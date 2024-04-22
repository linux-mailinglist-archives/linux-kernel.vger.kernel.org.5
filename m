Return-Path: <linux-kernel+bounces-153247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B748ACB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA31283C53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72814EC7F;
	Mon, 22 Apr 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BmVLUBkE"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456F14EC69
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783255; cv=none; b=N7VYAnLJOPcl314BTZQ9lmQM4hCl4gZGZiqgXg4LRNpF1uNwxnH9ZM50n/iXyD/NFBT4adm6bHLnkKCULe21/KN2oJ/RT1LGS5YTPQqjytQ9AAST8CiYGbkt2uJfaGWiQn7HnvBM7iIagGNJkBqcBQ7b+M3h1OePqZ5oFT+RnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783255; c=relaxed/simple;
	bh=UeipTPQfxZcyVz6WZs6qIK/wXFSLrBCbDAqvBu/wJrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3RHTQBIS1hEGWb8ZVsvT93MBvlG9DWXjN7KK8/wY9pjO6Ll+fwQcMqghqc35intRl4SxDT7bruiWL5zptEc97a9yjk9ku0aqZ+R9IxEW9CWNsPAR7BlZMmpXlRWphRLELYCZODhz4hqvIoBn/lNMg0ENBe8Go0QQRar9+2w+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BmVLUBkE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41a55be31eeso6111355e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713783251; x=1714388051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arj/N1skZQ+Mci7A32xTTOverIinR2Ho91O7tfvBIdc=;
        b=BmVLUBkE0xUThDC1Beyn83ppU7fE22stCkgXM5O7raqLAuOzOd5b/MwmCnVE7B40BP
         8bk1NgmZpYr6lUKAodup5CaukWUyd4wf4LC0asaWUHdc/uAiXMlHmXDDrjziaB8aTu+R
         cGEEnw4bbwNoyUzpY616uPNHBW7al9im2ACyJlUZk3LxQkmHb6sq5gkf8dsrHaAA2sK3
         jJDQf2lFBaANd1mV+4mQhvRl67WdGJa6wJZya9ozjfTXNszROGrBkweM2xmMdL4WvLyE
         kdYIQ9kbYXK2HA+EA//BmtyvWWWiRZ9nOK1UA6vfyzbAfotWtOOqjr+JRxoNUnrKn3T9
         znXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783251; x=1714388051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arj/N1skZQ+Mci7A32xTTOverIinR2Ho91O7tfvBIdc=;
        b=QGljcrP8grVTD02Lc/kshKPtYejOOF3Ano0Wiahw08ZSAZc0VLxAwexvZLzSF2RqNq
         OGH2F5qUomJFgdqHMLUdSu/maVimRrDC+dPYrbotB8AXI+epR8hqQ+Tsn2rxYEjzCbPl
         4Bh8skKyzOtYDdJyS8kzAZQpvU/Q8UJ5ViD1pPqcRMX+J5Y+UsF6snEnws9NVySFWRme
         vw7sKTajl/uVkYA+InqpcMZpezT8TzqDXc/G5etiLZyqPqmlpyDNr+BeZR2bu3mHJRXe
         gcbGsA3VqTe4NKJRTURwaU0amk/rG3T/EziHieA893WmXaFrqqlnJ/24g3e4P9nOxYZq
         pdLA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NuMhWxsyR/P39ZztAVFHQ4C9UVb3RY7AdY0Rqb2q5OKc6N5MXZqNrKSToSO7njEXAv0HQGSXT4pKHIcNcy/7qsaFRI53bt3+ao9p
X-Gm-Message-State: AOJu0YylIvHT8hiva7BYsGifdbLG0gX8IN8RC5d3oYyHy1M6goQWVkI4
	f0SeRhP1kxUEUf9mOnYCWvR+asKrYE4++eneB5bVfChzXRArBQZhlS59E3K2IEc=
X-Google-Smtp-Source: AGHT+IGH12ifHAtZ9arczl0FJzuvKuFpAd12aJXuD5o0I19naBmFqdGJOF0kGfJ9LFGU6GRVBlZbRQ==
X-Received: by 2002:a05:600c:4748:b0:41a:6edd:47ed with SMTP id w8-20020a05600c474800b0041a6edd47edmr1489578wmo.4.1713783250986;
        Mon, 22 Apr 2024 03:54:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041a3f700ccesm4321037wmn.40.2024.04.22.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:54:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 6/8] clk: renesas: rzg2l: Extend power domain support
Date: Mon, 22 Apr 2024 13:53:53 +0300
Message-Id: <20240422105355.1622177-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/{G2L, V2L, G3S}-based CPG versions have support for saving extra
power when clocks are disabled by activating module standby. This is done
through MSTOP-specific registers that are part of CPG. Each individual
module has one or more bits associated with one MSTOP register (see table
"Registers for Module Standby Mode" from HW manuals). Hardware manual
associates modules' clocks with one or more MSTOP bits. There are 3
mappings available (identified by researching RZ/G2L, RZ/G3S, RZ/V2L HW
manuals):

case 1: N clocks mapped to N MSTOP bits (with N={0, ..., X})
case 2: N clocks mapped to 1 MSTOP bit  (with N={0, ..., X})
case 3: N clocks mapped to M MSTOP bits (with N={0, ..., X}, M={0, ..., Y})

Case 3 has been currently identified on RZ/V2L for the VCPL4 module.

To cover all three cases, the individual platform drivers will provide to
clock driver MSTOP register offset and associated bits in this register
as a bitmask and the clock driver will apply this bitmask to proper
MSTOP register.

The MSTOP was implemented through power domains. Platform-specific clock
drivers will register an array of type
struct rzg2l_cpg_pm_domain_init_data, which will be used to instantiate
properly the power domains.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- dropped the pwrdn functionality until it is better understanded;
  at the same time kept the code ready for pwrd being added by keeping
  struct rzg2l_cpg_pm_domain_conf, DEF_REG_CONF(); please let me know
  if you prefer otherwise
- @Geert, @Ulf: I dropped your previous Rb tags due to dropping pwrdn

Changes in v3:
- collected tags

Changes in v2:
- called pm_genpd_init() with proper value for is_off argument
- fixed typos
- used flexible array for struct rzg2l_cpg_pm_domains::domains member
- moved genpd member of struct rzg2l_cpg_pd at the beginning of struct
- didn't initialize the parent variable in rzg2l_cpg_add_pm_domains()
  as it is already initialized in the for block from
  rzg2l_cpg_add_pm_domains() and that initialization should be enough
- dropped RZG2L_PD_F_PARENT flag
- used datasheet naming for all MSTOP registers
- added all MSTOP registers to rzg2l-cpg.h
- reworked the code that initializes the register offset and bits for domains
- dropped MSTOP*(), PWRDN*() macros and introduced struct rzg2l_cpg_reg_conf
  and DEF_REG_CONF() for domain description
- constified the 1st argument of rzg2l_cpg_pm_domain_xlate()
- used dev instead of priv->dev where possible
- dropped RZG2L_PD_F_PARENT
- added RZG2L_PD_F_NONE for better description of domains in platform
  specific clock drivers

 drivers/clk/renesas/rzg2l-cpg.c | 199 +++++++++++++++++++++++++++++---
 drivers/clk/renesas/rzg2l-cpg.h |  67 +++++++++++
 2 files changed, 252 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3d2daa4ba2a4..04b78064d4e0 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -139,7 +139,6 @@ struct rzg2l_pll5_mux_dsi_div_param {
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  * @info: Pointer to platform data
- * @genpd: PM domain
  * @mux_dsi_div_params: pll5 mux and dsi div parameters
  */
 struct rzg2l_cpg_priv {
@@ -156,8 +155,6 @@ struct rzg2l_cpg_priv {
 
 	const struct rzg2l_cpg_info *info;
 
-	struct generic_pm_domain genpd;
-
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };
 
@@ -1559,9 +1556,34 @@ static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cpg_priv *priv,
 	return true;
 }
 
+/**
+ * struct rzg2l_cpg_pm_domains - RZ/G2L PM domains data structure
+ * @onecell_data: cell data
+ * @domains: generic PM domains
+ */
+struct rzg2l_cpg_pm_domains {
+	struct genpd_onecell_data onecell_data;
+	struct generic_pm_domain *domains[];
+};
+
+/**
+ * struct rzg2l_cpg_pd - RZ/G2L power domain data structure
+ * @genpd: generic PM domain
+ * @priv: pointer to CPG private data structure
+ * @conf: CPG PM domain configuration info
+ * @id: RZ/G2L power domain ID
+ */
+struct rzg2l_cpg_pd {
+	struct generic_pm_domain genpd;
+	struct rzg2l_cpg_priv *priv;
+	struct rzg2l_cpg_pm_domain_conf conf;
+	u16 id;
+};
+
 static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device *dev)
 {
-	struct rzg2l_cpg_priv *priv = container_of(domain, struct rzg2l_cpg_priv, genpd);
+	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
+	struct rzg2l_cpg_priv *priv = pd->priv;
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args clkspec;
 	bool once = true;
@@ -1617,31 +1639,180 @@ static void rzg2l_cpg_detach_dev(struct generic_pm_domain *unused, struct device
 }
 
 static void rzg2l_cpg_genpd_remove(void *data)
+{
+	struct genpd_onecell_data *celldata = data;
+
+	for (unsigned int i = 0; i < celldata->num_domains; i++)
+		pm_genpd_remove(celldata->domains[i]);
+}
+
+static void rzg2l_cpg_genpd_remove_simple(void *data)
 {
 	pm_genpd_remove(data);
 }
 
+static int rzg2l_cpg_power_on(struct generic_pm_domain *domain)
+{
+	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
+	struct rzg2l_cpg_reg_conf mstop = pd->conf.mstop;
+	struct rzg2l_cpg_priv *priv = pd->priv;
+
+	/* Set MSTOP. */
+	if (mstop.mask)
+		writel(mstop.mask << 16, priv->base + mstop.off);
+
+	return 0;
+}
+
+static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
+{
+	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
+	struct rzg2l_cpg_reg_conf mstop = pd->conf.mstop;
+	struct rzg2l_cpg_priv *priv = pd->priv;
+
+	/* Set MSTOP. */
+	if (mstop.mask)
+		writel(mstop.mask | (mstop.mask << 16), priv->base + mstop.off);
+
+	return 0;
+}
+
+static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
+{
+	struct dev_power_governor *governor;
+
+	pd->genpd.flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
+	pd->genpd.attach_dev = rzg2l_cpg_attach_dev;
+	pd->genpd.detach_dev = rzg2l_cpg_detach_dev;
+	if (always_on) {
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
+		governor = &pm_domain_always_on_gov;
+	} else {
+		pd->genpd.power_on = rzg2l_cpg_power_on;
+		pd->genpd.power_off = rzg2l_cpg_power_off;
+		governor = &simple_qos_governor;
+	}
+
+	return pm_genpd_init(&pd->genpd, governor, !always_on);
+}
+
 static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
 {
 	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
-	struct generic_pm_domain *genpd = &priv->genpd;
+	struct rzg2l_cpg_pd *pd;
+	int ret;
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->genpd.name = np->name;
+	pd->priv = priv;
+	ret = rzg2l_cpg_pd_setup(pd, true);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove_simple, &pd->genpd);
+	if (ret)
+		return ret;
+
+	return of_genpd_add_provider_simple(np, &pd->genpd);
+}
+
+static struct generic_pm_domain *
+rzg2l_cpg_pm_domain_xlate(const struct of_phandle_args *spec, void *data)
+{
+	struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
+	struct genpd_onecell_data *genpd = data;
+
+	if (spec->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	for (unsigned int i = 0; i < genpd->num_domains; i++) {
+		struct rzg2l_cpg_pd *pd = container_of(genpd->domains[i], struct rzg2l_cpg_pd,
+						       genpd);
+
+		if (pd->id == spec->args[0]) {
+			domain = &pd->genpd;
+			break;
+		}
+	}
+
+	return domain;
+}
+
+static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
+{
+	const struct rzg2l_cpg_info *info = priv->info;
+	struct device *dev = priv->dev;
+	struct device_node *np = dev->of_node;
+	struct rzg2l_cpg_pm_domains *domains;
+	struct generic_pm_domain *parent;
+	u32 ncells;
 	int ret;
 
-	genpd->name = np->name;
-	genpd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ALWAYS_ON |
-		       GENPD_FLAG_ACTIVE_WAKEUP;
-	genpd->attach_dev = rzg2l_cpg_attach_dev;
-	genpd->detach_dev = rzg2l_cpg_detach_dev;
-	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
+	ret = of_property_read_u32(np, "#power-domain-cells", &ncells);
+	if (ret)
+		return ret;
+
+	/* For backward compatibility. */
+	if (!ncells)
+		return rzg2l_cpg_add_clk_domain(priv);
+
+	domains = devm_kzalloc(dev, struct_size(domains, domains, info->num_pm_domains),
+			       GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	domains->onecell_data.domains = domains->domains;
+	domains->onecell_data.num_domains = info->num_pm_domains;
+	domains->onecell_data.xlate = rzg2l_cpg_pm_domain_xlate;
+
+	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, &domains->onecell_data);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, genpd);
+	for (unsigned int i = 0; i < info->num_pm_domains; i++) {
+		bool always_on = !!(info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON);
+		struct rzg2l_cpg_pd *pd;
+
+		pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+		if (!pd)
+			return -ENOMEM;
+
+		pd->genpd.name = info->pm_domains[i].name;
+		pd->conf = info->pm_domains[i].conf;
+		pd->id = info->pm_domains[i].id;
+		pd->priv = priv;
+
+		ret = rzg2l_cpg_pd_setup(pd, always_on);
+		if (ret)
+			return ret;
+
+		if (always_on) {
+			ret = rzg2l_cpg_power_on(&pd->genpd);
+			if (ret)
+				return ret;
+		}
+
+		domains->domains[i] = &pd->genpd;
+		/* Parent should be on the very first entry of info->pm_domains[]. */
+		if (!i) {
+			parent = &pd->genpd;
+			continue;
+		}
+
+		ret = pm_genpd_add_subdomain(parent, &pd->genpd);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_genpd_add_provider_onecell(np, &domains->onecell_data);
 	if (ret)
 		return ret;
 
-	return of_genpd_add_provider_simple(np, genpd);
+	return 0;
 }
 
 static int __init rzg2l_cpg_probe(struct platform_device *pdev)
@@ -1697,7 +1868,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = rzg2l_cpg_add_clk_domain(priv);
+	error = rzg2l_cpg_add_pm_domains(priv);
 	if (error)
 		return error;
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 6e38c8fc888c..ecfe7e7ea8a1 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -27,6 +27,18 @@
 #define CPG_PL6_ETH_SSEL	(0x418)
 #define CPG_PL5_SDIV		(0x420)
 #define CPG_RST_MON		(0x680)
+#define CPG_BUS_ACPU_MSTOP	(0xB60)
+#define CPG_BUS_MCPU1_MSTOP	(0xB64)
+#define CPG_BUS_MCPU2_MSTOP	(0xB68)
+#define CPG_BUS_PERI_COM_MSTOP	(0xB6C)
+#define CPG_BUS_PERI_CPU_MSTOP	(0xB70)
+#define CPG_BUS_PERI_DDR_MSTOP	(0xB74)
+#define CPG_BUS_REG0_MSTOP	(0xB7C)
+#define CPG_BUS_REG1_MSTOP	(0xB80)
+#define CPG_BUS_TZCDDR_MSTOP	(0xB84)
+#define CPG_MHU_MSTOP		(0xB88)
+#define CPG_BUS_MCPU3_MSTOP	(0xB90)
+#define CPG_BUS_PERI_CPU2_MSTOP	(0xB94)
 #define CPG_OTHERFUNC1_REG	(0xBE8)
 
 #define CPG_SIPLL5_STBY_RESETB		BIT(0)
@@ -234,6 +246,55 @@ struct rzg2l_reset {
 #define DEF_RST(_id, _off, _bit)	\
 	DEF_RST_MON(_id, _off, _bit, -1)
 
+/**
+ * struct rzg2l_cpg_reg_conf - RZ/G2L register configuration data structure
+ * @off: register offset
+ * @mask: register mask
+ */
+struct rzg2l_cpg_reg_conf {
+	u16 off;
+	u16 mask;
+};
+
+#define DEF_REG_CONF(_off, _mask) ((struct rzg2l_cpg_reg_conf) { .off = (_off), .mask = (_mask) })
+
+/**
+ * struct rzg2l_cpg_pm_domain_conf - PM domain configuration data structure
+ * @mstop: MSTOP register configuration
+ */
+struct rzg2l_cpg_pm_domain_conf {
+	struct rzg2l_cpg_reg_conf mstop;
+};
+
+/**
+ * struct rzg2l_cpg_pm_domain_init_data - PM domain init data
+ * @name: PM domain name
+ * @conf: PM domain configuration
+ * @flags: RZG2L PM domain flags (see RZG2L_PD_F_*)
+ * @id: PM domain ID (similar to the ones defined in
+ *      include/dt-bindings/clock/<soc-id>-cpg.h)
+ */
+struct rzg2l_cpg_pm_domain_init_data {
+	const char * const name;
+	struct rzg2l_cpg_pm_domain_conf conf;
+	u32 flags;
+	u16 id;
+};
+
+#define DEF_PD(_name, _id, _mstop_conf, _flags) \
+	{ \
+		.name = (_name), \
+		.id = (_id), \
+		.conf = { \
+			.mstop = (_mstop_conf), \
+		}, \
+		.flags = (_flags), \
+	}
+
+/* Power domain flags. */
+#define RZG2L_PD_F_ALWAYS_ON	BIT(0)
+#define RZG2L_PD_F_NONE		(0)
+
 /**
  * struct rzg2l_cpg_info - SoC-specific CPG Description
  *
@@ -252,6 +313,8 @@ struct rzg2l_reset {
  * @crit_mod_clks: Array with Module Clock IDs of critical clocks that
  *                 should not be disabled without a knowledgeable driver
  * @num_crit_mod_clks: Number of entries in crit_mod_clks[]
+ * @pm_domains: PM domains init data array
+ * @num_pm_domains: Number of PM domains
  * @has_clk_mon_regs: Flag indicating whether the SoC has CLK_MON registers
  */
 struct rzg2l_cpg_info {
@@ -278,6 +341,10 @@ struct rzg2l_cpg_info {
 	const unsigned int *crit_mod_clks;
 	unsigned int num_crit_mod_clks;
 
+	/* Power domain. */
+	const struct rzg2l_cpg_pm_domain_init_data *pm_domains;
+	unsigned int num_pm_domains;
+
 	bool has_clk_mon_regs;
 };
 
-- 
2.39.2


