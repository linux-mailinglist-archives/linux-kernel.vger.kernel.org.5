Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392877BF5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442786AbjJJI1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442824AbjJJI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:27:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40FB107;
        Tue, 10 Oct 2023 01:27:07 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:27:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696926425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNbc6lLzsql6snug0HQa1mxk/kzC8m7f+xiIcj20Lyo=;
        b=jjk/Std83BJkeIWWgFLY87BoVtjAp+nGXoKw+esUF7jh9w0xLYWuD71Aovoqwz+3zCKBFd
        ae6xwOCeTLh5m9ROVQEPH97PMAqxfGbOEAcwV60UjqB35cDnBlq3hR9AAi94tn2kj7XHON
        vHbzJlTWRoBtVsqTUxZGFgdGSp1R77dzhRg9oOn71ArhVfXNEIv4MOA1k3dLYP8DAHDHK1
        e4MAuHCrKOr9TyxmFjDx1jiMtSxM0RHwvr5fLHZCT0ADIsf53U0RJMQWAdH5aF/VI8+ngA
        GoU1QT9Vm+3E6qd/mlzPwqEc2r+spydF3M0lmXalLK1Ca8TWBMF/Ovc2PmOUtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696926425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNbc6lLzsql6snug0HQa1mxk/kzC8m7f+xiIcj20Lyo=;
        b=o8q/0BKhL6U+WadtrCgQLm20NqhAKcrWI58CKcS0uoxHu08QrdEMyOYDygQR0IHgkP2n05
        VuuBOkVB1gQgvbCg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomics: Use atomic_try_cmpxchg_release()
 to micro-optimize rcuref_put_slowpath()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230509150255.3691-1-ubizjak@gmail.com>
References: <20230509150255.3691-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169692642491.3135.15300727916265365839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4fbf8b136ded943f8661cf48270482ad1f5ce7bd
Gitweb:        https://git.kernel.org/tip/4fbf8b136ded943f8661cf48270482ad1f5ce7bd
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 09 May 2023 17:02:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Oct 2023 10:14:27 +02:00

locking/atomics: Use atomic_try_cmpxchg_release() to micro-optimize rcuref_put_slowpath()

Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new) == old
in rcuref_put_slowpath(). On x86 the CMPXCHG instruction returns success in the
ZF flag, so this change saves a compare after CMPXCHG.  Additionaly,
the compiler reorders some code blocks to follow likely/unlikely
annotations in the atomic_try_cmpxchg() macro, improving the code from:

  9a:	f0 0f b1 0b          	lock cmpxchg %ecx,(%rbx)
  9e:	83 f8 ff             	cmp    $0xffffffff,%eax
  a1:	74 04                	je     a7 <rcuref_put_slowpath+0x27>
  a3:	31 c0                	xor    %eax,%eax

to:

  9a:	f0 0f b1 0b          	lock cmpxchg %ecx,(%rbx)
  9e:	75 4c                	jne    ec <rcuref_put_slowpath+0x6c>
  a0:	b0 01                	mov    $0x1,%al

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20230509150255.3691-1-ubizjak@gmail.com
---
 lib/rcuref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rcuref.c b/lib/rcuref.c
index 5ec00a4..97f300e 100644
--- a/lib/rcuref.c
+++ b/lib/rcuref.c
@@ -248,7 +248,7 @@ bool rcuref_put_slowpath(rcuref_t *ref)
 		 * require a retry. If this fails the caller is not
 		 * allowed to deconstruct the object.
 		 */
-		if (atomic_cmpxchg_release(&ref->refcnt, RCUREF_NOREF, RCUREF_DEAD) != RCUREF_NOREF)
+		if (!atomic_try_cmpxchg_release(&ref->refcnt, &cnt, RCUREF_DEAD))
 			return false;
 
 		/*
