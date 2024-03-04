Return-Path: <linux-kernel+bounces-90201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10B86FBD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CF2B21A36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811FA17BB6;
	Mon,  4 Mar 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HDM8YqlS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231F17995
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540950; cv=none; b=dSCrdy+HJm98VgXVwcYdWXr2iE6Lu+bNVTcqauXdpV6xTCRWEVkPfHo17p6kWUFQMocaLkIkF5f9CjXBOUIvQYpSZwpJrOq4YGks8Dgg4+lrbpMZndzqVHoeG4bgnbGj4jDBbsMIjCi8pavfm4k3KKKKiFH+sdABuJuDpyEX26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540950; c=relaxed/simple;
	bh=xHGtEE89Ysf5s3ceorxN1bQrlL7WHOhbN/NAx/SwBqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRPn/el93tFhz6jWZndswgTuFJPUzgfmHzOwsa8tS8rx2KdTXqW7bfYkkT0phPsQQ+J7kUP4gqC4ebWeLgzqc//8+FkCso/v9yrmSIT3do/9VW/z+UTkiSZKNgZSqf1+WsbFpPO8/DQAMIPBnz/NWrywuRh+0bMNDhoelX9OGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HDM8YqlS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42485owI016470;
	Mon, 4 Mar 2024 08:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SxZpxjfc7CDYpKWOPubQqbhzUUm/zbSPqv4kbl3pM4o=;
 b=HDM8YqlSxTOrQ8h6PrGT25zaBlUyRLbSfCf1BcroPpvV/A5dQt2i0MedNYs+67h5QFyy
 0uoD3DugZiVyELD1KvqzE8ax5wFynSIGKXscSNpglcXYbQDldXaX8/ykEdeE+NIuCw51
 G7lSHvys2e+yFrSD7N1JNc6FK31aZQYwdRK9b9dC912UJDcMttuiedvbPzoGgrRmeu0B
 iFeJR3YRtL+SIRJuYh5v2fkGUmQNKzdF67FozsUxs0uk9au/L2UY0eX/5Pjp7BArcVcw
 0HRmx802JOMP9+K5dXIrRpIQ3PR0Xc4O/29N9/RrOKUMp9tLxOgaahWaoO+70UywTz6I Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnafy0fqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 08:28:57 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 424867eB017110;
	Mon, 4 Mar 2024 08:28:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnafy0fq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 08:28:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 424705SA026228;
	Mon, 4 Mar 2024 08:28:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfenfbcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 08:28:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4248Sq5F37224936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Mar 2024 08:28:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A7AD58066;
	Mon,  4 Mar 2024 08:28:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26C2A58062;
	Mon,  4 Mar 2024 08:28:27 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Mar 2024 08:28:24 +0000 (GMT)
Message-ID: <5e5c0a81-3c60-437c-b164-e1245222d964@linux.ibm.com>
Date: Mon, 4 Mar 2024 13:58:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] sched/fair: Use helper function to access
 rd->overutilized
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com
References: <20240301151725.874604-1-sshegde@linux.ibm.com>
 <20240301151725.874604-3-sshegde@linux.ibm.com>
 <20240303185441.km7c4u7yui3b5nl2@airbuntu>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240303185441.km7c4u7yui3b5nl2@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8hRRv0y0fHzTgdpiDn-irHGKx_yayNbH
X-Proofpoint-GUID: WoeoPssrgSrXv6x67HH8DbQ1hMrs83YG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxlogscore=942 bulkscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040064



On 3/4/24 12:24 AM, Qais Yousef wrote:
> On 03/01/24 20:47, Shrikanth Hegde wrote:
>> Overutilized field is accessed directly in multiple places.
>> So it could use a helper function. That way one might be more
>> informed that it needs to be used only in case of EAS.
>>
>> No change in functionality intended.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> Can we do the same for rd->overload too? A set_rd_overload_status() would be
> a nice addition too. Anyway.


We have some more experiments going around overload. 
For example, currently it is writing sg_status & SG_OVERLOAD without checking if it has 
changed first. On large systems that are not overloaded, that may help by reducing the 
bus traffic. 

I will pick up this after we have some more data on the above. 

> 
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> 

Thank you.

> 
> Thanks!

