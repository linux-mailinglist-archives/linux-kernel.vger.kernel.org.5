Return-Path: <linux-kernel+bounces-12605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFAC81F7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186B6285954
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CA36FCB;
	Thu, 28 Dec 2023 11:26:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C86FBE;
	Thu, 28 Dec 2023 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 621A82F4;
	Thu, 28 Dec 2023 03:26:56 -0800 (PST)
Received: from [192.168.151.22] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 558E23F5A1;
	Thu, 28 Dec 2023 03:26:07 -0800 (PST)
Message-ID: <12ce6e5d-6e4d-fb99-eb82-dece97423bfb@arm.com>
Date: Thu, 28 Dec 2023 11:26:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] coresight: Add coresight name support
Content-Language: en-US
To: Mao Jinlong <quic_jinlmao@quicinc.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20231228093321.5522-1-quic_jinlmao@quicinc.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231228093321.5522-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/12/2023 09:33, Mao Jinlong wrote:
> Add coresight name support for custom names which will be
> easy to identify the device by the name.
> 

I suppose this is more of a V2 because the subject is the same as the
one sent earlier this year. But it looks like the discussion on the
previous one wasn't resolved.

With the main issues to solve being:

 * It would be nice to use the existing root node name instead of adding
   a new property. But at the same time DT nodes are supposed to have
   generic names.

 * This only works for DT and not ACPI

To me it seems like adding the new property is just a "cheat" to get
around not being allowed to have a specific name for the root node. But
if we admit that we need a name I don't see the benefit of not putting
the name where the node is already named.

Using the root node name at this point would also undo the hard coded
per-cpu naming of the CTI and ETM devices, so maybe it would be nice,
but it's just too late. That means that a new field is necessary.
Although that field could be a boolean like "use-root-name-for-display"
or something like that. In the end it probably doesn't really make a
difference whether it's that or a name string.

And maybe the answer to the ACPI question is just that if anyone needs
it, they can add it in the future. It doesn't seem like it would
conflict with anything we do here.

> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../hwtracing/coresight/coresight-cti-core.c  | 20 ++++++++------
>  drivers/hwtracing/coresight/coresight-dummy.c | 10 ++++---
>  .../hwtracing/coresight/coresight-platform.c  | 27 +++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.c  | 10 ++++---
>  include/linux/coresight.h                     |  1 +
>  5 files changed, 53 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 3999d0a2cb60..60a1e76064a9 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -902,14 +902,18 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>  	/* default to powered - could change on PM notifications */
>  	drvdata->config.hw_powered = true;
>  
> -	/* set up device name - will depend if cpu bound or otherwise */
> -	if (drvdata->ctidev.cpu >= 0)
> -		cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
> -					       drvdata->ctidev.cpu);
> -	else
> -		cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);

Can we put the new name stuff inside coresight_alloc_device_name()? Then
it happens by default for every device.

I know Suzuki said previously to do it per-device, but the new DT
property is just "coresight-name", so it's generic. Rather than being
specific like "cti-name". So I don't see the benefit of duplicating the
code at this point if we do decide to do it.

> -	if (!cti_desc.name)
> -		return -ENOMEM;
> +	cti_desc.name = coresight_get_device_name(dev);
> +	if (!cti_desc.name) {
> +		/* set up device name - will depend if cpu bound or otherwise */
> +		if (drvdata->ctidev.cpu >= 0)
> +			cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
> +						       drvdata->ctidev.cpu);
> +		else {
> +			cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
> +			if (!cti_desc.name)
> +				return -ENOMEM;
> +		}
> +	}

>  
>  	/* setup CPU power management handling for CPU bound CTI devices. */
>  	ret = cti_pm_setup(drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
> index e4deafae7bc2..b19cd400df79 100644
> --- a/drivers/hwtracing/coresight/coresight-dummy.c
> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> @@ -76,10 +76,12 @@ static int dummy_probe(struct platform_device *pdev)
>  	struct coresight_desc desc = { 0 };
>  
>  	if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
> -
> -		desc.name = coresight_alloc_device_name(&source_devs, dev);
> -		if (!desc.name)
> -			return -ENOMEM;
> +		desc.name = coresight_get_device_name(dev);
> +		if (!desc.name) {
> +			desc.name = coresight_alloc_device_name(&source_devs, dev);
> +			if (!desc.name)
> +				return -ENOMEM;
> +		}
>  
>  		desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>  		desc.subtype.source_subtype =
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 9d550f5697fa..284aa22a06b7 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -183,6 +183,18 @@ static int of_coresight_get_cpu(struct device *dev)
>  	return cpu;
>  }
>  
> +static const char *of_coresight_get_device_name(struct device *dev)
> +{
> +	const char *name = NULL;
> +
> +	if (!dev->of_node)
> +		return NULL;
> +
> +	of_property_read_string(dev->of_node, "coresight-name", &name);

Do you need to update the binding docs with this new property?

Also a minor nit: Maybe "display-name" is better? "Coresight" is
implied, and the node is already named, although that node name isn't
used for display purposes, but this one is.

Thanks
James

