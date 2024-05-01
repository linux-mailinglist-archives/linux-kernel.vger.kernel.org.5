Return-Path: <linux-kernel+bounces-165123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA38B885B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A110F1C2341D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EED5339D;
	Wed,  1 May 2024 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGsqqR6P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D652F6A
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557904; cv=none; b=i4GHl/adpJFnMkxnKpA20F286pVcG7t1g8QeD4fbL6G65fH+WPTGyltxJD5yxGDVzOaf/Lku35Lt4fyRP5ukO+Ptl0jvbMtBbiD8VBxlTdfRSaRTjEN4R17iQo7JGkxfsogGd2dZ/wsygLFWJKjYjzukp/McCvmPnj380V4kODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557904; c=relaxed/simple;
	bh=zRIOVwIbuRT/C61qM9NViozdpwS2MV3uEzoWw2VcWUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+e1E4UR1XJGA5QBZWOk4qTfzxQsvsJFd+4w6nKr4MAmYiFhCvnvXvX4y6VWgmRksCivYz8MxkviNZJV/NEu7xyfX+w8m84zvdAfpkSgU728ZZ+20AbEFIvaaa6Q9MseYvYg8E+bH9U758OFDr3feVGA3fy3CshrvZqP3XO7yv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGsqqR6P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714557901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nco7um67jte34vjyYL03elkp+CiCw7RycyAoOwG9/n4=;
	b=hGsqqR6PfZ/tS6+NxXtte1yCsptAw2uNF9uAg2EQar46200H1GGpTdvJ3EWWmTIw+e1iP1
	YGKyacNcth8BNA3YTZo9P52zDgeIAoGnh6mlaXw1MEHqDJAsmnylPMRVapS33i2zvlCWYc
	Q6xpNpmGoYNxbhIEa2gShC/Rom+CqOs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-KXi7dS9CPoeh-1IfwjoqxA-1; Wed, 01 May 2024 06:04:58 -0400
X-MC-Unique: KXi7dS9CPoeh-1IfwjoqxA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d8a7bb09afso54226111fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714557897; x=1715162697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nco7um67jte34vjyYL03elkp+CiCw7RycyAoOwG9/n4=;
        b=Qd5qtivkNasmLf7400Oi1qDkz3GsMz+8bplQPn9Dj26msQaaPrbvAZWMToFDImwrxk
         DD7KJ/Zf6Rb+q+azogSXENdhAGu0DDlnBSOemijXalNqh7Fv7HL1GHK5Vi5U3PcXNG/s
         Csdw9jART8BzsExLqstAv+FFxrbBDVeuvpZJKuo7fUyliJ+NSM3KDQ5/8XtUrSGwBMHw
         8L38+gVseprzHuplgZMZDYVXi9x8AgdJbNEV4noZyPyljStcvOFFGepR1cBFFd9SxYq5
         fl0zdORNYLwAItrx8mTcHratCf6aRaMwystfd3u5hSW5Sa3ilMobI3W2tv1K5A5XWVU2
         OGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk3mw8yJMPHVbCOVwvuWINvnsleK1Jpua9KpPohd+1mlmqWRpKEAyxpnaoqp/58b+QFNjc6KWhe3992bZ4MXvRzCcg1FINwTwbEydT
X-Gm-Message-State: AOJu0YzQihetsjPOicykUT9aFgfv8K5F+S4cWNh/W1nh0wIX80i34Ujd
	bX3rfJ44qMyWPTtefp9ZLIF9jCR/IZ+RLAH6ItmMTqQXXoYQxd76Z+RbjFYDL24HTNLeh2LHXGV
	/eCMGkWZiAvhYa3yJIRegjMROTifEF4O87cXb/DbPMDO7ZowlcBcFa27CXdk5mg==
X-Received: by 2002:a05:6512:478:b0:51e:25d2:453f with SMTP id x24-20020a056512047800b0051e25d2453fmr1062763lfd.68.1714557896869;
        Wed, 01 May 2024 03:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDzNjgasG6pTmAis+w8S8UbF/yOq/g9I/RXtOuc1slfRwaMySZoMjc7NM5pkOViqTv3n6VqQ==
X-Received: by 2002:a05:6512:478:b0:51e:25d2:453f with SMTP id x24-20020a056512047800b0051e25d2453fmr1062749lfd.68.1714557896403;
        Wed, 01 May 2024 03:04:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402164300b00562d908daf4sm15176493edx.84.2024.05.01.03.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:04:55 -0700 (PDT)
Message-ID: <7940339d-e9a9-4367-9fce-1e5a201e7ab7@redhat.com>
Date: Wed, 1 May 2024 12:04:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: ISST: Support SST-BF and SST-TF per level
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>
References: <20240430221052.15825-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240430221052.15825-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/1/24 12:10 AM, Srinivas Pandruvada wrote:
> SST SST-BF and SST-TF can be enabled/disabled per SST-PP level. So return
> a mask of all levels, where the feature is supported, instead of just for
> level 0.
> 
> Since the return value returns all levels mask, not just level 0, update
> API version.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  .../intel/speed_select_if/isst_tpmi_core.c    | 38 +++++++++++++++----
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 6bcbb97b0101..7bac7841ff0a 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -847,6 +847,8 @@ static int isst_if_get_perf_level(void __user *argp)
>  {
>  	struct isst_perf_level_info perf_level;
>  	struct tpmi_per_power_domain_info *power_domain_info;
> +	unsigned long level_mask;
> +	u8 level, support;
>  
>  	if (copy_from_user(&perf_level, argp, sizeof(perf_level)))
>  		return -EFAULT;
> @@ -866,12 +868,34 @@ static int isst_if_get_perf_level(void __user *argp)
>  		      SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH, SST_MUL_FACTOR_NONE)
>  	perf_level.enabled = !!(power_domain_info->sst_header.cap_mask & BIT(1));
>  
> -	_read_bf_level_info("bf_support", perf_level.sst_bf_support, 0, 0,
> -			    SST_BF_FEATURE_SUPPORTED_START, SST_BF_FEATURE_SUPPORTED_WIDTH,
> -			    SST_MUL_FACTOR_NONE);
> -	_read_tf_level_info("tf_support", perf_level.sst_tf_support, 0, 0,
> -			    SST_TF_FEATURE_SUPPORTED_START, SST_TF_FEATURE_SUPPORTED_WIDTH,
> -			    SST_MUL_FACTOR_NONE);
> +	level_mask = perf_level.level_mask;
> +	perf_level.sst_bf_support = 0;
> +	for_each_set_bit(level, &level_mask, BITS_PER_BYTE) {
> +		/*
> +		 * Read BF support for a level. Read output is updated
> +		 * to "support" variable by the below macro.
> +		 */
> +		_read_bf_level_info("bf_support", support, level, 0, SST_BF_FEATURE_SUPPORTED_START,
> +				    SST_BF_FEATURE_SUPPORTED_WIDTH, SST_MUL_FACTOR_NONE);
> +
> +		/* If supported set the bit for the level */
> +		if (support)
> +			perf_level.sst_bf_support |= BIT(level);
> +	}
> +
> +	perf_level.sst_tf_support = 0;
> +	for_each_set_bit(level, &level_mask, BITS_PER_BYTE) {
> +		/*
> +		 * Read TF support for a level. Read output is updated
> +		 * to "support" variable by the below macro.
> +		 */
> +		_read_tf_level_info("tf_support", support, level, 0, SST_TF_FEATURE_SUPPORTED_START,
> +				    SST_TF_FEATURE_SUPPORTED_WIDTH, SST_MUL_FACTOR_NONE);
> +
> +		/* If supported set the bit for the level */
> +		if (support)
> +			perf_level.sst_tf_support |= BIT(level);
> +	}
>  
>  	if (copy_to_user(argp, &perf_level, sizeof(perf_level)))
>  		return -EFAULT;
> @@ -1648,7 +1672,7 @@ void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
>  }
>  EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_resume, INTEL_TPMI_SST);
>  
> -#define ISST_TPMI_API_VERSION	0x02
> +#define ISST_TPMI_API_VERSION	0x03
>  
>  int tpmi_sst_init(void)
>  {


