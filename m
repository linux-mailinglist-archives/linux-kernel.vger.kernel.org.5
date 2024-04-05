Return-Path: <linux-kernel+bounces-133044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C293D899E01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774A51F21271
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C916D309;
	Fri,  5 Apr 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4FcA2sE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECE16D4F8;
	Fri,  5 Apr 2024 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322439; cv=none; b=MGlPvITjzQeb+O3MO7+Dh2OFlD8TQxcaGfVtCzFvJCOL1c+FfxyPAbrsB+HTEuSB3hoG64OdKR4f1CNtBSj7vgBiGAF9F/JZXBMGOrpp3BCq+mAYZlZw17sqdKLm6CfXSY5ha7axw8k3+z869vMQt0pmlTJUWJ3GtwX0lwLJh8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322439; c=relaxed/simple;
	bh=EYf9aJVWWapg+rOs2VOwVmeQbQXK+25yKMQolondcvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CiSrrsa4mIvnXEkBhKR+WT27A+lysLdMbKI83a5kHue3DkL3ZdO9FuRjQSXaHGlGlaivGY36YFT/x8a4MeUONc89x8tDn0wpbMOgltubTwhkNCigg0Bg6L01AUUh79DiAYoRASL3fuUbVbtfUN4JPWq13/pFJcftFUBodW6v2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4FcA2sE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B55C4166D;
	Fri,  5 Apr 2024 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322439;
	bh=EYf9aJVWWapg+rOs2VOwVmeQbQXK+25yKMQolondcvo=;
	h=From:Date:Subject:To:Cc:From;
	b=T4FcA2sEJ3X0TSwn3M1+mGADP1xvuwfDrCrlzpdPmRMmsg2rEtGvEwkw/aLJc2c+u
	 rtt/qI5ICDYPuMgzdfHiR6YCrviNrOysvPjscn8S5m850ZESQjP7UkS4HefrJFghoL
	 IYXnvZwUdIHbokNse/RnpXFQ6RdjJ4nO9gZn4eW2Q5Y4nrVRENVWt3d5uzAEF+kdLu
	 PeqXTVuPqX195bxg4cvPArbSrRKmO231FMIngqYCNjX2CrAFsXJBOi/DEo6HdmH+8W
	 jSXSAFBTBe2P2YQyTElYfwliC3azFn0+1sX+gZjcC3oacRPnq8i5iMqj2iVBOHIJ6v
	 sqk9sv1km+jhg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 05 Apr 2024 14:07:14 +0100
Subject: [PATCH v2] KVM: arm64: Document why we trap SVE access from the
 host in nVHE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-kvm-arm64-nvhe-sve-trap-v2-1-a179da25ee34@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIH3D2YC/3WNyw6CMBBFf4XM2jH2QaOu+A/DoikDbZBCpqTRE
 P7dSty6PCe5526QiAMluFcbMOWQwhwLyFMFzts4EIauMMiLVEKKK455QsuT0RizJ0yZcGW7YG9
 qq7pOG2sslPXC1IfXUX60hX1I68zv4yiLr/01pfjbzAIFKiXJudr05qabkTjS8zzzAO2+7x/vu
 q2QvwAAAA==
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EYf9aJVWWapg+rOs2VOwVmeQbQXK+25yKMQolondcvo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmD/eD0zTvKa3D86qnQSr+XkOhX1FPfd2oKxzOugwx
 ZkeA2JGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZg/3gwAKCRAk1otyXVSH0AmvB/
 9B5FqSRCIYIwoRkZL7zuAdbWUckXWCiiQjiVU2NUg+Jpbj+OjnL1J4iVD8DTREsLl9WKen1ofSsz7P
 x64X2WUI/lhQTO5TBdAJ80dBeXXo9gSP+4As+ljSJXwKzcf977CHw0MhMmqQg+ibIv+yxM8IIFCjZI
 af6WEPkj2+1/NLo0Vh7f9jd+W8GKOLzfuWEZptDURS0zCQms6ldUBPLKfGr+kmZRb+FL9CLpz+yLxM
 nMKDx4vBTZQX1CA7p7cWPyH1RZp6xoTJWQWD+7PwL1LsYz14A9gA+bih+tvpZFItTBJdmv86NQBppy
 HB6TN/F27mgA+VmbqKtA6UIVK3t3Vg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we exit from a SVE guest we leave the SVE configuration in EL2 as it
was for the guest, only switching back to the host configuration on next
use by the host. This is perhaps a little surprising when encountered in
the code by itself, add comments explaining what is going on both in the
trap handler and when we configure the traps.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.9-rc1.
- Link to v1: https://lore.kernel.org/r/20231221-kvm-arm64-nvhe-sve-trap-v1-1-332ecc56f694@kernel.org
---
 arch/arm64/include/asm/kvm_emulate.h | 2 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 975af30af31f..68a5c7b380a0 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -587,6 +587,7 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
 	} else if (has_hvhe()) {
 		val = (CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN);
 
+		/* Leave traps enabled, we will restore EL2 lazily */
 		if (!vcpu_has_sve(vcpu) ||
 		    (vcpu->arch.fp_state != FP_STATE_GUEST_OWNED))
 			val |= CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN;
@@ -595,6 +596,7 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
 	} else {
 		val = CPTR_NVHE_EL2_RES1;
 
+		/* Leave traps enabled, we will restore EL2 lazily */
 		if (vcpu_has_sve(vcpu) &&
 		    (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED))
 			val |= CPTR_EL2_TZ;
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2385fd03ed87..84deed83e580 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -420,6 +420,7 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 		handle_host_smc(host_ctxt);
 		break;
 	case ESR_ELx_EC_SVE:
+		/* Handle lazy restore of the host VL */
 		if (has_hvhe())
 			sysreg_clear_set(cpacr_el1, 0, (CPACR_EL1_ZEN_EL1EN |
 							CPACR_EL1_ZEN_EL0EN));

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20231218-kvm-arm64-nvhe-sve-trap-f65a3dd46a6a

Best regards,
-- 
Mark Brown <broonie@kernel.org>


