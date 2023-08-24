Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889E47878EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbjHXToH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243315AbjHXTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DEE1BDF;
        Thu, 24 Aug 2023 12:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B01B66E32;
        Thu, 24 Aug 2023 19:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED286C433C7;
        Thu, 24 Aug 2023 19:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692906228;
        bh=O49o/zsczeHH1GIYTkrpSoIrgQiUA5IDZ3LRVZespEA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uyhTMJ3FTHPRfIqyOQPozmKtgx4mbmlg+jP/aPuCHz8sLOnR8WQt9Do/W/0m3ZsTA
         uM2vJm0KlgiLUcIiRrfWxP4FP0hCK3O9XNB79zsrtYsm83FNJtnGkTiV4Jjvo4Xg7O
         Jhs3OQWuLZMWTK4+xp0SC3epL6fx9VeqhLNNSEp65txbt3DXm1b9IZvAHjmabJ/aFd
         5jMkUNrpZR/IjMxBxPhQgurw5Pi6qAL8WslzzY4xKCFyNccN8SVDsZRkgPi1rUi2fe
         ROw48L8i4GO+kK17mq0sBq7UQEv4ZFr8CZgN84RS5wHp24NaXPuBcE5nfhs1uKUH95
         jUHBleaIpe+uw==
Message-ID: <af247603-6a8d-7c05-4342-c6f615a7f508@kernel.org>
Date:   Fri, 25 Aug 2023 04:43:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
To:     Stanley Chang <stanley_chang@realtek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230822102846.4683-1-stanley_chang@realtek.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20230822102846.4683-1-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Almost code looks good to me. I add some comment below. Please check them.

On 23. 8. 22. 19:28, Stanley Chang wrote:
> This patch adds the extcon driver for Realtek DHC (digital home center)
> RTD SoCs type-c module. This can be used to detect whether the port is
> configured as a downstream or upstream facing port. And notify the status
> of extcon to listeners.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  drivers/extcon/Kconfig             |    9 +
>  drivers/extcon/Makefile            |    1 +
>  drivers/extcon/extcon-rtk-type-c.c | 1799 ++++++++++++++++++++++++++++
>  3 files changed, 1809 insertions(+)
>  create mode 100644 drivers/extcon/extcon-rtk-type-c.c
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 0ef1971d22bb..d670434321f2 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -190,4 +190,13 @@ config EXTCON_USBC_TUSB320
>  	  Say Y here to enable support for USB Type C cable detection extcon
>  	  support using a TUSB320.
>  
> +config EXTCON_RTK_TYPE_C
> +	tristate "Realtek RTD SoC extcon Type-C Driver"
> +	depends on ARCH_REALTEK || COMPILE_TEST
> +	help
> +	  Say Y here to enable extcon support for USB Type C cable detection
> +	  when using the Realtek RTD SoC USB Type-C port.
> +	  The DHC (Digital Home Hub) RTD series SoC contains a type c module.
> +	  This driver will detect the status of the type-c port.
> +
>  endif
> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> index 1b390d934ca9..f779adb5e4c7 100644
> --- a/drivers/extcon/Makefile
> +++ b/drivers/extcon/Makefile
> @@ -25,3 +25,4 @@ obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
>  obj-$(CONFIG_EXTCON_USB_GPIO)	+= extcon-usb-gpio.o
>  obj-$(CONFIG_EXTCON_USBC_CROS_EC) += extcon-usbc-cros-ec.o
>  obj-$(CONFIG_EXTCON_USBC_TUSB320) += extcon-usbc-tusb320.o
> +obj-$(CONFIG_EXTCON_RTK_TYPE_C) += extcon-rtk-type-c.o
> diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
> new file mode 100644
> index 000000000000..04d4d5128bdb
> --- /dev/null
> +++ b/drivers/extcon/extcon-rtk-type-c.c
> @@ -0,0 +1,1799 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  * extcon-rtk-type-c.c - Realtek Extcon Type C driver
> + *
> + * Copyright (C) 2023 Realtek Semiconductor Corporation
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_gpio.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/syscalls.h>
> +#include <linux/suspend.h>
> +#include <linux/debugfs.h>
> +#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
> +#include <linux/sys_soc.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/typec.h>
> +
> +struct cc_param {
> +	u32 rp_4p7k_code;
> +	u32 rp_36k_code;
> +	u32 rp_12k_code;
> +	u32 rd_code;
> +	u32 ra_code;
> +	u32 vref_2p6v;
> +	u32 vref_1p23v;
> +	u32 vref_0p8v;
> +	u32 vref_0p66v;
> +	u32 vref_0p4v;
> +	u32 vref_0p2v;
> +	u32 vref_1_1p6v;
> +	u32 vref_0_1p6v;
> +};
> +
> +struct type_c_cfg {
> +	int parameter_ver; /* Parameter version */
> +	int cc_dfp_mode;
> +	struct cc_param cc1_param;
> +	struct cc_param cc2_param;
> +
> +	u32 debounce_val;
> +	bool use_defalut_parameter;
> +};
> +
> +struct type_c_data {
> +	void __iomem *reg_base;
> +	struct device *dev;
> +	struct extcon_dev *edev;
> +
> +	u32 irq;
> +
> +	/* rd control GPIO only for rtd1295 */
> +	unsigned int rd_ctrl_gpio;
> +
> +	/* Parameters */
> +	struct type_c_cfg *type_c_cfg;
> +	u32 dfp_mode_rp_en;
> +	u32 ufp_mode_rd_en;
> +	u32 cc1_code;
> +	u32 cc2_code;
> +	u32 cc1_vref;
> +	u32 cc2_vref;
> +	u32 debounce; /* 1b,1us 7f,4.7us */
> +
> +	/* type_c state */
> +	int connect_change;
> +#define CONNECT_CHANGE 1
> +#define CONNECT_NO_CHANGE 0
> +	int cc_mode; /* cc is host or device */
> +#define IN_HOST_MODE 0x10
> +#define IN_DEVICE_MODE 0x20
> +	int is_attach;
> +#define IN_ATTACH 1
> +#define TO_ATTACH 1
> +#define IN_DETACH 0
> +#define TO_DETACH 0
> +	int at_cc1;
> +#define AT_CC1 1
> +#define AT_CC2 0
> +
> +	u32 int_status;
> +	u32 cc_status;
> +	/* protect the data member */
> +	spinlock_t lock;
> +	struct delayed_work delayed_work;
> +
> +	bool rd_en_at_first;
> +
> +	struct dentry *debug_dir;
> +
> +#ifdef CONFIG_TYPEC
> +	struct typec_port *port;
> +#endif /* CONFIG_TYPEC */
> +};
> +
> +/* Type C register offset */
> +#define USB_TYPEC_CTRL_CC1_0 0x0
> +#define USB_TYPEC_CTRL_CC1_1 0x4
> +#define USB_TYPEC_CTRL_CC2_0 0x8
> +#define USB_TYPEC_CTRL_CC2_1 0xC
> +#define USB_TYPEC_STS        0x10
> +#define USB_TYPEC_CTRL       0x14
> +#define USB_DBUS_PWR_CTRL    0x18

nitpick.
Above defintions uses 'space' to keep the left-aligned of value.
But, below defintions doesn't keep the left-aligned of value.

I recommend that you better to use the same style for the readability.

> +
> +#define ENABLE_CC1 0x1
> +#define ENABLE_CC2 0x2
> +#define DISABLE_CC 0x0
> +
> +/* Bit mapping USB_TYPEC_CTRL_CC1_0 and USB_TYPEC_CTRL_CC2_0 */
> +#define PLR_EN BIT(29)
> +#define CC_SWITCH_MASK (BIT(29) | BIT(28) | BIT(27))
> +#define CC_CODE_MASK (0xfffff << 7)
> +#define rp4pk_code(val) ((0x1f & (val)) << 22)
> +#define code_rp4pk(val) (((val) >> 22) & 0x1f)
> +#define rp36k_code(val) ((0x1f & (val)) << 17)
> +#define code_rp36k(val) (((val) >> 17) & 0x1f)
> +#define rp12k_code(val) ((0x1f & (val)) << 12)
> +#define code_rp12k(val) (((val) >> 12) & 0x1f)
> +#define rd_code(val) ((0x1f & (val)) << 7)
> +#define code_rd(val) (((val) >> 7) & 0x1f)
> +#define dfp_mode(val) ((0x3 & (val)) << 5)
> +#define EN_RP4P7K BIT(4)
> +#define EN_RP36K BIT(3)
> +#define EN_RP12K BIT(2)
> +#define EN_RD BIT(1)
> +#define EN_CC_DET BIT(0)
> +
> +#define CC_MODE_UFP 0x0
> +#define CC_MODE_DFP_USB 0x1
> +#define CC_MODE_DFP_1_5 0x2
> +#define CC_MODE_DFP_3_0 0x3
> +
> +/*
> + * PARAMETER_V0:
> + *  Realtek Kylin    rtd1295
> + *  Realtek Hercules rtd1395
> + *  Realtek Thor     rtd1619
> + *  Realtek Hank     rtd1319
> + *  Realtek Groot    rtd1312c
> + * PARAMETER_V1:
> + *  Realtek Stark    rtd1619b
> + *  Realtek Parker   rtd1319d
> + *  Realtek Danvers  rtd1315e
> + */
> +enum parameter_version {
> +	PARAMETER_V0 = 0,
> +	PARAMETER_V1 = 1,
> +};
> +
> +/* Bit mapping USB_TYPEC_CTRL_CC1_1 and USB_TYPEC_CTRL_CC2_1 */
> +#define V0_vref_2p6v(val) ((0xf & (val)) << 26) /* Bit 29 for groot */
> +#define V0_vref_1p23v(val) ((0xf & (val)) << 22)
> +#define V0_vref_0p8v(val) ((0xf & (val)) << 18)
> +#define V0_vref_0p66v(val) ((0xf & (val)) << 14)
> +#define V0_vref_0p4v(val) ((0x7 & (val)) << 11)
> +#define V0_vref_0p2v(val) ((0x7 & (val)) << 8)
> +#define V0_vref_1_1p6v(val) ((0xf & (val)) << 4)
> +#define V0_vref_0_1p6v(val) ((0xf & (val)) << 0)
> +
> +#define V0_decode_2p6v(val) (((val) >> 26) & 0xf) /* Bit 29 for groot */
> +#define V0_decode_1p23v(val) (((val) >> 22) & 0xf)
> +#define V0_decode_0p8v(val) (((val) >> 18) & 0xf)
> +#define V0_decode_0p66v(val) (((val) >> 14) & 0xf)
> +#define V0_decode_0p4v(val) (((val) >> 11) & 0x7)
> +#define V0_decode_0p2v(val) (((val) >> 8) & 0x7)
> +#define V0_decode_1_1p6v(val) (((val) >> 4) & 0xf)
> +#define V0_decode_0_1p6v(val) (((val) >> 0) & 0xf)
> +
> +/* new Bit mapping USB_TYPEC_CTRL_CC1_1 and USB_TYPEC_CTRL_CC2_1 */
> +#define V1_vref_2p6v(val) ((0xf & (val)) << 28)
> +#define V1_vref_1p23v(val) ((0xf & (val)) << 24)
> +#define V1_vref_0p8v(val) ((0xf & (val)) << 20)
> +#define V1_vref_0p66v(val) ((0xf & (val)) << 16)
> +#define V1_vref_0p4v(val) ((0xf & (val)) << 12)
> +#define V1_vref_0p2v(val) ((0xf & (val)) << 8)
> +#define V1_vref_1_1p6v(val) ((0xf & (val)) << 4)
> +#define V1_vref_0_1p6v(val) ((0xf & (val)) << 0)
> +
> +#define V1_decode_2p6v(val) (((val) >> 28) & 0xf)
> +#define V1_decode_1p23v(val) (((val) >> 24) & 0xf)
> +#define V1_decode_0p8v(val) (((val) >> 20) & 0xf)
> +#define V1_decode_0p66v(val) (((val) >> 16) & 0xf)
> +#define V1_decode_0p4v(val) (((val) >> 12) & 0xf)
> +#define V1_decode_0p2v(val) (((val) >> 8) & 0xf)
> +#define V1_decode_1_1p6v(val) (((val) >> 4) & 0xf)
> +#define V1_decode_0_1p6v(val) (((val) >> 0) & 0xf)
> +
> +/* Bit mapping USB_TYPEC_STS */
> +#define DET_STS 0x7
> +#define CC1_DET_STS (DET_STS)
> +#define CC2_DET_STS (DET_STS << 3)
> +#define DET_STS_RA 0x1
> +#define DET_STS_RD 0x3
> +#define DET_STS_RP 0x1
> +#define CC1_DET_STS_RA (DET_STS_RA)
> +#define CC1_DET_STS_RD (DET_STS_RD)
> +#define CC1_DET_STS_RP (DET_STS_RP)
> +#define CC2_DET_STS_RA (DET_STS_RA << 3)
> +#define CC2_DET_STS_RD (DET_STS_RD << 3)
> +#define CC2_DET_STS_RP (DET_STS_RP << 3)
> +
> +/* Bit mapping USB_TYPEC_CTRL */
> +#define CC2_INT_EN BIT(11)
> +#define CC1_INT_EN BIT(10)
> +#define CC2_INT_STS BIT(9)
> +#define CC1_INT_STS BIT(8)
> +#define DEBOUNCE_TIME_MASK 0xff
> +#define DEBOUNCE_EN BIT(0)
> +#define ENABLE_TYPE_C_DETECT (CC1_INT_EN | CC2_INT_EN)
> +#define ALL_CC_INT_STS (CC1_INT_STS | CC2_INT_STS)
> +
> +/* Parameter */
> +#define DETECT_TIME 50 /* ms */
> +
> +static const unsigned int usb_type_c_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +	EXTCON_NONE,
> +};
> +
> +enum usb_data_roles {
> +	DR_NONE,
> +	DR_HOST,
> +	DR_DEVICE,
> +};
> +
> +static const struct soc_device_attribute rtk_soc_kylin[] = {
> +	{ .family = "Realtek Kylin", },
> +	{ /* empty */ }
> +};
> +
> +static int rtd129x_switch_type_c_plug_config(struct type_c_data *type_c,
> +					     int dr_mode, int cc)
> +{
> +	void __iomem *reg = type_c->reg_base + USB_TYPEC_CTRL_CC1_0;
> +	int val_cc;
> +
> +#define TYPE_C_EN_SWITCH BIT(29)
> +#define TYPE_C_TXRX_SEL (BIT(28) | BIT(27))
> +#define TYPE_C_SWITCH_MASK (TYPE_C_EN_SWITCH | TYPE_C_TXRX_SEL)
> +#define TYPE_C_ENABLE_CC1 TYPE_C_EN_SWITCH
> +#define TYPE_C_ENABLE_CC2 (TYPE_C_EN_SWITCH | TYPE_C_TXRX_SEL)
> +#define TYPE_C_DISABLE_CC ~TYPE_C_SWITCH_MASK
> +
> +	val_cc = readl(reg);

I'd like you to use regmap interface to access the register
by using regmap_read, regmap_write. You can create the regmap instance
via devm_regmap_init_mmio() on probe instead of using 'type_c->reg_base' 
at the multipe point.

For example,
	struct regmap_config rtk_regmap_config = {
		.reg_bits = 32,
		.val_bits = 32,
	};

	void __iomem *base;

	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);            
	if (IS_ERR(base))                                                        
		return PTR_ERR(base);                                            
                                                                            
	regmap = devm_regmap_init_mmio(dev, base, &rtk_regmap_config);

	---

	And then just call regmap_read without any calculation between
	base address and specific register. 

	regmap_read(regmap, USB_TYPEC_CTRL_CC1_0)


> +	val_cc &= ~TYPE_C_SWITCH_MASK;
> +
> +	if (cc == DISABLE_CC) {
> +		val_cc &= TYPE_C_DISABLE_CC;
> +	} else if (cc == ENABLE_CC1) {
> +		val_cc |= TYPE_C_ENABLE_CC1;
> +	} else if (cc == ENABLE_CC2) {
> +		val_cc |= TYPE_C_ENABLE_CC2;
> +	} else {
> +		dev_err(type_c->dev, "%s: Error cc setting cc=0x%x\n", __func__, cc);
> +		return -EINVAL;
> +	}
> +	writel(val_cc, reg);
> +
> +	mdelay(1);
Maybe, it depends on h/w constraints. Better to explain the comment
of why adding delay at here. Also, this patch uses mdelay/msleep at
the multiple point. I recommend that add the comment of reason to add
mdelay/msleep.

> +
> +	dev_dbg(type_c->dev, "%s: cc=0x%x val_cc=0x%x usb_typec_ctrl_cc1_0=0x%x\n",
> +		__func__, cc, val_cc, readl(reg));
> +
> +	return 0;
> +}
> +
> +static inline void switch_type_c_plug_config(struct type_c_data *type_c,
> +					     int dr_mode, int cc)
> +{
> +	int ret = 0;
> +
> +	if (soc_device_match(rtk_soc_kylin))
> +		ret = rtd129x_switch_type_c_plug_config(type_c, dr_mode, cc);
> +
> +	if (ret < 0)
> +		dev_err(type_c->dev, "%s: Error set type c plug config\n",
> +			__func__);
> +}
> +
> +static void switch_type_c_dr_mode(struct type_c_data *type_c, int dr_mode, int cc)
> +{
> +	bool is_host = false;
> +	bool is_device = false;
> +	bool polarity = false;
> +	bool vbus = false;
> +	bool ss = true;
> +
> +	switch_type_c_plug_config(type_c, dr_mode, cc);
> +	if (cc == ENABLE_CC2)
> +		polarity = true;
> +
> +	switch (dr_mode) {
> +	case USB_DR_MODE_HOST:
> +		is_host = true;
> +		break;
> +	case USB_DR_MODE_PERIPHERAL:
> +		is_device = true;
> +		vbus = true;
> +		break;
> +	default:
> +		dev_dbg(type_c->dev, "%s dr_mode=%d ==> no host or device\n",
> +			__func__, dr_mode);
> +		break;
> +	}
> +
> +	dev_dbg(type_c->dev, "%s is_host=%d is_device=%d vbus=%d polarity=%d\n",
> +		__func__, is_host, is_device, vbus, polarity);
> +
> +	/* for EXTCON_USB device mode */
> +	extcon_set_state(type_c->edev, EXTCON_USB, is_device);
> +	extcon_set_property(type_c->edev, EXTCON_USB,
> +			    EXTCON_PROP_USB_VBUS,
> +			    (union extcon_property_value)(int)vbus);
> +	extcon_set_property(type_c->edev, EXTCON_USB,
> +			    EXTCON_PROP_USB_TYPEC_POLARITY,
> +			    (union extcon_property_value)(int)polarity);
> +	extcon_set_property(type_c->edev, EXTCON_USB,
> +			    EXTCON_PROP_USB_SS,
> +			    (union extcon_property_value)(int)ss);
> +
> +	/* for EXTCON_USB_HOST host mode */
> +	extcon_set_state(type_c->edev, EXTCON_USB_HOST, is_host);
> +	extcon_set_property(type_c->edev, EXTCON_USB_HOST,
> +			    EXTCON_PROP_USB_VBUS,
> +			    (union extcon_property_value)(int)vbus);
> +	extcon_set_property(type_c->edev, EXTCON_USB_HOST,
> +			    EXTCON_PROP_USB_TYPEC_POLARITY,
> +			    (union extcon_property_value)(int)polarity);
> +	extcon_set_property(type_c->edev, EXTCON_USB_HOST,
> +			    EXTCON_PROP_USB_SS,
> +			    (union extcon_property_value)(int)ss);
> +
> +	/* sync EXTCON_USB and EXTCON_USB_HOST */
> +	extcon_sync(type_c->edev, EXTCON_USB);
> +	extcon_sync(type_c->edev, EXTCON_USB_HOST);
> +
> +#ifdef CONFIG_TYPEC> +	if (type_c->port) {
> +		switch (dr_mode) {
> +		case USB_DR_MODE_HOST:
> +			typec_set_data_role(type_c->port, TYPEC_HOST);
> +			typec_set_pwr_role(type_c->port, TYPEC_SOURCE);
> +			break;
> +		case USB_DR_MODE_PERIPHERAL:
> +			typec_set_data_role(type_c->port, TYPEC_DEVICE);
> +			typec_set_pwr_role(type_c->port, TYPEC_SINK);
> +			break;
> +		default:
> +			dev_dbg(type_c->dev, "%s unknown dr_mode=%d\n",
> +				__func__, dr_mode);
> +			break;
> +		}
> +	}
> +#endif
> +}
> +
> +/* device attached/detached */
> +static int device_attached(struct type_c_data *type_c, u32 cc)
> +{
> +	void __iomem *reg = type_c->reg_base + USB_TYPEC_CTRL;
> +
> +	cancel_delayed_work(&type_c->delayed_work);
> +
> +	switch_type_c_dr_mode(type_c, USB_DR_MODE_HOST, cc);
> +
> +	writel(ENABLE_TYPE_C_DETECT | readl(reg), reg);
> +
> +	return 0;
> +}

device_attached() funciton is same with host_connected()
except for USR_BR_MODE_HOST, USB_DR_MODE_PERIPHERAL setting.

You can use only one function with 3rd paramer (dr_mode) as following
in order to reduce the duplicated code.
For example,
static int connector_attached(struct type_c_data *type_c, u32 cc, int dr_mode)

> +
> +static int device_detached(struct type_c_data *type_c, u32 cc)
> +{
> +	void __iomem *reg = type_c->reg_base + USB_TYPEC_CTRL;
> +
> +	writel(~ENABLE_TYPE_C_DETECT & readl(reg), reg);
> +
> +	switch_type_c_dr_mode(type_c, 0, cc);
> +
> +	schedule_delayed_work(&type_c->delayed_work, msecs_to_jiffies(DETECT_TIME));
> +
> +	return 0;
> +}

device_detached is perfectly same with host_disconnected.
You can use the only one function to reduce the duplicated code

> +
> +/* host connect/disconnect*/
> +static int host_connected(struct type_c_data *type_c, u32 cc)
> +{
> +	void __iomem *reg = type_c->reg_base + USB_TYPEC_CTRL;
> +
> +	cancel_delayed_work(&type_c->delayed_work);
> +
> +	switch_type_c_dr_mode(type_c, USB_DR_MODE_PERIPHERAL, cc);
> +
> +	writel(ENABLE_TYPE_C_DETECT | readl(reg), reg);
> +	return 0;
> +}
> +
> +static int host_disconnected(struct type_c_data *type_c, u32 cc)
> +{
> +	void __iomem *reg = type_c->reg_base + USB_TYPEC_CTRL;
> +
> +	writel(~ENABLE_TYPE_C_DETECT & readl(reg), reg);
> +
> +	switch_type_c_dr_mode(type_c, 0, cc);
> +
> +	schedule_delayed_work(&type_c->delayed_work, msecs_to_jiffies(DETECT_TIME));
> +
> +	return 0;
> +}
> +
> +/* detect host device switch */
> +static int __detect_host_device(struct type_c_data *type_c, u32 rp_or_rd_en)
> +{
> +	struct device *dev = type_c->dev;
> +	void __iomem *reg_base = type_c->reg_base;
> +	unsigned int gpio = type_c->rd_ctrl_gpio;
> +	u32 cc1_config, cc2_config, default_ctrl;
> +	u32 cc1_switch = 0;
> +
> +	default_ctrl = readl(reg_base + USB_TYPEC_CTRL) & DEBOUNCE_TIME_MASK;
> +	writel(default_ctrl, reg_base + USB_TYPEC_CTRL);
> +
> +	cc1_config = readl(reg_base + USB_TYPEC_CTRL_CC1_0);
> +	cc2_config = readl(reg_base + USB_TYPEC_CTRL_CC2_0);
> +
> +	cc1_config &= ~EN_CC_DET;
> +	cc2_config &= ~EN_CC_DET;
> +	writel(cc1_config, reg_base + USB_TYPEC_CTRL_CC1_0);
> +	writel(cc2_config, reg_base + USB_TYPEC_CTRL_CC2_0);
> +
> +	if (soc_device_match(rtk_soc_kylin))
> +		cc1_switch = cc1_config & CC_SWITCH_MASK;
> +
> +	cc1_config &= CC_CODE_MASK;
> +	cc1_config |= rp_or_rd_en | cc1_switch;
> +	cc2_config &= CC_CODE_MASK;
> +	cc2_config |= rp_or_rd_en;
> +	writel(cc2_config, reg_base + USB_TYPEC_CTRL_CC2_0);
> +	writel(cc1_config, reg_base + USB_TYPEC_CTRL_CC1_0);
> +
> +	/* For kylin to disable external rd control gpio */
> +	if (soc_device_match(rtk_soc_kylin)) {
> +		if (gpio != -1 && gpio_is_valid(gpio)) {
> +			if (gpio_direction_output(gpio, 1))
> +				dev_err(dev, "%s ERROR rd_ctrl_gpio=1 fail\n", __func__);
> +		}
> +	}
> +
> +	cc1_config |= EN_CC_DET;
> +	cc2_config |= EN_CC_DET;
> +	writel(cc1_config, reg_base + USB_TYPEC_CTRL_CC1_0);
> +	writel(cc2_config, reg_base + USB_TYPEC_CTRL_CC2_0);
> +
> +	return 0;
> +}
> +
> +static int detect_device(struct type_c_data *type_c)
> +{
> +	return __detect_host_device(type_c, type_c->dfp_mode_rp_en);
> +}
> +
> +static int detect_host(struct type_c_data *type_c)
> +{
> +	return __detect_host_device(type_c, type_c->ufp_mode_rd_en);
> +}
> +
> +static int host_device_switch_detection(struct type_c_data *type_c)
> +{
> +	if (type_c->cc_mode == IN_HOST_MODE) {
> +		type_c->cc_mode = IN_DEVICE_MODE;
> +		detect_host(type_c);
> +	} else {
> +		type_c->cc_mode = IN_HOST_MODE;
> +		detect_device(type_c);
> +	}
> +
> +	return 0;
> +}
> +
> +static int detect_type_c_state(struct type_c_data *type_c)
> +{
> +	struct device *dev = type_c->dev;
> +	void __iomem *reg_base = type_c->reg_base;
> +	u32 int_status, cc_status, cc_status_check;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&type_c->lock, flags);
> +
> +	int_status = readl(reg_base + USB_TYPEC_CTRL);
> +	cc_status = readl(reg_base + USB_TYPEC_STS);
> +
> +	type_c->connect_change = CONNECT_NO_CHANGE;
> +
> +	switch (type_c->cc_mode | type_c->is_attach) {
> +	case IN_HOST_MODE | IN_ATTACH:
> +		if (((cc_status & CC1_DET_STS) == CC1_DET_STS) && type_c->at_cc1 == AT_CC1) {
> +			dev_dbg(dev, "IN host mode and cc1 device detach (cc_status=0x%x)",
> +				cc_status);
> +			type_c->is_attach = TO_DETACH;
> +			type_c->connect_change = CONNECT_CHANGE;
> +		} else if (((cc_status & CC2_DET_STS) == CC2_DET_STS) &&
> +			   type_c->at_cc1 == AT_CC2) {
> +			dev_dbg(dev, "IN host mode and cc2 device detach (cc_status=0x%x)",
> +				cc_status);
> +			type_c->is_attach = TO_DETACH;
> +			type_c->connect_change = CONNECT_CHANGE;
> +		}
> +		break;
> +	case IN_HOST_MODE | IN_DETACH:
> +		cc_status_check = readl(reg_base + USB_TYPEC_STS);
> +		if (cc_status_check != (CC1_DET_STS | CC2_DET_STS)) {
> +			if (in_interrupt()) {
> +				mdelay(300);
> +			} else {
> +				spin_unlock_irqrestore(&type_c->lock, flags);
> +				msleep(300);
> +				spin_lock_irqsave(&type_c->lock, flags);
> +			}

As I commented above, it seems that there are some hardware constrains
which requires the some delay when changing the h/w state.
I recommend that you need to add the comment of why adding the delays/sleep.

> +			cc_status_check = readl(reg_base + USB_TYPEC_STS);
> +		}
> +		if (cc_status != cc_status_check) {
> +			dev_warn(dev, "IN_HOST_MODE: cc_status (0x%x) != cc_status_check (0x%x)\n",
> +				 cc_status, cc_status_check);
> +			cc_status = readl(reg_base + USB_TYPEC_STS);
> +		}
> +
> +		if ((cc_status & CC1_DET_STS) == CC1_DET_STS_RD) {
> +			dev_dbg(dev, "IN host mode and cc1 device attach (cc_status=0x%x)",
> +				cc_status);
> +			type_c->is_attach = TO_ATTACH;
> +			type_c->at_cc1 = AT_CC1;
> +			type_c->connect_change = CONNECT_CHANGE;
> +		} else if ((cc_status & CC2_DET_STS) == CC2_DET_STS_RD) {
> +			dev_dbg(dev, "In host mode and cc2 device attach (cc_status=0x%x)",
> +				cc_status);
> +			type_c->is_attach = TO_ATTACH;
> +			type_c->at_cc1 = AT_CC2;
> +			type_c->connect_change = CONNECT_CHANGE;
> +		}
> +		break;
> +	case IN_DEVICE_MODE | IN_ATTACH:
> +		if ((cc_status & CC1_DET_STS) < CC1_DET_STS_RP ||
> +		    (cc_status & CC2_DET_STS) < CC2_DET_STS_RP) {
> +			/* Add a sw debounce to filter cc signal sent from apple pd adapter */
> +			mdelay(5);
> +			cc_status_check = readl(reg_base + USB_TYPEC_STS);
> +
> +			if (cc_status != cc_status_check) {
> +				dev_dbg(dev, "IN_DEVICE_MODE: cc_status (0x%x) != cc_status_check (0x%x) maybe use a pd adapter\n",
> +					cc_status, cc_status_check);
> +				cc_status = cc_status_check;
> +			}
> +		}
> +
> +		if ((cc_status & CC1_DET_STS) < CC1_DET_STS_RP && type_c->at_cc1 == AT_CC1) {
> +			dev_dbg(dev, "IN device mode and cc1 host disconnect (cc_status=0x%x)",
> +				cc_status);
> +			type_c->is_attach = TO_DETACH;
> +			type_c->connect_change = CONNECT_CHANGE;
> +		} else if ((cc_status & CC2_DET_STS) < CC2_DET_STS_RP &&
> +			   type_c->at_cc1 == AT_CC2) {
> +			dev_dbg(dev, "IN device mode and cc2 host disconnect (cc_status=0x%x)",
> +				cc_status);
> +			type_c->is_attach = TO_DETACH;
> +			type_c->connect_change = CONNECT_CHANGE;
> +		}
> +		break;
> +	case IN_DEVICE_MODE | IN_DETACH:
> +		cc_status_check = readl(reg_base + USB_TYPEC_STS);
> +		if (cc_status_check != 0x0) {
> +			if (in_interrupt()) {
> +				mdelay(300);
> +			} else {
> +				spin_unlock_irqrestore(&type_c->lock, flags);
> +				msleep(300);
> +				spin_lock_irqsave(&type_c->lock, flags);
> +			}

ditto.

> +			cc_status_check = readl(reg_base + USB_TYPEC_STS);
> +		}
> +
> +		if (cc_status != cc_status_check) {
> +			dev_warn(dev, "IN_DEVICE_MODE: cc_status (0x%x) != cc_status_check (0x%x)\n",
> +				 cc_status, cc_status_check);
> +			cc_status = readl(reg_base + USB_TYPEC_STS);
> +		}
> +
> +		if ((cc_status & CC1_DET_STS) >= CC1_DET_STS_RP) {
> +			dev_dbg(dev, "IN device mode and cc1 host connect (cc_status=0x%x)",
> +				cc_status);
> +			type_c->at_cc1 = AT_CC1;
> +			type_c->is_attach = TO_ATTACH;
> +			type_c->connect_change = CONNECT_CHANGE;
> +		} else if ((cc_status & CC2_DET_STS) >= CC2_DET_STS_RP) {
> +			dev_dbg(dev, "IN device mode and cc2 host connect (cc_status=0x%x)",
> +				cc_status);
> +			type_c->at_cc1 = AT_CC2;
> +			type_c->is_attach = TO_ATTACH;
> +			type_c->connect_change = CONNECT_CHANGE;
> +		}
> +		break;
> +	default:
> +		dev_err(dev, "error host or device mode (cc_mode=%d, is_attach=%d) ",
> +			type_c->cc_mode, type_c->is_attach);
> +	}
> +
> +	type_c->int_status = int_status;
> +	type_c->cc_status = cc_status;
> +
> +	spin_unlock_irqrestore(&type_c->lock, flags);
> +	return 0;
> +}
> +
> +static void host_device_switch(struct work_struct *work)
> +{
> +	struct type_c_data *type_c = container_of(work, struct type_c_data,
> +						  delayed_work.work);
> +	struct device *dev = type_c->dev;
> +	unsigned long flags;
> +	int connect_change = 0;
> +	int cc_mode = 0;
> +	int is_attach = 0;
> +	int at_cc1 = 0;
> +
> +	spin_lock_irqsave(&type_c->lock, flags);
> +	if (type_c->connect_change)
> +		connect_change = type_c->connect_change;
> +	spin_unlock_irqrestore(&type_c->lock, flags);

Better to convert this code as following if type_c->connect_change is NULL,
you can reduce the lock/unlok operation of spin_lock. As you knew, spin_lock is expensive.
	
	if (type_c->connect_change) {
		spin_lock_irqsave(&type_c->lock, flags);
		connect_change = type_c->connect_change;
		spin_unlock_irqrestore(&type_c->lock, flags);
	}

> +
> +	if (!connect_change)
> +		detect_type_c_state(type_c);
> +
> +	spin_lock_irqsave(&type_c->lock, flags);
> +	if (type_c->connect_change) {
> +		connect_change = type_c->connect_change;
> +		cc_mode = type_c->cc_mode;
> +		is_attach = type_c->is_attach;
> +		at_cc1 = type_c->at_cc1;
> +		type_c->connect_change = CONNECT_NO_CHANGE;
> +	} else {
> +		host_device_switch_detection(type_c);
> +
> +		schedule_delayed_work(&type_c->delayed_work, msecs_to_jiffies(DETECT_TIME));
> +	}
> +	spin_unlock_irqrestore(&type_c->lock, flags);
> +
> +	if (connect_change) {

nitpick. 
You can reduce the depth of indentation when connector_change is 0
by changing the code as following: If possible, I always to try
to reduce the indentation depth for the readability.

	if (!connect_change)
		return

	dev_dbg(dev, "%s: usb cable connection change\n", __func__);
	if (cc_mode == IN_HOST_MODE) {
		......


> +		dev_dbg(dev, "%s: usb cable connection change\n", __func__);
> +		if (cc_mode == IN_HOST_MODE) {
> +			if (is_attach && at_cc1)
> +				device_attached(type_c, ENABLE_CC1);
> +			else if (is_attach && !at_cc1)
> +				device_attached(type_c, ENABLE_CC2);
> +			else
> +				device_detached(type_c, DISABLE_CC);
> +		} else if (cc_mode == IN_DEVICE_MODE) {
> +			if (is_attach && at_cc1)
> +				host_connected(type_c, ENABLE_CC1);
> +			else if (is_attach && !at_cc1)
> +				host_connected(type_c, ENABLE_CC2);
> +			else
> +				host_disconnected(type_c, DISABLE_CC);
> +		} else {
> +			dev_err(dev, "Error: IN unknown mode %d to %s at %s (cc_status=0x%x)\n",
> +				cc_mode, is_attach ? "attach" : "detach",
> +				at_cc1 ? "cc1" : "cc2", type_c->cc_status);
> +		}
> +		dev_info(dev, "Connection change OK: IN %s mode to %s at %s (cc_status=0x%x)\n",
> +			 cc_mode == IN_HOST_MODE ? "host" : "device",
> +			 is_attach ? "attach" : "detach",
> +			 at_cc1 ? "cc1" : "cc2", type_c->cc_status);
> +	}
> +}
> +
> +static irqreturn_t type_c_detect_irq(int irq, void *__data)
> +{
> +	struct type_c_data *type_c = (struct type_c_data *)__data;
> +	struct device *dev = type_c->dev;
> +	void __iomem *reg = type_c->reg_base + USB_TYPEC_CTRL;
> +	unsigned long flags;
> +
> +	detect_type_c_state(type_c);
> +
> +	spin_lock_irqsave(&type_c->lock, flags);
> +
> +	if (type_c->connect_change) {
> +		dev_dbg(dev, "%s: IN %s mode to %s (at %s interrupt) int_status=0x%x, cc_status=0x%x",
> +			__func__,
> +			type_c->cc_mode == IN_HOST_MODE ? "host" : "device",
> +			type_c->is_attach ? "attach" : "detach",
> +			type_c->at_cc1 ? "cc1" : "cc2",
> +			type_c->int_status, type_c->cc_status);
> +
> +		/* clear interrupt status */
> +		writel(~ALL_CC_INT_STS & readl(reg), reg);
> +
> +		cancel_delayed_work(&type_c->delayed_work);
> +		schedule_delayed_work(&type_c->delayed_work, msecs_to_jiffies(0));
> +	} else {
> +		static int local_count;
> +
> +		if (local_count++ > 10) {

It seems that clear interrupt status once every 10 times.
I think that it is not generic. You need to add the comment of why trying to clear
interrupt once every 10 times.

> +			/* clear interrupt status */
> +			writel(~ALL_CC_INT_STS & readl(reg), reg);
> +			local_count = 0;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&type_c->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}

(snip)

> +
> +static int extcon_rtk_type_c_init(struct type_c_data *type_c)
> +{
> +	struct device *dev = type_c->dev;
> +	unsigned long flags;
> +	void __iomem *reg;
> +	int val;
> +
> +	if ((type_c->rd_ctrl_gpio != -1) &&

nitpick.
After getting the gpio number by using of_get_named_gpio() function,
type_c->rd_ctrl_gpio is error number which is returned of_get_named_gpio().

In order to specify the more correctly, how about changing it as following?
Because I don't use the '-1' constant variable without any constant defintion.
Someone cannot understand the meaning of '-1'.

	if (!(type_c->rd_ctrl_gpio < 0))

> +	    gpio_request(type_c->rd_ctrl_gpio, dev->of_node->name))
> +		dev_err(dev, "%s ERROR Request rd_ctrl_gpio  (id=%d) fail\n",
> +			__func__, type_c->rd_ctrl_gpio);
> +
> +	spin_lock_irqsave(&type_c->lock, flags);
> +
> +	/* set parameter */
> +	reg = type_c->reg_base + USB_TYPEC_CTRL_CC1_0;
> +	val = readl(reg);
> +	val = (~CC_CODE_MASK & val) | (type_c->cc1_code & CC_CODE_MASK);
> +	writel(val, reg);
> +
> +	reg = type_c->reg_base + USB_TYPEC_CTRL_CC2_0;
> +	val = readl(reg);
> +	val = (~CC_CODE_MASK & val) | (type_c->cc2_code & CC_CODE_MASK);
> +
> +	reg = type_c->reg_base + USB_TYPEC_CTRL_CC1_1;
> +	writel(type_c->cc1_vref, reg);
> +
> +	reg = type_c->reg_base + USB_TYPEC_CTRL_CC2_1;
> +	writel(type_c->cc2_vref, reg);
> +
> +	reg = type_c->reg_base + USB_TYPEC_CTRL;
> +	val = readl(reg);
> +	val = (~DEBOUNCE_TIME_MASK & val) | (type_c->debounce & DEBOUNCE_TIME_MASK);
> +
> +	dev_info(dev, "First check USB_DR_MODE_PERIPHERAL");
> +	type_c->cc_mode = IN_DEVICE_MODE;
> +	type_c->is_attach = IN_DETACH;
> +	type_c->connect_change = CONNECT_NO_CHANGE;
> +
> +	detect_host(type_c);
> +
> +	spin_unlock_irqrestore(&type_c->lock, flags);
> +
> +	schedule_delayed_work(&type_c->delayed_work, msecs_to_jiffies(0));
> +
> +#ifdef CONFIG_TYPEC

Don'n need to check 'CONFIG_TYPEC' defintion wiht ifdef.
'ifdef' might make the code more complicated.

If type_c is optional, just print warning message
when typec_regiser_port returns error. 

This patch is already check whether 'type_c->port' is NULL or not
to handle the code related to typec.

> +	if (!type_c->port) {

(snip)

> +
> +		type_c->port = typec_register_port(type_c->dev, &typec_cap);
> +		if (IS_ERR(type_c->port))
> +			return PTR_ERR(type_c->port);
> +	}> +#endif /* CONFIG_TYPEC */
> +
> +	return 0;
> +}
> +
> +static int extcon_rtk_type_c_edev_register(struct type_c_data *type_c)
> +{
> +	struct device *dev = type_c->dev;
> +	int ret = 0;
> +
> +	type_c->edev = devm_extcon_dev_allocate(dev, usb_type_c_cable);
> +	if (IS_ERR(type_c->edev)) {
> +		dev_err(dev, "failed to allocate extcon device\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = devm_extcon_dev_register(dev, type_c->edev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register extcon device\n");
> +		return ret;
> +	}
> +
> +	extcon_set_property_capability(type_c->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(type_c->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +	extcon_set_property_capability(type_c->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_SS);
> +
> +	extcon_set_property_capability(type_c->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(type_c->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +	extcon_set_property_capability(type_c->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_SS);
> +
> +	return ret;
> +}
> +
> +static int extcon_rtk_type_c_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct type_c_data *type_c;
> +	const struct type_c_cfg *type_c_cfg;
> +	unsigned int gpio;
> +	int ret = 0;
> +
> +	type_c = devm_kzalloc(dev, sizeof(*type_c), GFP_KERNEL);
> +	if (!type_c)
> +		return -ENOMEM;
> +
> +	type_c->reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(type_c->reg_base))
> +		return PTR_ERR(type_c->reg_base);
> +
> +	type_c->dev = dev;
> +
> +	type_c->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (type_c->irq <= 0) {
> +		dev_err(&pdev->dev, "Type C driver with no IRQ. Check %s setup!\n",
> +			dev_name(&pdev->dev));
> +		ret = -ENODEV;
> +		goto err1;
> +	}
> +
> +	ret = devm_request_irq(dev, type_c->irq, type_c_detect_irq,
> +			       IRQF_SHARED, "type_c_detect", type_c);
> +
> +	spin_lock_init(&type_c->lock);
> +
> +	type_c->rd_ctrl_gpio = -1;
> +	if (soc_device_match(rtk_soc_kylin)) {
> +		gpio = of_get_named_gpio(dev->of_node, "realtek,rd-ctrl-gpio", 0);
> +		if (gpio_is_valid(gpio)) {
> +			type_c->rd_ctrl_gpio = gpio;
> +			dev_dbg(dev, "%s get rd-ctrl-gpio (id=%d) OK\n", __func__, gpio);
> +		} else {
> +			dev_err(dev, "Error rd_ctrl-gpio no found");
> +		}
> +	}
> +
> +	type_c_cfg = of_device_get_match_data(dev);
> +	if (!type_c_cfg) {
> +		dev_err(dev, "type_c config are not assigned!\n");
> +		return -EINVAL;
> +	}
> +
> +	type_c->type_c_cfg = devm_kzalloc(dev, sizeof(*type_c_cfg), GFP_KERNEL);
> +
> +	memcpy(type_c->type_c_cfg, type_c_cfg, sizeof(*type_c_cfg));
> +
> +	if (setup_type_c_parameter(type_c)) {
> +		dev_err(dev, "ERROR: %s to setup type c parameter!!", __func__);
> +		ret = -EINVAL;
> +		goto err1;
> +	}
> +
> +	INIT_DELAYED_WORK(&type_c->delayed_work, host_device_switch);
> +
> +	ret = extcon_rtk_type_c_init(type_c);
> +	if (ret) {
> +		dev_err(dev, "%s failed to init type_c\n", __func__);
> +		goto err1;
> +	}
> +
> +	platform_set_drvdata(pdev, type_c);
> +
> +	ret = extcon_rtk_type_c_edev_register(type_c);
> +
> +	create_debug_files(type_c);
> +
> +	return 0;
> +
> +err1:
> +	dev_err(&pdev->dev, "%s: Probe fail, %d\n", __func__, ret);
> +
> +	return ret;
> +}
> +
> +static void extcon_rtk_type_c_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct type_c_data *type_c = dev_get_drvdata(dev);
> +	u32 default_ctrl;
> +	unsigned long flags;
> +
> +	remove_debug_files(type_c);
> +
> +#ifdef CONFIG_TYPEC
> +	if (type_c->port) {
> +		typec_unregister_port(type_c->port);
> +		type_c->port = NULL;
> +	}
> +#endif
> +
> +	cancel_delayed_work_sync(&type_c->delayed_work);
> +	flush_delayed_work(&type_c->delayed_work);
> +	WARN_ON_ONCE(delayed_work_pending(&type_c->delayed_work));
> +
> +	spin_lock_irqsave(&type_c->lock, flags);
> +	/* disable interrupt */
> +	default_ctrl = readl(type_c->reg_base + USB_TYPEC_CTRL) &
> +		    DEBOUNCE_TIME_MASK;
> +	writel(default_ctrl, type_c->reg_base + USB_TYPEC_CTRL);
> +
> +	/* disable cc detect, rp, rd */
> +	writel(PLR_EN, type_c->reg_base + USB_TYPEC_CTRL_CC1_0);
> +	writel(0, type_c->reg_base + USB_TYPEC_CTRL_CC2_0);
> +
> +	spin_unlock_irqrestore(&type_c->lock, flags);
> +
> +	free_irq(type_c->irq, type_c);
> +}
> +
> +static const struct type_c_cfg rtd1295_type_c_cfg = {
> +	.parameter_ver = PARAMETER_V0,
> +	.cc_dfp_mode = CC_MODE_DFP_3_0,
> +	.cc1_param = { .rp_4p7k_code = 0xb,
> +		       .rp_36k_code = 0x17,
> +		       .rp_12k_code = 0x10,
> +		       .rd_code = 0,
> +		       .ra_code = 0,
> +		       .vref_2p6v = 0x0,
> +		       .vref_1p23v = 0x0,
> +		       .vref_0p8v = 0x3,
> +		       .vref_0p66v = 0x0,
> +		       .vref_0p4v = 0x0,
> +		       .vref_0p2v = 0x4,
> +		       .vref_1_1p6v = 0,
> +		       .vref_0_1p6v = 0 },
> +	.cc2_param = { .rp_4p7k_code = 0xc,
> +		       .rp_36k_code = 0x17,
> +		       .rp_12k_code = 0x12,
> +		       .rd_code = 0,
> +		       .ra_code = 0,
> +		       .vref_2p6v = 0x2,
> +		       .vref_1p23v = 0x0,
> +		       .vref_0p8v = 0x3,
> +		       .vref_0p66v = 0x0,
> +		       .vref_0p4v = 0x0,
> +		       .vref_0p2v = 0x5,
> +		       .vref_1_1p6v = 0,
> +		       .vref_0_1p6v = 0 },
> +	.debounce_val = 0x7f, /* 1b,1us 7f,4.7us */
> +	.use_defalut_parameter = false,
> +};
> +
> +static const struct type_c_cfg rtd1395_type_c_cfg = {
> +	.parameter_ver = PARAMETER_V0,
> +	.cc_dfp_mode = CC_MODE_DFP_3_0,
> +	.cc1_param = { .rp_4p7k_code = 0xc,
> +		       .rp_36k_code = 0xb,
> +		       .rp_12k_code = 0xe,
> +		       .rd_code = 0x10,
> +		       .ra_code = 0x0,
> +		       .vref_2p6v = 0x0,
> +		       .vref_1p23v = 0x1,
> +		       .vref_0p8v = 0x0,
> +		       .vref_0p66v = 0x0,
> +		       .vref_0p4v = 0x3,
> +		       .vref_0p2v = 0x0,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.cc2_param = { .rp_4p7k_code = 0xb,
> +		       .rp_36k_code = 0x9,
> +		       .rp_12k_code = 0xe,
> +		       .rd_code = 0xf,
> +		       .ra_code = 0x0,
> +		       .vref_2p6v = 0x1,
> +		       .vref_1p23v = 0x3,
> +		       .vref_0p8v = 0x3,
> +		       .vref_0p66v = 0x2,
> +		       .vref_0p4v = 0x3,
> +		       .vref_0p2v = 0x2,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.debounce_val = 0x7f, /* 1b,1us 7f,4.7us */
> +	.use_defalut_parameter = false,
> +};
> +
> +static const struct type_c_cfg rtd1619_type_c_cfg = {
> +	.parameter_ver = PARAMETER_V0,
> +	.cc_dfp_mode = CC_MODE_DFP_3_0,
> +	.cc1_param = { .rp_4p7k_code = 0xc,
> +		       .rp_36k_code = 0xf,
> +		       .rp_12k_code = 0xe,
> +		       .rd_code = 0x11,
> +		       .ra_code = 0x0,
> +		       .vref_2p6v = 0x5,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0xa,
> +		       .vref_0p66v = 0xa,
> +		       .vref_0p4v = 0x3,
> +		       .vref_0p2v = 0x2,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.cc2_param = { .rp_4p7k_code = 0xc,
> +		       .rp_36k_code = 0xf,
> +		       .rp_12k_code = 0xe,
> +		       .rd_code = 0xf,
> +		       .ra_code = 0x0,
> +		       .vref_2p6v = 0x5,
> +		       .vref_1p23v = 0x8,
> +		       .vref_0p8v = 0xa,
> +		       .vref_0p66v = 0xa,
> +		       .vref_0p4v = 0x3,
> +		       .vref_0p2v = 0x2,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.debounce_val = 0x7f, /* 1b,1us 7f,4.7us */
> +	.use_defalut_parameter = false,
> +};
> +
> +static const struct type_c_cfg rtd1319_type_c_cfg = {
> +	.parameter_ver = PARAMETER_V0,
> +	.cc_dfp_mode = CC_MODE_DFP_1_5,
> +	.cc1_param = { .rp_4p7k_code = 0x9,
> +		       .rp_36k_code = 0xe,
> +		       .rp_12k_code = 0x9,
> +		       .rd_code = 0x9,
> +		       .ra_code = 0x7,
> +		       .vref_2p6v = 0x3,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x7,
> +		       .vref_0p66v = 0x6,
> +		       .vref_0p4v = 0x2,
> +		       .vref_0p2v = 0x3,
> +		       .vref_1_1p6v = 0x4,
> +		       .vref_0_1p6v = 0x7 },
> +	.cc2_param = { .rp_4p7k_code = 0x8,
> +		       .rp_36k_code = 0xe,
> +		       .rp_12k_code = 0x9,
> +		       .rd_code = 0x9,
> +		       .ra_code = 0x7,
> +		       .vref_2p6v = 0x3,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x7,
> +		       .vref_0p66v = 0x6,
> +		       .vref_0p4v = 0x3,
> +		       .vref_0p2v = 0x3,
> +		       .vref_1_1p6v = 0x6,
> +		       .vref_0_1p6v = 0x7 },
> +	.debounce_val = 0x7f, /* 1b,1us 7f,4.7us */
> +	.use_defalut_parameter = false,
> +};
> +
> +static const struct type_c_cfg rtd1312c_type_c_cfg = {
> +	.parameter_ver = PARAMETER_V0,
> +	.cc_dfp_mode = CC_MODE_DFP_1_5,
> +	.cc1_param = { .rp_4p7k_code = 0xe,
> +		       .rp_36k_code = 0xc,
> +		       .rp_12k_code = 0xc,
> +		       .rd_code = 0xa,
> +		       .ra_code = 0x3,
> +		       .vref_2p6v = 0xa,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x7,
> +		       .vref_0p66v = 0x7,
> +		       .vref_0p4v = 0x4,
> +		       .vref_0p2v = 0x4,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.cc2_param = { .rp_4p7k_code = 0xe,
> +		       .rp_36k_code = 0xc,
> +		       .rp_12k_code = 0xc,
> +		       .rd_code = 0xa,
> +		       .ra_code = 0x3,
> +		       .vref_2p6v = 0xa,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x7,
> +		       .vref_0p66v = 0x7,
> +		       .vref_0p4v = 0x4,
> +		       .vref_0p2v = 0x4,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.debounce_val = 0x7f, /* 1b,1us 7f,4.7us */
> +	.use_defalut_parameter = false,
> +};
> +
> +static const struct type_c_cfg rtd1619b_type_c_cfg = {
> +	.parameter_ver = PARAMETER_V1,
> +	.cc_dfp_mode = CC_MODE_DFP_1_5,
> +	.cc1_param = { .rp_4p7k_code = 0xf,
> +		       .rp_36k_code = 0xf,
> +		       .rp_12k_code = 0xf,
> +		       .rd_code = 0xf,
> +		       .ra_code = 0x7,
> +		       .vref_2p6v = 0x9,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x9,
> +		       .vref_0p66v = 0x8,
> +		       .vref_0p4v = 0x7,
> +		       .vref_0p2v = 0x9,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.cc2_param = { .rp_4p7k_code = 0xf,
> +		       .rp_36k_code = 0xf,
> +		       .rp_12k_code = 0xf,
> +		       .rd_code = 0xf,
> +		       .ra_code = 0x7,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x9,
> +		       .vref_0p66v = 0x8,
> +		       .vref_0p4v = 0x7,
> +		       .vref_0p2v = 0x8,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.debounce_val = 0x7f, /* 1b,1us 7f,4.7us */
> +	.use_defalut_parameter = false,
> +};
> +
> +static const struct type_c_cfg rtd1319d_type_c_cfg = {
> +	.parameter_ver = PARAMETER_V1,
> +	.cc_dfp_mode = CC_MODE_DFP_1_5,
> +	.cc1_param = { .rp_4p7k_code = 0xe,
> +		       .rp_36k_code = 0x3,
> +		       .rp_12k_code = 0xe,
> +		       .rd_code = 0xf,
> +		       .ra_code = 0x6,
> +		       .vref_2p6v = 0x7,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x8,
> +		       .vref_0p66v = 0x7,
> +		       .vref_0p4v = 0x7,
> +		       .vref_0p2v = 0x7,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.cc2_param = { .rp_4p7k_code = 0xe,
> +		       .rp_36k_code = 0x3,
> +		       .rp_12k_code = 0xe,
> +		       .rd_code = 0xf,
> +		       .ra_code = 0x6,
> +		       .vref_2p6v = 0x7,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x8,
> +		       .vref_0p66v = 0x7,
> +		       .vref_0p4v = 0x7,
> +		       .vref_0p2v = 0x8,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.debounce_val = 0x7f, /* 1b,1us 7f,4.7us */
> +	.use_defalut_parameter = false,
> +};
> +
> +static const struct type_c_cfg rtd1315e_type_c_cfg = {
> +	.parameter_ver = PARAMETER_V1,
> +	.cc_dfp_mode = CC_MODE_DFP_1_5,
> +	.cc1_param = { .rp_4p7k_code = 0xe,
> +		       .rp_36k_code = 0x3,
> +		       .rp_12k_code = 0xe,
> +		       .rd_code = 0xf,
> +		       .ra_code = 0x6,
> +		       .vref_2p6v = 0x7,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x8,
> +		       .vref_0p66v = 0x7,
> +		       .vref_0p4v = 0x7,
> +		       .vref_0p2v = 0x7,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.cc2_param = { .rp_4p7k_code = 0xe,
> +		       .rp_36k_code = 0x3,
> +		       .rp_12k_code = 0xe,
> +		       .rd_code = 0xf,
> +		       .ra_code = 0x6,
> +		       .vref_2p6v = 0x7,
> +		       .vref_1p23v = 0x7,
> +		       .vref_0p8v = 0x8,
> +		       .vref_0p66v = 0x7,
> +		       .vref_0p4v = 0x7,
> +		       .vref_0p2v = 0x8,
> +		       .vref_1_1p6v = 0x7,
> +		       .vref_0_1p6v = 0x7 },
> +	.debounce_val = 0x7f, /* 1b,1us 7f,4.7us */
> +	.use_defalut_parameter = false,
> +};
> +
> +static const struct of_device_id extcon_rtk_type_c_match[] = {
> +	{ .compatible = "realtek,rtd1295-type-c", .data = &rtd1295_type_c_cfg },
> +	{ .compatible = "realtek,rtd1312c-type-c", .data = &rtd1312c_type_c_cfg },
> +	{ .compatible = "realtek,rtd1315e-type-c", .data = &rtd1315e_type_c_cfg },
> +	{ .compatible = "realtek,rtd1319-type-c", .data = &rtd1319_type_c_cfg },
> +	{ .compatible = "realtek,rtd1319d-type-c", .data = &rtd1319d_type_c_cfg },
> +	{ .compatible = "realtek,rtd1395-type-c", .data = &rtd1395_type_c_cfg },
> +	{ .compatible = "realtek,rtd1619-type-c", .data = &rtd1619_type_c_cfg },
> +	{ .compatible = "realtek,rtd1619b-type-c", .data = &rtd1619b_type_c_cfg },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, extcon_rtk_type_c_match);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int extcon_rtk_type_c_prepare(struct device *dev)
> +{
> +	struct type_c_data *type_c = dev_get_drvdata(dev);
> +	u32 default_ctrl;
> +	unsigned long flags;
> +
> +	cancel_delayed_work_sync(&type_c->delayed_work);
> +	flush_delayed_work(&type_c->delayed_work);
> +	WARN_ON_ONCE(delayed_work_pending(&type_c->delayed_work));
> +
> +	spin_lock_irqsave(&type_c->lock, flags);
> +	/* disable interrupt */
> +	default_ctrl = readl(type_c->reg_base + USB_TYPEC_CTRL) &
> +		    DEBOUNCE_TIME_MASK;
> +	writel(default_ctrl, type_c->reg_base + USB_TYPEC_CTRL);
> +
> +	/* disable cc detect, rp, rd */
> +	writel(PLR_EN, type_c->reg_base + USB_TYPEC_CTRL_CC1_0);
> +	writel(0, type_c->reg_base + USB_TYPEC_CTRL_CC2_0);
> +
> +	spin_unlock_irqrestore(&type_c->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void extcon_rtk_type_c_complete(struct device *dev)
> +{
> +	/* nothing */
> +}
> +
> +static int extcon_rtk_type_c_suspend(struct device *dev)
> +{
> +	struct type_c_data *type_c = dev_get_drvdata(dev);
> +
> +	if (type_c->rd_ctrl_gpio != -1)

ditto.

> +		gpio_free(type_c->rd_ctrl_gpio);
> +
> +	return 0;
> +}
> +
> +static int extcon_rtk_type_c_resume(struct device *dev)
> +{
> +	struct type_c_data *type_c = dev_get_drvdata(dev);
> +
> +	extcon_rtk_type_c_init(type_c);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops extcon_rtk_type_c_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(extcon_rtk_type_c_suspend, extcon_rtk_type_c_resume)
> +	.prepare = extcon_rtk_type_c_prepare,
> +	.complete = extcon_rtk_type_c_complete,
> +};
> +
> +#define DEV_PM_OPS	(&extcon_rtk_type_c_pm_ops)
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static struct platform_driver extcon_rtk_type_c_driver = {
> +	.probe		= extcon_rtk_type_c_probe,
> +	.remove_new	= extcon_rtk_type_c_remove,
> +	.driver		= {
> +		.name	= "extcon-rtk-type_c",
> +		.of_match_table = extcon_rtk_type_c_match,
> +		.pm = DEV_PM_OPS,
> +	},
> +};
> +
> +module_platform_driver(extcon_rtk_type_c_driver);
> +
> +MODULE_DESCRIPTION("Realtek Extcon Type C driver");
> +MODULE_ALIAS("platform:extcon-rtk-type-c");
> +MODULE_AUTHOR("Stanley Chang <stanley_chang@realtek.com>");
> +MODULE_LICENSE("GPL");

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

