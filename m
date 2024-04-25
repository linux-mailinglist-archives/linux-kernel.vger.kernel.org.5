Return-Path: <linux-kernel+bounces-159146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE36A8B29E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC39428795B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF36149E08;
	Thu, 25 Apr 2024 20:32:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1B149DFF;
	Thu, 25 Apr 2024 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077140; cv=none; b=sC3sIaSR22fsF2echLpmH2XAjhvQuUmBEBHFrOUkA9IMZTlSZ5LVFf5432p1tA30H7xxkmTReuweDGMoaHStgthHOt4r5acUGp0Rc074xo7elmWhloOKbaqRUtO3EpZaqSv7kJP6fu5+n4mAUq4YxAk/u107YLvB/yoTDuGg0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077140; c=relaxed/simple;
	bh=lZDbBxjGZfs9rBbh0vrUnDCzgU4uM7yQJ9gStTjQWWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjE3iX/MeYFSxXsJO4clkSoSLjze1+fuW7dVfP+LDKUfhfvXjl0lN3vosXI54Gc5ddsDEIJDcFurTiRxbwK/3BqB0J9J3QA6IlWhCQzdkmSvoyiw2hzg7tfop9zyQMe8ADHV39m+W8GNK+xHk9zdNKJa5lt+fQl8OodjL6j1C/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 160E72F;
	Thu, 25 Apr 2024 13:32:44 -0700 (PDT)
Received: from [192.168.33.11] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFA823F793;
	Thu, 25 Apr 2024 13:32:14 -0700 (PDT)
Message-ID: <ebdd1099-161c-4d70-bd8f-8763b863e2ad@arm.com>
Date: Thu, 25 Apr 2024 21:32:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] thermal/debugfs: Pass cooling device state to
 thermal_debug_cdev_add()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <3297002.44csPzL39Z@kreacher> <1968232.PYKUYFuaPT@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1968232.PYKUYFuaPT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 15:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If cdev_dt_seq_show() runs before the first state transition of a cooling
> device, it will not print any state residency information for it, even
> though it might be reasonably expected to print residency information for
> the initial state of the cooling device.
> 
> For this reason, rearrange the code to get the initial state of a cooling
> device at the registration time and pass it to thermal_debug_cdev_add(),
> so that the latter can create a duration record for that state which will
> allow cdev_dt_seq_show() to print its residency information.
> 
> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c    |    9 +++++++--
>   drivers/thermal/thermal_debugfs.c |   12 ++++++++++--
>   drivers/thermal/thermal_debugfs.h |    4 ++--
>   3 files changed, 19 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -935,6 +935,7 @@ __thermal_cooling_device_register(struct
>   {
>   	struct thermal_cooling_device *cdev;
>   	struct thermal_zone_device *pos = NULL;
> +	unsigned long current_state;
>   	int id, ret;
>   
>   	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> @@ -972,6 +973,10 @@ __thermal_cooling_device_register(struct
>   	if (ret)
>   		goto out_cdev_type;
>   
> +	ret = cdev->ops->get_cur_state(cdev, &current_state);
> +	if (ret)
> +		goto out_cdev_type;
> +
>   	thermal_cooling_device_setup_sysfs(cdev);
>   
>   	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> @@ -985,6 +990,8 @@ __thermal_cooling_device_register(struct
>   		return ERR_PTR(ret);
>   	}
>   
> +	thermal_debug_cdev_add(cdev, current_state);
> +
>   	/* Add 'this' new cdev to the global cdev list */
>   	mutex_lock(&thermal_list_lock);
>   
> @@ -1000,8 +1007,6 @@ __thermal_cooling_device_register(struct
>   
>   	mutex_unlock(&thermal_list_lock);
>   
> -	thermal_debug_cdev_add(cdev);
> -
>   	return cdev;
>   
>   out_cooling_dev:
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -466,8 +466,9 @@ void thermal_debug_cdev_state_update(con
>    * Allocates a cooling device object for debug, initializes the
>    * statistics and create the entries in sysfs.
>    * @cdev: a pointer to a cooling device
> + * @state: current state of the cooling device
>    */
> -void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
> +void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state)
>   {
>   	struct thermal_debugfs *thermal_dbg;
>   	struct cdev_debugfs *cdev_dbg;
> @@ -484,9 +485,16 @@ void thermal_debug_cdev_add(struct therm
>   		INIT_LIST_HEAD(&cdev_dbg->durations[i]);
>   	}
>   
> -	cdev_dbg->current_state = 0;
> +	cdev_dbg->current_state = state;
>   	cdev_dbg->timestamp = ktime_get();
>   
> +	/*
> +	 * Create a record for the initial cooling device state, so its
> +	 * duration will be printed by cdev_dt_seq_show() as expected if it
> +	 * runs before the first state transition.
> +	 */
> +	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations, state);
> +
>   	debugfs_create_file("trans_table", 0400, thermal_dbg->d_top,
>   			    thermal_dbg, &tt_fops);
>   
> Index: linux-pm/drivers/thermal/thermal_debugfs.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.h
> +++ linux-pm/drivers/thermal/thermal_debugfs.h
> @@ -2,7 +2,7 @@
>   
>   #ifdef CONFIG_THERMAL_DEBUGFS
>   void thermal_debug_init(void);
> -void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
> +void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state);
>   void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
>   void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
>   void thermal_debug_tz_add(struct thermal_zone_device *tz);
> @@ -14,7 +14,7 @@ void thermal_debug_tz_trip_down(struct t
>   void thermal_debug_update_trip_stats(struct thermal_zone_device *tz);
>   #else
>   static inline void thermal_debug_init(void) {}
> -static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
> +static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state) {}
>   static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev) {}
>   static inline void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
>   						   int state) {}
> 
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

