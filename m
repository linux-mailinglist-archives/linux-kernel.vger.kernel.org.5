Return-Path: <linux-kernel+bounces-42152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 800BD83FD1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005D51F22980
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D4F12B75;
	Mon, 29 Jan 2024 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKAK3aGZ"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9011734
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706501124; cv=none; b=BfXZSWULdEa+jdPZTuJyF97MNVeDpo+PPwutdiLLufUlZtoCC6Y6ZUYcodA3MxMkJEbRkP4GDgpFygi9IHC/qDz/K4GwQqZBaLIqZRa/r4vtalRY6FJU80Bl0SwRSfwBfiC2vfpJF0CG+u6GqwKFb78UdJMY3T/h3qoq2lhP2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706501124; c=relaxed/simple;
	bh=Mtqy0Ct1I+M9MVr+uPohc1YBnmJ3smhHCLq+6FeeAiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6RtG9U5dcWQHYX60nPS59R9ZLMtpaRmeCQhslftkoxxxdKLahITOowWbxgpkpBDWjzwdCPmvy4Sx/JL1I9jjN+bfERBaWjs7Akovw+TXJhBtzY5ERbvo8AbjZE7GXSSCYjccUWYiYjkEc3EL08Et6KFJ3Ft7awBg7N/ML1fY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKAK3aGZ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc223f3dd5eso2371901276.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706501121; x=1707105921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftMJ+6t5uKSVupkC2mB/MwofcBBs65/nrsC9Z7jssek=;
        b=UKAK3aGZYwVqmJGIyE524jLc25mL129Q2G8Vgdj7JuEO2ZEeXJZ+FaDKVoDIVgbNy8
         M6IPVajyD26QZKdGv9lyY23uxmdNhl605j8QfqE3qbqE/kl9cfxOKPQYVnGVWDPOpnks
         CEYT+MzBM2q99mWJCkkohNm7OWsI4wRSYznJvx9HgvNEV/lCpEkSR/E20060Dta1DjsL
         CTkSxFz7Mjzox57rVQlmOWN53n4vOAVaBxQtrWQhhh80T8Nh8ru3ad83QtmJjiWr6IHt
         GQWbi0HL8sKmYc70HSBAF01pmiHQ0OiojZykLLqmUkwJ5dhjb917L2TCRY1jJGxYRWQv
         Pz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706501121; x=1707105921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftMJ+6t5uKSVupkC2mB/MwofcBBs65/nrsC9Z7jssek=;
        b=RRI5VJj4rCGqQLsayqUyVzExMfgqTgKi24C041LBalun87iZ/3zSN6Xon6SPq8orlg
         rh+UgyqxwldsCOdZneru/3CEJLxaJ8t7SICuI4QKvpCIIxRdGEpjKcO+R5vTWjafuoXh
         2UidUN9UKw8ZGd72nrX1j+fxf57kz8B+rEbGGmaHCZmIsuQSaXyk5ylGfpoi3jsQGqUB
         +F4i49gCnWq4TT5HtG1C68aHvzJWEbz1mOCEdRcrTLx7AWQn6wDHUKXxbPaKylzfVDhU
         IPdlfEImX72GlRtm5U3Y59f/aJGyjVlMPpbMzmNgsCjfi3Z4/lfyCt9eeRcf3Pj6dgvU
         vz6Q==
X-Gm-Message-State: AOJu0YxRYlkrBfXhZyP8+fqfNA0uNqkjhVbQE09dpomAG4rXcisSwPBa
	tY8Hs1O2Zl2SlhfjtLPJnGqDOeuk8i/LP6bww5fu5GyKhpEDRZz6z5VW381itvmGy7JtiOk5TwV
	bbh4tYb/Y6ZWUGaG0oVZkovyyBgwngdCjLz2jAA==
X-Google-Smtp-Source: AGHT+IHuMFYcXPEnNF7lhkPA7PHjaHMeoMndTxyEC53ArEOtnt8rvtXYY6XCd7v7VMe7zqLIFMyFdtsaL9fOq2ioPp0=
X-Received: by 2002:a5b:34a:0:b0:dc6:19bf:1b99 with SMTP id
 q10-20020a5b034a000000b00dc619bf1b99mr3680472ybp.91.1706501120734; Sun, 28
 Jan 2024 20:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-x1e80100-phy-edp-compatible-refactor-v3-0-e71f3359c535@linaro.org>
 <20240129-x1e80100-phy-edp-compatible-refactor-v3-2-e71f3359c535@linaro.org>
In-Reply-To: <20240129-x1e80100-phy-edp-compatible-refactor-v3-2-e71f3359c535@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jan 2024 06:05:09 +0200
Message-ID: <CAA8EJpr5Ci7M92ibsCMec3wcQTVqFkaVgRQUhKUSdhg66YhW1Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] phy: qcom: edp: Add set_mode op for configuring
 eDP/DP submode
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 02:26, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Future platforms should not use different compatibles to differentiate
> between eDP and DP mode. Instead, they should use a single compatible as the
> IP block is the same. It will be the job of the controller to set the submode
> of the PHY accordingly.
>
> The existing platforms will remain with separate compatibles for each mode.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 71 ++++++++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 8e5078304646..af941d6c5588 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
> +#include <linux/phy/phy-dp.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> @@ -68,19 +69,21 @@
>
>  #define TXn_TRAN_DRVR_EMP_EN                    0x0078
>
> -struct qcom_edp_cfg {
> -       bool is_dp;
> -
> -       /* DP PHY swing and pre_emphasis tables */
> +struct qcom_edp_swing_pre_emph_cfg {
>         const u8 (*swing_hbr_rbr)[4][4];
>         const u8 (*swing_hbr3_hbr2)[4][4];
>         const u8 (*pre_emphasis_hbr_rbr)[4][4];
>         const u8 (*pre_emphasis_hbr3_hbr2)[4][4];
>  };
>
> +struct qcom_edp_phy_cfg {
> +       bool is_edp;
> +       const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
> +};
> +
>  struct qcom_edp {
>         struct device *dev;
> -       const struct qcom_edp_cfg *cfg;
> +       const struct qcom_edp_phy_cfg *cfg;
>
>         struct phy *phy;
>
> @@ -96,6 +99,8 @@ struct qcom_edp {
>
>         struct clk_bulk_data clks[2];
>         struct regulator_bulk_data supplies[2];
> +
> +       bool is_edp;
>  };
>
>  static const u8 dp_swing_hbr_rbr[4][4] = {
> @@ -126,8 +131,7 @@ static const u8 dp_pre_emp_hbr2_hbr3[4][4] = {
>         { 0x04, 0xff, 0xff, 0xff }
>  };
>
> -static const struct qcom_edp_cfg dp_phy_cfg = {
> -       .is_dp = true,
> +static const struct qcom_edp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg = {
>         .swing_hbr_rbr = &dp_swing_hbr_rbr,
>         .swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
>         .pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr,
> @@ -162,18 +166,28 @@ static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
>         { 0x00, 0xff, 0xff, 0xff }
>  };
>
> -static const struct qcom_edp_cfg edp_phy_cfg = {
> -       .is_dp = false,
> +static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
>         .swing_hbr_rbr = &edp_swing_hbr_rbr,
>         .swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
>         .pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr,
>         .pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
>  };
>
> +static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
> +};
> +
> +static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
> +       .swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
> +};
> +
> +static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
> +       .is_edp = true,
> +       .swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
> +};
> +
>  static int qcom_edp_phy_init(struct phy *phy)
>  {
>         struct qcom_edp *edp = phy_get_drvdata(phy);
> -       const struct qcom_edp_cfg *cfg = edp->cfg;
>         int ret;
>         u8 cfg8;
>
> @@ -200,7 +214,7 @@ static int qcom_edp_phy_init(struct phy *phy)
>                DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
>                edp->edp + DP_PHY_PD_CTL);
>
> -       if (cfg && cfg->is_dp)
> +       if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)

I think (!edp->is_edp) should be enough here.

>                 cfg8 = 0xb7;
>         else
>                 cfg8 = 0x37;
> @@ -234,7 +248,7 @@ static int qcom_edp_phy_init(struct phy *phy)
>
>  static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
>  {
> -       const struct qcom_edp_cfg *cfg = edp->cfg;
> +       const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->cfg->swing_pre_emph_cfg;
>         unsigned int v_level = 0;
>         unsigned int p_level = 0;
>         u8 ldo_config;
> @@ -245,6 +259,9 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
>         if (!cfg)
>                 return 0;
>
> +       if (edp->is_edp)
> +               cfg = &edp_phy_swing_pre_emph_cfg;
> +
>         for (i = 0; i < dp_opts->lanes; i++) {
>                 v_level = max(v_level, dp_opts->voltage[i]);
>                 p_level = max(p_level, dp_opts->pre[i]);
> @@ -261,7 +278,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
>         if (swing == 0xff || emph == 0xff)
>                 return -EINVAL;
>
> -       ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
> +       ldo_config = edp->is_edp ? 0x0 : 0x1;
>
>         writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
>         writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
> @@ -447,10 +464,9 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel
>  static int qcom_edp_phy_power_on(struct phy *phy)
>  {
>         const struct qcom_edp *edp = phy_get_drvdata(phy);
> -       const struct qcom_edp_cfg *cfg = edp->cfg;
>         u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
>         unsigned long pixel_freq;
> -       u8 ldo_config;
> +       u8 ldo_config = 0x0;
>         int timeout;
>         int ret;
>         u32 val;
> @@ -468,7 +484,8 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>                 return timeout;
>
>
> -       ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
> +       if (edp->cfg->swing_pre_emph_cfg && !edp->cfg->is_edp)

I'd assume this should be `if (!edp->is_edp)`, see qcom_edp_set_voltages()

> +               ldo_config = 0x1;
>
>         writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
>         writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
> @@ -589,6 +606,18 @@ static int qcom_edp_phy_power_off(struct phy *phy)
>         return 0;
>  }
>
> +static int qcom_edp_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +       struct qcom_edp *edp = phy_get_drvdata(phy);
> +
> +       if (mode != PHY_MODE_DP)
> +               return -EINVAL;
> +
> +       edp->is_edp = submode == PHY_SUBMODE_EDP ? true : false;
> +
> +       return 0;
> +}
> +
>  static int qcom_edp_phy_exit(struct phy *phy)
>  {
>         struct qcom_edp *edp = phy_get_drvdata(phy);
> @@ -604,6 +633,7 @@ static const struct phy_ops qcom_edp_ops = {
>         .configure      = qcom_edp_phy_configure,
>         .power_on       = qcom_edp_phy_power_on,
>         .power_off      = qcom_edp_phy_power_off,
> +       .set_mode       = qcom_edp_phy_set_mode,
>         .exit           = qcom_edp_phy_exit,
>         .owner          = THIS_MODULE,
>  };
> @@ -781,6 +811,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>
>         edp->dev = dev;
>         edp->cfg = of_device_get_match_data(&pdev->dev);
> +       edp->is_edp = edp->cfg->is_edp;
>
>         edp->edp = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(edp->edp))
> @@ -839,10 +870,10 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id qcom_edp_phy_match_table[] = {
> -       { .compatible = "qcom,sc7280-edp-phy" },
> -       { .compatible = "qcom,sc8180x-edp-phy" },
> -       { .compatible = "qcom,sc8280xp-dp-phy", .data = &dp_phy_cfg },
> -       { .compatible = "qcom,sc8280xp-edp-phy", .data = &edp_phy_cfg },
> +       { .compatible = "qcom,sc7280-edp-phy" , .data = &sc7280_dp_phy_cfg, },
> +       { .compatible = "qcom,sc8180x-edp-phy", .data = &sc7280_dp_phy_cfg, },
> +       { .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
> +       { .compatible = "qcom,sc8280xp-edp-phy", .data = &sc8280xp_edp_phy_cfg, },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_edp_phy_match_table);
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

