Return-Path: <linux-kernel+bounces-159317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E68B2CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78240282802
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7065B155A2A;
	Thu, 25 Apr 2024 22:20:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2214E2F9;
	Thu, 25 Apr 2024 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083611; cv=none; b=iWisI97QWzf9vPjsM/DLzoBbYJSpVDdql7TZId53uqhvcuIq5vX1to4beucBQtVHLOhelhd3icMHsJltlBoedt9QNO9hRqP23IzhY2yP7zKtuwvA3XbVIHCBaNpCyxc8b/DdzwJGNrONZN/rFgIzuAVdhd0hQsgZUu/VLxZrUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083611; c=relaxed/simple;
	bh=96H6oEfq/zzDR6wsjlZKTS8AvuLISoBullwt3a2u8/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCF8qjJjMJ8MVP9W1su2/jHj1ARriny9NNwnYjYfDkPE6rvThbbLQt7V6SShUFfT3o7DvO4BEZ48XqaqXSKtU7kVkQfiwtMbwBtVyNUDt5yrpGURDSnzmTttGixvur/9r1LuOkrXZ8FMWer6ey3ZjzERYFKFEvD8oBK+qBmOGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B697F2F;
	Thu, 25 Apr 2024 15:20:36 -0700 (PDT)
Received: from [10.57.64.58] (unknown [10.57.64.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E7433F73F;
	Thu, 25 Apr 2024 15:20:07 -0700 (PDT)
Message-ID: <f2f9b94d-e351-482b-a1ee-fdabb847094a@arm.com>
Date: Thu, 25 Apr 2024 23:20:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Alternative][PATCH v1 2/3] thermal/debugfs: Fix two locking
 issues with thermal zone debug
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <12427744.O9o76ZdvQC@kreacher> <1888579.tdWV9SEqCh@kreacher>
 <5780690.DvuYhMxLoT@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5780690.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 16:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> With the current thermal zone locking arrangement in the debugfs code,
> user space can open the "mitigations" file for a thermal zone before
> the zone's debugfs pointer is set which will result in a NULL pointer
> dereference in tze_seq_start().
> 
> Moreover, thermal_debug_tz_remove() is not called under the thermal
> zone lock, so can run in parallel with the other functions accessing
> the thermal zone's struct thermal_debugfs object.  Then, it may clear
> tz->debugfs after one of those functions has checked it and the
> struct thermal_debugfs object may be freed prematurely.
> 
> To address the first problem, pass a pointer to the thermal zone's
> struct thermal_debugfs object to debugfs_create_file() in
> thermal_debug_tz_add() and make tze_seq_start(), tze_seq_next(),
> tze_seq_stop(), and tze_seq_show() retrieve it from s->private
> instead of a pointer to the thermal zone object.  This will ensure
> that tz_debugfs will be valid across the "mitigations" file accesses
> until thermal_debugfs_remove_id() called by thermal_debug_tz_remove()
> removes that file.
> 
> To address the second problem, use tz->lock in thermal_debug_tz_remove()
> around the tz->debugfs value check (in case the same thermal zone is
> removed at the same time in two differet threads) and its reset to NULL.

s/differet/different/

> 
> Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
> Cc :6.8+ <stable@vger.kernel.org> # 6.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is an alternative fix for the issues addressed by
> 
> https://lore.kernel.org/linux-pm/1888579.tdWV9SEqCh@kreacher/
> 
> and I slightly prefer it, because it is less intrusive and makes
> the thermal zone debug code more consistent with the analogous code
> for cdevs.

I also prefer this one.

> 
> Accordingly, I've replace the above with this patch in the
> thermal-core-next branch in linux-pm.git.
> 
> ---
>   drivers/thermal/thermal_debugfs.c |   34 ++++++++++++++++++++++------------
>   1 file changed, 22 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -139,11 +139,13 @@ struct tz_episode {
>    * we keep track of the current position in the history array.
>    *
>    * @tz_episodes: a list of thermal mitigation episodes
> + * @tz: thermal zone this object belongs to
>    * @trips_crossed: an array of trip points crossed by id
>    * @nr_trips: the number of trip points currently being crossed
>    */
>   struct tz_debugfs {
>   	struct list_head tz_episodes;
> +	struct thermal_zone_device *tz;
>   	int *trips_crossed;
>   	int nr_trips;
>   };
> @@ -710,8 +712,7 @@ out:
>   
>   static void *tze_seq_start(struct seq_file *s, loff_t *pos)
>   {
> -	struct thermal_zone_device *tz = s->private;
> -	struct thermal_debugfs *thermal_dbg = tz->debugfs;
> +	struct thermal_debugfs *thermal_dbg = s->private;
>   	struct tz_debugfs *tz_dbg = &thermal_dbg->tz_dbg;
>   
>   	mutex_lock(&thermal_dbg->lock);
> @@ -721,8 +722,7 @@ static void *tze_seq_start(struct seq_fi
>   
>   static void *tze_seq_next(struct seq_file *s, void *v, loff_t *pos)
>   {
> -	struct thermal_zone_device *tz = s->private;
> -	struct thermal_debugfs *thermal_dbg = tz->debugfs;
> +	struct thermal_debugfs *thermal_dbg = s->private;
>   	struct tz_debugfs *tz_dbg = &thermal_dbg->tz_dbg;
>   
>   	return seq_list_next(v, &tz_dbg->tz_episodes, pos);
> @@ -730,15 +730,15 @@ static void *tze_seq_next(struct seq_fil
>   
>   static void tze_seq_stop(struct seq_file *s, void *v)
>   {
> -	struct thermal_zone_device *tz = s->private;
> -	struct thermal_debugfs *thermal_dbg = tz->debugfs;
> +	struct thermal_debugfs *thermal_dbg = s->private;
>   
>   	mutex_unlock(&thermal_dbg->lock);
>   }
>   
>   static int tze_seq_show(struct seq_file *s, void *v)
>   {
> -	struct thermal_zone_device *tz = s->private;
> +	struct thermal_debugfs *thermal_dbg = s->private;
> +	struct thermal_zone_device *tz = thermal_dbg->tz_dbg.tz;
>   	struct thermal_trip_desc *td;
>   	struct tz_episode *tze;
>   	const char *type;
> @@ -816,6 +816,8 @@ void thermal_debug_tz_add(struct thermal
>   
>   	tz_dbg = &thermal_dbg->tz_dbg;
>   
> +	tz_dbg->tz = tz;
> +
>   	tz_dbg->trips_crossed = kzalloc(sizeof(int) * tz->num_trips, GFP_KERNEL);
>   	if (!tz_dbg->trips_crossed) {
>   		thermal_debugfs_remove_id(thermal_dbg);
> @@ -824,20 +826,30 @@ void thermal_debug_tz_add(struct thermal
>   
>   	INIT_LIST_HEAD(&tz_dbg->tz_episodes);
>   
> -	debugfs_create_file("mitigations", 0400, thermal_dbg->d_top, tz, &tze_fops);
> +	debugfs_create_file("mitigations", 0400, thermal_dbg->d_top,
> +			    thermal_dbg, &tze_fops);
>   
>   	tz->debugfs = thermal_dbg;
>   }
>   
>   void thermal_debug_tz_remove(struct thermal_zone_device *tz)
>   {
> -	struct thermal_debugfs *thermal_dbg = tz->debugfs;
> +	struct thermal_debugfs *thermal_dbg;
>   	struct tz_episode *tze, *tmp;
>   	struct tz_debugfs *tz_dbg;
>   	int *trips_crossed;
>   
> -	if (!thermal_dbg)
> +	mutex_lock(&tz->lock);
> +
> +	thermal_dbg = tz->debugfs;
> +	if (!thermal_dbg) {
> +		mutex_unlock(&tz->lock);
>   		return;
> +	}
> +
> +	tz->debugfs = NULL;
> +
> +	mutex_unlock(&tz->lock);
>   
>   	tz_dbg = &thermal_dbg->tz_dbg;
>   
> @@ -850,8 +862,6 @@ void thermal_debug_tz_remove(struct ther
>   		kfree(tze);
>   	}
>   
> -	tz->debugfs = NULL;
> -
>   	mutex_unlock(&thermal_dbg->lock);
>   
>   	thermal_debugfs_remove_id(thermal_dbg);
> 
> 
> 

LGTM, with that minor spelling fixed:

Reviewed-by: Lukasz Luba <lukasz.luba@arm..com>

