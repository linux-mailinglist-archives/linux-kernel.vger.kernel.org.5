Return-Path: <linux-kernel+bounces-17918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B693982551A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23629B22986
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3702DF62;
	Fri,  5 Jan 2024 14:22:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4F2D7A7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6E0BC15;
	Fri,  5 Jan 2024 06:23:32 -0800 (PST)
Received: from [10.57.44.155] (unknown [10.57.44.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 482333F7A6;
	Fri,  5 Jan 2024 06:22:45 -0800 (PST)
Message-ID: <fc74c447-a15b-4fda-bc36-fa39894946e6@arm.com>
Date: Fri, 5 Jan 2024 14:22:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: make coresight_bustype const
Content-Language: en-GB
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 coresight@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
References: <2024010531-tinfoil-avert-4a57@gregkh>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <2024010531-tinfoil-avert-4a57@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/01/2024 12:33, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the coresight_bustype variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 2 +-
>   include/linux/coresight.h                    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 9fabe00a40d6..24c49e581737 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1796,7 +1796,7 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
>   }
>   EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
>   
> -struct bus_type coresight_bustype = {
> +const struct bus_type coresight_bustype = {
>   	.name	= "coresight",
>   };
>   
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index a269fffaf991..8fe75a0d7693 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -35,7 +35,7 @@
>   
>   #define CORESIGHT_UNLOCK	0xc5acce55
>   
> -extern struct bus_type coresight_bustype;
> +extern const struct bus_type coresight_bustype;

Thanks, for the patch. I will queue this for v6.8.

Thanks
Suzuki
>   
>   enum coresight_dev_type {
>   	CORESIGHT_DEV_TYPE_SINK,


