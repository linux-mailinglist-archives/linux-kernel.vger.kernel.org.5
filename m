Return-Path: <linux-kernel+bounces-138494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335BC89F23D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569061C21163
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB6315F40D;
	Wed, 10 Apr 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cbBRxdHh"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53615F330
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752046; cv=none; b=b+qLO0r/1wZyLC31HQLEvDvm7bv7QFXCY/IiE11GpEGdQLgVhyM31v+fF9xK0/1u8FAA2kTl1n5uNMyKF+6xMCIquOxhOuWlC8Lm0P8Ywh3Ny26F3YNOVL7ExXvcy2XtHhSRfOwqIw09UuhRTrAcq5ftXcbpbYEhpH37liK/4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752046; c=relaxed/simple;
	bh=Fbb37erbt6o9FBAZisY/zSs6Y/9ORVWWdlKj8BfIVgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WON4kuogKytUYFdxriFyvvosFTHByaq5phn18NxPJa4aPwwe7669qeoaIWAd8EPbQHsDcq16GZa7Cm/qzROhvOdeiQC6qGjLfj9nrTrpd8+eYlDTlTlnUFUmIn4SmixnAZkL0W4QA8w4IgXeB4P7jHybwl+f6O/uxR/+/kKpEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cbBRxdHh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-416a208d496so13158935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712752043; x=1713356843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klnbeJmhe/ss/+rAur1j3pibXzpubUbesCFy0b7qat4=;
        b=cbBRxdHhURzRVAwycrpbpS4J8pI6/mvG80zt3HVDhwP9Q+rWob2hA6BTMW8BP59dD2
         pVH6cidny5ElOyMgBV7oxwxswb2oXG6ySiNEMYbkGWRSNP4hlgMCEukCHtqykvUzXhCa
         2pLaFNkvckm9UWgkz68pGkPmtK9Zab0vrpN9UlMToyTDwjklk2a8Mj88MyI4x6GzctCf
         KwJ8kUR7If8UufVpzK8g59dODJcxs+BsJLXICbMm03V1CExY/j5ShMiXXDiSMH5+u4tN
         zSoy4KZnMGZm1foNgs/E4Lhgec/8KbMPBFEsblX9Oe7a2UBo8iptyItUQxoT1xOOTTBa
         DDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712752043; x=1713356843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klnbeJmhe/ss/+rAur1j3pibXzpubUbesCFy0b7qat4=;
        b=XvKhTuh9uG3b4GvVZ3kHcM/z5VHdGTX0ogSWYLcQ/ZDEvnVk1z7/UEI1L+nrUhJ4nc
         N4p6gSIqDHzh4K3pzjCM529tojbIukHiuCOuiB5Kr8j1hw5zwTEDAa/mOdKsyJdSwiWb
         KkxhfkRNcCpM+XcE39Pj2po8JAsdf1RufGE7kNScB99Ip+mb+p4tsOs54BFl1QrpYJWM
         1WF0zRs6lL1P9XTVP35Zf15SNpV8etEcmGrrmwY3KgtuWIAgSym2iT7kZki0GdeZaSuS
         2S7kQHFGBOLCOJam3cXT6j1VbKM21urcZbew1DRvzXroLRUrtBfC3B+Z12K7iRDakO89
         m7LA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Z8gMoTAqTJr6gi0U/z08c7QrLYCYklWsNB9YWJqBtJv8rc2yc+JnLsIL0PMI2fELBXFxo8qGj2K1x2BqHyRa70TILaZZcErIV2bU
X-Gm-Message-State: AOJu0Yz+d7bCezwXX4uf7GSgvF56kLFjwnwceQPLXimQujMGm5EGC+Nl
	x1FtqjzYdzC1Sk2ZjBjBlqKuxsvbdNVMa8PFM1bf5cQ2aZwukhAU28YR4ua9ORE=
X-Google-Smtp-Source: AGHT+IH1NKj/98RBwKSu1SCx1c/VGaNf8n2X2r4ZccgnQyON5LoYxu7bSTY0KpzihZ1hLvt2nPbz8w==
X-Received: by 2002:a05:600c:5012:b0:415:540e:760d with SMTP id n18-20020a05600c501200b00415540e760dmr1819137wmr.5.1712752043495;
        Wed, 10 Apr 2024 05:27:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b004171f151a5csm1679446wms.16.2024.04.10.05.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:27:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 8/9] clk: renesas: rzg2l-cpg: Add suspend/resume support for power domains
Date: Wed, 10 Apr 2024 15:26:56 +0300
Message-Id: <20240410122657.2051132-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/G3S supports deep sleep states that it can reach with the help of the
TF-A.

RZ/G3S has a few power domains (e.g. GIC) that need to be always-on while
Linux is running. These domains are initialized (and powered on) when
clock driver is probed.

As the TF-A takes control at the very last(suspend)/first(resume)
phase of configuring the deep sleep state, it can do it's own settings on
power domains.

Thus, to restore the proper Linux state, add rzg2l_cpg_resume() which
powers on the always-on domains and rzg2l_cpg_complete() which activates
the power down mode for the IPs selected through CPG_PWRDN_IP{1, 2}.

Along with it, added the suspend_check member to the RZ/G2L power domain
data structure whose purpose is to checks if a domain can be powered off
while the system is going to suspend. This is necessary for the serial
console domain which needs to be powered on if no_console_suspend is
available in bootargs.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- populate pd->suspend_check on rzg2l_cpg_attach_dev() for serial
  console; due to this the rzg2l_pd_suspend_check_console() was moved
  before rzg2l_cpg_attach_dev()
- removed RZG2L_PD_F_CONSOLE define

Changes in v2:
- none; this patch is new

 drivers/clk/renesas/rzg2l-cpg.c | 68 ++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index b36700f4a9f5..baf08a8cc3f0 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
+#include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -139,6 +140,7 @@ struct rzg2l_pll5_mux_dsi_div_param {
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  * @info: Pointer to platform data
+ * @domains: generic PM domains
  * @mux_dsi_div_params: pll5 mux and dsi div parameters
  */
 struct rzg2l_cpg_priv {
@@ -155,6 +157,8 @@ struct rzg2l_cpg_priv {
 
 	const struct rzg2l_cpg_info *info;
 
+	struct generic_pm_domain **domains;
+
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };
 
@@ -1570,16 +1574,23 @@ struct rzg2l_cpg_pm_domains {
  * struct rzg2l_cpg_pd - RZ/G2L power domain data structure
  * @genpd: generic PM domain
  * @priv: pointer to CPG private data structure
+ * @suspend_check: check if domain could be powered off in suspend
  * @conf: CPG PM domain configuration info
  * @id: RZ/G2L power domain ID
  */
 struct rzg2l_cpg_pd {
 	struct generic_pm_domain genpd;
 	struct rzg2l_cpg_priv *priv;
+	int (*suspend_check)(void);
 	struct rzg2l_cpg_pm_domain_conf conf;
 	u16 id;
 };
 
+static int rzg2l_pd_suspend_check_console(void)
+{
+	return console_suspend_enabled ? 0 : -EBUSY;
+}
+
 static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device *dev)
 {
 	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
@@ -1615,6 +1626,10 @@ static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device
 					error);
 				goto fail_put;
 			}
+
+			/* Add suspend check for console. */
+			if (np == of_stdout)
+				pd->suspend_check = rzg2l_pd_suspend_check_console;
 		} else {
 			of_node_put(clkspec.np);
 		}
@@ -1676,6 +1691,13 @@ static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
 	struct rzg2l_cpg_reg_conf pwrdn = pd->conf.pwrdn;
 	struct rzg2l_cpg_priv *priv = pd->priv;
 
+	if (pd->suspend_check) {
+		int ret = pd->suspend_check();
+
+		if (ret)
+			return ret;
+	}
+
 	/* Set MSTOP. */
 	if (mstop.mask)
 		writel(mstop.mask | (mstop.mask << 16), priv->base + mstop.off);
@@ -1687,8 +1709,9 @@ static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
 	return 0;
 }
 
-static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
+static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, u32 flags)
 {
+	bool always_on = !!(flags & RZG2L_PD_F_ALWAYS_ON);
 	struct dev_power_governor *governor;
 
 	pd->genpd.flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
@@ -1719,7 +1742,7 @@ static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
 
 	pd->genpd.name = np->name;
 	pd->priv = priv;
-	ret = rzg2l_cpg_pd_setup(pd, true);
+	ret = rzg2l_cpg_pd_setup(pd, RZG2L_PD_F_ALWAYS_ON);
 	if (ret)
 		return ret;
 
@@ -1778,13 +1801,13 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
 	domains->onecell_data.domains = domains->domains;
 	domains->onecell_data.num_domains = info->num_pm_domains;
 	domains->onecell_data.xlate = rzg2l_cpg_pm_domain_xlate;
+	priv->domains = domains->domains;
 
 	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, &domains->onecell_data);
 	if (ret)
 		return ret;
 
 	for (unsigned int i = 0; i < info->num_pm_domains; i++) {
-		bool always_on = !!(info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON);
 		struct rzg2l_cpg_pd *pd;
 
 		pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
@@ -1796,11 +1819,11 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
 		pd->id = info->pm_domains[i].id;
 		pd->priv = priv;
 
-		ret = rzg2l_cpg_pd_setup(pd, always_on);
+		ret = rzg2l_cpg_pd_setup(pd, info->pm_domains[i].flags);
 		if (ret)
 			return ret;
 
-		if (always_on) {
+		if (info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON) {
 			ret = rzg2l_cpg_power_on(&pd->genpd);
 			if (ret)
 				return ret;
@@ -1890,9 +1913,43 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	dev_set_drvdata(dev, priv);
+
+	return 0;
+}
+
+static int rzg2l_cpg_resume(struct device *dev)
+{
+	struct rzg2l_cpg_priv *priv = dev_get_drvdata(dev);
+	const struct rzg2l_cpg_info *info = priv->info;
+
+	/* Power on always ON domains. */
+	for (unsigned int i = 0; i < info->num_pm_domains; i++) {
+		if (info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON) {
+			int ret = rzg2l_cpg_power_on(priv->domains[i]);
+
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
+static void rzg2l_cpg_complete(struct device *dev)
+{
+	struct rzg2l_cpg_priv *priv = dev_get_drvdata(dev);
+
+	/* Prepare for power down the BUSes in power down mode. */
+	if (priv->info->pm_domain_pwrdn_mstop)
+		writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MSTOP);
+}
+
+static const struct dev_pm_ops rzg2l_cpg_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, rzg2l_cpg_resume)
+	.complete = rzg2l_cpg_complete,
+};
+
 static const struct of_device_id rzg2l_cpg_match[] = {
 #ifdef CONFIG_CLK_R9A07G043
 	{
@@ -1931,6 +1988,7 @@ static struct platform_driver rzg2l_cpg_driver = {
 	.driver		= {
 		.name	= "rzg2l-cpg",
 		.of_match_table = rzg2l_cpg_match,
+		.pm	= pm_sleep_ptr(&rzg2l_cpg_pm_ops),
 	},
 };
 
-- 
2.39.2


