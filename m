Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADF7E4366
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbjKGP1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjKGP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:27:26 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B339A113
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:27:24 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so3523340a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699370844; x=1699975644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtKbq6gTZrURkQc/6QWUt4p94lELBM6ajnXaIsFT5Fk=;
        b=ktHQmlUvEGh07IudoE1GTRc0X95raVD2ulViS3JxZHCPViJrwKn1UxqWFxRLb9hPOz
         DDe+SBLtcTampfozU9+pM1EKIZUj8O4n5qCxujnfE9F5IYUS0RoEx2/FIBhvLgUUVCzV
         MJwZEFquJhjFBDcxsw5aoaXk2N9hvTOuzCdn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370844; x=1699975644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtKbq6gTZrURkQc/6QWUt4p94lELBM6ajnXaIsFT5Fk=;
        b=Txil+CLscrlTUpryj3V3jUMVKiplw0Q+MrAnfbI1VjR4TriTWHlmECU6ibjAC9+vu7
         8PdBEMAclPYvoQR1q5Kn51b+tUkPFIuoJDm4QgeQ3mE91d1ItO5uLwgE4fvwVKGmajw5
         Gv7QgvTk5mLz3/hwvwNbVFpvligJyjc2pFXXYw8sdiK5oOBCHweyY+tsM7GLB7e/gUHF
         YBnk5qEcm5w5p1uQjDXIgX+3zEoIxlrINfhOe7zdIf5lhOk5q9WgWeGclt4uxU2Oc1oJ
         XIc0eiYcTup9tai5bUKhWEhUatSjTYYB2d93XwKfhHESf7wSLBmjtVkkiIBu4VibtOfO
         SrRw==
X-Gm-Message-State: AOJu0YwBBIiD05paPuI7bwBixxriP/+6e1SQ9r6bYMXmteFEADxqEzG6
        TY0fSlurOmDnblMZpROiB5kzL6/TUei3EjtLG2j+rtmz
X-Google-Smtp-Source: AGHT+IHafIx1Q/o+gcv8lXxYe8zv4qDYCy+lE7q7ku/ptgvSuHNV1DRwv7swhq+N2yuts6PwX8ie6A==
X-Received: by 2002:a17:90b:4b11:b0:281:d55:6fe8 with SMTP id lx17-20020a17090b4b1100b002810d556fe8mr4416063pjb.24.1699370844108;
        Tue, 07 Nov 2023 07:27:24 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16a7:2c01:9126:36a4])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090a49c700b002808c9e3095sm7066259pjm.26.2023.11.07.07.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:27:23 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] arm64: Move Mediatek GIC quirk handling from irqchip to core
Date:   Tue,  7 Nov 2023 07:26:56 -0800
Message-ID: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 44bd78dd2b88 ("irqchip/gic-v3: Disable pseudo NMIs on
Mediatek devices w/ firmware issues") we added a method for detecting
Mediatek devices with broken firmware and disabled pseudo-NMI. While
that worked, it didn't address the problem at a deep enough level.

The fundamental issue with this broken firmware is that it's not
saving and restoring several important GICR registers. The current
list is believed to be:
* GICR_NUM_IPRIORITYR
* GICR_CTLR
* GICR_ISPENDR0
* GICR_ISACTIVER0
* GICR_NSACR

Pseudo-NMI didn't work because it was the only thing (currently) in
the kernel that relied on the broken registers, so forcing pseudo-NMI
off was an effective fix. However, it could be observed that calling
system_uses_irq_prio_masking() on these systems still returned
"true". That caused confusion and led to the need for
commit a07a59415217 ("arm64: smp: avoid NMI IPIs with broken MediaTek
FW"). It's worried that the incorrect value returned by
system_uses_irq_prio_masking() on these systems will continue to
confuse future developers.

Let's fix the issue a little more completely by disabling IRQ
priorities at a deeper level in the kernel. Once we do this we can
revert some of the other bits of code dealing with this quirk.

This includes a partial revert of commit 44bd78dd2b88
("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware
issues"). This isn't a full revert because it leaves some of the
changes to the "quirks" structure around in case future code needs it.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Just detect the quirk once at init time.
- Fixed typo in subject: s/GiC/GIC.
- Squash in ("Remove Mediatek pseudo-NMI firmware quirk handling").

 arch/arm64/kernel/cpufeature.c | 46 ++++++++++++++++++++++++++++------
 drivers/irqchip/irq-gic-v3.c   | 22 +---------------
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f6b2e2906fc9..928124ea2e96 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -999,6 +999,37 @@ static void init_32bit_cpu_features(struct cpuinfo_32bit *info)
 	init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
 }
 
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+static bool enable_pseudo_nmi;
+
+static int __init early_enable_pseudo_nmi(char *p)
+{
+	return kstrtobool(p, &enable_pseudo_nmi);
+}
+early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
+
+static __init void detect_system_supports_pseudo_nmi(void)
+{
+	struct device_node *np;
+
+	if (!enable_pseudo_nmi)
+		return;
+
+	/*
+	 * Detect broken Mediatek firmware that doesn't properly save and
+	 * restore GIC priorities.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
+	if (np && of_property_read_bool(np, "mediatek,broken-save-restore-fw")) {
+		pr_info("Pseudo-NMI disabled due to Mediatek Chromebook GICR save problem\n");
+		enable_pseudo_nmi = false;
+	}
+	of_node_put(np);
+}
+#else /* CONFIG_ARM64_PSEUDO_NMI */
+static inline void detect_system_supports_pseudo_nmi(void) { }
+#endif
+
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
 	/* Before we start using the tables, make sure it is sorted */
@@ -1057,6 +1088,13 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 */
 	init_cpucap_indirect_list();
 
+	/*
+	 * Detect broken pseudo-NMI. Must be called _before_ the call to
+	 * setup_boot_cpu_capabilities() since it interacts with
+	 * can_use_gic_priorities().
+	 */
+	detect_system_supports_pseudo_nmi();
+
 	/*
 	 * Detect and enable early CPU capabilities based on the boot CPU,
 	 * after we have initialised the CPU feature infrastructure.
@@ -2085,14 +2123,6 @@ static void cpu_enable_e0pd(struct arm64_cpu_capabilities const *cap)
 #endif /* CONFIG_ARM64_E0PD */
 
 #ifdef CONFIG_ARM64_PSEUDO_NMI
-static bool enable_pseudo_nmi;
-
-static int __init early_enable_pseudo_nmi(char *p)
-{
-	return kstrtobool(p, &enable_pseudo_nmi);
-}
-early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
-
 static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 				   int scope)
 {
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 68d11ccee441..1ba674367ee3 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -39,8 +39,7 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
-#define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
-#define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 3)
+#define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 2)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -1779,15 +1778,6 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
-static bool gic_enable_quirk_mtk_gicr(void *data)
-{
-	struct gic_chip_data *d = data;
-
-	d->flags |= FLAGS_WORKAROUND_MTK_GICR_SAVE;
-
-	return true;
-}
-
 static bool gic_enable_quirk_cavium_38539(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1888,11 +1878,6 @@ static const struct gic_quirk gic_quirks[] = {
 		.compatible = "asr,asr8601-gic-v3",
 		.init	= gic_enable_quirk_asr8601,
 	},
-	{
-		.desc	= "GICv3: Mediatek Chromebook GICR save problem",
-		.property = "mediatek,broken-save-restore-fw",
-		.init	= gic_enable_quirk_mtk_gicr,
-	},
 	{
 		.desc	= "GICv3: HIP06 erratum 161010803",
 		.iidr	= 0x0204043b,
@@ -1959,11 +1944,6 @@ static void gic_enable_nmi_support(void)
 	if (!gic_prio_masking_enabled())
 		return;
 
-	if (gic_data.flags & FLAGS_WORKAROUND_MTK_GICR_SAVE) {
-		pr_warn("Skipping NMI enable due to firmware issues\n");
-		return;
-	}
-
 	rdist_nmi_refs = kcalloc(gic_data.ppi_nr + SGI_NR,
 				 sizeof(*rdist_nmi_refs), GFP_KERNEL);
 	if (!rdist_nmi_refs)
-- 
2.42.0.869.gea05f2083d-goog

