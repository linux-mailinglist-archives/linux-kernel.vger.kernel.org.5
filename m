Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D72750EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjGLQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGLQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:34:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6560D10C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:34:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6686ef86110so4092208b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689179666; x=1691771666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zs0m/En6zIrHPDFl9JK0/9X5KfaIqeG5U/i/N6mUb18=;
        b=dZmhTxuRn0Ggjtqs7Bh6lAMu4tfGvsu0WZ9SUdcFP/B4T6mX3uy70bUfhDi9042rfX
         0w2Kpe9GqHgRfCFx3IM+/gbqCwLtw+CXi9WVCPfaswrkiEKvi9403vfoSv2flY8D4yGd
         uIZF91XZiq2jv9EivTdtyijlpWU8Pqh4a47wGkKnRYl46WGwPaPutTTmbqLkTlrX6YGb
         pcM/M2xeyKa+/n0qDlp54qDX4hxN4kSt+9se04uxdrzTffT/c7/svnbkJrTQKCqbXg5r
         CXyaPlMqT34ZD0s1r0JEGKJPIWN4qqd3Pe7EsfwQEIX/obwZLxneXh4eamZZ3TH6EMNR
         GdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689179666; x=1691771666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs0m/En6zIrHPDFl9JK0/9X5KfaIqeG5U/i/N6mUb18=;
        b=Dkcfb8ikKBPf30uO/QsUi9ov3mFUJcHMjgMGJqBeDZ5kTp/JXptSzQbLnkDF5c3HFx
         oXhwQZcBICPgcv/pkUR8bPfuIt2rdmq4QmdPvYiwoSr/noOfpAnSm/gYTY+7kZTFxz1N
         ZhQN+G+YPuZxrMi8pLfbyG3XVsnJqfHbqmXsLpuejH3ZZp5HUysym6anoV1gqTKDDK/w
         vUVhFRy+kJ0yth6SYOoW4TUnABK8gG0wUivr/jAPBcRfpv79PX9oO+FNlH98WCdP1tJj
         wXcc18y94ChazdlfqMvz6oPxrX1QjkQM99c/F7wK+emnScqaChoPBQEHWqGr+s7wVoNi
         tB/w==
X-Gm-Message-State: ABy/qLazJBTdfaI6b9CAPMKzl0ARgXIH/yg/3zp7DTLOHW3B2VyaxSFj
        jWkIoKPxFrwvVgoo+eNJIbKz
X-Google-Smtp-Source: APBJJlFlBHP5AZssL4vukJEogJn8IyXWQu0xoAEj5zrJvcKufJwQ5DgtTZWoi4X/WVf8dBDZKaVjCQ==
X-Received: by 2002:a05:6a21:6d84:b0:126:a80d:4936 with SMTP id wl4-20020a056a216d8400b00126a80d4936mr17918871pzb.27.1689179665747;
        Wed, 12 Jul 2023 09:34:25 -0700 (PDT)
Received: from thinkpad ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id v23-20020aa78517000000b0064f95bc04d3sm3818864pfn.20.2023.07.12.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:34:25 -0700 (PDT)
Date:   Wed, 12 Jul 2023 22:04:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 11/14] scsi: ufs: host: Add support for parsing OPP
Message-ID: <20230712163406.GG102757@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
 <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:15:12PM +0300, Dmitry Baryshkov wrote:
> On 12/07/2023 13:32, Manivannan Sadhasivam wrote:
> > OPP framework can be used to scale the clocks along with other entities
> > such as regulators, performance state etc... So let's add support for
> > parsing OPP from devicetree. OPP support in devicetree is added through
> > the "operating-points-v2" property which accepts the OPP table defining
> > clock frequency, regulator voltage, power domain performance state etc...
> > 
> > Since the UFS controller requires multiple clocks to be controlled for
> > proper working, devm_pm_opp_set_config() has been used which supports
> > scaling multiple clocks through custom ufshcd_opp_config_clks() callback.
> > 
> > It should be noted that the OPP support is not compatible with the old
> > "freq-table-hz" property. So only one can be used at a time even though
> > the UFS core supports both.
> > 
> > Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/ufs/host/ufshcd-pltfrm.c | 116 +++++++++++++++++++++++++++++++
> >   1 file changed, 116 insertions(+)
> > 
> > diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
> > index 0b7430033047..068c22378c88 100644
> > --- a/drivers/ufs/host/ufshcd-pltfrm.c
> > +++ b/drivers/ufs/host/ufshcd-pltfrm.c
> > @@ -8,8 +8,10 @@
> >    *	Vinayak Holikatti <h.vinayak@samsung.com>
> >    */
> > +#include <linux/clk.h>
> >   #include <linux/module.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/pm_opp.h>
> >   #include <linux/pm_runtime.h>
> >   #include <linux/of.h>
> > @@ -17,6 +19,8 @@
> >   #include "ufshcd-pltfrm.h"
> >   #include <ufs/unipro.h>
> > +#include <trace/events/ufs.h>
> > +
> >   #define UFSHCD_DEFAULT_LANES_PER_DIRECTION		2
> >   static int ufshcd_parse_clock_info(struct ufs_hba *hba)
> > @@ -205,6 +209,112 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
> >   	}
> >   }
> > +static int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
> > +				  struct dev_pm_opp *opp, void *data,
> > +				  bool scaling_down)
> > +{
> > +	struct ufs_hba *hba = dev_get_drvdata(dev);
> > +	struct list_head *head = &hba->clk_list_head;
> > +	struct ufs_clk_info *clki;
> > +	unsigned long freq;
> > +	u8 idx = 0;
> > +	int ret;
> > +
> > +	list_for_each_entry(clki, head, list) {
> > +		if (!IS_ERR_OR_NULL(clki->clk)) {
> > +			freq = dev_pm_opp_get_freq_indexed(opp, idx++);
> > +
> > +			/* Do not set rate for clocks having frequency as 0 */
> > +			if (!freq)
> > +				continue;
> 
> Can we omit these clocks from the opp table? I don't think they serve any
> purpose.
> 

No, we cannot. OPP requires the clocks and opp-hz to be of same length. And we
cannot omit those clocks as well since linux needs to gate control them.

> Maybe it would even make sense to move this function to drivers/opp then, as
> it will be generic enough.
> 

There is already a generic function available in OPP core. But we cannot use it
as we need to skip setting 0 freq and that's not applicable in OPP core as
discussed with Viresh offline.

- Mani

> > +
> > +			ret = clk_set_rate(clki->clk, freq);
> > +			if (ret) {
> > +				dev_err(dev, "%s: %s clk set rate(%ldHz) failed, %d\n",
> > +					__func__, clki->name, freq, ret);
> > +				return ret;
> > +			}
> > +
> > +			trace_ufshcd_clk_scaling(dev_name(dev),
> > +				(scaling_down ? "scaled down" : "scaled up"),
> > +				clki->name, hba->clk_scaling.target_freq, freq);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +} > +
> > +static int ufshcd_parse_operating_points(struct ufs_hba *hba)
> > +{
> > +	struct device *dev = hba->dev;
> > +	struct device_node *np = dev->of_node;
> > +	struct dev_pm_opp_config config = {};
> > +	struct ufs_clk_info *clki;
> > +	const char **clk_names;
> > +	int cnt, i, ret;
> > +
> > +	if (!of_find_property(np, "operating-points-v2", NULL))
> > +		return 0;
> > +
> > +	if (of_find_property(np, "freq-table-hz", NULL)) {
> > +		dev_err(dev, "%s: operating-points and freq-table-hz are incompatible\n",
> > +			 __func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	cnt = of_property_count_strings(np, "clock-names");
> > +	if (cnt <= 0) {
> > +		dev_err(dev, "%s: Missing clock-names\n",  __func__);
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* OPP expects clk_names to be NULL terminated */
> > +	clk_names = devm_kcalloc(dev, cnt + 1, sizeof(*clk_names), GFP_KERNEL);
> > +	if (!clk_names)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * We still need to get reference to all clocks as the UFS core uses
> > +	 * them separately.
> > +	 */
> > +	for (i = 0; i < cnt; i++) {
> > +		ret = of_property_read_string_index(np, "clock-names", i,
> > +						    &clk_names[i]);
> > +		if (ret)
> > +			return ret;
> > +
> > +		clki = devm_kzalloc(dev, sizeof(*clki), GFP_KERNEL);
> > +		if (!clki)
> > +			return -ENOMEM;
> > +
> > +		clki->name = devm_kstrdup(dev, clk_names[i], GFP_KERNEL);
> > +		if (!clki->name)
> > +			return -ENOMEM;
> > +
> > +		if (!strcmp(clk_names[i], "ref_clk"))
> > +			clki->keep_link_active = true;
> > +
> > +		list_add_tail(&clki->list, &hba->clk_list_head);
> > +	}
> > +
> > +	config.clk_names = clk_names,
> > +	config.config_clks = ufshcd_opp_config_clks;
> > +
> > +	ret = devm_pm_opp_set_config(dev, &config);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_pm_opp_of_add_table(dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add OPP table: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	hba->use_pm_opp = true;
> > +
> > +	return 0;
> > +}
> > +
> >   /**
> >    * ufshcd_get_pwr_dev_param - get finally agreed attributes for
> >    *                            power mode change
> > @@ -371,6 +481,12 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
> >   	ufshcd_init_lanes_per_dir(hba);
> > +	err = ufshcd_parse_operating_points(hba);
> > +	if (err) {
> > +		dev_err(dev, "%s: OPP parse failed %d\n", __func__, err);
> > +		goto dealloc_host;
> > +	}
> > +
> >   	err = ufshcd_init(hba, mmio_base, irq);
> >   	if (err) {
> >   		dev_err(dev, "Initialization failed\n");
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
