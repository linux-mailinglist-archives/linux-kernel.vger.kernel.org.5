Return-Path: <linux-kernel+bounces-144790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 921758A4ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 218FEB22F57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F53C3D969;
	Mon, 15 Apr 2024 08:47:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0E03CF73
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170822; cv=none; b=ViOkGwnpSPAAAkEnvlIgm2nNYHMsI07PqAcEOZBbBr4xBnSjjaH99NGh9rwCFlXC9Lc2tCYlwyJp95k/dATxPQaIxizGIBINk7Kp2sUDmZ+IlZ041J+Uj5zlhLtuDehenR8+/O1/+MCvw225xnsog/fz6KG5Oz3/kAIx2wEJ58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170822; c=relaxed/simple;
	bh=OQNw4LBQ/YZYiZ9fTgbcylTBMNdRue7L9lu8bUUlgY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glOQLOGQjHw74wvLCY+6uVFHpVIWjz385v0e9s5fXjheFoJ23SxOmyvzzP3eSE7jy6H3eSD+OnD1YoCbg43Suj777JkG/25uhL826xL3fH7H0GgdONiJVtfnfybnv7TfDWVwVLAglOZx+wTIvLY7d/NvnCDWUnH/bYdJZT1QEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 032DD2F;
	Mon, 15 Apr 2024 01:47:28 -0700 (PDT)
Received: from [10.57.76.98] (unknown [10.57.76.98])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 036033F64C;
	Mon, 15 Apr 2024 01:46:57 -0700 (PDT)
Message-ID: <54e4a174-dea7-4588-b8a6-0310c210ffce@arm.com>
Date: Mon, 15 Apr 2024 09:46:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Add defer probe for firmware load
To: Andy Yan <andyshrk@163.com>, boris.brezillon@collabora.com
Cc: daniel@ffwll.ch, airlied@gmail.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Andy Yan <andy.yan@rock-chips.com>
References: <20240413114938.740631-1-andyshrk@163.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240413114938.740631-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/04/2024 12:49, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The firmware in the rootfs will not be accessible until we
> are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
> that point.
> This let the driver can load firmware when it is builtin.

The usual solution is that the firmware should be placed in the
initrd/initramfs if the module is included there (or built-in). The same
issue was brought up regarding the powervr driver:

https://lore.kernel.org/dri-devel/20240109120604.603700-1-javierm@redhat.com/T/

I'm not sure if that ever actually reached a conclusion though. The
question was deferred to Greg KH but I didn't see Greg actually getting
involved in the thread.

> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  drivers/gpu/drm/panthor/panthor_fw.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 33c87a59834e..25e375f8333c 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1336,8 +1336,17 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	}
>  
>  	ret = panthor_fw_load(ptdev);
> -	if (ret)
> +	if (ret) {
> +		/*
> +		 * The firmware in the rootfs will not be accessible until we
> +		 * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
> +		 * that point.
> +		 */
> +		if (system_state < SYSTEM_RUNNING)

This should really only be in the case where ret == -ENOENT - any other
error and the firmware is apparently present but broken in some way, so
there's no point deferring.

I also suspect we'd need some change in panthor_fw_load() to quieten
error messages if we're going to defer on this, in which case it might
make more sense to move this logic into that function.

Steve

> +			ret = -EPROBE_DEFER;
> +
>  		goto err_unplug_fw;
> +	}
>  
>  	ret = panthor_vm_active(fw->vm);
>  	if (ret)


