Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A178D784497
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjHVOmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbjHVOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C8187;
        Tue, 22 Aug 2023 07:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E2A46592A;
        Tue, 22 Aug 2023 14:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A521C433C9;
        Tue, 22 Aug 2023 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692715362;
        bh=JwRaFdXpBFPQvWg+7PAhwk5RLTvKjoAS3evEC/T1Ics=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0euQLufgFNRSnjyplQRQhH6HbdZ16LqtVmuSb58MLZK863JtFKmETmzT7qsFuvx/1
         7AZFXTdjbLMe+TvyViLIOikGnRQlyITSgy6SalJvI4fc9sZgJ1Gyv3f4zzqpVi5SkV
         rMT1Wl/QM+uKVEgvzVXFUQNMsQRQCzzhGz5Nl3IY=
Date:   Tue, 22 Aug 2023 16:42:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Sebastian Reichel <sre@kernel.org>, Bin Liu <b-liu@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: musb: dsps: Fix vbus vs tps65217-charger irq
 conflict
Message-ID: <2023082256-judiciary-udder-6d06@gregkh>
References: <20230822132202.19659-1-nemith592@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822132202.19659-1-nemith592@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 03:22:02PM +0200, Grant B Adams wrote:
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

Why is the patch here talking about the tps65217-charger driver?  That's
totally independent.

Also, your patches are not threaded, how did you send them?  Are they
related in some way or not?

thanks,

greg k-h
