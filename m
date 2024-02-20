Return-Path: <linux-kernel+bounces-72566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E1E85B551
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106552889F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45B5D473;
	Tue, 20 Feb 2024 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s7F8Zg8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B345CDE0;
	Tue, 20 Feb 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418072; cv=none; b=oR/ryAEEuHAXwGWLjQ5FwqcYVb80i2V02ndzfx+hiopbMkSJdqAq3wFukQ7RCYwqsfcpbZycgGi8l6uCGj92OcnEBkMcqbv5FL8Gi2MAjuJABY8j4ZQKBT0ni+7P1Sd+cILHzHaai20RBAVOVOTcxq5fDjdX38Qr0JYhpr8bHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418072; c=relaxed/simple;
	bh=s+96Op57oDFXNRMP69sWGVC3Iy4Su0Dddc6jDgQQ+8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxWiKcQFalJaxY9Fek+jDZNkd9O5TfF2MA45N7V4Bsd5JsjdRpC6q7wEGLYWKRfVVmhvB/fqN4NViol6Mey2QooivxpBOXOaJ+a9el+DJtnkABJem3HxJnOf3qM91LFIkEV2gH7krS8DDO8scgW0VF3sv09Y+x5ogcRqiSvWGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s7F8Zg8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FC2C433C7;
	Tue, 20 Feb 2024 08:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708418071;
	bh=s+96Op57oDFXNRMP69sWGVC3Iy4Su0Dddc6jDgQQ+8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7F8Zg8J15g+nMxHZnbVwu87WwqvQq2uCWjNNqbEfUXpeL25cXS9IaH3DzyQ8+mKj
	 WtXX0FoGhHIzwsiDHgzPYwl8MeFqIUiN0XXF6D+uftUseV3wXLsfBFrslNd/49WCKH
	 Y2llnEVajr7eyNMrmqkCgq4msNhJadAvA9Lrcb9k=
Date: Tue, 20 Feb 2024 09:34:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ray Chi <raychi@google.com>
Cc: Thinh.Nguyen@synopsys.com, quic_uaggarwa@quicinc.com,
	albertccwang@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: remove warning during kernel boot
Message-ID: <2024022024-trout-kennel-6d14@gregkh>
References: <20240220081205.135063-1-raychi@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220081205.135063-1-raychi@google.com>

On Tue, Feb 20, 2024 at 04:12:04PM +0800, Ray Chi wrote:
> The dwc3->gadget_driver is not initialized during the dwc3 probe
> process. This leads to a warning when the runtime power management (PM)
> attempts to suspend the gadget using dwc3_gadget_suspend().

What type of warning happens?

> This patch adds a check to prevent the warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend")
> Signed-off-by: Ray Chi <raychi@google.com>
> ---
>  drivers/usb/dwc3/gadget.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 28f49400f3e8..de987cffe1ec 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4708,6 +4708,9 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
>  	unsigned long flags;
>  	int ret;
>  
> +	if (!dwc->gadget_driver)
> +		return 0;
> +

This directly reverts part of the commit you say this fixes, are you
SURE about this?  Why?

thanks,

greg k-h

