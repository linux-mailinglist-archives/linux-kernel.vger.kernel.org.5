Return-Path: <linux-kernel+bounces-149733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759448A952B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F201F2211A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B915A490;
	Thu, 18 Apr 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcBxLLBd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD701586DB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429619; cv=none; b=gR7LfrssQIzXiV6+A9iGCjwSYn0onE6km1aO/0RjQvp/If+QvGZLLuDAQJI0g+OxaTgRAYstHRkr/Vsbb1d1URTww5wFDgrHiq658EmuLnTPz19bh4Y6bpoy30EctBzoaEX1smGdI7re1LtY5/k8mVfmXAfWs57kV8/lZbTJNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429619; c=relaxed/simple;
	bh=whVB5FMAA0Bq7jVqmh9CMRGIb1fK8NfDtaDZiNu4aZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyboDdTq1d4ygrxbfM/Sysd8PZ79Fkbi1R/7bSJNxSrx0KI805f60f9Iy7m+YWNMOzhP+hBFLj22ElCib1ygipYUyNwjVZ5MqPFfG0agyRUoGJpt2l054KdV+FTyXWEsLKj/TdjYV7QuQzWACJKSh45bhyhaPrS3XGr+OK+75pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcBxLLBd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713429616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiJSBwrnVS3X5n8yL9B9T0u0Bx/60qGTpS+liBEuro4=;
	b=VcBxLLBd8KLanJWbhc7VGf/YqZzE/fi1nbDRYhTO+XqQ39OABFq7P0gEzqGraBYQ7yRQxm
	8lWD6tKigHHarw67Y6+znnohuqi59Xsfv5wDOkG9uUOsYSNdBKyTvrRr9qP8qCOtZw3CcE
	cVXe9qEegVYTRjO0chXaRe6jjztkqGU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-xEUVpSndOnSpNzyKrfXMlQ-1; Thu, 18 Apr 2024 04:40:14 -0400
X-MC-Unique: xEUVpSndOnSpNzyKrfXMlQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a467a6d4e3eso20161066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429613; x=1714034413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiJSBwrnVS3X5n8yL9B9T0u0Bx/60qGTpS+liBEuro4=;
        b=O9xkVbsNmnK+ACTYZOP1oo10/MXGACyzy/pZhbCAzRb2F1wLMMucrANPhqk7S1MVJp
         NfZdQr2HW0uB7WQd17MiQsmrQvHA48z70j9H2sA55vMWNMEWVlW9aV0+vSyDs/yS8ne4
         W49U0jkOcjN14ZJ4lNg+u1KgyzsaV/alJw9L7t3Mk5M6O4MPcui1mtt6Ipp0fCM5qOVr
         yIH24ZHV4XFz/6lK9xUPQV+qdKun57ASirZuFn7ikZh45rAuS/B+XeN1J480ymdKq4jn
         27gdKGVXTbvPh4MastQ16XRuuQ3X70m9VUJCCVred5NmwkK6GM8LWQfexhgz2LQ5SUUR
         7e2w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+mPmwmaebzmMz6SLuILooB6iOV9mljd/T2DDgudOcY98inHWDPQ5SlR2RWpo9W0K+dDLl/OTTY2HKXAOWkeVeP52wbti/kHAXcsY
X-Gm-Message-State: AOJu0YyDQzHb1WN75d4QfxDPucmqm2TGc8UYN6BEP/FwPQVCO8/6KRgL
	h83zeejO/81gzW/FTYLjU06admEvk0i/TXjUdu3ZVYFB7/GHsYrtlwVQ+Z9jS9fWxIWNZOCWxnG
	EqbJD8DXxdYght4O0i1y5JNq9QVm2M3JfmvmijqQBGFZdt/CQRR2fCLQAfuMyTA==
X-Received: by 2002:a17:906:755:b0:a51:ddc6:f9c0 with SMTP id z21-20020a170906075500b00a51ddc6f9c0mr891492ejb.45.1713429613602;
        Thu, 18 Apr 2024 01:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrX/LWaMHfeaOJiU74jZ4pBAdLYGnUNM2JQRoGuML9mNpKP+wKwn8BmVlw7WowkvR/ittnwg==
X-Received: by 2002:a17:906:755:b0:a51:ddc6:f9c0 with SMTP id z21-20020a170906075500b00a51ddc6f9c0mr891487ejb.45.1713429613218;
        Thu, 18 Apr 2024 01:40:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709061e4700b00a52244ab819sm591514ejj.170.2024.04.18.01.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:40:12 -0700 (PDT)
Message-ID: <14e1e567-3429-4714-b0e2-14ad3eb66241@redhat.com>
Date: Thu, 18 Apr 2024 10:40:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-laptop: Use sysfs_emit() to replace
 sprintf()
To: yunshui <jiangyunshui@kylinos.cn>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, luke@ljones.dev, ilpo.jarvinen@linux.intel.com,
 Ai Chao <aichao@kylinos.cn>
References: <20240418083136.668869-1-jiangyunshui@kylinos.cn>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240418083136.668869-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi yunshui,

Thank you for your patch.

On 4/18/24 10:31 AM, yunshui wrote:
> As Documentation/filesystems/sysfs.rst suggested,
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>  drivers/platform/x86/asus-laptop.c | 44 +++++++++++++++---------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index 78c42767295a..2857aefc3d60 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -852,8 +852,8 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 * so we don't set eof to 1
>  	 */
>  
> -	len += sprintf(page, ASUS_LAPTOP_NAME " " ASUS_LAPTOP_VERSION "\n");
> -	len += sprintf(page + len, "Model reference    : %s\n", asus->name);
> +	len += sysfs_emit(page, ASUS_LAPTOP_NAME " " ASUS_LAPTOP_VERSION "\n");
> +	len += sysfs_emit(page + len, "Model reference    : %s\n", asus->name);

One of the purposes of sysfs_emit is to check that the output actually fits in
a page size and to truncate the output otherwise. The original code did not
check this, but if we are going to change this then we do want to check this,
so you should use sysfs_emit_at, iow the 2 new lines here should be:

	len += sysfs_emit_at(page, len, ASUS_LAPTOP_NAME " " ASUS_LAPTOP_VERSION "\n");
	len += sysfs_emit_at(page, len, "Model reference    : %s\n", asus->name);

And all further lines also should use sysfs_emit_at(page, len, "...", ...);

Regards,

Hans


>  	/*
>  	 * The SFUN method probably allows the original driver to get the list
>  	 * of features supported by a given model. For now, 0x0100 or 0x0800
> @@ -862,7 +862,7 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 */
>  	rv = acpi_evaluate_integer(asus->handle, "SFUN", NULL, &temp);
>  	if (ACPI_SUCCESS(rv))
> -		len += sprintf(page + len, "SFUN value         : %#x\n",
> +		len += sysfs_emit(page + len, "SFUN value         : %#x\n",
>  			       (uint) temp);
>  	/*
>  	 * The HWRS method return informations about the hardware.
> @@ -874,7 +874,7 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 */
>  	rv = acpi_evaluate_integer(asus->handle, "HWRS", NULL, &temp);
>  	if (ACPI_SUCCESS(rv))
> -		len += sprintf(page + len, "HWRS value         : %#x\n",
> +		len += sysfs_emit(page + len, "HWRS value         : %#x\n",
>  			       (uint) temp);
>  	/*
>  	 * Another value for userspace: the ASYM method returns 0x02 for
> @@ -885,25 +885,25 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 */
>  	rv = acpi_evaluate_integer(asus->handle, "ASYM", NULL, &temp);
>  	if (ACPI_SUCCESS(rv))
> -		len += sprintf(page + len, "ASYM value         : %#x\n",
> +		len += sysfs_emit(page + len, "ASYM value         : %#x\n",
>  			       (uint) temp);
>  	if (asus->dsdt_info) {
>  		snprintf(buf, 16, "%d", asus->dsdt_info->length);
> -		len += sprintf(page + len, "DSDT length        : %s\n", buf);
> +		len += sysfs_emit(page + len, "DSDT length        : %s\n", buf);
>  		snprintf(buf, 16, "%d", asus->dsdt_info->checksum);
> -		len += sprintf(page + len, "DSDT checksum      : %s\n", buf);
> +		len += sysfs_emit(page + len, "DSDT checksum      : %s\n", buf);
>  		snprintf(buf, 16, "%d", asus->dsdt_info->revision);
> -		len += sprintf(page + len, "DSDT revision      : %s\n", buf);
> +		len += sysfs_emit(page + len, "DSDT revision      : %s\n", buf);
>  		snprintf(buf, 7, "%s", asus->dsdt_info->oem_id);
> -		len += sprintf(page + len, "OEM id             : %s\n", buf);
> +		len += sysfs_emit(page + len, "OEM id             : %s\n", buf);
>  		snprintf(buf, 9, "%s", asus->dsdt_info->oem_table_id);
> -		len += sprintf(page + len, "OEM table id       : %s\n", buf);
> +		len += sysfs_emit(page + len, "OEM table id       : %s\n", buf);
>  		snprintf(buf, 16, "%x", asus->dsdt_info->oem_revision);
> -		len += sprintf(page + len, "OEM revision       : 0x%s\n", buf);
> +		len += sysfs_emit(page + len, "OEM revision       : 0x%s\n", buf);
>  		snprintf(buf, 5, "%s", asus->dsdt_info->asl_compiler_id);
> -		len += sprintf(page + len, "ASL comp vendor id : %s\n", buf);
> +		len += sysfs_emit(page + len, "ASL comp vendor id : %s\n", buf);
>  		snprintf(buf, 16, "%x", asus->dsdt_info->asl_compiler_revision);
> -		len += sprintf(page + len, "ASL comp revision  : 0x%s\n", buf);
> +		len += sysfs_emit(page + len, "ASL comp revision  : 0x%s\n", buf);
>  	}
>  
>  	return len;
> @@ -933,7 +933,7 @@ static ssize_t ledd_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct asus_laptop *asus = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "0x%08x\n", asus->ledd_status);
> +	return sysfs_emit(buf, "0x%08x\n", asus->ledd_status);
>  }
>  
>  static ssize_t ledd_store(struct device *dev, struct device_attribute *attr,
> @@ -993,7 +993,7 @@ static ssize_t wlan_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct asus_laptop *asus = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", asus_wireless_status(asus, WL_RSTS));
> +	return sysfs_emit(buf, "%d\n", asus_wireless_status(asus, WL_RSTS));
>  }
>  
>  static ssize_t wlan_store(struct device *dev, struct device_attribute *attr,
> @@ -1022,7 +1022,7 @@ static ssize_t bluetooth_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct asus_laptop *asus = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", asus_wireless_status(asus, BT_RSTS));
> +	return sysfs_emit(buf, "%d\n", asus_wireless_status(asus, BT_RSTS));
>  }
>  
>  static ssize_t bluetooth_store(struct device *dev,
> @@ -1052,7 +1052,7 @@ static ssize_t wimax_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct asus_laptop *asus = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", asus_wireless_status(asus, WM_RSTS));
> +	return sysfs_emit(buf, "%d\n", asus_wireless_status(asus, WM_RSTS));
>  }
>  
>  static ssize_t wimax_store(struct device *dev, struct device_attribute *attr,
> @@ -1081,7 +1081,7 @@ static ssize_t wwan_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct asus_laptop *asus = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", asus_wireless_status(asus, WW_RSTS));
> +	return sysfs_emit(buf, "%d\n", asus_wireless_status(asus, WW_RSTS));
>  }
>  
>  static ssize_t wwan_store(struct device *dev, struct device_attribute *attr,
> @@ -1151,7 +1151,7 @@ static ssize_t ls_switch_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct asus_laptop *asus = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", asus->light_switch);
> +	return sysfs_emit(buf, "%d\n", asus->light_switch);
>  }
>  
>  static ssize_t ls_switch_store(struct device *dev,
> @@ -1182,7 +1182,7 @@ static ssize_t ls_level_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct asus_laptop *asus = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", asus->light_level);
> +	return sysfs_emit(buf, "%d\n", asus->light_level);
>  }
>  
>  static ssize_t ls_level_store(struct device *dev, struct device_attribute *attr,
> @@ -1228,7 +1228,7 @@ static ssize_t ls_value_show(struct device *dev, struct device_attribute *attr,
>  	if (!err)
>  		err = pega_int_read(asus, PEGA_READ_ALS_L, &lo);
>  	if (!err)
> -		return sprintf(buf, "%d\n", 10 * hi + lo);
> +		return sysfs_emit(buf, "%d\n", 10 * hi + lo);
>  	return err;
>  }
>  static DEVICE_ATTR_RO(ls_value);
> @@ -1264,7 +1264,7 @@ static ssize_t gps_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct asus_laptop *asus = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", asus_gps_status(asus));
> +	return sysfs_emit(buf, "%d\n", asus_gps_status(asus));
>  }
>  
>  static ssize_t gps_store(struct device *dev, struct device_attribute *attr,


