Return-Path: <linux-kernel+bounces-9576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B281C7D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D8F286386
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28A10A0C;
	Fri, 22 Dec 2023 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB8q/XDy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96EB12E4B;
	Fri, 22 Dec 2023 10:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B267BC433C7;
	Fri, 22 Dec 2023 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703239657;
	bh=HhsKhELSaEHPdEC+e4lvoyNgygmS/hEMwtiEkDSIKzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fB8q/XDy4fQ0/f8zO1+P98aJMbnBPSRcSDiRGBttfw6ADYhbiR4tUeHe46t3IJ2+e
	 TSfTjCs7sG5+QB3rmIRnXdZED123RLgEQBSSVvtPynmHI94mm/2MYvpOM/WvQFhWzT
	 VeLMjhl1UY7lGGbGThStV0ib/XK/eJJjGLymDEafxnzgVBU9D05MTeFZAXqzXoEDzV
	 ZZ1M80Cl9sd7TPZsJVcIMfaDhWuaDuQOEFM63/lnLoX+3kcB4LW7B8Jqd3fqVi6V9j
	 mCAce/rhQaRtoUQLKNlyFPbSTXDn/QOXzXxhX/iH6Ugw+z/C8YUWlBHafaHnz8OcRy
	 DlCOrRifpF8Ow==
Message-ID: <48e124d7-94d3-47b2-82c3-db6d0d6fdefd@kernel.org>
Date: Fri, 22 Dec 2023 12:07:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] phy: cadence-torrent: Add PCIe(100MHz) +
 USXGMII(156.25MHz) multilink configuration
Content-Language: en-US
To: Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
 kishon@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: mparab@cadence.com, s-vadapalli@ti.com
References: <20231221162051.2131202-1-sjakhade@cadence.com>
 <20231221162051.2131202-3-sjakhade@cadence.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231221162051.2131202-3-sjakhade@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Swapnil,

On 21/12/2023 18:20, Swapnil Jakhade wrote:
> Torrent PHY can have separate input reference clocks for PLL0 and PLL1.
> Add support for dual reference clock multilink configurations.
> 
> Add register sequences for PCIe(100MHz) + USXGMII(156.25MHz) multilink
> configuration. PCIe uses PLL0 and USXGMII uses PLL1.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 194 +++++++++++++++++++++-
>  1 file changed, 191 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index a75c96385c57..18ec49c9a76e 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -355,7 +355,9 @@ struct cdns_torrent_phy {
>  	struct reset_control *apb_rst;
>  	struct device *dev;
>  	struct clk *clk;
> +	struct clk *clk1;
>  	enum cdns_torrent_ref_clk ref_clk_rate;
> +	enum cdns_torrent_ref_clk ref_clk1_rate;
>  	struct cdns_torrent_inst phys[MAX_NUM_LANES];
>  	int nsubnodes;
>  	const struct cdns_torrent_data *init_data;
> @@ -2460,9 +2462,11 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  {
>  	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
>  	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
> +	enum cdns_torrent_ref_clk ref_clk1 = cdns_phy->ref_clk1_rate;
>  	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
>  	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
>  	enum cdns_torrent_phy_type phy_t1, phy_t2;
> +	struct cdns_torrent_vals *phy_pma_cmn_vals;
>  	struct cdns_torrent_vals *pcs_cmn_vals;
>  	int i, j, node, mlane, num_lanes, ret;
>  	struct cdns_reg_pairs *reg_pairs;
> @@ -2489,6 +2493,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  			 * Get the array values as [phy_t2][phy_t1][ssc].
>  			 */
>  			swap(phy_t1, phy_t2);
> +			swap(ref_clk, ref_clk1);
>  		}
>  
>  		mlane = cdns_phy->phys[node].mlane;
> @@ -2552,9 +2557,22 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  					     reg_pairs[i].val);
>  		}
>  
> +		/* PHY PMA common registers configurations */
> +		phy_pma_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->phy_pma_cmn_vals_tbl,
> +							     CLK_ANY, CLK_ANY,
> +							     phy_t1, phy_t2, ANY_SSC);
> +		if (phy_pma_cmn_vals) {
> +			reg_pairs = phy_pma_cmn_vals->reg_pairs;
> +			num_regs = phy_pma_cmn_vals->num_regs;
> +			regmap = cdns_phy->regmap_phy_pma_common_cdb;
> +			for (i = 0; i < num_regs; i++)
> +				regmap_write(regmap, reg_pairs[i].off,
> +					     reg_pairs[i].val);
> +		}
> +
>  		/* PMA common registers configurations */
>  		cmn_vals = cdns_torrent_get_tbl_vals(&init_data->cmn_vals_tbl,
> -						     ref_clk, ref_clk,
> +						     ref_clk, ref_clk1,
>  						     phy_t1, phy_t2, ssc);
>  		if (cmn_vals) {
>  			reg_pairs = cmn_vals->reg_pairs;
> @@ -2567,7 +2585,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  
>  		/* PMA TX lane registers configurations */
>  		tx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->tx_ln_vals_tbl,
> -						       ref_clk, ref_clk,
> +						       ref_clk, ref_clk1,
>  						       phy_t1, phy_t2, ssc);
>  		if (tx_ln_vals) {
>  			reg_pairs = tx_ln_vals->reg_pairs;
> @@ -2582,7 +2600,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  
>  		/* PMA RX lane registers configurations */
>  		rx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->rx_ln_vals_tbl,
> -						       ref_clk, ref_clk,
> +						       ref_clk, ref_clk1,
>  						       phy_t1, phy_t2, ssc);
>  		if (rx_ln_vals) {
>  			reg_pairs = rx_ln_vals->reg_pairs;
> @@ -2684,9 +2702,11 @@ static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
>  static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
>  {
>  	struct device *dev = cdns_phy->dev;
> +	unsigned long ref_clk1_rate;
>  	unsigned long ref_clk_rate;
>  	int ret;
>  
> +	/* refclk: Input reference clock for PLL0 */
>  	cdns_phy->clk = devm_clk_get(dev, "refclk");
>  	if (IS_ERR(cdns_phy->clk)) {
>  		dev_err(dev, "phy ref clock not found\n");
> @@ -2725,7 +2745,54 @@ static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
>  		return -EINVAL;
>  	}
>  
> +	/* refclk1: Input reference clock for PLL1 */
> +	cdns_phy->clk1 = devm_clk_get_optional(dev, "pll1_refclk");
> +	if (IS_ERR(cdns_phy->clk1)) {
> +		dev_err(dev, "phy pll1 ref clock not found\n");
> +		return PTR_ERR(cdns_phy->clk1);

Don't you need to disable cdns_phy->clk before exititing?
So 
		ret = PTR_ERR(cdns_phy->clk1);
		goto disbale_clk;

> +	}
> +
> +	if (cdns_phy->clk1) {
> +		ret = clk_prepare_enable(cdns_phy->clk1);
> +		if (ret) {
> +			dev_err(cdns_phy->dev, "Failed to prepare pll1 ref clock\n");
nit, pll should be all uppercase in error messages. so "PLL1"?
Do you wan't to dump the return error code as well so it is easier to report/debug?

> +			clk_disable_unprepare(cdns_phy->clk);
> +			return ret;
Instead of above 2 lines, just: 
			goto disable_clk.

> +		}
> +
> +		ref_clk1_rate = clk_get_rate(cdns_phy->clk1);
> +		if (!ref_clk1_rate) {
> +			dev_err(cdns_phy->dev, "Failed to get pll1 ref clock rate\n");
> +			goto refclk1_err;

For consistency let's call this label disable_clk1

> +		}
> +
> +		switch (ref_clk1_rate) {
> +		case REF_CLK_19_2MHZ:
> +			cdns_phy->ref_clk1_rate = CLK_19_2_MHZ;
> +			break;
> +		case REF_CLK_25MHZ:
> +			cdns_phy->ref_clk1_rate = CLK_25_MHZ;
> +			break;
> +		case REF_CLK_100MHZ:
> +			cdns_phy->ref_clk1_rate = CLK_100_MHZ;
> +			break;
> +		case REF_CLK_156_25MHZ:
> +			cdns_phy->ref_clk1_rate = CLK_156_25_MHZ;
> +			break;
> +		default:
> +			dev_err(cdns_phy->dev, "Invalid pll1 ref clock rate\n");
> +			goto refclk1_err;
> +		}
> +	} else {
> +		cdns_phy->ref_clk1_rate = cdns_phy->ref_clk_rate;
> +	}
> +
>  	return 0;
> +
> +refclk1_err:
> +	clk_disable_unprepare(cdns_phy->clk1);

disable_clk:

> +	clk_disable_unprepare(cdns_phy->clk);
> +	return -EINVAL;

return ret. We need to preserve why the failure
happened so it is easier to debug.

>  }
>  
>  static int cdns_torrent_phy_probe(struct platform_device *pdev)
> @@ -2981,6 +3048,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  	of_node_put(child);
>  	reset_control_assert(cdns_phy->apb_rst);
>  	clk_disable_unprepare(cdns_phy->clk);
> +	clk_disable_unprepare(cdns_phy->clk1);

No sure if it matters, but for symmetry sake should we disable clk1 before clk?

>  clk_cleanup:
>  	cdns_torrent_clk_cleanup(cdns_phy);
>  	return ret;
> @@ -2999,6 +3067,7 @@ static void cdns_torrent_phy_remove(struct platform_device *pdev)
>  	}
>  
>  	clk_disable_unprepare(cdns_phy->clk);
> +	clk_disable_unprepare(cdns_phy->clk1);

Here too.

>  	cdns_torrent_clk_cleanup(cdns_phy);
>  }
>  
> @@ -3034,6 +3103,100 @@ static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
>  	.num_regs = ARRAY_SIZE(dp_usb_xcvr_diag_ln_regs),
>  };

<snip>

-- 
cheers,
-roger

