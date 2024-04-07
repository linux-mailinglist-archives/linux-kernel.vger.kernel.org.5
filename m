Return-Path: <linux-kernel+bounces-134311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBFF89B029
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09BB28253D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56C6171D8;
	Sun,  7 Apr 2024 09:49:26 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7781CAA4;
	Sun,  7 Apr 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483366; cv=none; b=EhtlHbOgMQNyZTiEVomKhj52pvMxnMzx7F76+9w9HF8eQhvp0Mit3khiuCFWYmTZ35F3aSj/hSHSpChhDUIGL+F3y251tl9VyOOWsCZTqiq77H60DI9t/c/65FEQUHB55BVCBQTiPiJA/NpW2sR9N4xHlgWqjEvvOdUY1wN2k0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483366; c=relaxed/simple;
	bh=ZmoHroEEWQNn9yJ7NQoUQMxBXY/9Ta5EgVKE6Owbfh8=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WmsQibuW6ttyfXF1tui9DM3rhXtKXDWDW98cWGrrpGrD1S9BY8CGAz8dJxn8zOMm6b3WNyn8IrJtW73XWHmbAZ9H3PK4mzSY8ORShYaCPyTs5JNe+FpSXTsykfSGdG6PE5OYSIpw6n+x04Y/xPdh3q6Tf/4BErX5lNxh/7KtQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VC6qD23fdzbfQB;
	Sun,  7 Apr 2024 17:48:24 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 13E3B140156;
	Sun,  7 Apr 2024 17:49:21 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 7 Apr 2024 17:49:20 +0800
CC: <yangyicong@hisilicon.com>, Jiri Slaby <jirislaby@kernel.org>, Tony
 Lindgren <tony@atomide.com>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] serial: core: Clearing the circular buffer before
 NULLifying it
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
References: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <b3fd1077-b49e-d99b-9cd1-c41bd244f290@huawei.com>
Date: Sun, 7 Apr 2024 17:49:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

Hi Andy,

On 2024/4/4 22:59, Andy Shevchenko wrote:
> The circular buffer is NULLified in uart_tty_port_shutdown()
> under the spin lock. However, the PM or other timer based callbacks
> may still trigger after this event without knowning that buffer pointer
> is not valid. Since the serial code is a bit inconsistent in checking
> the buffer state (some rely on the head-tail positions, some on the
> buffer pointer), it's better to have both aligned, i.e. buffer pointer
> to be NULL and head-tail possitions to be the same, meaning it's empty.
> This will prevent asynchronous calls to dereference NULL pointer as
> reported recently in 8250 case:
> 
>   BUG: kernel NULL pointer dereference, address: 00000cf5
>   Workqueue: pm pm_runtime_work
>   EIP: serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
>   ...
>   ? serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
>   __start_tx (drivers/tty/serial/8250/8250_port.c:1551)
>   serial8250_start_tx (drivers/tty/serial/8250/8250_port.c:1654)
>   serial_port_runtime_suspend (include/linux/serial_core.h:667 drivers/tty/serial/serial_port.c:63)
>   __rpm_callback (drivers/base/power/runtime.c:393)
>   ? serial_port_remove (drivers/tty/serial/serial_port.c:50)
>   rpm_suspend (drivers/base/power/runtime.c:447)
> 
> The proposed change will prevent ->start_tx() to be called during
> suspend on shut down port.
> 

Just saw the issue and thanks for your timely fix. I didn't got a board with 8250 and sorry for
didn't found this issue.

FYI, I checked device_shutdown() and seems it called pm_runtime_barrier() for waiting all
the scheduled RPM callbacks finished and keep the device in resume state. So ideally there
shouldn't be any pending requests later since we handled them before shutdown?

There's someone encountered the same issue in shutdown() due to runtime pm and fixed it in
	af8db1508f2c ("PM / driver core: disable device's runtime PM during shutdown")
patch above seems to still have some problem and later fixed by:
	fe6b91f47080 ("PM / Driver core: leave runtime PM enabled during system shutdown")

But seems the handling in the driver core doesn't cover the case here..

> Fixes: 43066e32227e ("serial: port: Don't suspend if the port is still busy")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202404031607.2e92eebe-lkp@intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> I have got into the very similar issue while working on max3100 driver.
> I haven't checked the 8250 case, but for mine the culprit is the same
> and this patch fixes it. Hence I assume it will fix the 8250 case as
> well.
> 
>  drivers/tty/serial/serial_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index a005fc06a077..ba3a674a8bbf 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1788,6 +1788,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
>  	 * Free the transmit buffer.
>  	 */
>  	uart_port_lock_irq(uport);
> +	uart_circ_clear(&state->xmit);
>  	buf = state->xmit.buf;
>  	state->xmit.buf = NULL;
>  	uart_port_unlock_irq(uport);
> 

