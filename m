Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE4765E45
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjG0VcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjG0VcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1BF198A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C2AE61F53
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BDDC433C7;
        Thu, 27 Jul 2023 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690493537;
        bh=1CRGMuJsL3YWwFkJWqZBVNQLm+e0c2Kn5gP+uFZkfnA=;
        h=From:Date:Subject:To:Cc:From;
        b=hH3TlYxlIbzFmsrhc7tqA0RbNmbOiMN1MESjZVmQCUuImg3/IaxnKpIXwLWbv7kvF
         3pzqheJI7w0gYaoN2/rYXM4+qGoy+3tFxnmLV356MM0WmkoicaUMNzGFw23zTOF86f
         14xXCHERBRuAXLgjIEiREtjSGHmxNCsEzOtwJCOZxPyDtxPWPArkJ94JQOLYs6eiUv
         AD6oxAwDC+ss933wRVeAt5HMjSpu8XdKCPMlJeSzIPcK1w/VuYyN3I7+H0Zk5b16W8
         PrfMozEokSlep42J3JJd/mxElozkdhtLWaolymui3kFU9iqjbjPVpWNgx1tKzIfF1Z
         qmLgLuige9Xaw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 27 Jul 2023 22:31:44 +0100
Subject: [PATCH] arm64/fpsimd: Only provide the length to cpufeature for
 xCR registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-arm64-sme-fa64-hotplug-v1-1-34ae93afc05b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAD/iwmQC/x2MQQqAIBAAvxJ7bqEsNPtKdJBaa6FUtCKI/p50m
 znMPJAoMiXoiwciXZzYuyx1WcC0GrcQ8pwdRCWaSgmFJu6yxbQTWpNh9UfYzgVrkp2WqpVWK8h
 xiGT5/sfD+L4fDOP8wWgAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2482; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1CRGMuJsL3YWwFkJWqZBVNQLm+e0c2Kn5gP+uFZkfnA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkwuJfmjZxm299vqS0FgQ7RMOHXsS6ZOjWNxPhZZ9u
 dj3urxaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMLiXwAKCRAk1otyXVSH0EYdB/
 9j02QwBO6pB4nb0BM8kQI73QWh+XZa0Vn8R1RubNM2+z++MgD7xbVOAMp7id+2c2D5lC4G/m/K3lLZ
 WArgn3zZKCKPQ91dqN9xaoBxSd4x2GHDCrWWffB/YI0tUFIFPPWSZZmegrGC1BBuCptjUQZIP6v1St
 J3MNHRAomp6IaW5Z8Bsf/3e17Fn8SuZ6ga4BulVwIM8me+GhD1Q2WeY7DVS4lvfSxsg+VInFEQU63q
 jRO+FXz0iL1xxT2xZl3qJ81lhXgcqq3fB3Kq/fzbwI0Qthh4IaJMGAtbfi/ZiljQkgrlPCCl43rD60
 HkTKJUnRYyMCTkm5vWzwl5Fe2rWPGF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
when we return the register value.

Fixes: 2e0f2478ea37eb ("arm64/sve: Probe SVE capabilities and usable vector lengths")
FixeS: b42990d3bf77cc ("arm64/sme: Identify supported SME vector lengths at boot")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 89d54a5242d1..c7fdeebd050c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1189,11 +1189,11 @@ u64 read_zcr_features(void)
 	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL1);
 
 	zcr = read_sysreg_s(SYS_ZCR_EL1);
-	zcr &= ~(u64)ZCR_ELx_LEN_MASK; /* find sticky 1s outside LEN field */
+	zcr &= ~(u64)ZCR_ELx_LEN_MASK;
 	vq_max = sve_vq_from_vl(sve_get_vl());
 	zcr |= vq_max - 1; /* set LEN field to maximum effective value */
 
-	return zcr;
+	return SYS_FIELD_GET(ZCR_ELx, LEN, zcr);
 }
 
 void __init sve_setup(void)
@@ -1364,7 +1364,7 @@ u64 read_smcr_features(void)
 	vq_max = sve_vq_from_vl(sme_get_vl());
 	smcr |= vq_max - 1; /* set LEN field to maximum effective value */
 
-	return smcr;
+	return SYS_FIELD_GET(SMCR_ELx, LEN, smcr);
 }
 
 void __init sme_setup(void)

---
base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
change-id: 20230727-arm64-sme-fa64-hotplug-1e6896746f97

Best regards,
-- 
Mark Brown <broonie@kernel.org>

