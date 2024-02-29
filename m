Return-Path: <linux-kernel+bounces-86981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C0086CDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B467928509A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387717A151;
	Thu, 29 Feb 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkOEhK7E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D897A144;
	Thu, 29 Feb 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221799; cv=none; b=Btwc0Mlhy1axJbkjiwgn83tO9me2UfTSXAoqSuMBsaxEuulvml1sjl2ssNT8zu7YA0tgpn5kLRHaKqSw8nccbVQ9u7dhxhiHdp+QOvObhwtZPpMeL5cngrrGoVl1LvcSQ4Os+NR2oU0XWDCpAF9GrhtJmU4RfMkqmV72mdjXuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221799; c=relaxed/simple;
	bh=KcTNPiFwNY84hKxY/REFym2TAOMI7OjhJJXCHAPfAWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFJ06XyOwtMJgSwzaJSzkbQMt6sgs9HCe/jkdTg1IxzU0meHomw8BUeu76NFstIIt4KmaEi3KN1x1SBqOdot5qGqD4M58NeTJuNadRdMcK3XEVY4tpKtVt8vbeD/pLefzAbUC6Z/gaXMiBPKVt/UpU2HUz6Z92/bT/xkeN7qvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkOEhK7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519E0C433B1;
	Thu, 29 Feb 2024 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221799;
	bh=KcTNPiFwNY84hKxY/REFym2TAOMI7OjhJJXCHAPfAWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkOEhK7ELb9lyjGf5gwUs1g0TQ6u2qNy1O3ApbGea9JmIrhHsgi3nG6vqIetvMhLH
	 VLhtRMY5Tp/hZr9K7efacbd27sFudyLxylUk5aXx2iCQPwHIpic0eoCDFxdCc3tL+c
	 zo/qhJhP62P+cBmkXniUF0/9HuANcIoXzjQvtQx2pdYE+R1ZyHBRpO9Up5sHzHcGgv
	 o63O6RCwVzgVWCGldeAv4KmCRCmc2F6y9fPgRFlzzh8Z6V2w2u/Nar1BKUnqiDLfbT
	 1RHh/r/83ynJ+UxMBzELNoIofOX2qJMkPLknbDfW0YeyNcLjOjI76ppVi/xCmmzRJo
	 9RsxqVJcs8HiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fangrui Song <maskray@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	catalin.marinas@arm.com,
	nathan@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 06/21] arm64: jump_label: use constraints "Si" instead of "i"
Date: Thu, 29 Feb 2024 10:49:26 -0500
Message-ID: <20240229154946.2850012-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Fangrui Song <maskray@google.com>

[ Upstream commit f9daab0ad01cf9d165dbbbf106ca4e61d06e7fe8 ]

The generic constraint "i" seems to be copied from x86 or arm (and with
a redundant generic operand modifier "c"). It works with -fno-PIE but
not with -fPIE/-fPIC in GCC's aarch64 port.

The machine constraint "S", which denotes a symbol or label reference
with a constant offset, supports PIC and has been available in GCC since
2012 and in Clang since 7.0. However, Clang before 19 does not support
"S" on a symbol with a constant offset [1] (e.g.
`static_key_false(&nf_hooks_needed[pf][hook])` in
include/linux/netfilter.h), so we use "i" as a fallback.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Fangrui Song <maskray@google.com>
Link: https://github.com/llvm/llvm-project/pull/80255 [1]
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20240206074552.541154-1-maskray@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/jump_label.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 48ddc0f45d228..b7716b215f91a 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -15,6 +15,10 @@
 
 #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
 
+/*
+ * Prefer the constraint "S" to support PIC with GCC. Clang before 19 does not
+ * support "S" on a symbol with a constant offset, so we use "i" as a fallback.
+ */
 static __always_inline bool arch_static_branch(struct static_key * const key,
 					       const bool branch)
 {
@@ -23,9 +27,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
 		 "	.pushsection	__jump_table, \"aw\"	\n\t"
 		 "	.align		3			\n\t"
 		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
+		 "	.quad		(%[key] - .) + %[bit0]  \n\t"
 		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		 :  :  [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);
 
 	return false;
 l_yes:
@@ -40,9 +44,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 		 "	.pushsection	__jump_table, \"aw\"	\n\t"
 		 "	.align		3			\n\t"
 		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
+		 "	.quad		(%[key] - .) + %[bit0]  \n\t"
 		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		 :  :  [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);
 
 	return false;
 l_yes:
-- 
2.43.0


