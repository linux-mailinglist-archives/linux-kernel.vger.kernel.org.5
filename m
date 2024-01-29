Return-Path: <linux-kernel+bounces-42482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9B8401F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313A41F229E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1CA55C0B;
	Mon, 29 Jan 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRWOIs5z"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320955765
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521239; cv=none; b=RMwVcENNEvVn4FOSIDqdW74u8tbpq324lOFCDkFxp2njD6GE9fl58mFPax3rXTS6Vs2LBKGWNDvDNMel7Q44vMPR1Jbow2tCsT2eHNT56NMDiYfeT8zvXy0fzLQRoveGFyXilvwa9PMLirKBVLu852CHULQ65np8YGClQTYHs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521239; c=relaxed/simple;
	bh=LvIa5rnussX39WpEvTL5gFnyjahkkKM2xWu0Uymx6WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcseUIJIcIVsVAGGpe7aZIGnHCJlVN8M6KEEytJRireg5f4zsarnVJXCylyGe8gXGEeVY0zyLl2O13+0jAcGEC+4VVWeiw65HtCZIJdPj4VfjV2tPjTHPyBY6kjUky83V9tMwaSGVv2vEVTBkq+HkRbE28v+2PjLqWPr+uKPWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uRWOIs5z; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6001449a2beso15512007b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706521235; x=1707126035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2JY6ToXPjNwXhuXrTT6QOjgiDmdF+CeM/r9NF1DgPmk=;
        b=uRWOIs5z5cpIcgIRteOBk0BWRv4DIT3n5pAnv7v7NShb/QfsK6qDWeMocGKBOtUzau
         U3DaFctFnVIdZo09w5hXWYD8ZxeJMobkjIOklZlp6xX4PK6osWLV/poAM2t9IKiByT4r
         2oAjaqTt8ld2m0oBA8pQXgolEHfBckhB9BRdu9YdoHcUWiVMFgAXyyIc3OSHrhk+1knF
         WGCr9HVS4/YNLY61Vr6y62RpIapzlUnFLiuWcEI0hDipgPG+RXIMtvaLilpbE6ltUJ9Y
         yX+WI327PXEgCa7HRGzEhrDxug4fDl3u6Uf/weUK+KZEYci2ViHnf+TsAewMVW794B1I
         VN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706521235; x=1707126035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JY6ToXPjNwXhuXrTT6QOjgiDmdF+CeM/r9NF1DgPmk=;
        b=qipDIh01HifA4+m3h+2CzE35lHc9PpSQnSJI1gOVd224/b1HZF37uVPkPy1i+5Tyai
         c0zp23L2oKmKrTxD0J4RD+vRIuZ+cULmilkuNQp+WtHVXpoi207rCnwY/3RpDfBY9uBg
         N4Ffvwqx7PCogeFmiQJ/Q+nMuBsMTZ+XL11rKPrmxh9JU+DgC1dgnSP/YuuiwlRvTn6d
         6tLbeIKF+z9mRwkig8VRpA6U84kxxcGZzeIuqHj1YWlqttvU32XX3NatBi7UNqrA442c
         dXcgWGcVGValplJNfzMMj/Y4sj1jUbnR0HqYGNXA+Uep/gG+lLAfIfH9jww/+AGiAksJ
         2I3A==
X-Gm-Message-State: AOJu0YywD/Oya/CcpDRkFpmOWgltPkjvOfH1td42rwNFNRKGiC52zJL1
	h1DT1mM521rWyFfx6Uh9rxp4Lv6OxFYVJ6WYF9WEUEOHN4iMnNjdeHyYBFs6fU9cezQ1jlUL3/Z
	AB+/o5YA8WU1gaqZyUc83rrWI9UuYkqAUd0rTAEiZnYZuHOII
X-Google-Smtp-Source: AGHT+IH4lWSb6WG9jfOKtjqmDCo4I5nviQ3kAEzfInwhv5cfQoct03pp8KFNFA8IYJr4yCU2gWeZ0ebx2mBpRYiPCJA=
X-Received: by 2002:a0d:d415:0:b0:5ef:78ad:b0b6 with SMTP id
 w21-20020a0dd415000000b005ef78adb0b6mr3331146ywd.69.1706521235443; Mon, 29
 Jan 2024 01:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-x1e80100-phy-edp-compatible-refactor-v3-0-e71f3359c535@linaro.org>
 <20240129-x1e80100-phy-edp-compatible-refactor-v3-2-e71f3359c535@linaro.org>
 <CAA8EJpr5Ci7M92ibsCMec3wcQTVqFkaVgRQUhKUSdhg66YhW1Q@mail.gmail.com> <Zbdcao0emQyBodCK@linaro.org>
In-Reply-To: <Zbdcao0emQyBodCK@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jan 2024 11:40:24 +0200
Message-ID: <CAA8EJppkEksTL90KLcaw0adg73K=ngoYp8semB_u5YFk6rChhA@mail.gmail.com>
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

On Mon, 29 Jan 2024 at 10:06, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 24-01-29 06:05:09, Dmitry Baryshkov wrote:
> > On Mon, 29 Jan 2024 at 02:26, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > Future platforms should not use different compatibles to differentiate
> > > between eDP and DP mode. Instead, they should use a single compatible as the
> > > IP block is the same. It will be the job of the controller to set the submode
> > > of the PHY accordingly.
> > >
> > > The existing platforms will remain with separate compatibles for each mode.
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-edp.c | 71 ++++++++++++++++++++++++++-----------
> > >  1 file changed, 51 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> > > index 8e5078304646..af941d6c5588 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/phy/phy.h>
> > > +#include <linux/phy/phy-dp.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/reset.h>
> > > @@ -68,19 +69,21 @@
> > >
> > >  #define TXn_TRAN_DRVR_EMP_EN                    0x0078
> > >
> > > -struct qcom_edp_cfg {
> > > -       bool is_dp;
> > > -
> > > -       /* DP PHY swing and pre_emphasis tables */
> > > +struct qcom_edp_swing_pre_emph_cfg {
> > >         const u8 (*swing_hbr_rbr)[4][4];
> > >         const u8 (*swing_hbr3_hbr2)[4][4];
> > >         const u8 (*pre_emphasis_hbr_rbr)[4][4];
> > >         const u8 (*pre_emphasis_hbr3_hbr2)[4][4];
> > >  };
> > >
> > > +struct qcom_edp_phy_cfg {
> > > +       bool is_edp;
> > > +       const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
> > > +};
> > > +
> > >  struct qcom_edp {
> > >         struct device *dev;
> > > -       const struct qcom_edp_cfg *cfg;
> > > +       const struct qcom_edp_phy_cfg *cfg;
> > >
> > >         struct phy *phy;
> > >
> > > @@ -96,6 +99,8 @@ struct qcom_edp {
> > >
> > >         struct clk_bulk_data clks[2];
> > >         struct regulator_bulk_data supplies[2];
> > > +
> > > +       bool is_edp;
> > >  };
> > >
> > >  static const u8 dp_swing_hbr_rbr[4][4] = {
> > > @@ -126,8 +131,7 @@ static const u8 dp_pre_emp_hbr2_hbr3[4][4] = {
> > >         { 0x04, 0xff, 0xff, 0xff }
> > >  };
> > >
> > > -static const struct qcom_edp_cfg dp_phy_cfg = {
> > > -       .is_dp = true,
> > > +static const struct qcom_edp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg = {
> > >         .swing_hbr_rbr = &dp_swing_hbr_rbr,
> > >         .swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
> > >         .pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr,
> > > @@ -162,18 +166,28 @@ static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
> > >         { 0x00, 0xff, 0xff, 0xff }
> > >  };
> > >
> > > -static const struct qcom_edp_cfg edp_phy_cfg = {
> > > -       .is_dp = false,
> > > +static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
> > >         .swing_hbr_rbr = &edp_swing_hbr_rbr,
> > >         .swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
> > >         .pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr,
> > >         .pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
> > >  };
> > >
> > > +static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
> > > +};
> > > +
> > > +static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
> > > +       .swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
> > > +};
> > > +
> > > +static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
> > > +       .is_edp = true,
> > > +       .swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
> > > +};
> > > +
> > >  static int qcom_edp_phy_init(struct phy *phy)
> > >  {
> > >         struct qcom_edp *edp = phy_get_drvdata(phy);
> > > -       const struct qcom_edp_cfg *cfg = edp->cfg;
> > >         int ret;
> > >         u8 cfg8;
> > >
> > > @@ -200,7 +214,7 @@ static int qcom_edp_phy_init(struct phy *phy)
> > >                DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
> > >                edp->edp + DP_PHY_PD_CTL);
> > >
> > > -       if (cfg && cfg->is_dp)
> > > +       if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
> >
> > I think (!edp->is_edp) should be enough here.
>
> Actually, in case of DP, the cfg8 needs to be 0xb7 for sc8280xp, while for sc7280 it should be 0x37.
>
> So to differentiate between first and second we check if the config
> provides a swing_pre_emph_cfg

Using swing_pre_emph_cfg to distinguish between those two cases is a pure hack.
Is there any sensible meaning behind those bits? If not, just put
those values into the configuration data.

>
> >
> > >                 cfg8 = 0xb7;
> > >         else
> > >                 cfg8 = 0x37;
> > > @@ -234,7 +248,7 @@ static int qcom_edp_phy_init(struct phy *phy)
> > >
> > >  static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
> > >  {
> > > -       const struct qcom_edp_cfg *cfg = edp->cfg;
> > > +       const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->cfg->swing_pre_emph_cfg;
> > >         unsigned int v_level = 0;
> > >         unsigned int p_level = 0;
> > >         u8 ldo_config;
> > > @@ -245,6 +259,9 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
> > >         if (!cfg)
> > >                 return 0;
> > >
> > > +       if (edp->is_edp)
> > > +               cfg = &edp_phy_swing_pre_emph_cfg;
> > > +
> > >         for (i = 0; i < dp_opts->lanes; i++) {
> > >                 v_level = max(v_level, dp_opts->voltage[i]);
> > >                 p_level = max(p_level, dp_opts->pre[i]);
> > > @@ -261,7 +278,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
> > >         if (swing == 0xff || emph == 0xff)
> > >                 return -EINVAL;
> > >
> > > -       ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
> > > +       ldo_config = edp->is_edp ? 0x0 : 0x1;
> > >
> > >         writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
> > >         writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
> > > @@ -447,10 +464,9 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel
> > >  static int qcom_edp_phy_power_on(struct phy *phy)
> > >  {
> > >         const struct qcom_edp *edp = phy_get_drvdata(phy);
> > > -       const struct qcom_edp_cfg *cfg = edp->cfg;
> > >         u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
> > >         unsigned long pixel_freq;
> > > -       u8 ldo_config;
> > > +       u8 ldo_config = 0x0;
> > >         int timeout;
> > >         int ret;
> > >         u32 val;
> > > @@ -468,7 +484,8 @@ static int qcom_edp_phy_power_on(struct phy *phy)
> > >                 return timeout;
> > >
> > >
> > > -       ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
> > > +       if (edp->cfg->swing_pre_emph_cfg && !edp->cfg->is_edp)
> >
> > I'd assume this should be `if (!edp->is_edp)`, see qcom_edp_set_voltages()
> >
>
> Yep. will fix.
>
> > > +               ldo_config = 0x1;
> > >
> > >         writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
> > >         writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
> > > @@ -589,6 +606,18 @@ static int qcom_edp_phy_power_off(struct phy *phy)
> > >         return 0;
> > >  }
> > >
> > > +static int qcom_edp_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> > > +{
> > > +       struct qcom_edp *edp = phy_get_drvdata(phy);
> > > +
> > > +       if (mode != PHY_MODE_DP)
> > > +               return -EINVAL;
> > > +
> > > +       edp->is_edp = submode == PHY_SUBMODE_EDP ? true : false;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static int qcom_edp_phy_exit(struct phy *phy)
> > >  {
> > >         struct qcom_edp *edp = phy_get_drvdata(phy);
> > > @@ -604,6 +633,7 @@ static const struct phy_ops qcom_edp_ops = {
> > >         .configure      = qcom_edp_phy_configure,
> > >         .power_on       = qcom_edp_phy_power_on,
> > >         .power_off      = qcom_edp_phy_power_off,
> > > +       .set_mode       = qcom_edp_phy_set_mode,
> > >         .exit           = qcom_edp_phy_exit,
> > >         .owner          = THIS_MODULE,
> > >  };
> > > @@ -781,6 +811,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
> > >
> > >         edp->dev = dev;
> > >         edp->cfg = of_device_get_match_data(&pdev->dev);
> > > +       edp->is_edp = edp->cfg->is_edp;
> > >
> > >         edp->edp = devm_platform_ioremap_resource(pdev, 0);
> > >         if (IS_ERR(edp->edp))
> > > @@ -839,10 +870,10 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
> > >  }
> > >
> > >  static const struct of_device_id qcom_edp_phy_match_table[] = {
> > > -       { .compatible = "qcom,sc7280-edp-phy" },
> > > -       { .compatible = "qcom,sc8180x-edp-phy" },
> > > -       { .compatible = "qcom,sc8280xp-dp-phy", .data = &dp_phy_cfg },
> > > -       { .compatible = "qcom,sc8280xp-edp-phy", .data = &edp_phy_cfg },
> > > +       { .compatible = "qcom,sc7280-edp-phy" , .data = &sc7280_dp_phy_cfg, },
> > > +       { .compatible = "qcom,sc8180x-edp-phy", .data = &sc7280_dp_phy_cfg, },
> > > +       { .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
> > > +       { .compatible = "qcom,sc8280xp-edp-phy", .data = &sc8280xp_edp_phy_cfg, },
> > >         { }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, qcom_edp_phy_match_table);
> > >
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

