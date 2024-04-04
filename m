Return-Path: <linux-kernel+bounces-131370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B488986D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B471C264E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4905185644;
	Thu,  4 Apr 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tT2Ue4om"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E26A005
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232584; cv=none; b=pTMzoWhZ9SfaTk3KQxBTTIEekkXUGxDfm4vsv9r+fIuboke2eyLr4seY6Ph11VljQChAobEjz5e1kBORbEKdQH9aRXRXY3MahwB7SU7QR/G6NxRr05UUBTlP5P0r0QK5dRGH26XsF8c1NjD+0k0yOC2z+M/qNTYNOlJMUyqe36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232584; c=relaxed/simple;
	bh=lYjgcmK0BVgg5XmY4N/S/JwDu8/aKtXHjENsaIYMZ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=KYpCJGeJS+xTVnFTyXuAC72CfbogEvXFG4h5s3FGVbEmRUCv0aW2D2lCAQ9QAPStDRJ8TEN3MOt6M8tEoNGL8XCHSpTloRpBo1Bxmq3yfck1RxsZDC3YxCh5hD98ZYziZwWsWVYayZBnigfdy4oeDMkQyKwRF0DZSz12J/9Rj80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tT2Ue4om; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240404120933euoutp02dee7266cf0154afdbc4964be73d6a2cc~DEnQbBCJG1652116521euoutp02W
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:09:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240404120933euoutp02dee7266cf0154afdbc4964be73d6a2cc~DEnQbBCJG1652116521euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712232573;
	bh=3EpcBq3+c9JQcVnSxOkwCiOM5/IkV2eowJ7+5oCA19A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tT2Ue4omtHAC7EGYy6tqwfsVtuSLSk0jVZZU2btt5aodP+/Lo2VoHL6rCOW4sDMT9
	 MGrFMAfQZTGPzXPWOLVaFoZGMxX5EgRyQaZSu3ZhyDFyt3wbUydZtKGf0oL6Ig+YUh
	 pY+wM0PUMnFqI0ftZKzg8TQEN9Sl91bER6M2dBXQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240404120933eucas1p1df9fb538c5af8530585e10a9214811b7~DEnQQ5tk92323523235eucas1p1N;
	Thu,  4 Apr 2024 12:09:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 1B.CF.09552.C789E066; Thu,  4
	Apr 2024 13:09:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240404120932eucas1p1b3c1e07bf6f41f6330725148b0268b13~DEnP7sI0d2323323233eucas1p1S;
	Thu,  4 Apr 2024 12:09:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240404120932eusmtrp2ae6f09a0a42ba1294d3d40c9fc8b207e~DEnP7Ib7S1847618476eusmtrp2N;
	Thu,  4 Apr 2024 12:09:32 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-27-660e987c62a7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 4D.9D.09146.C789E066; Thu,  4
	Apr 2024 13:09:32 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240404120932eusmtip1b850b2a0e3a42bb339046fd7037e0d47~DEnPijPT_2748627486eusmtip1Y;
	Thu,  4 Apr 2024 12:09:32 +0000 (GMT)
Message-ID: <5a49cadd-21b7-4384-9e7d-9105ccc288b3@samsung.com>
Date: Thu, 4 Apr 2024 14:09:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] pwm: Add more locking
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de, linux-amlogic@lists.infradead.org, LKML
	<linux-kernel@vger.kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <e36c1a44096cbd7e9cb693f2300ac12ed1b2f79d.1710670958.git.u.kleine-koenig@pengutronix.de>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOd2aGXxpBsuWWlqsmrqTxWLBbG6L
	y7vmsFncvbuK0eL2xMmMDqwem5fUe/T/NfD4vEkugDmKyyYlNSezLLVI3y6BK+P15tfMBbeK
	Kp5tn8fYwPg0rouRk0NCwERizqd5TCC2kMAKRom2NWVdjFxA9hdGidVTprBBOJ8ZJf6vmcAI
	0zH18RsWiMRyRokNv64wQTgfGSU+zutiBaniFbCTuNh0l7mLkYODRUBF4v9RU4iwoMTJmU9Y
	QGxRAXmJ+7dmsIPYwgJ6Eq/PXgeLiwgkSxw9co0VpJUZyH69WRYkzCwgLnHryXywS9kEDCW6
	3naxgdicAqkS+6c9YoOokZdo3jqbGeQcCYEtHBI3HiyAOtpFouHGQ2YIW1ji1fEt7BC2jMT/
	nfOZIBraGSUW/L4P5UxglGh4fguq21rizrlfbBAXaUqs36UPEXaUWHbyADtIWEKAT+LGW0GI
	I/gkJm2bzgwR5pXoaBOCqFaTmHV8HdzagxcuMU9gVJqFFCqzkLw5C8k7sxD2LmBkWcUonlpa
	nJueWmycl1quV5yYW1yal66XnJ+7iRGYUk7/O/51B+OKVx/1DjEycTAeYpTgYFYS4e124E0T
	4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYJrgFvH84pea
	5csYj/xuKdRdsf6unFajm2KKf9IER5VA1qSI1wlafm++Si094Lj6wFOpZfYz6zbO62SpYe+c
	sOvzr+er1Lc/5xJiOnCkJ/Ju+uZHQTZp0w71VLa9qLUS2muyPGJn5S2fl1Wb6w9I2z/XmnZF
	+Uvan51Lsy022gkH7V/4VHqRAUPEw7Arlaer65L6OcLvskmmZTtOyelNXLTqm9H8+HCzz7a7
	ZwgwH1LtnqMUmNjRIebUdf+jiZDK7cmHi8t7LSw3nvuxaLriOxOeuwfnGRwpSu1/kd6okJQu
	aPabgT94Sw5fpM/JyZ8z4oMyUg6efbGWseJU4gQ26S/5+9415rdevqV3Y33kKyWW4oxEQy3m
	ouJEADJ0406YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7o1M/jSDF5+UrFYNXUni8WC2dwW
	l3fNYbO4e3cVo8XtiZMZHVg9Ni+p9+j/a+DxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWRnqGl
	hZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbrza+ZC24VVTzbPo+xgfFpXBcjJ4eEgInE
	1MdvWLoYuTiEBJYySsz9+JIJIiEjcXJaAyuELSzx51oXG0TRe0aJ99t2s4EkeAXsJC423WXu
	YuTgYBFQkfh/1BQiLChxcuYTFhBbVEBe4v6tGewgtrCAnsTrs9fB4iICyRIfl24HG8MMZN+c
	DXPEHEaJTS0X2CES4hK3nswHO4hNwFCi620XWAOnQKrE/mmPoJrNJLq2djFC2PISzVtnM09g
	FJqF5I5ZSEbNQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFxtO3Yz807GOe9
	+qh3iJGJg/EQowQHs5IIb7cDb5oQb0piZVVqUX58UWlOavEhRlNgWExklhJNzgdGcl5JvKGZ
	gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5PSFo37eYtt/61TiW40mHy2
	zWQpX19XlVRo1IFnvPNYkksOlsrt/qz+X97Y2UXks/47CXuZbA7eOsnVfbs9Hh9Tjrn6+0hU
	IGdj2uegHnHTCItLs5LXW+aaLNR56fDDXnBuZDdHctSnhMS2N4JT2Jiu223806twXvb/pE9x
	U446Ke3fHOl80t+SbZLfsoliJVt5byRzhCUk3s8T5bP9ElT/xvPI6cR2m/yfD2ew8u57IdHe
	/Hq2iuXdHM1KnX9Pn07auX/ZhfX/XhjJT9YV+3mgl9uwdsNx8W0Cd+6b9k85zXXH0qzv+84z
	p4N6lVeKffLwTdxsrZthYrPtyEUx6RXhRfnlk3ouTrQ09U0NUGIpzkg01GIuKk4EAJ9U43os
	AwAA
X-CMS-MailID: 20240404120932eucas1p1b3c1e07bf6f41f6330725148b0268b13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240404120932eucas1p1b3c1e07bf6f41f6330725148b0268b13
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240404120932eucas1p1b3c1e07bf6f41f6330725148b0268b13
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
	<e36c1a44096cbd7e9cb693f2300ac12ed1b2f79d.1710670958.git.u.kleine-koenig@pengutronix.de>
	<CGME20240404120932eucas1p1b3c1e07bf6f41f6330725148b0268b13@eucas1p1.samsung.com>

Hi Uwe,

On 17.03.2024 11:40, Uwe Kleine-König wrote:
> This ensures that a pwm_chip that has no corresponding driver isn't used
> and that a driver doesn't go away while a callback is still running.
>
> In the presence of device links this isn't necessary yet (so this is no
> fix) but for pwm character device support this is needed.
>
> To not serialize all pwm_apply_state() calls, this introduces a per chip
> lock. An additional complication is that for atomic chips a mutex cannot
> be used (as pwm_apply_atomic() must not sleem) and a spinlock cannot be
> held while calling an operation for a sleeping chip. So depending on the
> chip being atomic or not a spinlock or a mutex is used.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


This patch landed some time ago in linux-next as commit a740f7879609 
("pwm: Add more locking"). Recently I've finally found that $subject 
patch is responsible for the following lock dep splat observed for some 
time during day-to-day linux-next testing:

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc1+ #14790 Tainted: G         C
------------------------------------------------------
kworker/u24:4/59 is trying to acquire lock:
ffff00003c65b510 (&chip->nonatomic_lock){+.+.}-{3:3}, at: 
pwm_apply_might_sleep+0x90/0xd8

but task is already holding lock:
ffff80008310fa40 (prepare_lock){+.+.}-{3:3}, at: clk_prepare_lock+0x4c/0xa8

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (prepare_lock){+.+.}-{3:3}:
        lock_acquire+0x68/0x84
        __mutex_lock+0xa0/0x840
        mutex_lock_nested+0x24/0x30
        clk_prepare_lock+0x4c/0xa8
        clk_round_rate+0x38/0xd0
        meson_pwm_apply+0x128/0x220 [pwm_meson]
        __pwm_apply+0x64/0x1f8
        pwm_apply_might_sleep+0x58/0xd8
        pwm_regulator_set_voltage+0xbc/0x12c
        _regulator_do_set_voltage+0x110/0x688
        regulator_set_voltage_rdev+0x64/0x25c
        regulator_do_balance_voltage+0x20c/0x47c
        regulator_balance_voltage+0x50/0x9c
        regulator_set_voltage_unlocked+0xa4/0x128
        regulator_set_voltage+0x50/0xec
        _opp_config_regulator_single+0x4c/0x130
        _set_opp+0xfc/0x544
        dev_pm_opp_set_rate+0x190/0x284
        set_target+0x34/0x40
        __cpufreq_driver_target+0x170/0x290
        cpufreq_online+0x814/0xa3c
        cpufreq_add_dev+0x80/0x98
        subsys_interface_register+0xfc/0x118
        cpufreq_register_driver+0x150/0x234
        dt_cpufreq_probe+0x150/0x480
        platform_probe+0x68/0xd8
        really_probe+0xbc/0x2a0
        __driver_probe_device+0x78/0x12c
        driver_probe_device+0xdc/0x164
        __device_attach_driver+0xb8/0x138
        bus_for_each_drv+0x84/0xe0
        __device_attach+0xa8/0x1b0
        device_initial_probe+0x14/0x20
        bus_probe_device+0xb0/0xb4
        deferred_probe_work_func+0x8c/0xc8
        process_one_work+0x220/0x634
        worker_thread+0x268/0x3a8
        kthread+0x124/0x128
        ret_from_fork+0x10/0x20

-> #0 (&chip->nonatomic_lock){+.+.}-{3:3}:
        __lock_acquire+0x1318/0x20c4
        lock_acquire.part.0+0xc8/0x20c
        lock_acquire+0x68/0x84
        __mutex_lock+0xa0/0x840
        mutex_lock_nested+0x24/0x30
        pwm_apply_might_sleep+0x90/0xd8
        clk_pwm_prepare+0x54/0x84
        clk_core_prepare+0xc8/0x2f8
        clk_prepare+0x28/0x44
        mmc_pwrseq_simple_pre_power_on+0x4c/0x8c
        mmc_pwrseq_pre_power_on+0x24/0x34
        mmc_power_up.part.0+0x20/0x16c
        mmc_start_host+0xa0/0xac
        mmc_add_host+0x84/0xf0
        meson_mmc_probe+0x318/0x3e8
        platform_probe+0x68/0xd8
        really_probe+0xbc/0x2a0
        __driver_probe_device+0x78/0x12c
        driver_probe_device+0xdc/0x164
        __device_attach_driver+0xb8/0x138
        bus_for_each_drv+0x84/0xe0
        __device_attach_async_helper+0xb0/0xd4
        async_run_entry_fn+0x34/0xe0
        process_one_work+0x220/0x634
        worker_thread+0x268/0x3a8
        kthread+0x124/0x128
        ret_from_fork+0x10/0x20

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(prepare_lock);
                                lock(&chip->nonatomic_lock);
                                lock(prepare_lock);
   lock(&chip->nonatomic_lock);

  *** DEADLOCK ***

4 locks held by kworker/u24:4/59:
  #0: ffff000000220d48 ((wq_completion)async){+.+.}-{0:0}, at: 
process_one_work+0x1a0/0x634
  #1: ffff80008461bde0 ((work_completion)(&entry->work)){+.+.}-{0:0}, 
at: process_one_work+0x1c8/0x634
  #2: ffff0000015bf0f8 (&dev->mutex){....}-{3:3}, at: 
__device_attach_async_helper+0x3c/0xd4
  #3: ffff80008310fa40 (prepare_lock){+.+.}-{3:3}, at: 
clk_prepare_lock+0x4c/0xa8

stack backtrace:
CPU: 1 PID: 59 Comm: kworker/u24:4 Tainted: G         C 6.9.0-rc1+ #14790
Hardware name: Khadas VIM3 (DT)
Workqueue: async async_run_entry_fn
Call trace:
  dump_backtrace+0x98/0xf0
  show_stack+0x18/0x24
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  print_circular_bug+0x290/0x370
  check_noncircular+0x15c/0x170
  __lock_acquire+0x1318/0x20c4
  lock_acquire.part.0+0xc8/0x20c
  lock_acquire+0x68/0x84
  __mutex_lock+0xa0/0x840
  mutex_lock_nested+0x24/0x30
  pwm_apply_might_sleep+0x90/0xd8
  clk_pwm_prepare+0x54/0x84
  clk_core_prepare+0xc8/0x2f8
  clk_prepare+0x28/0x44
  mmc_pwrseq_simple_pre_power_on+0x4c/0x8c
  mmc_pwrseq_pre_power_on+0x24/0x34
  mmc_power_up.part.0+0x20/0x16c
  mmc_start_host+0xa0/0xac
  mmc_add_host+0x84/0xf0
  meson_mmc_probe+0x318/0x3e8
  platform_probe+0x68/0xd8
  really_probe+0xbc/0x2a0
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0xdc/0x164
  __device_attach_driver+0xb8/0x138
  bus_for_each_drv+0x84/0xe0
  __device_attach_async_helper+0xb0/0xd4
  async_run_entry_fn+0x34/0xe0
  process_one_work+0x220/0x634
  worker_thread+0x268/0x3a8
  kthread+0x124/0x128
  ret_from_fork+0x10/0x20


I'm not really sure if this warning shows a real problem or just some 
functions are missing lock dep annotations. Quite a lots of subsystems 
are involved in it (clocks, regulators and pwms) and this issue is fully 
reproducible here during system boot on Khadas VIM3 ARM64-based board.


> ---
>   drivers/pwm/core.c  | 98 +++++++++++++++++++++++++++++++++++++++++----
>   include/linux/pwm.h | 13 ++++++
>   2 files changed, 103 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 09ff6ef0b634..2e08fcfbe138 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -29,6 +29,22 @@ static DEFINE_MUTEX(pwm_lock);
>   
>   static DEFINE_IDR(pwm_chips);
>   
> +static void pwmchip_lock(struct pwm_chip *chip)
> +{
> +	if (chip->atomic)
> +		spin_lock(&chip->atomic_lock);
> +	else
> +		mutex_lock(&chip->nonatomic_lock);
> +}
> +
> +static void pwmchip_unlock(struct pwm_chip *chip)
> +{
> +	if (chip->atomic)
> +		spin_unlock(&chip->atomic_lock);
> +	else
> +		mutex_unlock(&chip->nonatomic_lock);
> +}
> +
>   static void pwm_apply_debug(struct pwm_device *pwm,
>   			    const struct pwm_state *state)
>   {
> @@ -183,6 +199,7 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>   int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
>   {
>   	int err;
> +	struct pwm_chip *chip = pwm->chip;
>   
>   	/*
>   	 * Some lowlevel driver's implementations of .apply() make use of
> @@ -193,7 +210,13 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
>   	 */
>   	might_sleep();
>   
> -	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
> +	pwmchip_lock(chip);
> +	if (!chip->operational) {
> +		pwmchip_unlock(chip);
> +		return -ENODEV;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
>   		/*
>   		 * Catch any drivers that have been marked as atomic but
>   		 * that will sleep anyway.
> @@ -205,6 +228,8 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
>   		err = __pwm_apply(pwm, state);
>   	}
>   
> +	pwmchip_unlock(chip);
> +
>   	return err;
>   }
>   EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
> @@ -291,16 +316,26 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
>   int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
>   		unsigned long timeout)
>   {
> +	struct pwm_chip *chip;
>   	int err;
>   
> -	if (!pwm || !pwm->chip->ops)
> +	if (!pwm || !(chip = pwm->chip)->ops)
>   		return -EINVAL;
>   
> -	if (!pwm->chip->ops->capture)
> +	if (!chip->ops->capture)
>   		return -ENOSYS;
>   
>   	mutex_lock(&pwm_lock);
> -	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
> +
> +	pwmchip_lock(chip);
> +
> +	if (chip->operational)
> +		err = chip->ops->capture(pwm->chip, pwm, result, timeout);
> +	else
> +		err = -ENODEV;
> +
> +	pwmchip_unlock(chip);
> +
>   	mutex_unlock(&pwm_lock);
>   
>   	return err;
> @@ -340,6 +375,14 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>   	if (test_bit(PWMF_REQUESTED, &pwm->flags))
>   		return -EBUSY;
>   
> +	/*
> +	 * This function is called while holding pwm_lock. As .operational only
> +	 * changes while holding this lock, checking it here without holding the
> +	 * chip lock is fine.
> +	 */
> +	if (!chip->operational)
> +		return -ENODEV;
> +
>   	if (!try_module_get(chip->owner))
>   		return -ENODEV;
>   
> @@ -368,7 +411,12 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>   		 */
>   		struct pwm_state state = { 0, };
>   
> +		pwmchip_lock(chip);
> +
>   		err = ops->get_state(chip, pwm, &state);
> +
> +		pwmchip_unlock(chip);
> +
>   		trace_pwm_get(pwm, &state, err);
>   
>   		if (!err)
> @@ -997,6 +1045,7 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
>   
>   	chip->npwm = npwm;
>   	chip->uses_pwmchip_alloc = true;
> +	chip->operational = false;
>   
>   	pwmchip_dev = &chip->dev;
>   	device_initialize(pwmchip_dev);
> @@ -1102,6 +1151,11 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>   
>   	chip->owner = owner;
>   
> +	if (chip->atomic)
> +		spin_lock_init(&chip->atomic_lock);
> +	else
> +		mutex_init(&chip->nonatomic_lock);
> +
>   	mutex_lock(&pwm_lock);
>   
>   	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
> @@ -1115,6 +1169,10 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>   	if (IS_ENABLED(CONFIG_OF))
>   		of_pwmchip_add(chip);
>   
> +	pwmchip_lock(chip);
> +	chip->operational = true;
> +	pwmchip_unlock(chip);
> +
>   	ret = device_add(&chip->dev);
>   	if (ret)
>   		goto err_device_add;
> @@ -1124,6 +1182,10 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>   	return 0;
>   
>   err_device_add:
> +	pwmchip_lock(chip);
> +	chip->operational = false;
> +	pwmchip_unlock(chip);
> +
>   	if (IS_ENABLED(CONFIG_OF))
>   		of_pwmchip_remove(chip);
>   
> @@ -1145,12 +1207,27 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
>   void pwmchip_remove(struct pwm_chip *chip)
>   {
>   	pwmchip_sysfs_unexport(chip);
> +	unsigned int i;
> +
> +	mutex_lock(&pwm_lock);
> +
> +	pwmchip_lock(chip);
> +	chip->operational = false;
> +	pwmchip_unlock(chip);
> +
> +	for (i = 0; i < chip->npwm; ++i) {
> +		struct pwm_device *pwm = &chip->pwms[i];
> +
> +		if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> +			dev_alert(&chip->dev, "Freeing requested PWM #%u\n", i);
> +			if (pwm->chip->ops->free)
> +				pwm->chip->ops->free(pwm->chip, pwm);
> +		}
> +	}
>   
>   	if (IS_ENABLED(CONFIG_OF))
>   		of_pwmchip_remove(chip);
>   
> -	mutex_lock(&pwm_lock);
> -
>   	idr_remove(&pwm_chips, chip->id);
>   
>   	mutex_unlock(&pwm_lock);
> @@ -1532,12 +1609,17 @@ void pwm_put(struct pwm_device *pwm)
>   
>   	mutex_lock(&pwm_lock);
>   
> -	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> +	/*
> +	 * If the chip isn't operational, PWMF_REQUESTED was already cleared. So
> +	 * don't warn in this case. This can only happen if a consumer called
> +	 * pwm_put() twice.
> +	 */
> +	if (chip->operational && !test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
>   		pr_warn("PWM device already freed\n");
>   		goto out;
>   	}
>   
> -	if (chip->ops->free)
> +	if (chip->operational && chip->ops->free)
>   		pwm->chip->ops->free(pwm->chip, pwm);
>   
>   	pwm->label = NULL;
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 60b92c2c75ef..9c84e0ba81a4 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -274,6 +274,9 @@ struct pwm_ops {
>    * @of_xlate: request a PWM device given a device tree PWM specifier
>    * @atomic: can the driver's ->apply() be called in atomic context
>    * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this chip
> + * @operational: signals if the chip can be used (or is already deregistered)
> + * @nonatomic_lock: mutex for nonatomic chips
> + * @atomic_lock: mutex for atomic chips
>    * @pwms: array of PWM devices allocated by the framework
>    */
>   struct pwm_chip {
> @@ -289,6 +292,16 @@ struct pwm_chip {
>   
>   	/* only used internally by the PWM framework */
>   	bool uses_pwmchip_alloc;
> +	bool operational;
> +	union {
> +		/*
> +		 * depending on the chip being atomic or not either the mutex or
> +		 * the spinlock is used. It protects .operational and
> +		 * synchronizes calls to the .ops->apply and .ops->get_state()
> +		 */
> +		struct mutex nonatomic_lock;
> +		struct spinlock atomic_lock;
> +	};
>   	struct pwm_device pwms[] __counted_by(npwm);
>   };
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


