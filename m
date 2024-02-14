Return-Path: <linux-kernel+bounces-65046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64F2854719
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18721C26A33
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0811759D;
	Wed, 14 Feb 2024 10:24:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5317552;
	Wed, 14 Feb 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906284; cv=none; b=X0p13Q0O50BRsA4NnkbumW3H38mrD36ADVV0yB2SnHf3BokNndb7CettSoMaTrLzMagL1mAi62iIVo54MUrFbkTbEGNlH1Pw9ZiWw2IpFgtT9qzTc5G06C7Xl7N0UEUtYrCKyeZ/sG96YDs9+urUgy0i919wgqF1kgOWkZvZDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906284; c=relaxed/simple;
	bh=L/qyyXzgC6hYYYA38GAe52ZNx6yR11HINzKT0BfZ7dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrVD9XHSD6oB5s3auWuv4fEQcjST6He3HxW3k5lw1Vz506JBfJEunUFe16lo3iO9uZb6S1wtnl4W44sMHlK1lUG2y5HFtzi9iUBBLbEkhk2uyrU6rMTsHkopsiI3oHFBDZxZlYiX1uhvbVxRDokLUhvylXN/zPsxK2NJR2YXWQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62E3C433F1;
	Wed, 14 Feb 2024 10:24:42 +0000 (UTC)
Message-ID: <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>
Date: Wed, 14 Feb 2024 11:24:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l: marvell: select CONFIG_V4L2_ASYNC where
 needed
Content-Language: en-US, nl
To: Arnd Bergmann <arnd@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20240213095555.454392-1-arnd@kernel.org>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240213095555.454392-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Arnd, Sakari,

Is this something that needs to go to v6.8? Or just v6.9?

Do we need a Fixes tag?

Regards,

	Hans

On 13/02/2024 10:55, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Drivers that call v4l2_async_nf_init() need to select the corresponding
> Kconfig symbol:
> 
> ERROR: modpost: "v4l2_async_nf_init" [drivers/media/platform/marvell/cafe_ccic.ko] undefined!
> ERROR: modpost: "__v4l2_async_nf_add_i2c" [drivers/media/platform/marvell/cafe_ccic.ko] undefined!
> ERROR: modpost: "v4l2_async_nf_unregister" [drivers/media/platform/marvell/mcam-core.ko] undefined!
> ERROR: modpost: "v4l2_async_nf_init" [drivers/media/platform/marvell/mmp_camera.ko] undefined!
> ERROR: modpost: "__v4l2_async_nf_add_fwnode_remote" [drivers/media/platform/marvell/mmp_camera.ko] undefined!
> 
> I checked all v4l2 drivers to see if anything else has the same
> bug, but these two appear to be the only ones.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/platform/marvell/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/marvell/Kconfig b/drivers/media/platform/marvell/Kconfig
> index d6499ffe30e8..d31f4730f2a3 100644
> --- a/drivers/media/platform/marvell/Kconfig
> +++ b/drivers/media/platform/marvell/Kconfig
> @@ -7,6 +7,7 @@ config VIDEO_CAFE_CCIC
>  	depends on V4L_PLATFORM_DRIVERS
>  	depends on PCI && I2C && VIDEO_DEV
>  	depends on COMMON_CLK
> +	select V4L2_ASYNC
>  	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
>  	select VIDEOBUF2_VMALLOC
>  	select VIDEOBUF2_DMA_CONTIG
> @@ -24,6 +25,7 @@ config VIDEO_MMP_CAMERA
>  	depends on COMMON_CLK
>  	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
>  	select I2C_GPIO
> +	select V4L2_ASYNC
>  	select VIDEOBUF2_VMALLOC
>  	select VIDEOBUF2_DMA_CONTIG
>  	select VIDEOBUF2_DMA_SG


