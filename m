Return-Path: <linux-kernel+bounces-52232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AD38495B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D771C20B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9611CB1;
	Mon,  5 Feb 2024 08:56:01 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7911CA9;
	Mon,  5 Feb 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123361; cv=none; b=sKS2RkDso8xQyzJ+6yeLxm3BfGa9sHl6IqLzEiCuXMt8xs+Nfgty2r70dxGDSKOmSYHWKfH0HP0F1h1Ns0VcrA6B7K6Daxh/nQhoJdB58WLLy6174xoZYd42XCs8gOUGoYDJcCovbm4vHUw3/+tEuaMb4Jw9uNY2mbGNcatDc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123361; c=relaxed/simple;
	bh=fLbhecTLyO0qKUHDd+wj0hsYeRDa0CZBKLdtJyJKsgw=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SlzhH6rsvC6+oEqH9Zo6Wq+9hA8AaFLcQ7iPoJTYvk5sdNFC805ioikqMUjGlKq/eZ7rAr9djIMpO6MBfv5XD4PeO0vy8Yp9fV0f0/xvBt82i8lLw81WTZy/jqFTD/4orFT/4YmSjEaej10j0SwNIh71ZwqtD9zPiYrzroJdRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TT0Zg4cMDz1vtD3;
	Mon,  5 Feb 2024 16:55:23 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id D9EF7140153;
	Mon,  5 Feb 2024 16:55:50 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 16:55:50 +0800
CC: <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <john.ogness@linutronix.de>,
	<andriy.shevchenko@linux.intel.com>, <tglx@linutronix.de>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH] serial: port: Don't suspend if the port is still busy
To: Tony Lindgren <tony@atomide.com>
References: <20240204031957.58176-1-yangyicong@huawei.com>
 <20240205065126.GB5185@atomide.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <b1518b0f-977a-58f5-3164-a6bb9a45dfbe@huawei.com>
Date: Mon, 5 Feb 2024 16:55:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240205065126.GB5185@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/5 14:51, Tony Lindgren wrote:
> * Yicong Yang <yangyicong@huawei.com> [240204 03:24]:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> We accidently met the issue that the bash prompt is not shown after the
>> previous command done and until the next input if there's only one CPU
>> (In our issue other CPUs are isolated by isolcpus=). Further analysis
>> shows it's because the port entering runtime suspend even if there's
>> still pending chars in the buffer and the pending chars will only be
>> processed in next device resuming. We are using amba-pl011 and the
>> problematic flow is like below:
>>
>> Bash                                         kworker
>> tty_write()
>>   file_tty_write()
>>     n_tty_write()
>>       uart_write()
>>         __uart_start()
>>           pm_runtime_get() // wakeup waker
>>             queue_work()
>>                                              pm_runtime_work()
>>                                                rpm_resume()
>>                                                 status = RPM_RESUMING
>>                                                 serial_port_runtime_resume()
>>                                                   port->ops->start_tx()
>>                                                     pl011_tx_chars()
>>                                                       uart_write_wakeup()
>>         […]
>>         __uart_start()
>>           pm_runtime_get() < 0 // because runtime status = RPM_RESUMING
>>                                // later data are not commit to the port driver
>>                                                 status = RPM_ACTIVE
>>                                                 rpm_idle() -> rpm_suspend()
> 
> Can you please confirm if this still happens also with commit 6f699743aebf
> ("serial: core: Fix runtime PM handling for pending tx")? It adds a check
> for -EINPROGRESS.

Tested nagetive on latest v6.8-rc3. Paste the current code snippet below in __uart_start():

	/* Increment the runtime PM usage count for the active check below */
	err = pm_runtime_get(&port_dev->dev);
	if (err < 0 && err != -EINPROGRESS) {
		pm_runtime_put_noidle(&port_dev->dev);
		return;
	}

	/*
	 * Start TX if enabled, and kick runtime PM. If the device is not
	 * enabled, serial_port_runtime_resume() calls start_tx() again
	 * after enabling the device.
	 */
	if (pm_runtime_active(&port_dev->dev))
		port->ops->start_tx(port);

In our issue case, the dev->power.runtime_status == RPM_RESUMING as analyzed in
commit. So we cannot pass the pm_runtime_active() check and the chars will still
be pending.

> 
>> This patch tries to fix this by checking the port busy before entering
>> runtime suspending. A runtime_suspend callback is added for the port
>> driver. When entering runtime suspend the callback is invoked, if there's
>> still pending chars in the buffer then request an runtime resume for
>> handling this.
> 
> OK. Let's look at this further after you have checked what happens with
> commit 6f699743aebf.
> 
> If needed, to me it seems that flushing tx and returning -EBUSY from
> serial_port_runtime_suspend() if busy might do the trick though.
> 

Do you mean something like below?

static int serial_port_runtime_suspend(struct device *dev)
{
	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
	struct uart_port *port;
	unsigned long flags;
	int ret = 0;

	port = port_dev->port;

	if (port->flags & UPF_DEAD)
		return ret;

	spin_lock_irqsave(&port->lock, flags);
	if (__serial_port_busy(port)) {
		port->ops->start_tx(port);
		ret = -EBUSY;
	}
	spin_unlock_irqrestore(&port->lock, flags);

	return ret;
}

If so will the port fail to suspend after flushing the pending chars? Considering
underlay driver like amba-pl011 doesn't implement runtime power management, does
anyone will get the port into suspend routine later? I'm not quite sure about it.

In the patch's implementation the pending chars will be flushed in runtime_resume()
callback and rpm_resume() will try to call rpm_idle() later.

Thanks.


