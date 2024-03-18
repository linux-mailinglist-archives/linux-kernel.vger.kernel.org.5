Return-Path: <linux-kernel+bounces-106048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A687E854
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963B61F25A16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9185374EF;
	Mon, 18 Mar 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vCvUgQ0n"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304B381AC;
	Mon, 18 Mar 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760372; cv=none; b=Al3o44r6zi19/HTYoGz3y0yPsH0W5hFQxT4OOsjbsL33W69/yufOnaiKfZgcmJpY5zJ6s8E5oXi5PRknpqs1gzJOc3oAUtjo3OEIS7fns8L0c283f6iMiVHSzREasxI0TMKysDTzCsws/FVyLpf/r15uPfvsLe+5GlGwKhmSXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760372; c=relaxed/simple;
	bh=DnVZF8SGVwGKINb0idkVhUywVWKD3UaEQ9II6Y0tp+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cHCXk92C+Jrw4fOyoIDQAT/Zj/yak2hm+B1T0Mn7V9taRwxL0XdDf0AliwhKn3N7ZJ25aOd6Bi14BlPtj7QEMJkwKkScFhgJBjCH8ceXTboekeq97gQVKchtMCzfIQ+TD3o83KE+hlXXnVi/jjFWDw5bvH6XRA0piHtUodiRz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vCvUgQ0n; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IBCUfc088930;
	Mon, 18 Mar 2024 06:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710760350;
	bh=DV4xGfeZV0MHV7EUiL5CPLZLpyUrr+cQbMmhRNUiEbU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vCvUgQ0no+l0m+XxSAIntTEFS5NRdg6Qg9ZfIyoCdnhCn7Epf1UxV01TV4MKOozmC
	 6gjGxyUGmnEz1t06ZqbIvoSc3s5hOGFtXDlrkOv0Shdr4gPnhECKcg1j9deVSiwxF2
	 MzwoiqsMCd1Z9UI9VF0/C44dE90V0uow2ekWqIbU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IBCUfW029670
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 06:12:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 06:12:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 06:12:30 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IBCQSs091840;
	Mon, 18 Mar 2024 06:12:26 -0500
Message-ID: <47f8db23-52b8-4a37-89b9-70e5ed4c8d83@ti.com>
Date: Mon, 18 Mar 2024 16:42:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: ethernet: ti: am65-cpts: Enable PTP RX HW
 timestamp using CPTS FIFO
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Grygorii
 Strashko" <grygorii.strashko@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, "Roger
 Quadros" <rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David
 S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240312100233.941763-1-c-vankar@ti.com>
 <dc45f4f104a0d0691715398d2f7efa6a0a3447b8.camel@redhat.com>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <dc45f4f104a0d0691715398d2f7efa6a0a3447b8.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 12/03/24 16:20, Paolo Abeni wrote:
> On Tue, 2024-03-12 at 15:32 +0530, Chintan Vankar wrote:
>> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
>> index c66618d91c28..6c1d571c5e0b 100644
>> --- a/drivers/net/ethernet/ti/am65-cpts.c
>> +++ b/drivers/net/ethernet/ti/am65-cpts.c
>> @@ -859,29 +859,6 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
>>   	return delay;
>>   }
>>   
>> -/**
>> - * am65_cpts_rx_enable - enable rx timestamping
>> - * @cpts: cpts handle
>> - * @en: enable
>> - *
>> - * This functions enables rx packets timestamping. The CPTS can timestamp all
>> - * rx packets.
>> - */
>> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
>> -{
>> -	u32 val;
>> -
>> -	mutex_lock(&cpts->ptp_clk_lock);
>> -	val = am65_cpts_read32(cpts, control);
>> -	if (en)
>> -		val |= AM65_CPTS_CONTROL_TSTAMP_EN;
>> -	else
>> -		val &= ~AM65_CPTS_CONTROL_TSTAMP_EN;
>> -	am65_cpts_write32(cpts, val, control);
>> -	mutex_unlock(&cpts->ptp_clk_lock);
>> -}
>> -EXPORT_SYMBOL_GPL(am65_cpts_rx_enable);
> 
> It looks like the above chunk will cause a transient build break, as
> the function is still in use and the caller will be removed by the next
> patch. I guess you should move this chunk there.

Thank you for your suggestion. I will update the patch with this
change in the next version.

> 
>> -
>>   static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>>   {
>>   	unsigned int ptp_class = ptp_classify_raw(skb);
>> @@ -906,6 +883,72 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>>   	return 1;
>>   }
>>   
>> +static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, struct sk_buff *skb,
>> +				int ev_type, u32 skb_mtype_seqid)
>> +{
>> +	struct list_head *this, *next;
>> +	struct am65_cpts_event *event;
>> +	unsigned long flags;
>> +	u32 mtype_seqid;
>> +	u64 ns = 0;
>> +
>> +	am65_cpts_fifo_read(cpts);
>> +	spin_lock_irqsave(&cpts->lock, flags);
>> +	list_for_each_safe(this, next, &cpts->events) {
>> +		event = list_entry(this, struct am65_cpts_event, list);
>> +		if (time_after(jiffies, event->tmo)) {
>> +			list_del_init(&event->list);
>> +			list_add(&event->list, &cpts->pool);
>> +			continue;
>> +		}
>> +
>> +		mtype_seqid = event->event1 &
>> +			      (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
>> +			       AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK |
>> +			       AM65_CPTS_EVENT_1_EVENT_TYPE_MASK);
>> +
>> +		if (mtype_seqid == skb_mtype_seqid) {
>> +			ns = event->timestamp;
>> +			list_del_init(&event->list);
>> +			list_add(&event->list, &cpts->pool);
>> +			break;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&cpts->lock, flags);
> 
> Ouch, you have to acquire an additional lock per packet and a lot of
> cacheline dithering.
> 
> Not strictly necessary for this series, but I suggest to invest some
> time reconsidering this schema, it looks bad from performance pov.
> 
> Possibly protecting the list with RCU and leaving the recycle to the
> producer could help.

Thank you for pointing out this. I will consider your point and spend
some time on it.

> 
> Additionally net-next is currently closed for the merge window, please
> post the new revision (including the target tree in the subj prefix)
> when net-next will re-open in ~2weeks.
> 
Thank you for information. I will update the patch and post its next
version with above mentioned changes.

> Cheers,
> 
> Paolo
> 

