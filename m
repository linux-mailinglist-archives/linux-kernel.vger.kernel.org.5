Return-Path: <linux-kernel+bounces-119230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B68088C5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC965305C36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AB313C809;
	Tue, 26 Mar 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWTSU+g5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9913C8E6;
	Tue, 26 Mar 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464805; cv=none; b=jIUbuPoaVNcEAEfdIbqazevUpyRFJgdxqOwh40eCmMe/F3SuQergCmLsz/ZXazkvS0YNXrC6Mu2uoKxtdNEXYYjW8Rn8I7Hek1iSTSPimpJfpQ9iyj/W7QuIsnsedOLkjdwpjymtU15RaYYhzqgrECyYq2SFBoXHYmH7pnsZj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464805; c=relaxed/simple;
	bh=FjV1aylvw54HgcRcPH+ncOEHfWZSF7cjGG7LKooAAck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+5F2nmpA/5sq7WnNzKQyUx0pn75w3lP4bYuZxUI12hoMkN6z4r1r2POV+R4A83f+pwGh1eDOK9cYwTcWiVGSoPQ0iymUL3zuS6Pk8T+xFKFt7wlhV+RqbKvCyOyoh6culgagrBKY0nWlcFRJghXhytq361K2V3D7S6VwYcaa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWTSU+g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D02BC43390;
	Tue, 26 Mar 2024 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464805;
	bh=FjV1aylvw54HgcRcPH+ncOEHfWZSF7cjGG7LKooAAck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWTSU+g5YT6X2/viOT6OSnsvQCMADUzH/G6N8TqRwDyL254fJ/riQrZHmhuCc2A+X
	 5o3HSqemY/camVxz1u9JrAWlkv3zwRBsaJeLlKw91UAC8jSwMUFh6O7mcKlaAU17Sg
	 0lUpJSnbWUnpzHwON08HffRzzuwD0pwOmTvoLqMvPLEoyExsicoc1LE1iJHUKA5n5x
	 2w+coKhaiq8CZRyQrZi5waTMSSC3MeGZuyExcMhQ5dfIqWNrYMFZ8SURu1C4TonES2
	 EpakXZD2yfAefCBpvLJu+AdTtoFmbewvwyRHisxe27AiA36hlufQn0uTi1/lxSNqXS
	 Gs4X7JRpb3vpQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bill Metzenthen <billm@melbpc.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 08/12] x86: math-emu: fix function cast warnings
Date: Tue, 26 Mar 2024 15:51:33 +0100
Message-Id: <20240326145140.3257163-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326144741.3094687-1-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
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


