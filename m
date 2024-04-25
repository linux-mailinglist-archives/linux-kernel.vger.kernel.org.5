Return-Path: <linux-kernel+bounces-159061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C78B28C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42121282CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A91514DB;
	Thu, 25 Apr 2024 19:08:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB439FCF;
	Thu, 25 Apr 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072094; cv=none; b=LHZbVzgFiXUp4jKIdWYr+VWQntKWogwcqhFFWpUGk3ERoOEHXVf9eEaC5iqqkr24Z9djEEN9C/d7d20eV0WmocT0oyS0I6eOSbzLXI7GGykodPPNFCcPfn8Ung7lxGiT7042KarQbvnP+rUkotCoRHo4UO3NBBpMgWvStHjPY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072094; c=relaxed/simple;
	bh=GzIuAu2wdC/XfK35nS2UyFarpW+pmbi1UNViZv7vvlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqfWkE6PFv6INscXwrUIQitRYd+43s4V4cgIPo9yHN6BE4BN/Z7WobG1qZuL4jvhwkvQnqm+lp9AmAbD8h1KkdihZUK56Gc4CbGiD7DuzZjsz30Bseo8mTiZ34lb5Lq0LZiux6pHwaR4WP7eJUho7YEfZtkLm33OoQOs0ODchb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47BDE2F;
	Thu, 25 Apr 2024 12:08:40 -0700 (PDT)
Received: from [10.57.75.39] (unknown [10.57.75.39])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17D6E3F793;
	Thu, 25 Apr 2024 12:08:10 -0700 (PDT)
Message-ID: <9edd1059-e9ad-466e-a302-8055a44ff56d@arm.com>
Date: Thu, 25 Apr 2024 20:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] thermal/debugfs: Create records for cdev states as
 they get used
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <3297002.44csPzL39Z@kreacher> <10458619.nUPlyArG6x@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <10458619.nUPlyArG6x@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 15:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal_debug_cdev_state_update() only creates a duration record
> for the old state of a cooling device, if its new state is used for the
> first time, there will be no record for it and cdev_dt_seq_show() will
> not print the duration information for it even though it contains code
> to compute the duration value in that case.
> 
> Address this by making thermal_debug_cdev_state_update() create a
> duration record for the new state if there is none.
> 
> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_debugfs.c |    8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -433,6 +433,14 @@ void thermal_debug_cdev_state_update(con
>   	}
>   
>   	cdev_dbg->current_state = new_state;
> +
> +	/*
> +	 * Create a record for the new state if it is not there, so its
> +	 * duration will be printed by cdev_dt_seq_show() as expected if it
> +	 * runs before the next state transition.
> +	 */
> +	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations, new_state);
> +
>   	transition = (old_state << 16) | new_state;
>   
>   	/*
> 
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

