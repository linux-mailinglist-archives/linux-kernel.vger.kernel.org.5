Return-Path: <linux-kernel+bounces-159294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956358B2CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52051287EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2A16F836;
	Thu, 25 Apr 2024 22:02:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB93153BD7;
	Thu, 25 Apr 2024 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082566; cv=none; b=ZLePe4Zxa81V8a/Z4k59SP6Ix9TlewNK4paZ851RTOxF9sS/INNpzzBZLSjSGq3Ss1DsYD7nj9mUwBeo6ScIqWqeEOJqlVZKGhKTOuUn5pmAwEMUR9DaCjP8luN46IUulNxB/vRtl4Dv6Z6H7tH8V86iYGW1MkvU40DnD03aexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082566; c=relaxed/simple;
	bh=MF7/MmMr8a4nNSERUdc/jjo1OcVPHWAGSNEofngKwPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFB/l0C6jZz9YIDIB3HJpR/BM4cUdObOO0C/cH+/x0bj36SwsENIKpjDeizVcDmJnD8bFBBP4sSNUC28d6ZXxSsIwQjEhFyquEUWSu7suK69Tx3hrMheuS6eiU3/sE07+i/yNP4Is1hsMp2zzTO1IYzQfy46RED5haiXHEKu9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 149CC2F;
	Thu, 25 Apr 2024 15:03:08 -0700 (PDT)
Received: from [10.57.64.58] (unknown [10.57.64.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC46B3F73F;
	Thu, 25 Apr 2024 15:02:38 -0700 (PDT)
Message-ID: <fb4e29fa-36e4-45ff-979b-2497ec3d946b@arm.com>
Date: Thu, 25 Apr 2024 23:02:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal/debugfs: Free all thermal zone debug
 memory on zone removal
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <12427744.O9o76ZdvQC@kreacher> <4918398.31r3eYUQgx@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4918398.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 14:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal_debug_tz_remove() does not free all memory allocated for
> thermal zone diagnostics, some of that memory becomes unreachable after
> freeing the thermal zone's struct thermal_debugfs object.
> 
> Address this by making thermal_debug_tz_remove() free all of the memory
> in question.
> 
> Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
> Cc :6.8+ <stable@vger.kernel.org> # 6.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_debugfs.c |   13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -832,15 +832,28 @@ void thermal_debug_tz_add(struct thermal
>   void thermal_debug_tz_remove(struct thermal_zone_device *tz)
>   {
>   	struct thermal_debugfs *thermal_dbg = tz->debugfs;
> +	struct tz_episode *tze, *tmp;
> +	struct tz_debugfs *tz_dbg;
> +	int *trips_crossed;
>   
>   	if (!thermal_dbg)
>   		return;
>   
> +	tz_dbg = &thermal_dbg->tz_dbg;
> +
>   	mutex_lock(&thermal_dbg->lock);
>   
> +	trips_crossed = tz_dbg->trips_crossed;
> +
> +	list_for_each_entry_safe(tze, tmp, &tz_dbg->tz_episodes, node) {
> +		list_del(&tze->node);
> +		kfree(tze);
> +	}
> +
>   	tz->debugfs = NULL;
>   
>   	mutex_unlock(&thermal_dbg->lock);
>   
>   	thermal_debugfs_remove_id(thermal_dbg);
> +	kfree(trips_crossed);
>   }
> 
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

