Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAFB7EBB92
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjKODIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjKODIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:08:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0EA183;
        Tue, 14 Nov 2023 19:07:49 -0800 (PST)
Date:   Wed, 15 Nov 2023 03:07:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700017666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFLN1xMKoqdzRw2wzV2uNrNhBJ7V/n9kgwDlpjXIqLk=;
        b=Ca0uGTDMmjpfcC1TCfqlkpI9HGIsscHOkAMA/vRmncglxdPmaYQporVbZPeUNGd4PA8Ei9
        Q3e4w1zBmjnR9pommhRAP1+SRDAIoJ1tZVpA1c4BpiJYwzMoIFhugKIf59jl+61pRrBDu8
        BQQ9qYobeqUBUbRpipC8NsyBMm+rGqWJl4sO95SqYZM6dIK6/VRu3KI4AGMVxdNtFZOm9C
        jXRUo6fVPQDo8snY7AKwJgewgrXEa0uRGtaFaBjw5WFRqrPJCSM+jrUimeNdn9anFuKcUD
        c0lOAEZzmuosCKd7im/1xpO/d5NXF4neJk3m/VhJHVAXDBz9mOEv8Aw7KAajAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700017666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFLN1xMKoqdzRw2wzV2uNrNhBJ7V/n9kgwDlpjXIqLk=;
        b=X2rtJXQAigHHtmbkEqxVigAA18G9/ZsjVHH3DFHh3D+in6ZCvAJ/YypuSaMq0DmB4nRMRG
        Fb8OntQRFraulSBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Fix hardcoded flags
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Florian Weimer <fweimer@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <stable@vger.kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231114201402.GA25315@noisy.programming.kicks-ass.net>
References: <20231114201402.GA25315@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <170001766579.391.5243762310659751499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     c9bd1568d5462f4108417518ce1af7b924acfb6f
Gitweb:        https://git.kernel.org/tip/c9bd1568d5462f4108417518ce1af7b924acfb6f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 14 Nov 2023 21:36:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 15 Nov 2023 04:02:25 +01:00

futex: Fix hardcoded flags

Xi reported that commit 5694289ce183 ("futex: Flag conversion") broke
glibc's robust futex tests.

This was narrowed down to the change of FLAGS_SHARED from 0x01 to
0x10, at which point Florian noted that handle_futex_death() has a
hardcoded flags argument of 1.

Change this to: FLAGS_SIZE_32 | FLAGS_SHARED, matching how
futex_to_flags() unconditionally sets FLAGS_SIZE_32 for all legacy
futex ops.

Reported-by: Xi Ruoyao <xry111@xry111.site>
Reported-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20231114201402.GA25315@noisy.programming.kicks-ass.net
Fixes: 5694289ce183 ("futex: Flag conversion")
Cc: <stable@vger.kernel.org>
---
 kernel/futex/core.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 52695c5..dad981a 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -700,7 +700,8 @@ retry:
 	owner = uval & FUTEX_TID_MASK;
 
 	if (pending_op && !pi && !owner) {
-		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
+		futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, 1,
+			   FUTEX_BITSET_MATCH_ANY);
 		return 0;
 	}
 
@@ -752,8 +753,10 @@ retry:
 	 * Wake robust non-PI futexes here. The wakeup of
 	 * PI futexes happens in exit_pi_state():
 	 */
-	if (!pi && (uval & FUTEX_WAITERS))
-		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
+	if (!pi && (uval & FUTEX_WAITERS)) {
+		futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, 1,
+			   FUTEX_BITSET_MATCH_ANY);
+	}
 
 	return 0;
 }
