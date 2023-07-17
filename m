Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E6D756014
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGQKHv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 06:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGQKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:07:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019D10E6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:07:21 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qLL8L-00015l-Ud; Mon, 17 Jul 2023 12:07:14 +0200
Message-ID: <66749b1b4523d2859b9fbc6e9120e5f1e887d531.camel@pengutronix.de>
Subject: Re: [PATCH v1 8/8] drm/etnaviv: Add a helper to get a pointer to
 the first available node
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Jul 2023 12:07:12 +0200
In-Reply-To: <20230623100822.274706-9-sui.jingfeng@linux.dev>
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
         <20230623100822.274706-9-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 23.06.2023 um 18:08 +0800 schrieb Sui Jingfeng:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> This make the code in etnaviv_pdev_probe() less twisted, drop the reference
> to device node after finished. Also kill a double blank line.
> 
I can't spot the double blank line you claim to remove.

> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 32 ++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 7d0eeab3e8b7..3446f8eabf59 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -27,6 +27,19 @@
>   * DRM operations:
>   */
>  
> +/* If the DT contains at least one available GPU, return a pointer to it */
> +
I think the code in the function is simple enough that we don't need a
comment explaining what it does.

Regards,
Lucas

> +static struct device_node *etnaviv_of_first_node(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, "vivante,gc") {
> +		if (of_device_is_available(np))
> +			return np;
> +	}
> +
> +	return NULL;
> +}
>  
>  static void load_gpu(struct drm_device *dev)
>  {
> @@ -587,7 +600,7 @@ static const struct component_master_ops etnaviv_master_ops = {
>  static int etnaviv_pdev_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *first_node = NULL;
> +	struct device_node *first_node;
>  	struct component_match *match = NULL;
>  
>  	if (!dev->platform_data) {
> @@ -597,11 +610,10 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
>  			if (!of_device_is_available(core_node))
>  				continue;
>  
> -			if (!first_node)
> -				first_node = core_node;
> -
>  			drm_of_component_match_add(&pdev->dev, &match,
>  						   component_compare_of, core_node);
> +
> +			of_node_put(core_node);
>  		}
>  	} else {
>  		char **names = dev->platform_data;
> @@ -634,8 +646,11 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
>  	 * device as the GPU we found. This assumes that all Vivante
>  	 * GPUs in the system share the same DMA constraints.
>  	 */
> -	if (first_node)
> +	first_node = etnaviv_of_first_node();
> +	if (first_node) {
>  		of_dma_configure(&pdev->dev, first_node, true);
> +		of_node_put(first_node);
> +	}
>  
>  	return component_master_add_with_match(dev, &etnaviv_master_ops, match);
>  }
> @@ -709,17 +724,14 @@ static int __init etnaviv_init(void)
>  	 * If the DT contains at least one available GPU device, instantiate
>  	 * the DRM platform device.
>  	 */
> -	for_each_compatible_node(np, NULL, "vivante,gc") {
> -		if (!of_device_is_available(np))
> -			continue;
> +	np = etnaviv_of_first_node();
> +	if (np) {
>  		of_node_put(np);
>  
>  		ret = etnaviv_create_platform_device("etnaviv",
>  						     &etnaviv_platform_device);
>  		if (ret)
>  			goto unregister_platform_driver;
> -
> -		break;
>  	}
>  
>  	return 0;

