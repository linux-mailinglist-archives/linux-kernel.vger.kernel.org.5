Return-Path: <linux-kernel+bounces-94980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AC87477F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601FF1C2174F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBEA17727;
	Thu,  7 Mar 2024 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cg/P3ZEN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AD711184
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709787382; cv=none; b=D8SP/S4o7lozT+DHEyPSf17j2fU385Sm281jtXjHAOleCOVRjsyjjRisEZAOD3SRvnUkSbNQCPdl5HmqPpZemhJ/xIqjPhi9RNvdJaMmHjizz2JBN4CyyXCtwTAxraoJ5ls6efvUHgb9ihVbcEIyeFGGO77dBCYtU6lfMpWhOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709787382; c=relaxed/simple;
	bh=8HhRyyLhjfP3SHqTD/5Wr30RxiBUgYsb4QrADguOwlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwiIPXdfKT+4g5Xw+HIoTztSIwHyzYW85/Z/Ig1NX3cB4zvg+TM/Zt4q5fZi5R8E3q5UrrgGNH9bqM0DjpL2IX/zg+RjeBSaOyq6ww2cJq8/Oq6lps4C+9PfI4riMul1qHWf3iTRuAKgwFUhRJkGJI9+8uyXYuIu+FmgIwAIWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cg/P3ZEN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4274u4KB031626;
	Thu, 7 Mar 2024 04:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OvTmpxWjhzjGvRK3SnZaGo7QqGaRcsHLHYkykc8TRps=;
 b=cg/P3ZENpsXdbHZ1EoqDDRskmj3WXjf8wKzp4HgB+ATbDAvsAJIjMlpS3Xr+B5LNeZep
 5HzI8A47pb5rag5/+PZU0dU67DXo90LTY8uVB1nLesDWwYqOJG0iL2OEcQh/cRHavrgE
 7X5vW4OxX0Khuq2K5fVzrnRdiL+DfNMfmWdos1a/d72X30s2QDw68DEIsptP6gv82OGl
 0FXebWTBeoQ0UfxudEd0KFr3fv2xkPgP0gP6qryVPB1N/l63B+ZjR6RDuv5chighzCs3
 f8IgLAoFsP5PtPJLmO1tTNoSOkXijwymipAcxGHuEBff1b1nWwOrEXwP3V5HS5V0mXgr 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq64g0tmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 04:56:06 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4274u5aX031747;
	Thu, 7 Mar 2024 04:56:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq64g0t4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 04:56:04 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4273eRSV006077;
	Thu, 7 Mar 2024 04:51:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetbmdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 04:51:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4274p1Fp34865586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 04:51:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0E6858058;
	Thu,  7 Mar 2024 04:51:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8FC758059;
	Thu,  7 Mar 2024 04:50:57 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 04:50:57 +0000 (GMT)
Message-ID: <61ef7ebd-f5cf-4d48-9bbd-f011d751041a@linux.ibm.com>
Date: Thu, 7 Mar 2024 10:20:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] sched/fair: Add EAS checks before updating
 overutilized
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, peterz@infradead.org, yu.c.chen@intel.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        nysal@linux.ibm.com, aboorvad@linux.ibm.com, srikar@linux.ibm.com,
        vschneid@redhat.com, pierre.gondois@arm.com, qyousef@layalina.io
References: <20240306102454.341014-1-sshegde@linux.ibm.com>
 <20240306102454.341014-2-sshegde@linux.ibm.com>
 <CAKfTPtCnN95A8kQ-uBA7ykTMAzQVRzwER-XNJt4YyQXdxhDCTQ@mail.gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAKfTPtCnN95A8kQ-uBA7ykTMAzQVRzwER-XNJt4YyQXdxhDCTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c8M0ZS1VxWq8Fb7QX7AAt5ETZ-qP3ZR2
X-Proofpoint-GUID: qYF45bn6v-gainBbuC6ogLfgHcimYRua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_01,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=870 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070033



On 3/6/24 11:10 PM, Vincent Guittot wrote:
> On Wed, 6 Mar 2024 at 11:25, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>  #else
>> -static inline void update_overutilized_status(struct rq *rq) { }
>> +static inline void check_update_overutilized_status(struct rq *rq)
>> +{
>> +       return 0;
>> +}
> 
> static inline void check_update_overutilized_status(struct rq *rq) { }
> 

Yes. Thanks for catching. I made a mistake there. 

>> +
>> +static inline void set_rd_overutilized_status(struct root_domain *rd,
>> +                                             unsigned int status)
>> +{
>> +       return 0;
>> +}
> 
> static inline void set_rd_overutilized_status(struct rq *rq) { }
> 
> my comment on v4 about {return 0; } applies only for static inline int
> is_rd_overutilized(struct root_domain *rd)
> 
> Also, I don't think that set_rd_overutilized_status() is called
> outside #ifdef CONFIG_SMP so you can remove it.
> 

yes. this set_rd_overutilized_status and is_rd_overutilized or is_rd_not_overutilized
can go away for !CONFIG_SMP case. Let me do that and send next version. 

> 
> 
> 

