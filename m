Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75117F3445
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjKUQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKUQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:53:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECFD92
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:53:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE4CC433C7;
        Tue, 21 Nov 2023 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700585615;
        bh=dXMSeMNK+WEBDV6rnNty0bayoAnlHmRDxFemjBJL70E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ra6Vhd55uJUnkSGETGcDSGW77NyER+qrJBIyENP3uAPYGiRUemWipmmhMGJika2xK
         OTrvmNCYHM2k6oEaRQqR30ujYKgxmVSXp0Cygnya952ww30PVtxhv01Sgm5Meo06Zw
         DvXk7eEo7SnZEE+J1XCKENfBU3gUTJhVA1FG5bOkGbZasJKZ+8H8c1+dC1heCKtFhK
         A2fO2twFLiA+Fpf3daT6uxwCp+STjsR39x4g8T+1YcB/wTIIa5asKzcv6Y3/CuVoGX
         t/BumSB2tJTR85lpdGri4xW6sGKdpZYAVhXnqe6ufmYrjPMhBl2Q3okB/M4JShskYu
         I0dIeaL3sUNgg==
Message-ID: <d2bd89f1-a86b-4fe4-a7ad-20c7e8caf9b6@kernel.org>
Date:   Tue, 21 Nov 2023 18:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] usb: cdns3-ti: signal reset-on-resume to xHCI for
 J7200 platform
Content-Language: en-US
To:     =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
 <20231120-j7200-usb-suspend-v2-6-038c7e4a3df4@bootlin.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231120-j7200-usb-suspend-v2-6-038c7e4a3df4@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2023 19:06, Théo Lebrun wrote:
> Pass CDNS3_RESET_ON_RESUME as platform data to cdns3 host role. It will
> in turn pass it down to xHCI platform data as XHCI_RESET_ON_RESUME.
> 
> Avoid this warning on resume:
> 
>   [   16.017462] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit
> 
> When used, remote wakeup is not expected to work.
> 
> Only focus J7200 as other SoC are untested.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 84f93c2fcd5c..7d56a1acbc54 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include "core.h"
>  
>  /* USB Wrapper register offsets */
>  #define USBSS_PID		0x0
> @@ -128,6 +129,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = pdev->dev.of_node;
> +	const struct of_dev_auxdata *auxdata;
>  	struct cdns_ti *data;
>  	unsigned long rate;
>  	int error, i;
> @@ -177,7 +179,8 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  
>  	cdns_ti_init_hw(data);
>  
> -	error = of_platform_populate(node, NULL, NULL, dev);
> +	auxdata = of_device_get_match_data(dev);
> +	error = of_platform_populate(node, NULL, auxdata, dev);
>  	if (error) {
>  		dev_err(dev, "failed to create children: %d\n", error);
>  		return error;
> @@ -222,8 +225,20 @@ static const struct dev_pm_ops cdns_ti_pm_ops = {
>  
>  #endif /* CONFIG_PM */
>  
> +static struct cdns3_platform_data cdns_ti_j7200_pdata = {
> +	.quirks = CDNS3_RESET_ON_RESUME,
> +};

We will need to introduce a new data structure "struct cdns_ti_platform_data"
and add platform specific details like "reset_on_resume" to it.
This is to address what Krzysztof pointed to in patch 4.

> +
> +static const struct of_dev_auxdata cdns_ti_j7200_auxdata[] = {
> +	{
> +		.compatible = "cdns,usb3",
> +		.platform_data = &cdns_ti_j7200_pdata,
> +	},
> +	{},
> +};
> +
>  static const struct of_device_id cdns_ti_of_match[] = {
> -	{ .compatible = "ti,j7200-usb", },
> +	{ .compatible = "ti,j7200-usb", .data = cdns_ti_j7200_auxdata, },

Here we should pass "struct cdns_ti_platform_data"

>  	{ .compatible = "ti,j721e-usb", },
>  	{ .compatible = "ti,am64-usb", },
>  	{},
> 

-- 
cheers,
-roger
