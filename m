Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70B679F128
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjIMSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:34:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE1BA3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:34:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92B3C433C8;
        Wed, 13 Sep 2023 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694630072;
        bh=24jGWq19/rv3+6J5AgpLm/HbwyWq/3uIYq2kxo6jB8Q=;
        h=From:Date:Subject:To:Cc:From;
        b=MX+kGbDvofFkEwStch87Uzmw14ffdjzzAnYyfV1KWNeN0kbxrcqzH+KfaBXWme27H
         zuE/iNUfDr6UXMLTuUlbPaHpObWHnpNcUNBm3iJ7KHqHet2PByBlIH42OYrvpKUCSY
         SgL+vr8OcrD4lTT6v0jfvbPDRmG28Ml2buetfE1McFH44S/IkXBXmMMgwUe+HlsnUX
         K3hWhcLmRf8mA2phK7ioY0Kjq9THyazyqMZcIt4qVKRfb4hPbzCCeBD7XR0E1+PZmi
         H5HjL6RM5XZqwFjmm2/93Gjcf1SfVVw5+jvgqYoZ4VkIza4lQqXEg0jH6a34KBjzgt
         xLE2GIVY05Phg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 13 Sep 2023 19:34:16 +0100
Subject: [PATCH] KVM: arm64: Only default to enabling SVE when present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-kvm-arm64-fp-init-v1-1-8ce9ba1cc4c4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKcAAmUC/x3MQQqAIBBA0avIrBuwstCuEi0kpxoiCw0JpLsnL
 d/i/wyRAlOEQWQIlDjy6QvqSsC8Wb8SsiuGRjatNFLjng604egVLhey5xu1Udpq13WkFJTuCrT
 w8z/H6X0/Yv5G5GMAAAA=
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331; i=broonie@kernel.org;
 h=from:subject:message-id; bh=24jGWq19/rv3+6J5AgpLm/HbwyWq/3uIYq2kxo6jB8Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAgC0g4V1utvnFCrJGRX/IIAlVdEhwtsmuZXB/psP
 +m6cleCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQIAtAAKCRAk1otyXVSH0Et1B/
 wPRc04N8fDXXPVzS0NHrRGqRG/AcAcViQkowmHjW+vL2/C0b/eG0Xz37VnUiyuHK4q2CELDMuSGmib
 6uJ0KBu0HqR7OMsgId8D6rCS14TNxW+uu8SecUtpdA/t73FISy04yo/IP0FJZ19ejd8enjS+x3xuP7
 gX+pdRN9t2qL6SmNEvCFiQEK3vYd/qcY9+GB8XkcelPKW/0kHtlYR2lo7pZk0STfmioks5Snh4gkcT
 5d6TWha3oqAs2WPh+ndqb8AcaZ4i5mEC0M9yjkMP741Rx3peFV7/rR5UC372VGBM4sUs5fvR5+iQtZ
 19geP4n7PqrahE+jTpib3X3W37LNhN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unclear reasons our handling of SVE and SME when setting the default
value of CPTR_EL2 for VHE mode is inconsistent. For normal VHE we
unconditionally set CPTR_EL2.ZEN to 0b01 but only set the equivalent
field CPTR_EL2.SMEN to 0b01 if SME is present, for hVHE we will always
set the field 0b11 if SVE is not supported. Given the similarities
between the two extensions it would generally be expected that the code
handling SVE and SME would be very similar.

Since CPTR_ELx.ZEN is RES0 when SVE is not implemented it is probably not
harmful to try to set the bits but it is better practice to not set
unimplemented bits so resolve the inconsistency in favour of checking if
SVE is present too.

FPSIMD is also in theory optional though there's probably much more work to
handle the case where it is not implemented properly and that is not
something we see in practical systems.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 3d6725ff0bf6..4cf53b4aa226 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -584,15 +584,17 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
 	u64 val;
 
 	if (has_vhe()) {
-		val = (CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN |
-		       CPACR_EL1_ZEN_EL1EN);
+		val = (CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN);
+		if (cpus_have_final_cap(ARM64_SVE))
+			val |= CPACR_EL1_ZEN_EL1EN;
 		if (cpus_have_final_cap(ARM64_SME))
 			val |= CPACR_EL1_SMEN_EL1EN;
 	} else if (has_hvhe()) {
 		val = (CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN);
 
-		if (!vcpu_has_sve(vcpu) ||
-		    (vcpu->arch.fp_state != FP_STATE_GUEST_OWNED))
+		if (cpus_have_final_cap(ARM64_SVE) &&
+		    (!vcpu_has_sve(vcpu) ||
+		     (vcpu->arch.fp_state != FP_STATE_GUEST_OWNED)))
 			val |= CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN;
 		if (cpus_have_final_cap(ARM64_SME))
 			val |= CPACR_EL1_SMEN_EL1EN | CPACR_EL1_SMEN_EL0EN;

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230908-kvm-arm64-fp-init-8948a8d55e44

Best regards,
-- 
Mark Brown <broonie@kernel.org>

