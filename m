Return-Path: <linux-kernel+bounces-68447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69C4857A51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF84B2498B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4147F6E;
	Fri, 16 Feb 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dJY6ftFh"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D435884
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079471; cv=none; b=ECuZBDQdeENigjuIsJumgCTADOE4R+phg9KQQOUcSJAl3tDwsxEvPgNPqwndcz6GAHxj+TmXTROz3X/mrWRzfdEXbh9qxwf2rqrA1zLJYS9RYld8dzCAau9hNj4YAsKWV/+JqBT7OaHHMoK4+tvxuRt47s9HBUtgpQTOwUqgyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079471; c=relaxed/simple;
	bh=I83TNhqClB3Gx2Xpm9j06FD9JteHVB7WC+8FSzlxZEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=RMAa8yBlHp6oCF7X5Q50GXfZmzO4IV6QGYkU3+xsE/AUAZA6y0CmIUCvcluHXdnuuP72If3xhRSFa4RIh3KRoeYNettBXoJo5g7xzQ9AjDGXWjMESZo+PABrQ75dYoH5SOOW0Pi4WPEZNhWGbvV5cwS4gMNVitiilbTZA3g6e4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dJY6ftFh; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240216103105euoutp02b7912389cabad4d8fb6cdeeda6da445b~0UTlsTsyk3045130451euoutp02a
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240216103105euoutp02b7912389cabad4d8fb6cdeeda6da445b~0UTlsTsyk3045130451euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708079465;
	bh=xt2ynN5M4KAj6tHqiVtX0hIoyZhRqcNU8aJG8AjVTk8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dJY6ftFhASb4dfIUZaqrP2hGR42wB9Tgz2/mWAJ6A7ZO/71dakSojrQfivaSXoJuT
	 h4oQfvSyQV5bcNKOkm92Vn/sT1XqhzwFd55QZErOERMQHu/joywI9zpwaLxKDoyqih
	 K56Mxzl5Mdr1cCavQnNVzgcZe7HDYqsWpuOc9/cg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240216103105eucas1p28c598cab052ba2c98403a9a7c2388510~0UTlWa3OY0059900599eucas1p2W;
	Fri, 16 Feb 2024 10:31:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 49.0E.09539.9693FC56; Fri, 16
	Feb 2024 10:31:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240216103104eucas1p1fac9b939d4af1648d222963fbef59645~0UTk0-eNx2540025400eucas1p1o;
	Fri, 16 Feb 2024 10:31:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240216103104eusmtrp10a5cf307211e12623642de4102c1d4c3~0UTk0UCoA0272402724eusmtrp12;
	Fri, 16 Feb 2024 10:31:04 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-c8-65cf3969d098
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 61.72.09146.8693FC56; Fri, 16
	Feb 2024 10:31:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240216103104eusmtip1539149280582d6d86e2daac5bbc48e69~0UTkHJCtc0251502515eusmtip1f;
	Fri, 16 Feb 2024 10:31:04 +0000 (GMT)
Message-ID: <179caa10-5f86-4707-8bb0-fe1b316326d6@samsung.com>
Date: Fri, 16 Feb 2024 11:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] gpio: cdev: use correct pointer accessors with
 SRCU
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
	<linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, Alex Elder
	<elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E .
 McKenney" <paulmck@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mark
	Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz
	Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot
	<oliver.sang@intel.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240214084419.6194-3-brgl@bgdev.pl>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djP87qZludTDb5P4bPobZrOZLHi2xom
	i10PtrFZTH34hM3iw7xWdotjDfeYLebOnsRoMeXPciaLzfP/MFpc3jWHzWLBp78sFp+WfGOx
	2NiyldFi5YlZzA58Houv3Wb1mHhW12PnrLvsHov3vGTy2LSqk83jzrU9bB7zTgZ6nDz1hMXj
	8ya5AM4oLpuU1JzMstQifbsEroxdpzpZCx7ZVbzo62dtYJxu0sXIySEhYCLRsWYrK4gtJLCC
	UWLvF+MuRi4g+wujxIyN+5ggnM+MEtMv72CD6bi98S4TRMdyRonXp7Igij4ySnSsfMQMkuAV
	sJP48O4V2FgWAVWJ/009rBBxQYmTM5+wgNiiAvIS92/NYAexhQUCJT4d72YEsZkFxCVuPZkP
	tllEYAazxMop/8AcZoGFjBI73jwB28AmYCjR9bYL7CROASOJTVf62CG65SWat85mBmmQEFjP
	KfGu6xcjxN0uEj8eT2CBsIUlXh3fwg5hy0icntzDAtHQziix4Pd9JghnAqNEw/NbUN3WEnfO
	/QJaxwG0QlNi/S59iLCjxKG/O1hBwhICfBI33gpCHMEnMWnbdGaIMK9ER5sQRLWaxKzj6+DW
	HrxwiXkCo9IspICZhRQAs5C8Mwth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiB
	Ce/0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd5JvWdShXhTEiurUovy44tKc1KLDzFKc7AoifOq
	psinCgmkJ5akZqemFqQWwWSZODilGpjmSAXMlEq/8rUpZknfgcmm1vuc+UK9DtfaVR3LLL2g
	o9B/4G76nnnXA0+rF5hmaf0zUkzl0vq3sebWUoH3b7e6hKV26ew1ecbQ1hHZ4HWip8/N7tgW
	+2lb6+z3tMXP1b23KdLz6DaBmz9jmw6Urm+Y0b+dTfVjYcnLnW9Lg89EHnD0fmU8c/bdWROz
	bqXkOzycfDSPVzOjZMPs0/ZJfb+e3JGtSu8WWCx26zNX2vu3t0OCmlfpu516UneC8bjE5kN2
	vxQXal9fOC9QYOrNClknxa8b3M4/Zpr462/Tnf2S2kJei8ykz2ulcixjYbQ1+3RtJWPRDSMl
	jQcdvtr7Z+Vz/y+1zNR3af7YzLg2uVmJpTgj0VCLuag4EQColN6B5wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7oZludTDdrv6Fj0Nk1nsljxbQ2T
	xa4H29gspj58wmbxYV4ru8WxhnvMFnNnT2K0mPJnOZPF5vl/GC0u75rDZrHg018Wi09LvrFY
	bGzZymix8sQsZgc+j8XXbrN6TDyr67Fz1l12j8V7XjJ5bFrVyeZx59oeNo95JwM9Tp56wuLx
	eZNcAGeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
	XsauU52sBY/sKl709bM2ME436WLk5JAQMJG4vfEuUxcjF4eQwFJGiVMf3zNBJGQkTk5rYIWw
	hSX+XOtiA7GFBN4zSsy6FAVi8wrYSXx49wqshkVAVeJ/Uw8rRFxQ4uTMJywgtqiAvMT9WzPY
	QWxhgUCJT8e7GUFsZgFxiVtP5oMtFhGYwyyxZu4mdhCHWWAho0TDkkNA2ziAtkVK3NkfDtLA
	JmAo0fUW4ghOASOJTVf62CEGmUl0be2CGiov0bx1NvMERqFZSO6YhWTfLCQts5C0LGBkWcUo
	klpanJueW2yoV5yYW1yal66XnJ+7iREY39uO/dy8g3Heq496hxiZOBgPMUpwMCuJ8E7qPZMq
	xJuSWFmVWpQfX1Sak1p8iNEUGBgTmaVEk/OBCSavJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUgg
	PbEkNTs1tSC1CKaPiYNTqoFpcr/Ao9oPLd9SNcIMKyyuXPy/20f5m9Lp0PSKu6Yr97789Fsu
	Z9KMpPSb2caXKgUku479fs8psDljee+fuzZ3o/MFXX2rXT1YZ94p0q3c77/yJTNraav6q+m7
	mn9F1L9nrVB9IDOz2r5ZvK0+OyUh36WsKdCxce4px7N1yfPW3LUrZfiw8P6KhibJrmmeos+k
	XeX13Z43zTjqNb/uV7beZda6w+enWVybvF5Spsdner6f1Y+ba5JnqL5i0WSXzN/K+ord+CG3
	+tWb5Sfa3269vuxwXuDKg3XSecxGG7TXJAn8Np2dMGnq1FMFvIE1fckXJbzMr27Yk/ezNGma
	Xn/E7ePZPT9n3lTdt6yYJUGJpTgj0VCLuag4EQDedz+ZeAMAAA==
X-CMS-MailID: 20240216103104eucas1p1fac9b939d4af1648d222963fbef59645
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240216103104eucas1p1fac9b939d4af1648d222963fbef59645
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240216103104eucas1p1fac9b939d4af1648d222963fbef59645
References: <20240214084419.6194-1-brgl@bgdev.pl>
	<20240214084419.6194-3-brgl@bgdev.pl>
	<CGME20240216103104eucas1p1fac9b939d4af1648d222963fbef59645@eucas1p1.samsung.com>

On 14.02.2024 09:44, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We never dereference the chip pointer in character device code so we can
> use the lighter rcu_access_pointer() helper. This also makes lockep
> happier as it no longer complains about suspicious rcu_dereference()
> usage.
>
> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.com
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/gpio/gpiolib-cdev.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 9323b357df43..85037fa4925e 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -206,7 +206,7 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
>   
>   	guard(srcu)(&lh->gdev->srcu);
>   
> -	if (!rcu_dereference(lh->gdev->chip))
> +	if (!rcu_access_pointer(lh->gdev->chip))
>   		return -ENODEV;
>   
>   	switch (cmd) {
> @@ -1521,7 +1521,7 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
>   
>   	guard(srcu)(&lr->gdev->srcu);
>   
> -	if (!rcu_dereference(lr->gdev->chip))
> +	if (!rcu_access_pointer(lr->gdev->chip))
>   		return -ENODEV;
>   
>   	switch (cmd) {
> @@ -1552,7 +1552,7 @@ static __poll_t linereq_poll(struct file *file,
>   
>   	guard(srcu)(&lr->gdev->srcu);
>   
> -	if (!rcu_dereference(lr->gdev->chip))
> +	if (!rcu_access_pointer(lr->gdev->chip))
>   		return EPOLLHUP | EPOLLERR;
>   
>   	poll_wait(file, &lr->wait, wait);
> @@ -1574,7 +1574,7 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
>   
>   	guard(srcu)(&lr->gdev->srcu);
>   
> -	if (!rcu_dereference(lr->gdev->chip))
> +	if (!rcu_access_pointer(lr->gdev->chip))
>   		return -ENODEV;
>   
>   	if (count < sizeof(le))
> @@ -1875,7 +1875,7 @@ static __poll_t lineevent_poll(struct file *file,
>   
>   	guard(srcu)(&le->gdev->srcu);
>   
> -	if (!rcu_dereference(le->gdev->chip))
> +	if (!rcu_access_pointer(le->gdev->chip))
>   		return EPOLLHUP | EPOLLERR;
>   
>   	poll_wait(file, &le->wait, wait);
> @@ -1913,7 +1913,7 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
>   
>   	guard(srcu)(&le->gdev->srcu);
>   
> -	if (!rcu_dereference(le->gdev->chip))
> +	if (!rcu_access_pointer(le->gdev->chip))
>   		return -ENODEV;
>   
>   	/*
> @@ -1996,7 +1996,7 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
>   
>   	guard(srcu)(&le->gdev->srcu);
>   
> -	if (!rcu_dereference(le->gdev->chip))
> +	if (!rcu_access_pointer(le->gdev->chip))
>   		return -ENODEV;
>   
>   	/*
> @@ -2510,7 +2510,7 @@ static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   	guard(srcu)(&gdev->srcu);
>   
>   	/* We fail any subsequent ioctl():s when the chip is gone */
> -	if (!rcu_dereference(gdev->chip))
> +	if (!rcu_access_pointer(gdev->chip))
>   		return -ENODEV;
>   
>   	/* Fill in the struct and pass to userspace */
> @@ -2595,7 +2595,7 @@ static __poll_t lineinfo_watch_poll(struct file *file,
>   
>   	guard(srcu)(&cdev->gdev->srcu);
>   
> -	if (!rcu_dereference(cdev->gdev->chip))
> +	if (!rcu_access_pointer(cdev->gdev->chip))
>   		return EPOLLHUP | EPOLLERR;
>   
>   	poll_wait(file, &cdev->wait, pollt);
> @@ -2618,7 +2618,7 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
>   
>   	guard(srcu)(&cdev->gdev->srcu);
>   
> -	if (!rcu_dereference(cdev->gdev->chip))
> +	if (!rcu_access_pointer(cdev->gdev->chip))
>   		return -ENODEV;
>   
>   #ifndef CONFIG_GPIO_CDEV_V1
> @@ -2696,7 +2696,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
>   	guard(srcu)(&gdev->srcu);
>   
>   	/* Fail on open if the backing gpiochip is gone */
> -	if (!rcu_dereference(gdev->chip))
> +	if (!rcu_access_pointer(gdev->chip))
>   		return -ENODEV;
>   
>   	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
> @@ -2796,8 +2796,7 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
>   
>   	guard(srcu)(&gdev->srcu);
>   
> -	gc = rcu_dereference(gdev->chip);
> -	if (!gc)
> +	if (!rcu_access_pointer(gdev->chip))
>   		return -ENODEV;
>   
>   	chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);

Here 'gc' is left uninitialized and nukes if GPIO DEBUGs are enabled. 
Here is an example (captured on today's linux-next):

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 
00000000 when read
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-next-20240216 #8096
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at gpiolib_cdev_register+0xd4/0x170
LR is at chainhash_table+0x784/0x20000
pc : [<c05dbe54>]    lr : [<c18bb74c>]    psr: 20000013
..
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000404a  DAC: 00000051
Register r0 information: non-slab/vmalloc memory
Register r1 information: NULL pointer
Register r2 information: non-paged memory
Register r3 information: non-paged memory
Register r4 information: slab kmalloc-1k start c1e5f800 pointer offset 0 
size 1024
Register r5 information: NULL pointer
Register r6 information: non-paged memory
Register r7 information: slab kmalloc-1k start c1e5f800 pointer offset 
952 size 1024
Register r8 information: NULL pointer
Register r9 information: slab kmalloc-1k start c1e5f800 pointer offset 
960 size 1024
Register r10 information: non-paged memory
Register r11 information: non-slab/vmalloc memory
Register r12 information: NULL pointer
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xf082db90 to 0xf082e000)
..
  gpiolib_cdev_register from gpiochip_setup_dev+0x44/0xb0
  gpiochip_setup_dev from gpiochip_add_data_with_key+0x9ac/0xaac
  gpiochip_add_data_with_key from devm_gpiochip_add_data_with_key+0x20/0x5c
  devm_gpiochip_add_data_with_key from samsung_pinctrl_probe+0x938/0xb18
  samsung_pinctrl_probe from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xe0/0x400
  really_probe from __driver_probe_device+0x9c/0x1f4
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __device_attach_driver+0xa8/0x120
  __device_attach_driver from bus_for_each_drv+0x80/0xcc
  bus_for_each_drv from __device_attach+0xac/0x1fc
  __device_attach from bus_probe_device+0x8c/0x90
  bus_probe_device from device_add+0x5d4/0x7fc
  device_add from of_platform_device_create_pdata+0x94/0xc4
  of_platform_device_create_pdata from of_platform_bus_create+0x1f8/0x4c0
  of_platform_bus_create from of_platform_bus_create+0x268/0x4c0
  of_platform_bus_create from of_platform_populate+0x80/0x110
  of_platform_populate from of_platform_default_populate_init+0xd4/0xec
  of_platform_default_populate_init from do_one_initcall+0x64/0x2fc
  do_one_initcall from kernel_init_freeable+0x1c4/0x228
  kernel_init_freeable from kernel_init+0x1c/0x12c
  kernel_init from ret_from_fork+0x14/0x28
Exception stack(0xf082dfb0 to 0xf082dff8)
..
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
---[ end Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b ]---


Probably the easiest way to fix this issue is to replace chip_dbg with 
the following dev_dbg() call:

dev_dbg(&gdev->dev, "(%s): added GPIO chardev (%d:%d)\n", gdev->label, 
MAJOR(devt), gdev->id);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


