Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635C7F422C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbjKVJoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbjKVJoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:44:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E4510E4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:44:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E86C4339A;
        Wed, 22 Nov 2023 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646248;
        bh=i9QyE7h/VNfEY/fQWg1KcUCsnEaqWFpKvbtjF57JZIU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OvKVQHJlaRBJIrr/EqVvB1Vhp4g6DB+5CWEBUGNM3o4IyXrYXjYMV9aL349rfMduV
         iC1sUc8GEMqhX9H+WRYy595ExaJkKlI4MNhh8kzV2HwPjOacNIQul8xtmQvxy/xNWy
         bJyZ92pIRTGziqyBTlQVmhpRcHecvfbBV8wVxA1Jl3BIzkpyZ6s/ZovvVa/P4DuGKH
         mxVnXURPLXu73B5K45nsYhJhGwSGJGkfi7MoHRbDJvnCRGQ5ZNTznbOFNqjlxfBHPi
         GJ1mJL/sYWm4X7XtGJckFaZSRb6p2wAJFNIMhy8vDr+jKDW1Wp5g6OdIf+KPnIfmWR
         oSzOQyZR1Z4qQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Nov 2023 09:42:20 +0000
Subject: [PATCH v7 10/39] arm64/cpufeature: Runtime detection of Guarded
 Control Stack (GCS)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-10-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2922; i=broonie@kernel.org;
 h=from:subject:message-id; bh=i9QyE7h/VNfEY/fQWg1KcUCsnEaqWFpKvbtjF57JZIU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXcz+s2txHvZTDwLAf6SOVjsd+5BN63pi8i51Z
 FULlftCXzOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3M/gAKCRAk1otyXVSH
 0LSmCACGoUb2lLCDHWabC23R3Nx8VwtQ0tQQHq3bVsr9lWag6ifOZORAusKIlhzB1Oof9Iv9cBG
 7FBO3D5ZhNs6EMIXSMOy38ifF/x/csaQnxTcH0SQxUa0yxqQabljmKvoALa4i6z2Sae8FCyOu5E
 bYUX0M3PHsUF5jPmg/O+j9TkHroXSXFGeQgLHN7x67h3d/QTmpeg1SC6AwlkZYnH/dUUQusDF4r
 mj6E+PFeikOSBCVgHbO/jkc02tozpz97gUJGsZ9H4glsVXGtiH+3gPm2IGliCtYTvx2Jwl0/Mu+
 7ZPEOpq55NzT3FgzhsBiZfL6DeYDKnu1Tu30JsJ4LpYGSAQ+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a cpufeature for GCS, allowing other code to conditionally support it
at runtime.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f6d416fe49b0..5696a55cc1f8 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -819,6 +819,12 @@ static inline bool system_supports_tlb_range(void)
 	return alternative_has_cap_unlikely(ARM64_HAS_TLB_RANGE);
 }
 
+static inline bool system_supports_gcs(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_GCS) &&
+		alternative_has_cap_unlikely(ARM64_HAS_GCS);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 646591c67e7a..5477451cefa1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -255,6 +255,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_GCS),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_GCS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_SME_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_MPAM_frac_SHIFT, 4, 0),
@@ -2242,6 +2244,12 @@ static void cpu_enable_mops(const struct arm64_cpu_capabilities *__unused)
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_MSCEn);
 }
 
+static void cpu_enable_gcs(const struct arm64_cpu_capabilities *__unused)
+{
+	/* GCS is not currently used at EL1 */
+	write_sysreg_s(0, SYS_GCSCR_EL1);
+}
+
 /* Internal helper functions to match cpu capability type */
 static bool
 cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
@@ -2731,6 +2739,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
 	},
+	{
+		.desc = "Guarded Control Stack (GCS)",
+		.capability = ARM64_HAS_GCS,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.cpu_enable = cpu_enable_gcs,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, GCS, IMP)
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index b98c38288a9d..30d27f6301fd 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -28,6 +28,7 @@ HAS_EPAN
 HAS_EVT
 HAS_FGT
 HAS_FPSIMD
+HAS_GCS
 HAS_GENERIC_AUTH
 HAS_GENERIC_AUTH_ARCH_QARMA3
 HAS_GENERIC_AUTH_ARCH_QARMA5

-- 
2.39.2

