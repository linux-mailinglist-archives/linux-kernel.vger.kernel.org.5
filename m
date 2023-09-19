Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706337A604F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjISK4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjISK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:56:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E910FD;
        Tue, 19 Sep 2023 03:52:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD76A66071A9;
        Tue, 19 Sep 2023 11:52:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695120763;
        bh=QcGJGu+vMVFM/Aga4X3LUn1iwVKSKDmFF54awTg/A70=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XsYzeYGM1Z6puB66ZRn9YFFXiS7eKo+82uLha4cqjDWTxx5Ec39nbpzubtY10lqrQ
         Qvt0RPzjRjlmpzR8bZhP3389PEnOUeN1gKCxhaGGHTZOUGr2H8bmDRIcbUllbUEvvq
         BcmKHcgMRDLHjzFVMVmFTDBnNR9xp+jBOZQYasl7vJnispz9JpSxtWVnf2YpfR0sD1
         bYGrY8Sy2b8QTva3Xt+L51e/0LtdbJCc1KC+JkG8sYnezT26CJaj9mVy/9BvZ000G1
         snpkpLcE1Xs+AFk8O8syZ/ZTwdS1XBFhBuXsmuGz0xP0T09geJRF3TSBL9VxssKdsr
         cpNbmDD5tOJsA==
Message-ID: <0009f224-aac4-6681-fde5-cf1ead94c604@collabora.com>
Date:   Tue, 19 Sep 2023 12:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/2] soc: mediatek: svs: add support for mt8188
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
References: <20230919014439.5795-1-chun-jen.tseng@mediatek.com>
 <20230919014439.5795-3-chun-jen.tseng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230919014439.5795-3-chun-jen.tseng@mediatek.com>
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

Il 19/09/23 03:44, Mark Tseng ha scritto:
> MT8188 svs gpu uses 2-line high bank and low bank to optimize the
> voltage of opp table for higher and lower frequency respectively.
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 184 ++++++++++++++++++++++++++++++++-
>   1 file changed, 180 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 3a2f97cd5272..f31e3bedff50 100644
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

I already asked you to please send the voltage bin support as a separated commit
because this is for *all SoCs* and not only for 8188.

Again, please separate the voltage bin support from the MT8188 support.

soc: mediatek: svs: Add support for voltage bins
soc: mediatek: svs: Add support for MT8188 SoC

Regards,
Angelo

