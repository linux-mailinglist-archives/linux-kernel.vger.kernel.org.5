Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBCC7840E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjHVMf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHVMf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EBB196;
        Tue, 22 Aug 2023 05:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74773655C3;
        Tue, 22 Aug 2023 12:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4165DC433C8;
        Tue, 22 Aug 2023 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692707724;
        bh=QbQ7MAct0KMZDWDEaE6Yv6uUdfFsPx5IUZRMtL4IpOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltGRzM3cMRk7uUSi2ppA/ts1mwLk6Z3Sk9wIXROu9fRr+Ie5P2lvs6v1+D5emHPFE
         Np79bfZ/+58cBZFyJ0EZ6cOE/wijxJfdX2Jz44Y7Yl0Z5uHIqiPcm9U6GX5KGOY8FE
         CijIb5e9LR6UZ/35+tvqz2mogX0rLxMPuylDOaP0=
Date:   Tue, 22 Aug 2023 14:35:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Bin Liu <b-liu@ti.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: musb: dsps: Fix vbus vs tps65217-charger irq
 conflict
Message-ID: <2023082210-vaguely-tiring-7e2b@gregkh>
References: <20230811114856.35486-1-nemith592@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811114856.35486-1-nemith592@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:48:56PM +0200, Grant B Adams wrote:
> Enabling the tps65217-charger driver/module causes an interrupt conflict
> with the vbus driver resulting in a probe failure.
> The conflict is resolved by changing both driver's threaded interrupt
> request function from IRQF_ONESHOT to IRQF_SHARED.
> 
> Signed-off-by: Grant B Adams <nemith592@gmail.com>
> ---
>  drivers/usb/musb/musb_dsps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 9119b1d51370..cbb45de5a76f 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -851,7 +851,7 @@ static int dsps_setup_optional_vbus_irq(struct platform_device *pdev,
>  
>  	error = devm_request_threaded_irq(glue->dev, glue->vbus_irq,
>  					  NULL, dsps_vbus_threaded_irq,
> -					  IRQF_ONESHOT,
> +					  IRQF_SHARED,
>  					  "vbus", glue);
>  	if (error) {
>  		glue->vbus_irq = 0;
> -- 
> 2.34.1
> 

Where is patch 1/2 of this series?

Please resend the whole series.

thanks,

greg k-h
