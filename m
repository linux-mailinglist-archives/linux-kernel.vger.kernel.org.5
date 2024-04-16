Return-Path: <linux-kernel+bounces-146504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3847C8A663F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB61B222FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC0839E5;
	Tue, 16 Apr 2024 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NYRh5pJ/"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3D205E10;
	Tue, 16 Apr 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256581; cv=none; b=u+MEhjF68XgvNmRpV7xAkmQ8T7p0u5GDrbfQ+bKki2riJ97q0rl/FXtCX0Fquw//QBe98D1Fi2woFpUKHDYQWp8OCQOoSHHpMVdzCjDFBu5tGc6YpgQJfbU2DnrhYDX9VJwgezSYz0xV+YC0YShneY6Hx8UBEULIbTzYX1W2VTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256581; c=relaxed/simple;
	bh=AveT/kzhMyKqy9qT8luIjlZhEw74u3Rg6QrwfWqr29U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DU3YN6axj1wfTW3SFFGLR82rGaWUOi7edOsJ0d9mGMwH8dsv88GHGH3HSLxpsikPON9KckSeQAMnDbkYDR7+XdgXgBoTgqvwd/xAC8N4AsqYAoKaNV1S7Y6eAx6JtLn27WX0NqDDbSdIKJPeKUomDL6hsprJgJxlZ1x49vRJYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NYRh5pJ/; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43G8a5ET051699;
	Tue, 16 Apr 2024 03:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713256565;
	bh=gunZQjBXlTN74AuFxyYpvMjk5/cg4ebKFt9lvmAInR0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NYRh5pJ/awzVIVr4sD0Qm2nOpnz+fNtcJuwBVUH09sLg4gr37FOxU/L1UY1w/cTMV
	 jxqZaAOI86/Aa1lA/vToagLbAxf/77FVw1WdPdL6DJRa1tM1yzlFlugUFkhNdnUeTi
	 5cIgmeWO1Rz+oHEqVHNrdtLYDgDfOZEbX1bSFLlc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43G8a5Uj060264
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Apr 2024 03:36:05 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 03:36:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 03:36:05 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43G8a0Dr067512;
	Tue, 16 Apr 2024 03:36:01 -0500
Message-ID: <dc4563a4-949a-4e5e-a87b-2068a42eea85@ti.com>
Date: Tue, 16 Apr 2024 14:05:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] net: ethernet: ti: am65-cpts: Enable RX
 HW timestamp for PTP packets using CPTS FIFO
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240402114405.219100-1-c-vankar@ti.com>
 <20240402114405.219100-2-c-vankar@ti.com>
 <7c8be16329668d343a971e265e923543cba5e304.camel@redhat.com>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <7c8be16329668d343a971e265e923543cba5e304.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 04/04/24 16:10, Paolo Abeni wrote:
> On Tue, 2024-04-02 at 17:14 +0530, Chintan Vankar wrote:
>> Add a new function "am65_cpts_rx_timestamp()" which checks for PTP
>> packets from header and timestamps them.
>>
>> Add another function "am65_cpts_find_rx_ts()" which finds CPTS FIFO
>> Event to get the timestamp of received PTP packet.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v4:
>> https://lore.kernel.org/r/20240327054234.1906957-1-c-vankar@ti.com/
>>
>> Changes from v4 to v5:
>> - Updated commit message.
>> - Replaced "list_del_entry()" and "list_add()" functions with equivalent
>>    "list_move()" function.
>>
>>   drivers/net/ethernet/ti/am65-cpts.c | 64 +++++++++++++++++++++++++++++
>>   drivers/net/ethernet/ti/am65-cpts.h |  6 +++
>>   2 files changed, 70 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
>> index c66618d91c28..bc0bfda1db12 100644
>> --- a/drivers/net/ethernet/ti/am65-cpts.c
>> +++ b/drivers/net/ethernet/ti/am65-cpts.c
>> @@ -906,6 +906,70 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>>   	return 1;
>>   }
>>   
>> +static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
>> +{
>> +	struct list_head *this, *next;
>> +	struct am65_cpts_event *event;
>> +	unsigned long flags;
>> +	u32 mtype_seqid;
>> +	u64 ns = 0;
>> +
>> +	am65_cpts_fifo_read(cpts);
>> +	spin_lock_irqsave(&cpts->lock, flags);
> 
> am65_cpts_fifo_read() acquires and releases this same lock. If moving
> to a lockless schema is too complex, you should at least try to acquire
> the lock only once. e.g. factor out a lockless  __am65_cpts_fifo_read
> variant and explicitly acquire the lock before invoke it.
> 

Moving to a lockless schema is complex for now, but I will make the
changes suggested by you in next version.

>> +	list_for_each_safe(this, next, &cpts->events) {
>> +		event = list_entry(this, struct am65_cpts_event, list);
>> +		if (time_after(jiffies, event->tmo)) {
>> +			list_del_init(&event->list);
>> +			list_add(&event->list, &cpts->pool);
> 
> Jakub suggested to use list_move() in v4, you should apply that here,
> too.
> 
Okay. I will update that too.

> Cheers,
> 
> Paolo
> 
> 

