Return-Path: <linux-kernel+bounces-79642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27AE86252A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888551F21D90
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83641238;
	Sat, 24 Feb 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i6NjKAbT"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DEC3F9D9;
	Sat, 24 Feb 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782237; cv=none; b=cVdA6FCzRWAurX5991fWDmRXk3b7HMqQaQEo5B4MquWxndDbVVBCsY8FVPy3xoviodI+3vnUqPtj/P/3LOYIYhXBX0oRKzyvxSYLBwnRy93pFsPmUgHhPl1y6jRAcD2gUfm+NXopmhPQVDzsNQU3/959uUp/UFqr+tqE/mYoPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782237; c=relaxed/simple;
	bh=W53/vi7azCB+U45tpstfhL4ivvrXFwVqKWH5XqIlrfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE7vRXGbuoK31tG44LcOJ/D6zMH86ezxYVpyo5M3WXHssBQih6zEJpAHJQplZrljoAIvQ0s5U0A3tn6Qvwzo42lcPNbpM3U7L2PzyTfJe2PBsPnu2Jl1NZR1fwRgim7KwnIDyfGEdjZuz+6HH+5k+t6pYOoMYRkcJRfqfaJXR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i6NjKAbT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ODC4FA004009;
	Sat, 24 Feb 2024 13:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=P8EsLr5E4u9owq2KvVUaP7toUEfklXs1dRyjPEaRMf8=;
 b=i6NjKAbTVU3IVjgFVlxk9QelquTNoRTcpBxbCHqxKZA5C1Ipz8gcwyd2+ZsKblf7N9mt
 Qet+Tw/Uz6+pa3+42ziotzUkRBfISoSAIQZDv+A3rWvMVk4TVCEVupdc/JKqRHtrHo1b
 Zc1jutiWVNBr285V6qXXW8bv7zgP3TCTXEuXQfEdkXGNmcq7lJ9l96B5EFzdwM8AS7FU
 fhGpyA93Gjx9jeoKfLT30w3E8RTK5oyc6Ux1rY2lxgj0XfN1PNBqE9LpZKGkiJgQoxhT
 u+xZideZH453155cElDlW445hx2+Wx+32kDFThIumPUa+4Xe8AMYROhy+Ae4pj3Ut40A pA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wffr31ege-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 13:43:35 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41ODFbJK012431;
	Sat, 24 Feb 2024 13:43:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wffr31eg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 13:43:34 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41OBPBpK012711;
	Sat, 24 Feb 2024 13:43:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74ucvgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 13:43:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41ODhU4C36569556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 13:43:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6C8058052;
	Sat, 24 Feb 2024 13:43:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54AFC58056;
	Sat, 24 Feb 2024 13:43:26 +0000 (GMT)
Received: from [9.43.40.229] (unknown [9.43.40.229])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 24 Feb 2024 13:43:26 +0000 (GMT)
Message-ID: <1bb797ef-573b-4bda-98bf-1eb63f6f4ffe@linux.ibm.com>
Date: Sat, 24 Feb 2024 19:13:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] sched: blk: Handle HMP systems when completing IO
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240223155749.2958009-1-qyousef@layalina.io>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240223155749.2958009-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _GFMsstkd62ipsM6BDL85LCXu6Umeg4Y
X-Proofpoint-ORIG-GUID: ZsQmflBtFjgBkzkgguc4nSunQi6LASKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_08,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 mlxlogscore=769 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240116



On 2/23/24 9:27 PM, Qais Yousef wrote:
> Due to recent changes in how topology is represented on asymmetric multi
> processing systems like big.LITTLE where all cpus share the last LLC, there is
> a performance regression as cpus with different compute capacities appear under
> the same LLC and we no longer send an IPI when the requester is running on
> a different cluster with different compute capacity.
> 
> Restore the old behavior by adding a new cpus_equal_capacity() function to help
> check for the new condition for these systems.
> 
> Changes since v1:
> 
> 	* Split the patch per subsystem.
> 	* Convert cpus_gte_capacity() to cpus_equal_capacity()
> 	* Make cpus_equal_capacity() return immediately for SMP systems.
> 

nit: Did you mean !SMP systems here? 
Because in changes i see its returning true directly if its in !CONFIG_SMP path. 

> Qais Yousef (2):
>   sched: Add a new function to compare if two cpus have the same
>     capacity
>   block/blk-mq: Don't complete locally if capacities are different
> 
>  block/blk-mq.c                 |  5 +++--
>  include/linux/sched/topology.h |  6 ++++++
>  kernel/sched/core.c            | 11 +++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 

