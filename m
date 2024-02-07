Return-Path: <linux-kernel+bounces-56064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA83E84C591
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3618EB251CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6461F61C;
	Wed,  7 Feb 2024 07:22:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF41F5F0;
	Wed,  7 Feb 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290545; cv=none; b=j1T96wd+O0pZqkyhQOeerdLUYoGsed3tLHI/awhmZ8efW/W6thRqaeEZwc5/10b2WFCDFkmcssUnGsQCO1BWo7U/wLWnOluNBKI6qmgbSScPLvVRiq0OLHR/UxV3zwZ0k4H6iJq94IfbiMqRZ3omQr+LP5j/K3afL8qS0MdyIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290545; c=relaxed/simple;
	bh=VVvRFG/eiBuKl5tvWu7HLckqb1fOLvTugxdSX+bh1nQ=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sRKk+B9YIks+7Mh3AhlSUa5DSaflzYGQ7JNVcgOR+nLekzGTl3322sHqgqMRdsUMQl4QqNMOaNtSO8cE31HNamMHZOKKJBjVUundbFr+lbFj9N8T2leUQM5kdDdhLZVZQEQbq0w3ETqv0S3XVeWvip2L8KTrnKH0aoraio/64rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TVBN62G5mz1gydY;
	Wed,  7 Feb 2024 15:20:22 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 983AB1400CF;
	Wed,  7 Feb 2024 15:22:18 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 15:22:18 +0800
CC: <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <tony@atomide.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <john.ogness@linutronix.de>,
	<tglx@linutronix.de>, <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v2] serial: port: Don't suspend if the port is still busy
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240206073322.5560-1-yangyicong@huawei.com>
 <ZcIvjC1qzD4atwlT@smile.fi.intel.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <9e3d8daf-6715-bb37-125a-4141a9460417@huawei.com>
Date: Wed, 7 Feb 2024 15:22:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcIvjC1qzD4atwlT@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)

Hi Andy,

On 2024/2/6 21:09, Andy Shevchenko wrote:
> On Tue, Feb 06, 2024 at 03:33:22PM +0800, Yicong Yang wrote:
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
>>
>> This patch tries to fix this by checking the port busy before entering
>> runtime suspending. A runtime_suspend callback is added for the port
>> driver. When entering runtime suspend the callback is invoked, if there's
>> still pending chars in the buffer then flush the buffer.
> 
> ...
> 
>> +static int serial_port_runtime_suspend(struct device *dev)
>> +{
>> +	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
>> +	struct uart_port *port;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	port = port_dev->port;
>> +
>> +	if (port->flags & UPF_DEAD)
>> +		return ret;
>> +
>> +	uart_port_lock_irqsave(port, &flags);
>> +	if (__serial_port_busy(port)) {
>> +		port->ops->start_tx(port);
> 
>> +		pm_runtime_mark_last_busy(dev);
> 
> Do you think we need to call this under a lock?
> 

I just put this close to the ops->start_tx() where I used the device. Yes I have no
strong reason to put it in/with the lock region, but pm_runtime_mark_last_busy()
should be no costy and safe enough to put it in the spinlock region.

Any thoughts?

>> +		ret = -EBUSY;
>> +	}
>> +	uart_port_unlock_irqrestore(port, flags);
>> +
>> +	return ret;
>> +}
> 
> With the above I would rather write it as
> 
> static int __serial_port_busy(struct uart_port *port)
> {
> 	if (uart_tx_stopped(port))
> 		return 0;
> 
> 	if (uart_circ_chars_pending(&port->state->xmit)
> 		return -EBUSY;

I'm not sure but EBUSY seems not quite match here. EBUSY for
"Device or resource busy" so the device probably cannot be used
but we're testing whether the port is busy here. Hope I understand it
correctly.

> 
> 	return 0;
> }
> 
> static int serial_port_runtime_suspend(struct device *dev)
> {
> 	int ret;
> 	...
> 	uart_port_lock_irqsave(port, &flags);
> 	ret = __serial_port_busy(port);
> 	if (ret)
> 		port->ops->start_tx(port);
> 	uart_port_unlock_irqrestore(port, flags);
> 
> 	if (ret)
> 		pm_runtime_mark_last_busy(dev);
> 
> 	return ret;
> }
> 
> It also seems aligned with the resume implementation above.
> 
> ...
> 
> For the consistency's sake the resume can be refactored as
> 
> static int serial_port_runtime_resume(struct device *dev)
> {
> 	...
> 	int ret;
> 	...
> 	ret = __serial_port_busy(port);
> 	if (ret)
> 	...
> }
> 
> but this can be done later.
> 

I agree the refactoring should go to a separate patch. But it doesn't seem
to be more simpler or readable comparing to the current implementation? Just
want to narrowing the spinlock region?

Thanks.


