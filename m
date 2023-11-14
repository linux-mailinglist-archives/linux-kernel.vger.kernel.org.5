Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F8C7EB255
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjKNOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjKNOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:36:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE0D79
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9683C43395;
        Tue, 14 Nov 2023 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699972555;
        bh=+jSB6ryQw/tAoaW0f6Dn8f5r/j3Y5hYXa/dEZzeKHsY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=SEGdzbC7b3wvMV/Ivzh+9pjvZ4JIMa9KlE7jQa6b4P2pa6rq17+x3do5ktJq1XLux
         7T4GgVQV7XbbzuW7I2oE2Q1GisQDn5s60Zm9L3lSQruv90HXyNcPZRO98vranKE7l2
         /GrQfWQYcZjvSQUQGvLmKA+UQt+ba+dAoAnpU2Up9slFFsWZJiYEBrBEIsxsQZGNrJ
         DxNdqxvl+v1I8aIMm2OKN44VvNMGy752EsPi39uSdacKE8uDorHkb/u9pEjBsDRrAD
         8gqTuFsq5dcoH2Xpq+C6lSGdEw9sW8wZvPS4wRmKOXjCUjZGbBj64nFj7lUQKALnli
         AeCR4q53PRrdA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 14:34:55 +0000
Subject: [PATCH v2 10/21] arm64/fpsimd: Enable host kernel access to FPMR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-10-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+jSB6ryQw/tAoaW0f6Dn8f5r/j3Y5hYXa/dEZzeKHsY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WcKwT165mW8oQVRPIaZv68B/WwcA+JzKzLOCir
 kQlxz5+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFnAAKCRAk1otyXVSH0GMdB/
 4+cijMYPYrqufsdKVq1iYT/G7uPwkXJ9/l3VF+dAG1JOHxhY2b2Ce8RiIKiql/X7QgixZvMO/M/zOM
 ZPIUX4CV0DhhyCv0dry+chuyfHmZKstJzsDz4jyryyx+szv4am5GwIGJHOHVKQ/JoSK4k/SRMyKR4q
 U7TJe73E+13UCeTitrIqV6D2gDqr7SqeRungofG3SkzDPWAQb4givyRUVEyAWPEukXji4V58e40LzE
 mgNS18Eb0F4D4Ih3su5c+Ejb3IF390ueKDQJLFs6HKKcR82E589lXZnquLKvpuP4hHV/KUWZ28+PY2
 8jL/aO44ctaIzBymlrA1ZBmmRoqanD
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

FEAT_FPMR provides a new generally accessible architectural register FPMR.
This is only accessible to EL0 and EL1 when HCRX_EL2.EnFPM is set to 1,
do this when the host is running. The guest part will be done along with
context switching the new register and exposing it via guest management.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index b85f46a73e21..9f9239d86900 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -105,7 +105,7 @@
 #define HCRX_GUEST_FLAGS \
 	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
 	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2) : 0))
-#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En)
+#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_RES1		((1U << 31) | (1 << 23))

-- 
2.30.2

