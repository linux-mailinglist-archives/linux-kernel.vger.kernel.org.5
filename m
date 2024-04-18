Return-Path: <linux-kernel+bounces-149741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD18A9545
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6537E1F23D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C815886C;
	Thu, 18 Apr 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eI4TiPsb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA66156F54
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429990; cv=none; b=cyCivKBWKTODaP7Suo5BHc0hjToC3Z29n4X8y+nPmFoXB5qzMex2rKvQSUqTiB8i/MTQJoP117gcmi19rxMnPV0YpvfksZNX42fBSH8qKHLwnt5KVDAFPiv5zz4X/GpytHmwahJZFiz9WRn0RvvCoyWZnd1xYutQWxSqcmRbnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429990; c=relaxed/simple;
	bh=liaanHInhCVHl6LFCXyaUL53XzFp8tFHkc9T7d/cwqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiqaITICbv7dzdEjaOpme22qapiH/X2vBnw8yMV2mlJFUyctQPcCbtkyqNzqpfQpGW3Enb+DzlW87/xrYZHtJGKxaEFyLeS74ZBL9dTsJDVifoP+qwoqm5ybn1ZzX1TLBMyv/7GR5sJSUlhyRQpyd0/a+NSq+wKyD5NMSJTbAr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eI4TiPsb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713429987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNj3joo+Yw9FT0MEQmqvCroatRCFxnhMX9kyaDL4c3c=;
	b=eI4TiPsbpL4k6Z5Ygc8XtDDRhBcJedgbl21+RwBJtnqiFHqjZrmy+xbCkwIy9YJQ+r7Z21
	NydO4LmD23YNgrwurVC0ODENi/jT0ZoE7TX71qOMQ+pLm7ky78B7CiUtlhIEzBWn85GToa
	wrJ9olwCvsE46c8BaPUsyL43/OUJjPA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-FwZK0I4mMImSbHvF_Br4mg-1; Thu, 18 Apr 2024 04:46:26 -0400
X-MC-Unique: FwZK0I4mMImSbHvF_Br4mg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d9ebfd9170so5734871fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429984; x=1714034784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNj3joo+Yw9FT0MEQmqvCroatRCFxnhMX9kyaDL4c3c=;
        b=Nf91BShfnOPYkctfnMXbfrj9COSfY24SK6IafB8/7J6fchTxVWQv2AKUoxK6YKEsd9
         WjXYbE1y1J69vaHbR8L56Ap2+/mFc8eYlDUtzBd5rFVq+xa2IlrsBKLx1Wjuz58cuN83
         zAaS7ZRKNlHyfBP1ETzOCtTb4j9b1Q/yReG7mPP5mb17bddb69TAamo50syVyg0pCIzh
         o1ucL/YTD/cB9AJDnKM6ius7DPYYGAYGTLVwiuj13A//2Vf9gnlFz5k7lSLzN7M0OFNA
         QqJ4OvFSV4W6PxHSmB2gfacgQuNfgPgJ9rLR+6buj5td5uk/tc/K2P/AQK9w0Z9HBD4+
         kwZg==
X-Forwarded-Encrypted: i=1; AJvYcCVftCaoZGc7tXOiL4e6F7NeD7AAe1bk+b0pYAULe398+LdOppztWqpfqvHRpLO2G5hS07s9O+eVLqfbB6aeo0qIrhTHchTCEoE7RvZC
X-Gm-Message-State: AOJu0Yyu/Y0H1hjZFi2Paliq2MyxKzOZTAkXvzSg0llL5VQJkkkEp0Mz
	f8VZZwRzwfp+3H8kKmrxDhEi1Xpn6WPXGP3JHFBXGRom0Kvjf8LN/QC1HfT/DoIGclVzCu4rpoh
	C70P60hNb8MpMD0wOrA3rFKWp7vf8hm3ij5rRHUhoLbBCVo33ciTHChDzvs0grO6JM8aE0w==
X-Received: by 2002:a2e:a784:0:b0:2d4:6a34:97bf with SMTP id c4-20020a2ea784000000b002d46a3497bfmr1474219ljf.49.1713429984589;
        Thu, 18 Apr 2024 01:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Q3nlDo1Y5obOYlTRSJejji2XuPvgeect2eoeDKPrcfW8fAPyfx7tp7Pvm9JeCr8oWfW3Eg==
X-Received: by 2002:a2e:a784:0:b0:2d4:6a34:97bf with SMTP id c4-20020a2ea784000000b002d46a3497bfmr1474199ljf.49.1713429984230;
        Thu, 18 Apr 2024 01:46:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709066bc700b00a5556cd0fd5sm589910ejs.183.2024.04.18.01.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:46:23 -0700 (PDT)
Message-ID: <5f8fac08-5368-443c-853e-6587b635e39b@redhat.com>
Date: Thu, 18 Apr 2024 10:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: samsung-laptop: Use sysfs_emit() to replace
 the old interface sprintf()
To: yunshui <jiangyunshui@kylinos.cn>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, ilpo.jarvinen@linux.intel.com,
 Ai Chao <aichao@kylinos.cn>
References: <20240418070550.628310-1-jiangyunshui@kylinos.cn>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240418070550.628310-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>


On 4/18/24 9:05 AM, yunshui wrote:
>     As Documentation/filesystems/sysfs.rst suggested,
>     show() should only use sysfs_emit() or sysfs_emit_at() when formatting
>     the value to be returned to user space.
> 
> Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

But this double Signed-off-by is weird, looking at the From:
you (yunshui) are the author so your Signed-off-by is expected.

But Ai Chao's Signed-off-by here is weird, I would only
expect that if Ai Chao would be submitting the patch on
your behalf (for whatever reason).  Signed-off-by indicates
that you're either the author or the patch passed through
your hands. So I'll add my S-o-b for example when applying
this to my review-hans branch.

I guess you may want:

Reviewed-by: Ai Chao <aichao@kylinos.cn>

here and in the other similar sysfs_emit() patches ?

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


