Return-Path: <linux-kernel+bounces-168051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090178BB313
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F5AB20E91
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883B15884B;
	Fri,  3 May 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I49loTwd"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1241A80
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760988; cv=none; b=aLjID75X0EKgiPek/6+v7uLVzGXmxNMaFRKzS678moSj0ch29MTCoCtN8NBIqZ4gwWjlJz1d3Sbxus8gBIZV1ALPw+dO2QS9madiYcuPZ9ur3tKdelQmY4pHD9IPf69K89lzL761CMR1uZpEeHwABHIVm1VoI+5sLLwzm5sLi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760988; c=relaxed/simple;
	bh=+/j9eocWJQy7UVNG7UMYNMCgLDsNfhclGjsXkpSvvwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZTTRVZha2TL1/sdvbsygb+DPNBAcJAkPlHKz08Xu5GLm1DKhUnxJTZNYPOoEJqaiJI6IuSf26zfKku0ThNliFVcrhbHpjsFbVCmRRVI1wOwT89Hr4GvqK7F4ufOK4RirnG+AyKp+/7Wp5kob4mXKBYaMoXlaTsfJNC/RjNu8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I49loTwd; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de596c078c2so1757276.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714760986; x=1715365786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4c0Xkscfsp+v9YiH2gEmKNwfnNo0YPYHltR5P7xeTEo=;
        b=I49loTwdPzr3MRin7QdIlxrraW224afuFzjzkqNGcUIdpZVy+VEpK1zJ3yZVlAX6ti
         aBv34z6da4KPfu/rMbYBXLgS+Q1LQzkaLpezeN+zURo1xkBKmkbsvBAaKymaZ8WOAnQx
         Q7ONcAmzDqkH+yv3WyuTpeTLWRXCmX+PY3mGXZrX9blggd5XqjzkfA5krqFvqgjxqAyv
         7hmgi59SrDrCneJXkEPgKlT4T40zH0CjvO8rJSXRDiVLWD5V0fMtOu7w3jrELK3NpypB
         htBow2r/uKqCAJp+eay1JNGz+L3Uldl9Ow2KbTOdnnKSPvMHzYUWCApduORZr5+NtSWy
         F1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760986; x=1715365786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4c0Xkscfsp+v9YiH2gEmKNwfnNo0YPYHltR5P7xeTEo=;
        b=jlYS1+L4nvZ8q85zrJLtAFAgQXHSdnet8lwYeER5Hv73JTmz6zE8Hxl1LQjQfBU5MV
         o5P+T0YRr3a7WIiTR3y6960H8om62FikZNpMCcmrjJc6S69iDx8RcVVYSigt57C52C2Y
         iOA6+EIfDD4JgCoUbUH74yQkKeckoSoGsZYHrhaU/jUSTfItHaoqDoCWTRgPWCcuo5rI
         95UuLzlh0l4kfNNfvBQUHZUupUn+YbshGDvyG/g5QD+vR4KELd7FkSzhWIW3PGOL8AOl
         Qh6cQl3ULPiDqX/28DnHfxkPw4uah5uXsCsLv1YwbhuV1TKTuMjvGxZd4jM3rwQqTb/y
         BJzg==
X-Forwarded-Encrypted: i=1; AJvYcCUgn+50TJS1pA9RNC1YgucvMeyxCsT//xrxZuWiDbiH25lBp0nczEQHrOChWTR+7WNN97Kh1Dpja36E7JoNNGEa6AdhXpEMH+098Sf/
X-Gm-Message-State: AOJu0YzmMhHso6//jtljXyjGrGhngF5+IrKYRgCraOu9bobXohbDE1V3
	gJprCSdXNSpFXlXHIEWspkycR26c4CAW8f80yw4hkmsG0EnBrqisX+ZQmPFZG683BYS3Bx3iCIH
	Dn9O9KbnhgKaZN4807fS5pc2p6sw4jEtTzrCNGA==
X-Google-Smtp-Source: AGHT+IF3PxhjibMh+R8Z/4SVCsOdvyiDuKj7cvIrr+QB0fNzYmuVOiKzWOohmwY6T0mpCF9SV6qRMbHlLl6atTzIFtc=
X-Received: by 2002:a25:bf8e:0:b0:de5:f0ef:7898 with SMTP id
 l14-20020a25bf8e000000b00de5f0ef7898mr4101235ybk.20.1714760986103; Fri, 03
 May 2024 11:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502123312.31083-1-quic_ugoswami@quicinc.com>
 <CAA8EJppeQTadmny=hcs4xCQDXHwXEBHXjeecvZCUVcSXmwBTgg@mail.gmail.com> <2f3dd278-02b8-4939-8b75-55c342adcddf@quicinc.com>
In-Reply-To: <2f3dd278-02b8-4939-8b75-55c342adcddf@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 3 May 2024 21:29:34 +0300
Message-ID: <CAA8EJprJfddVGH+tSE=n+7MncfGNULerEidbxdSGd7a14fChvQ@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-snps-femto-v2: Add load and voltage setting for
 LDO's used
To: Udipto Goswami <quic_ugoswami@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 08:24, Udipto Goswami <quic_ugoswami@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 5/2/2024 6:42 PM, Dmitry Baryshkov wrote:
> > On Thu, 2 May 2024 at 15:33, Udipto Goswami <quic_ugoswami@quicinc.com> wrote:
> >>
> >> The Femto phy depends on 0.88/ 1.8/ 3.3V regulators for its operation.
> >> If one of the regulators is not voted to the required minimum voltage
> >> for phy to operate, then High speed mode of operation will fail.
> >>
> >> On certain targets like (qcm6490_rb3gen2) where the minimum voltage
> >> of the regulator is lower than the operating voltage of the phy.
> >> If not voted properly, the phy supply would be limited to the min value
> >> of the LDO thereby rendering the phy non-operational.
> >>
> >> The current implementation of the regulators in the Femto PHY is not
> >> setting the load and voltage for each LDO. The appropriate voltages and
> >> loads required for the PHY to operate should be set.
> >
> > Please move min/max voltages to the DTS. There is no need to set them
> > from the driver.
> that also can be done.
> >
> > Also, is there any reason why you can't use `regulator-initial-mode =
> > <RPMH_REGULATOR_MODE_HPM>;` like other boards do?
>
>
> but the regulator loads & voltages for the phy doesn't change for every
> platform.
> Phys operational limits will still be the same for all the different
> platforms which exists today and the upcoming ones as well if they use it.
>
> Suppose te LDO's HPM is 2000 but the phy require 6000, its not getting
> enough power, same for reverse say 6000 in LDO's HPM and phy require
> 2000, isn't this power leakage ?
>
> This also seems to be the case with voltages as well, the phy require
> 0.88V for operation but if LDO is lower then that say 0.70, phy won't work.
>
> So instead of doing it seperately doesn't it make sense to do it in driver ?

For RPMh regulators the load isn't propagated to the regulator at all.
Only the mode is being selected based on the load.

For the voltages: no. The DT constraints should provide boundaries for
the regulator to supply all devices. So setting voltages in the driver
is not correct.

Last, but not least. Please take a look around before writing the
patch. It's true that some of the drivers for Qualcomm platforms set
the load. And some of them get this removed in favour of setting the
mode (that depends on the situation).However I think none of the
consumers on Qualcomm platforms set the voltage boundaries.

> >
> >>
> >> Implement a bulk operation api to set load & voltages before doing bulk
> >> enable. This will ensure that the PHY remains operational under all
> >> conditions.
> >>
> >> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 121 +++++++++++++++++-
> >>   1 file changed, 114 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> >> index eb0b0f61d98e..cbe9cdaa6849 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> >> @@ -78,11 +78,39 @@
> >>
> >>   #define LS_FS_OUTPUT_IMPEDANCE_MASK            GENMASK(3, 0)
> >>
> >> -static const char * const qcom_snps_hsphy_vreg_names[] = {
> >> -       "vdda-pll", "vdda33", "vdda18",
> >> +
> >> +struct qcom_snps_hsphy_regulator_data {
> >> +       const char *name;
> >> +       unsigned int enable_load;
> >> +       unsigned int min_voltage;
> >> +       unsigned int max_voltage;
> >> +};
> >> +
> >> +static const struct qcom_snps_hsphy_regulator_data hsphy_vreg_l[] = {
> >> +       {
> >> +               .name = "vdda-pll",
> >> +               .enable_load = 30000,
> >> +               .min_voltage = 825000,
> >> +               .max_voltage = 925000,
> >> +       },
> >> +
> >> +       {
> >> +               .name = "vdda18",
> >> +               .enable_load = 19000,
> >> +               .min_voltage = 1704000,
> >> +               .max_voltage = 1800000
> >> +       },
> >> +
> >> +       {
> >> +               .name = "vdda33",
> >> +               .enable_load = 16000,
> >> +               .min_voltage = 3050000,
> >> +               .max_voltage = 3300000
> >> +       },
> >> +
> >>   };
> >>
> >> -#define SNPS_HS_NUM_VREGS              ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
> >> +#define SNPS_HS_NUM_VREGS              ARRAY_SIZE(hsphy_vreg_l)
> >>
> >>   struct override_param {
> >>          s32     value;
> >> @@ -132,12 +160,90 @@ struct qcom_snps_hsphy {
> >>          struct clk_bulk_data *clks;
> >>          struct reset_control *phy_reset;
> >>          struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
> >> +       const struct qcom_snps_hsphy_regulator_data *vreg_list;
> >>
> >>          bool phy_initialized;
> >>          enum phy_mode mode;
> >>          struct phy_override_seq update_seq_cfg[NUM_HSPHY_TUNING_PARAMS];
> >>   };
> >>
> >> +static int __vdda_phy_bulk_enable_disable(struct qcom_snps_hsphy *hsphy, bool on)
> >
> > Separate functions, please.
> sure.
> >
> >> +{
> >> +       int ret = 0;
> >> +       int i;
> >> +
> >> +       if (!on)
> >> +               goto disable_vdd;
> >> +
> >> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
> >> +
> >> +               ret = regulator_set_load(hsphy->vregs[i].consumer,
> >> +                                        hsphy->vreg_list[i].enable_load);
> >> +
> >> +               if (ret < 0) {
> >> +                       dev_err(hsphy->dev, "unable to set HPM of %s %d\n",
> >> +                                               hsphy->vregs[i].supply, ret);
> >> +                       goto err_vdd;
> >> +               }
> >> +       }
> >> +
> >> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
> >> +               ret = regulator_set_voltage(hsphy->vregs[i].consumer,
> >> +                                           hsphy->vreg_list[i].min_voltage,
> >> +                                           hsphy->vreg_list[i].max_voltage);
> >> +               if (ret) {
> >> +                       dev_err(hsphy->dev,
> >> +                               "unable to set voltage of regulator %s %d\n",
> >> +                                               hsphy->vregs[i].supply, ret);
> >> +                       goto put_vdd_lpm;
> >> +               }
> >> +       }
> >> +
> >> +       ret = regulator_bulk_enable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> >> +       if (ret)
> >> +               goto unconfig_vdd;
> >> +
> >> +       return ret;
> >> +
> >> +disable_vdd:
> >> +       regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> >> +
> >> +unconfig_vdd:
> >> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
> >> +               ret = regulator_set_voltage(hsphy->vregs[i].consumer, 0,
> >> +                                           hsphy->vreg_list[i].max_voltage);
> >> +               if (ret) {
> >> +                       dev_err(hsphy->dev,
> >> +                       "unable to set voltage of regulator %s %d\n",
> >> +                                       hsphy->vregs[i].supply, ret);
> >> +               }
> >> +       }
> >> +
> >> +put_vdd_lpm:
> >> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
> >> +               ret = regulator_set_load(hsphy->vregs[i].consumer, 0);
> >> +
> >> +               if (ret < 0) {
> >> +                       dev_err(hsphy->dev, "unable to set LPM of %s %d\n",
> >> +                                               hsphy->vregs[i].supply, ret);
> >> +               }
> >> +       }
> >> +
> >> +err_vdd:
> >> +       return ret;
> >> +
> >> +}
> >> +
> >> +static int vdda_phy_bulk_enable(struct qcom_snps_hsphy *hsphy)
> >> +{
> >> +       return __vdda_phy_bulk_enable_disable(hsphy, true);
> >> +}
> >> +
> >> +static int vdda_phy_bulk_disable(struct qcom_snps_hsphy *hsphy)
> >> +{
> >> +       return __vdda_phy_bulk_enable_disable(hsphy, false);
> >> +}
> >> +
> >>   static int qcom_snps_hsphy_clk_init(struct qcom_snps_hsphy *hsphy)
> >>   {
> >>          struct device *dev = hsphy->dev;
> >> @@ -390,7 +496,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
> >>
> >>          dev_vdbg(&phy->dev, "%s(): Initializing SNPS HS phy\n", __func__);
> >>
> >> -       ret = regulator_bulk_enable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> >> +       ret = vdda_phy_bulk_enable(hsphy);
> >>          if (ret)
> >>                  return ret;
> >>
> >> @@ -471,7 +577,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
> >>   disable_clks:
> >>          clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
> >>   poweroff_phy:
> >> -       regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> >> +       ret = vdda_phy_bulk_disable(hsphy);
> >>
> >>          return ret;
> >>   }
> >> @@ -482,7 +588,7 @@ static int qcom_snps_hsphy_exit(struct phy *phy)
> >>
> >>          reset_control_assert(hsphy->phy_reset);
> >>          clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
> >> -       regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> >> +       vdda_phy_bulk_disable(hsphy);
> >>          hsphy->phy_initialized = false;
> >>
> >>          return 0;
> >> @@ -592,8 +698,9 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
> >>
> >>          num = ARRAY_SIZE(hsphy->vregs);
> >>          for (i = 0; i < num; i++)
> >> -               hsphy->vregs[i].supply = qcom_snps_hsphy_vreg_names[i];
> >> +               hsphy->vregs[i].supply = hsphy_vreg_l[i].name;
> >>
> >> +       hsphy->vreg_list  = hsphy_vreg_l;
> >>          ret = devm_regulator_bulk_get(dev, num, hsphy->vregs);
> >>          if (ret)
> >>                  return dev_err_probe(dev, ret,
> >> --
> >> 2.17.1
>
> -Udipto



-- 
With best wishes
Dmitry

