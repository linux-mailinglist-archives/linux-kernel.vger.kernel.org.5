Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E397AA0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjIUUrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjIUUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:47:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D441381FFF;
        Thu, 21 Sep 2023 10:36:34 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:36:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0XoGbkGrsY9M6VIGn5Woc8BmhyjnaFTf3yO8yqiAIE=;
        b=wOAtrnWd+R4t5aeicoFBajsnsFHm5Z7QMJwzru54qLoG9ZXN4AhafxTuy0VkV6hJv4t9ef
        T7qCHxQX/HK6aP3Z5w1jrYEF2oq8coSaa0IoiwbM7mgwtdsQSfLHTZ3vf5Yv3zC1A9PU5I
        sYnJtOdM9ueLUCnQCWQnZWnfCIuFs6dYSMRJS+W9WklPaKj630uwD9ZvKThzTOdfuKidcQ
        ZxHbL6WfuZHvZNcouwoPeQ7hR5YJfJCgc/3+EPtb1oRR1+8BXuJL7w+jy0RS3sWWfJ+s6x
        t1b36INQ1y+WOuPa0GyWMnMozDQB6ZJEczJt13ulWzBwCm9adz+UMeQghrJ6UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0XoGbkGrsY9M6VIGn5Woc8BmhyjnaFTf3yO8yqiAIE=;
        b=P5QojkC5fuE535hqBbwK/cDMTLlvbXjxLS+29iyV/Cfw+hgtj0qLJSG26rQYORBRMVYCIQ
        1OuKi0XuMJtwGQDw==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Extend the FUTEX2 flags
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andrealmeid@igalia.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230921105247.617057368@noisy.programming.kicks-ass.net>
References: <20230921105247.617057368@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531776622.27769.3661853983494438744.tip-bot2@tip-bot2>
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

Commit-ID:     d6d08d24790e82c69a46ef78ae44fe1b1ed30775
Gitweb:        https://git.kernel.org/tip/d6d08d24790e82c69a46ef78ae44fe1b1ed=
30775
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:05 +02:00

futex: Extend the FUTEX2 flags

Add the definition for the missing but always intended extra sizes,
and add a NUMA flag for the planned numa extention.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/r/20230921105247.617057368@noisy.programming.ki=
cks-ass.net
---
 include/uapi/linux/futex.h | 21 ++++++++++++++++++---
 kernel/futex/syscalls.c    |  9 +++++++--
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 21d4eff..d2ee625 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -45,17 +45,32 @@
=20
 /*
  * Flags for futex2 syscalls.
+ *
+ * NOTE: these are not pure flags, they can also be seen as:
+ *
+ *   union {
+ *     u32  flags;
+ *     struct {
+ *       u32 size    : 2,
+ *           numa    : 1,
+ *                   : 4,
+ *           private : 1;
+ *     };
+ *   };
  */
-			/*	0x00 */
-			/*	0x01 */
+#define FUTEX2_SIZE_U8		0x00
+#define FUTEX2_SIZE_U16		0x01
 #define FUTEX2_SIZE_U32		0x02
-			/*	0x04 */
+#define FUTEX2_SIZE_U64		0x03
+#define FUTEX2_NUMA		0x04
 			/*	0x08 */
 			/*	0x10 */
 			/*	0x20 */
 			/*	0x40 */
 #define FUTEX2_PRIVATE		FUTEX_PRIVATE_FLAG
=20
+#define FUTEX2_SIZE_MASK	0x03
+
 /* do not use */
 #define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
=20
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index ff696b0..953f0a4 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -183,7 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32,=
 val,
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
=20
-#define FUTEX2_VALID_MASK (FUTEX2_SIZE_U32 | FUTEX2_PRIVATE)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
=20
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
@@ -207,7 +207,12 @@ static int futex_parse_waitv(struct futex_vector *futexv,
 		if ((aux.flags & ~FUTEX2_VALID_MASK) || aux.__reserved)
 			return -EINVAL;
=20
-		if (!(aux.flags & FUTEX2_SIZE_U32))
+		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
+			if ((aux.flags & FUTEX2_SIZE_MASK) =3D=3D FUTEX2_SIZE_U64)
+				return -EINVAL;
+		}
+
+		if ((aux.flags & FUTEX2_SIZE_MASK) !=3D FUTEX2_SIZE_U32)
 			return -EINVAL;
=20
 		futexv[i].w.flags =3D aux.flags;
