Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67047698E9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGaOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjGaODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760D4C18
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:59:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0DBE61156
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA58AC433C8;
        Mon, 31 Jul 2023 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690811936;
        bh=Y20rCRKq5uNdwkqUpNrU9kMWAiGPZ9PiFVa14wpm3ak=;
        h=From:Date:Subject:To:Cc:From;
        b=t655aoxAo+IqCk9uPlpORFGZepkR/uSRvdnbbXFe/v8As8SfWdMRDgHAaB11LtrUW
         6j56jMgoUEXPzL2e8OQtnU6u1PwX5A2jCUgUx1ym48DU4DY3BRIwswbz8BqN4S1hHe
         v30reVH0iBuAody6qhlIS28vJqX2DlLUzHA9rNhPfOtB9H1/AUwDepQ75/vVqx9qK5
         aK8+iFyvjSBAOWCbkRwg5vYwOxj7N23UlG42C0hVPLi/WMo+4NLkWSUdiipnUYUJ6A
         vGldpoMQnMtBBFjKtJx+fSdABxTQDtHmlaOB1j8vzbPblAS4FATiRdAfDWMiIsoAos
         C/qPxMiCp1d7w==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 31 Jul 2023 14:58:48 +0100
Subject: [PATCH v2] arm64/fpsimd: Only provide the length to cpufeature for
 xCR registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org>
X-B4-Tracking: v=1; b=H4sIABe+x2QC/4WNQQ6CMBBFr0Jm7Zi2YCuuvIdhUXEKjUDJFImG9
 O5WLuDuv5/89zeIxJ4iXIoNmFYffZgyqEMBbW+njtA/MoMSqhRGGbQ86grjSOhsDn1Y5uHVoSR
 9rrWptKsN5PHM5Px7F9+azL2PS+DP/rPKX/tXuUqUWFaW6tK6Vpzu1yfxRMMxcAdNSukLfiMhU
 r0AAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3690; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Y20rCRKq5uNdwkqUpNrU9kMWAiGPZ9PiFVa14wpm3ak=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkx74d2izPJ5eQrkqQz/wumIwnpMJibEii4LCF4syS
 IK2UYJGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMe+HQAKCRAk1otyXVSH0JxTB/
 0UXVcOEATL1/+hb6PzIJ7mRToFRfr9hE1e1HJI/5mOTYEAZpXuJTmILqM9snl2scQp0kR6p3ZMxRtx
 KmLB9o43UYE7wnkwpW1NMTHx4UHuKuSulrDI0nRcKoO0zXbg35i2ChWZ6Tjr/ROdNkgDV25tw71r+j
 p5Av1ov69byhlKCq/43n1a3ikWnfvHALLd0QdL6kluI27F7YPlU+rzP8qjBw9jm2vlzIX/nO7v+99f
 GpccnuaDjc1pFMc7vpq7ltEW/RSE4d2bb0BHUPCVMkS1b73oeNR05OFSm2zcH/qDTad9mUhLrY0YBW
 p3ZopW4eCNimueYsNuT/1rHIGwIWkk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For both SVE and SME we abuse the generic register field comparison
support in the cpufeature code as part of our detection of unsupported
variations in the vector lengths available to PEs, reporting the maximum
vector lengths via ZCR_EL1.LEN and SMCR_EL1.LEN.  Since these are
configuration registers rather than identification registers the
assumptions the cpufeature code makes about how unknown bitfields behave
are invalid, leading to warnings when SME features like FA64 are enabled
and we hotplug a CPU:

  CPU features: SANITY CHECK: Unexpected variation in SYS_SMCR_EL1. Boot CPU: 0x0000000000000f, CPU3: 0x0000008000000f
  CPU features: Unsupported CPU feature variation detected.

SVE has no controls other than the vector length so is not yet impacted
but the same issue will apply there if any are defined.

Since the only field we are interested in having the cpufeature code
handle is the length field and we use a custom read function to obtain
the value we can avoid these warnings by filtering out all other bits
when we return the register value, if we're doing that we don't need to
bother reading the register at all and can simply use the RDVL/RDSVL
value we were filling in instead.

Fixes: 2e0f2478ea37eb ("arm64/sve: Probe SVE capabilities and usable vector lengths")
FixeS: b42990d3bf77cc ("arm64/sme: Identify supported SME vector lengths at boot")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Skip the munging into the register step and just return the value we
  would munge in.
- Link to v1: https://lore.kernel.org/r/20230727-arm64-sme-fa64-hotplug-v1-1-34ae93afc05b@kernel.org
---
 arch/arm64/kernel/fpsimd.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 520b681a07bb..aa4194c646b2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1178,9 +1178,6 @@ void sve_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
  */
 u64 read_zcr_features(void)
 {
-	u64 zcr;
-	unsigned int vq_max;
-
 	/*
 	 * Set the maximum possible VL, and write zeroes to all other
 	 * bits to see if they stick.
@@ -1188,12 +1185,8 @@ u64 read_zcr_features(void)
 	sve_kernel_enable(NULL);
 	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL1);
 
-	zcr = read_sysreg_s(SYS_ZCR_EL1);
-	zcr &= ~(u64)ZCR_ELx_LEN_MASK; /* find sticky 1s outside LEN field */
-	vq_max = sve_vq_from_vl(sve_get_vl());
-	zcr |= vq_max - 1; /* set LEN field to maximum effective value */
-
-	return zcr;
+	/* Return LEN value that would be written to get the maximum VL */
+	return sve_vq_from_vl(sve_get_vl()) - 1;
 }
 
 void __init sve_setup(void)
@@ -1348,9 +1341,6 @@ void fa64_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
  */
 u64 read_smcr_features(void)
 {
-	u64 smcr;
-	unsigned int vq_max;
-
 	sme_kernel_enable(NULL);
 
 	/*
@@ -1359,12 +1349,8 @@ u64 read_smcr_features(void)
 	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_LEN_MASK,
 		       SYS_SMCR_EL1);
 
-	smcr = read_sysreg_s(SYS_SMCR_EL1);
-	smcr &= ~(u64)SMCR_ELx_LEN_MASK; /* Only the LEN field */
-	vq_max = sve_vq_from_vl(sme_get_vl());
-	smcr |= vq_max - 1; /* set LEN field to maximum effective value */
-
-	return smcr;
+	/* Return LEN value that would be written to get the maximum VL */
+	return sve_vq_from_vl(sme_get_vl()) - 1;
 }
 
 void __init sme_setup(void)

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230727-arm64-sme-fa64-hotplug-1e6896746f97

Best regards,
-- 
Mark Brown <broonie@kernel.org>

