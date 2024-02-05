Return-Path: <linux-kernel+bounces-52031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E338A849314
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E86283ACC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCE8B65D;
	Mon,  5 Feb 2024 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnhPjGgF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720AB64A;
	Mon,  5 Feb 2024 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108759; cv=none; b=h2n4xQXHCg82eQZ3Ot3SAXTBxUFyKQElMAoZk07LcnzXJR1DldXFNsRColoyOeGiQ4oWT8N7XGUYnfrOoFKti/kKczHVEJan+QaR+hLmIREFuF71KAhs+Y7Yhy1MeEfz+4Pujnt6lp43cU9fOtmA+x8p7KrTenaBD9V3WHtEq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108759; c=relaxed/simple;
	bh=HhfVX9BYq7tXbakLwJPIqNA5VK+k8QfcCLl9is71Btw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTXclpzwzN8aypA+rSqSDtGZtvg8lE6qrTcPA0yCbKQ8xtnfgXD3C0Fe6c7pGgYtAeQ9WrswO2hriGxeEJ/KCHMpC2OdrMAX5icltoyKvB+SWkJadiCnD/DZ00VRyx4DKJRBdtIIZhXIX5OMmz4ApbjkIoMa5VatWoylEjbt/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnhPjGgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB08C433F1;
	Mon,  5 Feb 2024 04:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707108758;
	bh=HhfVX9BYq7tXbakLwJPIqNA5VK+k8QfcCLl9is71Btw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnhPjGgFyQhyuQROGwOdLLBeT4oA12tLKttw3ALePE6WEt5r6N1S/oT5DqWI2UJmr
	 cDha40mGE4hpMAWU7OU2F5aEVU1DwbqE4JPMUwNIFsUogmCfILErgFHmonh6JAJlPw
	 SU+rAT2zvHYtebukTj9XiNuBXw+S4N0LgtZT3feln2JSB1gOg09qDW0P6sMYubT6cv
	 BQjcCnzMDOVJ987LoSFX2Xh/UX8uuC5qOH4loInt5EjdGQRkDgWWoZvBmaD1ujQVKR
	 BXeGb/ZW2RngcjwIFPpe2NsfPJbccSK1ci6x48yD59ajzVAK4RZ+57mocJoyOk0zp+
	 WaXH4op24+DrQ==
Date: Mon, 5 Feb 2024 12:52:27 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: rogerq@kernel.org, felipe.balbi@linux.intel.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	pawell@cadence.com
Subject: Re: [PATCH v2 2/2] usb: cdns3: fix memory double free when handle
 zero packet
Message-ID: <20240205045227.GD1200221@nchen-desktop>
References: <20240202154217.661867-1-Frank.Li@nxp.com>
 <20240202154217.661867-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202154217.661867-2-Frank.Li@nxp.com>

On 24-02-02 10:42:17, Frank Li wrote:
> 829  if (request->complete) {
> 830          spin_unlock(&priv_dev->lock);
> 831          usb_gadget_giveback_request(&priv_ep->endpoint,
> 832                                    request);
> 833          spin_lock(&priv_dev->lock);
> 834  }
> 835
> 836  if (request->buf == priv_dev->zlp_buf)
> 837      cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
> 
> Driver append an additional zero packet request when queue a packet, which
> length mod max packet size is 0. When transfer complete, run to line 831,
> usb_gadget_giveback_request() will free this requestion. 836 condition is
> true, so cdns3_gadget_ep_free_request() free this request again.
> 
> Log:
> 
> [ 1920.140696][  T150] BUG: KFENCE: use-after-free read in cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
> [ 1920.140696][  T150]
> [ 1920.151837][  T150] Use-after-free read at 0x000000003d1cd10b (in kfence-#36):
> [ 1920.159082][  T150]  cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
> [ 1920.164988][  T150]  cdns3_transfer_completed+0x438/0x5f8 [cdns3]
> 
> Add check at line 829, skip call usb_gadget_giveback_request() if it is
> additional zero length packet request. Needn't call
> usb_gadget_giveback_request() because it is allocated in this driver.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index d6723d31fc6e2..fd1beb10bba72 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -828,7 +828,11 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
>  			return;
>  	}
>  
> -	if (request->complete) {
> +	/*
> +	 * zlp request is appended by driver, needn't call usb_gadget_giveback_request() to notify
> +	 * gadget composite driver.
> +	 */
> +	if (request->complete && request->buf != priv_dev->zlp_buf) {
>  		spin_unlock(&priv_dev->lock);
>  		usb_gadget_giveback_request(&priv_ep->endpoint,
>  					    request);
> -- 
> 2.34.1
> 

-- 

Thanks,
Peter Chen

