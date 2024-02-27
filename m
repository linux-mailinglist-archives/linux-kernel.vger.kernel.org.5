Return-Path: <linux-kernel+bounces-82957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0141868C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AFB1F26A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF7136675;
	Tue, 27 Feb 2024 09:28:52 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C12130E27;
	Tue, 27 Feb 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026131; cv=none; b=mkidKuO/SnSIq554w6kBfhs4oAl4mSSV54HhTNCvHsh39DvinEbe5aOgpYZ7yMikyrCOZG4gjG2ACY26yc6NPZTRl7SxJ1ZQkqyO+V8Ivk0pDvZIrCXJJj5nSkQ1DKG2edL7BEnJtOk9dLuPMyx6KuPwAZqf5eYwJ8OCEYHMKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026131; c=relaxed/simple;
	bh=1RjYEjC3tg/YdPzt49HYIWRUmSXGpg4jxTTNPMxee90=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCJMuJb7hb/gAviO0wGCShc7FTkykB5JKZWHmUTk65b7/eGFCYxW9vCg325lofEaUFqHAk4LuJpO5p7atSc+ptzt52jJMBuIVvfN0gH4LXJ7wqw7PtPZjg52ARQfOW3j2ocSQI+LBkZ+SZlMMc2qb1LmGtcYgM2mawLCB5h5Ge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TkXBh6NgBz67bbM;
	Tue, 27 Feb 2024 17:25:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B1CD1400CD;
	Tue, 27 Feb 2024 17:28:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 09:28:44 +0000
Date: Tue, 27 Feb 2024 09:28:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	<kangkang.shen@futurewei.com>
Subject: Re: [PATCH v2 3/5] ACPI: scan: Make acpi_processor_add() check the
 device enabled bit
Message-ID: <20240227092844.00006d49@Huawei.com>
In-Reply-To: <3283809.44csPzL39Z@kreacher>
References: <6021126.lOV4Wx5bFT@kreacher>
	<3283809.44csPzL39Z@kreacher>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Feb 2024 17:40:52 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify acpi_processor_add() return an error if _STA returns the enabled
> bit clear for the given processor device, so as to avoid using processors
> that don't decode their resources, as per the ACPI specification. [1]
> 
> Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status # [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sorry for lack of reply on discussion. Your follow up mails never reached my
inbox for some reason so I just caught up on lore. I'll keep an eye on
the archives to make sure I don't miss further discussion.

Agreed that functional isn't relevant here so this patch is correct.
Also agree that it would be nice to clarify the spec as you mentioned
to say that bit 1 is reserved if bit 0 of _STA result is clear.
Depending on interpretation it's either a clarification or a relaxation
of current statements, so should be uncontroversial (famous last words ;)

+CC kangkang so this is on his radar as an ACPI cleanup suggestion.
For his reference, discussion is here:
https://lore.kernel.org/linux-acpi/CAJZ5v0jjD=KN0pOuWZZ8DT5yHdu03KgOSHYe3wB7h2vafNa44w@mail.gmail.com/

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> v1 -> v2:
>    * Move acpi_device_is_enabled() to this patch.
>    * Change patch ordering.
>    * Do not check the "functional" _STA bit in acpi_device_is_present().
> 
> ---
>  drivers/acpi/acpi_processor.c |    3 +++
>  drivers/acpi/internal.h       |    1 +
>  drivers/acpi/scan.c           |    5 +++++
>  3 files changed, 9 insertions(+)
> 
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -121,6 +121,7 @@ int acpi_device_setup_files(struct acpi_
>  void acpi_device_remove_files(struct acpi_device *dev);
>  void acpi_device_add_finalize(struct acpi_device *device);
>  void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> +bool acpi_device_is_enabled(const struct acpi_device *adev);
>  bool acpi_device_is_present(const struct acpi_device *adev);
>  bool acpi_device_is_battery(struct acpi_device *adev);
>  bool acpi_device_is_first_physical_node(struct acpi_device *adev,
> Index: linux-pm/drivers/acpi/acpi_processor.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_processor.c
> +++ linux-pm/drivers/acpi/acpi_processor.c
> @@ -381,6 +381,9 @@ static int acpi_processor_add(struct acp
>  	struct device *dev;
>  	int result = 0;
>  
> +	if (!acpi_device_is_enabled(device))
> +		return -ENODEV;
> +
>  	pr = kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
>  	if (!pr)
>  		return -ENOMEM;
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1945,6 +1945,11 @@ bool acpi_device_is_present(const struct
>  	return adev->status.present || adev->status.functional;
>  }
>  
> +bool acpi_device_is_enabled(const struct acpi_device *adev)
> +{
> +	return adev->status.present && adev->status.enabled;
> +}
> +
>  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>  				       const char *idstr,
>  				       const struct acpi_device_id **matchid)
> 
> 
> 


