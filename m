Return-Path: <linux-kernel+bounces-27853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84AA82F6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56667284693
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5505B1EA;
	Tue, 16 Jan 2024 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u//JNVyV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5B5A118;
	Tue, 16 Jan 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434373; cv=none; b=QXzoW7UGDP2rPT6cWiawZbEgbjIwZlNJhiVfUB7fnluQVD/JJ4TSy9ZYQeR/zgAdkiqtGGZBaGYBiSCGcCtpyFXE1iGsy49YqdmP479IG1+dVA+8385J4WPhu8yiaHXLqyafrFENBjZaddTpZqwn4iFztrYoY/i0FHdfJMKpZgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434373; c=relaxed/simple;
	bh=nFwiyKpVMtwCLdn+g9bVyJk7PIg5t850sOdqgjHgcpk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=fcPmlHNJXLPK3mDJq6uPkyXbRAmzTwJvcT5OjwkcBW3cCNpdwb/k08Ozn0vUbCNXW8VCqqIkx9AXTzfid9YDakTREo4pZS8Lu07Ki/piyQrVc1o9ncFrhPsAyNJtoDxea1y6Ktbe0MpKjD6XI3v20fcBomR9gcuDV2yUrPVv89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u//JNVyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B33C433C7;
	Tue, 16 Jan 2024 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434373;
	bh=nFwiyKpVMtwCLdn+g9bVyJk7PIg5t850sOdqgjHgcpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u//JNVyVwgj5hgUcHWp03IYqXe4ngyO7elVkJOhdPICUSwwiGi/0opFqe72Yeq+++
	 jL4A36NUyfBi66hMv8vz2m01EJ+xaZT7bqC8hlGilBcB+S7R5BOMmQnqpLd9E0pc/K
	 4wni+Ep4d3buWH+9Hy/vMQ9eoUtuRmQqt6fhm3jkcmHHjzWZG7+WZLhCvZvlMSSD4X
	 D/lIjxLDg8tjhuhffSO0u54W0r1VFmsGlu9Bv2HJXK3/zrWL3q+XSah3CDxnUvZFid
	 6AGZ7QGXIjvhoV9kLu9dpmuYI9kYWVr84O3ZYpk8iPiZ9VEOQXz3TdwVCMTCCMmguf
	 J2WOJ68FreQ/Q==
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
Subject: [PATCH AUTOSEL 6.7 082/108] cfi: Add CFI_NOSEAL()
Date: Tue, 16 Jan 2024 14:39:48 -0500
Message-ID: <20240116194225.250921-82-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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


