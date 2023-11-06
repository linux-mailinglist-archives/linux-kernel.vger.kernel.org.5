Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54A7E2986
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjKFQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjKFQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:15:03 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E71BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:15:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1r02FZ-0003qg-T5; Mon, 06 Nov 2023 17:14:53 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1r02FZ-0075Lk-5q; Mon, 06 Nov 2023 17:14:53 +0100
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1r02FZ-000i2P-3Q; Mon, 06 Nov 2023 17:14:53 +0100
Date:   Mon, 6 Nov 2023 17:14:53 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] soc: imx8mp: support 128 bits UID
Message-ID: <20231106161453.tucbpn643cxub3ah@pengutronix.de>
References: <20231029034547.3039893-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029034547.3039893-1-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

thanks for your patch, please see my comments below.

On 23-10-29, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current driver only supports 64bits UID for i.MX8MP, but
> i.MX8MP UID is actually 128bits, the high 64bits is at 0xE00.
> So update driver to support it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Address Shawn and Macro's comments
> 
>  drivers/soc/imx/soc-imx8m.c | 63 +++++++++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index ec87d9d878f3..6ed7889e1902 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -24,6 +24,7 @@
>  #define OCOTP_UID_HIGH			0x420
>  
>  #define IMX8MP_OCOTP_UID_OFFSET		0x10
> +#define IMX8MP_OCOTP_UID_HIGH		0xe00
>  
>  /* Same as ANADIG_DIGPROG_IMX7D */
>  #define ANADIG_DIGPROG_IMX8MM	0x800
> @@ -31,9 +32,11 @@
>  struct imx8_soc_data {
>  	char *name;
>  	u32 (*soc_revision)(void);
> +	bool uid_128bit;

Can we replace this by:

  	void (*soc_uid)(void);

and let the driver data set the correct soc_uid function within the
driver data? Please see below for further comments on this.

>  };
>  
>  static u64 soc_uid;
> +static u64 soc_uid_h;
>  
>  #ifdef CONFIG_HAVE_ARM_SMCCC
>  static u32 imx8mq_soc_revision_from_atf(void)
> @@ -101,8 +104,6 @@ static void __init imx8mm_soc_uid(void)
>  	void __iomem *ocotp_base;
>  	struct device_node *np;
>  	struct clk *clk;
> -	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
> -		     IMX8MP_OCOTP_UID_OFFSET : 0;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
>  	if (!np)
> @@ -118,12 +119,52 @@ static void __init imx8mm_soc_uid(void)
>  
>  	clk_prepare_enable(clk);
>  
> -	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
> +	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
>  	soc_uid <<= 32;
> -	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
> +	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
>  
>  	clk_disable_unprepare(clk);
>  	clk_put(clk);
> +
> +	iounmap(ocotp_base);
> +	of_node_put(np);
> +}
> +
> +static void __init imx8mp_soc_uid(void)
> +{
> +	void __iomem *ocotp_base;
> +	struct device_node *np;
> +	struct clk *clk;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-ocotp");
> +	if (!np)
> +		return;
> +
> +	ocotp_base = of_iomap(np, 0);
> +	if (!ocotp_base) {
> +		WARN_ON(!ocotp_base);
> +		return;
> +	}
> +
> +	clk = of_clk_get_by_name(np, NULL);
> +	if (IS_ERR(clk)) {
> +		WARN_ON(IS_ERR(clk));
> +		return;
> +	}
> +
> +	clk_prepare_enable(clk);
> +
> +	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + IMX8MP_OCOTP_UID_OFFSET);

We can avoid this (base + old_reg + offset) pattern now and just do:

	soc_uid = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_BITS_64_32);

> +	soc_uid <<= 32;
> +	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + IMX8MP_OCOTP_UID_OFFSET);

	soc_uid |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_BITS_32_0);

> +	soc_uid_h = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH + 0x10);

	soc_uid = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_BITS_128_96);

> +	soc_uid_h <<= 32;
> +	soc_uid_h |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH);

	soc_uid |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_BITS_96_64);

with:

#define IMX8MP_OCOTP_UID_BITS_32_0	0x420
#define IMX8MP_OCOTP_UID_BITS_64_32	0x430
#define IMX8MP_OCOTP_UID_BITS_96_64	0xe00
#define IMX8MP_OCOTP_UID_BITS_128_96	0xe10

> +
> +	clk_disable_unprepare(clk);
> +	clk_put(clk);
> +
>  	iounmap(ocotp_base);
>  	of_node_put(np);
>  }
> @@ -146,7 +187,11 @@ static u32 __init imx8mm_soc_revision(void)
>  	iounmap(anatop_base);
>  	of_node_put(np);
>  
> -	imx8mm_soc_uid();
> +
> +	if (of_machine_is_compatible("fsl,imx8mp"))
> +		imx8mp_soc_uid();
> +	else
> +		imx8mm_soc_uid();

Sorry for beeing a bit picky but we could improve this driver even
further and drop this additional unnecessary of_machine_is_compatible()
if we make the soc_uid() a function hook which can be filled by the
driver data. Doing the UID within the imx8mm_soc_revision() seems wrong
to too since the revisions is using the anatop and the uid the ocotp
register space. So it made only sense for the i.MX8MQ.

>  	return rev;
>  }
> @@ -169,6 +214,7 @@ static const struct imx8_soc_data imx8mn_soc_data = {
>  static const struct imx8_soc_data imx8mp_soc_data = {
>  	.name = "i.MX8MP",
>  	.soc_revision = imx8mm_soc_revision,
> +	.uid_128bit = true,
>  };
>  
>  static __maybe_unused const struct of_device_id imx8_soc_match[] = {
> @@ -222,7 +268,12 @@ static int __init imx8_soc_init(void)
>  		goto free_soc;
>  	}

The new hook should be called like it is done for the soc_revision hook,
so within the:

	if (data) {
		soc_dev_attr->soc_id = data->name;
		if (data->soc_revision)
			soc_rev = data->soc_revision();
		if (data->soc_uid)
			data->soc_uid();
	}

The split into soc_uid() hook for the i.MX8M platforms can be done
within a seperate patch to make it more clear. The next patch should add
the support to read the upper 64 bits.

> -	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
> +	if (data->uid_128bit)

This can be checked via:

	if (soc_uid_h)
> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
> +							soc_uid_h, soc_uid);
> +	else
> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
> +
>  	if (!soc_dev_attr->serial_number) {
>  		ret = -ENOMEM;
>  		goto free_rev;

Regards,
  Marco
