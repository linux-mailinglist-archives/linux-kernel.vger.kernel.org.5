Return-Path: <linux-kernel+bounces-161908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B328B5326
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CDF1C2150E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CCF1759E;
	Mon, 29 Apr 2024 08:29:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28638EAE5;
	Mon, 29 Apr 2024 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379395; cv=none; b=TtA08El8DXmZGdV0ycgGTAYpnp3NnuZVRvAJKvoSRsIcqBq0p7e4vpFfW/ffjH5lnkUQ5b2twQLCzcGTq5Ofkp7Q7XAnQfYhxdOxbfny4V+ryFKUt5fk7PQBaOcvmTZNT0kWyYxQqGPmPa6vHWptDGvHMgyR5tgdnwDa3IFabBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379395; c=relaxed/simple;
	bh=UjNF+WJ8bFa3h858ykeWlkf9ppOKXDAJYJklbdVa5Eg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqgOKxMl7tOY/oAwgKqUSfcoHtAI8PojFWiNvl6DHbLw2ZgMZw93ssezDKhOMQT8zQpkJOvAkaSgKf+5g0yCSylQ+9VAGgGOJ3V5CU1sj8I2wsENB5MqZmlqyzZwrXxf0MDO4oZToP7bVXZ2obmTi5gWTYDNkUR4rlHeIF6hQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VSc1z0Y7Kz6K9DL;
	Mon, 29 Apr 2024 16:29:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 519031406AE;
	Mon, 29 Apr 2024 16:29:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 09:29:42 +0100
Date: Mon, 29 Apr 2024 09:29:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [PATCH v1] ACPI: scan: Avoid enumerating devices with clearly
 invalid _STA values
Message-ID: <20240429092942.00004c96@Huawei.com>
In-Reply-To: <2741433.mvXUDI8C0e@kreacher>
References: <2741433.mvXUDI8C0e@kreacher>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Apr 2024 18:56:21 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The return value of _STA with the "present" bit unset and the "enabled"
> bit set is clearly invalid as per the ACPI specification, Section 6.3.7
> "_STA (Device Status)", so make the ACPI device enumeration code
> disregard devices with such _STA return values.
> 
> Also, because this implies that status.enabled will only be set if
> status.present is set too, acpi_device_is_enabled() can be modified
> to simply return the value of the former.
> 
> Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status
> Link: https://lore.kernel.org/linux-acpi/88179311a503493099028c12ca37d430@huawei.com/
> Suggested-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Seems a sensible tidying up.  Hopefully nothing was relying on
this looser behavior.  One trivial thing inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/bus.c  |   11 +++++++++++
>  drivers/acpi/scan.c |    2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -112,6 +112,17 @@ int acpi_bus_get_status(struct acpi_devi
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> +	if (!device->status.present && device->status.enabled) {
> +		pr_info(FW_BUG "Device [%s] status [%08x]: not present and enabled\n",
> +			device->pnp.bus_id, (u32)sta);
> +		device->status.enabled = 0;
> +		/*
> +		 * The status is clearly invalid, so clear the enabled bit as
> +		 * well to avoid attempting to use the device.
> +		 */

Comment seems to be in a slightly odd place.  Perhaps one line earlier makes
more sense?  Or was the intent to mention functional here?

> +		device->status.functional = 0;
> +	}
> +
>  	acpi_set_device_status(device, sta);
>  
>  	if (device->status.functional && !device->status.present) {
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1962,7 +1962,7 @@ bool acpi_device_is_present(const struct
>  
>  bool acpi_device_is_enabled(const struct acpi_device *adev)
>  {
> -	return adev->status.present && adev->status.enabled;
> +	return adev->status.enabled;
>  }
>  
>  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
> 
> 
> 


