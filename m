Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E58B799A12
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjIIQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjIIQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B59C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694277993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OdCJqsKNdERpBnYU8M+NFHEJroll7Jtw77XwuC55ZyI=;
        b=U+DuKMgT0kCn5YjDI1flrK3XjMNIMM4bYvijXNcqiiCXs9ub1AuHRi2VlA19Bijw7e+woZ
        nGqRM+p1peqE5oS00hfCo9yf0dwrypXbyepRhXul6wzBie+Ik9rbPSpozJVcNkvnTJodfy
        H/bPweUACgxN8n2jPic//oFFFdg5/Cg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-ImDeTm9sOpabTVlGNMKkkw-1; Sat, 09 Sep 2023 12:46:30 -0400
X-MC-Unique: ImDeTm9sOpabTVlGNMKkkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F90B380673F;
        Sat,  9 Sep 2023 16:46:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 644542015CE0;
        Sat,  9 Sep 2023 16:46:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat,  9 Sep 2023 18:45:38 +0200 (CEST)
Date:   Sat, 9 Sep 2023 18:45:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] signal: complete_signal: use __for_each_thread()
Message-ID: <20230909164537.GA11633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do/while_each_thread should be avoided when possible.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index fc276fc07d87..ccfc3ded5672 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1058,12 +1058,11 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			signal->flags = SIGNAL_GROUP_EXIT;
 			signal->group_exit_code = sig;
 			signal->group_stop_count = 0;
-			t = p;
-			do {
+			__for_each_thread(signal, t) {
 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 				sigaddset(&t->pending.signal, SIGKILL);
 				signal_wake_up(t, 1);
-			} while_each_thread(p, t);
+			}
 			return;
 		}
 	}
-- 
2.25.1.362.g51ebf55


