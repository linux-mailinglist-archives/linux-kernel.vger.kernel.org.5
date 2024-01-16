Return-Path: <linux-kernel+bounces-27993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8D982F8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFAC7B27404
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EED45BACE;
	Tue, 16 Jan 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhGz9CZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D55BAC4;
	Tue, 16 Jan 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434797; cv=none; b=HJVYKhn+T46wzVFyTQminmYl5BCLIe6Bux9ELhMuLO8txwcYTgtM/+BMGpkNvIHSN5Px19++TvVx99T7BxDJncubw2Ktk8VCbrrz7P7gKwWKWrOCb5jOk7HX3ibJmlx5plYhfSp5KXFDlkJPAh8bCva64T9Meytpbwd4xu4g6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434797; c=relaxed/simple;
	bh=nFwiyKpVMtwCLdn+g9bVyJk7PIg5t850sOdqgjHgcpk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=a7k6J17HRBBnILLyQm+iBsWBoo/Cdep1AhXRMyuZOanJh799PpANAi7THcY67IHo2b80Yg+jMYhWdhsac0Fl8JNV135kdfU3Z+nNVx/aLzmgHy/QW/9b9TUN2x5SRtQo8PXfLV08BZMH7lhuMoqKTMhUAA+2deBh+261Qnaofb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhGz9CZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EBFC433F1;
	Tue, 16 Jan 2024 19:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434797;
	bh=nFwiyKpVMtwCLdn+g9bVyJk7PIg5t850sOdqgjHgcpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhGz9CZUI8vuwQKuSKujt/33CseBqZsdtp6vxmgFzN1nGnq680+23w87UNWQiAKdw
	 hf7Lton/IrFGzWuhKfEBKNnp5Fah+MKSqHMZNmZilRDTCkjoKJ2nfL7VAqWNOaYYK3
	 +C/xcAEW5s7qVJvv4wTLIsTYD68ZA3bs76W1wHsB3ujyNhjBqAYNo/UgKOJNUnk7IJ
	 FM/hr2ylciohlJ7qY51flXvCpIAM9kI11aIT6momK+QGdZDKxYLbnhQZfgI6rCPuoK
	 3NYkfw3s9yYH6xLC9ZEeMnDe+3m1RcXOBnQ79nG6Z9mO6r084DvixRIc53rOPmRRT6
	 IIVJxg0WW/5sg==
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
Subject: [PATCH AUTOSEL 6.6 081/104] cfi: Add CFI_NOSEAL()
Date: Tue, 16 Jan 2024 14:46:47 -0500
Message-ID: <20240116194908.253437-81-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 3552ec82b725..bb084eb053e7 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -38,4 +38,8 @@ static inline void module_cfi_finalize(const Elf_Ehdr *hdr,
 #endif /* CONFIG_ARCH_USES_CFI_TRAPS */
 #endif /* CONFIG_MODULES */
 
+#ifndef CFI_NOSEAL
+#define CFI_NOSEAL(x)
+#endif
+
 #endif /* _LINUX_CFI_H */
-- 
2.43.0


