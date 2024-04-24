Return-Path: <linux-kernel+bounces-157786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7658B162E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA892828E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF516E86A;
	Wed, 24 Apr 2024 22:30:17 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id ADCC41EA80
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997816; cv=none; b=DGkpqkuTTqveTxDM0D93Zae9GXNnzeCAV8TydfaLJLpBNT8vt3tvm/VThanwNOXUj/nmEAKlpwhsr0jAXisGwIDGqg8yP89OFJwYLNbwtyBAMl0yCWQurrKor/2vaROAnBIU9EXGofWzg1aTctFbyI18QKcA3BH0T6oZd6MBIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997816; c=relaxed/simple;
	bh=HDHCFTiG9P0rM6J/rTMdHTIogb/0OwpJMxF2VUxSp74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9LUHuUdI6/QvmpgFyM791MCCHpB58ofFbvU7JHbdu98ShKRN5yjD+KP/QScEKKYQrNlYYPyJLIhc0NOuz0cQQeD+o2JqBPBoa/Ufb8XVbhDGlG9hQ/LGyMQO7q4ede7XCYZkBiRfmv9BVQzlfGiRwiL7oyiJiLfsmo6eoXtM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 470718 invoked by uid 1000); 24 Apr 2024 18:30:06 -0400
Date: Wed, 24 Apr 2024 18:30:06 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
Message-ID: <0a29cc85-a79e-476d-aae6-0a054aad2e90@rowland.harvard.edu>
References: <20240424195951.3749388-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424195951.3749388-1-linux@roeck-us.net>

On Wed, Apr 24, 2024 at 12:59:51PM -0700, Guenter Roeck wrote:
> Testing ohci functionality with qemu's pci-ohci emulation often results
> in ohci interface stalls, resulting in hung task timeouts.
> 
> The problem is caused by lost interrupts between the emulation and the
> Linux kernel code. Additional interrupts raised while the ohci interrupt
> handler in Linux is running and before the handler clears the interrupt
> status are not handled. The fix for a similar problem in ehci suggests
> that the problem is likely caused by edge-triggered MSI interrupts. See
> commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
> edge-triggered MSI") for details.
> 
> Ensure that the ohci interrupt code handles all pending interrupts before
> returning to solve the problem.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Only repeat if the interface is still active

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Greg might insist that the patch be CC'ed to stable@vger.kernel.org since 
it contains a Fixes: tag.

Alan Stern

>  drivers/usb/host/ohci-hcd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 4f9982ecfb58..bb6b50b4a356 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -888,6 +888,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  	/* Check for an all 1's result which is a typical consequence
>  	 * of dead, unclocked, or unplugged (CardBus...) devices
>  	 */
> +again:
>  	if (ints == ~(u32)0) {
>  		ohci->rh_state = OHCI_RH_HALTED;
>  		ohci_dbg (ohci, "device removed!\n");
> @@ -982,6 +983,13 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  	}
>  	spin_unlock(&ohci->lock);
>  
> +	/* repeat until all enabled interrupts are handled */
> +	if (ohci->rh_state != OHCI_RH_HALTED) {
> +		ints = ohci_readl(ohci, &regs->intrstatus);
> +		if (ints & ohci_readl(ohci, &regs->intrenable))
> +			goto again;
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.39.2
> 

