Return-Path: <linux-kernel+bounces-133571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D459189A5D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD61F22593
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C25174EF1;
	Fri,  5 Apr 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akS4L/ax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FB1C6A8;
	Fri,  5 Apr 2024 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350166; cv=none; b=clUZKzkjY8oNywDEs5FxSrXo8uIehUxueYkY9Z8H8FGCY4N5mn2MNNYUVRNV8S8wvdbUtXV34vyDVuw7g/rPGO89HPf6BD3I59U6ptJHRbex4UeM7IHQURMOPKdJoDNWmxB2TTC+G4aeQAKRwakJPnQguF7zufcY2dfZth5yf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350166; c=relaxed/simple;
	bh=Uj0xHs/QTrbiYnPbS02sV+ugvX08VA6WObmU7km1zXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=meJoBK2FepwL9CnI2UnT5plagnT7uE6daxBiNJIOMICih0miMfb8g1ilG5R2lT0tjlq32vtWe9wyGorVEciZ5qBVfusr8gumi9vFWfwBCUuv/t202CqRa2W/79M3TEmzMnboufd+8ftABKBBkTc8CBVI2c8ziruC7DBteu/Q4r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akS4L/ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CA2C433C7;
	Fri,  5 Apr 2024 20:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712350165;
	bh=Uj0xHs/QTrbiYnPbS02sV+ugvX08VA6WObmU7km1zXc=;
	h=From:To:Cc:Subject:Date:From;
	b=akS4L/axZhyEypj9uBgZX0ctrH5px85d87/hs5PD3DCE4fnvGTlsvagiyE7jqU2qd
	 d7M82DW6EZ4lfKJh4g3diKiRwxdIHBRK5yKC8DdXcxOPDIRbtbs/Lz53lG74JBoKPj
	 fRw9TOUjdccQD688WoLeFTYrHVwC9yHDip1n7tkfWscWBEjd86BlEB4oBu52v0es+o
	 Ui0j0VgAxE44tIn1Y2CvU2HxEp9F4MLvt0Qx3XIR21JUVWOUxM71zs9ko5Hf+SMqiu
	 c414Hn2VodLEmdLhGG5kt/f27ANT/8Ntjn5zhgDlPAxwzCAhuFqBkcK+9+fuP8sIf5
	 s9NwMMylHbrfA==
From: Arnd Bergmann <arnd@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] x86: microcode: avoid -Wformat warning with clang-15
Date: Fri,  5 Apr 2024 22:49:07 +0200
Message-Id: <20240405204919.1003409-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Older versions of clang show a warning for amd.c after a fix for a gcc
warning:

arch/x86/kernel/cpu/microcode/amd.c:478:47: error: format specifies type 'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Werror,-Wformat]
                         "amd-ucode/microcode_amd_fam%02hhxh.bin", family);
                                                     ~~~~~~        ^~~~~~
                                                     %02hx

In clang-16 and higher, this warning is disabled by default, but clang-15 is
still supported, and it's trivial to avoid by adapting the types according
to the range of the passed data and the format string.

Fixes: 2e9064faccd1 ("x86/microcode/amd: Fix snprintf() format string warning in W=1 build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 13b45b9c806d..620f0af713ca 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -465,7 +465,7 @@ static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, siz
 	return !__apply_microcode_amd(mc);
 }
 
-static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
+static bool get_builtin_microcode(struct cpio_data *cp, u8 family)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct firmware fw;
-- 
2.39.2


