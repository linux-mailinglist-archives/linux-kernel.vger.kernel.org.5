Return-Path: <linux-kernel+bounces-153475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E58ACE88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF0D2818F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21B14F9FA;
	Mon, 22 Apr 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iu6p7yAg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6B5028B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793340; cv=none; b=ncs290V//nuAT8v11PWJfjM+tlb1Afi2wD9z10AutwC459yl99qi7kySh2awjOVO7+YN1mraOrOHfF6dPqIfVOmoKtrOca1RWMHQk6eYeguQcW7kAayJ9hV8R5kxwWRdjrc+hm3dyWZL925xBEdUgc/KQRpCelrrust7BJ12JP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793340; c=relaxed/simple;
	bh=2hQwBEpW01jp8qra2jvf/jNfR8J7cPQJApPJeAmp3hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZ0qfyDFhDiIt/RwO1EJLLt5LMJ18n+YyvXlGFts/G1sFpgrIZIixCHlCf/ioU65Qxq1hhu757uGxhh9I4P37y3B8nY3bgGrmVngDz/lIcW/FlxWpXiHFVUPI9BlSzucKM7Ik1vP5+skPELBSSBSxQHpQ7U/jTwNPUp4mUHq3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iu6p7yAg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713793338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DjWK16yEpG2qC4sEpfQe3ru9FwvfTS+uslLAL5h78t0=;
	b=iu6p7yAgrFB/VWsW31UQD5c1uukqz2RiNfI/FZZnhy3iyVFRdzzjxM5PAwvcfNgqcxxWZQ
	/v47qcFf9y6G54f5bsk++8Tifv28o9tvLuOEFDaCE4G1WS11A63OslUwCtLSkXQyFGXbD7
	jkC0iTj5IthxtmwZacHVgNPyTTMJeXw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-dCFO5pkAPeOsrMvUykCeQQ-1; Mon, 22 Apr 2024 09:42:15 -0400
X-MC-Unique: dCFO5pkAPeOsrMvUykCeQQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a572ceb5340so30754266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793334; x=1714398134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjWK16yEpG2qC4sEpfQe3ru9FwvfTS+uslLAL5h78t0=;
        b=Yx5UIgFWryf7of/sOS5ooKerGXV0YPDKOaGR72y+wJmPgYBHluBPIx8LeTs84XyeGi
         bY/h37/jqMNr7wi3sR6cJeFpB/y9xx98d83hmylQXsM7ew8JDNP0L7U7l2S0SJpx0NB+
         0ijG5oO/R4NKYHa9TxOD0V4yzvs0ZqwsGRWlvlWM24/qlURFaBtDhOLjzK+UEhH0qNTS
         dp/Rn1GSJ+cAtsm0PDl65O578BRdpb2n/+2EVTZB8p+CX2N7kdfXyx1m2zYWsu1v5RZz
         8hmXhlc8LYXv15eUc8b1557VadGCsUTxN6dXLhoWys0+5aJs+ahWYEKYzwMjP0KtZlxO
         cWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW787RfFiJ1u5qB30Z5rv6uxa9wcL4lHprtoCAGVjV/UbAR7uXSwdtewMT2aysYjAhyn6Q9x5LPdTU3nxg2pzt+ZAZn2KzaqoKIHug5
X-Gm-Message-State: AOJu0YwUNVFWH4xbWpbFr8AqZkqvOlkqBV4V53x4W5rpMtjTldPV8twY
	Hh4y0MxJIaes4E9HXpLEgkPyoX/tsGTXYF8XV7laGQJWd/VseKSX8EC8v7cEnf67L9uBOkrGsDn
	spGGb2pwGcXE0rM3BiQj9D3ybZylPV51npHrevoD8xMVshnUourbGs+kQt0fUbw==
X-Received: by 2002:a17:906:c79a:b0:a58:7192:8fbe with SMTP id cw26-20020a170906c79a00b00a5871928fbemr405956ejb.60.1713793334614;
        Mon, 22 Apr 2024 06:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA47jcvWTws5tkGi6B6q4Akc3azNwMQOwXlm+C/+DX0XcvHM7e0vNZiFufhWREV6jXq2+QzQ==
X-Received: by 2002:a17:906:c79a:b0:a58:7192:8fbe with SMTP id cw26-20020a170906c79a00b00a5871928fbemr405945ejb.60.1713793334372;
        Mon, 22 Apr 2024 06:42:14 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906058d00b00a522d34fee8sm5759717ejn.114.2024.04.22.06.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:42:13 -0700 (PDT)
Message-ID: <3db76d62-114a-4703-ac88-8e1f26791a36@redhat.com>
Date: Mon, 22 Apr 2024 15:42:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: samsung-laptop: Use sysfs_emit() to
 replace the old interface sprintf()
To: yunshui <jiangyunshui@kylinos.cn>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
References: <20240419064106.2396705-1-jiangyunshui@kylinos.cn>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240419064106.2396705-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/19/24 8:41 AM, yunshui wrote:
>     As Documentation/filesystems/sysfs.rst suggested,
>     show() should only use sysfs_emit() or sysfs_emit_at() when formatting
>     the value to be returned to user space.
> 
> Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
> Reviewed-by: Ai Chao <aichao@kylinos.cn>

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



> ---
>  drivers/platform/x86/samsung-laptop.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
> index b4aa8ba35d2d..3d2f8e758369 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -661,9 +661,9 @@ static ssize_t get_performance_level(struct device *dev,
>  	/* The logic is backwards, yeah, lots of fun... */
>  	for (i = 0; config->performance_levels[i].name; ++i) {
>  		if (sretval.data[0] == config->performance_levels[i].value)
> -			return sprintf(buf, "%s\n", config->performance_levels[i].name);
> +			return sysfs_emit(buf, "%s\n", config->performance_levels[i].name);
>  	}
> -	return sprintf(buf, "%s\n", "unknown");
> +	return sysfs_emit(buf, "%s\n", "unknown");
>  }
>  
>  static ssize_t set_performance_level(struct device *dev,
> @@ -744,7 +744,7 @@ static ssize_t get_battery_life_extender(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%d\n", ret);
> +	return sysfs_emit(buf, "%d\n", ret);
>  }
>  
>  static ssize_t set_battery_life_extender(struct device *dev,
> @@ -813,7 +813,7 @@ static ssize_t get_usb_charge(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%d\n", ret);
> +	return sysfs_emit(buf, "%d\n", ret);
>  }
>  
>  static ssize_t set_usb_charge(struct device *dev,
> @@ -878,7 +878,7 @@ static ssize_t get_lid_handling(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%d\n", ret);
> +	return sysfs_emit(buf, "%d\n", ret);
>  }
>  
>  static ssize_t set_lid_handling(struct device *dev,


