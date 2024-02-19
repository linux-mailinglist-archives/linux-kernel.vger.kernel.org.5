Return-Path: <linux-kernel+bounces-71593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54A185A78B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CAD2815C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60F639AD5;
	Mon, 19 Feb 2024 15:37:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDDA383BE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357021; cv=none; b=rBlrERTVQKQGs8Ow2CxLTqBSzQxzwZOJB5LmIxsxmoqW4IKojsghwU4E5p/3TdZ/Gjtk6wikEjA4u5MdNkoajv3ywuVF+d3BAzoGOGnQ7OLKQn1FIXh+UoTx/TKzXJI8udLpnj9L8GRq6ZLTe3gOxjLglzR+iKnxW+UqptjRUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357021; c=relaxed/simple;
	bh=8KZpnnBsbpLu8GE2mANOnSknsqHAGg5dhZ59vdXuTiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4vWuNluxRSjE8aT/ajV+gW8aaBF+if54HtrKHVlgBGuGy0AUImXzjFJhTE3sKpjOZRsovg337R7BBc1pHKRdXk5PALqKTsEo3juHyLBztLRQ4c6knO7qKKAbkGKjOWFaFzAzSCZBAXsX3gfSGdwYuSMdfeeZvq4dff4kNxrAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69841FEC;
	Mon, 19 Feb 2024 07:37:39 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF6873F7CE;
	Mon, 19 Feb 2024 07:36:57 -0800 (PST)
Message-ID: <9bdf420c-f716-2a18-4b68-a8c6331eeb39@arm.com>
Date: Mon, 19 Feb 2024 15:36:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] coresight: constify the struct device_type usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20240219-device_cleanup-coresight-v1-1-4a8a0b816183@marliere.net>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240219-device_cleanup-coresight-v1-1-4a8a0b816183@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/02/2024 13:43, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> coresight_dev_type variable to be a constant structure as well, placing it
> into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/hwtracing/coresight/coresight-priv.h  | 2 +-
>  drivers/hwtracing/coresight/coresight-sysfs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index eb365236f9a9..ca3362cbdb70 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -13,7 +13,7 @@
>  #include <linux/pm_runtime.h>
>  
>  extern struct mutex coresight_mutex;
> -extern struct device_type coresight_dev_type[];
> +extern const struct device_type coresight_dev_type[];
>  
>  /*
>   * Coresight management registers (0xf00-0xfcc)
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index f9444e2cb1d9..1e67cc7758d7 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -377,7 +377,7 @@ static struct attribute *coresight_source_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(coresight_source);
>  
> -struct device_type coresight_dev_type[] = {
> +const struct device_type coresight_dev_type[] = {
>  	[CORESIGHT_DEV_TYPE_SINK] = {
>  		.name = "sink",
>  		.groups = coresight_sink_groups,
> 
> ---
> base-commit: c099fdd218a0fedfe87e0b88d2ba0667eab3b3c8
> change-id: 20240219-device_cleanup-coresight-00ba00fd5f21
> 
> Best regards,


Reviewed-by: James Clark <james.clark@arm.com>

