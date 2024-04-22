Return-Path: <linux-kernel+bounces-153440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC848ACE1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B303D2821A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70A14F9C9;
	Mon, 22 Apr 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNoaoEnx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2C14F13E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792361; cv=none; b=cMjjWiQFUNIETx5PaRouUlrVrSpxHrZ3QrTRRtI+9xXHeLGDQMEqMgzpecA7uCmZVYsoKfu0x98NLvQXUBIcW0pG8zKXZqBE/IPeNd+ghRq5PygebsJ4lCfr2h+kiF3tiU/kL5S8RhONEqTjr1lDH8b8KcNYJtixXOIvWGBo2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792361; c=relaxed/simple;
	bh=zzX5eE4yMUDKe0LvVLzQNY6kTp+yzD1J3zOF3ag/LAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9sFUypHTUUXsSQMbGtzN5CHofcHXaTDYqWcgn8Mly1PwJJ2J3Omch52000//YtmZAVrStzSkhcfAyYKalQEk181daGmGiC5u8s2VvvzjtYW0wscbNo85WnakYHv4RrmoemhWH1lUqyuG94ZbiIlNeHuPHmwJBuaY//zDeb/9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNoaoEnx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713792358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol/2RA90vNCMdV3wT9xM2JZGkm3yoQFPbLwEAxBwTSc=;
	b=VNoaoEnx9qbqhibtIcM0olCNHTab4P2dSzHw0BAxGFPKf7Q9+SKgmASjXBPYp62TO7NRsE
	nhmOiF45ftHLqhh3S+I0oWYZCt6N67BGXw33t9OZ4ygCLc1cPwOvBWleAzlMKpyhbYlh1Q
	KHvFZFFVISEXk8+HUB+BMQVkJIawz0g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-5sbK6jJQO4iBrL8heBax5g-1; Mon, 22 Apr 2024 09:25:56 -0400
X-MC-Unique: 5sbK6jJQO4iBrL8heBax5g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a52233a228aso261747466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792355; x=1714397155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol/2RA90vNCMdV3wT9xM2JZGkm3yoQFPbLwEAxBwTSc=;
        b=LAR/dhTsIGy47h5wQ0uWrQ4r5Z+nFGcvbqR6rskJYhwboWQmkVUMevhYxHHNsVkw3W
         VOkXBXrZBcIRh+0f0fUbUUIgN6xusDn7coP4F0jGTic1x0yLwa9sxCX2IsW0vIetFEkN
         okAOifyflutSogQmxC8FxbSxuag8alEVdYctS9oeocrvIS6EVKf6nr5EzBB6o1FYKn1h
         j0jvz3Os+8qlfFXMsJ/7L5NCsalb3c5tvP4E9Q9Tmwqs2XKgtjlHoCNIIigk7rGCuBk3
         6uqj75PQuJSCylqkR4x7tBXmXcbIDU1FZ4Vlr4oZdkc8DoX/voovXJnMYq+NpiO/thEa
         UhOA==
X-Forwarded-Encrypted: i=1; AJvYcCXctVXMbCxLze1WC5xI7ores08BU94c4n/dh5/3dcZgIqR6ODgJQrqS3XcSVb9Y/+Arb20HzpMpHs0M24XWlOiKcu00kuY3tFcnWS2u
X-Gm-Message-State: AOJu0YwvxpEppc517ll0vGxvdIIUZ3dStNJmfYueUL+9zPBJOMlI3d50
	Jo/44nEy4aJzayaHKT5Y77SP3IfGVpGSPXJT8W8SNAy/8cs7pwoQE3Cy4lZJwQnq6B4KPIcL8en
	f2SXnUf8L1oA+yO127bVFpfnrsHKx2tVpykuMwhLdQ4950J+85WfPcB4edCoZ6A==
X-Received: by 2002:a17:906:fe0b:b0:a55:ab92:8baa with SMTP id wy11-20020a170906fe0b00b00a55ab928baamr4660378ejb.9.1713792355114;
        Mon, 22 Apr 2024 06:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFizyCClaD48IQHzVKa86p3t7HomFbWXivDIP/CjLWOxs68n/orswhkEk93S6EN8g/eJimpuQ==
X-Received: by 2002:a17:906:fe0b:b0:a55:ab92:8baa with SMTP id wy11-20020a170906fe0b00b00a55ab928baamr4660363ejb.9.1713792354738;
        Mon, 22 Apr 2024 06:25:54 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id x20-20020a1709060a5400b00a524b2ffed6sm5761118ejf.56.2024.04.22.06.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:25:54 -0700 (PDT)
Message-ID: <12ef6031-35e1-4d48-9771-8c431f7abe33@redhat.com>
Date: Mon, 22 Apr 2024 15:25:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Don't present root domain
 on error
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240415215210.2824868-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240415215210.2824868-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/15/24 11:52 PM, Srinivas Pandruvada wrote:
> If none of the clusters are added because of some error, fail to load
> driver without presenting root domain. In this case root domain will
> present invalid data.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Fixes: 01c10f88c9b7 ("platform/x86/intel-uncore-freq: tpmi: Provide cluster level control")
> Cc: <stable@vger.kernel.org> # 6.5+
> ---
> This error can be reproduced in the pre production hardware only.
> So can go through regular cycle and they apply to stable.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> 
>  .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c     | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> index bd75d61ff8a6..587437211d72 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> @@ -240,6 +240,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
>  	bool read_blocked = 0, write_blocked = 0;
>  	struct intel_tpmi_plat_info *plat_info;
>  	struct tpmi_uncore_struct *tpmi_uncore;
> +	bool uncore_sysfs_added = false;
>  	int ret, i, pkg = 0;
>  	int num_resources;
>  
> @@ -384,9 +385,15 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
>  			}
>  			/* Point to next cluster offset */
>  			cluster_offset >>= UNCORE_MAX_CLUSTER_PER_DOMAIN;
> +			uncore_sysfs_added = true;
>  		}
>  	}
>  
> +	if (!uncore_sysfs_added) {
> +		ret = -ENODEV;
> +		goto remove_clusters;
> +	}
> +
>  	auxiliary_set_drvdata(auxdev, tpmi_uncore);
>  
>  	tpmi_uncore->root_cluster.root_domain = true;


