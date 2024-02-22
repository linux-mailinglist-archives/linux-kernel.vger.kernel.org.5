Return-Path: <linux-kernel+bounces-76254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839685F4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D621F21C48
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956D405F8;
	Thu, 22 Feb 2024 09:42:10 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EDF37152;
	Thu, 22 Feb 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594930; cv=none; b=ivmb15ob6BD6qEs1C6XuoMisCSEH1U4dWfQ0Ev4ulwqeF00u8PGoBIjNFjU3V6p/VHEWgPJ1ofNpNsUGyb9X0YXm4z55C7fsjjy034hx22SVCXI5OKiznsIQJ7ndzoL1GwDRD3p1ZZ1ZD6cayQazn7S28SVJl1RcYmvSSl+tz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594930; c=relaxed/simple;
	bh=nB7akApCyMJjlIrdgWz8NAIOpjWP2HJ57h/ete1dFZU=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KF88ZjMZl8v0L7HKCKxwh/fCSSRkq7HJbDGUxYdeib3ekUUDBU/SjdNhNQJhAi4cLzRMMbxTq7PykMpAZT+ukU9JVTQhSZ3RNX6CSdX/I9jf8+kWgjEC/zlvhusdyZVY7CgFMWlPh49IxrRcvzUj1Ab0Gw6FhcAk1f1nGpk1mh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TgSmf4LZVz1Q8C7;
	Thu, 22 Feb 2024 17:40:18 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 44C791404F2;
	Thu, 22 Feb 2024 17:41:59 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 17:41:58 +0800
CC: <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
	<tony@atomide.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <john.ogness@linutronix.de>,
	<tglx@linutronix.de>, <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v3] serial: port: Don't suspend if the port is still busy
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby
	<jirislaby@kernel.org>
References: <20240208075216.48915-1-yangyicong@huawei.com>
 <beb599e2-ebc5-4b26-82c3-908830effd5a@kernel.org>
 <ZcUOp60BX8njHQ4Q@smile.fi.intel.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <d6384122-08da-03f4-ba9f-caa893ca10fb@huawei.com>
Date: Thu, 22 Feb 2024 17:41:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcUOp60BX8njHQ4Q@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/9 1:25, Andy Shevchenko wrote:
> On Thu, Feb 08, 2024 at 09:27:57AM +0100, Jiri Slaby wrote:
>> On 08. 02. 24, 8:52, Yicong Yang wrote:
> 
> ...
> 
>>>   static int __serial_port_busy(struct uart_port *port)
>>>   {
>>> -	return !uart_tx_stopped(port) &&
>>> -		uart_circ_chars_pending(&port->state->xmit);
>>> +	if (uart_tx_stopped(port))
>>> +		return 0;
>>> +
>>> +	if (uart_circ_chars_pending(&port->state->xmit))
>>> +		return -EBUSY;
>>
>> Why do you do this change at all? If anything, __serial_port_busy() should
>> be made to return a bool and not to return an error. Look how it is named --
>> returning EBUSY is sort of unexpected in my eyes. And if this needed to be
>> done, it should have been in a separate patch anyway.
> 
> I proposed that with a renaming, so it won't look as boolean.
> And I also implied (sorry if it was unclear) that this has to be
> done separately, so we are on the same page about this.
> 

Seems I misunderstand the comment from Andy. Will drop this change which should be
a separate one besides the fix. Will respin a v4 which only narrow the lock region
based on v2 (per Andy).

Thanks.

