Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE07AA083
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjIUUja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjIUUjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:39:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615CB7C70D;
        Thu, 21 Sep 2023 10:36:36 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:36:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpbIu30gcGg96xLSgkfP4+EIIDAxGY+PaJcVDLY/4X0=;
        b=I9XPLO8Xb5CJfCKnckSQGjGhLbIcmUub8WI4rQQzU1ae+hPhK0o4+ruWkrqbHxrEQ/xLOY
        /EWkIWeBr15y25A3zNCwgGD5sQNtOog1EJjGTYIJgWuSR+thMT1fA/M1orpELCv9CB2NYE
        2Jhlf36gtqKLh1JHsxJUlVHSGs3fXfjRByJWeVn1CM4F8ZyTC0pRX1HD7D1z2McsxwWjFT
        7Ch9ZS71bcnOilts4kvGi/OrLb2/VCIKbWvi7ZAS4eeKKRnlg11w+z6Z9KxRiNk0Fb8Uh5
        wI8ZklbeG5GOZ+j/ekoHRuIzkbljdS1UuN59WfoqNU3cZLWNbMmIVQwA01IYBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpbIu30gcGg96xLSgkfP4+EIIDAxGY+PaJcVDLY/4X0=;
        b=Edz4+DGvOfFybpa++JbC9G1sq+JAKzHZ1GqkvMUerch9KffGRTYrOH442s1g2/AUUXgxm5
        Ur4GSKmgZyrickAQ==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Clarify FUTEX2 flags
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andrealmeid@igalia.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230921105247.507327749@noisy.programming.kicks-ass.net>
References: <20230921105247.507327749@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531776669.27769.7129503337742105554.tip-bot2@tip-bot2>
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

Commit-ID:     4923954bbc4a760e0b2210e0cb5733726ac2e2e9
Gitweb:        https://git.kernel.org/tip/4923954bbc4a760e0b2210e0cb5733726ac=
2e2e9
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:04 +02:00

futex: Clarify FUTEX2 flags

sys_futex_waitv() is part of the futex2 series (the first and only so
far) of syscalls and has a flags field per futex (as opposed to flags
being encoded in the futex op).

This new flags field has a new namespace, which unfortunately isn't
super explicit. Notably it currently takes FUTEX_32 and
FUTEX_PRIVATE_FLAG.

Introduce the FUTEX2 namespace to clarify this

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/r/20230921105247.507327749@noisy.programming.ki=
cks-ass.net
---
 include/uapi/linux/futex.h | 16 +++++++++++++---
 kernel/futex/syscalls.c    |  7 +++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 71a5df8..21d4eff 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -44,10 +44,20 @@
 					 FUTEX_PRIVATE_FLAG)
=20
 /*
- * Flags to specify the bit length of the futex word for futex2 syscalls.
- * Currently, only 32 is supported.
+ * Flags for futex2 syscalls.
  */
-#define FUTEX_32		2
+			/*	0x00 */
+			/*	0x01 */
+#define FUTEX2_SIZE_U32		0x02
+			/*	0x04 */
+			/*	0x08 */
+			/*	0x10 */
+			/*	0x20 */
+			/*	0x40 */
+#define FUTEX2_PRIVATE		FUTEX_PRIVATE_FLAG
+
+/* do not use */
+#define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
=20
 /*
  * Max numbers of elements in a futex_waitv array
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index a807407..ff696b0 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -183,8 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32,=
 val,
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
=20
-/* Mask of available flags for each futex in futex_waitv list */
-#define FUTEXV_WAITER_MASK (FUTEX_32 | FUTEX_PRIVATE_FLAG)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_U32 | FUTEX2_PRIVATE)
=20
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
@@ -205,10 +204,10 @@ static int futex_parse_waitv(struct futex_vector *futex=
v,
 		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
 			return -EFAULT;
=20
-		if ((aux.flags & ~FUTEXV_WAITER_MASK) || aux.__reserved)
+		if ((aux.flags & ~FUTEX2_VALID_MASK) || aux.__reserved)
 			return -EINVAL;
=20
-		if (!(aux.flags & FUTEX_32))
+		if (!(aux.flags & FUTEX2_SIZE_U32))
 			return -EINVAL;
=20
 		futexv[i].w.flags =3D aux.flags;
