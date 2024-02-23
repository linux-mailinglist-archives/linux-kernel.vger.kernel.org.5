Return-Path: <linux-kernel+bounces-78453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA78613BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710E41C22437
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1C80BE3;
	Fri, 23 Feb 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sM6o6dgZ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5237E798;
	Fri, 23 Feb 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697613; cv=none; b=IdZLh+L1AWAcOJ1r6RSAHnkNrnBBxB8Kh2yGmznzu7lmgdFFiDa70zVX1S7vhhn7lgWURns3hUHm1D3qHthjcalAYh4l+9+mWwFCtr6fxtcgesZdShGk7db/ESa/rbOXiHP5DhUXw2gHpVgzrSHWOkC+pMKQf9i4sJGKDMdhHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697613; c=relaxed/simple;
	bh=ko9c4iEcf/DE6C3ZRAZ+IP1qYu+WKPLwKkjums+ckWI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BB1aSM06OZdtpdVYU/i8ir7dtecWlSUjtG/3ahj5quXO5+gGRbaRWY/ztOQ37SzwGW3gqzLzQQIsQBHjPwjyVjHDWaPFkiV+UEQUBdrLnADgrYJzlFmm0wY/oYc0iQkcDT7nK12wYOo+mB+hDtxNanSS+NfuJB8fKdlqOIxSE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sM6o6dgZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NDuwbX003700;
	Fri, 23 Feb 2024 14:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : from
 : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Acv2wnXVA88NYpQfqAGtH+XKer3IXQR98WYmrH26+uA=;
 b=sM6o6dgZ7RjSeTELK7cdpJBFSIepHWMXs4n52UhVzX83DjmLBQN+IyEVmvNudRWfep9R
 ZA63OQYcwmb3hsSX0DSPU3irw+b1IvYyUYDe738K5LHHnDBKRQTEBS8KVsPjboo/+z+m
 WflTzqHmOlmUYbgBooK/QJUH8d7XZEBrnsujJJzo5x1TtNw9bz0/pszuLQW9BOeGnD5Z
 x9FJeTnYeP6kD2MXj1cfij608vEdxwbRTGZDRScjMYa4hfY8yq6BFj4DjuqQx/NZ516+
 Xm1k9f3A65mpDPK+rRPRzaKkOlQqyLlkSHuq7hrDiav2mV8LAdLv6bqqHnl3099KrQev zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wevpr8ehd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:13:27 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NDv5n7004001;
	Fri, 23 Feb 2024 14:13:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wevpr8egp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:13:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41ND2PLj031119;
	Fri, 23 Feb 2024 14:13:25 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bmdcy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:13:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NEDM4Y60817858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 14:13:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A5F58055;
	Fri, 23 Feb 2024 14:13:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FCDF5805B;
	Fri, 23 Feb 2024 14:13:19 +0000 (GMT)
Received: from [9.171.73.236] (unknown [9.171.73.236])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 14:13:18 +0000 (GMT)
Message-ID: <700198c8-e4dc-4974-9ebf-f819deaa785b@linux.ibm.com>
Date: Fri, 23 Feb 2024 15:13:18 +0100
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next 09/15] net/smc: introduce loopback-ism statistics
 attributes
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-10-guwen@linux.alibaba.com>
 <417a1b7c-4136-4f96-a614-9fd976dc884d@linux.ibm.com>
 <cac6192e-85d8-4289-b5af-bc8143e76004@linux.alibaba.com>
Content-Language: en-GB
In-Reply-To: <cac6192e-85d8-4289-b5af-bc8143e76004@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DmwT2ccgnwSpwqjqQQYJmM6mm-2ChAHF
X-Proofpoint-ORIG-GUID: iaFTWxfo9vY_8SLwDI2OL7V38Xnb1XNU
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
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230103



On 20.02.24 03:45, Wen Gu wrote:
> 
> 
> On 2024/2/16 22:24, Wenjia Zhang wrote:
>>
>>
>> On 11.01.24 13:00, Wen Gu wrote:
>>> This introduces some statistics attributes of loopback-ism. They can be
>>> read from /sys/devices/virtual/smc/loopback-ism/{xfer_tytes|dmbs_cnt}.
>>>
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>>>   net/smc/smc_loopback.c | 74 ++++++++++++++++++++++++++++++++++++++++++
>>>   net/smc/smc_loopback.h | 22 +++++++++++++
>>>   2 files changed, 96 insertions(+)
>>>
>>
>> I've read the comments from Jiri and your answer. I can understand 
>> your thought. However, from the perspective of the end user, it makes 
>> more sense to integetrate the stats info into 'smcd stats'. Otherwise, 
>> it would make users confused to find out with which tool to check 
>> which statisic infornation. Sure, some improvement of the smc-tools is 
>> also needed
> 
> Thank you Wenjia.
> 
> Let's draw an analogy with RDMA devices, which is used in SMC-R. If we want
> to check the RNIC status or statistics, we may use rdma statistic 
> command, or
> ibv_devinfo command, or check file under /sys/class/infiniband/mlx5_0. 
> These
> provide details or attributes related to *devices*.
> 
> Since s390 ISM can be used out of SMC, I guess it also has its own way 
> (other
> than smc-tools) to check the statistic?
> 
> What we can see in smcr stats or smcd stats command is about statistic or
> status of SMC *protocol* layer, such as DMB status, Tx/Rx, connections, 
> fallbacks.
> 
> If we put the underlying devices's statistics into smc-tools, should we 
> also
> put RNIC statistics or s390 ISM statistics into smcr stat or smcd stat? and
> for each futures device that can be used by SMC-R/SMC-D, should we 
> update them
> into smcr stat and smcd stat? And the attributes of each devices may be 
> different,
> should we add entries in smcd stat for each of them?
> 
> After considering the above things, I believe that the details of the 
> underlying
> device should not be exposed to smc(smc-tools). What do you think?
> 
> Thanks!
> 
That is a very good point. It really depends on how we understand 
*devices* and how we want to use it. The more we are thinking, the more 
complicated the thing is getting. I'm trying to find accurate 
definitions on modeling virtual devices hoping that would make things 
eaiser. Unfortunately, it is not easy. Finally, I found this article: 
https://lwn.net/Articles/645810/ (Heads up! It is even from nine years 
ago, I'm not sure how reliable it is.) With the insight of this article, 
I'm trying to summarize my thought:

It looks good to put the loopback-ism under the /sys/devices/virtual, 
especially according to the article
"
.. it is simply a place to put things that don't belong anywhere else.
"
However, in practice we use this in the term of simulated ism, which 
includes not only loopback-ism, but also other ones. Thus, does it not 
make sense to classify all of them together? E.g. same bus (just a 
half-baked idea)

Then the following questions are comig up:
- How should we organize them?
- Should it show up in the smc_rnics?
- How should it be seen from the perspective of the container?
- If we see this loopback-ism as a *device*, should we not only put the 
device related information under the /sys? Thus, dmbs_cnt seems ok, but 
xfer_tytes not. Besides, we have a field in smd stat naming "Data 
transmitted (Bytes)", which should be suitable for this information.


