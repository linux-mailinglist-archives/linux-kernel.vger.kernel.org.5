Return-Path: <linux-kernel+bounces-81215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B3867223
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7503289F41
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDF01DFD1;
	Mon, 26 Feb 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd2PJ5E+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A54EB2C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944582; cv=none; b=GlGzxY/zkt/6rR40NI0QHe/TPQdAUjS4eBUpbBxnsSZ9byZaK1ZPTd/QBjrwJ7AK9DyHoaTFPcGiEnBZiWjnhJTljJtYNS4GHhSKp1xWp1voURdW0sZjhTBHzKKF1M959TG7EtlQAY7Tpt5+CrR1wG9ILlKRsXQ6cHsLx5l9Ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944582; c=relaxed/simple;
	bh=s5FZTsY04OR2sn6XFn4Jw5cp8uBwLriO7EA+PC8imxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd1nFLEZBFABX7Lc8DnpSUXhBUynq8aBnd9L+pRVHZmSX+7G1XD6RhFLE3KeMOKSalH5/c8U2MMHJadDLluYKdDYmF10SdG2NLeAvw1zbCXCxZMgQ0fo8xDrQI85LJMPVXNLT/b8PHdS8+rUydWef0qGB6VXVgVNE4cIfZ9jeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd2PJ5E+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708944579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tp2IsM3kS/CQBpKX2Ld+o0BiTLGfA2jr4ARdI9dgpI8=;
	b=Nd2PJ5E+Wdo0KbSmqi/zirpYOhXnifYIzu6Qsptw+Ska+vU9gAqyuinH9KTrji4FpQykiO
	adtCuo21yosDuzkjj9ff0yeLB2pFwqvkSNgoRCAiFT9+vWBDeWzvqW9o5D6FLTxXgVg0hT
	bttKnk9uEk7AvhVV0vT1QqGHgZafDZg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-e8Ds4u_RN36zx3gjVbB9XQ-1; Mon, 26 Feb 2024 05:49:37 -0500
X-MC-Unique: e8Ds4u_RN36zx3gjVbB9XQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2f71c83b7eso275139666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944576; x=1709549376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tp2IsM3kS/CQBpKX2Ld+o0BiTLGfA2jr4ARdI9dgpI8=;
        b=gpf7nKoG1UhTQB7bCIupRxQjFRSyY3SCFCiDwPzp9vN+4ObOTy1QTKmHX2aVmTVIDY
         wmXt+RFvVabKB2LczAJf9DLotrAQ+6uo0dUvQhg5ew37DM6hbfIIqAOnn8ySSA6YEsRR
         ceNddRKqdU+areYSriQYd6Kv31i0aLrBOtePXLYtvjpjNHrmaR2BPLrfyUP1plJuMrPE
         lM+GB1gDlPsaWYGXz+UtXEv1Sk6jpVSBF7vMc2/AOlYDxDG1zcpUDcjiNyJD3sGm22+/
         NiD9icrDtKqKNfhUp4H4Pdf59D5rFk9FWs7OrSozonjjn7duPGgWHBs73IjnWWoloeM/
         wxjw==
X-Forwarded-Encrypted: i=1; AJvYcCWduGk1JmIZU2i2pHpBJz1+4ooR0ZoBVnzLZwQc2cSgaqNZInGXR/YwbGOhKjfBH6QKKZz3e8RgJe3vnYPX72LSQriBP+29wp8kjyha
X-Gm-Message-State: AOJu0Yx9F5gfke6NjViBtTl0kPLlDcFudRdy5pe3adsviseXlYcDyAB2
	uAx2byG1Z/zsX5/OuLR/FSpfgqeZjdYNcpV0xqT3Iz3he1N4gpMkl6Hf0RKX0LhXIJKmlWSkpN/
	DozYLgj8Ze7lSQaUl2tl8HE4YMHZ16dO2I4DXbRacSoZP8RiCxVMS+6migpSQxg==
X-Received: by 2002:a17:906:b7d3:b0:a3d:993e:ad24 with SMTP id fy19-20020a170906b7d300b00a3d993ead24mr3820664ejb.59.1708944576819;
        Mon, 26 Feb 2024 02:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+FHnqYXRywJjuKWIUXKnjByNIBL0LdeL0VrfUgVCQQPSjHmo45/hmmD4XRHZnCoq4l/N8lA==
X-Received: by 2002:a17:906:b7d3:b0:a3d:993e:ad24 with SMTP id fy19-20020a170906b7d300b00a3d993ead24mr3820656ejb.59.1708944576630;
        Mon, 26 Feb 2024 02:49:36 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id rf14-20020a1709076a0e00b00a4339b8b1bbsm1143238ejc.212.2024.02.26.02.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 02:49:35 -0800 (PST)
Message-ID: <5badfbc2-fbb0-4aea-a75e-3b50aabdc94d@redhat.com>
Date: Mon, 26 Feb 2024 11:49:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/mellanox: mlxbf-pmc: mlxbf_pmc_event_list():
 make size ptr optional
Content-Language: en-US
To: Luiz Capitulino <luizcap@redhat.com>, ilpo.jarvinen@linux.intel.com,
 shravankr@nvidia.com
Cc: davthompson@nvidia.com, ndalvi@redhat.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <cover.1708635408.git.luizcap@redhat.com>
 <182de8ec6b9c33152f2ba6b248c35b0311abf5e4.1708635408.git.luizcap@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <182de8ec6b9c33152f2ba6b248c35b0311abf5e4.1708635408.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/22/24 21:57, Luiz Capitulino wrote:
> The mlxbf_pmc_event_list() function returns a pointer to an array of
> supported events and the array size. The array size is returned via
> a pointer passed as an argument, which is mandatory.
> 
> However, we want to be able to use mlxbf_pmc_event_list() just to check
> if a block name is implemented/supported. For this usage passing the size
> argument is not necessary so let's make it optional.
> 
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 40 +++++++++++++++------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 250405bb59a7..b71636eb3db1 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -966,32 +966,33 @@ static bool mlxbf_pmc_valid_range(unsigned int blk_num, u32 offset)
>  }
>  
>  /* Get the event list corresponding to a certain block */
> -static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size_t *size)
> +static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size_t *psize)
>  {
>  	const struct mlxbf_pmc_events *events;
> +	size_t size;
>  
>  	if (strstr(blk, "tilenet")) {
>  		events = mlxbf_pmc_hnfnet_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_hnfnet_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_hnfnet_events);
>  	} else if (strstr(blk, "tile")) {
>  		events = mlxbf_pmc_hnf_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_hnf_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_hnf_events);
>  	} else if (strstr(blk, "triogen")) {
>  		events = mlxbf_pmc_smgen_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
>  	} else if (strstr(blk, "trio")) {
>  		switch (pmc->event_set) {
>  		case MLXBF_PMC_EVENT_SET_BF1:
>  			events = mlxbf_pmc_trio_events_1;
> -			*size = ARRAY_SIZE(mlxbf_pmc_trio_events_1);
> +			size = ARRAY_SIZE(mlxbf_pmc_trio_events_1);
>  			break;
>  		case MLXBF_PMC_EVENT_SET_BF2:
>  			events = mlxbf_pmc_trio_events_2;
> -			*size = ARRAY_SIZE(mlxbf_pmc_trio_events_2);
> +			size = ARRAY_SIZE(mlxbf_pmc_trio_events_2);
>  			break;
>  		default:
>  			events = NULL;
> -			*size = 0;
> +			size = 0;
>  			break;
>  		}
>  	} else if (strstr(blk, "mss")) {
> @@ -999,43 +1000,46 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size
>  		case MLXBF_PMC_EVENT_SET_BF1:
>  		case MLXBF_PMC_EVENT_SET_BF2:
>  			events = mlxbf_pmc_mss_events_1;
> -			*size = ARRAY_SIZE(mlxbf_pmc_mss_events_1);
> +			size = ARRAY_SIZE(mlxbf_pmc_mss_events_1);
>  			break;
>  		case MLXBF_PMC_EVENT_SET_BF3:
>  			events = mlxbf_pmc_mss_events_3;
> -			*size = ARRAY_SIZE(mlxbf_pmc_mss_events_3);
> +			size = ARRAY_SIZE(mlxbf_pmc_mss_events_3);
>  			break;
>  		default:
>  			events = NULL;
> -			*size = 0;
> +			size = 0;
>  			break;
>  		}
>  	} else if (strstr(blk, "ecc")) {
>  		events = mlxbf_pmc_ecc_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_ecc_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_ecc_events);
>  	} else if (strstr(blk, "pcie")) {
>  		events = mlxbf_pmc_pcie_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_pcie_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_pcie_events);
>  	} else if (strstr(blk, "l3cache")) {
>  		events = mlxbf_pmc_l3c_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_l3c_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_l3c_events);
>  	} else if (strstr(blk, "gic")) {
>  		events = mlxbf_pmc_smgen_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
>  	} else if (strstr(blk, "smmu")) {
>  		events = mlxbf_pmc_smgen_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
>  	} else if (strstr(blk, "llt_miss")) {
>  		events = mlxbf_pmc_llt_miss_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_llt_miss_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_llt_miss_events);
>  	} else if (strstr(blk, "llt")) {
>  		events = mlxbf_pmc_llt_events;
> -		*size = ARRAY_SIZE(mlxbf_pmc_llt_events);
> +		size = ARRAY_SIZE(mlxbf_pmc_llt_events);
>  	} else {
>  		events = NULL;
> -		*size = 0;
> +		size = 0;
>  	}
>  
> +	if (psize)
> +		*psize = size;
> +
>  	return events;
>  }
>  


