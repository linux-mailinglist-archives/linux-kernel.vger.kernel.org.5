Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB58D763685
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjGZMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjGZMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:41:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A47269A;
        Wed, 26 Jul 2023 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690375311; x=1721911311;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=VqkcfOeBmVVhj1BJf0tLq+PPuMnNtkgeiPGwDuSDfOo=;
  b=OSgLJsQ+Fq60VjA+UXhV910d06YGcojEdN4mlAXLv5NTF24XypWjlGs+
   rPz/X/U3b82lyxZhnRSWNCYAroWxHqqSboKiTCgCn4g9rQy1uLrHFE6G+
   oVG5A+AL2fHbT4UQSpjLF300u8I7bH2xQgs6D8m+R1OSVBw1aJUzpX96t
   lWIn3cUgsyn3dDERv9Pq3MC5c8/sFteojJi86nR9ClgRkNO9fNm3T3lYo
   AzkaXghvJU5x3KjjA0dS62BsUMhRsmm+/F1LaXTOcb0/aoV8lPZBFr6nQ
   Br64gjmKuHLYxkniXhemUPzwlQeB/7z6reW4uBsFkv587fL6Z4TrCfvG4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347617529"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="347617529"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="676683367"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="676683367"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.75])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:41:46 -0700
Message-ID: <a2853d8c-00b6-9772-652b-556d503f3cc8@intel.com>
Date:   Wed, 26 Jul 2023 15:41:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 2/6] mmc: sdhci-cadence: Restructure the code
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>,
        Brad Larson <blarson@amd.com>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
 <20230717125146.16791-3-pmalgujar@marvell.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230717125146.16791-3-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/23 15:51, Piyush Malgujar wrote:
> From: Dhananjay Kangude <dkangude@cadence.com>
> 
> Restructured the code, added controller version specific init for
> SD4 operations with no change to existing functionality.
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 76 ++++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 9bb38281bcb244b0be91ef579046c40de7a06e1f..98fe752bcf27a71607623f3cb1c36f1a16d688a4 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -60,11 +60,17 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>  
> +struct sdhci_cdns_priv;

Unnecessary forward declaration.

> +
>  struct sdhci_cdns_sd4_phy_param {
>  	u8 addr;
>  	u8 data;
>  };
>  
> +struct sdhci_cdns_sd4_phy {
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns_sd4_phy_param phy_params[];
> +};
>  struct sdhci_cdns_priv {
>  	void __iomem *hrs_addr;
>  	void __iomem *ctl_addr;	/* write control */
> @@ -72,8 +78,8 @@ struct sdhci_cdns_priv {
>  	bool enhanced_strobe;
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
> -	unsigned int nr_phy_params;
> -	struct sdhci_cdns_sd4_phy_param phy_params[];
> +	const struct sdhci_cdns_drv_data *cdns_data;
> +	void *phy;
>  };
>  
>  struct sdhci_cdns_sd4_phy_cfg {
> @@ -83,6 +89,8 @@ struct sdhci_cdns_sd4_phy_cfg {
>  
>  struct sdhci_cdns_drv_data {
>  	int (*init)(struct platform_device *pdev);
> +	int (*phy_init)(struct sdhci_cdns_priv *priv);
> +	int (*phy_probe)(struct platform_device *pdev, struct sdhci_cdns_priv *priv);
>  	const struct sdhci_pltfm_data pltfm_data;
>  };
>  
> @@ -151,9 +159,9 @@ static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
>  }
>  
>  static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
> -					   struct sdhci_cdns_priv *priv)
> +					   struct sdhci_cdns_sd4_phy *phy)
>  {
> -	struct sdhci_cdns_sd4_phy_param *p = priv->phy_params;
> +	struct sdhci_cdns_sd4_phy_param *p = phy->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> @@ -172,10 +180,11 @@ static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
>  static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
>  {
>  	int ret, i;
> +	struct sdhci_cdns_sd4_phy *phy = priv->phy;
>  
> -	for (i = 0; i < priv->nr_phy_params; i++) {
> -		ret = sdhci_cdns_sd4_write_phy_reg(priv, priv->phy_params[i].addr,
> -						   priv->phy_params[i].data);
> +	for (i = 0; i < phy->nr_phy_params; i++) {
> +		ret = sdhci_cdns_sd4_write_phy_reg(priv, phy->phy_params[i].addr,
> +						   phy->phy_params[i].data);
>  		if (ret)
>  			return ret;
>  	}
> @@ -218,6 +227,27 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>  	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
>  }
>  
> +static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
> +				    struct sdhci_cdns_priv *priv)
> +{
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns_sd4_phy *phy;
> +	struct device *dev = &pdev->dev;
> +
> +	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
> +	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
> +			   GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->nr_phy_params = nr_phy_params;
> +
> +	sdhci_cdns_sd4_phy_param_parse(dev->of_node, phy);
> +	priv->phy = phy;
> +
> +	return 0;
> +}
> +
>  static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
>  {
>  	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> @@ -420,6 +450,8 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
>  };
>  
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
> +	.phy_init = sdhci_cdns_sd4_phy_init,
> +	.phy_probe = sdhci_cdns_sd4_phy_probe,
>  	.pltfm_data = {
>  	.ops = &sdhci_cdns_sd4_ops,
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> @@ -428,12 +460,16 @@ static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  
>  static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
>  	.init = elba_drv_init,
> +	.phy_init = sdhci_cdns_sd4_phy_init,
> +	.phy_probe = sdhci_cdns_sd4_phy_probe,
>  	.pltfm_data = {
>  		.ops = &sdhci_elba_ops,
>  	},
>  };
>  
>  static const struct sdhci_cdns_drv_data sdhci_cdns_sd4_drv_data = {
> +	.phy_init = sdhci_cdns_sd4_phy_init,
> +	.phy_probe = sdhci_cdns_sd4_phy_probe,
>  	.pltfm_data = {
>  		.ops = &sdhci_cdns_sd4_ops,
>  	},
> @@ -482,7 +518,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> -	unsigned int nr_phy_params;
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> @@ -496,12 +531,12 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	data = of_device_get_match_data(dev);
> -	if (!data)
> -		data = &sdhci_cdns_sd4_drv_data;

Why change this?

> +	if (!data) {
> +		ret = -EINVAL;
> +		goto disable_clk;
> +	}
>  
> -	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
> -	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
> -				struct_size(priv, phy_params, nr_phy_params));
> +	host = sdhci_pltfm_init(pdev, &data->pltfm_data, sizeof(*priv));
>  	if (IS_ERR(host)) {
>  		ret = PTR_ERR(host);
>  		goto disable_clk;
> @@ -511,10 +546,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	pltfm_host->clk = clk;
>  
>  	priv = sdhci_pltfm_priv(pltfm_host);
> -	priv->nr_phy_params = nr_phy_params;
>  	priv->hrs_addr = host->ioaddr;
>  	priv->enhanced_strobe = false;
>  	priv->priv_writel = cdns_writel;
> +	priv->cdns_data = data;
>  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;
> @@ -532,9 +567,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free;
>  
> -	sdhci_cdns_sd4_phy_param_parse(dev->of_node, priv);
> +	ret = data->phy_probe(pdev, priv);
> +	if (ret)
> +		goto free;
>  
> -	ret = sdhci_cdns_sd4_phy_init(priv);
> +	ret = priv->cdns_data->phy_init(priv);

data->phy_init() would be consistent with data->phy_probe()
instead of priv->cdns_data->phy_init()

>  	if (ret)
>  		goto free;
>  
> @@ -574,7 +611,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = sdhci_cdns_sd4_phy_init(priv);
> +	ret = priv->cdns_data->phy_init(priv);
>  	if (ret)
>  		goto disable_clk;
>  
> @@ -604,7 +641,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "amd,pensando-elba-sd4hc",
>  		.data = &sdhci_elba_drv_data,
>  	},
> -	{ .compatible = "cdns,sd4hc" },
> +	{
> +		.compatible = "cdns,sd4hc",
> +		.data = &sdhci_cdns_sd4_drv_data,

Why change this?

> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_cdns_match);

