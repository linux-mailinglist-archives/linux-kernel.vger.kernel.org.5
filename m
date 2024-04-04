Return-Path: <linux-kernel+bounces-131805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CFB898BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6CCB29413
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBE212AAD4;
	Thu,  4 Apr 2024 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek9DxjTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C571734;
	Thu,  4 Apr 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247470; cv=none; b=ZZmnzSoquNuda4GHjkQBQk0W85MkCJ7DwOHnNSZ0NKVoF0zFOY0bWYPDr+g1IB5uqYB6OG91YV2K5rC1ItWmsIIbTFlQzafZkrxSno+uSXY/TQXUyCVdMTCIm9RxoP4MyALv2pXBeQR7uJxYOFi4cMGNi6lRhJFJwXNuImRH2Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247470; c=relaxed/simple;
	bh=FjV1aylvw54HgcRcPH+ncOEHfWZSF7cjGG7LKooAAck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RiDynAt93eHmn8oFWbMhptpUCdfzC+1iWNCEfcVpWFePLmOHQhF0jqesLlsAXKk0+IOouz45NChSgchgyi9mIA8L3tISuuBHyH27jvyCl4vJlGTn8SFMS5urauLxnnB1J7rpYfUqMsb/etSAoqfwAPmnf234TxEfgBPs8KqZXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek9DxjTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA52C433C7;
	Thu,  4 Apr 2024 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712247470;
	bh=FjV1aylvw54HgcRcPH+ncOEHfWZSF7cjGG7LKooAAck=;
	h=From:To:Cc:Subject:Date:From;
	b=Ek9DxjTf0nDgfbJgJnq24Rxo708J00NDrJ0cdUdpq1W/hQkojUagi9MxbQy1vhtc2
	 Lsz39WEGcfqELDgW6r7oWq1DymrE/Se6YNlMI836imP9j+I2qjqQSpLjJsZqNf7p74
	 nH5unccsPIE+X3xCpPmcCHirS+OFroe7d5QDFQ5vhxx0KcZy2PvDiJD50Zyg3bRqbn
	 7ycGyjxmLKFcI50LSSJB/PEMhG1XRPhu4CSONabzjmgHmwnN0HybX7720GXyzwPP8A
	 Mbn40Ul0xF2Es1VJ5/UMszIPd6PXfC5xA+suYIeSvAliKIrGyul/NPnWyloGJfCz+I
	 3mgBYRUXq6zLA==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bill Metzenthen <billm@melbpc.org.au>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] x86: math-emu: fix function cast warnings
Date: Thu,  4 Apr 2024 18:17:24 +0200
Message-Id: <20240404161742.3580041-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 warns about casting function pointers with incompatible
prototypes. The x86 math-emu code does this in a number of places
to call some trivial functions that need no arguments:

arch/x86/math-emu/fpu_etc.c:124:14: error: cast from 'void (*)(void)' to 'FUNC_ST0' (aka 'void (*)(struct fpu__reg *, unsigned char)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  124 |         fchs, fabs, (FUNC_ST0) FPU_illegal, (FUNC_ST0) FPU_illegal,
      |                     ^~~~~~~~~~~~~~~~~~~~~~
arch/x86/math-emu/fpu_trig.c:1634:19: error: cast from 'void (*)(void)' to 'FUNC_ST0' (aka 'void (*)(struct fpu__reg *, unsigned char)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1634 |         fxtract, fprem1, (FUNC_ST0) fdecstp, (FUNC_ST0) fincstp
      |                          ^~~~~~~~~~~~~~~~~~
arch/x86/math-emu/reg_constant.c:112:53: error: cast from 'void (*)(void)' to 'FUNC_RC' (aka 'void (*)(int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  112 |         fld1, fldl2t, fldl2e, fldpi, fldlg2, fldln2, fldz, (FUNC_RC) FPU_illegal

Change the fdecstp() and fincstp() functions to actually have the correct
prototypes based on the caller, and add wrappers around FPU_illegal()
for adapting those.

Link: https://lore.kernel.org/lkml/20240213095631.454543-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Resending the version from Feb 13, no changes
---
 arch/x86/math-emu/fpu_etc.c      | 9 +++++++--
 arch/x86/math-emu/fpu_trig.c     | 6 +++---
 arch/x86/math-emu/reg_constant.c | 7 ++++++-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/math-emu/fpu_etc.c b/arch/x86/math-emu/fpu_etc.c
index 1b118fd93140..39423ec409e1 100644
--- a/arch/x86/math-emu/fpu_etc.c
+++ b/arch/x86/math-emu/fpu_etc.c
@@ -120,9 +120,14 @@ static void fxam(FPU_REG *st0_ptr, u_char st0tag)
 	setcc(c);
 }
 
+static void FPU_ST0_illegal(FPU_REG *st0_ptr, u_char st0_tag)
+{
+	FPU_illegal();
+}
+
 static FUNC_ST0 const fp_etc_table[] = {
-	fchs, fabs, (FUNC_ST0) FPU_illegal, (FUNC_ST0) FPU_illegal,
-	ftst_, fxam, (FUNC_ST0) FPU_illegal, (FUNC_ST0) FPU_illegal
+	fchs, fabs, FPU_ST0_illegal, FPU_ST0_illegal,
+	ftst_, fxam, FPU_ST0_illegal, FPU_ST0_illegal,
 };
 
 void FPU_etc(void)
diff --git a/arch/x86/math-emu/fpu_trig.c b/arch/x86/math-emu/fpu_trig.c
index 990d847ae902..85daf98c81c3 100644
--- a/arch/x86/math-emu/fpu_trig.c
+++ b/arch/x86/math-emu/fpu_trig.c
@@ -433,13 +433,13 @@ static void fxtract(FPU_REG *st0_ptr, u_char st0_tag)
 #endif /* PARANOID */
 }
 
-static void fdecstp(void)
+static void fdecstp(FPU_REG *st0_ptr, u_char st0_tag)
 {
 	clear_C1();
 	top--;
 }
 
-static void fincstp(void)
+static void fincstp(FPU_REG *st0_ptr, u_char st0_tag)
 {
 	clear_C1();
 	top++;
@@ -1631,7 +1631,7 @@ static void fscale(FPU_REG *st0_ptr, u_char st0_tag)
 
 static FUNC_ST0 const trig_table_a[] = {
 	f2xm1, fyl2x, fptan, fpatan,
-	fxtract, fprem1, (FUNC_ST0) fdecstp, (FUNC_ST0) fincstp
+	fxtract, fprem1, fdecstp, fincstp,
 };
 
 void FPU_triga(void)
diff --git a/arch/x86/math-emu/reg_constant.c b/arch/x86/math-emu/reg_constant.c
index 742619e94bdf..003a0b2753e6 100644
--- a/arch/x86/math-emu/reg_constant.c
+++ b/arch/x86/math-emu/reg_constant.c
@@ -108,8 +108,13 @@ static void fldz(int rc)
 
 typedef void (*FUNC_RC) (int);
 
+static void FPU_RC_illegal(int unused)
+{
+	FPU_illegal();
+}
+
 static FUNC_RC constants_table[] = {
-	fld1, fldl2t, fldl2e, fldpi, fldlg2, fldln2, fldz, (FUNC_RC) FPU_illegal
+	fld1, fldl2t, fldl2e, fldpi, fldlg2, fldln2, fldz, FPU_RC_illegal
 };
 
 void fconst(void)
-- 
2.39.2


