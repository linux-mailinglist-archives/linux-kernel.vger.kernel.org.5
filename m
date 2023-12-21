Return-Path: <linux-kernel+bounces-9076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3080B81BFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C3B1C23F46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C076DB5;
	Thu, 21 Dec 2023 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPhO+IaY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2376DA0;
	Thu, 21 Dec 2023 21:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0C8C433C7;
	Thu, 21 Dec 2023 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703193709;
	bh=NjNmw5Ek8zEJrqryDRYWuyDZvX8b0InAFEl21YGq4XY=;
	h=From:Date:Subject:To:Cc:From;
	b=rPhO+IaYCwg9QQGnJD2N6PkeHyXytY0LnsDPYiySppg75/ONxsv36JJk002c3xmLU
	 lJJwVc/rBQxAZOnqGuUzeAc7kjYGOKvwKaINW8zDa8esQ8+VWZUM/wecGySitddfWe
	 +lVBQk//OF5Fc2qTTmbdhcrcVHqAMGeB5Kif1iE6dpd40Goy4Hysmf/cDdsGZcCS3E
	 aK65T5ue2fBAa6S16p2EqWziGt0VrthwTTBRre8wIvG8FcjdvXxKS4O728BjtkbIze
	 Vdvvxcp3EI7+huATwpt5laNmfbqXKai7c/Ll/5n7dXQR7ha54qAYfVwrlH/4JenwjI
	 Qg9OaBUmq33AA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 21 Dec 2023 21:21:09 +0000
Subject: [PATCH] KVM: arm64: Document why we trap SVE access from the host
 in nVHE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-kvm-arm64-nvhe-sve-trap-v1-1-332ecc56f694@kernel.org>
X-B4-Tracking: v=1; b=H4sIAESshGUC/x3MMQqAMAxA0atIZgO2ahGvIg7BRg1ilVSKIN7d4
 viG/x+IrMIR+uIB5SRRjpBhygKmlcLCKD4bbGVrY02HW9qRdHcNhrQyxsR4KZ04u5Zq7xtHjiD
 Xp/Is938exvf9APIfSIxpAAAA
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NjNmw5Ek8zEJrqryDRYWuyDZvX8b0InAFEl21YGq4XY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhKxqtaVguLxVoy/xyh/2YDD7V5KEdHEKIQHe9SYb
 FOuLKVSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYSsagAKCRAk1otyXVSH0AeKB/
 9VuQl3RXtHCh2SiKEoZkyn67P1sOJROEh15jp/tZ2/inqSslCn/TRleua50ZwSKbF8yqWt9UoglFyd
 G4d1I85RkBLHxq078eSfP/USN37aX0t5b+q4/UPjp0D9ogHDMKYq/qFumulnb3ZQC23L/Kctz8p9/4
 IJZrik7Hhy3rw7HLedJVmMH7H431RUDuPzBcoefxwl9sb8t7dU0TTPl4qxHGorCtdTzd86FpVMMYsu
 xWnwyrNDgzVidt0rruILNccgBnMY6vRu2og0L/WKl2Hfr/fV/OR/BAaNbC6CLY/pzKPTA5i9NZ2H4s
 JYgiwEkiYoFdk/bqU3dUOSuTi9pmFe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we exit from a SVE guest we leave the SVE configuration in EL2 as it
was for the guest, only switching back to the host configuration on next
use by the host. This is perhaps a little surprising when encountered in
the code by itself, add comments explaining what is going on both in the
trap handler and when we configure the traps.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 2 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 78a550537b67..edd807a77e19 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -590,6 +590,7 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
 	} else if (has_hvhe()) {
 		val = (CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN);
 
+		/* Leave traps enabled, we will restore EL2 lazily */
 		if (!vcpu_has_sve(vcpu) ||
 		    (vcpu->arch.fp_state != FP_STATE_GUEST_OWNED))
 			val |= CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN;
@@ -598,6 +599,7 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
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
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231218-kvm-arm64-nvhe-sve-trap-f65a3dd46a6a

Best regards,
-- 
Mark Brown <broonie@kernel.org>


