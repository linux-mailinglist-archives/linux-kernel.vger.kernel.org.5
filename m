Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9132977FB27
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353326AbjHQPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353324AbjHQPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600B730D4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692287317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YkNjMltfBCPur9SkBC24c2W5OLAmVkJHJQKlj/IHZtg=;
        b=hDABF8ZhZ0cyk4D+j1oxSI3KmdSLLOPCj601hLdXkx2OFY9CJrjpY8fC0AUnDyXDmuuh4b
        6wCNkgYV0fUO2vOo3Lm+lqHlBmFckXmFWvNhfgGJE6tzP1hHOWZIEq6thiBajh7DsuQeyz
        FdSEjnoDkRcZlFkVVMZKGKhnmhmLAIQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-CWvoqjh-MMSR8JC9WejCVg-1; Thu, 17 Aug 2023 11:48:31 -0400
X-MC-Unique: CWvoqjh-MMSR8JC9WejCVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F4351C0726E;
        Thu, 17 Aug 2023 15:48:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91F872026D68;
        Thu, 17 Aug 2023 15:48:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Aug 2023 17:47:46 +0200 (CEST)
Date:   Thu, 17 Aug 2023 17:47:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Petr Skocik <pskocik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] __kill_pgrp_info: simplify the calculation of return value
Message-ID: <20230817154743.GA18674@redhat.com>
References: <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
 <87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>
 <20230814140652.GA30596@redhat.com>
 <20230814154351.GA4203@redhat.com>
 <3b14ae8091e3403bbc4ef1bee6dcf4f6@AcuMS.aculab.com>
 <20230815151149.GA29072@redhat.com>
 <87fs4ig23p.fsf@email.froward.int.ebiederm.org>
 <20230816210634.GA10130@redhat.com>
 <87r0o2cs8w.fsf@email.froward.int.ebiederm.org>
 <871qg28esu.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qg28esu.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, Eric W. Biederman wrote:
>
> > We should be consistent and ensure  __kill_pgrp_info uses
> > the same code pattern, otherwise it will be difficult to
> > see they use the same logic.

Hmm, agreed.

Then I think we should change __kill_pgrp_info() first, then "copy"
this pattern into kill_something_info() in a separate patch.

> > I think for both patterns the reader of the code is going to have to
> > stop and think about what is going on to understand the logic.

Yes, although to me the current code looks less clear but this is subjective.

But I agree this needs a comment. How about the patch below?


From 753d4edd1f2f21f9f9181b9ff7394ed098d58ff6 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 17 Aug 2023 17:38:55 +0200
Subject: [PATCH] __kill_pgrp_info: simplify the calculation of return value

No need to calculate/check the "success" variable, we can kill it and update
retval in the main loop unless it is zero.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 128e9bb3d1a2..c0acdfd4c81b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1460,16 +1460,21 @@ int group_send_sig_info(int sig, struct kernel_siginfo *info,
 int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
 {
 	struct task_struct *p = NULL;
-	int retval, success;
+	int ret = -ESRCH;
 
-	success = 0;
-	retval = -ESRCH;
 	do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
 		int err = group_send_sig_info(sig, info, p, PIDTYPE_PGID);
-		success |= !err;
-		retval = err;
+		/*
+		 * If group_send_sig_info() succeeds at least once ret
+		 * becomes 0 and after that the code below has no effect.
+		 * Otherwise we return the last err or -ESRCH if this
+		 * process group is empty.
+		 */
+		if (ret)
+			ret = err;
 	} while_each_pid_task(pgrp, PIDTYPE_PGID, p);
-	return success ? 0 : retval;
+
+	return ret;
 }
 
 int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
-- 
2.25.1.362.g51ebf55


