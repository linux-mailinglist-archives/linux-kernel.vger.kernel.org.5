Return-Path: <linux-kernel+bounces-104398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857887CD40
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87DC283A86
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361D1C698;
	Fri, 15 Mar 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZaYhj6ml"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921C1AAD2;
	Fri, 15 Mar 2024 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505776; cv=none; b=kxy3eXM0CdPYY4FAnf1PyP6GiMDlY4pIEGgG7yVr6UuqqQMdEdNsYBn6JYRWfulLkNStAP6sAKqrrORLcXyRTw6vJ2IU3auFCDLfOFbmcsJ2MLxHMebXJzcOczjyKrMaEckxuHEfW8VKr0F35ehonHNuWpvV8RNRtn+w8zvPzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505776; c=relaxed/simple;
	bh=zSg0JLnzu3b+mexUHYjuBLoiSrX/RKbZ+snbm57/7eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGCvKW8dI07gUWRl9ho3a4S2I3lL6R24Mcm1rDYgE4a6IsHJreibLhZQ69S4fKD0J74g6VmqBWLon85EzDMIPILO2bB8UtRRbGcQp9BaDGprinLQM4uuXN7h+vEcpjiTHUwSKsX+AwBcVLetKVzr62kTGLGMClfAE8MyIWmYFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZaYhj6ml; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710505769; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DLwbbjen0CAQVgzQqgyS6vV9v1Bn0lmRB2jT8Yg8TYw=;
	b=ZaYhj6mloaGhZQ70/6HNnAjHH9WmhExcnjLX+euJIqEX3VF2+/wN+5iS0erg2U8V9PR1ai3mXoC4EMKyyHKrMxW6eeY81wTDj65hGc5pItixveDf7qysQ60Te5OTXLlC16nK1wdFHMGgfB9NOZ32xbXqukYSvxqJcm6kvROVLwI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2XNO79_1710505767;
Received: from 30.221.129.129(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2XNO79_1710505767)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 20:29:28 +0800
Message-ID: <d69885a1-c85f-4d26-a615-fbf6968e2c40@linux.alibaba.com>
Date: Fri, 15 Mar 2024 20:29:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/11] net/smc: adapt SMC-D device dump for
 Emulated-ISM
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240312142743.41406-1-guwen@linux.alibaba.com>
 <20240312142743.41406-2-guwen@linux.alibaba.com>
 <caab067b-f5c3-490f-9259-262624c236b4@linux.ibm.com>
 <a6e4c563-e1d4-44ae-bfab-a0021584220f@linux.alibaba.com>
 <ef98b16d-2965-4297-a2ed-143b0b592a25@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ef98b16d-2965-4297-a2ed-143b0b592a25@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/15 18:27, Jan Karcher wrote:
> 
> 
> On 15/03/2024 04:44, Wen Gu wrote:
>>
>>
>> On 2024/3/14 18:23, Jan Karcher wrote:
>>>
>>>
>>> On 12/03/2024 15:27, Wen Gu wrote:
>>>> The introduction of Emulated-ISM requires adaptation of SMC-D device
>>>> dump. Software implemented non-PCI device (loopback-ism) should be
>>>> handled correctly and the CHID reserved for Emulated-ISM should be got
>>>> from smcd_ops interface instead of PCI information.
>>>>
>>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>>> ---
>>>>   net/smc/smc_ism.c | 13 ++++++++++---
>>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>>>> index ac88de2a06a0..b6eca4231913 100644
>>>> --- a/net/smc/smc_ism.c
>>>> +++ b/net/smc/smc_ism.c
>>>> @@ -252,12 +252,11 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>>>>       char smc_pnet[SMC_MAX_PNETID_LEN + 1];
>>>>       struct smc_pci_dev smc_pci_dev;
>>>>       struct nlattr *port_attrs;
>>>> +    struct device *device;
>>>>       struct nlattr *attrs;
>>>> -    struct ism_dev *ism;
>>>>       int use_cnt = 0;
>>>>       void *nlh;
>>>> -    ism = smcd->priv;
>>>>       nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
>>>>                 &smc_gen_nl_family, NLM_F_MULTI,
>>>>                 SMC_NETLINK_GET_DEV_SMCD);
>>>> @@ -272,7 +271,15 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>>>>       if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
>>>>           goto errattr;
>>>>       memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
>>>> -    smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
>>>> +    device = smcd->ops->get_dev(smcd);
>>>> +    if (device->parent)
>>>> +        smc_set_pci_values(to_pci_dev(device->parent), &smc_pci_dev);
>>>> +    if (smc_ism_is_emulated(smcd)) {
>>>> +        smc_pci_dev.pci_pchid = smc_ism_get_chid(smcd);
>>>> +        if (!device->parent)
>>>> +            snprintf(smc_pci_dev.pci_id, sizeof(smc_pci_dev.pci_id),
>>>> +                 "%s", dev_name(device));
>>>> +    }
>>>
>>> Hi Wen Gu,
>>>
>>> playing around with the loopback-ism device and testing it, i developed some concerns regarding this exposure. 
>>> Basically this enables us to see the loopback device in the `smcd device` tool without any changes.
>>> E.g.:
>>> ```
>>> # smcd device
>>> FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>>> 0000 0     loopback-ism  ffff   No        0
>>> 102a ISM   0000:00:00.0  07c2   No        0  NET1
>>> ```
>>>
>>> Now the problem with this is that "loopback-ism" is no valid PCI-ID and should not be there. My first thought was to 
>>> put an "n/a" instead, but that opens up another problem. Currently you could set - even if it does not make sense - a 
>>> PNET_ID for the loopback device:
>>> ```
>>
>> Yes, and we can exclude loopback-ism in smc_pnet_enter() if necessary.
> 
> We could, but we have to make sure we implement those distinctions at the right location. E.g.: if virtio-ism is coming. 
> Does a PNETID make sense for a virtio-ism device? Do we want to exclude is also there or do we want an abstracted 
> layer/mechanism to recognize if a device has a PNETId capability or not?
> 

Understand, a long-term view is better.

>>
>>> # smc_pnet -a -D loopback-ism NET1
>>> # smcd device
>>> FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>>> 0000 0     loopback-ism  ffff   No        0  *NET1
>>> 102a ISM   0000:00:00.0  07c2   No        0  NET1
>>> ```
>>> If we would change the PCI-ID to "n/a" it would be a valid input parameter for the tooling which is... to put it 
>>> nice... not so beautiful.
>>
>> FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>> 0000 0     n/a           ffff   No        0
>>
>> IIUC, the problem is that the 'n/a', which would be an input for other tools, is somewhat strange?
> 
> Exactly.
> 
>>
>> Since PCHID 0xffff is clear defined for loopback-ism, I am wondering if it can be a specific sign
>> of loopback-ism for tooling to not take PCI-ID into account? Would you also consider that inelegant?
> 
> I think deciding on PCHID is the only way we can currently differentiate what kind of device we are talking about. So my 
> guess would be that PCHID is going to play a big role in future design decisions.
> 

Make sense to me.

>>
>>> I brainstormed this with them team and the problem is more complex.
>>> In theory there shouldn't be PCI information set for the loopback device. There should be a better abstraction in the 
>>> netlink interface that creates this output and the tooling should be made aware of it.
>>>
>>
>> Yes, it is better. But I couldn't surely picture how the abstraction looks like, and if it is necessary
>> to introduce it just for a special case of loopback-ism (note that virtio-ISM also has PCI information),
>> since we can identify loopback-ism by CHID.
> 
> Please take the following with a grain of salt. I just want to give you a bit insight of our current train of thought. 
> None of it is final or set in stone. The idea would be to have device core information that contain the information 
> which other fields are important for this device. And corresponding "extensions" that contain the information. The 
> tooling cvould then decide soley on the core information which features are supported by a device and which are not.
> If that is really needed: Not sure yet. Is this the best solution: Propably not.
> E.g.:
> 
> SMC-D netlink abstraction
> 
> +------------------------------------+
> | Core information                   |
> | (e.g. PCHID, InUse, isPCI, isS390) |
> +------------------------------------+
> 
> +----------------+
> | s390 extension |
> | (e.g.FID)      |
> +----------------+
> 
> +--------------------+
> | PCI extension      |
> | (e.g. PCI-ID, ...) |
> +--------------------+
> 
> 

I like this diagram and it is very clear. So core information will be applicable to all ISM devices,
and the extension information will be specific to some certain kinds.

>>
>>> Do you rely on the output currently? What are your thoughts about it?
>>> If not I'd ask you to not fill the netlink interface for the loopback device and refactor it with the next stage when 
>>> we create a right interface for it.
>>>
>>
>> Currently we don't rely on the output, and I have no objection to the proposal that not fill the netlink
>> interface for loopback-ism and refactor it in the next stage.
> 
> Thank you! If you have ideas regarding the design of the interface hit us up. As soon as we are going to think about 
> this further I'm going to invite you to those discussions.
>

Sure! and thank you very much!


Best regards,
Wen Gu

>> >>> Since the Merge-Window is closed feel free to send new versions as RFC.
>>
>> OK, I will send the new version as an RFC.
>>
>> Thank you!
> 
> Thanks!
> - Jan
> 
>>
>>> Thank you
>>> - Jan
>>>
>>>>       if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
>>>>           goto errattr;
>>>>       if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))

