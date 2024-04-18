Return-Path: <linux-kernel+bounces-149742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A1E8A9548
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA171F21028
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8515886C;
	Thu, 18 Apr 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd/ZJtJ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22BA39FDD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430028; cv=none; b=ffFV9bsdwbMcv1vrVnQQn+J+LsNpMe+sdap1ih6A210Hy821Cw2vWIyNMnjn4Va2/yNIL33jZ4gQkzq8P7j9tNKSa6LrDYNC5twEKISCwtq4poK1WKrFPw7nNggugVkdFhWA45SJVofO0yrK7TiWgxpoIML4kAuyngV3b/rqaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430028; c=relaxed/simple;
	bh=hZhXW9wg4wjoavT+9EfcCTWpvN/SZJQnteH7FnhHDXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3iEVpnPUG6RX1ca3xra1UJrYkYZzThWomIDoB/+lttwjm8UHXtq6BX7LbsH2uI09L6yPKmlGZBIvd5VEY91VrnDD7WJgCA051zmkXcQ2dkNeDuM+qYu25jnkKvXxGnXaAhLeDQH5LWC1Sjc4SfjtPWyiNJ9VjNzAGlzruhuDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gd/ZJtJ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713430024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypu/IzdSRACz4KGvkLD7l6pluK2joJIPj93eOoJKFJU=;
	b=Gd/ZJtJ6nQ6wAGsux7zoAVMNqQavIgpAMSTLsoIarQOs+Ozib7vb85WdMc+jjYC0IiRb9f
	2oVO0c+YuazINKkO+VIP4ucIabpiRPocRZWJ2oRPRLTKuKKo3Jl97Hk3NXYINc8RzE6d5B
	f49svQuBLVMhDovuvKCTNdls4HJxhPY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-NAJydeRwNP2e0EdgHJX2qw-1; Thu, 18 Apr 2024 04:47:03 -0400
X-MC-Unique: NAJydeRwNP2e0EdgHJX2qw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516ddd6d66fso467498e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430021; x=1714034821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypu/IzdSRACz4KGvkLD7l6pluK2joJIPj93eOoJKFJU=;
        b=K1eHGp4uh9JWLGrqYB/mI43QmS0GDRGHIDEVPbaCFNvSBiVQmoZVqzx1ZolXFgzFsB
         JTN835mRxdpGWPXql43oXXMKeNRPbDH+9A/NFYxUtJNcJ8e6wv7HpopJU9Q/M+4bqEzq
         V3BAzNYQZuFJ8JZ6rK1r1QAkQAtJqq28wJGbhlc6cKjzxzygKw2K8ok6WwCre+wZlvKO
         xp6kFUD9gBcNpcvRlRkg7AaBdgj/9ydMBQfmMbiF1T3xcdi1ryugrBgbzQCM2UUijB38
         XQyjt5eq6L48MknKhaRhFgVA9+0nN9ALic/TCgr2c5Cma3ioThmANSd0cD2NsxT/FF1o
         TREg==
X-Forwarded-Encrypted: i=1; AJvYcCXwMwsJryPprVFmSHE0qm49fGKgm9amfw71PdC7c1NZpDi5hYFI4OiELhkMZ8taUg37TRMCaGMLi1yozsu3WzZTKGYNbOWcqYAKPwGu
X-Gm-Message-State: AOJu0YxXXldWq/oPMU9b7QsWUqzd5eI7JYtpVspFAGQcv1RRelY3BcqM
	iuVxiHgOxUH42LQaOjcagJJv5Z3NBv7QWSOFYEUuOtLvWvtasRp+hEX6GC5CCSDWCEQWVGVY8XK
	ouzjGV5V7SKGEU5YcfI1fi9HhPcTYdtoB5M38Dgvj+CPDTJRkc8n0XEyluss4Ww==
X-Received: by 2002:ac2:514a:0:b0:518:dfae:2691 with SMTP id q10-20020ac2514a000000b00518dfae2691mr934548lfd.11.1713430021714;
        Thu, 18 Apr 2024 01:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmRh2T6pvnSqHalT0e9jZSTumH+2b2s1Adv+nj5rhoXDlqkM4PEjAaGAuY6sV4enTEM5Eukw==
X-Received: by 2002:ac2:514a:0:b0:518:dfae:2691 with SMTP id q10-20020ac2514a000000b00518dfae2691mr934538lfd.11.1713430021471;
        Thu, 18 Apr 2024 01:47:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k4-20020a50cb84000000b005705bb48307sm600965edi.42.2024.04.18.01.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:47:01 -0700 (PDT)
Message-ID: <9d4800ed-ac7d-406e-ad66-7b5bcd136c30@redhat.com>
Date: Thu, 18 Apr 2024 10:47:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: msi-laptop: Use sysfs_emit() to replace
 sprintf()
To: yunshui <jiangyunshui@kylinos.cn>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: jlee@suse.com, ilpo.jarvinen@linux.intel.com, Ai Chao <aichao@kylinos.cn>
References: <20240418072257.631977-1-jiangyunshui@kylinos.cn>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240418072257.631977-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

On 4/18/24 9:22 AM, yunshui wrote:
>     As Documentation/filesystems/sysfs.rst suggested,
>     show() should only use sysfs_emit() or sysfs_emit_at() when formatting
>     the value to be returned to user space.
> 
> Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

Note same weird S-o-b here though.

Regards,

Hans




> ---
>  drivers/platform/x86/msi-laptop.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
> index f4c6c36e05a5..e5391a37014d 100644
> --- a/drivers/platform/x86/msi-laptop.c
> +++ b/drivers/platform/x86/msi-laptop.c
> @@ -317,7 +317,7 @@ static ssize_t show_wlan(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%i\n", enabled);
> +	return sysfs_emit(buf, "%i\n", enabled);
>  }
>  
>  static ssize_t store_wlan(struct device *dev,
> @@ -341,7 +341,7 @@ static ssize_t show_bluetooth(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%i\n", enabled);
> +	return sysfs_emit(buf, "%i\n", enabled);
>  }
>  
>  static ssize_t store_bluetooth(struct device *dev,
> @@ -364,7 +364,7 @@ static ssize_t show_threeg(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%i\n", threeg_s);
> +	return sysfs_emit(buf, "%i\n", threeg_s);
>  }
>  
>  static ssize_t store_threeg(struct device *dev,
> @@ -383,7 +383,7 @@ static ssize_t show_lcd_level(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%i\n", ret);
> +	return sysfs_emit(buf, "%i\n", ret);
>  }
>  
>  static ssize_t store_lcd_level(struct device *dev,
> @@ -413,7 +413,7 @@ static ssize_t show_auto_brightness(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%i\n", ret);
> +	return sysfs_emit(buf, "%i\n", ret);
>  }
>  
>  static ssize_t store_auto_brightness(struct device *dev,
> @@ -443,7 +443,7 @@ static ssize_t show_touchpad(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> -	return sprintf(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_TOUCHPAD_MASK));
> +	return sysfs_emit(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_TOUCHPAD_MASK));
>  }
>  
>  static ssize_t show_turbo(struct device *dev,
> @@ -457,7 +457,7 @@ static ssize_t show_turbo(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> -	return sprintf(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_TURBO_MASK));
> +	return sysfs_emit(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_TURBO_MASK));
>  }
>  
>  static ssize_t show_eco(struct device *dev,
> @@ -471,7 +471,7 @@ static ssize_t show_eco(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> -	return sprintf(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_ECO_MASK));
> +	return sysfs_emit(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_ECO_MASK));
>  }
>  
>  static ssize_t show_turbo_cooldown(struct device *dev,
> @@ -485,7 +485,7 @@ static ssize_t show_turbo_cooldown(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> -	return sprintf(buf, "%i\n", (!!(rdata & MSI_STANDARD_EC_TURBO_MASK)) |
> +	return sysfs_emit(buf, "%i\n", (!!(rdata & MSI_STANDARD_EC_TURBO_MASK)) |
>  		(!!(rdata & MSI_STANDARD_EC_TURBO_COOLDOWN_MASK) << 1));
>  }
>  
> @@ -500,7 +500,7 @@ static ssize_t show_auto_fan(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> -	return sprintf(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_AUTOFAN_MASK));
> +	return sysfs_emit(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_AUTOFAN_MASK));
>  }
>  
>  static ssize_t store_auto_fan(struct device *dev,


