Return-Path: <linux-kernel+bounces-153486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AB8ACEA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0151F220A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDCB1514E2;
	Mon, 22 Apr 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QD6KP9Ge"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1B1509A5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793540; cv=none; b=kBpVU1A02sjh16nddDcTHV/OWE+zdy02KwltqanC1rd6Bz6gXHnlkF8SMNdND7Ii3PVOI4qohzTz0JhhtCL4lSlw4doxsm6rIVRkQYQOpP7eCDQWtFDpZMAxvLTPS0+ir5+NqhqWShN/4ngghQd7wFV2wGCciOTAkLX50VJK/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793540; c=relaxed/simple;
	bh=4YMVZUICuNUnooMES/18Kn3KRTa8xUdNs/MTHLvud3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBtZdKq+HFgj1L1ZGMaOsO/S2gQZu64dktR7UJVj5/OtM0YKwpdm0GqvspkVVFEIDeiuMhpSBDzjPiTrBaROnjfvwzlHSSbm3L/Zv3r7Qi1J/tDA5OS66A1oJY2Qvr0tbbVWAWiL3jFHqAIx3KSxHcifoBn4qUNXFgYR0UH2igg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QD6KP9Ge; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713793537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwY1DtEOHqribjOyCtgFKsXBMbmg7tj+TqpASPAmvqA=;
	b=QD6KP9GeOaKU9rwemCyMCzazup/zh5A3o14wq9e1D/enIAV3bGqVeceSqixmLOA2upHh4G
	plmSpMDY4MwaMj+7pVcoK4UbftjaMynYZCv1gBc7j0wd8oMlJjcj4z9W83d73Ix6lYkLNm
	iUL6UE2by7hrvGAK8eIt3A5zkXnQkrM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-EFgfkw6rPDeB7Hp2cFLMGA-1; Mon, 22 Apr 2024 09:45:33 -0400
X-MC-Unique: EFgfkw6rPDeB7Hp2cFLMGA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-518f6868850so3401909e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793531; x=1714398331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwY1DtEOHqribjOyCtgFKsXBMbmg7tj+TqpASPAmvqA=;
        b=g9PD54d6UCBbuZczPFrYYsBWJQqhVomvH+MMmKeHRlexKn7Siwhu4OI0obQq6ae/Sn
         vc7mTOL1eRUpmzd7LNlx2ppVckcdOt754+hEB4OTtXPOY0vTgsbnosHPzy7YVYbHNTSm
         Zh5y94cCJF1lWmJCoD8qlKgS05IalG/VIGjteFi7ZLf5g0eVgfEbOs2WjRdveYOJVU/i
         wj/HNHghRcl3fvKsz3Z04EgenuwRpjdkMxG2o9arhPsoflHEjfOA4rcwSOhhuRdyZ+pT
         FxhyuMCxpRsmK7ppvzG2TMOPuWwqIFhRaEh7im3oFE/rUrb6oJrvGc1K9Y9dN0R/14I/
         WrXw==
X-Forwarded-Encrypted: i=1; AJvYcCUU2iUWCKwP82NyOxcbe4Kxa12cUJmqbK5Bn0G04UWhcaPon1Bmo6dprfsADQdBRgSu/RJflxG9/e+RfOFfyIC88P2YvOS2KDYxu6AR
X-Gm-Message-State: AOJu0YwDLTtm1R9oqSZidAG0er6cIkn0sy7fHIryBQA4LdAnR364qxV9
	aY6ppiUoAsGsXmGXJGhVpGgnVN1hmU9Xbgu03UWwq+wE/H701Hc+28cuKhRCPRJ7Vv6p6qVjB1G
	qtrxDEiezjD0u88OzXfu7eTzU8osYDHTiinzvVeh/HsBbkbkpRSf1nlWwTF+A2A==
X-Received: by 2002:a05:6512:60b:b0:51b:3ffa:f22d with SMTP id b11-20020a056512060b00b0051b3ffaf22dmr1621229lfe.18.1713793531031;
        Mon, 22 Apr 2024 06:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKFQpw6rKr1G9y/ZCaqi5LiAOCRXo3Yu+6uaAFYUdvzN8gHUauGRjJfN5YhPSGmG97LfhNUA==
X-Received: by 2002:a05:6512:60b:b0:51b:3ffa:f22d with SMTP id b11-20020a056512060b00b0051b3ffaf22dmr1621212lfe.18.1713793530561;
        Mon, 22 Apr 2024 06:45:30 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id dk17-20020a170907941100b00a55b0380a6fsm1785209ejc.10.2024.04.22.06.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:45:29 -0700 (PDT)
Message-ID: <98b6e167-5828-41fd-ab4a-014099032d5b@redhat.com>
Date: Mon, 22 Apr 2024 15:45:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: asus-laptop: Use sysfs_emit() and
 sysfs_emit_at() to replace sprintf()
To: yunshui <jiangyunshui@kylinos.cn>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, luke@ljones.dev, ilpo.jarvinen@linux.intel.com,
 Ai Chao <aichao@kylinos.cn>
References: <20240422062915.3393480-1-jiangyunshui@kylinos.cn>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240422062915.3393480-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/22/24 8:29 AM, yunshui wrote:
> As Documentation/filesystems/sysfs.rst suggested,
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

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
>  drivers/platform/x86/asus-laptop.c | 44 +++++++++++++++---------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index 78c42767295a..ccb33d034e2a 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -852,8 +852,8 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 * so we don't set eof to 1
>  	 */
>  
> -	len += sprintf(page, ASUS_LAPTOP_NAME " " ASUS_LAPTOP_VERSION "\n");
> -	len += sprintf(page + len, "Model reference    : %s\n", asus->name);
> +	len += sysfs_emit_at(page, len, ASUS_LAPTOP_NAME " " ASUS_LAPTOP_VERSION "\n");
> +	len += sysfs_emit_at(page, len, "Model reference    : %s\n", asus->name);
>  	/*
>  	 * The SFUN method probably allows the original driver to get the list
>  	 * of features supported by a given model. For now, 0x0100 or 0x0800
> @@ -862,7 +862,7 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 */
>  	rv = acpi_evaluate_integer(asus->handle, "SFUN", NULL, &temp);
>  	if (ACPI_SUCCESS(rv))
> -		len += sprintf(page + len, "SFUN value         : %#x\n",
> +		len += sysfs_emit_at(page, len, "SFUN value         : %#x\n",
>  			       (uint) temp);
>  	/*
>  	 * The HWRS method return informations about the hardware.
> @@ -874,7 +874,7 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 */
>  	rv = acpi_evaluate_integer(asus->handle, "HWRS", NULL, &temp);
>  	if (ACPI_SUCCESS(rv))
> -		len += sprintf(page + len, "HWRS value         : %#x\n",
> +		len += sysfs_emit_at(page, len, "HWRS value         : %#x\n",
>  			       (uint) temp);
>  	/*
>  	 * Another value for userspace: the ASYM method returns 0x02 for
> @@ -885,25 +885,25 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 */
>  	rv = acpi_evaluate_integer(asus->handle, "ASYM", NULL, &temp);
>  	if (ACPI_SUCCESS(rv))
> -		len += sprintf(page + len, "ASYM value         : %#x\n",
> +		len += sysfs_emit_at(page, len, "ASYM value         : %#x\n",
>  			       (uint) temp);
>  	if (asus->dsdt_info) {
>  		snprintf(buf, 16, "%d", asus->dsdt_info->length);
> -		len += sprintf(page + len, "DSDT length        : %s\n", buf);
> +		len += sysfs_emit_at(page, len, "DSDT length        : %s\n", buf);
>  		snprintf(buf, 16, "%d", asus->dsdt_info->checksum);
> -		len += sprintf(page + len, "DSDT checksum      : %s\n", buf);
> +		len += sysfs_emit_at(page, len, "DSDT checksum      : %s\n", buf);
>  		snprintf(buf, 16, "%d", asus->dsdt_info->revision);
> -		len += sprintf(page + len, "DSDT revision      : %s\n", buf);
> +		len += sysfs_emit_at(page, len, "DSDT revision      : %s\n", buf);
>  		snprintf(buf, 7, "%s", asus->dsdt_info->oem_id);
> -		len += sprintf(page + len, "OEM id             : %s\n", buf);
> +		len += sysfs_emit_at(page, len, "OEM id             : %s\n", buf);
>  		snprintf(buf, 9, "%s", asus->dsdt_info->oem_table_id);
> -		len += sprintf(page + len, "OEM table id       : %s\n", buf);
> +		len += sysfs_emit_at(page, len, "OEM table id       : %s\n", buf);
>  		snprintf(buf, 16, "%x", asus->dsdt_info->oem_revision);
> -		len += sprintf(page + len, "OEM revision       : 0x%s\n", buf);
> +		len += sysfs_emit_at(page, len, "OEM revision       : 0x%s\n", buf);
>  		snprintf(buf, 5, "%s", asus->dsdt_info->asl_compiler_id);
> -		len += sprintf(page + len, "ASL comp vendor id : %s\n", buf);
> +		len += sysfs_emit_at(page, len, "ASL comp vendor id : %s\n", buf);
>  		snprintf(buf, 16, "%x", asus->dsdt_info->asl_compiler_revision);
> -		len += sprintf(page + len, "ASL comp revision  : 0x%s\n", buf);
> +		len += sysfs_emit_at(page, len, "ASL comp revision  : 0x%s\n", buf);
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


