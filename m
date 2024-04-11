Return-Path: <linux-kernel+bounces-140319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED638A12AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524371C21F94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E761482FC;
	Thu, 11 Apr 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QWJFcBlU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CECB1474BA;
	Thu, 11 Apr 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833959; cv=none; b=BQbBrcGB8NkcQ3IIkaptcUrxDXV/TjfspaNGTQZcVbmSi01us56+CqIEXsJ4iNhnJ8/7i0Zr1CJcimJH4NyyLDpWliepBE2wCqdWsspJdp/m2yUsrkRVyduT0Unv+nmp6t1T9UghmhdxwDXRwaDKSaXWQdwDXRkIGXJoBKioejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833959; c=relaxed/simple;
	bh=XWXUyl1Nz91NBxdPg+48EdN2ElgiJkR3ew64Yn5yz/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d5MAWuXLPLtdseCGh2x0VPQ6dTQ8NKUaD1ta/1H/BcYAjTgu6C38injBLZDtSfSscxxXV4oJfugCkCE7cy1wesIL1a+xqjh0fsnWJ+6+IznBqoLQnjjTxbPh+GPKiRhIL1m3F7hMBi6ZcUCWcV5/ma8lfNJ4B5leSNNLIum+Er4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QWJFcBlU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BAW5lC027333;
	Thu, 11 Apr 2024 11:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uhcvB6tpxrkxE/KaZ+ck3RH3SA1Z9JkugprvYlNNlwk=;
 b=QWJFcBlUByKAlYtOaYGkA8IRTEAbJODcZ945EbsZLdKxBHI6hiwSjqRFPPLUxTVp9CD4
 oaKs+pMb16VK8nL0CDf56CyosGxXQvpaGbcASX6138cUXuDR/rThAZd+W0UMZ1wUJ19d
 P+U24VUJZOzf4DI/a/GSnIlrgB8wUVk/OdE1ZAB9yzooD2hIO6NW6cDr30UjkJLMMI3f
 AZVxi/mRtfLWszRCVMwOwFJiQctqXCm7V+nP25ljgyVFgHnc6NuaYzVQ6DwP9LPDJi87
 D72LROOzInxQ1M6JAf0aEe13fZ2YlKIyF4JUfTsKPFHGgcS1drvAwg4O+XaVMB4el8JI eA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xebfy8eda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:12:30 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43BBCT3h021006;
	Thu, 11 Apr 2024 11:12:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xebfy8ed6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:12:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43B8ZDpV013544;
	Thu, 11 Apr 2024 11:12:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbgqtu1qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:12:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43BBCNUX16974168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 11:12:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC8CE2004B;
	Thu, 11 Apr 2024 11:12:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D04A20043;
	Thu, 11 Apr 2024 11:12:23 +0000 (GMT)
Received: from [9.152.224.141] (unknown [9.152.224.141])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Apr 2024 11:12:23 +0000 (GMT)
Message-ID: <12ae995f-4af4-4c6b-9130-04672d157293@linux.ibm.com>
Date: Thu, 11 Apr 2024 13:12:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 04/11] net/smc: implement some unsupported
 operations of loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, twinkler@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
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
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <46e8e227-8058-4062-a9db-6b9c774f63cc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lH8IiSDzd6CHB4tJ3S8jUQABn86FFQBx
X-Proofpoint-ORIG-GUID: Dn9t7sHizOmtClU9DfBA8utLe4LTNm47
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
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404110081



On 09.04.24 03:44, Wen Gu wrote:
> 
> 
> On 2024/4/4 23:15, Niklas Schnelle wrote:
>> On Thu, 2024-04-04 at 21:12 +0800, Wen Gu wrote:
>>>
>>> On 2024/4/4 19:42, Niklas Schnelle wrote:
>>>> On Thu, 2024-04-04 at 17:32 +0800, Wen Gu wrote:
>>>>>
>>>>> On 2024/4/4 00:25, Gerd Bayer wrote:
>>>>>> On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
>>>>>>> This implements some operations that loopback-ism does not support
>>>>>>> currently:
>>>>>>>     - vlan operations, since there is no strong use-case for it.
>>>>>>>     - signal_event operations, since there is no event to be processed
>>>>>>> by the loopback-ism device.
>>>>>>
>>>>>> Hi Wen,
>>>>>>
>>>>>> I wonder if the these operations that are not supported by loopback-ism
>>>>>> should rather be marked "optional" in the struct smcd_ops, and the
>>>>>> calling code should call these only when they are implemented.
>>>>>>
>>>>>> Of course this would mean more changes to net/smc/smc_core.c - but
>>>>>> loopback-ism could omit these "boiler-plate" functions.
>>>>>>
>>>>>
>>>>> Hi Gerd.
>>>>>
>>>>> Thank you for the thoughts! I agree that checks like 'if(smcd->ops->xxx)'
>>>>> can avoid the device driver from implementing unsupported operations. But I
>>>>> am afraid that which operations need to be defined as 'optional' may differ
>>>>> from different device perspectives (e.g. for loopback-ism they are vlan-related
>>>>> opts and signal_event). So I perfer to simply let the smc protocol assume
>>>>> that all operations have been implemented, and let drivers to decide which
>>>>> ones are unsupported in implementation. What do you think?
>>>>>
>>>>> Thanks!
>>>>>
>>>>
>>>> I agree with Gerd, in my opinion it is better to document ops as
>>>> optional and then allow their function pointers to be NULL and check
>>>> for that. Acting like they are supported and then they turn out to be
>>>> nops to me seems to contradict the principle of least surprises. I also
>>>> think we can find a subset of mandatory ops without which SMC-D is
>>>> impossible and then everything else should be optional.
>>>
>>> I see. If we all agree to classify smcd_ops into mandatory and optional ones,
>>> I'll add a patch to mark the optional ops and check if they are implemented.
>>
>> Keep in mind I don't speak for the SMC maintainers but that does sound
>> reasonable to me.
>>
> 
> Hi Wenjia and Jan, do you have any comments on this and [1]? Thanks!
> 
> [1] https://lore.kernel.org/netdev/60b4aec0b4bf4474d651b653c86c280dafc4518a.camel@linux.ibm.com/
> 
>>>
>>>>
>>>> As a first guess I think the following options may be mandatory:
>>>>
>>>> * query_remote_gid()
>>>> * register_dmb()/unregister_dmb()
>>>> * move_data()
>>>>     For this one could argue that either move_data() or
>>>>     attach_dmb()/detach_dmb() is required though personally I would
>>>>     prefer to always have move_data() as a fallback and simple API
>>>> * supports_v2()
>>>> * get_local_gid()
>>>> * get_chid()
>>>> * get_dev()
>>> I agree with this classification. Just one point, maybe we can take
>>> supports_v2() as an optional ops, like support_dmb_nocopy()? e.g. if
>>> it is not implemented, we treat it as an ISMv1.
>>>
>>> Thanks!
>>
>> Interpreting a NULL supports_v2() as not supporting v2 sounds
>> reasonable to me.
> 

Let me add my thoughts to the discussion:
For the vlan operations and signal_event operations that loopback-ism does
not support:
I like the idea to set the ops to NULL and make sure the caller checks that
and can live with it. That is readable and efficient.

I don't think there is a need to discuss a strategy now, which ops could be
optional in the future. This is all inside the kernel. loopback-ism is even 
inside the smc module. Such comments in the code get outdated very easily.

I would propose to mark those as optional struct smcd_ops, where all callers can 
handle a NULL pointer and still be productive.
Future support of other devices for SMC-D can update that.




