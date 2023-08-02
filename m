Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B076DA9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjHBWU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjHBWTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:19:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60325272D;
        Wed,  2 Aug 2023 15:19:34 -0700 (PDT)
Date:   Wed, 02 Aug 2023 22:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691014772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IstEpb6mzOZLU9hL9T/45QOiURs2kmDy8oax4r7RTL0=;
        b=uTUYZJJZ1Aocok0W2Qli8xsKXuoqK7OZJkq2U03aMzgaf9ZhZQICZL+0ZjgEj1MvUha590
        AjqymAefyZzXVzM0on5xEq6wdu9wHq6E3+X9hwHIb4FSIgZhMsBEWyGcv13OBws6XAhoKx
        bzwgLx8RWZeG7j8W0wYS5SzUmyHZv6JO+bUDAU/BAeKv00Bp/fyPjK3zvUIwL9W8MzgNOi
        TbrktCrvZfWzuaXyFwbang3sAplh3YmggUXwX00XWQtcPd8ixx0cLhfHo7Ro+Hbaj5cF20
        uRiLCYLMtEG9yZogQBKv50So+G+ybOUcF/gJbCO4tgnGFr6UcL7cl2Ogb3S5Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691014772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IstEpb6mzOZLU9hL9T/45QOiURs2kmDy8oax4r7RTL0=;
        b=07KvcmKweG5u2W3uqHdQKiK1P2fm82gRdofbdMZG7w7dqNX9oxn5Sb8gxPdkCZh3VEPw/J
        KM2eNunR1tZhIECg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Check that signal frame is shadow stack mem
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169101477165.28540.13769364032686646171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     7fad2a432cd35bbf104d2d9d426e74902f22aa95
Gitweb:        https://git.kernel.org/tip/7fad2a432cd35bbf104d2d9d426e74902f2=
2aa95
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:59 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 02 Aug 2023 15:01:50 -07:00

x86/shstk: Check that signal frame is shadow stack mem

The shadow stack signal frame is read by the kernel on sigreturn. It
relies on shadow stack memory protections to prevent forgeries of this
signal frame (which included the pre-signal SSP). This behavior helps
userspace protect itself. However, using the INCSSP instruction userspace
can adjust the SSP to 8 bytes beyond the end of a shadow stack. INCSSP
performs shadow stack reads to make sure it doesn=E2=80=99t increment off of =
the
shadow stack, but on the end position it actually reads 8 bytes below the
new SSP.

For the shadow stack HW operations, this situation (INCSSP off the end
of a shadow stack by 8 bytes) would be fine. If the a RET is executed, the
push to the shadow stack would fail to write to the shadow stack. If a
CALL is executed, the SSP will be incremented back onto the stack and the
return address will be written successfully to the very end. That is
expected behavior around shadow stack underflow.

However, the kernel doesn=E2=80=99t have a way to read shadow stack memory us=
ing
shadow stack accesses. WRUSS can write to shadow stack memory with a
shadow stack access which ensures the access is to shadow stack memory.
But unfortunately for this case, there is no equivalent instruction for
shadow stack reads. So when reading the shadow stack signal frames, the
kernel currently assumes the SSP is pointing to the shadow stack and uses
a normal read.

The SSP pointing to shadow stack memory will be true in most cases, but as
described above, in can be untrue by 8 bytes. So lookup the VMA of the
shadow stack sigframe being read to verify it is shadow stack.

Since the SSP can only be beyond the shadow stack by 8 bytes, and
shadow stack memory is page aligned, this check only needs to be done
when this type of relative position to a page boundary is encountered.
So skip the extra work otherwise.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230613001108.3040476-34-rick.p.edgecombe%=
40intel.com
---
 arch/x86/kernel/shstk.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index a8705f7..50733a5 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -249,15 +249,38 @@ static int shstk_push_sigframe(unsigned long *ssp)
=20
 static int shstk_pop_sigframe(unsigned long *ssp)
 {
+	struct vm_area_struct *vma;
 	unsigned long token_addr;
-	int err;
+	bool need_to_check_vma;
+	int err =3D 1;
=20
+	/*
+	 * It is possible for the SSP to be off the end of a shadow stack by 4
+	 * or 8 bytes. If the shadow stack is at the start of a page or 4 bytes
+	 * before it, it might be this case, so check that the address being
+	 * read is actually shadow stack.
+	 */
 	if (!IS_ALIGNED(*ssp, 8))
 		return -EINVAL;
=20
+	need_to_check_vma =3D PAGE_ALIGN(*ssp) =3D=3D *ssp;
+
+	if (need_to_check_vma)
+		mmap_read_lock_killable(current->mm);
+
 	err =3D get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
 	if (unlikely(err))
-		return err;
+		goto out_err;
+
+	if (need_to_check_vma) {
+		vma =3D find_vma(current->mm, *ssp);
+		if (!vma || !(vma->vm_flags & VM_SHADOW_STACK)) {
+			err =3D -EFAULT;
+			goto out_err;
+		}
+
+		mmap_read_unlock(current->mm);
+	}
=20
 	/* Restore SSP aligned? */
 	if (unlikely(!IS_ALIGNED(token_addr, 8)))
@@ -270,6 +293,10 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	*ssp =3D token_addr;
=20
 	return 0;
+out_err:
+	if (need_to_check_vma)
+		mmap_read_unlock(current->mm);
+	return err;
 }
=20
 int setup_signal_shadow_stack(struct ksignal *ksig)
