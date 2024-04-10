Return-Path: <linux-kernel+bounces-138337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6108689EFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99241F23751
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7145815A496;
	Wed, 10 Apr 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZpU+PyV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283815956A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745337; cv=none; b=PkeIXPRCQHkeaRV1ACS+L1uTaF3Wy7gA1Eqr1ppa3FZT1pZgihvidFCIsj9RdBMubVm6+8UuWdXOQGB2Ipv8tcnvWhp4eF87ChtRKbjoaSyHXhR8T/IhwvK/HaYIIBZVeAWidfqWezRei9HFOnBrctLsD955+TgDtnQaQ01/nxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745337; c=relaxed/simple;
	bh=rmoFoakUhj6+msUlbauZkAYDvK64i2LrXOHiREfUozo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anT0PDOepL0/lOqdE1d21LU17ZkEFy97SuU4jmz4qE2TlTIMxj60OrMIqSSSQ1hVqBlVKRxD0ppZZm2n5Yhrm0Fa5XD7kHJyhs5ezAI28NFT4IhpFQznqd3smNBxRrs0Om5F02XHYp7hl6kDI+b7eLxyFuBSvPwook3vTs4XMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZpU+PyV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712745334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYnQ58s+I6zMZkaWsRCCBmtK31C23SKzGz7dYRh7GvU=;
	b=TZpU+PyV86BomVfYhoJmjVlvmNYQni23yWo/qzlZGKeP979mqO6GJgg9wZRKMcmlkoIUJR
	SdyxP6HJeqDoSpqHlFDSqtwp1dEQ7QhVu8792gLJXw1T2k/fleJ8kHyYdCvZy7aqVJPeLV
	P9kRVJH0tUtXKOrnSSID6hAoAc/JLRQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-JPxf4OgNOZ64_kLSVoVYgQ-1; Wed, 10 Apr 2024 06:35:32 -0400
X-MC-Unique: JPxf4OgNOZ64_kLSVoVYgQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a467a6d4e3eso311304366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712745331; x=1713350131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYnQ58s+I6zMZkaWsRCCBmtK31C23SKzGz7dYRh7GvU=;
        b=ZySJIPanaExQOP0iym4HlO1darLJOyjWwJuzXP9gJqp6r+u0dBh7H2QqBb/Iqy5Ada
         pWCiXWxDWtQ3fXa6jTm4JSfKf0MpYch+jTmoSMFk8bSi+fV/Wz2ycJQ2DzD5YlldU/pQ
         IW924NTzpAZxYfJXmgq5jLnBwj72zum+f5SOsWXperdLzOL6qnO+tHhhmOpJtEZWI7T6
         PlmcwsFIr0zw6SuWcN8lEe6jM7u0Vdgvb0+em8NYW42Wgr1wNAvx3St8cOfHjRtiiEec
         GLb7D7nO3Jt5sJQ6GujB1A6rtAB7D6zohhCQlFL0b6iXsquXDC2LNc0Isp3ZuR0dHz8d
         qjEA==
X-Forwarded-Encrypted: i=1; AJvYcCU5hq8mZmPMeHuowJUdBVM5jUHLVTbxT8vO6XVVskRlf8mxNAbXxh23m2Fd9bLNQE3YI8UYpmOaI49WGN4GO4EU82h/IUQSiG5mp2bk
X-Gm-Message-State: AOJu0YyGa/hTG+jn9GOsKboCYlL84y1VEJSF8NKC8K2ydBHDdxEgV18M
	QKUJxKSixNwOTuqA5PF7fvcOnU+B2M/9Cfnj9Lb1cgLf1F657Ksw3+V3bBpsV7z/nF8DEuNkgqy
	ga/5UMtsUncByYJuFuttRMfgReyBhBdWTQU+/DDb8vaeby1jqve2XRrrdKTcvy/cgRBhPjQ==
X-Received: by 2002:a17:907:7f88:b0:a4e:146c:ff09 with SMTP id qk8-20020a1709077f8800b00a4e146cff09mr1571285ejc.7.1712745331561;
        Wed, 10 Apr 2024 03:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl/DgE8lML4A21OOZtzpiFdYYtgIOsGkpz5Iu44RPGGo4g+/OgXBdiq8ILcRIkcBjkwrdv0g==
X-Received: by 2002:a17:907:7f88:b0:a4e:146c:ff09 with SMTP id qk8-20020a1709077f8800b00a4e146cff09mr1571263ejc.7.1712745330852;
        Wed, 10 Apr 2024 03:35:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id cw23-20020a170906c79700b00a51bf5932aesm5274595ejb.28.2024.04.10.03.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 03:35:30 -0700 (PDT)
Message-ID: <c9741df0-6c12-4ff5-90b4-5a13f0bd9b51@redhat.com>
Date: Wed, 10 Apr 2024 12:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] media: atomisp: Replace open-coded
 i2c_find_device_by_fwnode()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240326202813.1425431-1-andriy.shevchenko@linux.intel.com>
 <20240326202813.1425431-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240326202813.1425431-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

Thank you for the patch.

On 3/26/24 9:27 PM, Andy Shevchenko wrote:
> gmin_i2c_dev_exists() is using open-coded variant of
> i2c_find_device_by_fwnode(). Replace it with a corresponding call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> index 80aa2211cdc3..b7c477280986 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> @@ -394,12 +394,10 @@ static struct i2c_client *gmin_i2c_dev_exists(struct device *dev, char *name,
>  	if (!adev)
>  		return NULL;
>  
> -	d = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
> +	d = get_device(acpi_get_first_physical_node(adev));
>  	acpi_dev_put(adev);
> -	if (!d)
> -		return NULL;
>  
> -	*client = i2c_verify_client(d);
> +	*client = i2c_find_device_by_fwnode(dev_fwnode(d));
>  	put_device(d);
>  
>  	dev_dbg(dev, "found '%s' at address 0x%02x, adapter %d\n",

If we are ging to simplify this I think the change should be:

From ea66d15b9a72fcb8baf22a2ff059f2b842a91b67 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 10 Apr 2024 12:32:11 +0200
Subject: [PATCH] media: atomisp: Replace open-coded
 i2c_find_device_by_fwnode()

gmin_i2c_dev_exists() is using open-coded variant of
i2c_find_device_by_fwnode(). Replace it with a corresponding call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Directly use the ACPI fwnode through acpi_fwnode_handle(adev) instead
  of first calling acpi_get_first_physical_node(adev)
---
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index 804ffff245f3..ed6214327ce5 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -394,14 +394,11 @@ static struct i2c_client *gmin_i2c_dev_exists(struct device *dev, char *name,
 	if (!adev)
 		return NULL;
 
-	d = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
+	*client = i2c_find_device_by_fwnode(acpi_fwnode_handle(adev));
 	acpi_dev_put(adev);
-	if (!d)
+	if (!*client)
 		return NULL;
 
-	*client = i2c_verify_client(d);
-	put_device(d);
-
 	dev_dbg(dev, "found '%s' at address 0x%02x, adapter %d\n",
 		(*client)->name, (*client)->addr, (*client)->adapter->nr);
 	return *client;
-- 
2.44.0

Note I added a:

	if (!*client)
		return NULL;

To fix a bug in the original code where the dev_dbg() arguments
are dereferencing a potential NULL *client ptr.

I'm going to merge this variant into my media-atomisp branch
instead of the orignal.

Regards,

Hans




