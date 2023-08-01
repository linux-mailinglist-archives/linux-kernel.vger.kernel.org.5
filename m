Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E576B503
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjHAMsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjHAMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:48:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D35E6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:48:39 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qQonB-0004wo-0E; Tue, 01 Aug 2023 14:48:01 +0200
Message-ID: <bf2979c4-0b63-be53-b530-3d7385796534@pengutronix.de>
Date:   Tue, 1 Aug 2023 14:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause the TXC clock in
 fixed-link
Content-Language: en-US, de-DE
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
        Frank Li <frank.li@nxp.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-3-shenwei.wang@nxp.com>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <20230731161929.2341584-3-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenwei,

thanks for your patch.

On 7/31/23 18:19, Shenwei Wang wrote:
> When using a fixed-link setup, certain devices like the SJA1105 require a
> small pause in the TXC clock line to enable their internal tunable
> delay line (TDL).

If this is only required for some devices, is it safe to enforce this behaviour 
unconditionally for any kind of fixed link devices connected to the MX93 EQOS 
or could this possibly break for other devices?

Best regards
Johannes

> 
> To satisfy this requirement, this patch temporarily disables the TX clock,
> and restarts it after a required period. This provides the required
> silent interval on the clock line for SJA1105 to complete the frequency
> transition and enable the internal TDLs.
> 
> So far we have only enabled this feature on the i.MX93 platform.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index 53ee5a42c071..2e4173d099f3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -32,6 +32,7 @@
>   #define GPR_ENET_QOS_RGMII_EN		(0x1 << 21)
>   
>   #define MX93_GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(3, 0)
> +#define MX93_GPR_ENET_QOS_INTF_MASK		GENMASK(3, 1)
>   #define MX93_GPR_ENET_QOS_INTF_SEL_MII		(0x0 << 1)
>   #define MX93_GPR_ENET_QOS_INTF_SEL_RMII		(0x4 << 1)
>   #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	(0x1 << 1)
> @@ -40,6 +41,7 @@
>   #define DMA_BUS_MODE			0x00001000
>   #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
>   #define RMII_RESET_SPEED		(0x3 << 14)
> +#define CTRL_SPEED_MASK			GENMASK(15, 14)
>   
>   struct imx_dwmac_ops {
>   	u32 addr_width;
> @@ -56,6 +58,7 @@ struct imx_priv_data {
>   	struct regmap *intf_regmap;
>   	u32 intf_reg_off;
>   	bool rmii_refclk_ext;
> +	void __iomem *base_addr;
>   
>   	const struct imx_dwmac_ops *ops;
>   	struct plat_stmmacenet_data *plat_dat;
> @@ -212,6 +215,42 @@ static void imx_dwmac_fix_speed(void *priv, uint speed, uint mode)
>   		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
>   }
>   
> +static void imx_dwmac_fix_speed_mx93(void *priv, uint speed, uint mode)
> +{
> +	struct imx_priv_data *dwmac = priv;
> +	int ctrl, old_ctrl, iface;
> +
> +	imx_dwmac_fix_speed(priv, speed, mode);
> +
> +	if (!dwmac || mode != MLO_AN_FIXED)
> +		return;
> +
> +	if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface))
> +		return;
> +
> +	iface &= MX93_GPR_ENET_QOS_INTF_MASK;
> +	if (iface != MX93_GPR_ENET_QOS_INTF_SEL_RGMII)
> +		return;
> +
> +	old_ctrl = readl(dwmac->base_addr + MAC_CTRL_REG);
> +	ctrl = old_ctrl & ~CTRL_SPEED_MASK;
> +	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> +			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
> +	writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
> +
> +	/* Ensure the settings for CTRL are applied and avoid CPU/Compiler
> +	 * reordering.
> +	 */
> +	wmb();
> +
> +	usleep_range(10, 20);
> +	iface |= MX93_GPR_ENET_QOS_CLK_GEN_EN;
> +	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> +			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
> +
> +	writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG);
> +}
> +
>   static int imx_dwmac_mx93_reset(void *priv, void __iomem *ioaddr)
>   {
>   	struct plat_stmmacenet_data *plat_dat = priv;
> @@ -317,8 +356,11 @@ static int imx_dwmac_probe(struct platform_device *pdev)
>   	plat_dat->exit = imx_dwmac_exit;
>   	plat_dat->clks_config = imx_dwmac_clks_config;
>   	plat_dat->fix_mac_speed = imx_dwmac_fix_speed;
> +	if (of_machine_is_compatible("fsl,imx93"))
> +		plat_dat->fix_mac_speed = imx_dwmac_fix_speed_mx93;
>   	plat_dat->bsp_priv = dwmac;
>   	dwmac->plat_dat = plat_dat;
> +	dwmac->base_addr = stmmac_res.addr;
>   
>   	ret = imx_dwmac_clks_config(dwmac, true);
>   	if (ret)

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

