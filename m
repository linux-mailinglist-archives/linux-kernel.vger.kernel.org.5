Return-Path: <linux-kernel+bounces-54467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591C84AF91
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF658B24811
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074712AAD8;
	Tue,  6 Feb 2024 08:02:41 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B212C542;
	Tue,  6 Feb 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206560; cv=none; b=SZf4b+q4EauQvU3Z71cpRMpPFHEFDhBiEzQyR0xgWKZfo/zaunewJp/48QmhiXq7lJI7ttlDcoxoUyvLtc94tawT5EQSmyB5w+uxysHkHpvqrQjeXy8BZ7GilqCe0jC2MMikEQ1ABA0wUonaAXmmUYWZqaCPzhdfBCSL7CX7buo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206560; c=relaxed/simple;
	bh=5TtFAlo6L0iTbzszJobYOjgwlk+MTqRRtFyfOah/7Cg=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GaDu0a3cQTISpiSc5pLNNQv615T+BG/Kaucu3VnerHLVYGKOEn8Tzv69Y546luMKp1bmO1swsZ4ETrT/qDjtIrH2YyjxjDTmOn13SitrIT+XLdIyzwq9KpKbNskNyHoQ7prn8e3a26gKNbFd2zlKlQjGMuJzT0ugwRM7kH2lt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TTbLl6PxTz1vtHP;
	Tue,  6 Feb 2024 16:02:07 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 89BE9140390;
	Tue,  6 Feb 2024 16:02:35 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 16:02:35 +0800
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
 <b1518b0f-977a-58f5-3164-a6bb9a45dfbe@huawei.com>
 <20240205090713.GE5185@atomide.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <ea950cd4-b778-12e3-4ccd-301b213da450@huawei.com>
Date: Tue, 6 Feb 2024 16:02:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240205090713.GE5185@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/5 17:07, Tony Lindgren wrote:
> * Yicong Yang <yangyicong@huawei.com> [240205 08:55]:
>> On 2024/2/5 14:51, Tony Lindgren wrote:
>>> Can you please confirm if this still happens also with commit 6f699743aebf
>>> ("serial: core: Fix runtime PM handling for pending tx")? It adds a check
>>> for -EINPROGRESS.
>>
>> Tested nagetive on latest v6.8-rc3. Paste the current code snippet below in __uart_start():
> 
> OK thanks for confirming it.
> 
>> In our issue case, the dev->power.runtime_status == RPM_RESUMING as analyzed in
>> commit. So we cannot pass the pm_runtime_active() check and the chars will still
>> be pending.
> 
> OK
> 
>> Do you mean something like below?
>>
>> static int serial_port_runtime_suspend(struct device *dev)
>> {
>> 	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
>> 	struct uart_port *port;
>> 	unsigned long flags;
>> 	int ret = 0;
>>
>> 	port = port_dev->port;
>>
>> 	if (port->flags & UPF_DEAD)
>> 		return ret;
>>
>> 	spin_lock_irqsave(&port->lock, flags);
>> 	if (__serial_port_busy(port)) {
>> 		port->ops->start_tx(port);
>> 		ret = -EBUSY;
>> 	}
>> 	spin_unlock_irqrestore(&port->lock, flags);
>>
>> 	return ret;
>> }
> 
> Yes the above should work.
> 
>> If so will the port fail to suspend after flushing the pending chars? Considering
>> underlay driver like amba-pl011 doesn't implement runtime power management, does
>> anyone will get the port into suspend routine later? I'm not quite sure about it.
> 
> Hmm yeah you may need to also call pm_runtime_mark_last_busy() to
> ensure the port gets idled later on. Not sure if PM runtime core does that for
> you on returning -EBUSY, worth checking it :)

In this if the runtime_suspend() callback return -EBUSY, rpm core will try to
repeat to try to suspend the device. So this shall be ok.

So I respin a v2 as suggested:
https://lore.kernel.org/all/20240206073322.5560-1-yangyicong@huawei.com/

> 
> The PM runtime hierarchy will block the serial port controller driver from
> suspending, so the port drivers won't runtime suspend.
> 
>> In the patch's implementation the pending chars will be flushed in runtime_resume()
>> callback and rpm_resume() will try to call rpm_idle() later.
> 
> On serial_port_runtime_suspend() the serial port controller will be active, so
> you can call start_tx() directly.
> 
> Regards,
> 
> Tony
> 
> .
> 

