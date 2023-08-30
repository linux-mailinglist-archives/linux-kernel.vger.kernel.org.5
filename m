Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AECF78DEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjH3Tys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241094AbjH3Ty1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 15:54:27 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279876A4C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:23:13 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4107e6fb0e8so281451cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693423297; x=1694028097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfL7hyBseirw2ULKrzVmWf2hUa/6+UsGULqRK6gzzdQ=;
        b=Zm+uAGzPvbJsEEp700xFergIXBX4V6oBP94hDbrVJma8sHqtVujJRdmr7eujAmlV8d
         zeu4sOHErQXpdNNCizii1TboCHnTcesPNP6jFxeFvykF3ynHOwoBWd/1N9ShnWC0m5IZ
         gsC+fzfRjz4TYhWgbniPQ32tgngiel/xVZ5HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423297; x=1694028097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfL7hyBseirw2ULKrzVmWf2hUa/6+UsGULqRK6gzzdQ=;
        b=f7Q9CxnKjKzTHmbAVPh2qodEDgqJAl4YMZKX8+skeGBrfwNAogU8C+sAe7msM2BJHy
         U53VQbcOtQ2oK4FP3mhS425L3w22NExd7NEa5GlUh8UDzdnwsXya6dlAm9QRMscllzra
         XHXo7qx8c+OARTipNqBhR1BBBRz1v90y7HAX0q9fU1cMLq5xI60Rrwjb1nNdA/ZPbJ8g
         TDjkvZvqSOMY4/3ieYYzIwGyewjLIuib+p6A72Rj5mafRcv7iXDA7vCdYUnfsQyBiJx9
         s1v+p0eu1x1m3NHqEp1eiiPnkVbXF6xenl0mBGh0UxfAoXS0xcWrxPyK18z/3oxDdo3a
         llGA==
X-Gm-Message-State: AOJu0YwY/UrouDWvUNcFpJ/4sZtxIgBCP27YXfxusNlo9EWJutpYnVv/
        u4XrJVvvHblkgCY/MVX3a9zXphG5iPzGdowv8uG39+pI
X-Google-Smtp-Source: AGHT+IGsRVBhxDwcrTroEG3U48LgMw7Y7iXGf6tvH99XoYoezCk7L0nZpJx4PQuaXGFWu2v93kvrxQ==
X-Received: by 2002:a05:6a21:35c8:b0:14d:8dbe:1960 with SMTP id ba8-20020a056a2135c800b0014d8dbe1960mr2942041pzc.55.1693422817689;
        Wed, 30 Aug 2023 12:13:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e315:dec6:467c:83c5])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001bbdf32f011sm11338928plg.269.2023.08.30.12.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:13:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/7] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Wed, 30 Aug 2023 12:11:22 -0700
Message-ID: <20230830121115.v12.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830191314.1618136-1-dianders@chromium.org>
References: <20230830191314.1618136-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 6abbd6988971 ("irqchip/gic, gic-v3: Make SGIs use
handle_percpu_devid_irq()") SGIs are treated the same as PPIs/EPPIs
and use handle_percpu_devid_irq() by default. Unfortunately,
handle_percpu_devid_irq() isn't NMI safe, and so to run in an NMI
context those should use handle_percpu_devid_fasteoi_nmi().

In order to accomplish this, we just have to make room for SGIs in the
array of refcounts that keeps track of which interrupts are set as
NMI. We also rename the array and create a new indexing scheme that
accounts for SGIs.

Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
as IRQs/NMIs happen as part of this routine.

Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'll note that this change is a little more black magic to me than
others in this series. I don't have a massive amounts of familiarity
with all the moving parts of gic-v3, so I mostly just followed Mark
Rutland's advice [1]. Please pay extra attention to make sure I didn't
do anything too terrible.

Mark's advice wasn't a full patch and I ended up doing a bit of work
to translate it to reality, so I did not add him as "Co-developed-by"
here. Mark: if you would like this tag then please provide it and your
Signed-off-by. I certainly won't object.

[1] https://lore.kernel.org/r/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.arm.com

Changes in v12:
- Added a comment about why we account for 16 SGIs when Linux uses 8.

Changes in v10:
- Rewrite as needed for 5.11+ as per Mark Rutland and Sumit.

 drivers/irqchip/irq-gic-v3.c | 59 +++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index eedfa8e9f077..8d20122ba0a8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -78,6 +78,13 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 #define GIC_LINE_NR	min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
 #define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
 
+/*
+ * There are 16 SGIs, though we only actually use 8 in Linux. The other 8 SGIs
+ * are potentially stolen by the secure side. Some code, especially code dealing
+ * with hwirq IDs, is simplified by accounting for all 16.
+ */
+#define SGI_NR		16
+
 /*
  * The behaviours of RPR and PMR registers differ depending on the value of
  * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
@@ -125,8 +132,8 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
 		__priority;						\
 	})
 
-/* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
-static refcount_t *ppi_nmi_refs;
+/* rdist_nmi_refs[n] == number of cpus having the rdist interrupt n set as NMI */
+static refcount_t *rdist_nmi_refs;
 
 static struct gic_kvm_info gic_v3_kvm_info __initdata;
 static DEFINE_PER_CPU(bool, has_rss);
@@ -519,9 +526,22 @@ static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
 	}
 }
 
-static u32 gic_get_ppi_index(struct irq_data *d)
+static u32 __gic_get_rdist_idx(irq_hw_number_t hwirq)
+{
+	switch (__get_intid_range(hwirq)) {
+	case SGI_RANGE:
+	case PPI_RANGE:
+		return hwirq;
+	case EPPI_RANGE:
+		return hwirq - EPPI_BASE_INTID + 32;
+	default:
+		unreachable();
+	}
+}
+
+static u32 gic_get_rdist_idx(struct irq_data *d)
 {
-	return __gic_get_ppi_index(d->hwirq);
+	return __gic_get_rdist_idx(d->hwirq);
 }
 
 static int gic_irq_nmi_setup(struct irq_data *d)
@@ -545,11 +565,14 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_ppi_index(d);
+		u32 idx = gic_get_rdist_idx(d);
 
-		/* Setting up PPI as NMI, only switch handler for first NMI */
-		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
-			refcount_set(&ppi_nmi_refs[idx], 1);
+		/*
+		 * Setting up a percpu interrupt as NMI, only switch handler
+		 * for first NMI
+		 */
+		if (!refcount_inc_not_zero(&rdist_nmi_refs[idx])) {
+			refcount_set(&rdist_nmi_refs[idx], 1);
 			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
 		}
 	} else {
@@ -582,10 +605,10 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_ppi_index(d);
+		u32 idx = gic_get_rdist_idx(d);
 
 		/* Tearing down NMI, only switch handler for last NMI */
-		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
+		if (refcount_dec_and_test(&rdist_nmi_refs[idx]))
 			desc->handle_irq = handle_percpu_devid_irq;
 	} else {
 		desc->handle_irq = handle_fasteoi_irq;
@@ -1279,10 +1302,10 @@ static void gic_cpu_init(void)
 	rbase = gic_data_rdist_sgi_base();
 
 	/* Configure SGIs/PPIs as non-secure Group-1 */
-	for (i = 0; i < gic_data.ppi_nr + 16; i += 32)
+	for (i = 0; i < gic_data.ppi_nr + SGI_NR; i += 32)
 		writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
 
-	gic_cpu_config(rbase, gic_data.ppi_nr + 16, gic_redist_wait_for_rwp);
+	gic_cpu_config(rbase, gic_data.ppi_nr + SGI_NR, gic_redist_wait_for_rwp);
 
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
@@ -1939,12 +1962,13 @@ static void gic_enable_nmi_support(void)
 		return;
 	}
 
-	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
-	if (!ppi_nmi_refs)
+	rdist_nmi_refs = kcalloc(gic_data.ppi_nr + SGI_NR,
+				 sizeof(*rdist_nmi_refs), GFP_KERNEL);
+	if (!rdist_nmi_refs)
 		return;
 
-	for (i = 0; i < gic_data.ppi_nr; i++)
-		refcount_set(&ppi_nmi_refs[i], 0);
+	for (i = 0; i < gic_data.ppi_nr + SGI_NR; i++)
+		refcount_set(&rdist_nmi_refs[i], 0);
 
 	pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
 		gic_has_relaxed_pmr_sync() ? "relaxed" : "forced");
@@ -2061,6 +2085,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -2073,8 +2098,6 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
2.42.0.283.g2d96d420d3-goog

