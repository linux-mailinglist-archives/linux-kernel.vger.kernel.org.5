Return-Path: <linux-kernel+bounces-142639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B798A2E25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E584928535C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E0D56B62;
	Fri, 12 Apr 2024 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QfVWyD20"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD125789E;
	Fri, 12 Apr 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924435; cv=none; b=MLUICN+oXAVACs6/X/RYROErfIPQWhMT23O6B+ZJvldIVehU86kknn9hsFbsRtHSCmlc1N/EZU+sdiZtHTSLJYUqrEKTFY35bw9bF5MiMHrX+PsctfF/UMyMGX7TmCgkasGAjwPd/Ijak6nRDG3sXxFQSHRKx3rOVkO26eNHm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924435; c=relaxed/simple;
	bh=9RbGazIluzu40/8gyLCXYyXA38l6vJhz/PRMZhuyIPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WKqh25su6iIuzPCZr2qUJ80tJHCZI6JhfKKvAI8LM8rp/JTPXQHTBT8hwwqaTCXreMUiNry+ZTuccx4YqeaF909Fsk/T2evhZjN1JxBBuoq1+7g3xA0rDr/2cetmtTlFN5O5KQkNsg6PxWcOIsYiyG9OutwmzvUTO5zViR5NgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QfVWyD20; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CAvXse023857;
	Fri, 12 Apr 2024 12:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RJC167otxpCflVENaNvvQ3B2EaoZd+dILAFx+Js9czQ=;
 b=QfVWyD208xEbFsvRDMChyNH5KvqGywCyZSfCrYl4LdoKNd0DQWplCFTGQlcnjuxQ8TSL
 oWFvqxkUxgMQGX+MTg0U0SAWe5pD651r/EAXBrFceZLcuo+fOIVUDY3AGmMDxT7vpSmW
 3BC83bJuVs1LL7/OX0r+u+SrO85VApaAlOf72neD21VShWvOujkvWJsRWPxOHvvxDwjI
 7D6TFgTCjG9vGdFk57fv8pl+N8B/gOc0x6eqCiuduBhY+rXekcU8WEnIaKrtX8U+Eqvu
 XGV6xf0VNTKJZ6Fdysh7WpkWMEyOCIuKToc2oq7H1fnXkVeEMacHtRTRzpZ4c/19Lvf3 vg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf3nag5ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 12:20:22 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CCKMT1030080;
	Fri, 12 Apr 2024 12:20:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf3nag5dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 12:20:22 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CAHCF0013539;
	Fri, 12 Apr 2024 12:20:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbgqu20g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 12:20:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CCKIC816450072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 12:20:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 586F058061;
	Fri, 12 Apr 2024 12:20:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56BDB5805A;
	Fri, 12 Apr 2024 12:20:15 +0000 (GMT)
Received: from [9.171.38.223] (unknown [9.171.38.223])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Apr 2024 12:20:15 +0000 (GMT)
Message-ID: <61c7fd44-c098-4b41-b142-1567a5f7405f@linux.ibm.com>
Date: Fri, 12 Apr 2024 14:20:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 04/11] net/smc: implement some unsupported
 operations of loopback-ism
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, twinkler@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <20240324135522.108564-5-guwen@linux.alibaba.com>
 <3122eece5b484abcf8d23f85d6c18c36f0b939ff.camel@linux.ibm.com>
 <1db6ccab-b49f-45d2-a93c-05b0f79371a3@linux.alibaba.com>
 <3b3ff37643e9030ec1246e67720683a2cf5660e5.camel@linux.ibm.com>
 <7a0fc481-658e-4c99-add7-ccbd5f9dce1e@linux.alibaba.com>
 <7291dd1b2d16fd9bbd90988ac5bcc3a46d17e3f4.camel@linux.ibm.com>
 <46e8e227-8058-4062-a9db-6b9c774f63cc@linux.alibaba.com>
 <12ae995f-4af4-4c6b-9130-04672d157293@linux.ibm.com>
 <44ea7d83-4fa7-427b-9d54-678f05fd09e9@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <44ea7d83-4fa7-427b-9d54-678f05fd09e9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8XH3RagV2NeEKpoasKjzk6Y7pQSEP-CN
X-Proofpoint-ORIG-GUID: pH9xfJr_Kx_RLKEyG8tazUKpF6wldmit
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120089



On 12.04.24 04:02, Wen Gu wrote:
> 
> 
> On 2024/4/11 19:12, Alexandra Winter wrote:
>>
>>
>> On 09.04.24 03:44, Wen Gu wrote:
>>>
>>>
>>> On 2024/4/4 23:15, Niklas Schnelle wrote:
>>>> On Thu, 2024-04-04 at 21:12 +0800, Wen Gu wrote:
>>>>>
>>>>> On 2024/4/4 19:42, Niklas Schnelle wrote:
>>>>>> On Thu, 2024-04-04 at 17:32 +0800, Wen Gu wrote:
>>>>>>>
>>>>>>> On 2024/4/4 00:25, Gerd Bayer wrote:
>>>>>>>> On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
>>>>>>>>> This implements some operations that loopback-ism does not support
>>>>>>>>> currently:
>>>>>>>>>      - vlan operations, since there is no strong use-case for it.
>>>>>>>>>      - signal_event operations, since there is no event to be 
>>>>>>>>> processed
>>>>>>>>> by the loopback-ism device.
>>>>>>>>
>>>>>>>> Hi Wen,
>>>>>>>>
>>>>>>>> I wonder if the these operations that are not supported by 
>>>>>>>> loopback-ism
>>>>>>>> should rather be marked "optional" in the struct smcd_ops, and the
>>>>>>>> calling code should call these only when they are implemented.
>>>>>>>>
>>>>>>>> Of course this would mean more changes to net/smc/smc_core.c - but
>>>>>>>> loopback-ism could omit these "boiler-plate" functions.
>>>>>>>>
>>>>>>>
>>>>>>> Hi Gerd.
>>>>>>>
>>>>>>> Thank you for the thoughts! I agree that checks like 
>>>>>>> 'if(smcd->ops->xxx)'
>>>>>>> can avoid the device driver from implementing unsupported 
>>>>>>> operations. But I
>>>>>>> am afraid that which operations need to be defined as 'optional' 
>>>>>>> may differ
>>>>>>> from different device perspectives (e.g. for loopback-ism they 
>>>>>>> are vlan-related
>>>>>>> opts and signal_event). So I perfer to simply let the smc 
>>>>>>> protocol assume
>>>>>>> that all operations have been implemented, and let drivers to 
>>>>>>> decide which
>>>>>>> ones are unsupported in implementation. What do you think?
>>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>
>>>>>> I agree with Gerd, in my opinion it is better to document ops as
>>>>>> optional and then allow their function pointers to be NULL and check
>>>>>> for that. Acting like they are supported and then they turn out to be
>>>>>> nops to me seems to contradict the principle of least surprises. I 
>>>>>> also
>>>>>> think we can find a subset of mandatory ops without which SMC-D is
>>>>>> impossible and then everything else should be optional.
>>>>>
>>>>> I see. If we all agree to classify smcd_ops into mandatory and 
>>>>> optional ones,
>>>>> I'll add a patch to mark the optional ops and check if they are 
>>>>> implemented.
>>>>
>>>> Keep in mind I don't speak for the SMC maintainers but that does sound
>>>> reasonable to me.
>>>>
>>>
>>> Hi Wenjia and Jan, do you have any comments on this and [1]? Thanks!
>>>
>>> [1] 
>>> https://lore.kernel.org/netdev/60b4aec0b4bf4474d651b653c86c280dafc4518a.camel@linux.ibm.com/
>>>
>>>>>
>>>>>>
>>>>>> As a first guess I think the following options may be mandatory:
>>>>>>
>>>>>> * query_remote_gid()
>>>>>> * register_dmb()/unregister_dmb()
>>>>>> * move_data()
>>>>>>      For this one could argue that either move_data() or
>>>>>>      attach_dmb()/detach_dmb() is required though personally I would
>>>>>>      prefer to always have move_data() as a fallback and simple API
>>>>>> * supports_v2()
>>>>>> * get_local_gid()
>>>>>> * get_chid()
>>>>>> * get_dev()
>>>>> I agree with this classification. Just one point, maybe we can take
>>>>> supports_v2() as an optional ops, like support_dmb_nocopy()? e.g. if
>>>>> it is not implemented, we treat it as an ISMv1.
>>>>>
>>>>> Thanks!
>>>>
>>>> Interpreting a NULL supports_v2() as not supporting v2 sounds
>>>> reasonable to me.
>>>
>>
>> Let me add my thoughts to the discussion:
>> For the vlan operations and signal_event operations that loopback-ism 
>> does
>> not support:
>> I like the idea to set the ops to NULL and make sure the caller checks 
>> that
>> and can live with it. That is readable and efficient.
>>
>> I don't think there is a need to discuss a strategy now, which ops 
>> could be
>> optional in the future. This is all inside the kernel. loopback-ism is 
>> even
>> inside the smc module. Such comments in the code get outdated very 
>> easily.
>>
>> I would propose to mark those as optional struct smcd_ops, where all 
>> callers can
>> handle a NULL pointer and still be productive.
>> Future support of other devices for SMC-D can update that.
>>
>>
> 
> Hi Sandy, just to confirm if I understand you correctly.
> 
> You are proposing that don't draw a conclusion about the classification 
> now,
> but supplementally mark which one become a optional operation in struct 
> smcd_ops
> during the introduction of new devices for SMC-D.

@Sandy, could you please elaborate your proposal, or comfirm what Wen 
interpreted is what you mean?
If it is like what he said. IMO, I don't think it's necessary to dicuss 
further on which ops could be mandatory or optional. It's actually clear 
to me which are mandatory. And the classification should be much cleaner 
for our code. However, I agree that the classification is not really in 
the scope of this patches series. Especially if it is too expensive to 
rebuild it, we do need a seperate set of cleanup patches to do it. Thus, 
I'd like to let Wen take the decisions by ihmself. Any objections?

@All, if anyone has any strong opinion, I appreciate it if you could 
bring up your options as soon as possible. That would help us to 
accelerate the whole process.

Thanks,
Wenjia


