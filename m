Return-Path: <linux-kernel+bounces-88296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1026286DFD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFD2B22A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673226CBF4;
	Fri,  1 Mar 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xems7rTN"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D023BD;
	Fri,  1 Mar 2024 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291227; cv=none; b=uUKQSFK59b4Rh14Kxpd8bFLBbZ9Xlw6kWuW7V5wZZ8hW9rOSbgDR1Y9W2CeeXOwYG5yzsA7OOoO/uPxS/nrp5WkL8MWQXzaX8d+/sNFwlolMqpHxfEGnMk8rIcA12g4bX+iNq2zYUYtDg8Ms/5gOm8EDLQDpb1lRcRUukU/pzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291227; c=relaxed/simple;
	bh=5bFpmhJNutqaRHya9G5up6sRV/+gFMoxq43MQp2WWm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dw4C8HrjurwooTglxi5EdnY4fuEyHalJBbsH+fTjoZ0Fs2wc9tNi9VKG0lOc690OTryNRc6gkfOGcrCVYQvYcU8wq74CqnTLMukxTHvON8udTVYQePK6+VwObLZx0vSh+LyqCMzNt5o62LRfOt+gUtMsrwmldW3+MTGBcPt03m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xems7rTN; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 421B6tKh118925;
	Fri, 1 Mar 2024 05:06:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709291215;
	bh=K0ubzdlroUOBglVY3S/rVyrZxp/5zoLq78kaG6y7qwk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xems7rTNX/wBUTAhgzrViEwtkw/6X8Pc4dYyzjkvDq7CNycNe7f/sqWyknT5BSCPW
	 21brxT62jDi7MQKOWJKlbT2ednsZbaty36Fnw0AHUro8hyGpK+0FSxwIu/W1FcX7Hy
	 p8wa6VuUP79r9vRi1dheXW6gtkl2q2vf02Flc84w=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 421B6t0b105933
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Mar 2024 05:06:55 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Mar 2024 05:06:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Mar 2024 05:06:54 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 421B6oD0085832;
	Fri, 1 Mar 2024 05:06:51 -0600
Message-ID: <750369ae-71ef-4c07-8c61-14c0cd06ef4b@ti.com>
Date: Fri, 1 Mar 2024 16:36:50 +0530
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
 <3713e01e-1e48-489b-8ec2-e98471ca22f0@ti.com>
 <0f62faa4-608f-4e8e-98e5-7e6e50e20308@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <0f62faa4-608f-4e8e-98e5-7e6e50e20308@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 26/02/24 18:19, Roger Quadros wrote:
> 
> 
> On 26/02/2024 11:08, Chintan Vankar wrote:
>>
>> On 19/02/24 16:54, Roger Quadros wrote:
>>>
>>> On 15/02/2024 13:09, Chintan Vankar wrote:
>>>> CPTS module supports capturing timestamp for every packet it receives,
>>>> add a new function named "am65_cpts_rx_find_ts()" to get the timestamp
>>>> of received packets from CPTS FIFO.
>>>>
>>>> Add another function named "am65_cpts_rx_timestamp()" which internally
>>>> calls "am65_cpts_rx_find_ts()" function and timestamps the received
>>>> PTP packets.
>>>>
>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>>> ---
>>>>    drivers/net/ethernet/ti/am65-cpts.c | 84 +++++++++++++++++++++--------
>>>>    drivers/net/ethernet/ti/am65-cpts.h | 11 ++--
>>>>    2 files changed, 67 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
>>>> index c66618d91c28..92a3b40e60d6 100644
>>>> --- a/drivers/net/ethernet/ti/am65-cpts.c
>>>> +++ b/drivers/net/ethernet/ti/am65-cpts.c
>>>> @@ -859,29 +859,6 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
>>>>        return delay;
>>>>    }
>>>>    -/**
>>>> - * am65_cpts_rx_enable - enable rx timestamping
>>>> - * @cpts: cpts handle
>>>> - * @en: enable
>>>> - *
>>>> - * This functions enables rx packets timestamping. The CPTS can timestamp all
>>>> - * rx packets.
>>>> - */
>>>> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
>>>> -{
>>>> -    u32 val;
>>>> -
>>>> -    mutex_lock(&cpts->ptp_clk_lock);
>>>> -    val = am65_cpts_read32(cpts, control);
>>>> -    if (en)
>>>> -        val |= AM65_CPTS_CONTROL_TSTAMP_EN;
>>>> -    else
>>>> -        val &= ~AM65_CPTS_CONTROL_TSTAMP_EN;
>>>> -    am65_cpts_write32(cpts, val, control);
>>>> -    mutex_unlock(&cpts->ptp_clk_lock);
>>>> -}
>>>> -EXPORT_SYMBOL_GPL(am65_cpts_rx_enable);
>>>> -
>>>>    static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>>>>    {
>>>>        unsigned int ptp_class = ptp_classify_raw(skb);
>>>> @@ -906,6 +883,67 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>>>>        return 1;
>>>>    }
>>>>    +static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, struct sk_buff *skb,
>>>> +                int ev_type, u32 skb_mtype_seqid)
>>>> +{
>>>> +    struct list_head *this, *next;
>>>> +    struct am65_cpts_event *event;
>>>> +    unsigned long flags;
>>>> +    u32 mtype_seqid;
>>>> +    u64 ns = 0;
>>>> +
>>>> +    am65_cpts_fifo_read(cpts);
>>> am65_cpts_fifo_read() is called from the CPTS interrupt handler and the
>>> event is popped out of the FIFO and pushed into an event list.
>>>
>>> Doesn't this race with that interrupt handler?
>> Could you clarify why there be a race condition ?
> 
> I'm not sure so was asking. The question is, do you have to call
> am65_cpts_fifo_read() here? If yes, could you please add a comment why.

Yes. We need to call "am65_cpts_fifo_read()" here. If we don't call it
here then there will be a race condition for the event to be added to
the list before "am65_cpts_get_rx_ts()" function is called.

If we have to implement it without invoking "am65_cpts_fifo_read()",
then there has to be a check to ensure that the interrupt associated
with the RX Event has successfully added that event to the list.
Otherwise, due to the nature of "spin_lock_irqsave", when the interrupt
has acquired the lock on one CPU, the "am65_cpts_get_rx_ts()" function
running on another CPU might acquire the lock from the interrupt and
search for the RX Event which the "am65_cpts_fifo_read()" invoked by
the interrupt was supposed to add in the event list. This is racy due
to which it is possible that the event is not yet added when
"am65_cpts_get_rx_ts()" is invoked. Therefore, to ensure that the
event is surely present, invoking "am65_cpts_fifo_read()" is
required.

> 
>>> Can't you use that event list instead of reading cpts_fifo directly?
>>>
>>> Something like am65_cpts_match_tx_ts()?
>>>
>>>> +    spin_lock_irqsave(&cpts->lock, flags);
>>>> +    list_for_each_safe(this, next, &cpts->events) {
>>>> +        event = list_entry(this, struct am65_cpts_event, list);
>>>> +        if (time_after(jiffies, event->tmo)) {
>>>> +            list_del_init(&event->list);
>>>> +            list_add(&event->list, &cpts->pool);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        mtype_seqid = event->event1 &
>>>> +                  (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
>>>> +                   AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK |
>>>> +                   AM65_CPTS_EVENT_1_EVENT_TYPE_MASK);
>>>> +
>>>> +        if (mtype_seqid == skb_mtype_seqid) {
>>>> +            ns = event->timestamp;
>>>> +            list_del_init(&event->list);
>>>> +            list_add(&event->list, &cpts->pool);
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +    spin_unlock_irqrestore(&cpts->lock, flags);
>>>> +
>>>> +    return ns;
>>>> +}
>>>> +
>>>> +void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
>>>> +{
>>>> +    struct am65_cpts_skb_cb_data *skb_cb = (struct am65_cpts_skb_cb_data *)skb->cb;
>>>> +    struct skb_shared_hwtstamps *ssh;
>>>> +    int ret;
>>>> +    u64 ns;
>>>> +
>>>> +    ret = am65_skb_get_mtype_seqid(skb, &skb_cb->skb_mtype_seqid);
>>>> +    if (!ret)
>>>> +        return; /* if not PTP class packet */
>>>> +
>>>> +    skb_cb->skb_mtype_seqid |= (AM65_CPTS_EV_RX << AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT);
>>>> +
>>>> +    dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
>>>> +
>>>> +    ns = am65_cpts_find_rx_ts(cpts, skb, AM65_CPTS_EV_RX, skb_cb->skb_mtype_seqid);
>>>> +    if (!ns)
>>>> +        return;
>>>> +
>>>> +    ssh = skb_hwtstamps(skb);
>>>> +    memset(ssh, 0, sizeof(*ssh));
>>>> +    ssh->hwtstamp = ns_to_ktime(ns);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(am65_cpts_rx_timestamp);
>>>> +
>>>>    /**
>>>>     * am65_cpts_tx_timestamp - save tx packet for timestamping
>>>>     * @cpts: cpts handle
>>>> diff --git a/drivers/net/ethernet/ti/am65-cpts.h b/drivers/net/ethernet/ti/am65-cpts.h
>>>> index 6e14df0be113..6099d772799d 100644
>>>> --- a/drivers/net/ethernet/ti/am65-cpts.h
>>>> +++ b/drivers/net/ethernet/ti/am65-cpts.h
>>>> @@ -22,9 +22,9 @@ void am65_cpts_release(struct am65_cpts *cpts);
>>>>    struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
>>>>                       struct device_node *node);
>>>>    int am65_cpts_phc_index(struct am65_cpts *cpts);
>>>> +void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>>>>    void am65_cpts_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>>>>    void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>>>> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en);
>>>>    u64 am65_cpts_ns_gettime(struct am65_cpts *cpts);
>>>>    int am65_cpts_estf_enable(struct am65_cpts *cpts, int idx,
>>>>                  struct am65_cpts_estf_cfg *cfg);
>>>> @@ -48,17 +48,18 @@ static inline int am65_cpts_phc_index(struct am65_cpts *cpts)
>>>>        return -1;
>>>>    }
>>>>    -static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
>>>> +static inline void am65_cpts_rx_timestamp(struct am65_cpts *cpts,
>>>>                          struct sk_buff *skb)
>>>>    {
>>>>    }
>>>>    -static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
>>>> -                           struct sk_buff *skb)
>>>> +static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
>>>> +                      struct sk_buff *skb)
>>>>    {
>>>>    }
>>>>    -static inline void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
>>>> +static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
>>>> +                           struct sk_buff *skb)
>>>>    {
>>>>    }
>>>>    
> 

