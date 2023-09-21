Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F187AA0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjIUUrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjIUUrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:47:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9837E4F3;
        Thu, 21 Sep 2023 10:36:05 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:36:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZ+AWsu/It5qMoqLvWyHRu3tp7dd43Yf5izBLfEk20A=;
        b=j6sJNM6oqKgpQj6qMLdn+nqzbYwE4fu6QpYJICqWKxzEnnxo7gGo2CtKzvosUzm/Rj1QmK
        f3pLQqm3IwN1J3uJIcEtBuNN2CPpZPBlOB7/exIabkUVBd4QeyW2uq1LxpVmKCNSll00Jd
        m912p66grCOfKJGD0Bn2jpymw+DJpymJK/jpfzJ6FikbGNoJmWkh/Po1mzXGLJJ42Od/mT
        qU8YOaiQ7gc5BiCmVZE1EI2PZuObyh6GZh5sMMSC/Glz8+gRergWwQHbE7g7c1mT30MWjO
        bLKOyFKcg1hDHZIDMjWC+RM4qsNbC9OKKZt5b1OgFdl0rLrFw0aefP37OvdfSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZ+AWsu/It5qMoqLvWyHRu3tp7dd43Yf5izBLfEk20A=;
        b=CAddA7LF3Yscb8zsb/+4tQ37vZoAFf+VyGH0/hI3WoddMS120kKSdkuK/KIxQtcBl3NRUU
        WwQ2HuwsD6USA0Cg==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: FLAGS_STRICT
Cc:     andrealmeid@igalia.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230921105248.048643656@noisy.programming.kicks-ass.net>
References: <20230921105248.048643656@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531776286.27769.7382358930466919741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     43adf844951084c266f172561f84c5f8120dd60b
Gitweb:        https://git.kernel.org/tip/43adf844951084c266f172561f84c5f8120=
dd60b
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:07 +02:00

futex: FLAGS_STRICT

The current semantics for futex_wake() are a bit loose, specifically
asking for 0 futexes to be woken actually gets you 1.

Adding a !nr check to sys_futex_wake() makes that it would return 0
for unaligned futex words, because that check comes in the shared
futex_wake() function. Adding the !nr check there, would affect the
legacy sys_futex() semantics.

Hence frob a flag :-(

Suggested-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230921105248.048643656@noisy.programming.ki=
cks-ass.net
---
 kernel/futex/futex.h    | 21 +++++++++++----------
 kernel/futex/syscalls.c |  2 +-
 kernel/futex/waitwake.c |  3 +++
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index a3f1fce..0e7821a 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -17,25 +17,26 @@
  * Futex flags used to encode options to functions and preserve them across
  * restarts.
  */
-#define FLAGS_SIZE_8		0x00
-#define FLAGS_SIZE_16		0x01
-#define FLAGS_SIZE_32		0x02
-#define FLAGS_SIZE_64		0x03
+#define FLAGS_SIZE_8		0x0000
+#define FLAGS_SIZE_16		0x0001
+#define FLAGS_SIZE_32		0x0002
+#define FLAGS_SIZE_64		0x0003
=20
-#define FLAGS_SIZE_MASK		0x03
+#define FLAGS_SIZE_MASK		0x0003
=20
 #ifdef CONFIG_MMU
-# define FLAGS_SHARED		0x10
+# define FLAGS_SHARED		0x0010
 #else
 /*
  * NOMMU does not have per process address space. Let the compiler optimize
  * code away.
  */
-# define FLAGS_SHARED		0x00
+# define FLAGS_SHARED		0x0000
 #endif
-#define FLAGS_CLOCKRT		0x20
-#define FLAGS_HAS_TIMEOUT	0x40
-#define FLAGS_NUMA		0x80
+#define FLAGS_CLOCKRT		0x0020
+#define FLAGS_HAS_TIMEOUT	0x0040
+#define FLAGS_NUMA		0x0080
+#define FLAGS_STRICT		0x0100
=20
 /* FUTEX_ to FLAGS_ */
 static inline unsigned int futex_to_flags(unsigned int op)
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 7049a52..4739892 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -333,7 +333,7 @@ SYSCALL_DEFINE4(futex_wake,
 	if (!futex_validate_input(flags, mask))
 		return -EINVAL;
=20
-	return futex_wake(uaddr, flags, nr, mask);
+	return futex_wake(uaddr, FLAGS_STRICT | flags, nr, mask);
 }
=20
 #ifdef CONFIG_COMPAT
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index fa97577..ceb05b8 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -155,6 +155,9 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int=
 nr_wake, u32 bitset)
 	if (unlikely(ret !=3D 0))
 		return ret;
=20
+	if ((flags & FLAGS_STRICT) && !nr_wake)
+		return 0;
+
 	hb =3D futex_hash(&key);
=20
 	/* Make sure we really have tasks to wakeup */
