Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093EB7BF224
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376907AbjJJFU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344471AbjJJFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:20:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E937AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 22:20:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qq5Ao-0001Xy-WC; Tue, 10 Oct 2023 07:20:51 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1qq5An-000aIe-RI; Tue, 10 Oct 2023 07:20:49 +0200
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qq5An-00DfhY-Of; Tue, 10 Oct 2023 07:20:49 +0200
Date:   Tue, 10 Oct 2023 07:20:49 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: imx8mp: support 128 bits UID
Message-ID: <20231010052049.iwqn5cnk523jixq2@pengutronix.de>
References: <20231008083808.1517132-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008083808.1517132-1-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 23-10-08, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current driver only supports 64bits UID for i.MX8MP, but
> i.MX8MP UID is actually 128bits, the high 64bits is at 0xE00.
> So update driver to support it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index ec87d9d878f3..5dcc227d41c0 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -24,6 +24,7 @@
>  #define OCOTP_UID_HIGH			0x420
>  
>  #define IMX8MP_OCOTP_UID_OFFSET		0x10
> +#define IMX8MP_OCOTP_UID_HIGH		0xE00
						  ^
						0xe00

>  /* Same as ANADIG_DIGPROG_IMX7D */
>  #define ANADIG_DIGPROG_IMX8MM	0x800
> @@ -34,6 +35,7 @@ struct imx8_soc_data {
>  };
>  
>  static u64 soc_uid;
> +static u64 soc_uid_h;
>  
>  #ifdef CONFIG_HAVE_ARM_SMCCC
>  static u32 imx8mq_soc_revision_from_atf(void)
> @@ -122,8 +124,15 @@ static void __init imx8mm_soc_uid(void)
>  	soc_uid <<= 32;
>  	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
>  
> +	if (offset) {
> +		soc_uid_h = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH + 0x10);
> +		soc_uid_h <<= 32;
> +		soc_uid_h |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH);
> +	}

Since the function is very small and with this addition the shared code
is very limited. So I would rather tend to have a separate
imx8mp_soc_uid() function.

> +
>  	clk_disable_unprepare(clk);
>  	clk_put(clk);
> +
>  	iounmap(ocotp_base);
>  	of_node_put(np);
>  }
> @@ -222,7 +231,12 @@ static int __init imx8_soc_init(void)
>  		goto free_soc;
>  	}
>  
> -	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
> +	if (soc_uid_h) {

We already do have match data can't we do something like this:

	if (id->uid_128bit)
		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
							soc_uid_h, soc_uid);
	else
		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);

Regards,
  Marco

> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
> +							soc_uid_h, soc_uid);
> +	} else {
> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
> +	}
>  	if (!soc_dev_attr->serial_number) {
>  		ret = -ENOMEM;
>  		goto free_rev;
> -- 
> 2.37.1
> 
> 
> 
