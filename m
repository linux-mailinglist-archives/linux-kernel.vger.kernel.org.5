Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EC17D3AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjJWPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjJWPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F805DB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698075302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gHSlX1YDGV5G2LskBeGoFUFpyleE33b46ppJ65LrH24=;
        b=QTRZQ3b0/rTvwH9uECP6/LldKqm5bdgd/kqASoEdpUILChf20rkG27ms/Y1dLY49tcAT53
        cwE82KKhNF3VZ+sYtvU8kZ/fHjV7BWHlsCR/Eo2aLtuHvvM++Qc29crPQ6K9mPgBUgJemb
        TkAmKR0t9347+ux/uAZFFGLxFHL/0vQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-Ym4rw9vjNDiVwo4EWSsx4Q-1; Mon, 23 Oct 2023 11:34:46 -0400
X-MC-Unique: Ym4rw9vjNDiVwo4EWSsx4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B55BE185A79C;
        Mon, 23 Oct 2023 15:34:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE44A40C6F79;
        Mon, 23 Oct 2023 15:34:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 23 Oct 2023 17:33:44 +0200 (CEST)
Date:   Mon, 23 Oct 2023 17:33:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] do_io_accounting: use __for_each_thread()
Message-ID: <20231023153343.GA4629@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rather than while_each_thread() which should be avoided when possible.

This makes the code more clear and allows the next change.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/base.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c0e971cc6d41..0a39412332e2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2976,7 +2976,7 @@ static const struct file_operations proc_coredump_filter_operations = {
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 static int do_io_accounting(struct task_struct *task, struct seq_file *m, int whole)
 {
-	struct task_io_accounting acct = task->ioac;
+	struct task_io_accounting acct;
 	unsigned long flags;
 	int result;
 
@@ -2990,14 +2990,18 @@ static int do_io_accounting(struct task_struct *task, struct seq_file *m, int wh
 	}
 
 	if (whole && lock_task_sighand(task, &flags)) {
-		struct task_struct *t = task;
+		struct signal_struct *sig = task->signal;
+		struct task_struct *t;
 
-		task_io_accounting_add(&acct, &task->signal->ioac);
-		while_each_thread(task, t)
+		acct = sig->ioac;
+		__for_each_thread(sig, t)
 			task_io_accounting_add(&acct, &t->ioac);
 
 		unlock_task_sighand(task, &flags);
+	} else {
+		acct = task->ioac;
 	}
+
 	seq_printf(m,
 		   "rchar: %llu\n"
 		   "wchar: %llu\n"
-- 
2.25.1.362.g51ebf55


