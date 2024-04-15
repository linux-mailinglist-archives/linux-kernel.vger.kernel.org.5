Return-Path: <linux-kernel+bounces-144489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489588A46F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734011C2198C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D10615E9B;
	Mon, 15 Apr 2024 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hMmklDCG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6BC360;
	Mon, 15 Apr 2024 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148293; cv=none; b=gKkX/TLNs6qBswOSbl8X/afKFKwG2AKJ31AVOkWGISnsuHEnpfyerwIpWunnbRPlWmN+v8icc8gNCJWT/pvEJO/3nzm4U7Tb01Ex6M0+R/eTEO7AgneIzRar8g1dVxD8Zos5UepcrpwxqYZNDrb38VkAEjB624bWGHRhxt32CwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148293; c=relaxed/simple;
	bh=+0ulUZtaDsN9UyxD9v9KKPRsr2CjjkBptTxXXA+yj9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KGiboetig0FWUmTA5I+Qg1z/6/li/n/taQh9TYWEffx0kBv3F6ZSbK9fbe58W5jCUb0vdckMQm5Ms8sAvphEI+UG/IW+G1pd0ucGuYwGrQ+nI1moXhfEJDK77g+5qiQI5oy+LLseLMxOZs+mpw0xFRXl3KGFvLvUSQY9yb3Efok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hMmklDCG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43EMpVtt014538;
	Mon, 15 Apr 2024 02:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : cc : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=5JCIQECFpl2gtzJRAM8eyjuVFRNA4fKWOwV1H23eQxI=;
 b=hMmklDCGYuCbw6yLMoUgQIltnTYUDGtamSyOytV6rbcmjAPbnC29PVIGySDg6H6jVvkE
 +Vflkn1mcRYIPkZue32+KOwTwCU5fIp7qAfeJAC1oRngEIJnLVleUCKYCye2Aa0UQ/u6
 2aH4X3cvj0I0P6+87elL9SpGf4GiM5NgRnYAdOvexeF5y6KZaj+xvyhWaIvEhxCA2KUJ
 v7zfl0txFsX6XBCZMVtbYQirH5usktwheaYQ3Zo1hsnkqfEj740MxzEt+JtZGfUkdIp5
 Y29Xu0vk+Et7TBr3JnTGvkIr8xMsAh1UCma/V+gD8mDJ0W3E4+ioxbu4yt0uPjO5VjRW HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfj6gtt16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 02:31:17 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43F2VGCI012674;
	Mon, 15 Apr 2024 02:31:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfj6gtt12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 02:31:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43F2Euwa015836;
	Mon, 15 Apr 2024 02:31:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vkw7v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 02:31:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43F2VCKX24707502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 02:31:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F7158060;
	Mon, 15 Apr 2024 02:31:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E67F58059;
	Mon, 15 Apr 2024 02:31:06 +0000 (GMT)
Received: from [9.43.85.113] (unknown [9.43.85.113])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 02:31:06 +0000 (GMT)
Message-ID: <1b9fcded-3048-4fa9-b388-34543a44b025@linux.ibm.com>
Date: Mon, 15 Apr 2024 08:01:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf sched: Rename switches to count and add usage
 description, options for latency
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, acme@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328090005.8321-1-vineethr@linux.ibm.com>
Content-Language: en-US
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 20240328090005.8321-1-vineethr@linux.ibm.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240328090005.8321-1-vineethr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: drLZDNFPaOze2YHFwByvnqLEPcugPjkY
X-Proofpoint-ORIG-GUID: -hCQ37uNhq2UjEd6nXhZUROgvijcbXT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_01,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150016

On 28/03/24 14:30, Madadi Vineeth Reddy wrote:
> Rename 'Switches' to 'Count' and document metrics shown for perf
> sched latency output. Also add options possible with perf sched
> latency.
> 
> Initially, after seeing the output of 'perf sched latency', the term
> 'Switches' seemed like it's the number of context switches-in for a
> particular task, but upon going through the code, it was observed that
> it's actually keeping track of number of times a delay was calculated so
> that it is used in calculation of the average delay.
> 
> Actually, the switches here is a subset of number of context switches-in
> because there are some cases where the count is not incremented in
> switch-in handler 'add_sched_in_event'. For example when a task is
> switched-in while it's state is not ready to run(!= THREAD_WAIT_CPU).
> 
> commit d9340c1db3f5 ("perf sched: Display time in milliseconds, reorganize
> output") changed it from the original count to switches.
> 
> So, renamed switches to count to make things a bit more clearer and
> added the metrics description of latency in the document.
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---

Hi Arnaldo,
Any comments on this patch?

Thanks and Regards
Madadi Vineeth Reddy


