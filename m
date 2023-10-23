Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0347D2B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjJWHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:37:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40979E6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698046628; x=1729582628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BVXcvER3gZF7y+IzMnHXvHQ3bk1djiH+VHPIzDVb9jI=;
  b=gD7VaA5YpNgOAHGqMfjgDLrAgFqFRQ3nXm32F1+p7Yuo/fsSjd/XVObS
   pE/RS/WZsowqe2hLk1kyCYNKVZGnd3RbCCmOqbd2wSv/I2HwNrgxR85s8
   Y5riUicoAajh9QdRNikrVn5AR/gIE0ifZzzuHEdsYk4aJ0pNjl+rtU/NG
   dk9/mZXdOaX56DGh7XJR+PjUHfeV2SeyiKBIPZpo+YfTMn9MTkqv6uqmK
   wZwpUkXsK7RbxwGEdIFcCiPii83NUivd6Chs61vDrj9kUNcVwvg2gf0cW
   /+xHXI82zfV9otMNmoHrABoQPYyeagmVrGSOoTERL8mxYotAOvzjopImJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="453256541"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="453256541"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 00:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="1005225982"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="1005225982"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91]) ([10.94.0.91])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 00:37:03 -0700
Message-ID: <b3be3317-218a-48fd-907a-287bdcbec66f@linux.intel.com>
Date:   Mon, 23 Oct 2023 09:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] ASoC: amd: acp: refactor acp i2s clock generation
 code
Content-Language: en-US
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        venkataprasad.potturu@amd.com, arungopal.kondaveeti@amd.com,
        mastan.katragadda@amd.com, juan.martinez@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
 <20231021145110.478744-2-Syed.SabaKareem@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20231021145110.478744-2-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2023 4:50 PM, Syed Saba Kareem wrote:
> Refactor acp i2s LRCLK,BCLK generation code and move to commnon file.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> ---
>   sound/soc/amd/acp/acp-i2s.c | 32 ++++++++++++++++++++++++++++++
>   sound/soc/amd/acp/amd.h     | 39 -------------------------------------
>   2 files changed, 32 insertions(+), 39 deletions(-)
> 
> diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
> index df350014966a..59d3a499771a 100644
> --- a/sound/soc/amd/acp/acp-i2s.c
> +++ b/sound/soc/amd/acp/acp-i2s.c
> @@ -20,10 +20,42 @@
>   #include <sound/soc.h>
>   #include <sound/soc-dai.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/bitfield.h>
>   
>   #include "amd.h"
>   
>   #define DRV_NAME "acp_i2s_playcap"
> +#define	I2S_MASTER_MODE_ENABLE		1
> +#define	I2S_MODE_ENABLE			0
> +#define	I2S_FORMAT_MODE			GENMASK(1, 1)
> +#define	LRCLK_DIV_FIELD			GENMASK(10, 2)
> +#define	BCLK_DIV_FIELD			GENMASK(23, 11)
> +
> +static inline void acp_set_i2s_clk(struct acp_dev_data *adata, int dai_id)
> +{
> +	u32 i2s_clk_reg, val;
> +
> +	switch (dai_id) {
> +	case I2S_SP_INSTANCE:
> +		i2s_clk_reg = ACP_I2STDM0_MSTRCLKGEN;
> +		break;
> +	case I2S_BT_INSTANCE:
> +		i2s_clk_reg = ACP_I2STDM1_MSTRCLKGEN;
> +		break;
> +	case I2S_HS_INSTANCE:
> +		i2s_clk_reg = ACP_I2STDM2_MSTRCLKGEN;
> +		break;
> +	default:
> +		i2s_clk_reg = ACP_I2STDM0_MSTRCLKGEN;
> +		break;
> +	}
> +
> +	val  = I2S_MASTER_MODE_ENABLE;
> +	val |= I2S_MODE_ENABLE & BIT(1);

There is I2S_FORMAT_MODE define, you probably want to use it instead of 
BIT(1), so there is no "magic number" mask?

> +	val |= FIELD_PREP(LRCLK_DIV_FIELD, adata->lrclk_div);
> +	val |= FIELD_PREP(BCLK_DIV_FIELD, adata->bclk_div);
> +	writel(val, adata->acp_base + i2s_clk_reg);
> +}
>   
>   static int acp_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
>   			   unsigned int fmt)
> diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
> index 487eefa5985f..87d1e1f7d6b6 100644
> --- a/sound/soc/amd/acp/amd.h
> +++ b/sound/soc/amd/acp/amd.h
> @@ -188,17 +188,6 @@ struct acp_dev_data {
>   	u32 xfer_rx_resolution[3];
>   };
>   
> -union acp_i2stdm_mstrclkgen {
> -	struct {
> -		u32 i2stdm_master_mode : 1;
> -		u32 i2stdm_format_mode : 1;
> -		u32 i2stdm_lrclk_div_val : 9;
> -		u32 i2stdm_bclk_div_val : 11;
> -		u32:10;
> -	} bitfields, bits;
> -	u32  u32_all;
> -};
> -
>   extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
>   extern const struct snd_soc_dai_ops acp_dmic_dai_ops;
>   
> @@ -276,32 +265,4 @@ static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int
>   POINTER_RETURN_BYTES:
>   	return byte_count;
>   }
> -
> -static inline void acp_set_i2s_clk(struct acp_dev_data *adata, int dai_id)
> -{
> -	union acp_i2stdm_mstrclkgen mclkgen;
> -	u32 master_reg;
> -
> -	switch (dai_id) {
> -	case I2S_SP_INSTANCE:
> -		master_reg = ACP_I2STDM0_MSTRCLKGEN;
> -		break;
> -	case I2S_BT_INSTANCE:
> -		master_reg = ACP_I2STDM1_MSTRCLKGEN;
> -		break;
> -	case I2S_HS_INSTANCE:
> -		master_reg = ACP_I2STDM2_MSTRCLKGEN;
> -		break;
> -	default:
> -		master_reg = ACP_I2STDM0_MSTRCLKGEN;
> -		break;
> -	}
> -
> -	mclkgen.bits.i2stdm_master_mode = 0x1;
> -	mclkgen.bits.i2stdm_format_mode = 0x00;
> -
> -	mclkgen.bits.i2stdm_bclk_div_val = adata->bclk_div;
> -	mclkgen.bits.i2stdm_lrclk_div_val = adata->lrclk_div;
> -	writel(mclkgen.u32_all, adata->acp_base + master_reg);
> -}
>   #endif

