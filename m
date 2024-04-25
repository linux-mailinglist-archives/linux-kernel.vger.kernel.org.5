Return-Path: <linux-kernel+bounces-159296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B99A8B2CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D98E1C20E21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C48174ED1;
	Thu, 25 Apr 2024 22:05:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A0C15665A;
	Thu, 25 Apr 2024 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082713; cv=none; b=pqF9ZCaPrBXjtngELU50XdW745AhdT0b2Y2xbvIjn2Q2Mwd91D/zjfKZsTehxxwcsJ2ZhjKiXVJaC4/45DXyzmccjB3qMZybi9ACd1+aCPOaYpdzOAJw0fZuFBzEo78buQ14B5nIGR1/KaB13c+YmtJ5UfEKcLHDHTLr6q2fHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082713; c=relaxed/simple;
	bh=rzOpat6m+ksSiEzPcmXF9k/1yjbfIuVAexjK08+zs2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoDAbehfQXQXQA2XYYAPqVBMvoJZiTEoFaVGSptL2DofDgCS19g/qnaWTxVjMiuhcsaMtjjOegSf/UOPG63Zqb239HxXZSqBuuWH3LopZ9EarHsxXOa4+nc5wM6NDdO2Zt0yV3hdJB7TpH8ZhqgrV8ZfZ6n9W1biFQE1S444aK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 568602F;
	Thu, 25 Apr 2024 15:05:38 -0700 (PDT)
Received: from [10.57.64.58] (unknown [10.57.64.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1993F3F73F;
	Thu, 25 Apr 2024 15:05:08 -0700 (PDT)
Message-ID: <cf03d58a-93ad-46ce-bd59-8fbae3c311b2@arm.com>
Date: Thu, 25 Apr 2024 23:05:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal/debugfs: Prevent use-after-free from
 occurring after cdev removal
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <12427744.O9o76ZdvQC@kreacher> <13503555.uLZWGnKmhe@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <13503555.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 14:57, Rafael J. Wysocki wrote:
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
> same time in two differet threads) and its reset to NULL.

s/differet/different/

> 
> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
> Cc :6.8+ <stable@vger.kernel.org> # 6.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_debugfs.c |   10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -503,15 +503,21 @@ void thermal_debug_cdev_add(struct therm
>    */
>   void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
>   {
> -	struct thermal_debugfs *thermal_dbg = cdev->debugfs;
> +	struct thermal_debugfs *thermal_dbg;
>   
> +	mutex_lock(&cdev->lock);
> +
> +	thermal_dbg = cdev->debugfs;
>   	if (!thermal_dbg)

mutex_unlock(&cdev->lock) missing here

>   		return;
>   
> +	cdev->debugfs = NULL;
> +
> +	mutex_unlock(&cdev->lock);
> +
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

