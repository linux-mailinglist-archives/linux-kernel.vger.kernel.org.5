Return-Path: <linux-kernel+bounces-140489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEA08A155B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF131F22680
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499C22096;
	Thu, 11 Apr 2024 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u7hkPWTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A314C58E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841246; cv=none; b=U+mnDsOpRUOk1/KVINZgnguI3YBTXF/itkqgI3Ggy6wKJCuedAUMOQo9C/W4mm2SLvr+PinrjRDOuQCjVRKDrfrTU37clOJClk86fMAGeH6PCWoENNsQA5hMDW1bcA+rZMKPC8UrrIAoUhMgBJdUUwY7rwsoq4iA6dPLOdH9f2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841246; c=relaxed/simple;
	bh=1RGUiBi+xQELudFAau2uEPqeagTAW0M6fMKQJBQQyzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad6NFQ+KFwePA8VziAhJXS2ahsVcW6/rIoLAjWmyBU76V/bATDzpe7TS4AEgVGLPGbw+8gLFZI0n6qTngaxcADdatvITY1E9aSzYRogmFlc3wXO8Y51n4dqJZxomvduOnNR6lb1pCEB8n7zM1xcpRrQrXK9wbPFX9WHFiHLU8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u7hkPWTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE2EC433C7;
	Thu, 11 Apr 2024 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712841245;
	bh=1RGUiBi+xQELudFAau2uEPqeagTAW0M6fMKQJBQQyzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7hkPWTdnfilXOBBsLtkNEUZI8O0cdFb9K7cG+x9MyL6qGD8xUnvqwrbsbEbVwuB2
	 RSqgm2UUyhsgxEEcApv7GdYWNPBta+NN6kShi8jwH+D+IFG52XLe71y4VuQ+iKMGE/
	 oiOA42vGS2AD9+awZHlKuNHLPUGBWbPc3qLoNI6Q=
Date: Thu, 11 Apr 2024 15:14:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huai-Yuan Liu <qq810974084@gmail.com>
Cc: sudipm.mukherjee@gmail.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com
Subject: Re: [PATCH V3] ppdev: Add an error check in register_device
Message-ID: <2024041153-undrilled-partition-2a9e@gregkh>
References: <20240407132054.12170-1-qq810974084@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407132054.12170-1-qq810974084@gmail.com>

On Sun, Apr 07, 2024 at 09:20:54PM +0800, Huai-Yuan Liu wrote:
> In register_device, the return value of ida_simple_get is unchecked, 
> in witch ida_simple_get will use an invalid index value.
> 
> To address this issue, index should be checked after ida_simple_get. When
> the index value is abnormal, a warning message should be printed, the port
> should be dropped, and the value should be recorded.
> 
> Fixes: 9a69645dde11 ("ppdev: fix registering same device name")
> Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
> ---
> V2:
> * In patch V2, we found that parport_find_number implicitly calls
> parport_get_port(). So when dealing with abnormal index values, we should
> call parport_put_port() to throw away the reference to the port.
> V3:
> * In patch V3, we made some additional adjustments to the jump labels,
> making the code more concise and readable.
>   Thanks to Christophe JAILLET for helpful suggestion.
> ---
>  drivers/char/ppdev.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
> index 4c188e9e477c..276db589b901 100644
> --- a/drivers/char/ppdev.c
> +++ b/drivers/char/ppdev.c
> @@ -296,28 +296,36 @@ static int register_device(int minor, struct pp_struct *pp)
>  	if (!port) {
>  		pr_warn("%s: no associated port!\n", name);
>  		rc = -ENXIO;
> -		goto err;
> +		goto err_free_name;
>  	}
>  
>  	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
> +	if (index < 0) {
> +		pr_warn("%s: failed to get index!\n", name);
> +		rc = index;
> +		goto err_put_port;
> +	}
> +
>  	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
>  	ppdev_cb.irq_func = pp_irq;
>  	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
>  	ppdev_cb.private = pp;
>  	pdev = parport_register_dev_model(port, name, &ppdev_cb, index);
> -	parport_put_port(port);
>  
>  	if (!pdev) {
>  		pr_warn("%s: failed to register device!\n", name);
>  		rc = -ENXIO;
>  		ida_simple_remove(&ida_index, index);
> -		goto err;
> +		goto err_put_port;
>  	}
>  
>  	pp->pdev = pdev;
>  	pp->index = index;
>  	dev_dbg(&pdev->dev, "registered pardevice\n");
> -err:
> +
> +err_put_port:
> +	parport_put_port(port);
> +err_free_name:
>  	kfree(name);
>  	return rc;
>  }
> -- 
> 2.34.1
> 

Does not apply to the tree at all :(

