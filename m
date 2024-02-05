Return-Path: <linux-kernel+bounces-52234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD628495BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA9C1C2402F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0A11CB9;
	Mon,  5 Feb 2024 09:00:24 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5D11CAD;
	Mon,  5 Feb 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123624; cv=none; b=iB+jDdaXWMTQotoB5S5WSXsma4pdQMoWVbu8TqTtbp1KVC5y/wRuYyD7gi6hJ607nx9c/riRvlNfVeAaWboRSqZCmik7UwsrdqKt4yAl9UYktHPSJIe71+znjAcd/IUk3AMAPL/ExmXexcZEILaPf5dfL2ZQPlWtQPY2LNYufRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123624; c=relaxed/simple;
	bh=fhBKaVEYrEHPBmY52GfTCngYum3bYZxkD05PkUODcO8=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O3J4xFoLL5XzQYwDjd/dlvjemIsKfp1sut7PczhIFZ/7tLNrRTiceVkxXOWj4OKijiBwez2+UFySaTjuVmFwBVDaXhg1xGYlnPJ4j5pA/RWZgx1+nxCpN2TPi5ov6Ekx0arjlF0ZJtIt/1P2TGk+k0+5P0zNoOUc5MmH3mprmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TT0f15Y80z1gyZS;
	Mon,  5 Feb 2024 16:58:17 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D66E1A016B;
	Mon,  5 Feb 2024 17:00:12 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 17:00:11 +0800
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <tony@atomide.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <andriy.shevchenko@linux.intel.com>,
	<tglx@linutronix.de>, <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH] serial: port: Don't suspend if the port is still busy
To: John Ogness <john.ogness@linutronix.de>
References: <20240204031957.58176-1-yangyicong@huawei.com>
 <878r3zpaba.fsf@jogness.linutronix.de>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <d25d1d33-6a10-4e23-5ab2-f02ed4b72fac@huawei.com>
Date: Mon, 5 Feb 2024 17:00:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878r3zpaba.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/5 16:47, John Ogness wrote:
> On 2024-02-04, Yicong Yang <yangyicong@huawei.com> wrote:
>> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
>> index 88975a4df306..60d1eec6b6b7 100644
>> --- a/drivers/tty/serial/serial_port.c
>> +++ b/drivers/tty/serial/serial_port.c
>> @@ -46,8 +46,28 @@ static int serial_port_runtime_resume(struct device *dev)
>>  	return 0;
>>  }
>>  
>> +static int serial_port_runtime_suspend(struct device *dev)
>> +{
>> +	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
>> +	struct uart_port *port;
>> +	unsigned long flags;
>> +
>> +	port = port_dev->port;
>> +
>> +	if (port->flags & UPF_DEAD)
>> +		return 0;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +	if (__serial_port_busy(port))
>> +		pm_request_resume(dev);
>> +	spin_unlock_irqrestore(&port->lock, flags);
> 
> Please use the wrapper functions for the uart port lock:
> 
> uart_port_lock_irqsave()
> uart_port_unlock_irqrestore()
> 

Sure. Thanks for the information.

