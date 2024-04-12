Return-Path: <linux-kernel+bounces-142466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B601E8A2BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71890289777
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4BE535B8;
	Fri, 12 Apr 2024 10:05:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC25430673;
	Fri, 12 Apr 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916339; cv=none; b=DdKD8KJQbI76dCNyoG3fbh33ie3XV+1C/yIEEW/PMrQWqpCKlRiqrihpSuVg85yAGLsuFHVlmwIFG5iD+sSkmxwPqqqYrwNHXx5twGYc2MvwX36DJrRP+Ny5kUuVC8vG13uW43d4rJ+RBQwCYJgCLHFmY8pZQxA8dit4HJj3eLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916339; c=relaxed/simple;
	bh=EkjLXSEsa7m9cJl/GBEGrhoAnqPXfgfS8vyCa9AUeis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUYNNNovtxHbBsVvz4VBGFUer7q6WCARy/FfC/lqOg/fERMMohNmOEgJKFP6H4sBBfccmnnYjGRBhKzqxvf9PtwHhf53ufGRvzVXpbvtis8Mu2YcsKHI1MfstNl9Rq3eCGl4qPf5P46NHJQinXUb768YEQMfeTOA4Mxt/d0ufvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FEAD339;
	Fri, 12 Apr 2024 03:06:03 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ED0B3F64C;
	Fri, 12 Apr 2024 03:05:32 -0700 (PDT)
Message-ID: <d707430f-00ee-4427-a9e4-6e42bc5b6aa9@arm.com>
Date: Fri, 12 Apr 2024 11:05:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] coresight: tmc: Add support for reading crash data
To: Linu Cherian <lcherian@marvell.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>,
 mike.leach@linaro.org, leo.yan@linaro.org
References: <20240307033625.325058-1-lcherian@marvell.com>
 <20240307033625.325058-6-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240307033625.325058-6-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/03/2024 03:36, Linu Cherian wrote:
> * Introduce a new mode CS_MODE_READ_CRASHDATA for reading trace
>   captured in previous crash/watchdog reset.
> 
> * Add special device files for reading ETR/ETF crash data.
> 
> * User can read the crash data as below
> 
>   For example, for reading crash data from tmc_etf sink
> 
>   #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
> 
> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v6:
> * Removed read_prevboot flag in sysfs
> * Added special device files for reading crashdata 
> * Renamed CS mode READ_PREVBOOT to READ_CRASHDATA 
> * Setting the READ_CRASHDATA mode is done as part of file open.
> 

[...]

> @@ -619,6 +740,19 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  		coresight_unregister(drvdata->csdev);
>  	else
>  		pm_runtime_put(&adev->dev);
> +
> +	if (!is_tmc_reserved_region_valid(dev))
> +		goto out;
> +
> +	drvdata->crashdev.name =
> +		devm_kasprintf(dev, GFP_KERNEL, "%s_%s", "crash", desc.name);
> +	drvdata->crashdev.minor = MISC_DYNAMIC_MINOR;
> +	drvdata->crashdev.fops = &tmc_crashdata_fops;
> +	ret = misc_register(&drvdata->crashdev);
> +	if (ret)
> +		pr_err("%s: Failed to setup dev interface for crashdata\n",
> +		       desc.name);
> +

Is this all optional after the is_tmc_reserved_region_valid()? Skipping
to out seems to be more like an error condition, but in this case it's
not? Having it like this makes it more difficult to add extra steps to
the probe function. You could move it to a function and flip the
condition which would be clearer:

   if (is_tmc_reserved_region_valid(dev))
      register_crash_dev_interface(drvdata);


>  out:
>  	return ret;
>  }

[...]

>  
> +static int tmc_etr_setup_crashdata_buf(struct tmc_drvdata *drvdata)
> +{
> +	int rc = 0;
> +	u64 trace_addr;
> +	struct etr_buf *etr_buf;
> +	struct etr_flat_buf *resrv_buf;
> +	struct tmc_crash_metadata *mdata;
> +	struct device *dev = &drvdata->csdev->dev;
> +
> +	mdata = drvdata->crash_mdata.vaddr;
> +
> +	etr_buf = kzalloc(sizeof(*etr_buf), GFP_ATOMIC);
> +	if (!etr_buf) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	etr_buf->size = drvdata->crash_tbuf.size;
> +
> +	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_ATOMIC);
> +	if (!resrv_buf) {
> +		rc = -ENOMEM;
> +		goto rmem_err;
> +	}
> +
> +	/*
> +	 * Buffer address given by metadata for retrieval of trace data
> +	 * from previous boot is expected to be same as the reserved
> +	 * trace buffer memory region provided through DTS
> +	 */
> +	if (is_tmc_reserved_region_valid(dev->parent)
> +	    && (drvdata->crash_tbuf.paddr == mdata->trc_paddr))
> +		resrv_buf->vaddr = drvdata->crash_tbuf.vaddr;
> +	else {
> +		dev_dbg(dev, "Trace buffer address of previous boot invalid\n");
> +		rc = -EINVAL;
> +		goto map_err;
> +	}
> +
> +	resrv_buf->size = etr_buf->size;
> +	resrv_buf->dev = &drvdata->csdev->dev;
> +	etr_buf->hwaddr = trace_addr;

trace_addr is uninitialised at this point. If you pull the latest
coresight branch we enabled some extra compiler warnings which catch this.

I assume it's supposed to be mdata->trc_paddr?

Is there some kind of test that could be added that could have caught
this? Maybe skip the full reboot flow but just enable the feature and
see if we can read from the buffer.

Or even just toggling the mode on and off via sysfs. We're running the
Perf and kselftests on Juno internally so I can add a reserved region to
the Juno DT and make sure this stays working.



