Return-Path: <linux-kernel+bounces-113410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2E88841A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A42B224D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D0C1A6990;
	Sun, 24 Mar 2024 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcLhzsZD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5241A62FA;
	Sun, 24 Mar 2024 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320212; cv=none; b=PoeHHw0nuucYVoq2oYHsBB0evwbdsXkFRAJiopUG0c6TSc0boPttZNoQm1e605kJ61JAYxXq7WGm/Ajl4XzlnqbEAb+fT8a9TbGCwLY72DYbNsFNjNoiLKwtrUtxoldujw24Syzmx/R+B7kzHn5MLbY4v8d5casU4lXCTpjtAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320212; c=relaxed/simple;
	bh=4FUPlWa79cawkkNKxG7WUAwRAA85F1SBpHi+Rf23veo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2jlxa7YtzY/39kqvr4jlNmRX9kUCYeDaZ8wV0r1LMpcFDROlIkbSmb8SHSPzfixjFAwhowpJDeozrZBnPhbksLsehbfuNJju1vgBDbea9k2Dbgf6XfeohpmpYy4UFRbh1qYURXkqATb/3vCnro50aJqI0oXQmJ5d1QAvRDdUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcLhzsZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72154C43601;
	Sun, 24 Mar 2024 22:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320212;
	bh=4FUPlWa79cawkkNKxG7WUAwRAA85F1SBpHi+Rf23veo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcLhzsZDOeK9Rp2MAlxJKWKOa4bfRReWrHl5sggmMZk7GHM3stmsAHb49TbddyqBC
	 bwG1biw5wbVH3EriPBH9zCtgJ2gQSNP6nKiFMWF4tox0Bj4IQwd8/wuP/41QRpBA7a
	 xuX9v5+SVTPERlpwBZky7sZSmM/NwHZx9iEGuqsaewO6hXEZ/W0/L9GlEgrBFisCVq
	 Z1oVjN+tSz3mcWbtijAmX73ioG6cdH9fLtSh9wu8CkwHS2G+iPnRZ+Euc56Cnxs/My
	 58GgaqZyxeCwh5BB08FANDVujr+7h3DjGpCV6rltV5uobIPj9ZxWFGjuDwNRiHjQqu
	 Bpo4Xap9c89qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 519/715] RISC-V: KVM: Forward SEED CSR access to user space
Date: Sun, 24 Mar 2024 18:31:38 -0400
Message-ID: <20240324223455.1342824-520-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Anup Patel <apatel@ventanamicro.com>

[ Upstream commit d808f0b1be4888a87524164bc7dad2242734de38 ]

The SEED CSR access from VS/VU mode (guest) will always trap to
HS-mode (KVM) when Zkr extension is available to the Guest/VM.

Forward this CSR access to KVM user space so that it can be
emulated based on the method chosen by VMM.

Fixes: f370b4e668f0 ("RISC-V: KVM: Allow scalar crypto extensions for Guest/VM")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kvm/vcpu_insn.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 7a6abed41bc17..ee7215f4071f5 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -7,6 +7,8 @@
 #include <linux/bitops.h>
 #include <linux/kvm_host.h>
 
+#include <asm/cpufeature.h>
+
 #define INSN_OPCODE_MASK	0x007c
 #define INSN_OPCODE_SHIFT	2
 #define INSN_OPCODE_SYSTEM	28
@@ -213,9 +215,20 @@ struct csr_func {
 		    unsigned long wr_mask);
 };
 
+static int seed_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
+			unsigned long *val, unsigned long new_val,
+			unsigned long wr_mask)
+{
+	if (!riscv_isa_extension_available(vcpu->arch.isa, ZKR))
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	return KVM_INSN_EXIT_TO_USER_SPACE;
+}
+
 static const struct csr_func csr_funcs[] = {
 	KVM_RISCV_VCPU_AIA_CSR_FUNCS
 	KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS
+	{ .base = CSR_SEED, .count = 1, .func = seed_csr_rmw },
 };
 
 /**
-- 
2.43.0


