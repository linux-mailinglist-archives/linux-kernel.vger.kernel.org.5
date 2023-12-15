Return-Path: <linux-kernel+bounces-1217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA00814BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138F2B2257C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AD137169;
	Fri, 15 Dec 2023 15:30:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DF237152;
	Fri, 15 Dec 2023 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 619E3C15;
	Fri, 15 Dec 2023 07:31:40 -0800 (PST)
Received: from [10.57.85.151] (unknown [10.57.85.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D441A3F5A1;
	Fri, 15 Dec 2023 07:30:53 -0800 (PST)
Message-ID: <30891c4e-0fec-4477-ba49-905ea05a4545@arm.com>
Date: Fri, 15 Dec 2023 15:31:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Fix NULL pointer dereference in zone
 registration error path
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
References: <5737641.DvuYhMxLoT@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5737641.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/14/23 10:52, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If device_register() in thermal_zone_device_register_with_trips()
> returns an error, the tz variable is set to NULL and subsequently
> dereferenced in kfree(tz->tzp).
> 
> Commit adc8749b150c ("thermal/drivers/core: Use put_device() if
> device_register() fails") added the tz = NULL assignment in question to
> avoid a possible double-free after dropping the reference to the zone
> device.  However, after commit 4649620d9404 ("thermal: core: Make
> thermal_zone_device_unregister() return after freeing the zone"), that
> assignment has become redundant, because dropping the reference to the
> zone device does not cause the zone object to be freed any more.
> 
> Drop it to address the NULL pointer dereference.
> 
> Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |    1 -
>   1 file changed, 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1394,7 +1394,6 @@ unregister:
>   	device_del(&tz->device);
>   release_device:
>   	put_device(&tz->device);
> -	tz = NULL;
>   remove_id:
>   	ida_free(&thermal_tz_ida, id);
>   free_tzp:
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

