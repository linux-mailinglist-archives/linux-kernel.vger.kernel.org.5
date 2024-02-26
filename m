Return-Path: <linux-kernel+bounces-81009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208EF866EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D6C1F2732F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02CE7CF13;
	Mon, 26 Feb 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EEmI43gj"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C323768;
	Mon, 26 Feb 2024 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938526; cv=none; b=qQidX/St4XsX3daKRiKFgLo7mlLMzfWs156UD84eh46Hsv8W9JS7A6CHd46h2acE35wcwdMBkp4c0abio/cVfVWek/MDfGN5nmBKy4syyZuH4yvb6B/rxMI2HXVf9yhKbFSFWp9ZD6dRC02wm2qo5Ksy1Ewq5SminLrVEGji524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938526; c=relaxed/simple;
	bh=U01h9L1+UkCeGva9sz0XcyySArX+WnZPXS9U7CDy9hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ILxxV36UHJEtNlx1EEPMIGJqVzy8rq/EI1uuHRS99NBKlLv5i/apOTvvKtnI0Afp0heTcncFgKdTXN0U8q3soG1A12uK0wlUGS2VV8xmlSj/CzOjNFZxLZnbzTwXwQHYsWxJqq229raDJ98+yjT6Ha0n9GPi4dfz57ukpkwPeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EEmI43gj; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41Q98ZsA026841;
	Mon, 26 Feb 2024 03:08:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708938515;
	bh=4Iem/3dn5S2Id6pTl2iaGP7FvOdBnbe8AXCqGJhP8Co=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EEmI43gjg3VvNlq7JsDYLM8YsQQnwG5K5xEI9xScMrURAYtMFaZ9N3mTQ7uVDseVg
	 mJrz6Yzqe3DZz14wQxWy+y96mjpRUT9RK+Xe3duy4XN46KqO9ekwWu1jXIjxqMtJrz
	 JZZ8wvcNwqYHPd5RvcvuxYNOgm/3VoXQ3UMpa4Z8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41Q98ZWZ045234
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Feb 2024 03:08:35 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 03:08:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 03:08:34 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41Q98VLK064302;
	Mon, 26 Feb 2024 03:08:32 -0600
Message-ID: <3713e01e-1e48-489b-8ec2-e98471ca22f0@ti.com>
Date: Mon, 26 Feb 2024 14:38:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ethernet: ti: am65-cpts: Enable PTP RX
 HW timestamp using CPTS FIFO
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240215110953.3225099-1-c-vankar@ti.com>
 <52ff5e18-3616-478a-ab40-8f9a6f7f3e37@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <52ff5e18-3616-478a-ab40-8f9a6f7f3e37@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 19/02/24 16:54, Roger Quadros wrote:
>
> On 15/02/2024 13:09, Chintan Vankar wrote:
>> CPTS module supports capturing timestamp for every packet it receives,
>> add a new function named "am65_cpts_rx_find_ts()" to get the timestamp
>> of received packets from CPTS FIFO.
>>
>> Add another function named "am65_cpts_rx_timestamp()" which internally
>> calls "am65_cpts_rx_find_ts()" function and timestamps the received
>> PTP packets.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>   drivers/net/ethernet/ti/am65-cpts.c | 84 +++++++++++++++++++++--------
>>   drivers/net/ethernet/ti/am65-cpts.h | 11 ++--
>>   2 files changed, 67 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
>> index c66618d91c28..92a3b40e60d6 100644
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
>> -
>>   static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>>   {
>>   	unsigned int ptp_class = ptp_classify_raw(skb);
>> @@ -906,6 +883,67 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
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
> am65_cpts_fifo_read() is called from the CPTS interrupt handler and the
> event is popped out of the FIFO and pushed into an event list.
>
> Doesn't this race with that interrupt handler?
Could you clarify why there be a race condition ?
> Can't you use that event list instead of reading cpts_fifo directly?
>
> Something like am65_cpts_match_tx_ts()?
>
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
>> +
>> +	return ns;
>> +}
>> +
>> +void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
>> +{
>> +	struct am65_cpts_skb_cb_data *skb_cb = (struct am65_cpts_skb_cb_data *)skb->cb;
>> +	struct skb_shared_hwtstamps *ssh;
>> +	int ret;
>> +	u64 ns;
>> +
>> +	ret = am65_skb_get_mtype_seqid(skb, &skb_cb->skb_mtype_seqid);
>> +	if (!ret)
>> +		return; /* if not PTP class packet */
>> +
>> +	skb_cb->skb_mtype_seqid |= (AM65_CPTS_EV_RX << AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT);
>> +
>> +	dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
>> +
>> +	ns = am65_cpts_find_rx_ts(cpts, skb, AM65_CPTS_EV_RX, skb_cb->skb_mtype_seqid);
>> +	if (!ns)
>> +		return;
>> +
>> +	ssh = skb_hwtstamps(skb);
>> +	memset(ssh, 0, sizeof(*ssh));
>> +	ssh->hwtstamp = ns_to_ktime(ns);
>> +}
>> +EXPORT_SYMBOL_GPL(am65_cpts_rx_timestamp);
>> +
>>   /**
>>    * am65_cpts_tx_timestamp - save tx packet for timestamping
>>    * @cpts: cpts handle
>> diff --git a/drivers/net/ethernet/ti/am65-cpts.h b/drivers/net/ethernet/ti/am65-cpts.h
>> index 6e14df0be113..6099d772799d 100644
>> --- a/drivers/net/ethernet/ti/am65-cpts.h
>> +++ b/drivers/net/ethernet/ti/am65-cpts.h
>> @@ -22,9 +22,9 @@ void am65_cpts_release(struct am65_cpts *cpts);
>>   struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
>>   				   struct device_node *node);
>>   int am65_cpts_phc_index(struct am65_cpts *cpts);
>> +void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>>   void am65_cpts_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>>   void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en);
>>   u64 am65_cpts_ns_gettime(struct am65_cpts *cpts);
>>   int am65_cpts_estf_enable(struct am65_cpts *cpts, int idx,
>>   			  struct am65_cpts_estf_cfg *cfg);
>> @@ -48,17 +48,18 @@ static inline int am65_cpts_phc_index(struct am65_cpts *cpts)
>>   	return -1;
>>   }
>>   
>> -static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
>> +static inline void am65_cpts_rx_timestamp(struct am65_cpts *cpts,
>>   					  struct sk_buff *skb)
>>   {
>>   }
>>   
>> -static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
>> -					       struct sk_buff *skb)
>> +static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
>> +					  struct sk_buff *skb)
>>   {
>>   }
>>   
>> -static inline void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
>> +static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
>> +					       struct sk_buff *skb)
>>   {
>>   }
>>   

