Return-Path: <linux-kernel+bounces-153474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F148ACE85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B19F1C21457
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA014F9F1;
	Mon, 22 Apr 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBoi5mDn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD975028B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793314; cv=none; b=C3TJFqlGvDqQAXyKA0S1S8djuelrhhNrWf2TAjL12FGSAQtTSXYtgU5EydArXX970ZJ+k0IHhuw7AZcnZwnH+AyGA9USQ4zlHrDFCzPooIP2YLF55btmq1yC/5h+BHRKCSGAqcclHtSK2zMYjXQGs08GdLBhOVBMZjLJkKVa+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793314; c=relaxed/simple;
	bh=4oim69y/9OfKbI8BdKLij662Sppol9ItNizhr27QLms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1v77yhiBt1prymDh0lqpfgjvM02pUNkm2yjyQFkArlNFfV91lk8i4U/xYVuGCAh6uSKitWRiDkyiGDQDNq2kIXzupn8wyA10gvC/MraMJkw34rTSnMcFApvcMaDnWBhiIDuTDOC7MAFlySrpT1dKYOl8o8ZzwUZMGojxTn/Bf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBoi5mDn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713793311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRxwkIFUs9CTScVUXhPkf0X+3b18MF4xd0ddKvmTSu8=;
	b=hBoi5mDnP7p3KGrCRiajhIVJncXcCoN/x6zZV/wm4wR37WpqBRCfeWsEQHpRuJ1rTu8XLa
	bZoHtXBb5qpXP0kL+BIZiZfnJeb7yNk58rs/0Gqap3QHp4HqmHofZ80yIqVfcA1oJFBXcQ
	hnJWyYDafpnzNTXCJA01G9a1qdfByFs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-QxEGd39aOw-0miEBfu48sg-1; Mon, 22 Apr 2024 09:41:50 -0400
X-MC-Unique: QxEGd39aOw-0miEBfu48sg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34a49f5a6baso2685158f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793309; x=1714398109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRxwkIFUs9CTScVUXhPkf0X+3b18MF4xd0ddKvmTSu8=;
        b=ZyhqcOimH9JBLIgP/r3JSsS2BacY83a502FsdZRKupTn+9tW/iG05j7sliTIB4mJZ5
         BjEN8S4x/ZsGaXbHc/nOJBuRFU0gEQQ2p0Kwn7YB4Jl+DaCQ6wysHz8SQhU4HuwXVJv4
         IYgrRPNvuBje06Vc5ngmDj9vMRAxItqdlonHg946dENruyNiQTBAOISt8B1g5dqdhbUc
         LlUhkGH+kb0GKfBZKIJswRKKGGYzT3w8h8qdUYM5aAjKaTw4055jqXxyoMBMtZdVbvyl
         NujV9vLcOwrxgBdy+TtrsyPd2yY96v3lihn/KmMjhPKeqNzwYy3kxUmBty1lDpkYN5H1
         gF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVw61+DHJL0/2QLhKgtDQ9uC7jsJTNlxn4vRn1s+n9JF8xleXcEMrWiiRB/+vNzV7uVItE6rcCmh4TJB2uQF+GjwQb5uAniG0RADxR
X-Gm-Message-State: AOJu0YwOxzVT+HJX6JdcizUi9fUXyPWAlVJIRa+i1RVxmrloA1arnvMC
	kOwg54zJKIEx0w6YgUhrJ2OkcWtO3jiAg8IMbJsJkInuc1YP2v+gn3k6G5EksG2tkNra4yZ1amV
	B3Sjp/BpPkK6sOFBzlXpG0b58GUaxGTKZ2qVRENOnf1tT6TNT7xXdITEO5zn7Iw==
X-Received: by 2002:adf:f343:0:b0:343:5cca:f7c7 with SMTP id e3-20020adff343000000b003435ccaf7c7mr8253510wrp.41.1713793309114;
        Mon, 22 Apr 2024 06:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0jLaTWNc6yGyIvSKmiCD5yZ7ygpSwhzslfbyzrlx20Ts+CP4YuQ0EwZ9+WZX60zIsyyVJ9A==
X-Received: by 2002:adf:f343:0:b0:343:5cca:f7c7 with SMTP id e3-20020adff343000000b003435ccaf7c7mr8253486wrp.41.1713793308682;
        Mon, 22 Apr 2024 06:41:48 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id f15-20020a170906c08f00b00a553574ae71sm5742142ejz.7.2024.04.22.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:41:47 -0700 (PDT)
Message-ID: <1e4e5799-38b7-42ca-b196-3eac82601ff4@redhat.com>
Date: Mon, 22 Apr 2024 15:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] platform/x86: msi-laptop: Use sysfs_emit() to replace
 sprintf()
To: yunshui <jiangyunshui@kylinos.cn>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
References: <20240419063649.2396461-1-jiangyunshui@kylinos.cn>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240419063649.2396461-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/19/24 8:36 AM, yunshui wrote:
> As Documentation/filesystems/sysfs.rst suggested,
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
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


