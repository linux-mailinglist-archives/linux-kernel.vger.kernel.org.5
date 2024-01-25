Return-Path: <linux-kernel+bounces-39386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71983CFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D8929574C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001851B59E;
	Thu, 25 Jan 2024 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOoyKeNg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648A1AAC4;
	Thu, 25 Jan 2024 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223366; cv=none; b=MA9CdAzD8VJCXpOctuO24qT4qCf3DxxckGgrv00MKhgYV5FGMfspUWL77swsaPYeKDMhtLMuBRRjA+Q4o9GxtcU4b4y2/beC+oboxH0W9B+uD7BNUtUkzfzFHjK9S6fNzQKuikssrtVBunrvRxgTOCT08mIyjd8fYZJkSUmigSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223366; c=relaxed/simple;
	bh=zFyRf340b4Mvmk4AZBMPn1ATdYHqCm1fuVo+aEb/I9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZcWzokF0G5H5yuwqSYdsusKPOeXZdcvfuysVQvMrfilNfVz/qm4QLjE2nfQjj6gQQPC65Rb9rrqv8vw4OoI8bLAxJctS+xkdwi77NYgiFpoJgR/hnsr1Z/FA/mJ86ugjg0VyTpp5t/5fDHeDuRXiQJCOoh+dM+wuYbMvPxVLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOoyKeNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A71C433A6;
	Thu, 25 Jan 2024 22:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223366;
	bh=zFyRf340b4Mvmk4AZBMPn1ATdYHqCm1fuVo+aEb/I9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cOoyKeNg3zlX8TFuDV6Cy9Rlb1Xg4NlOjPJ8PYg94zKsdTDXtoJB76fR7mlwAEUKe
	 WJLkP7H+S2oobOO4Sbv3ereOQEzMqetJFMR1mnSfE84a1rq2COJh4R3YquIOaeH8Z6
	 KcA49tVCLqodjXum0zzgUDiX2DehmBWo+V/xPBTBSWJmPXcCr75TcPYyTpSJkjsJQV
	 q9wNfi1TSzR9CHU71yb8XQGAvk2NVCF5kCrH6Jj7u6/uak2RAYxihyKmpQ8bwsGCgD
	 Z0XFpxf5Bm/sYfr+YyF6478lHnOsiHB4E2da6Q3XYAtpHsgCtLn2UWJ4/I1ev/LTBa
	 1eV3yaddOUB6A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:13 -0700
Subject: [PATCH 07/11] riscv: Remove MCOUNT_NAME workaround
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-7-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, paul.walmsley@sifive.com, 
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org, 
 linux-riscv@lists.infradead.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3407; i=nathan@kernel.org;
 h=from:subject:message-id; bh=zFyRf340b4Mvmk4AZBMPn1ATdYHqCm1fuVo+aEb/I9Y=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv3zPlsw8/ey1V+jI92ctNQZ4uvU5vzmlf4vw1+76
 cqUlXeDO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBE3CUYGbY02hvOi1ZSXXxN
 SNn5yds3Dxfc0JomVNVv6u4gPPGT5SFGhmsT5mdn5rK35Cw6qJxyRaiEIXnjtFDduebCQo6/vwr
 MZwMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that the minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1, the condition for using _mcount as
MCOUNT_NAME is always true, as the build will fail during the
configuration stage for older LLVM versions. Replace MCOUNT_NAME with
_mcount directly.

This effectively reverts commit 7ce047715030 ("riscv: Workaround mcount
name prior to clang-13").

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com
Cc: aou@eecs.berkeley.edu
Cc: conor@kernel.org
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/include/asm/ftrace.h | 14 ++------------
 arch/riscv/kernel/mcount.S      | 10 +++++-----
 scripts/recordmcount.pl         |  2 +-
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 06874fb1311e..cf5b63e789fa 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -13,19 +13,9 @@
 #endif
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
-/*
- * Clang prior to 13 had "mcount" instead of "_mcount":
- * https://github.com/llvm/llvm-project/commit/ef58ae86ba778ed7d01cd3f6bd6d08f943abab44
- */
-#if defined(CONFIG_CC_IS_GCC) || CONFIG_CLANG_VERSION >= 130000
-#define MCOUNT_NAME _mcount
-#else
-#define MCOUNT_NAME mcount
-#endif
-
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #ifndef __ASSEMBLY__
-void MCOUNT_NAME(void);
+void _mcount(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	return addr;
@@ -75,7 +65,7 @@ struct dyn_arch_ftrace {
  * both auipc and jalr at the same time.
  */
 
-#define MCOUNT_ADDR		((unsigned long)MCOUNT_NAME)
+#define MCOUNT_ADDR		((unsigned long)_mcount)
 #define JALR_SIGN_MASK		(0x00000800)
 #define JALR_OFFSET_MASK	(0x00000fff)
 #define AUIPC_OFFSET_MASK	(0xfffff000)
diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index d7ec69ac6910..3a42f6287909 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -50,8 +50,8 @@
 
 SYM_TYPED_FUNC_START(ftrace_stub)
 #ifdef CONFIG_DYNAMIC_FTRACE
-       .global MCOUNT_NAME
-       .set    MCOUNT_NAME, ftrace_stub
+       .global _mcount
+       .set    _mcount, ftrace_stub
 #endif
 	ret
 SYM_FUNC_END(ftrace_stub)
@@ -80,7 +80,7 @@ SYM_FUNC_END(return_to_handler)
 #endif
 
 #ifndef CONFIG_DYNAMIC_FTRACE
-SYM_FUNC_START(MCOUNT_NAME)
+SYM_FUNC_START(_mcount)
 	la	t4, ftrace_stub
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	la	t0, ftrace_graph_return
@@ -126,6 +126,6 @@ SYM_FUNC_START(MCOUNT_NAME)
 	jalr	t5
 	RESTORE_ABI_STATE
 	ret
-SYM_FUNC_END(MCOUNT_NAME)
+SYM_FUNC_END(_mcount)
 #endif
-EXPORT_SYMBOL(MCOUNT_NAME)
+EXPORT_SYMBOL(_mcount)
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index f84df9e383fd..0871b2e92584 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -352,7 +352,7 @@ if ($arch eq "x86_64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
 } elsif ($arch eq "riscv") {
     $function_regex = "^([0-9a-fA-F]+)\\s+<([^.0-9][0-9a-zA-Z_\\.]+)>:";
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\sR_RISCV_CALL(_PLT)?\\s_?mcount\$";
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\sR_RISCV_CALL(_PLT)?\\s_mcount\$";
     $type = ".quad";
     $alignment = 2;
 } elsif ($arch eq "csky") {

-- 
2.43.0


