Return-Path: <linux-kernel+bounces-28069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9042082F9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975B31C25C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCAB14A4DC;
	Tue, 16 Jan 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxmR2Tzm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2514A4D8;
	Tue, 16 Jan 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435033; cv=none; b=Oc/j26g6Ts5P8IJslfSQtrkwazLKuRh3jtxxjRylFSzeskfXhB3pw0zng3ASNMWThbdh2xf5hrNfQrW3hW3LUIK6VzjhsKQZQoEZvLJhajywdAnennSbeebQYxSYT4C2mu7mvmck36qk+YnHG7DplIDwyfrAB9udmIrHpzjgvlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435033; c=relaxed/simple;
	bh=7CEGRNOMwtdh3DIm4oTvfxawZHmpjrSc1E2kHZCYxZ4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=uFix20gTyO+74OUtCfoYF+d/DVncpZg2DRqug4Q9gOz648Kikpoomrsmd+INAFvXxMzWiTDC+krhPN4k3rdXKnzAyT+uoeYcTJhctZW4F8GpYihSWtHGHr3ZndyBH4ixXHA0dbFwKox5o/fUlDfY8SVGsGwWiiftmNZfMjEe+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxmR2Tzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93247C43390;
	Tue, 16 Jan 2024 19:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435032;
	bh=7CEGRNOMwtdh3DIm4oTvfxawZHmpjrSc1E2kHZCYxZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxmR2Tzmuut+9TOwM/6B+1nQ5m+2WfDkVvP9or8iwWXYf9pL1dZ5ek05Xhw+ookfd
	 vRJM1tDSHuNHGXqpDyULQyCiYfnPVJf9IdCi2P98QN1iYdNU9iN+UHulR8yoRwIzqP
	 wSBfg6fE35gmUFXKyGI2A35UI12U9D3Q2mTLUWdaOf0GBIEHJpLpBE3mqWxwpZNZvX
	 AITVFZSi9EjXkGkabJuDxJwBFWJIizCwEtigLVrCX2SxNz0KlDqcxbNEFGMkRrNCbx
	 xsVbM0WwME35ONbfpQfCfwK55G9hxxRXw3rrIj+wyE/frozAuwHDxpGW+0IU+UMbhY
	 tJO0BCoiIQurw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	samitolvanen@google.com,
	keescook@chromium.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 51/68] cfi: Add CFI_NOSEAL()
Date: Tue, 16 Jan 2024 14:53:50 -0500
Message-ID: <20240116195511.255854-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit e9d13b9d2f99ccf7afeab490d97eaa5ac9846598 ]

Add a CFI_NOSEAL() helper to mark functions that need to retain their
CFI information, despite not otherwise leaking their address.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231215092707.669401084@infradead.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/cfi.h | 5 +++++
 include/linux/cfi.h        | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 58dacd90daef..67b010c224e4 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -9,6 +9,7 @@
  */
 
 #include <linux/cfi.h>
+#include <asm/ibt.h>
 
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
@@ -19,4 +20,8 @@ static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 }
 #endif /* CONFIG_CFI_CLANG */
 
+#if HAS_KERNEL_IBT == 1
+#define CFI_NOSEAL(x)	asm(IBT_NOSEAL(__stringify(x)))
+#endif
+
 #endif /* _ASM_X86_CFI_H */
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 5e134f4ce8b7..f2f722c5aedd 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -36,4 +36,8 @@ static inline void module_cfi_finalize(const Elf_Ehdr *hdr,
 #endif /* CONFIG_ARCH_USES_CFI_TRAPS */
 #endif /* CONFIG_MODULES */
 
+#ifndef CFI_NOSEAL
+#define CFI_NOSEAL(x)
+#endif
+
 #endif /* _LINUX_CFI_H */
-- 
2.43.0


