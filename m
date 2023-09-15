Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457027A223B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjIOPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjIOPWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:22:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764CE50;
        Fri, 15 Sep 2023 08:22:13 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:22:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694791331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zXvk3r4eLfALSMQsQXt7D31XO209Sjvfg9W6OVxL00Y=;
        b=TKOctj+wZW5aTodcgygciapIBZh6z8M9ECyEP/toI6je8uMfhZPXDEdvBmZ7u5MaCBOZNL
        8kANfr+t5If1wl7e/HZZENrYRSBA9+4tivIzs8FvzvAPL0Ejt9hvbiK8H0f3dtYBqkhykL
        KLYO1T5jTWrWQZeMfG2bESIqnU9hWZ82RxOkSMTkGZXwfjqPajntGwFsWegoINE2gKelin
        XLbEg5Y+sGmeQcrxw9NDb4cu4L9E2kXv4fHpRcfcB7Aj3FQFP8qTnn495s4U1q8EFE26oS
        3yu6oK4BThawd6oIcY1LxIJoXmDt1Q0uvbXwPaUiaDpCazGbRGQk+IdbwN0q2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694791331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zXvk3r4eLfALSMQsQXt7D31XO209Sjvfg9W6OVxL00Y=;
        b=MvbgZo/17ICWpSQAxkv/ZBbScLpfwRbgpQtoA/uQCvzt9y8ShPEZtF0pblM0so5uU54UYk
        Ue/gkCHA9vWjDPDA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Use do-while instead of for loop in
 set_nr_if_polling()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230228161426.4508-1-ubizjak@gmail.com>
References: <20230228161426.4508-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169479133040.27769.13340324338034270661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4ff34ad3d39377d9f6953f3606ccf611ce636767
Gitweb:        https://git.kernel.org/tip/4ff34ad3d39377d9f6953f3606ccf611ce636767
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 28 Feb 2023 17:14:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 17:18:02 +02:00

sched/core: Use do-while instead of for loop in set_nr_if_polling()

Use equivalent do-while loop instead of infinite for loop.

There are no asm code changes.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230228161426.4508-1-ubizjak@gmail.com
---
 kernel/sched/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 76662d8..f39482d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -919,14 +919,13 @@ static bool set_nr_if_polling(struct task_struct *p)
 	struct thread_info *ti = task_thread_info(p);
 	typeof(ti->flags) val = READ_ONCE(ti->flags);
 
-	for (;;) {
+	do {
 		if (!(val & _TIF_POLLING_NRFLAG))
 			return false;
 		if (val & _TIF_NEED_RESCHED)
 			return true;
-		if (try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED))
-			break;
-	}
+	} while (!try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED));
+
 	return true;
 }
 
