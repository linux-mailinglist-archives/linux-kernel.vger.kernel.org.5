Return-Path: <linux-kernel+bounces-54681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03C184B265
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326B128C75B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D183C12E1E2;
	Tue,  6 Feb 2024 10:20:56 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61112E1CA;
	Tue,  6 Feb 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214856; cv=none; b=gZrnK+9G5EtwHBbL1SZ07b014g5tUd0s7XtHEpDpMI1NA9dHy3hysOKuMpMh9JZm4EZLmlvab+Mp/apAykQqtXdvTlMOjjji7EAZPuGdb+vKT2UxSkI9K1PB+SvBc8xgriWjpFr32O566leuLFZmZ/UOmWlJgb9jKmHXL+w3wb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214856; c=relaxed/simple;
	bh=AT61w8PtLBkTuamoC6D2og3lYMvQu4th7vGPt3i0Pt8=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B5VOWBKS7IXTe1KlM8t5UfCJYHxiyQADp41BNiRT1KbHm7QEjnJy0df58z9S8UmZvKttOxU88ufY6qK3ju3mRi/QMu6PbDthjPQDU8/6GU1ANpy9Z5CzR9oNsI6XmAsQjkZqXaazoCjliTxNLpPvr1ZP8obtyRm6Dhft79HrzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TTfNS6FHlz1gyft;
	Tue,  6 Feb 2024 18:18:48 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 64F2E140390;
	Tue,  6 Feb 2024 18:20:44 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 18:20:44 +0800
CC: <yangyicong@hisilicon.com>, <jirislaby@kernel.org>, <tony@atomide.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<tglx@linutronix.de>, <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v2] serial: port: Don't suspend if the port is still busy
To: Greg KH <gregkh@linuxfoundation.org>
References: <20240206073322.5560-1-yangyicong@huawei.com>
 <2024020600-attendant-verbally-6441@gregkh>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <3512fe60-15ce-878c-8444-6dfa806921c9@huawei.com>
Date: Tue, 6 Feb 2024 18:20:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024020600-attendant-verbally-6441@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/6 17:44, Greg KH wrote:
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
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Is this a regression that was caused by the port code?  If so, what
> commit id does this fix?  Should it be backported to older kernels?
> 

Sorry for missing it. The fix tag should be:

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")

Thanks.



