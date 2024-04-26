Return-Path: <linux-kernel+bounces-159798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9669A8B3437
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4CB287782
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8149813F444;
	Fri, 26 Apr 2024 09:36:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1813DDD5;
	Fri, 26 Apr 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124162; cv=none; b=rRMMjeNSCpQ/V+lypd4hR+3qAvHISCuhW1EMT+IxKruApMWEO2Ivoc8okO+Td3RTLDUa/w5Coq10IcP2lS3JRwnmE0yJHl8gk8rKgTqL/cDuE/19MDhBtzeCevu5EZTqoyfxH9BUhe6289aBrkz/cTQzYIiqJXWiaOZqDtO4bnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124162; c=relaxed/simple;
	bh=vT9giKtFcg61enkBZkXpg92QD6V+SFbh+XlHX2mLqwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwW2fj3QGqOjwsxweXGyxOuRRn1b5ujR07l8VLLbS0Nc1RAaYF+0taUptAt/KRvqZqUf8pFPIFDBtLzSQ9Tg3cP8f1YQflKyYpWBQszdGZx0wFR7DEsnBckxeZryM9rJYspboMYmG7l//mSp/oAZLMZcVofaEZNguJQu1VIJUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B894F2F4;
	Fri, 26 Apr 2024 02:36:21 -0700 (PDT)
Received: from [10.57.66.9] (unknown [10.57.66.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B89B33F64C;
	Fri, 26 Apr 2024 02:35:52 -0700 (PDT)
Message-ID: <4416568e-79d4-465f-8d47-a199b3b69ca4@arm.com>
Date: Fri, 26 Apr 2024 10:35:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] thermal/debugfs: Prevent use-after-free from
 occurring after cdev removal
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <12427744.O9o76ZdvQC@kreacher> <13503555.uLZWGnKmhe@kreacher>
 <2740417.mvXUDI8C0e@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2740417.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/26/24 10:28, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_debug_cdev_remove() does not run under cdev->lock, it can
> run in parallel with thermal_debug_cdev_state_update() and it may free
> the struct thermal_debugfs object used by the latter after it has been
> checked against NULL.
> 
> If that happens, thermal_debug_cdev_state_update() will access memory
> that has been freed already causing the kernel to crash.
> 
> Address this by using cdev->lock in thermal_debug_cdev_remove() around
> the cdev->debugfs value check (in case the same cdev is removed at the
> same time in two different threads) and its reset to NULL.
> 
> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
> Cc :6.8+ <stable@vger.kernel.org> # 6.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Add missing mutex_unlock() (Lukasz).
> 
> ---
>   drivers/thermal/thermal_debugfs.c |   14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -505,15 +505,23 @@ void thermal_debug_cdev_add(struct therm
>    */
>   void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
>   {
> -	struct thermal_debugfs *thermal_dbg = cdev->debugfs;
> +	struct thermal_debugfs *thermal_dbg;
>   
> -	if (!thermal_dbg)
> +	mutex_lock(&cdev->lock);
> +
> +	thermal_dbg = cdev->debugfs;
> +	if (!thermal_dbg) {
> +		mutex_unlock(&cdev->lock);
>   		return;
> +	}
> +
> +	cdev->debugfs = NULL;
> +
> +	mutex_unlock(&cdev->lock);
>   
>   	mutex_lock(&thermal_dbg->lock);
>   
>   	thermal_debugfs_cdev_clear(&thermal_dbg->cdev_dbg);
> -	cdev->debugfs = NULL;
>   
>   	mutex_unlock(&thermal_dbg->lock);
>   
> 
> 
> 
> 

It looks good now

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

