Return-Path: <linux-kernel+bounces-129168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B21B896663
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2BF1C21633
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD565B1E2;
	Wed,  3 Apr 2024 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNfnwlCR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADB5A0F3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129233; cv=none; b=QWY37icSakya0qKeSneifr9B1Way0OUiSAzPSF0l6LtawYSLH4ML+if0m99mJ2uIlPZCwDeSCOE0EbUnjFQv9u+F0t/665kpnfEqKuReJQeD8wsOG6YH4Ry3WgyrLJswM7iTZvsAE6tumjIlkLA37sCFjv1MFXW7lpv0I5qJOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129233; c=relaxed/simple;
	bh=+VzjS3lYs6MmEFgAWLAK/tBPyrT/NYGIq1NsetZK0N4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F29lBKSdG+yf2cZr95ZHBBfVxSHhuEYIso4HENW9KTii0vIJje4iAk/wyG+ba8/6C5mx6UuxNIFh80hRkGlgon7e6qyKJmoU/97FMhOUg2DOsqxZBzdbocb6V7a5TblSpKbcoJxaAhFpqZRviqbXZ3fZWWSfexbqecBSOqmnxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNfnwlCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506BAC4166C;
	Wed,  3 Apr 2024 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712129233;
	bh=+VzjS3lYs6MmEFgAWLAK/tBPyrT/NYGIq1NsetZK0N4=;
	h=From:To:Cc:Subject:Date:From;
	b=vNfnwlCRbrrs+6oRiuY5HnZ1jnEcpXLfT282PXD+b5CWl/fw1eWCrbdibGIarc/N6
	 I9ZYikj4gLFF7GdgIpYozxHKpugugvRROjc6lX9liupSFYD+6sUcteJRJPRylPOBld
	 j897gZXMVtm8PL5BptbZZV9YHO8zziyhfjmqv+IUGzps6Oetq3dRalD3QexSmRLGik
	 tzKzUF3FlI3pWmLUapkwV4G084eIboYExqbOCraW0uPIdl9tWsrVU+BADUop4HUS/j
	 4+4QDriYAo9nkL9zEOtS05U9eYGngEQ6j1fzQQ0bN41R2R/j6j0jTS81luAO2Gwfu/
	 NLhh2CxQTBL2Q==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Vincent Chen <vincent.chen@sifive.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Greentime Hu <greentime.hu@sifive.com>,
	Haorong Lu <ancientmodern4@gmail.com>,
	Jerry Shih <jerry.shih@sifive.com>,
	Nick Knight <nick.knight@sifive.com>,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vineetg@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH] riscv: Fix vector state restore in rt_sigreturn()
Date: Wed,  3 Apr 2024 09:26:38 +0200
Message-Id: <20240403072638.567446-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V Vector specification states in "Appendix D: Calling
Convention for Vector State" [1] that "Executing a system call causes
all caller-saved vector registers (v0-v31, vl, vtype) and vstart to
become unspecified.". In the RISC-V kernel this is called "discarding
the vstate".

Returning from a signal handler via the rt_sigreturn() syscall, vector
discard is also performed. However, this is not an issue since the
vector state should be restored from the sigcontext, and therefore not
care about the vector discard.

The "live state" is the actual vector register in the running context,
and the "vstate" is the vector state of the task. A dirty live state,
means that the vstate and live state are not in synch.

When vectorized user_from_copy() was introduced, an bug sneaked in at
the restoration code, related to the discard of the live state.

An example when this go wrong:

  1. A userland application is executing vector code
  2. The application receives a signal, and the signal handler is
     entered.
  3. The application returns from the signal handler, using the
     rt_sigreturn() syscall.
  4. The live vector state is discarded upon entering the
     rt_sigreturn(), and the live state is marked as "dirty", indicating
     that the live state need to be synchronized with the current
     vstate.
  5. rt_sigreturn() restores the vstate, except the Vector registers,
     from the sigcontext
  6. rt_sigreturn() restores the Vector registers, from the sigcontext,
     and now the vectorized user_from_copy() is used. The dirty live
     state from the discard is saved to the vstate, making the vstate
     corrupt.
  7. rt_sigreturn() returns to the application, which crashes due to
     corrupted vstate.

Note that the vectorized user_from_copy() is invoked depending on the
value of CONFIG_RISCV_ISA_V_UCOPY_THRESHOLD. Default is 768, which
means that vlen has to be larger than 128b for this bug to trigger.

The fix is simply to mark the live state as non-dirty/clean prior
performing the vstate restore.

Link: https://github.com/riscv/riscv-isa-manual/releases/download/riscv-isa-release-8abdb41-2024-03-26/unpriv-isa-asciidoc.pdf # [1]
Reported-by: Charlie Jenkins <charlie@rivosinc.com>
Reported-by: Vineet Gupta <vgupta@kernel.org>
Fixes: c2a658d41924 ("riscv: lib: vectorize copy_to_user/copy_from_user")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/signal.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 501e66debf69..5a2edd7f027e 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -119,6 +119,13 @@ static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
 	struct __sc_riscv_v_state __user *state = sc_vec;
 	void __user *datap;
 
+	/*
+	 * Mark the vstate as clean prior performing the actual copy,
+	 * to avoid getting the vstate incorrectly clobbered by the
+	 *  discarded vector state.
+	 */
+	riscv_v_vstate_set_restore(current, regs);
+
 	/* Copy everything of __sc_riscv_v_state except datap. */
 	err = __copy_from_user(&current->thread.vstate, &state->v_state,
 			       offsetof(struct __riscv_v_ext_state, datap));
@@ -133,13 +140,7 @@ static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
 	 * Copy the whole vector content from user space datap. Use
 	 * copy_from_user to prevent information leak.
 	 */
-	err = copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
-	if (unlikely(err))
-		return err;
-
-	riscv_v_vstate_set_restore(current, regs);
-
-	return err;
+	return copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
 }
 #else
 #define save_v_state(task, regs) (0)

base-commit: 7115ff4a8bfed3b9294bad2e111744e6abeadf1a
-- 
2.40.1


