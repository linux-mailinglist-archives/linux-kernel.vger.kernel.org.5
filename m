Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC17A1A41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjIOJVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjIOJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:20:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36FCD4;
        Fri, 15 Sep 2023 02:20:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C605666072F9;
        Fri, 15 Sep 2023 10:20:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694769652;
        bh=4IgrSSEYd+jVIiU7JcF5y2Ow9YKQzmTU7HYlnL8vZDo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k5mrsOZYjmk5g1JGGHwrN17c+/Dz4Jy7ll1I7zKWOG2PqEX3qlAqMW2qfliJkzgrK
         f35cev5i5xVfSKAPxvR8ZWsFPrVDNikqWv/x7z7MicQaZrwc0VkSpHHMsXboxtlRJ1
         M8NqGicKBpUBiXNwAnw/cqco+bKA1VEAKzRM2aO0l8019CiPDtrdWpfuphxVS5dGJ5
         i5e0XgOhCC9JYwKgq/vaSyxGvfFOdyhsumxmjUWFpeBmN1HzCCCOg5qVl20NLmtGLd
         xtLbGJbT+dcMbTBFbxY4rrjyGpUZHgfUBJGIF5doX3/HCW7rskGafrjPyzLQJmEaSF
         J+U/LmdSvZKCA==
Message-ID: <a6ae9a08-d295-8c1a-840a-84a1b447421b@collabora.com>
Date:   Fri, 15 Sep 2023 11:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 2/2] soc: mediatek: svs: add support for mt8188
Content-Language: en-US
To:     Mark Tseng <chun-jen.tseng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230915075003.1552-1-chun-jen.tseng@mediatek.com>
 <20230915075003.1552-3-chun-jen.tseng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230915075003.1552-3-chun-jen.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/23 09:50, Mark Tseng ha scritto:
> MT8188 svs gpu uses 2-line high bank and low bank to optimize the
> voltage of opp table for higher and lower frequency respectively.
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 177 ++++++++++++++++++++++++++++++++-
>   1 file changed, 172 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 3a2f97cd5272..fafc72df99ee 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -407,6 +407,7 @@ struct svs_platform_data {
>    * @dcbdet: svs efuse data
>    * @dcmdet: svs efuse data
>    * @turn_pt: 2-line turn point tells which opp_volt calculated by high/low bank
> + * @vbin_turn_pt: voltage bin turn point helps know which svsb_volt should be overridden
>    * @type: bank type to represent it is 2-line (high/low) bank or 1-line bank
>    *
>    * Svs bank will generate suitalbe voltages by below general math equation
> @@ -469,6 +470,7 @@ struct svs_bank {
>   	u32 dcbdet;
>   	u32 dcmdet;
>   	u32 turn_pt;
> +	u32 vbin_turn_pt;
>   	u32 type;
>   };
>   
> @@ -751,11 +753,12 @@ static int svs_status_debug_show(struct seq_file *m, void *v)
>   
>   	ret = thermal_zone_get_temp(svsb->tzd, &tzone_temp);
>   	if (ret)
> -		seq_printf(m, "%s: temperature ignore, turn_pt = %u\n",
> -			   svsb->name, svsb->turn_pt);
> +		seq_printf(m, "%s: temperature ignore, vbin_turn_pt = %u, turn_pt = %u\n",
> +			   svsb->name, svsb->vbin_turn_pt, svsb->turn_pt);
>   	else
> -		seq_printf(m, "%s: temperature = %d, turn_pt = %u\n",
> -			   svsb->name, tzone_temp, svsb->turn_pt);
> +		seq_printf(m, "%s: temperature = %d, vbin_turn_pt = %u, turn_pt = %u\n",
> +			   svsb->name, tzone_temp, svsb->vbin_turn_pt,
> +			   svsb->turn_pt);
>   
>   	for (i = 0; i < svsb->opp_count; i++) {
>   		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
> @@ -952,6 +955,29 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
>   	for (i = opp_start; i < opp_stop; i++)
>   		if (svsb->volt_flags & SVSB_REMOVE_DVTFIXED_VOLT)
>   			svsb->volt[i] -= svsb->dvt_fixed;
> +
> +	/* For voltage bin support */
> +	if (svsb->opp_dfreq[0] > svsb->freq_base) {
> +		svsb->volt[0] = svs_opp_volt_to_bank_volt(svsb->opp_dvolt[0],
> +							  svsb->volt_step,
> +							  svsb->volt_base);
> +
> +		/* Find voltage bin turn point */
> +		for (i = 0; i < svsb->opp_count; i++) {
> +			if (svsb->opp_dfreq[i] <= svsb->freq_base) {
> +				svsb->vbin_turn_pt = i;
> +				break;
> +			}
> +		}
> +
> +		/* Override svs bank voltages */
> +		for (i = 1; i < svsb->vbin_turn_pt; i++)
> +			svsb->volt[i] = interpolate(svsb->freq_pct[0],
> +						    svsb->freq_pct[svsb->vbin_turn_pt],
> +						    svsb->volt[0],
> +						    svsb->volt[svsb->vbin_turn_pt],
> +						    svsb->freq_pct[i]);
> +	}

This looks like being a new feature that applies to more than just MT8188?
Goes into a different commit.

>   }
>   
>   static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
> @@ -1808,6 +1834,80 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
>   	return true;
>   }
>   
> +static bool svs_mt8188_efuse_parsing(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb;
> +	struct nvmem_cell *cell;
> +	u32 idx, i, golden_temp;
> +
> +	for (i = 0; i < svsp->efuse_max; i++)
> +		if (svsp->efuse[i])
> +			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
> +				 i, svsp->efuse[i]);
> +
> +	if (!svsp->efuse[5]) {
> +		dev_notice(svsp->dev, "svs_efuse[5] = 0x0?\n");
> +		return false;
> +	}
> +
> +	/* Svs efuse parsing */
> +	for (idx = 0; idx < svsp->bank_max; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		if (svsb->type == SVSB_LOW) {
> +			svsb->mtdes = svsp->efuse[5] & GENMASK(7, 0);
> +			svsb->bdes = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
> +			svsb->mdes = (svsp->efuse[5] >> 24) & GENMASK(7, 0);
> +			svsb->dcbdet = (svsp->efuse[15] >> 16) & GENMASK(7, 0);
> +			svsb->dcmdet = (svsp->efuse[15] >> 24) & GENMASK(7, 0);
> +		} else if (svsb->type == SVSB_HIGH) {
> +			svsb->mtdes = svsp->efuse[4] & GENMASK(7, 0);
> +			svsb->bdes = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
> +			svsb->mdes = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
> +			svsb->dcbdet = svsp->efuse[14] & GENMASK(7, 0);
> +			svsb->dcmdet = (svsp->efuse[14] >> 8) & GENMASK(7, 0);
> +		}
> +
> +		svsb->vmax += svsb->dvt_fixed;
> +	}

The only change between mt8192, 8195 and 8188 is this for loop; can we please
commonize the rest of the function?

> +
> +	/* Thermal efuse parsing */
> +	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
> +	if (IS_ERR_OR_NULL(cell)) {
> +		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n",
> +			PTR_ERR(cell));
> +		return false;
> +	}
> +
> +	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
> +	if (IS_ERR(svsp->tefuse)) {
> +		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
> +			PTR_ERR(svsp->tefuse));
> +		nvmem_cell_put(cell);
> +		return false;
> +	}
> +
> +	svsp->tefuse_max /= sizeof(u32);
> +	nvmem_cell_put(cell);
> +
> +	for (i = 0; i < svsp->tefuse_max; i++)
> +		if (svsp->tefuse[i] != 0)
> +			break;
> +
> +	if (i == svsp->tefuse_max)
> +		golden_temp = 50; /* All thermal efuse data are 0 */
> +	else
> +		golden_temp = (svsp->tefuse[0] & GENMASK(31, 24)) >> 24;
> +
> +	for (idx = 0; idx < svsp->bank_max; idx++) {
> +		svsb = &svsp->banks[idx];
> +		svsb->mts = 500;
> +		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
> +	}
> +
> +	return true;
> +}
> +
>   static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
>   {
>   	struct svs_bank *svsb;
> @@ -2052,7 +2152,7 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
>   		return dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
>   				     "cannot get svs reset control\n");
>   
> -	dev = svs_add_device_link(svsp, "lvts");
> +	dev = svs_add_device_link(svsp, "thermal-sensor");

This is a fix that must go in a different commit with a Fixes tag.

>   	if (IS_ERR(dev))
>   		return dev_err_probe(svsp->dev, PTR_ERR(dev),
>   				     "failed to get lvts device\n");
> @@ -2173,6 +2273,61 @@ static struct svs_bank svs_mt8192_banks[] = {
>   	},
>   };
>   

Regards,
Angelo

