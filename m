Return-Path: <linux-kernel+bounces-76925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2285FEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AAD1C22A98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3C154C0D;
	Thu, 22 Feb 2024 17:09:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFEA14F9FE;
	Thu, 22 Feb 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621781; cv=none; b=nNDggy33elGL3jp9wDve4cyqSCiSoaB50RdgzZbSCNx8cFPZ9V7Fp6DRQU/0EA1fXFyVySsSiYBORCy/s1MOd/U/B9iSXQR3gJNfSJiOmo5QUcN3XTdjioayj52RrkVPTIUj14/GpW/s/2HP0QhdBODwDNSwSfOppIQxaSVZa2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621781; c=relaxed/simple;
	bh=mIilUSVPnUtIgyL5qEymGqB/IlLbf3/YZNTlBlIzB3Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaxWoBTNeNJy73umNGxsiTavG52jKf2eOXpaqIs+pTEQOJ7CCw3QWdHRd+b1rQqzVtfZHJJXuynjxzpuHodB1lIt2h7rLWKw+O8ESCjV54kAASoHBb7uObaVdZliQeW/TIJr374juZbzrebgIniwwNMvznp0yRg4r4rkackdVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TgffK0Y7Wz6K66S;
	Fri, 23 Feb 2024 01:05:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 90D471400C9;
	Fri, 23 Feb 2024 01:09:15 +0800 (CST)
Received: from localhost (10.195.247.94) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Feb
 2024 17:09:11 +0000
Date: Thu, 22 Feb 2024 17:09:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 2/4] ACPI: scan: Relocate acpi_bus_trim_one()
Message-ID: <20240222170907.00000afa@Huawei.com>
In-Reply-To: <2189881.irdbgypaU6@kreacher>
References: <4562925.LvFx2qVVIh@kreacher>
	<2189881.irdbgypaU6@kreacher>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Feb 2024 21:01:48 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Relocate acpi_bus_trim_one() (without modifications) so as to avoid the
> need to add a forward declaration of it in a subsequent patch.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
FWIW you indeed moved the code :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/scan.c |   52 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -244,6 +244,32 @@ static int acpi_scan_try_to_offline(stru
>  	return 0;
>  }
>  
> +static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> +{
> +	struct acpi_scan_handler *handler = adev->handler;
> +
> +	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> +
> +	adev->flags.match_driver = false;
> +	if (handler) {
> +		if (handler->detach)
> +			handler->detach(adev);
> +
> +		adev->handler = NULL;
> +	} else {
> +		device_release_driver(&adev->dev);
> +	}
> +	/*
> +	 * Most likely, the device is going away, so put it into D3cold before
> +	 * that.
> +	 */
> +	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> +	adev->flags.initialized = false;
> +	acpi_device_clear_enumerated(adev);
> +
> +	return 0;
> +}
> +
>  static int acpi_scan_hot_remove(struct acpi_device *device)
>  {
>  	acpi_handle handle = device->handle;
> @@ -2547,32 +2573,6 @@ int acpi_bus_scan(acpi_handle handle)
>  }
>  EXPORT_SYMBOL(acpi_bus_scan);
>  
> -static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> -{
> -	struct acpi_scan_handler *handler = adev->handler;
> -
> -	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> -
> -	adev->flags.match_driver = false;
> -	if (handler) {
> -		if (handler->detach)
> -			handler->detach(adev);
> -
> -		adev->handler = NULL;
> -	} else {
> -		device_release_driver(&adev->dev);
> -	}
> -	/*
> -	 * Most likely, the device is going away, so put it into D3cold before
> -	 * that.
> -	 */
> -	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> -	adev->flags.initialized = false;
> -	acpi_device_clear_enumerated(adev);
> -
> -	return 0;
> -}
> -
>  /**
>   * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
>   * @adev: Root of the ACPI namespace scope to walk.
> 
> 
> 


