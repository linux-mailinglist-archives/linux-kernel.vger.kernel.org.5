Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1804B7EA29D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjKMSNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMSNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:13:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685FFD57
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:13:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14064C433C8;
        Mon, 13 Nov 2023 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699899214;
        bh=zZ0ABhBNzUrMEKoajMk2OiQ2peqB51tlUR1tmzcZ7QE=;
        h=From:Date:Subject:To:Cc:From;
        b=Ufk8Ipnjch8hRwP6kbw4DrHyq2lNTBAttobjsEfozAApeXtbIhKWESGA1N7GxluFU
         bRyOsDwvEESSDsNuukk7lbmMVOO1uWNnwqE67u8ZsAtezZNhFpyLZpCo6A4myaDrWS
         d0xBeVYbC6q66VGw4Lk46kZav7VJUMdsxz7rnLDbj+9vx23VEDL0FJCOAYgPoNB1QI
         rhDG7/OOF3JZpKZYNWOTx2hX7NyVjsB97EMWmveu8M4vyVFnJPA6Etsom8QFK9RJog
         mjTKPPP0L0XbsbdnqyWMJ/m4ySgOIsojmDxIutBb4VsNRz+lNXbgqSFFVUc7OB4WX4
         0N5nCdXlwgxMA==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 13 Nov 2023 18:09:18 +0000
Subject: [PATCH v2] KVM: arm64: Only default to enabling SVE when present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-kvm-arm64-fp-init-v2-1-98867e5fd97f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE5mUmUC/22NQQ6CMBBFr0Jm7RgKxRRX3sOwqGWACVLIlDQaw
 t2txKXL95L//gaBhCnANdtAKHLg2ScoThm4wfqekNvEUORFmde5wTFOaGW6aOwWZM8rmloba9q
 qIq0h7Rahjl9H894kHjiss7yPi6i+9ldT5Z9aVKjQOKofVjmnnb6NJJ6e51l6aPZ9/wB8q9PIs
 wAAAA==
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zZ0ABhBNzUrMEKoajMk2OiQ2peqB51tlUR1tmzcZ7QE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlUmdKzgYWsfK8IY0vjDLIDyiKtEJ/MwZ6WMxi7mip
 PI6CWymJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVJnSgAKCRAk1otyXVSH0I2zB/
 9/GohuiyHT41TGPna2JwnANYxSkfsGRbWEfszNUz92/SIPL07c93Ca2nyhCwjqj6pdZsUzGJ68VovD
 gAMIr+RkYLVGkx4li6CfsXGFkZsIc+6uhqTyDy2f3jLoo7cWt5xAa+nuCeiwd2axTdKEAIdMfzL1Gh
 mN4KU+VzCgV6mzKoIwj2E4BPrg1nLE+zNHa8STplZjHilVi/rx+DWBOg7pwgQD1N5wjtpNCt5ZrjuP
 UeuTS+bv5we7VKG8NPgYO+5I2lMgOfbXg0h+MSfbYKRXbsVvQ45hwcJnVn/Lf3s3KEIYp4MPAPyz+S
 cT+h8WCaXBOhuy6fdzf7iyPY1eZ1+T
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes in v2:
- Rebase onto v6.7-rc1.
- Link to v1: https://lore.kernel.org/r/20230913-kvm-arm64-fp-init-v1-1-8ce9ba1cc4c4@kernel.org
---
 arch/arm64/include/asm/kvm_emulate.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 78a550537b67..b6f1ddff796c 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -583,15 +583,17 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
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
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20230908-kvm-arm64-fp-init-8948a8d55e44

Best regards,
-- 
Mark Brown <broonie@kernel.org>

