Return-Path: <linux-kernel+bounces-20445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4ED827F14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D941F245EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675409455;
	Tue,  9 Jan 2024 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kxd7L47X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6A79C4;
	Tue,  9 Jan 2024 07:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F35C433C7;
	Tue,  9 Jan 2024 07:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704784381;
	bh=KW+h+R/WBAgOJEnE4m6clFnLxv6Xr732ZUMriIV0kXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxd7L47X0QpJB6vNmFmMeG8Ml9h67ISPM5fncSn9iX0I6pyMJksIukgSkx9A5iEPz
	 qHNbTKzZ5vhtTcJcbqrPZKnhL54J2VhEaRGVxrl825lzPF1CuKKPfJ7AQ3ORT5nbnM
	 qTpM9K/NdVGqbOptQZsEJOFU3lcr3Yxh6i9oaPE4=
Date: Tue, 9 Jan 2024 08:12:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Elad Nachman <enachman@marvell.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: host: Add ac5 to EHCI Orion
Message-ID: <2024010943-deluxe-snitch-febc@gregkh>
References: <20240108175457.4113480-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108175457.4113480-1-enachman@marvell.com>

On Mon, Jan 08, 2024 at 07:54:57PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add support for ac5 to the EHCI Orion platform driver.
> The ac5 SOC has DDR starting at offset 0x2_0000_0000,
> Hence it requires a larger than 32-bit DMA mask to operate.
> Move the dma mask to be pointed by the OF match data, and
> use that match data when initializng the DMA mask.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/usb/host/ehci-orion.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
> index 6c47ab0a491d..58883664c884 100644
> --- a/drivers/usb/host/ehci-orion.c
> +++ b/drivers/usb/host/ehci-orion.c
> @@ -65,6 +65,15 @@ struct orion_ehci_hcd {
>  
>  static struct hc_driver __read_mostly ehci_orion_hc_driver;
>  
> +/*
> + * Legacy DMA mask is 32 bit.
> + * AC5 has the DDR starting at 8GB, hence it requires
> + * a larger (34-bit) DMA mask, in order for DMA allocations
> + * to succeed:
> + */
> +static const u64 dma_mask_orion =	DMA_BIT_MASK(32);
> +static const u64 dma_mask_ac5 =		DMA_BIT_MASK(34);
> +
>  /*
>   * Implement Orion USB controller specification guidelines
>   */
> @@ -211,6 +220,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
>  	int irq, err;
>  	enum orion_ehci_phy_ver phy_version;
>  	struct orion_ehci_hcd *priv;
> +	u64 *dma_mask_ptr;
>  
>  	if (usb_disabled())
>  		return -ENODEV;
> @@ -228,7 +238,8 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
>  	 * set. Since shared usb code relies on it, set it here for
>  	 * now. Once we have dma capability bindings this can go away.
>  	 */
> -	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	dma_mask_ptr = (u64 *)of_device_get_match_data(&pdev->dev);
> +	err = dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
>  	if (err)
>  		goto err;
>  
> @@ -332,9 +343,9 @@ static void ehci_orion_drv_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id ehci_orion_dt_ids[] = {
> -	{ .compatible = "marvell,orion-ehci", },
> -	{ .compatible = "marvell,armada-3700-ehci", },
> -	{},
> +	{ .compatible = "marvell,orion-ehci", .data = &dma_mask_orion},
> +	{ .compatible = "marvell,armada-3700-ehci", .data = &dma_mask_orion},
> +	{ .compatible = "marvell,ac5-ehci", .data = &dma_mask_ac5},
>  };
>  MODULE_DEVICE_TABLE(of, ehci_orion_dt_ids);
>  
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

