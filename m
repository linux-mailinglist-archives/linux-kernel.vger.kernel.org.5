Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555C17F2AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjKUKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjKUKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:41:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED2911C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:41:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42018C433C8;
        Tue, 21 Nov 2023 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700563268;
        bh=6ssmz9Fzj5B5OmCb07mIm3SGwRw9YGJdqqjNOMzjqjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4vK5vs4oL3icSXZydnqDM56wAeOdVXHDrdnc5HGhc07aObDsKuXDA6nPc9Kb/AjO
         tFTsFjQsYLFV6t2wKtWlJRyz8RSctyacMs0ecueARCS6ikBk4balsn1z9IN/cBBhf5
         b8a4mu42V8h2H1j9aw4XOLMiz4gg1lBZeQc8Rcqdpa7CAMwhGOZUPS43Aoercery22
         A+VWLfY9me9tZNzztinOEcud0MxToeqAgO3RzE+vgDoV0GfSa1VN6plMRXx4ONNNBw
         52A1UllKq6WlZhEA3yy3s6mPDMlPFWkKB4LuyaHcT/uK52CcIyMSq30d/3K552YJil
         8xS4+R7zYbMxg==
Date:   Tue, 21 Nov 2023 18:40:56 +0800
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
        linux-arm-kernel@lists.infradead.org,
        ThomasPetazzonithomas.petazzoni@bootlin.com,
        =?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH v2 5/7] usb: cdns3: add quirk to platform data for
 reset-on-resume
Message-ID: <20231121104056.GA541474@nchen-desktop>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
 <20231120-j7200-usb-suspend-v2-5-038c7e4a3df4@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120-j7200-usb-suspend-v2-5-038c7e4a3df4@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-20 18:06:05, Théo Lebrun wrote:
> The cdns3 host role does not care about reset-on-resume. xHCI however
> reconfigures itself in silence rather than printing a warning about a
> resume error. Related warning example:
> 
>   [   16.017462] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit
> 
> Allow passing a CDNS3_RESET_ON_RESUME quirk flag from cdns3 pdata down
> to xHCI pdata. The goal is to allow signaling about reset-on-resume
> behavior from platform wrapper drivers.
> 
> When used, remote wakeup is not expected to work.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
>  drivers/usb/cdns3/core.h | 1 +
>  drivers/usb/cdns3/host.c | 3 +++
>  2 files changed, 4 insertions(+)
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
> index 6164fc4c96a4..28c4d1deb231 100644
> --- a/drivers/usb/cdns3/host.c
> +++ b/drivers/usb/cdns3/host.c
> @@ -91,6 +91,9 @@ static int __cdns_host_init(struct cdns *cdns)
>  	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
>  		cdns->xhci_plat_data->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>  
> +	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_RESET_ON_RESUME))
> +		cdns->xhci_plat_data->quirks |= XHCI_RESET_ON_RESUME;
> +
>  	ret = platform_device_add_data(xhci, cdns->xhci_plat_data,
>  			sizeof(struct xhci_plat_priv));
>  	if (ret)
> 
> -- 
> 2.42.0
> 

-- 

Thanks,
Peter Chen
