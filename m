Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCCE76D04D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjHBOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjHBOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:41:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46778E0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:41:18 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qRD1e-0002R7-VB; Wed, 02 Aug 2023 16:40:35 +0200
Message-ID: <49d52a10-20cf-9c5b-ebe3-07292664fe11@pengutronix.de>
Date:   Wed, 2 Aug 2023 16:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
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
        dl-linux-imx <linux-imx@nxp.com>,
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
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Frank Li <frank.li@nxp.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-3-shenwei.wang@nxp.com>
 <bf2979c4-0b63-be53-b530-3d7385796534@pengutronix.de>
 <PAXPR04MB9185D7D3B088E4786A216044890AA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <e32c89e1-7385-105b-63c9-74f58c2253cb@pengutronix.de>
 <PAXPR04MB91851BB5D1375AF0EF3C51B7890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <PAXPR04MB91851BB5D1375AF0EF3C51B7890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenwei,

On 8/2/23 16:27, Shenwei Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Johannes Zink <j.zink@pengutronix.de>
>> Sent: Wednesday, August 2, 2023 1:26 AM
>> To: Shenwei Wang <shenwei.wang@nxp.com>; Russell King
>> <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; Maxime Coquelin
>> <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
>> Hauer <s.hauer@pengutronix.de>; Neil Armstrong <neil.armstrong@linaro.org>;
>> Kevin Hilman <khilman@baylibre.com>; Vinod Koul <vkoul@kernel.org>; Chen-
>> Yu Tsai <wens@csie.org>; Jernej Skrabec <jernej.skrabec@gmail.com>; Samuel
>> Holland <samuel@sholland.org>
>> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
>> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
>> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
>> <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jerome Brunet
>> <jbrunet@baylibre.com>; Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com>; Bhupesh Sharma
>> <bhupesh.sharma@linaro.org>; Nobuhiro Iwamatsu
>> <nobuhiro1.iwamatsu@toshiba.co.jp>; Simon Horman
>> <simon.horman@corigine.com>; Andrew Halaney <ahalaney@redhat.com>;
>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>; Wong Vee Khee
>> <veekhee@apple.com>; Revanth Kumar Uppala <ruppala@nvidia.com>; Jochen
>> Henneberg <jh@henneberg-systemdesign.com>; netdev@vger.kernel.org; linux-
>> stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; linux-amlogic@lists.infradead.org;
>> imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
>> Subject: Re: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause the
>> TXC clock in fixed-link
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report this
>> email' button
>>
>>
>> Hi Shenwei,
>>
>> On 8/1/23 19:10, Shenwei Wang wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Johannes Zink <j.zink@pengutronix.de>
>>>> Sent: Tuesday, August 1, 2023 7:48 AM
>>>> To: Shenwei Wang <shenwei.wang@nxp.com>; Russell King
>>>> <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric
>>>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>>>> Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin
>>>> <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
>> Sascha
>>>> Hauer <s.hauer@pengutronix.de>; Neil Armstrong
>>>> <neil.armstrong@linaro.org>; Kevin Hilman <khilman@baylibre.com>;
>>>> Vinod Koul <vkoul@kernel.org>; Chen- Yu Tsai <wens@csie.org>; Jernej
>>>> Skrabec <jernej.skrabec@gmail.com>; Samuel Holland
>>>> <samuel@sholland.org>
>>>> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
>>>> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
>>>> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
>>>> <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jerome Brunet
>>>> <jbrunet@baylibre.com>; Martin Blumenstingl
>>>> <martin.blumenstingl@googlemail.com>; Bhupesh Sharma
>>>> <bhupesh.sharma@linaro.org>; Nobuhiro Iwamatsu
>>>> <nobuhiro1.iwamatsu@toshiba.co.jp>; Simon Horman
>>>> <simon.horman@corigine.com>; Andrew Halaney <ahalaney@redhat.com>;
>>>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>; Wong Vee Khee
>>>> <veekhee@apple.com>; Revanth Kumar Uppala <ruppala@nvidia.com>;
>>>> Jochen Henneberg <jh@henneberg-systemdesign.com>;
>>>> netdev@vger.kernel.org; linux- stm32@st-md-mailman.stormreply.com;
>>>> linux-arm-kernel@lists.infradead.org;
>>>> linux-kernel@vger.kernel.org; linux-amlogic@lists.infradead.org;
>>>> imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
>>>> Subject: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause
>>>> the TXC clock in fixed-link
>>>>
>>>> Caution: This is an external email. Please take care when clicking
>>>> links or opening attachments. When in doubt, report the message using
>>>> the 'Report this email' button
>>>>
>>>>
>>>> Hi Shenwei,
>>>>
>>>> thanks for your patch.
>>>>
>>>> On 7/31/23 18:19, Shenwei Wang wrote:
>>>>> When using a fixed-link setup, certain devices like the SJA1105
>>>>> require a small pause in the TXC clock line to enable their internal
>>>>> tunable delay line (TDL).
>>>>
>>>> If this is only required for some devices, is it safe to enforce this
>>>> behaviour unconditionally for any kind of fixed link devices
>>>> connected to the MX93 EQOS or could this possibly break for other devices?
>>>>
>>>
>>> It won't impact normal devices. The link layer hasn't built up yet.
>>>
>>
>> As Russel suggested in [1] - maybe you could rephrase your commit message for
>> your v4 to point this out to future reviewers (apparently multiple people have
>> had questions about this...)  and have this fact also recorded in the git log later
>> on.
>>
> 
> Okay.
> 
>> Also: does this only apply to i.MX93, or would we have to test and enable it on
>> e.g. i.MX8MP as well?
>>
> 
> Yes, it is required when the EQOS MAC is selected. However, this patch just enables
> The feature on i.MX93.

If this behaviour is required on all EQOS, I think the name 
imx_dwmac_fix_speed_mx93() is misleading. It should either be 
imx_dwmac_fix_speed() if applicable to all imx implementations, or 
dwmac_fix_speed() (and moved to a non-gluecode file) if applicable for all 
implementations in general.

You can then add a second patch for enabling it for the i.mx93 in the gluecode 
driver.

Johannes


> 
> Thanks,
> Shenwei
> 
>> Thanks
>> Johannes
>>
>> [1] ZMk/xqRP67zXHNrf@shell.armlinux.org.uk
>>
>>
>>> Thanks,
>>> Shenwei
>>>
>>>> Best regards
>>>> Johannes
>>>>
>>>>>
>>>>> To satisfy this requirement, this patch temporarily disables the TX
>>>>> clock, and restarts it after a required period. This provides the
>>>>> required silent interval on the clock line for SJA1105 to complete
>>>>> the frequency transition and enable the internal TDLs.
>>>>>
>>>>> So far we have only enabled this feature on the i.MX93 platform.
>>>>>
>>>>> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
>>>>> Reviewed-by: Frank Li <frank.li@nxp.com>
>>>>> ---
>>>>>     .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 42
>> +++++++++++++++++++
>>>>>     1 file changed, 42 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
>>>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
>>>>> index 53ee5a42c071..2e4173d099f3 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
>>>>> @@ -32,6 +32,7 @@
>>>>>     #define GPR_ENET_QOS_RGMII_EN               (0x1 << 21)
>>>>>
>>>>>     #define MX93_GPR_ENET_QOS_INTF_MODE_MASK    GENMASK(3, 0)
>>>>> +#define MX93_GPR_ENET_QOS_INTF_MASK          GENMASK(3, 1)
>>>>>     #define MX93_GPR_ENET_QOS_INTF_SEL_MII              (0x0 << 1)
>>>>>     #define MX93_GPR_ENET_QOS_INTF_SEL_RMII             (0x4 << 1)
>>>>>     #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII    (0x1 << 1)
>>>>> @@ -40,6 +41,7 @@
>>>>>     #define DMA_BUS_MODE                        0x00001000
>>>>>     #define DMA_BUS_MODE_SFT_RESET              (0x1 << 0)
>>>>>     #define RMII_RESET_SPEED            (0x3 << 14)
>>>>> +#define CTRL_SPEED_MASK                      GENMASK(15, 14)
>>>>>
>>>>>     struct imx_dwmac_ops {
>>>>>         u32 addr_width;
>>>>> @@ -56,6 +58,7 @@ struct imx_priv_data {
>>>>>         struct regmap *intf_regmap;
>>>>>         u32 intf_reg_off;
>>>>>         bool rmii_refclk_ext;
>>>>> +     void __iomem *base_addr;
>>>>>
>>>>>         const struct imx_dwmac_ops *ops;
>>>>>         struct plat_stmmacenet_data *plat_dat; @@ -212,6 +215,42 @@
>>>>> static void imx_dwmac_fix_speed(void *priv, uint speed, uint mode)
>>>>>                 dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
>>>>>     }
>>>>>
>>>>> +static void imx_dwmac_fix_speed_mx93(void *priv, uint speed, uint
>>>>> +mode) {
>>>>> +     struct imx_priv_data *dwmac = priv;
>>>>> +     int ctrl, old_ctrl, iface;
>>>>> +
>>>>> +     imx_dwmac_fix_speed(priv, speed, mode);
>>>>> +
>>>>> +     if (!dwmac || mode != MLO_AN_FIXED)
>>>>> +             return;
>>>>> +
>>>>> +     if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface))
>>>>> +             return;
>>>>> +
>>>>> +     iface &= MX93_GPR_ENET_QOS_INTF_MASK;
>>>>> +     if (iface != MX93_GPR_ENET_QOS_INTF_SEL_RGMII)
>>>>> +             return;
>>>>> +
>>>>> +     old_ctrl = readl(dwmac->base_addr + MAC_CTRL_REG);
>>>>> +     ctrl = old_ctrl & ~CTRL_SPEED_MASK;
>>>>> +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
>>>>> +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
>>>>> +     writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
>>>>> +
>>>>> +     /* Ensure the settings for CTRL are applied and avoid CPU/Compiler
>>>>> +      * reordering.
>>>>> +      */
>>>>> +     wmb();
>>>>> +
>>>>> +     usleep_range(10, 20);
>>>>> +     iface |= MX93_GPR_ENET_QOS_CLK_GEN_EN;
>>>>> +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
>>>>> +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
>>>>> +
>>>>> +     writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG); }
>>>>> +
>>>>>     static int imx_dwmac_mx93_reset(void *priv, void __iomem *ioaddr)
>>>>>     {
>>>>>         struct plat_stmmacenet_data *plat_dat = priv; @@ -317,8
>>>>> +356,11 @@ static int imx_dwmac_probe(struct platform_device *pdev)
>>>>>         plat_dat->exit = imx_dwmac_exit;
>>>>>         plat_dat->clks_config = imx_dwmac_clks_config;
>>>>>         plat_dat->fix_mac_speed = imx_dwmac_fix_speed;
>>>>> +     if (of_machine_is_compatible("fsl,imx93"))
>>>>> +             plat_dat->fix_mac_speed = imx_dwmac_fix_speed_mx93;
>>>>>         plat_dat->bsp_priv = dwmac;
>>>>>         dwmac->plat_dat = plat_dat;
>>>>> +     dwmac->base_addr = stmmac_res.addr;
>>>>>
>>>>>         ret = imx_dwmac_clks_config(dwmac, true);
>>>>>         if (ret)
>>>>
>>>> --
>>>> Pengutronix e.K.                | Johannes Zink                  |
>>>> Steuerwalder Str. 21            |
>>>> https://www/
>>>> .pe%2F&data=05%7C01%7Cshenwei.wang%40nxp.com%7Ccfd142f0d60a461
>> ee01408
>>>>
>> db9321578d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63826554
>> 36335
>>>>
>> 61986%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
>> zIiLCJ
>>>>
>> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=CV10o1M%2BOj
>> DPOaH5C
>>>> y%2Fka%2B0aOMs0IaVapMH7aa3RnTI%3D&reserved=0
>>>>
>> ngutronix.de%2F&data=05%7C01%7Cshenwei.wang%40nxp.com%7C761fbb75c
>>>>
>> 1c24cfe091508db928d8ade%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
>>>>
>> 0%7C638264908852977732%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
>>>>
>> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
>>>>
>> 7C&sdata=2l2zNfIaNnRJENmERehNae8g%2F%2BQqlxD2YRx7ksY2X%2BE%3D&r
>>>> eserved=0    |
>>>> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
>>>> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
>>>
>>>
>>
>> --
>> Pengutronix e.K.                | Johannes Zink                  |
>> Steuerwalder Str. 21            |
>> https://www.pe/
>> ngutronix.de%2F&data=05%7C01%7Cshenwei.wang%40nxp.com%7Ccfd142f0d
>> 60a461ee01408db9321578d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
>> C0%7C638265543633561986%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
>> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
>> %7C&sdata=yKzNPsHqD%2FxU%2FRmzLn4JSQjmuT9tU8SabLxHyGTTmms%3D&r
>> eserved=0    |
>> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
>> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

