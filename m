Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696FB799A11
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjIIQqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjIIQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED471D9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694277958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nKmw2x4tdBZKAzfdlAoPOvGHiII0xbZcN6BItATXzMM=;
        b=M6WzaOBuHtLxBli9qnhuHwKj8uxv0VJO/o6mD0QOrkUY8vqrJKnOkh/bVP517QN/MmRaZq
        V4AW60+wBVo+pQhMYHZE/WEKi21XfIMSxCHMz5mYlvz5qxe3qsXyTo7+26n/hI12lfjlvr
        +VKiS79a/Pkbf0m24LibQ3M3QD0WOFg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-TSV_lBlDPTC_1Huzv3sXAQ-1; Sat, 09 Sep 2023 12:45:54 -0400
X-MC-Unique: TSV_lBlDPTC_1Huzv3sXAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6405129AA3B2;
        Sat,  9 Sep 2023 16:45:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 62D0F412F2CD;
        Sat,  9 Sep 2023 16:45:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat,  9 Sep 2023 18:45:02 +0200 (CEST)
Date:   Sat, 9 Sep 2023 18:45:01 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/proc: do_task_stat: use __for_each_thread()
Message-ID: <20230909164501.GA11581@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do/while_each_thread should be avoided when possible.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/array.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2c2efbe685d8..ff08a8957552 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -536,12 +536,13 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 		/* add up live thread stats at the group level */
 		if (whole) {
-			struct task_struct *t = task;
-			do {
+			struct task_struct *t;
+
+			__for_each_thread(sig, t) {
 				min_flt += t->min_flt;
 				maj_flt += t->maj_flt;
 				gtime += task_gtime(t);
-			} while_each_thread(task, t);
+			}
 
 			min_flt += sig->min_flt;
 			maj_flt += sig->maj_flt;
-- 
2.25.1.362.g51ebf55


