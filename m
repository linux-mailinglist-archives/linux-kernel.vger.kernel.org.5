Return-Path: <linux-kernel+bounces-66377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B7855BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D31B1F24E82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A011184;
	Thu, 15 Feb 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lk+3gT8f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B1BDF5C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983358; cv=none; b=d5XVjDOWCXV6mzA109hLKZm16WpfGQypRuGEm7euGIFe+s36zJunsnabQwJrk+SDqVNGEuAoIWmbNdT4BxdB0KwGBz7y8DHdAnjN/i836Igy7wcAZ6yvwuNEGCpwrpR9VI9TB1qZ4lTJ4+nP2EuzdfJtFbnPnRfwhvY3r7P3pnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983358; c=relaxed/simple;
	bh=yRUw9CYJ6uyFJWQRSmlGBkO+R7YksGKsR9jpcrmgjwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc7mp8YLjm3Ge6qxXGZJ2VrqyaugrLU0Yvy9FuD4tQXq3B1bNuvflzZPOEp1H6zhoPyTdmiqOLhRsOa+xsiWxk+v8DvwWyZoxV1ZT1ZtNp9/ys/z6XDAJNCDyt23Dj0e2ERKDUOWIloA15p+6TsOMIOSHItPE9/7gHh6sPicgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lk+3gT8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005B5C433C7;
	Thu, 15 Feb 2024 07:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707983357;
	bh=yRUw9CYJ6uyFJWQRSmlGBkO+R7YksGKsR9jpcrmgjwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lk+3gT8fYApB9KmsUTcF+RB9AQs58Sdj1brYwNFJhIL6hV5xssThy0DoY+VHm7Vom
	 UHw1F694//PtcxmZPjn2vU8JFzrQrDhs0OOfEwSQhO7ptp05JlkmnwnjOW7wXHOtY4
	 V7aq2x6+LyD6EISJu6wr0TQzRCLLrzjg9hVB2974=
Date: Thu, 15 Feb 2024 08:49:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: make nvmem_layout_bus_type const
Message-ID: <2024021503-eardrum-manhandle-3f65@gregkh>
References: <20240214-bus_cleanup-nvmem2-v1-1-97960007da18@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-bus_cleanup-nvmem2-v1-1-97960007da18@marliere.net>

On Wed, Feb 14, 2024 at 04:04:57PM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type, move the nvmem_layout_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/nvmem/layouts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
> index 6a6aa58369ff..8b5e2de138eb 100644
> --- a/drivers/nvmem/layouts.c
> +++ b/drivers/nvmem/layouts.c
> @@ -45,7 +45,7 @@ static void nvmem_layout_bus_remove(struct device *dev)
>  	return drv->remove(layout);
>  }
>  
> -static struct bus_type nvmem_layout_bus_type = {
> +static const struct bus_type nvmem_layout_bus_type = {
>  	.name		= "nvmem-layout",
>  	.match		= nvmem_layout_bus_match,
>  	.probe		= nvmem_layout_bus_probe,
> 
> ---
> base-commit: 2c8df24cc166478910c4e9e870adf44d157330fa
> change-id: 20240214-bus_cleanup-nvmem2-b77804172a0b
> 


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

