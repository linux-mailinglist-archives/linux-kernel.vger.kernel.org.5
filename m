Return-Path: <linux-kernel+bounces-77141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCA86019B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443D41C24375
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62759137938;
	Thu, 22 Feb 2024 18:28:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6746137919;
	Thu, 22 Feb 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626523; cv=none; b=TDCWsT2YcUSIhA0AM4q2HSakLUNq1lmuA4JvQH76x09uxUPdDORPmTWBKR1qZrf5BMcMM90VK2dceY0ZZ1vr217/vy70HhI71WvU144QfL9xGRs/0iN3OEcltvAHNu69viaiazXHra2w8G2EskHllHN0ZnHZMvdxZzReouVgyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626523; c=relaxed/simple;
	bh=QiLVanTscz1aqdc7VbWSJnOpMWD88oe6T0mv+ihO+5o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJSWx1yaIQvGzDOKj5ZWqJg/iznqz9VrSdA7eOLpTdtMEninOqXXuhGZKYpWEWvZND27vzFGF0tLk9pjAnEaOmHcq8J0TRdfb/oyr5im9f2aM1yQpjxLcbK8hI8IB6zWqyHeP+GzGP25YOR3zg5vXCCelC5WOt78fl1V4PwXHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TghPB5xt4z6J9St;
	Fri, 23 Feb 2024 02:24:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E39B140A9C;
	Fri, 23 Feb 2024 02:28:38 +0800 (CST)
Received: from localhost (10.195.247.94) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Feb
 2024 18:28:37 +0000
Date: Thu, 22 Feb 2024 18:28:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 3/4] ACPI: scan: Rework Device Check and Bus Check
 notification handling
Message-ID: <20240222182834.00000b02@Huawei.com>
In-Reply-To: <2939512.e9J7NaK4W3@kreacher>
References: <4562925.LvFx2qVVIh@kreacher>
	<2939512.e9J7NaK4W3@kreacher>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Feb 2024 21:02:33 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The underlying problem is the handling of the enabled bit in device
> status (bit 1 of _STA return value) which is required by the ACPI
> specification to be observed in addition to the present bit (bit 0
> of _STA return value) [1], but Linux does not observe it.
> 
> Since Linux has not looked at that bit for a long time, it is generally
> risky to start obseving it in all device enumeration cases, especially
> at the system initialization time, but it can be observed when the
> kernel receives a Bus Check or Device Check notification indicating a
> change in device configuration.  In those cases, seeing the enabled bit
> clear may be regarded as an indication that the device at hand should
> not be used any more.

Hi Rafael,

I rebased the vCPU HP series Russell was working to go on top of this
and give me a basis to check the flows through your new conditions.
It may have it's own issues, but at least it makes use of some of these
bits and related checks.

For now the only key thing is make sure we don't check enabled()
in the hot remove path (until after _EJ0).  That happens correctly
because acpi_device_trim() is called and that doesn't have check_status
set.  The naming however doesn't make it obvious that path elides the
check, so I wonder if that call in acpi_scan_hotremove()
should be replaced with acpi_bus_trim_one(, NULL);

> 
> For this reason, rework the handling of Device Check and Bus Check
> notifications in the ACPI core device enumeration code in the
> following way:
> 
>  1. Make acpi_bus_trim_one() check device status if its second argument
>     is not NULL, in which case it will only detach scan handlers or ACPI
>     drivers from devices whose _STA returns the enabled bit clear.
> 
>  2. Make acpi_scan_device_check() and acpi_scan_bus_check() invoke
>     acpi_bus_trim_one() with a non-NULL second argument unconditionally,
>     so scan handlers and ACPI drivers are detached from the target
>     device and its ancestors if their _STA returns the enabled bit
>     clear.
> 
>  3. Make acpi_scan_device_check() skip the bus rescan if _STA for the
>     target device return the enabled bit clear, which is allowed by the
>     ACPI specification in the Device Check case. [2]
> 
> In addition to the above:
> 
>  4. Make sure that the bus rescan that needs to be triggered in the case
>     when a new device has appeared is carried out in the same way in
>     both the Device Check and Bus Check cases.
> 
>  5. In the Device Check case, start the bus rescan mentioned above from
>     the target device's parent, as per the specification. [2]

This feels like an 'and' kind of a patch. Can we split it up so refactors
are done first and the _STA check stuff in a follow up patch?

End result is good, just could possibly be easier to review in two hops.

> 
> Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status # [1]
> Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#device-object-notification-values # [2]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Diff had a field day here and generated an somewhat unreadable patch.

A few other comments inline, but superficial stuff. The handling looks
correct to me.

> ---
>  drivers/acpi/internal.h |    1 
>  drivers/acpi/scan.c     |  109 +++++++++++++++++++++++++++---------------------
>  2 files changed, 64 insertions(+), 46 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -244,11 +244,27 @@ static int acpi_scan_try_to_offline(stru
>  	return 0;
>  }
>  
> -static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> +static int acpi_bus_trim_one(struct acpi_device *adev, void *check_status)

Bool as pointer is a bit hard to read particularly as you use (void *)true
for true, but not (void *)false for false.

However it's not too bad.  My current version of the vCPU patches needs
to pass more data in here anyway (as there a few things we need to
not do on eject, that don't correspond to !check_status)
so I have this as a struct anyway after a rebase.

>  {
>  	struct acpi_scan_handler *handler = adev->handler;
>  
> -	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> +	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, check_status);
> +
> +	if (check_status) {
> +		acpi_bus_get_status(adev);
> +		/*
> +		 * Skip devices that are still there and take the enabled
> +		 * flag into account.
> +		 */
> +		if (acpi_device_is_enabled(adev))
> +			return 0;
> +
> +		/* Skip device that have not been enumerated. */
> +		if (!acpi_device_enumerated(adev)) {
> +			dev_dbg(&adev->dev, "Still not enumerated\n");
> +			return 0;
> +		}
> +	}
>  
>  	adev->flags.match_driver = false;
>  	if (handler) {
> @@ -315,71 +331,67 @@ static int acpi_scan_hot_remove(struct a
>  	return 0;
>  }
>  
> -static int acpi_scan_device_not_enumerated(struct acpi_device *adev)
> +static void acpi_scan_check_gone(struct acpi_device *adev)

The name of this had me initially a little confused.  Maybe
acpi_bus_trim_if_gone()

Or maybe just drop this wrapper entirely as it doesn't save much
and naming it clearly is hard.


>  {
> -	if (!acpi_device_enumerated(adev)) {
> -		dev_warn(&adev->dev, "Still not enumerated\n");
> -		return -EALREADY;
> -	}
> -	acpi_bus_trim(adev);
> -	return 0;
> +	acpi_bus_trim_one(adev, (void *)true);
>  }


>  static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
>  {
>  	switch (type) {
>  	case ACPI_NOTIFY_BUS_CHECK:
> -		return acpi_scan_bus_check(adev, NULL);
> +		return acpi_scan_bus_check(adev);
>  	case ACPI_NOTIFY_DEVICE_CHECK:
>  		return acpi_scan_device_check(adev);
>  	case ACPI_NOTIFY_EJECT_REQUEST:
> @@ -1945,6 +1957,11 @@ bool acpi_device_is_present(const struct
>  	return adev->status.present || adev->status.functional;
>  }
>  
> +bool acpi_device_is_enabled(const struct acpi_device *adev)
> +{
> +	return acpi_device_is_present(adev) && adev->status.enabled;

This resolves as (present or functional) && enabled.

By my reading you are not allowed functional && enabled, but not present.
Line one of the description says.

"If bit [0] is cleared, then bit 1 must also be cleared (in other words, a device that is not present cannot be enabled)."

I don't much care about that though (I think we discussed this
in Russel's earlier series)

> +}
> +
>  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>  				       const char *idstr,
>  				       const struct acpi_device_id **matchid)
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
> 
> 
> 


