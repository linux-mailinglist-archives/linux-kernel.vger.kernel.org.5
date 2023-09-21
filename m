Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735DD7AA06E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjIUUhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjIUUhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:37:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1E81FFD;
        Thu, 21 Sep 2023 10:36:34 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:36:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdlegKqSx1sFXYsl6OPUIPVsYZjue2Sou5wwaOjYFwE=;
        b=N6Ne6cKwyMO1FBjjffxoMh36OXm6HwtL+9ZZbTEj5vme1MTSni/wzqHsVtxk0e+On5iE3Y
        giAkdR93fYh9DDWjZiy/XIIfbhLPXobPq7cntEST+Vq1ZBJxUf3AId3L3pSmxdSIp4rDDU
        zvVnBXLZJ2KQ3eUpgke3fHhRWL82ND+FvkZk9EUChUhQYiC0/EZoW8+dX8IvUjWuyK6mXr
        lr5RUdWALBFZ+ySAx1E+Xj1L53cGSa60c1sRYdXLjSvn4TcspXgNzQn2EHDhsnwFLIN8bB
        VkDKkegayO6HmcZVA+CEWGlR6fvj8Xe34NyvnDqLIJ6+2i5ia3DkF5uOPkxlIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdlegKqSx1sFXYsl6OPUIPVsYZjue2Sou5wwaOjYFwE=;
        b=w/r0GLzYM8z+AgGBS/FJTA2A86kOH3teS/zTZ1WA4e27OORUGq5+LLGKS6v/UvILtIOgTy
        QrAd28T+KxMqrCBA==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Flag conversion
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andrealmeid@igalia.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230921105247.722140574@noisy.programming.kicks-ass.net>
References: <20230921105247.722140574@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531776573.27769.5454262358398654731.tip-bot2@tip-bot2>
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

Commit-ID:     5694289ce183bc3336407a78c8c722a0b9208f9b
Gitweb:        https://git.kernel.org/tip/5694289ce183bc3336407a78c8c722a0b92=
08f9b
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:05 +02:00

futex: Flag conversion

Futex has 3 sets of flags:

 - legacy futex op bits
 - futex2 flags
 - internal flags

Add a few helpers to convert from the API flags into the internal
flags.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/r/20230921105247.722140574@noisy.programming.ki=
cks-ass.net
---
 kernel/futex/futex.h    | 63 ++++++++++++++++++++++++++++++++++++++--
 kernel/futex/syscalls.c | 24 +++++----------
 kernel/futex/waitwake.c |  4 +--
 3 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index b5379c0..68fc052 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -5,6 +5,7 @@
 #include <linux/futex.h>
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
+#include <linux/compat.h>
=20
 #ifdef CONFIG_PREEMPT_RT
 #include <linux/rcuwait.h>
@@ -16,8 +17,15 @@
  * Futex flags used to encode options to functions and preserve them across
  * restarts.
  */
+#define FLAGS_SIZE_8		0x00
+#define FLAGS_SIZE_16		0x01
+#define FLAGS_SIZE_32		0x02
+#define FLAGS_SIZE_64		0x03
+
+#define FLAGS_SIZE_MASK		0x03
+
 #ifdef CONFIG_MMU
-# define FLAGS_SHARED		0x01
+# define FLAGS_SHARED		0x10
 #else
 /*
  * NOMMU does not have per process address space. Let the compiler optimize
@@ -25,8 +33,57 @@
  */
 # define FLAGS_SHARED		0x00
 #endif
-#define FLAGS_CLOCKRT		0x02
-#define FLAGS_HAS_TIMEOUT	0x04
+#define FLAGS_CLOCKRT		0x20
+#define FLAGS_HAS_TIMEOUT	0x40
+#define FLAGS_NUMA		0x80
+
+/* FUTEX_ to FLAGS_ */
+static inline unsigned int futex_to_flags(unsigned int op)
+{
+	unsigned int flags =3D FLAGS_SIZE_32;
+
+	if (!(op & FUTEX_PRIVATE_FLAG))
+		flags |=3D FLAGS_SHARED;
+
+	if (op & FUTEX_CLOCK_REALTIME)
+		flags |=3D FLAGS_CLOCKRT;
+
+	return flags;
+}
+
+/* FUTEX2_ to FLAGS_ */
+static inline unsigned int futex2_to_flags(unsigned int flags2)
+{
+	unsigned int flags =3D flags2 & FUTEX2_SIZE_MASK;
+
+	if (!(flags2 & FUTEX2_PRIVATE))
+		flags |=3D FLAGS_SHARED;
+
+	if (flags2 & FUTEX2_NUMA)
+		flags |=3D FLAGS_NUMA;
+
+	return flags;
+}
+
+static inline unsigned int futex_size(unsigned int flags)
+{
+	return 1 << (flags & FLAGS_SIZE_MASK);
+}
+
+static inline bool futex_flags_valid(unsigned int flags)
+{
+	/* Only 64bit futexes for 64bit code */
+	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
+		if ((flags & FLAGS_SIZE_MASK) =3D=3D FLAGS_SIZE_64)
+			return false;
+	}
+
+	/* Only 32bit futexes are implemented -- for now */
+	if ((flags & FLAGS_SIZE_MASK) !=3D FLAGS_SIZE_32)
+		return false;
+
+	return true;
+}
=20
 #ifdef CONFIG_FAIL_FUTEX
 extern bool should_fail_futex(bool fshared);
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 953f0a4..948ac24 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-#include <linux/compat.h>
 #include <linux/syscalls.h>
 #include <linux/time_namespace.h>
=20
@@ -85,15 +84,12 @@ err_unlock:
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {
+	unsigned int flags =3D futex_to_flags(op);
 	int cmd =3D op & FUTEX_CMD_MASK;
-	unsigned int flags =3D 0;
=20
-	if (!(op & FUTEX_PRIVATE_FLAG))
-		flags |=3D FLAGS_SHARED;
-
-	if (op & FUTEX_CLOCK_REALTIME) {
-		flags |=3D FLAGS_CLOCKRT;
-		if (cmd !=3D FUTEX_WAIT_BITSET && cmd !=3D FUTEX_WAIT_REQUEUE_PI &&
+	if (flags & FLAGS_CLOCKRT) {
+		if (cmd !=3D FUTEX_WAIT_BITSET &&
+		    cmd !=3D FUTEX_WAIT_REQUEUE_PI &&
 		    cmd !=3D FUTEX_LOCK_PI2)
 			return -ENOSYS;
 	}
@@ -201,21 +197,19 @@ static int futex_parse_waitv(struct futex_vector *futex=
v,
 	unsigned int i;
=20
 	for (i =3D 0; i < nr_futexes; i++) {
+		unsigned int flags;
+
 		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
 			return -EFAULT;
=20
 		if ((aux.flags & ~FUTEX2_VALID_MASK) || aux.__reserved)
 			return -EINVAL;
=20
-		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
-			if ((aux.flags & FUTEX2_SIZE_MASK) =3D=3D FUTEX2_SIZE_U64)
-				return -EINVAL;
-		}
-
-		if ((aux.flags & FUTEX2_SIZE_MASK) !=3D FUTEX2_SIZE_U32)
+		flags =3D futex2_to_flags(aux.flags);
+		if (!futex_flags_valid(flags))
 			return -EINVAL;
=20
-		futexv[i].w.flags =3D aux.flags;
+		futexv[i].w.flags =3D flags;
 		futexv[i].w.val =3D aux.val;
 		futexv[i].w.uaddr =3D aux.uaddr;
 		futexv[i].q =3D futex_q_init;
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index ba01b94..fa97577 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -419,11 +419,11 @@ static int futex_wait_multiple_setup(struct futex_vecto=
r *vs, int count, int *wo
 	 */
 retry:
 	for (i =3D 0; i < count; i++) {
-		if ((vs[i].w.flags & FUTEX_PRIVATE_FLAG) && retry)
+		if (!(vs[i].w.flags & FLAGS_SHARED) && retry)
 			continue;
=20
 		ret =3D get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
-				    !(vs[i].w.flags & FUTEX_PRIVATE_FLAG),
+				    vs[i].w.flags & FLAGS_SHARED,
 				    &vs[i].q.key, FUTEX_READ);
=20
 		if (unlikely(ret))
