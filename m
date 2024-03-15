Return-Path: <linux-kernel+bounces-104261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D187CB60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF0D1C20D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F418C08;
	Fri, 15 Mar 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B52dFGlI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E28182AE;
	Fri, 15 Mar 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498591; cv=none; b=tC6WJAb9Oi2/vy0+ibG4qdraPZgldfLIZ5C2S4MBOYPcBFX4qRCinDuMDqGxLzopZvvIOHxd0fYeWOD2LPBEa4seALVJD1eMmJIsPVQ3OHDii2l2xVuy2SWZJdiwDMHbPxdMxTIDuD9FW7E1fDrghvcs3PBtsDV/XgyAybc0J9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498591; c=relaxed/simple;
	bh=MdR9Rgj6lYbnvYBc5Ry+EeGq9GbsLqebF8J2pH4Rs2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXhnlyZsXxT5XUZxImAANjCQCHNnEMCvis9Iy1c9z5Uh+CJiHv7auz0sRfZvRtHejNI/UltHKFRd53weL4JsNSknmd1bqJp1FNcqANtQPcqz+SxhvHE05UL3vVfs1kFdkoVFq3BEic29ThIIZyMQdFOEPr5rsFpxcS48L3iUPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B52dFGlI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42F8vKqW009801;
	Fri, 15 Mar 2024 10:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Qv/ns6i5YE/Ff9QJj3RIHIOHrMPS5bhUM3j/hsm8baA=;
 b=B52dFGlI1KNYDOQZJtZlC9h4p0mC7L9v3qO0bsrwNNob7vpzQKEysh8hJCrb1ItfmNXO
 jcj9e2P6uQsXPm86rqRqhwfS7aHYshA6yjCmVX+qBZ0wW60rjLbYFw+k/DXKdhN0mdhz
 4n6lYO2eIU8ausMb7mom93NEHxsdcCMI9vql3ZGxhdGk0Bi/r8GA0JbyXpBK7jJ8h9jb
 XVhDgOcJKDZZfutAOT8ZPaW4Krl2NfUpmLq+fvwvW5hC5ZNuYmFzECXvMLk6GXlDMYD7
 zmK7YNZeneVTyXn4vwVNUbxllEXykjN7+rnvgt/EY0rwr5qPzROGVlox1YVbGqn7IiIz 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvk96h0dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 10:29:37 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42FATalM017963;
	Fri, 15 Mar 2024 10:29:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvk96h0bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 10:29:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42F97H2l018155;
	Fri, 15 Mar 2024 10:27:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23tue9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 10:27:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FARUs834144638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 10:27:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 343A02005A;
	Fri, 15 Mar 2024 10:27:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFE8420043;
	Fri, 15 Mar 2024 10:27:28 +0000 (GMT)
Received: from [9.171.8.212] (unknown [9.171.8.212])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 10:27:28 +0000 (GMT)
Message-ID: <ef98b16d-2965-4297-a2ed-143b0b592a25@linux.ibm.com>
Date: Fri, 15 Mar 2024 11:27:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/11] net/smc: adapt SMC-D device dump for
 Emulated-ISM
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240312142743.41406-1-guwen@linux.alibaba.com>
 <20240312142743.41406-2-guwen@linux.alibaba.com>
 <caab067b-f5c3-490f-9259-262624c236b4@linux.ibm.com>
 <a6e4c563-e1d4-44ae-bfab-a0021584220f@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <a6e4c563-e1d4-44ae-bfab-a0021584220f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oEwCmu99UV7vREH5MKSDphISc6tEivza
X-Proofpoint-GUID: cFdS7VR90OoK6LTTeGo30vThpscFQisn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403150085



On 15/03/2024 04:44, Wen Gu wrote:
> 
> 
> On 2024/3/14 18:23, Jan Karcher wrote:
>>
>>
>> On 12/03/2024 15:27, Wen Gu wrote:
>>> The introduction of Emulated-ISM requires adaptation of SMC-D device
>>> dump. Software implemented non-PCI device (loopback-ism) should be
>>> handled correctly and the CHID reserved for Emulated-ISM should be got
>>> from smcd_ops interface instead of PCI information.
>>>
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>>>   net/smc/smc_ism.c | 13 ++++++++++---
>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>>> index ac88de2a06a0..b6eca4231913 100644
>>> --- a/net/smc/smc_ism.c
>>> +++ b/net/smc/smc_ism.c
>>> @@ -252,12 +252,11 @@ static int smc_nl_handle_smcd_dev(struct 
>>> smcd_dev *smcd,
>>>       char smc_pnet[SMC_MAX_PNETID_LEN + 1];
>>>       struct smc_pci_dev smc_pci_dev;
>>>       struct nlattr *port_attrs;
>>> +    struct device *device;
>>>       struct nlattr *attrs;
>>> -    struct ism_dev *ism;
>>>       int use_cnt = 0;
>>>       void *nlh;
>>> -    ism = smcd->priv;
>>>       nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, 
>>> cb->nlh->nlmsg_seq,
>>>                 &smc_gen_nl_family, NLM_F_MULTI,
>>>                 SMC_NETLINK_GET_DEV_SMCD);
>>> @@ -272,7 +271,15 @@ static int smc_nl_handle_smcd_dev(struct 
>>> smcd_dev *smcd,
>>>       if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
>>>           goto errattr;
>>>       memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
>>> -    smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
>>> +    device = smcd->ops->get_dev(smcd);
>>> +    if (device->parent)
>>> +        smc_set_pci_values(to_pci_dev(device->parent), &smc_pci_dev);
>>> +    if (smc_ism_is_emulated(smcd)) {
>>> +        smc_pci_dev.pci_pchid = smc_ism_get_chid(smcd);
>>> +        if (!device->parent)
>>> +            snprintf(smc_pci_dev.pci_id, sizeof(smc_pci_dev.pci_id),
>>> +                 "%s", dev_name(device));
>>> +    }
>>
>> Hi Wen Gu,
>>
>> playing around with the loopback-ism device and testing it, i 
>> developed some concerns regarding this exposure. Basically this 
>> enables us to see the loopback device in the `smcd device` tool 
>> without any changes.
>> E.g.:
>> ```
>> # smcd device
>> FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>> 0000 0     loopback-ism  ffff   No        0
>> 102a ISM   0000:00:00.0  07c2   No        0  NET1
>> ```
>>
>> Now the problem with this is that "loopback-ism" is no valid PCI-ID 
>> and should not be there. My first thought was to put an "n/a" instead, 
>> but that opens up another problem. Currently you could set - even if 
>> it does not make sense - a PNET_ID for the loopback device:
>> ```
> 
> Yes, and we can exclude loopback-ism in smc_pnet_enter() if necessary.

We could, but we have to make sure we implement those distinctions at 
the right location. E.g.: if virtio-ism is coming. Does a PNETID make 
sense for a virtio-ism device? Do we want to exclude is also there or do 
we want an abstracted layer/mechanism to recognize if a device has a 
PNETId capability or not?

> 
>> # smc_pnet -a -D loopback-ism NET1
>> # smcd device
>> FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>> 0000 0     loopback-ism  ffff   No        0  *NET1
>> 102a ISM   0000:00:00.0  07c2   No        0  NET1
>> ```
>> If we would change the PCI-ID to "n/a" it would be a valid input 
>> parameter for the tooling which is... to put it nice... not so beautiful.
> 
> FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
> 0000 0     n/a           ffff   No        0
> 
> IIUC, the problem is that the 'n/a', which would be an input for other 
> tools, is somewhat strange?

Exactly.

> 
> Since PCHID 0xffff is clear defined for loopback-ism, I am wondering if 
> it can be a specific sign
> of loopback-ism for tooling to not take PCI-ID into account? Would you 
> also consider that inelegant?

I think deciding on PCHID is the only way we can currently differentiate 
what kind of device we are talking about. So my guess would be that 
PCHID is going to play a big role in future design decisions.

> 
>> I brainstormed this with them team and the problem is more complex.
>> In theory there shouldn't be PCI information set for the loopback 
>> device. There should be a better abstraction in the netlink interface 
>> that creates this output and the tooling should be made aware of it.
>>
> 
> Yes, it is better. But I couldn't surely picture how the abstraction 
> looks like, and if it is necessary
> to introduce it just for a special case of loopback-ism (note that 
> virtio-ISM also has PCI information),
> since we can identify loopback-ism by CHID.

Please take the following with a grain of salt. I just want to give you 
a bit insight of our current train of thought. None of it is final or 
set in stone. The idea would be to have device core information that 
contain the information which other fields are important for this 
device. And corresponding "extensions" that contain the information. The 
tooling cvould then decide soley on the core information which features 
are supported by a device and which are not.
If that is really needed: Not sure yet. Is this the best solution: 
Propably not.
E.g.:

SMC-D netlink abstraction

+------------------------------------+
| Core information                   |
| (e.g. PCHID, InUse, isPCI, isS390) |
+------------------------------------+

+----------------+
| s390 extension |
| (e.g.FID)      |
+----------------+

+--------------------+
| PCI extension      |
| (e.g. PCI-ID, ...) |
+--------------------+


> 
>> Do you rely on the output currently? What are your thoughts about it?
>> If not I'd ask you to not fill the netlink interface for the loopback 
>> device and refactor it with the next stage when we create a right 
>> interface for it.
>>
> 
> Currently we don't rely on the output, and I have no objection to the 
> proposal that not fill the netlink
> interface for loopback-ism and refactor it in the next stage.

Thank you! If you have ideas regarding the design of the interface hit 
us up. As soon as we are going to think about this further I'm going to 
invite you to those discussions.

> 
>> Since the Merge-Window is closed feel free to send new versions as RFC.
> 
> OK, I will send the new version as an RFC.
> 
> Thank you!

Thanks!
- Jan

> 
>> Thank you
>> - Jan
>>
>>>       if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
>>>           goto errattr;
>>>       if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))

