Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74C68068FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376756AbjLFHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:54:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FDA188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:54:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B30C433C8;
        Wed,  6 Dec 2023 07:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701849296;
        bh=oypg8H92xfnc19tAPThmY81NoTSyU3vjeSxmhkrunYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9365YMCtQ4i08AM5A8FU6ypnRi/Hv8bTvXegw3gf0f5PeYEtUNfLUbi0PiaaR0Ch
         itRumrtGztqFge/s6pc3DQgK8LPlntURUaS/UHiCam7qR4Z1znpqnPRhS7bqeOzCwJ
         P3FlUAvWOHF12D+d3a+yP53LS3wH7rluw4TMoDEXmpQoYActcXHQQ1ihdCTQCc+Otu
         NLVktWCpZNjjwI02XrzHDBoqFEkRbfmil2AtfA0aW/3ZNbx7eHfnnKljsKwBKTkehw
         q1aKKFsUvuWnWLvgkRx51EzBe50SNekCt8b8CTIGaZwzRcaR66hDeRM/qP7NvaYhaw
         avHxLR5jFOssA==
Date:   Wed, 6 Dec 2023 13:24:47 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, quic_cang@quicinc.com,
        Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH V1] scsi: ufs: core: store min and max clk freq from OPP
 table
Message-ID: <20231206075447.GA4954@thinkpad>
References: <20231206053628.32169-1-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206053628.32169-1-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:06:28AM +0530, Nitin Rawat wrote:
> OPP support will make use of OPP table in device tree and removes
> freq-table-hz property from device tree.
> 
> With OPP enabled in devicetree, clki->min_freq and clki->maxfreq
> currently is not getting updated and the value is set to 0.
> 
> Soc vendors like qcom, mediatek uses clki->minfreq and clki->maxfreq
> in vendor specific file. These frequencies values are used to update
> vendor specific configurations. Since the value is 0, it is causing
> functional issue.

How about,

"OPP support added by commit 72208ebe181e ("scsi: ufs: core: Add support
for parsing OPP") doesn't update the min_freq and max_freq of each clocks
in 'struct ufs_clk_info'.

But these values are used by the vendor host drivers internally for controller
configuration. When the OPP support is enabled in devicetree, these values will
be 0, causing boot issues on the respective platforms.

So let's parse the min_freq and max_freq of all clocks while parsing the OPP
table."

> 
> Add code to store the min and max ufs clk frequency from OPP table.
> 
> Fixes: 72208ebe181e ("scsi: ufs: core: Add support for parsing OPP")
> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufshcd-pltfrm.c | 56 ++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
> index da2558e274b4..12fa6f7d6a97 100644
> --- a/drivers/ufs/host/ufshcd-pltfrm.c
> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
> @@ -13,6 +13,7 @@
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/clk.h>

Sort includes alphabetically.

> 
>  #include <ufs/ufshcd.h>
>  #include "ufshcd-pltfrm.h"
> @@ -213,6 +214,55 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
>  	}
>  }
> 
> +/**
> + * ufshcd_config_min_max_clk_freq - update min and max freq

"ufshcd_parse_clock_min_max_freq - Parse MIN and MAX frequencies of clocks"

> + * @hba: per adapter instance
> + *
> + * This function store min and max freq for all the clocks.
> + *

"This function parses MIN and MAX frequencies of all clocks required by the
vendor host drivers."

> + * Returns 0 for success and non-zero for failure
> + */
> +static int ufshcd_config_min_max_clk_freq(struct ufs_hba *hba)
> +{
> +	struct list_head *head = &hba->clk_list_head;
> +	struct dev_pm_opp *opp;
> +	struct ufs_clk_info *clki;

Please maintain reverse Xmas tree order. It's not a rule for this driver, but my
own preference.

> +	unsigned long freq;
> +	u8 idx = 0;
> +	int ret;

This won't be needed if all the return values are directly returned as I shared
below.

> +
> +	list_for_each_entry(clki, head, list) {
> +		if (!clki->name)
> +			continue;
> +
> +		clki->clk = devm_clk_get(hba->dev, clki->name);
> +		if (!IS_ERR_OR_NULL(clki->clk)) {

This function won't return NULL, so IS_ERR() is sufficient.

> +			/* Find Max Freq */
> +			freq = ULONG_MAX;
> +			opp = dev_pm_opp_find_freq_floor_indexed(hba->dev, &freq, idx);

Use idx++ and get rid of the increment at the end of the 'if' condition.

> +			if (IS_ERR(opp)) {
> +				dev_err(hba->dev, "failed to find dev_pm_opp\n");

"Failed to find OPP for MAX frequency"

> +				ret = PTR_ERR(opp);

return PTR_ERR(opp);

> +				return ret;
> +			}
> +			clki->max_freq = dev_pm_opp_get_freq_indexed(opp, idx);
> +

Missing dev_pm_opp_put()

> +			/* Find Min Freq */
> +			freq = 0;
> +			opp = dev_pm_opp_find_freq_ceil_indexed(hba->dev, &freq, idx);
> +			if (IS_ERR(opp)) {
> +				dev_err(hba->dev, "failed to find dev_pm_opp\n");

"Failed to find OPP for MIN frequency"

> +				ret = PTR_ERR(opp);

return PTR_ERR(opp);

> +				return ret;
> +			}
> +			clki->min_freq = dev_pm_opp_get_freq_indexed(opp, idx);

Missing dev_pm_opp_put()

> +			idx++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>  {
>  	struct device *dev = hba->dev;
> @@ -279,6 +329,12 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>  		return ret;
>  	}
> 
> +	ret = ufshcd_config_min_max_clk_freq(hba);
> +	if (ret) {
> +		dev_err(dev, "Failed to get min max freq: %d\n", ret);

Since we already print error message inside the function, no need to do the same
here.

- Mani

> +		return ret;
> +	}
> +
>  	hba->use_pm_opp = true;
> 
>  	return 0;
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
