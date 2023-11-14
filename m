Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE57EABB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjKNIjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNIjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:39:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713AAA4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:38:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF65BC433C8;
        Tue, 14 Nov 2023 08:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699951138;
        bh=Qz4bqCfb39E5fvYkFxANSDUiv0YU+cze73hZIqUJoas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Evo9Jq1Z02upcf0EdAXLr4DlJDNCEFzN9aofJ05Ssk28wE/s7yhMnPCIvtgjG0ebI
         YM6fuhkTs2jJDiOoKnHakIJYHuesen4hL+NtfDBjRZvQF8EuPFzgLbCkoBmgNzOZsE
         s3n/I/E9TmOG/fgt1nv3OA3McT+8vff5mbv0UJyMud8/LPvkoJ6JH5x0L/A9jKkM+j
         7txpZPI0iD1r3pY5eyEyrFoBp5IL1uS3Seukf8ep1Cy8W1L4C8p18vwf0qlBY4/6U+
         +6XOvxBO1VkkzrCzFAJVUCL8vBorLhLrC2Na/51HzRKdACb/vSbbch47ukXavw6VqS
         7H3lwKgnE9B8Q==
Date:   Tue, 14 Nov 2023 16:38:38 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] usb: cdns3: support power-off of controller when in
 host role
Message-ID: <20231114083838.GC64573@nchen-desktop>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-4-ad1ee714835c@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113-j7200-usb-suspend-v1-4-ad1ee714835c@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-13 15:26:59, Théo Lebrun wrote:
> The controller is not being reconfigured at resume. Change resume to
> redo hardware config if quirk CDNS3_RESET_ON_RESUME is active.

Current logic has power off judgement, see cdns3_controller_resume for
detail.

> 
> Platform data comes from the parent driver (eg cdns3-ti).
> 
> The quirk should be passed if the platform driver knows that the
> controller might be in reset state at resume. We do NOT reconfigure the
> hardware without this quirk to avoid losing state if we did a suspend
> without reset.
> 
> If the quirk is on, we notify the xHCI subsystem that:
> 
> 1. We reset on resume. It will therefore redo the xHC init & trigger
>    such message as "root hub lost power or was reset" in dmesg.
> 
> 2. It should disable/enable clocks on suspend/resume. This does not
>    matter on our platform as xhci-plat does not get access to any clock
>    but it would be the right thing to do if we indeed had such clocks.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/core.h |  1 +
>  drivers/usb/cdns3/host.c | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 81a9c9d6be08..7487067ba23f 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -44,6 +44,7 @@ struct cdns3_platform_data {
>  			bool suspend, bool wakeup);
>  	unsigned long quirks;
>  #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
> +#define CDNS3_RESET_ON_RESUME		BIT(1)
>  };
>  
>  /**
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> index 6164fc4c96a4..a81019a7c8cc 100644
> --- a/drivers/usb/cdns3/host.c
> +++ b/drivers/usb/cdns3/host.c
> @@ -88,6 +88,9 @@ static int __cdns_host_init(struct cdns *cdns)
>  		goto err1;
>  	}
>  
> +	if (cdns->pdata && cdns->pdata->quirks & CDNS3_RESET_ON_RESUME)
> +		cdns->xhci_plat_data->quirks |= XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS;
> +

If you set this flag, how could you support the USB remote wakeup
request? In that case, the USB bus does not expect re-enumeration.

>  	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
>  		cdns->xhci_plat_data->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>  
> @@ -124,6 +127,18 @@ static void cdns_host_exit(struct cdns *cdns)
>  	cdns_drd_host_off(cdns);
>  }
>  
> +static int cdns_host_suspend(struct cdns *cdns, bool do_wakeup)
> +{
> +	if (!do_wakeup)
> +		cdns_drd_host_off(cdns);
> +	return 0;
> +}
> +
> +static int cdns_host_resume(struct cdns *cdns, bool hibernated)
> +{
> +	return cdns_drd_host_on(cdns);

This one will redo if controller's power is off, please consider both
on and power situation.

> +}
> +
>  int cdns_host_init(struct cdns *cdns)
>  {
>  	struct cdns_role_driver *rdrv;
> @@ -137,6 +152,11 @@ int cdns_host_init(struct cdns *cdns)
>  	rdrv->state	= CDNS_ROLE_STATE_INACTIVE;
>  	rdrv->name	= "host";
>  
> +	if (cdns->pdata && cdns->pdata->quirks & CDNS3_RESET_ON_RESUME) {
> +		rdrv->suspend = cdns_host_suspend;
> +		rdrv->resume = cdns_host_resume;
> +	}
> +
>  	cdns->roles[USB_ROLE_HOST] = rdrv;
>  
>  	return 0;
> 
> -- 
> 2.41.0
> 

-- 

Thanks,
Peter Chen
