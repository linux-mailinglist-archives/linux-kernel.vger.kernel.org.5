Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BB07D3AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjJWPgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJWPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8760BC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698075312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkwmARJHmNaXztbVnFtRTdIfVzfaFOrlU9U2aCeRghM=;
        b=f2AUMx6erauthObnKjyho0z7SIi+F9S9ptDAxuf58aDIOr2nnN91Zs/iFxn5AiBiDdru6F
        WMYjgbdtTDNLUPCUk6F7CBL+jygjSvgvJFbSEN7hVAjOl2fCVb8svxXaBaopjbmihK5hDW
        ENxhYcpbNxCYQFvr8zp9xJEzL8PtJes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-TWtHbjWEOmWJ8jWJXmyJyw-1; Mon, 23 Oct 2023 11:35:08 -0400
X-MC-Unique: TWtHbjWEOmWJ8jWJXmyJyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CD22811728;
        Mon, 23 Oct 2023 15:35:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1F71A25C0;
        Mon, 23 Oct 2023 15:35:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 23 Oct 2023 17:34:07 +0200 (CEST)
Date:   Mon, 23 Oct 2023 17:34:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] do_io_accounting: use sig->stats_lock
Message-ID: <20231023153405.GA4639@redhat.com>
References: <20231023153343.GA4629@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023153343.GA4629@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rather than lock_task_sighand(), sig->stats_lock was specifically
designed for this type of use.

This way the "if (whole)" branch runs lockless in the likely case.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/base.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0a39412332e2..ad4afa73b25b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2977,7 +2977,6 @@ static const struct file_operations proc_coredump_filter_operations = {
 static int do_io_accounting(struct task_struct *task, struct seq_file *m, int whole)
 {
 	struct task_io_accounting acct;
-	unsigned long flags;
 	int result;
 
 	result = down_read_killable(&task->signal->exec_update_lock);
@@ -2989,15 +2988,24 @@ static int do_io_accounting(struct task_struct *task, struct seq_file *m, int wh
 		goto out_unlock;
 	}
 
-	if (whole && lock_task_sighand(task, &flags)) {
+	if (whole) {
 		struct signal_struct *sig = task->signal;
 		struct task_struct *t;
+		unsigned int seq = 1;
+		unsigned long flags;
+
+		rcu_read_lock();
+		do {
+			seq++; /* 2 on the 1st/lockless path, otherwise odd */
+			flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
 
-		acct = sig->ioac;
-		__for_each_thread(sig, t)
-			task_io_accounting_add(&acct, &t->ioac);
+			acct = sig->ioac;
+			__for_each_thread(sig, t)
+				task_io_accounting_add(&acct, &t->ioac);
 
-		unlock_task_sighand(task, &flags);
+		} while (need_seqretry(&sig->stats_lock, seq));
+		done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+		rcu_read_unlock();
 	} else {
 		acct = task->ioac;
 	}
-- 
2.25.1.362.g51ebf55


