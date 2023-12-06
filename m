Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763EE80711D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378552AbjLFNrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbjLFNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:47:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB459C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:47:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98621C433C7;
        Wed,  6 Dec 2023 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701870430;
        bh=ib/KhT6CRE/Dl/IG1bo0ffAo1R+XUpJpRoCSE1xk+GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYFh1nYid3rxZZz5/+kjM3nXYMw6bVGEewjinV2oOagGeDF0CzRQHqrbjcB+Tv9Cg
         4reI89we9LR67SvVk4r8A0jqZUTVPa5/NPpOS6u521MejXp/8Q/2D7+jNOFMuKitvG
         BZts2e9VsTtT+j75DCksBDU5DpmXZX6i4W3KL3xlRv5SALMCTS7FIxmULkK+tom16x
         33e1sGkqQWmki0Ple1VBECEUfsXPXn5I7DlEf6fMtTnMlu5/Eey7HfUMejhRcIZr2p
         kvN7uNAfe3MENuNjSdJH7PLgNPJMCxNqH252Styiky0g0fgWon3Bns4ko2+OkaSyKM
         4G5JvBDTwyoNQ==
Date:   Wed, 6 Dec 2023 19:17:03 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH V4] scsi: ufs: core: store min and max clk freq from OPP
 table
Message-ID: <20231206134703.GF12802@thinkpad>
References: <20231206133812.21488-1-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206133812.21488-1-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 07:08:12PM +0530, Nitin Rawat wrote:
> OPP support added by commit 72208ebe181e ("scsi: ufs: core: Add support
> for parsing OPP") doesn't update the min_freq and max_freq of each clocks
> in 'struct ufs_clk_info'.
> 
> But these values are used by the host drivers internally for controller
> configuration. When the OPP support is enabled in devicetree, these
> values will be 0, causing boot issues on the respective platforms.
> 
> So add support to parse the min_freq and max_freq of all clocks while
> parsing the OPP table.
> 
> Fixes: 72208ebe181e ("scsi: ufs: core: Add support for parsing OPP")
> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Martin, please queue this patch for 6.7-rcS.

- Mani

> ---
> Changes from v3:
> - updated commit description and comment to address christoph's comment
> 
> Changes from v2:
> - increment idx in dev_pm_opp_get_freq_indexed
> 
> Changes from v1:
> As per Manivannan's comment:
> - Updated commmit description
> - Sort include file alphabetically
> - Added missing dev_pm_opp_put
> - updated function name and documention
> - removed ret variable
> ---
>  drivers/ufs/host/ufshcd-pltfrm.c | 53 ++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
> index da2558e274b4..0983cee6355e 100644
> --- a/drivers/ufs/host/ufshcd-pltfrm.c
> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
> @@ -8,6 +8,7 @@
>   *	Vinayak Holikatti <h.vinayak@samsung.com>
>   */
> 
> +#include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> @@ -213,6 +214,54 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
>  	}
>  }
> 
> +/**
> + * ufshcd_parse_clock_min_max_freq  - Parse MIN and MAX clocks freq
> + * @hba: per adapter instance
> + *
> + * This function parses MIN and MAX frequencies of all clocks required
> + * by the host drivers.
> + *
> + * Returns 0 for success and non-zero for failure
> + */
> +static int ufshcd_parse_clock_min_max_freq(struct ufs_hba *hba)
> +{
> +	struct list_head *head = &hba->clk_list_head;
> +	struct ufs_clk_info *clki;
> +	struct dev_pm_opp *opp;
> +	unsigned long freq;
> +	u8 idx = 0;
> +
> +	list_for_each_entry(clki, head, list) {
> +		if (!clki->name)
> +			continue;
> +
> +		clki->clk = devm_clk_get(hba->dev, clki->name);
> +		if (!IS_ERR(clki->clk)) {
> +			/* Find Max Freq */
> +			freq = ULONG_MAX;
> +			opp = dev_pm_opp_find_freq_floor_indexed(hba->dev, &freq, idx);
> +			if (IS_ERR(opp)) {
> +				dev_err(hba->dev, "Failed to find OPP for MAX frequency\n");
> +				return PTR_ERR(opp);
> +			}
> +			clki->max_freq = dev_pm_opp_get_freq_indexed(opp, idx);
> +			dev_pm_opp_put(opp);
> +
> +			/* Find Min Freq */
> +			freq = 0;
> +			opp = dev_pm_opp_find_freq_ceil_indexed(hba->dev, &freq, idx);
> +			if (IS_ERR(opp)) {
> +				dev_err(hba->dev, "Failed to find OPP for MIN frequency\n");
> +				return PTR_ERR(opp);
> +			}
> +			clki->min_freq = dev_pm_opp_get_freq_indexed(opp, idx++);
> +			dev_pm_opp_put(opp);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>  {
>  	struct device *dev = hba->dev;
> @@ -279,6 +328,10 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>  		return ret;
>  	}
> 
> +	ret = ufshcd_parse_clock_min_max_freq(hba);
> +	if (ret)
> +		return ret;
> +
>  	hba->use_pm_opp = true;
> 
>  	return 0;
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
