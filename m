Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B0E7A475F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbjIRKll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbjIRKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:41:15 -0400
Received: from out-230.mta0.migadu.com (out-230.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFFA129
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:40:42 -0700 (PDT)
Message-ID: <b279bee8-1613-23ea-a339-9d3fdde9d0eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695033641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1MGC3KGeNs7iZtksIvUer+LllrWZx8zvqOvOFfo/kY=;
        b=luApwJ1UQVAtpehdRgQ2aGV+u3L4sIEBUA3WxBc6cIpc/FIyJIcWfs6pzCKDYDF2AeHisU
        AWBZIaata3ZtLiUK2Ul4IhJ5OdLwc7F/faCEMlINvtZp8crpGCMwb8knymzaRxKehS2phn
        iiFbsPgJwBgQVSSKooHHXXTZvMgbVP0=
Date:   Mon, 18 Sep 2023 11:40:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] net: phy: Add GPIO and DT support to NCN26000
Content-Language: en-US
To:     Jay Monkman <jtm@lopingdog.com>, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>
References: <ZQf1Nx+2amtUZulX@lopingdog.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZQf1Nx+2amtUZulX@lopingdog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 07:59, Jay Monkman wrote:
> 
> This adds GPIO support and devicetree configuration for
> the NCN26000 PHY.
> 
> Signed-off-by: Jay Monkman <jtm@lopingdog.com>
> ---
>   drivers/net/phy/ncn26000.c | 467 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 459 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
> index 5680584f659e..d89cbac6f8e3 100644
> --- a/drivers/net/phy/ncn26000.c
> +++ b/drivers/net/phy/ncn26000.c
> @@ -7,17 +7,32 @@
>   #include <linux/kernel.h>
>   #include <linux/bitfield.h>
>   #include <linux/errno.h>
> +#include <linux/gpio/driver.h>
>   #include <linux/init.h>
>   #include <linux/module.h>
>   #include <linux/mii.h>
>   #include <linux/phy.h>
> +#include <linux/property.h>
>   
>   #include "mdio-open-alliance.h"
>   
>   #define PHY_ID_NCN26000			0x180FF5A1
>   
> +#define TO_TMR_DEFAULT			32
> +
>   #define NCN26000_REG_IRQ_CTL            16
>   #define NCN26000_REG_IRQ_STATUS         17
> +#define NCN26000_REG_DIO_CONFIG         18
> +
> +// clause 45 vendor specific registers
> +#define NCN26000_REG_PHYCFG1_MMD	MDIO_MMD_VEND2
> +#define NCN26000_REG_PHYCFG1		0x8001
> +
> +#define NCN26000_REG_PLCAEXT_MMD	MDIO_MMD_VEND2
> +#define NCN26000_REG_PLCAEXT		0x8002
> +
> +#define NCN26000_REG_TWEAKS_MMD		MDIO_MMD_VEND1
> +#define NCN26000_REG_TWEAKS		0x1001
>   
>   // the NCN26000 maps link_ctrl to BMCR_ANENABLE
>   #define NCN26000_BCMR_LINK_CTRL_BIT	BMCR_ANENABLE
> @@ -33,17 +48,392 @@
>   #define NCN26000_IRQ_PHYSCOL_BIT	BIT(5)
>   #define NCN26000_IRQ_RESET_BIT		BIT(15)
>   
> -#define TO_TMR_DEFAULT			32
> +#define NCN26000_DIO_FN_DISABLE		0x0
> +#define NCN26000_DIO_FN_GPIO		0x1
> +#define NCN26000_DIO_FN_SFD_TX		0x2
> +#define NCN26000_DIO_FN_SFD_RX		0x3
> +#define NCN26000_DIO_FN_LED_LINK	0x4
> +#define NCN26000_DIO_FN_LED_PLCA	0x5
> +#define NCN26000_DIO_FN_LED_TX		0x6
> +#define NCN26000_DIO_FN_LED_RX		0x7
> +#define NCN26000_DIO_FN_CLK25M		0x8
> +#define NCN26000_DIO_FN_SFD_RXTX	0xb
> +#define NCN26000_DIO_FN_LED_RXTX	0xf
> +
> +#define NCN26000_DIO_CFG_SLEW_RATE1	BIT(15)
> +#define NCN26000_DIO_CFG_PULL_EN1	BIT(14)
> +#define NCN26000_DIO_CFG_PULL_DIR1	BIT(13)
> +#define NCN26000_DIO_CFG_FN1(x)		((x) << 9)
> +#define NCN26000_DIO_CFG_VAL1		BIT(8)
> +#define NCN26000_DIO_CFG_SLEW_RATE0	BIT(7)
> +#define NCN26000_DIO_CFG_PULL_EN0	BIT(6)
> +#define NCN26000_DIO_CFG_PULL_DIR0	BIT(5)
> +#define NCN26000_DIO_CFG_FN0(x)		((x) << 1)
> +#define NCN26000_DIO_CFG_VAL0		BIT(0)
> +
> +#define NCN26000_PHYCFG1_PKT_LOOP	BIT(15)
> +#define NCN26000_PHYCFG1_ENI		BIT(7)
> +#define NCN26000_PHYCFG1_UNJAB_TMR	BIT(6)
> +#define NCN26000_PHYCFG1_NO_COL_MASK	BIT(1)
> +#define NCN26000_PHYCFG1_RX_DLY		BIT(0)
> +
> +#define NCN26000_PLCAEXT_PRECEDENCE	BIT(15)
> +#define NCN26000_PLCAEXT_MIIEXTDIS	BIT(11)
> +
> +#define NCN26000_TWEAKS_TX_GAIN(x)	((x) << 14)
> +#define NCN26000_TWEAKS_CD_THRESH(x)	((x) << 10)
> +#define NCN26000_TWEAKS_ED_THRESH(x)	((x) << 6)
> +#define NCN26000_TWEAKS_DIG_SLEW	BIT(5)
> +#define NCN26000_TWEAKS_CMC_COMP(x)	((x) << 3)
> +#define NCN26000_TWEAKS_TX_SLEW		BIT(2)
> +
> +#define NCN26000_TX_GAIN_1V0		0
> +#define NCN26000_TX_GAIN_1V1		1
> +#define NCN26000_TX_GAIN_0V9		2
> +#define NCN26000_TX_GAIN_0V8		3
> +#define NCN26000_CD_THRESH_DEFAULT	11
> +#define NCN26000_ED_THRESH_DEFAULT	2
> +#define NCN26000_DIG_SLEW_FAST		1
> +#define NCN26000_DIG_SLEW_SLOW		0
> +#define NCN26000_CMC_COMP_0P25		0
> +#define NCN26000_CMC_COMP_1P37		1
> +#define NCN26000_CMC_COMP_3P00		2
> +#define NCN26000_CMC_COMP_4P37		3
> +#define NCN26000_TX_SLEW_FAST		1
> +#define NCN26000_TX_SLEW_SLOW		0
> +
> +struct ncn26000_priv {
> +	struct device *dev;
> +	struct phy_device *phydev;
> +	struct gpio_chip gpio_chip;
> +	unsigned int gpiomask;
> +	u16 diocfg;
> +	u16 phycfg0;
> +	u16 plcaext;
> +	u16 tweaks;
> +
> +	enum {
> +		ENI_AUTO = 0,
> +		ENI_FORCE_ON = 1,
> +		ENI_FORCE_OFF = 2
> +	} eni_mode;
> +};
> +
> +static int ncn26000_gpio_request(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct ncn26000_priv *priv = gpiochip_get_data(gc);
> +
> +	if (offset > 2)
> +		return -ENODEV;
> +
> +	if (priv->gpiomask & (1 << offset))

it's better to use BIT(offset) here

> +		return 0;
> +
> +	return -EBUSY;
> +}
> +
> +static void ncn26000_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
> +{
> +	struct ncn26000_priv *priv = gpiochip_get_data(gc);
> +	u32 dio_reg;
> +
> +	dio_reg = phy_read(priv->phydev, NCN26000_REG_DIO_CONFIG);
> +
> +	switch (offset) {
> +	case 0:
> +		if (!val == !(priv->diocfg & NCN26000_DIO_CFG_VAL0))

		     val == !!(priv->diocfg & NCN26000_DIO_CFG_VAL0)

> +			dio_reg |= NCN26000_DIO_CFG_VAL0;
> +		else
> +			dio_reg &= ~NCN26000_DIO_CFG_VAL0;
> +		break;
> +
> +	case 1:
> +		if (!val == !(priv->diocfg & NCN26000_DIO_CFG_VAL1))

		     val == !!(priv->diocfg & NCN26000_DIO_CFG_VAL1)

> +			dio_reg |= NCN26000_DIO_CFG_VAL1;
> +		else
> +			dio_reg &= ~NCN26000_DIO_CFG_VAL1;
> +		break;
> +
> +	default:
> +		dev_err(priv->dev, "invalid GPIO offset: %d\n", offset);
> +		return;
> +	}
> +
> +	phy_write(priv->phydev, NCN26000_REG_DIO_CONFIG, dio_reg);
> +}
> +
> +static int ncn26000_gpio_get_dir(struct gpio_chip *gc, unsigned int offset)
> +{
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int ncn26000_gpio_dir_out(struct gpio_chip *gc, unsigned int offset,
> +				 int val)
> +{
> +	ncn26000_gpio_set(gc, offset, val);
> +	return 0;
> +}
> +
> +static int ncn26000_gpio_setup(struct ncn26000_priv *priv)
> +{
> +	struct gpio_chip *gc = &priv->gpio_chip;
> +
> +	gc->request            = ncn26000_gpio_request;
> +	gc->get_direction      = ncn26000_gpio_get_dir;
> +	gc->direction_output   = ncn26000_gpio_dir_out;
> +	gc->set                = ncn26000_gpio_set;
> +	gc->label              = "ncn26000-gpio";
> +	gc->base               = -1;
> +	gc->ngpio              = 2;
> +	gc->parent             = priv->dev;
> +	gc->owner              = THIS_MODULE;
> +
> +	return devm_gpiochip_add_data(priv->dev, gc, priv);
> +}
> +
> +static void ncn26000_tweaks_config(struct ncn26000_priv *priv)
> +{
> +	u16 val = NCN26000_TWEAKS_CD_THRESH(NCN26000_CD_THRESH_DEFAULT) |
> +		  NCN26000_TWEAKS_ED_THRESH(NCN26000_ED_THRESH_DEFAULT) |
> +		  NCN26000_DIG_SLEW_FAST;
> +
> +	struct device *dev = &priv->phydev->mdio.dev;
> +	const char *s;
> +	int ret;
> +
> +	ret = device_property_read_string(dev, "tx-gain", &s);
> +	if (!ret) {
> +		dev_info(dev, "tx-gain = %s\n", s);
> +		if (strcmp(s, "1v1") == 0)
> +			val |= NCN26000_TWEAKS_TX_GAIN(NCN26000_TX_GAIN_1V1);
> +		else if (strcmp(s, "0v9") == 0)
> +			val |= NCN26000_TWEAKS_TX_GAIN(NCN26000_TX_GAIN_0V9);
> +		else if (strcmp(s, "0v8") == 0)
> +			val |= NCN26000_TWEAKS_TX_GAIN(NCN26000_TX_GAIN_0V8);
> +		else if (strcmp(s, "1v0") != 0)
> +			dev_err(dev, "tx-gain is invalid: %s\n", s);
> +	}
> +
> +	ret = device_property_read_string(dev, "tx-slew", &s);
> +	if (!ret) {
> +		dev_info(dev, "tx-slew = %s\n", s);
> +		if (strcmp(s, "fast") == 0)
> +			val |= NCN26000_TX_SLEW_FAST;
> +		else if (strcmp(s, "slow") != 0)
> +			dev_err(dev, "tx-slew is invalid: %s\n", s);
> +	}
> +
> +	ret = device_property_read_string(dev, "dig-slew", &s);
> +	if (!ret) {
> +		dev_info(dev, "dig-slew = %s\n", s);
> +		if (strcmp(s, "slow") == 0)
> +			val &= ~NCN26000_DIG_SLEW_FAST;
> +		else if (strcmp(s, "fast") != 0)
> +			dev_err(dev, "dig-slew is invalid: %s\n", s);
> +	}
> +
> +	ret = device_property_read_string(dev, "cmc-comp", &s);
> +	if (!ret) {
> +		dev_info(dev, "cmc-comp = %s\n", s);
> +		if (strcmp(s, "1p37") == 0)
> +			val |= NCN26000_TWEAKS_CMC_COMP(NCN26000_CMC_COMP_1P37);
> +		else if (strcmp(s, "3p00") == 0)
> +			val |= NCN26000_TWEAKS_CMC_COMP(NCN26000_CMC_COMP_3P00);
> +		else if (strcmp(s, "4p37") == 0)
> +			val |= NCN26000_TWEAKS_CMC_COMP(NCN26000_CMC_COMP_4P37);
> +		else if (strcmp(s, "0p25") != 0)
> +			dev_err(dev, "cmc-comp is invalid: %s\n", s);
> +	}
> +
> +	priv->tweaks = val;
> +}
> +
> +static void ncn26000_plcaext_config(struct ncn26000_priv *priv)
> +{
> +	u16 val = NCN26000_PLCAEXT_MIIEXTDIS;
> +
> +	if (device_property_read_bool(priv->dev, "plca-precedence")) {
> +		dev_info(priv->dev, "PLCA precedence mode enabled\n");
> +		val |= NCN26000_PLCAEXT_PRECEDENCE;
> +	}
> +
> +	priv->plcaext = val;
> +}
> +
> +static void ncn26000_phycfg0_config(struct ncn26000_priv *priv)
> +{
> +	u16 val = NCN26000_PHYCFG1_RX_DLY | NCN26000_PHYCFG1_NO_COL_MASK |
> +		  NCN26000_PHYCFG1_UNJAB_TMR;
> +
> +	struct device *dev = &priv->phydev->mdio.dev;
> +	const char *s;
> +	int ret;
> +
> +	priv->eni_mode = ENI_AUTO;
> +	ret = device_property_read_string(dev, "eni-mode", &s);
> +	if (!ret) {
> +		dev_info(dev, "eni-mode = %s\n", s);
> +		if (strcmp(s, "force-on") == 0) {
> +			priv->eni_mode = ENI_FORCE_ON;
> +			val |= NCN26000_PHYCFG1_ENI;
> +		} else if (strcmp(s, "force-off") == 0) {
> +			priv->eni_mode = ENI_FORCE_OFF;
> +		} else if (strcmp(s, "auto") != 0) {
> +			dev_err(dev, "eni-mode is invalid: %s\n", s);
> +		}
> +	}
> +
> +	if (device_property_read_bool(priv->dev, "tx-pkt-loop")) {
> +		dev_info(priv->dev, "TX packet loop enabled\n");
> +		val |= NCN26000_PHYCFG1_PKT_LOOP;
> +	}
> +
> +	if (device_property_read_bool(priv->dev, "unjab-tmr-disable")) {
> +		dev_info(priv->dev, "unjab timer disabled\n");
> +		val &= ~NCN26000_PHYCFG1_UNJAB_TMR;
> +	}
> +
> +	if (device_property_read_bool(priv->dev, "col-disable")) {
> +		dev_info(priv->dev, "ENI collision detect disabled\n");
> +		val &= ~NCN26000_PHYCFG1_NO_COL_MASK;
> +	}
> +
> +	if (device_property_read_bool(priv->dev, "no-rx-delay")) {
> +		dev_info(priv->dev, "RX delay disabled\n");
> +		val &= ~NCN26000_PHYCFG1_RX_DLY;
> +	}
> +
> +	priv->phycfg0 = val;
> +}
> +
> +static void ncn26000_dio_config(struct ncn26000_priv *priv)
> +{
> +	struct device *dev = &priv->phydev->mdio.dev;
> +	const char *s;
> +	u16 val = 0;
> +	int ret;
> +
> +	ret = device_property_read_string(dev, "dio0-fn", &s);
> +	if (!ret) {
> +		dev_info(dev, "dio0-fn = %s\n", s);
> +		if (strcmp(s, "sfd-tx") == 0)
> +			val |= NCN26000_DIO_CFG_FN0(NCN26000_DIO_FN_SFD_TX);
> +		else if (strcmp(s, "sfd-rx") == 0)
> +			val |= NCN26000_DIO_CFG_FN0(NCN26000_DIO_FN_SFD_RX);
> +		else if (strcmp(s, "sfd-rxtx") == 0)
> +			val |= NCN26000_DIO_CFG_FN0(NCN26000_DIO_FN_SFD_RXTX);
> +		else if (strcmp(s, "led-link") == 0)
> +			val |= NCN26000_DIO_CFG_FN0(NCN26000_DIO_FN_LED_LINK);
> +		else if (strcmp(s, "led-plca") == 0)
> +			val |= NCN26000_DIO_CFG_FN0(NCN26000_DIO_FN_LED_PLCA);
> +		else if (strcmp(s, "led-tx") == 0)
> +			val |= NCN26000_DIO_CFG_FN0(NCN26000_DIO_FN_LED_TX);
> +		else if (strcmp(s, "led-rx") == 0)
> +			val |= NCN26000_DIO_CFG_FN0(NCN26000_DIO_FN_LED_RX);
> +		else if (strcmp(s, "led-rxtx") == 0)
> +			val |= NCN26000_DIO_CFG_FN0(NCN26000_DIO_FN_LED_RXTX);
> +		else if (strcmp(s, "clk25m") == 0)
> +			val |= NCN26000_DIO_CFG_FN0(NCN26000_DIO_FN_CLK25M);
> +		else
> +			dev_err(dev, "dio0-fn is invalid: %s\n", s);
> +	}
> +
> +	if (device_property_read_bool(dev, "dio0-pullup"))
> +		val |= NCN26000_DIO_CFG_PULL_EN0;
> +
> +	if (device_property_read_bool(dev, "dio0-active-high"))
> +		val |= NCN26000_DIO_CFG_VAL0;
> +
> +	ret = device_property_read_string(dev, "dio0-slew", &s);
> +	if (!ret) {
> +		dev_info(dev, "dio0-slew = %s\n", s);
> +		if (strcmp(s, "slow") == 0)
> +			val |= NCN26000_DIO_CFG_SLEW_RATE0;
> +		else if (strcmp(s, "fast") != 0)
> +			dev_err(dev, "dio0-slew is invalid: %s\n", s);
> +	}
> +
> +	ret = device_property_read_string(dev, "dio1-fn", &s);
> +	if (!ret) {
> +		dev_info(dev, "dio1-fn = %s\n", s);
> +		if (strcmp(s, "sfd-tx") == 0)
> +			val |= NCN26000_DIO_CFG_FN1(NCN26000_DIO_FN_SFD_TX);
> +		else if (strcmp(s, "sfd-rx") == 0)
> +			val |= NCN26000_DIO_CFG_FN1(NCN26000_DIO_FN_SFD_RX);
> +		else if (strcmp(s, "sfd-rxtx") == 0)
> +			val |= NCN26000_DIO_CFG_FN1(NCN26000_DIO_FN_SFD_RXTX);
> +		else if (strcmp(s, "led-link") == 0)
> +			val |= NCN26000_DIO_CFG_FN1(NCN26000_DIO_FN_LED_LINK);
> +		else if (strcmp(s, "led-plca") == 0)
> +			val |= NCN26000_DIO_CFG_FN1(NCN26000_DIO_FN_LED_PLCA);
> +		else if (strcmp(s, "led-tx") == 0)
> +			val |= NCN26000_DIO_CFG_FN1(NCN26000_DIO_FN_LED_TX);
> +		else if (strcmp(s, "led-rx") == 0)
> +			val |= NCN26000_DIO_CFG_FN1(NCN26000_DIO_FN_LED_RX);
> +		else if (strcmp(s, "led-rxtx") == 0)
> +			val |= NCN26000_DIO_CFG_FN1(NCN26000_DIO_FN_LED_RXTX);
> +		else if (strcmp(s, "clk25m") == 0)
> +			val |= NCN26000_DIO_CFG_FN1(NCN26000_DIO_FN_CLK25M);
> +		else
> +			dev_err(dev, "dio1-fn is invalid: %s\n", s);
> +	}
> +
> +	if (device_property_read_bool(dev, "dio1-pullup"))
> +		val |= NCN26000_DIO_CFG_PULL_EN1;
> +
> +	if (device_property_read_bool(dev, "dio1-active-high"))
> +		val |= NCN26000_DIO_CFG_VAL1;
> +
> +	ret = device_property_read_string(dev, "dio1-slew", &s);
> +	if (!ret) {
> +		dev_info(dev, "dio1-slew = %s\n", s);
> +		if (strcmp(s, "slow") == 0)
> +			val |= NCN26000_DIO_CFG_SLEW_RATE1;
> +		else if (strcmp(s, "fast") != 0)
> +			dev_err(dev, "dio1-slew is invalid: %s\n", s);
> +	}
> +
> +	priv->diocfg = val;
> +}
>   
>   static int ncn26000_config_init(struct phy_device *phydev)
>   {
> +	struct ncn26000_priv *priv = phydev->priv;
> +	int ret;
> +
> +	// configure the DIOx function
> +	ret = phy_write(phydev, NCN26000_REG_DIO_CONFIG, priv->diocfg);
> +	if (ret)
> +		goto out;
> +
> +	// configure proprietary PHY features
> +	ret = phy_write_mmd(phydev, NCN26000_REG_PHYCFG1_MMD,
> +			    NCN26000_REG_PHYCFG1, priv->phycfg0);
> +	if (ret)
> +		goto out;
> +
> +	// configure the PLCA extensions
> +	ret = phy_write_mmd(phydev, NCN26000_REG_PLCAEXT_MMD,
> +			    NCN26000_REG_PLCAEXT, priv->plcaext);
> +	if (ret)
> +		goto out;
> +
> +	// configure additional PHY tweaks
> +	ret = phy_write_mmd(phydev, NCN26000_REG_TWEAKS_MMD,
> +			    NCN26000_REG_TWEAKS, priv->tweaks);
> +	if (ret)
> +		goto out;
> +
>   	/* HW bug workaround: the default value of the PLCA TO_TIMER should be
>   	 * 32, where the current version of NCN26000 reports 24. This will be
>   	 * fixed in future PHY versions. For the time being, we force the
>   	 * correct default here.
>   	 */
> -	return phy_write_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_PLCA_TOTMR,
> -			     TO_TMR_DEFAULT);
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_PLCA_TOTMR,
> +			    TO_TMR_DEFAULT);
> +
> +out:
> +	return ret;
>   }
>   
>   static int ncn26000_config_aneg(struct phy_device *phydev)
> @@ -100,6 +490,36 @@ static int ncn26000_read_status(struct phy_device *phydev)
>   	return 0;
>   }
>   
> +static int ncn26000_plca_set_cfg(struct phy_device *phydev,
> +				 const struct phy_plca_cfg *plca_cfg)
> +{
> +	struct ncn26000_priv *priv = phydev->priv;
> +	int ret;
> +
> +	/* We capture calls to PLCA set config to intercept PLCA enable/disable
> +	 * requests and set the proprietary ENI mode accordingly
> +	 */
> +	ret = genphy_c45_plca_set_cfg(phydev, plca_cfg);
> +	if (ret || plca_cfg->enabled < 0 || priv->eni_mode != ENI_AUTO)
> +		goto out;
> +
> +	ret = phy_read_mmd(phydev, NCN26000_REG_PHYCFG1_MMD,
> +			   NCN26000_REG_PHYCFG1);
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	if (plca_cfg->enabled)
> +		ret |= NCN26000_PHYCFG1_ENI;
> +	else
> +		ret &= ~NCN26000_PHYCFG1_ENI;
> +
> +	ret = phy_write_mmd(phydev, NCN26000_REG_PHYCFG1_MMD,
> +			    NCN26000_REG_PHYCFG1, ret);
> +out:
> +	return ret;
> +}
> +
>   static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
>   {
>   	int ret;
> @@ -140,20 +560,51 @@ static int ncn26000_config_intr(struct phy_device *phydev)
>   	return 0;
>   }
>   
> +static int ncn26000_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct ncn26000_priv *priv;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->phydev = phydev;
> +	phydev->priv = priv;
> +
> +	ncn26000_dio_config(priv);
> +	if (priv->gpiomask)
> +		ncn26000_gpio_setup(priv);
> +
> +	ncn26000_phycfg0_config(priv);
> +	ncn26000_plcaext_config(priv);
> +	ncn26000_tweaks_config(priv);
> +
> +	return 0;
> +}
> +
> +static void ncn26000_remove(struct phy_device *phydev)
> +{
> +	kfree(phydev->priv);
> +}
> +
>   static struct phy_driver ncn26000_driver[] = {
>   	{
>   		PHY_ID_MATCH_MODEL(PHY_ID_NCN26000),
>   		.name			= "NCN26000",
>   		.features		= PHY_BASIC_T1S_P2MP_FEATURES,
> -		.config_init            = ncn26000_config_init,
> -		.config_intr            = ncn26000_config_intr,
> +		.probe			= ncn26000_probe,
> +		.remove			= ncn26000_remove,
> +		.config_init		= ncn26000_config_init,
> +		.config_intr		= ncn26000_config_intr,
>   		.config_aneg		= ncn26000_config_aneg,
>   		.read_status		= ncn26000_read_status,
> -		.handle_interrupt       = ncn26000_handle_interrupt,
> +		.handle_interrupt	= ncn26000_handle_interrupt,
> +		.set_plca_cfg		= ncn26000_plca_set_cfg,
>   		.get_plca_cfg		= genphy_c45_plca_get_cfg,
> -		.set_plca_cfg		= genphy_c45_plca_set_cfg,
>   		.get_plca_status	= genphy_c45_plca_get_status,
> -		.soft_reset             = genphy_soft_reset,
> +		.soft_reset		= genphy_soft_reset,
>   	},
>   };
>   

