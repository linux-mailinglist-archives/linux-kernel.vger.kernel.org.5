Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2555F7EB8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjKNV44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNV4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:56:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B367D3;
        Tue, 14 Nov 2023 13:56:50 -0800 (PST)
Date:   Tue, 14 Nov 2023 21:56:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699999007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vInrZ1jYOgBJhGzvcL4J/hkNuIxeYyfms/Z6oqeyhq0=;
        b=i27GDA64/eBNcBzluVesMvqmC0WT30/jPwHu7GLvKTfQerNr5F84dipvaCZhYFOqkriheS
        dsjHOXzcmeyw2ZqsCrNNJq7D3xkQQ5yKXYwJVs2lxilI19nuyigv2cDD47mVb3TYCcuxHK
        GnmvUQQ8oQAqWsVJn8YZZd9UVcRqk8xapQfFgIaoSSqd4i9V/+epw8gZLiQPo2fZVbwqf3
        1ypHEAsWl+fcpDPt9Iynhp6WaMDFekbqpy6/ev/W6EGBGVHwfe45bLMQnf8yfodnR4iVOE
        PisjK95PdoDEFhD4zJZkO+HIqQ13X8+qrMCnV8gJmhGLGoUsZTXDz/Ip9dOGZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699999007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vInrZ1jYOgBJhGzvcL4J/hkNuIxeYyfms/Z6oqeyhq0=;
        b=gIrSZFKsLRz2OWqUo1CVdVssIuBiNJu6VMcbF1mjNXebNM/QTPUquSu1WzTwgso4vbQ5r6
        4rSshQRT1r04yZCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Fix hardcoded flags
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Florian Weimer <fweimer@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231114201402.GA25315@noisy.programming.kicks-ass.net>
References: <20231114201402.GA25315@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169999900615.391.871692364626596753.tip-bot2@tip-bot2>
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

Commit-ID:     59f3daffefbf48206dbf310af5472d6d7d7161df
Gitweb:        https://git.kernel.org/tip/59f3daffefbf48206dbf310af5472d6d7d7161df
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 14 Nov 2023 21:36:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Nov 2023 22:26:41 +01:00

futex: Fix hardcoded flags

Xi reported that commit 5694289ce183 ("futex: Flag conversion") broke
glibc's robust futex tests.

This was narrowed down to the change of FLAGS_SHARED from 0x01 to
0x10, at which point Florian noted that handle_futex_death() has a
hardcoded flags argument of 1.

Change this to: FLAGS_SIZE_32 | FLAGS_SHARED, matching how
futex_to_flags() unconditionally sets FLAGS_SIZE_32 for all legacy
futex ops.

Fixes: 5694289ce183 ("futex: Flag conversion")
Reported-by: Xi Ruoyao <xry111@xry111.site>
Reported-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231114201402.GA25315@noisy.programming.kicks-ass.net
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
