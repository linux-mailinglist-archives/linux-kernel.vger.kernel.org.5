Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8FC763912
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjGZO1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjGZO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:27:45 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7A5A810A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:27:44 -0700 (PDT)
Received: (qmail 1924318 invoked by uid 1000); 26 Jul 2023 10:27:43 -0400
Date:   Wed, 26 Jul 2023 10:27:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/30] usb: ohci-at91: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <2ab38659-a25b-43a8-934a-5d44533a51c2@rowland.harvard.edu>
References: <20230726113816.888-1-frank.li@vivo.com>
 <20230726113816.888-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726113816.888-3-frank.li@vivo.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:37:49PM +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/usb/host/ohci-at91.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index b9ce8d80f20b..f957d008f360 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -200,8 +200,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  		return -ENOMEM;
>  	ohci_at91 = hcd_to_ohci_at91_priv(hcd);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	hcd->regs = devm_ioremap_resource(dev, res);
> +	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(hcd->regs)) {
>  		retval = PTR_ERR(hcd->regs);
>  		goto err;

Did you try to test-compile this change (and all the similar ones in 
this series)?  If you did, you would have gotten a warning about res 
being used without being initialized.

Alan Stern
