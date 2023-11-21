Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2077A7F33A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjKUQ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKUQ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA6191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700584085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WwXihslT8h2SicYQaDhoz7hTx5u8MEtPcg6KyWcnIH4=;
        b=ijm4/7k2W8RbtEuRMqrvgjoSXJbiKjew5cnXQTE7TUq38XtF+fdZiBW+iqpe3kL7qq/BY0
        MVsQHMaMjrvCJACJTGG43SwbUdefga8oKaY1ppF++LwyMXVXDBxxHxvNJPr4zo+jy+uX2W
        Z9j3E7Y+U/EeAKiyrtA16f+7LC4opho=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-OWZ_0DI2PkOHMeWNncw39Q-1; Tue,
 21 Nov 2023 11:27:58 -0500
X-MC-Unique: OWZ_0DI2PkOHMeWNncw39Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 248493C14908;
        Tue, 21 Nov 2023 16:27:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1B05E1121319;
        Tue, 21 Nov 2023 16:27:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 21 Nov 2023 17:26:52 +0100 (CET)
Date:   Tue, 21 Nov 2023 17:26:50 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] __ptrace_unlink: kill the obsolete "FIXME" code
Message-ID: <20231121162650.GA6635@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The corner case described by the comment is no longer possible after the
commit 7b3c36fc4c23 ("ptrace: fix task_join_group_stop() for the case when
current is traced"), task_join_group_stop() ensures that the new thread has
the correct signr in JOBCTL_STOP_SIGMASK regardless of ptrace.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/ptrace.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 443057bee87c..d6fc63458c76 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -145,20 +145,9 @@ void __ptrace_unlink(struct task_struct *child)
 	 */
 	if (!(child->flags & PF_EXITING) &&
 	    (child->signal->flags & SIGNAL_STOP_STOPPED ||
-	     child->signal->group_stop_count)) {
+	     child->signal->group_stop_count))
 		child->jobctl |= JOBCTL_STOP_PENDING;
 
-		/*
-		 * This is only possible if this thread was cloned by the
-		 * traced task running in the stopped group, set the signal
-		 * for the future reports.
-		 * FIXME: we should change ptrace_init_task() to handle this
-		 * case.
-		 */
-		if (!(child->jobctl & JOBCTL_STOP_SIGMASK))
-			child->jobctl |= SIGSTOP;
-	}
-
 	/*
 	 * If transition to TASK_STOPPED is pending or in TASK_TRACED, kick
 	 * @child in the butt.  Note that @resume should be used iff @child
-- 
2.25.1.362.g51ebf55


