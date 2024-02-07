Return-Path: <linux-kernel+bounces-56323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED58784C8B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBAFB228F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8845510788;
	Wed,  7 Feb 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nK74E9dF"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908214266
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301910; cv=none; b=USHmO5HvG0SpnLDsG+6I43lpWPE+kYdqx6ajljn4XIsbDA56EZEEnnxCHE3x8ckrTTPQW7nNd3ii8SCUtU+lPRVDRTTmO3jtmWdE4ErTHk1kZuxc57FfruHV7bSWw6DQhuO9n0tU/nMkxrt9/aFyaXeVCxhm0Jgrzen+yebVyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301910; c=relaxed/simple;
	bh=PVWoXOnA1/nbNr+rQEqzlHt08VDAFLGXRyhrDNBBl6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OsFrIPqNViF0JU3fbh6tX3H1HoJ82+4B0dhNY0IA6OSj1AUg0KDVxz07RS6QPGLYa5DxchAbK8+mqo/IjaZWTZ6j61Ar5ylQQy2u41XaaDKnpG1E97FBGdJ9YWBMKV2yjkKjHJG6vIpU88dFEL5CtcwoUimRruQSQ0CNt0Ug5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nK74E9dF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240207103145euoutp015039288e7fdfc2bd4f426331fa0835f7~xjgmBseEE2507025070euoutp01T
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:31:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240207103145euoutp015039288e7fdfc2bd4f426331fa0835f7~xjgmBseEE2507025070euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707301905;
	bh=8LAzUIgW1zL1oI/Y5Dux+SHod072J135K8NLuj0Toek=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nK74E9dFvfZzrQtAZeZBu7xXIP2IIFkXFZ/PeNOBeg6N5R4YYzTVVYg2pzeMfxt0k
	 5BzANSRddk/ZmKiSvdlh0m693WQEW9b74ZZc/laFFNQMAjHgzYY+kQTbAcZMJGDjX1
	 LlO1eUMuRYGBO5nPRrHVO3MNRPINjN8zpGdJ4m7Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240207103144eucas1p2a8eede5b3a17ac75cd18d5e9c919ab10~xjglwHoeT2839828398eucas1p21;
	Wed,  7 Feb 2024 10:31:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 2C.F2.09814.01C53C56; Wed,  7
	Feb 2024 10:31:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240207103144eucas1p16b601a73ff347d2542f8380b25921491~xjglYjn182474124741eucas1p1J;
	Wed,  7 Feb 2024 10:31:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240207103144eusmtrp1a440aead32b1246489f92a31229f5eab~xjglX5Itp0507405074eusmtrp1X;
	Wed,  7 Feb 2024 10:31:44 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-b9-65c35c1009c7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.A3.09146.01C53C56; Wed,  7
	Feb 2024 10:31:44 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240207103143eusmtip2da7dc17b938caad9d40e826aa521b629~xjgkkXwXC1965719657eusmtip2T;
	Wed,  7 Feb 2024 10:31:43 +0000 (GMT)
Message-ID: <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
Date: Wed, 7 Feb 2024 11:31:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tejun Heo
	<tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <10423008.nUPlyArG6x@kreacher>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7oCMYdTDfY2mVhMXbubyWLfxTVs
	Fpd3zWGz+Nx7hNFi4vHNrBbtK5+yWZw5fYnV4uOeDYwWv5YfZbQ4vjbcgctj56y77B6bVnWy
	edy5tofNY97JQI9zFys8tlxtZ/H4vEnOo/1AN1MARxSXTUpqTmZZapG+XQJXxsRVq9kK2oIr
	uttfMDUwXnLsYuTkkBAwkXi2ah4biC0ksIJR4vRPgy5GLiD7C6PE1+cdUInPjBLTH4TANMy+
	+4ENomg5o8Sz61fZIZyPjBK7965m7GLk4OAVsJN48LcMpIFFQEXi0ZEXzCA2r4CgxMmZT1hA
	bFEBeYn7t2awg9jCAiESr88eZQWZIyKwh1Hi76ErYBuYBbYxSvz6fw3sDGYBcYlbT+Yzgdhs
	AoYSXW+7wOKcAtoSrRd2QtXIS2x/O4cZpFlCYDKnxKa2rWAXSQi4SGy67ArxgrDEq+Nb2CFs
	GYnTk3tYIOrbGSUW/L7PBOFMYJRoeH6LEaLKWuLOuV9sIIOYBTQl1u/Shwg7SrQu2cAKMZ9P
	4sZbQYgb+CQmbZvODBHmlehoE4KoVpOYdXwd3NqDFy4xT2BUmoUULrOQfDkLyTezEPYuYGRZ
	xSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZi4Tv87/mUH4/JXH/UOMTJxMB5ilOBgVhLh
	NdtxIFWINyWxsiq1KD++qDQntfgQozQHi5I4r2qKfKqQQHpiSWp2ampBahFMlomDU6qBqUwl
	T+OUR+wr8fd79vyOeP145gxb7wgTF1Mb0+qMuxNNJxhrf7wU9J/v6MZ8ic1PzvXMjP62T7Dm
	sGv4pn1LJQLXS65kOvz8/eLHroE7lCrS1CaevOO3fwkvR0BE5bxKK26Oohl2Sj8uM0x0bXW5
	dkvvWcjP32GvRP5Pcn93TIDnk7vfUf89m0oeplzykly6SqifI9BMSZXHY9HBddcK1XfF/vs3
	+cxRO8OdWxX23r3y4Nuui4K39wlyCgQopc+6uWf63fj+bWV36zZzWgQV8XQ35IoZmB2PCl3D
	ad5a+v57b+Lk2f9b9yqLRN6Lal5yd7mp0ePlv6plmN81TBFY9a4hWoJF9KDEpJnr/+hMrFJi
	Kc5INNRiLipOBAAPTt+vywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7oCMYdTDZ7PlLGYunY3k8W+i2vY
	LC7vmsNm8bn3CKPFxOObWS3aVz5lszhz+hKrxcc9Gxgtfi0/ymhxfG24A5fHzll32T02repk
	87hzbQ+bx7yTgR7nLlZ4bLnazuLxeZOcR/uBbqYAjig9m6L80pJUhYz84hJbpWhDCyM9Q0sL
	PSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jImrVrMVtAVXdLe/YGpgvOTYxcjJISFgIjH7
	7ge2LkYuDiGBpYwSEzYsZINIyEicnNbACmELS/y51gVV9J5R4kLjesYuRg4OXgE7iQd/y0Bq
	WARUJB4decEMYvMKCEqcnPmEBcQWFZCXuH9rBjuILSwQIvH67FFWkDkiAnsYJdZcPccE4jAL
	7GCUuNt3FaxKSEBL4uHrz2CbmQXEJW49mc8EYrMJGEp0ve0Cu45TQFui9cJONogaM4murV2M
	ELa8xPa3c5gnMArNQnLILCSjZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA
	aN127OfmHYzzXn3UO8TIxMF4iFGCg1lJhNdsx4FUId6UxMqq1KL8+KLSnNTiQ4ymwNCYyCwl
	mpwPTBd5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MB/6wpR8v
	4bmZOun0seKMW9+cV/Cc51OvjWxiKvMOvrg5doGLlG1J5oNL/O3C7REr9n1+OHVjklqp/aEp
	RjulJY1Ffx7YxTo1pnR6ybxvX1dw2nUJzqubLrdyns8b8Svenw/nxEi1nF3nJ6G27WT8XoGt
	E2KuPPGQEe+bcziD5febqIWnW2483z43N+ptiNsEb5P0r9Mud3F8m7464tultlPzvjwXM5z7
	VjYg9SLD0R9Ts5yad6ZF/87OO73r3VvvG192zzHp12m/y64Rk/dy59vinLQ3uwzLbwT4mU15
	sHnlgdr9cmdiPJNsdC4uS2r1PXzu1KFfVZFnjpWwK38N0b21NnfvpnrF6PkhVXnXZymxFGck
	GmoxFxUnAgAyEgOkXwMAAA==
X-CMS-MailID: 20240207103144eucas1p16b601a73ff347d2542f8380b25921491
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240207103144eucas1p16b601a73ff347d2542f8380b25921491
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240207103144eucas1p16b601a73ff347d2542f8380b25921491
References: <10423008.nUPlyArG6x@kreacher>
	<CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>

Dear All,

On 09.01.2024 17:59, Rafael J. Wysocki wrote:
>   From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
> system-wide PM code"), the resume of devices that were allowed to resume
> asynchronously was scheduled before starting the resume of the other
> devices, so the former did not have to wait for the latter unless
> functional dependencies were present.
>
> Commit 7839d0078e0d removed that optimization in order to address a
> correctness issue, but it can be restored with the help of a new device
> power management flag, so do that now.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

This patch finally landed in linux-next some time ago as 3e999770ac1c 
("PM: sleep: Restore asynchronous device resume optimization"). Recently 
I found that it causes a non-trivial interaction with commit 
5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement 
for unbound workqueues"). Since merge commit 954350a5f8db in linux-next 
system suspend/resume fails (board doesn't wake up) on my old Samsung 
Exynos4412-based Odroid-U3 board (ARM 32bit based), which was rock 
stable for last years.

My further investigations confirmed that the mentioned commits are 
responsible for this issue. Each of them separately (3e999770ac1c and 
5797b1c18919) doesn't trigger any problems. Reverting any of them on top 
of linux-next (with some additional commit due to code dependencies) 
also fixes/hides the problem.

Let me know if You need more information or tests on the hardware. I'm 
open to help debugging this issue.

> I said I'd probably do this in 6.9, but then I thought more about it
> and now I think it would be nice to have 6.8-rc1 without a suspend
> performance regression and the change is relatively straightforward,
> so here it goes.
>
> ---
>   drivers/base/power/main.c |  117 +++++++++++++++++++++++++---------------------
>   include/linux/pm.h        |    1
>   2 files changed, 65 insertions(+), 53 deletions(-)
>
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -681,6 +681,7 @@ struct dev_pm_info {
>   	bool			wakeup_path:1;
>   	bool			syscore:1;
>   	bool			no_pm_callbacks:1;	/* Owned by the PM core */
> +	bool			in_progress:1;	/* Owned by the PM core */
>   	unsigned int		must_resume:1;	/* Owned by the PM core */
>   	unsigned int		may_skip_resume:1;	/* Set by subsystems */
>   #else
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -579,7 +579,7 @@ bool dev_pm_skip_resume(struct device *d
>   }
>   
>   /**
> - * __device_resume_noirq - Execute a "noirq resume" callback for given device.
> + * device_resume_noirq - Execute a "noirq resume" callback for given device.
>    * @dev: Device to handle.
>    * @state: PM transition of the system being carried out.
>    * @async: If true, the device is being resumed asynchronously.
> @@ -587,7 +587,7 @@ bool dev_pm_skip_resume(struct device *d
>    * The driver of @dev will not receive interrupts while this function is being
>    * executed.
>    */
> -static void __device_resume_noirq(struct device *dev, pm_message_t state, bool async)
> +static void device_resume_noirq(struct device *dev, pm_message_t state, bool async)
>   {
>   	pm_callback_t callback = NULL;
>   	const char *info = NULL;
> @@ -674,16 +674,22 @@ static bool dpm_async_fn(struct device *
>   {
>   	reinit_completion(&dev->power.completion);
>   
> -	if (!is_async(dev))
> -		return false;
> +	if (is_async(dev)) {
> +		dev->power.in_progress = true;
>   
> -	get_device(dev);
> -
> -	if (async_schedule_dev_nocall(func, dev))
> -		return true;
> +		get_device(dev);
>   
> -	put_device(dev);
> +		if (async_schedule_dev_nocall(func, dev))
> +			return true;
>   
> +		put_device(dev);
> +	}
> +	/*
> +	 * Because async_schedule_dev_nocall() above has returned false or it
> +	 * has not been called at all, func() is not running and it safe to
> +	 * update the in_progress flag without additional synchronization.
> +	 */
> +	dev->power.in_progress = false;
>   	return false;
>   }
>   
> @@ -691,18 +697,10 @@ static void async_resume_noirq(void *dat
>   {
>   	struct device *dev = data;
>   
> -	__device_resume_noirq(dev, pm_transition, true);
> +	device_resume_noirq(dev, pm_transition, true);
>   	put_device(dev);
>   }
>   
> -static void device_resume_noirq(struct device *dev)
> -{
> -	if (dpm_async_fn(dev, async_resume_noirq))
> -		return;
> -
> -	__device_resume_noirq(dev, pm_transition, false);
> -}
> -
>   static void dpm_noirq_resume_devices(pm_message_t state)
>   {
>   	struct device *dev;
> @@ -712,18 +710,28 @@ static void dpm_noirq_resume_devices(pm_
>   	mutex_lock(&dpm_list_mtx);
>   	pm_transition = state;
>   
> +	/*
> +	 * Trigger the resume of "async" devices upfront so they don't have to
> +	 * wait for the "non-async" ones they don't depend on.
> +	 */
> +	list_for_each_entry(dev, &dpm_noirq_list, power.entry)
> +		dpm_async_fn(dev, async_resume_noirq);
> +
>   	while (!list_empty(&dpm_noirq_list)) {
>   		dev = to_device(dpm_noirq_list.next);
> -		get_device(dev);
>   		list_move_tail(&dev->power.entry, &dpm_late_early_list);
>   
> -		mutex_unlock(&dpm_list_mtx);
> +		if (!dev->power.in_progress) {
> +			get_device(dev);
>   
> -		device_resume_noirq(dev);
> +			mutex_unlock(&dpm_list_mtx);
>   
> -		put_device(dev);
> +			device_resume_noirq(dev, state, false);
> +
> +			put_device(dev);
>   
> -		mutex_lock(&dpm_list_mtx);
> +			mutex_lock(&dpm_list_mtx);
> +		}
>   	}
>   	mutex_unlock(&dpm_list_mtx);
>   	async_synchronize_full();
> @@ -747,14 +755,14 @@ void dpm_resume_noirq(pm_message_t state
>   }
>   
>   /**
> - * __device_resume_early - Execute an "early resume" callback for given device.
> + * device_resume_early - Execute an "early resume" callback for given device.
>    * @dev: Device to handle.
>    * @state: PM transition of the system being carried out.
>    * @async: If true, the device is being resumed asynchronously.
>    *
>    * Runtime PM is disabled for @dev while this function is being executed.
>    */
> -static void __device_resume_early(struct device *dev, pm_message_t state, bool async)
> +static void device_resume_early(struct device *dev, pm_message_t state, bool async)
>   {
>   	pm_callback_t callback = NULL;
>   	const char *info = NULL;
> @@ -820,18 +828,10 @@ static void async_resume_early(void *dat
>   {
>   	struct device *dev = data;
>   
> -	__device_resume_early(dev, pm_transition, true);
> +	device_resume_early(dev, pm_transition, true);
>   	put_device(dev);
>   }
>   
> -static void device_resume_early(struct device *dev)
> -{
> -	if (dpm_async_fn(dev, async_resume_early))
> -		return;
> -
> -	__device_resume_early(dev, pm_transition, false);
> -}
> -
>   /**
>    * dpm_resume_early - Execute "early resume" callbacks for all devices.
>    * @state: PM transition of the system being carried out.
> @@ -845,18 +845,28 @@ void dpm_resume_early(pm_message_t state
>   	mutex_lock(&dpm_list_mtx);
>   	pm_transition = state;
>   
> +	/*
> +	 * Trigger the resume of "async" devices upfront so they don't have to
> +	 * wait for the "non-async" ones they don't depend on.
> +	 */
> +	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
> +		dpm_async_fn(dev, async_resume_early);
> +
>   	while (!list_empty(&dpm_late_early_list)) {
>   		dev = to_device(dpm_late_early_list.next);
> -		get_device(dev);
>   		list_move_tail(&dev->power.entry, &dpm_suspended_list);
>   
> -		mutex_unlock(&dpm_list_mtx);
> +		if (!dev->power.in_progress) {
> +			get_device(dev);
>   
> -		device_resume_early(dev);
> +			mutex_unlock(&dpm_list_mtx);
>   
> -		put_device(dev);
> +			device_resume_early(dev, state, false);
> +
> +			put_device(dev);
>   
> -		mutex_lock(&dpm_list_mtx);
> +			mutex_lock(&dpm_list_mtx);
> +		}
>   	}
>   	mutex_unlock(&dpm_list_mtx);
>   	async_synchronize_full();
> @@ -876,12 +886,12 @@ void dpm_resume_start(pm_message_t state
>   EXPORT_SYMBOL_GPL(dpm_resume_start);
>   
>   /**
> - * __device_resume - Execute "resume" callbacks for given device.
> + * device_resume - Execute "resume" callbacks for given device.
>    * @dev: Device to handle.
>    * @state: PM transition of the system being carried out.
>    * @async: If true, the device is being resumed asynchronously.
>    */
> -static void __device_resume(struct device *dev, pm_message_t state, bool async)
> +static void device_resume(struct device *dev, pm_message_t state, bool async)
>   {
>   	pm_callback_t callback = NULL;
>   	const char *info = NULL;
> @@ -975,18 +985,10 @@ static void async_resume(void *data, asy
>   {
>   	struct device *dev = data;
>   
> -	__device_resume(dev, pm_transition, true);
> +	device_resume(dev, pm_transition, true);
>   	put_device(dev);
>   }
>   
> -static void device_resume(struct device *dev)
> -{
> -	if (dpm_async_fn(dev, async_resume))
> -		return;
> -
> -	__device_resume(dev, pm_transition, false);
> -}
> -
>   /**
>    * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
>    * @state: PM transition of the system being carried out.
> @@ -1006,16 +1008,25 @@ void dpm_resume(pm_message_t state)
>   	pm_transition = state;
>   	async_error = 0;
>   
> +	/*
> +	 * Trigger the resume of "async" devices upfront so they don't have to
> +	 * wait for the "non-async" ones they don't depend on.
> +	 */
> +	list_for_each_entry(dev, &dpm_suspended_list, power.entry)
> +		dpm_async_fn(dev, async_resume);
> +
>   	while (!list_empty(&dpm_suspended_list)) {
>   		dev = to_device(dpm_suspended_list.next);
>   
>   		get_device(dev);
>   
> -		mutex_unlock(&dpm_list_mtx);
> +		if (!dev->power.in_progress) {
> +			mutex_unlock(&dpm_list_mtx);
>   
> -		device_resume(dev);
> +			device_resume(dev, state, false);
>   
> -		mutex_lock(&dpm_list_mtx);
> +			mutex_lock(&dpm_list_mtx);
> +		}
>   
>   		if (!list_empty(&dev->power.entry))
>   			list_move_tail(&dev->power.entry, &dpm_prepared_list);
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


