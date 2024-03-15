Return-Path: <linux-kernel+bounces-104204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE687CAA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D35D283C79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B7F17BCF;
	Fri, 15 Mar 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzN2QS5O"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D46175BF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494771; cv=none; b=omvqMgYxZQ03wnClotqtSyz44MZrIvQbSa+O8WNef4+uDGRu864LeRNXafcfX8PL5/kDibWoyQYUqHhJwTfIwA452ofc6Kwh3pDXU5g1Z6ofG5sVxt/Q+BoYNLo2W4INuNBGfCtpKFJYg2s6bgMuLy3jPMa/xBTngrQMPoCg9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494771; c=relaxed/simple;
	bh=MReRIJrlX8O9MT/+6kJslqNYwHtGqTuoDN2PocAehRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syXChnwsEXFOs6XtQs+M7BtPXutKKH2H9jah+44b54ME16YQcJq5ttQ3GoIUd6jXFfL5Aa7C/P8YBNwIqIqP/ve3DMhbIVEdyrZtBCeynrmUqNbWNqIWyES9FOUF+zV/gPZ6ait6q/Pz1eJ74tBzk2WDgF4UvVOgxdUeJlyYDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzN2QS5O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42F8tE0n008889;
	Fri, 15 Mar 2024 09:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KvLLWTMK+Jze46m0R5HmxFbZSHGWN2mqFJV6H+SLzAQ=;
 b=pzN2QS5OGKtasOskysZFdZ3WdeB6NFfep3yakeYGEBSf4t9LM8jqPFKIT6o5BNI2oRnU
 /IdxkUWtAPpjUS0uZpgXlg0UzODvYtJfNT+2aoComG/hQtvQ0PrIc5A7kgaKLS2sh0yc
 Af2LyYxCzH6DDenYeFwplx7ASam3Ha2J6IAKAH9XuMZBqPDlR/I9nHssx7i+psL4/o+3
 5+JuGwGLv4ME8Ktu6iaotXKgHRIy7YXLd3l/RUQsR5iS+j+7Wt3gms05WeoH8qVMtKvz
 +U9CHDbEB6AOTkCXlPWcXhEg/jteVVdzG02bLedUqKvnOv6kte786zSDqagSUvr3kYkH Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvhcj9qq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 09:26:00 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42F9PAm4015856;
	Fri, 15 Mar 2024 09:25:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvhcj9qq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 09:25:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42F6MaZa018143;
	Fri, 15 Mar 2024 09:25:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23tu5hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 09:25:59 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42F9PuZ111076216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 09:25:58 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E46F58068;
	Fri, 15 Mar 2024 09:25:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E7FA5805F;
	Fri, 15 Mar 2024 09:25:54 +0000 (GMT)
Received: from [9.124.31.199] (unknown [9.124.31.199])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 09:25:53 +0000 (GMT)
Message-ID: <f1e78013-3664-4a37-982e-6aab44ead0e3@linux.ibm.com>
Date: Fri, 15 Mar 2024 14:55:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] sched/balancing: Switch the
 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t
 sched_balance_running' flag
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
 <20240308105901.1096078-2-mingo@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240308105901.1096078-2-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Voe-nRTJtijgLpYjzGClX1GNpleG_j10
X-Proofpoint-ORIG-GUID: TTF9Mi1eGrjybl0gwHTJwMV7sGkjQstF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150076



On 3/8/24 4:28 PM, Ingo Molnar wrote:
> The 'balancing' spinlock added in:
> 

> Also document the flag a bit.
> 
> No change in functionality intended.
> 

> -static DEFINE_SPINLOCK(balancing);
> +/*
> + * This flag serializes load-balancing passes over large domains
> + * (above the NODE topology level) - only one load-balancing instance
> + * may run at a time, to reduce overhead on very large systems with
> + * lots of CPUs and large NUMA distances.
> + *
> + * - Note that load-balancing passes triggered while another one
> + *   is executing are skipped and not re-tried.
> + *
> + * - Also note that this does not serialize rebalance_domains()

nit: please change rebalance_domains to sched_balance_domains. 

> + *   execution, as non-SD_SERIALIZE domains will still be
> + *   load-balanced in parallel.
> + */
> +static atomic_t sched_balance_running = ATOMIC_INIT(0);
>  
>  /*
>   * Scale the max load_balance interval with the number of CPUs in the system.
> @@ -11711,7 +11724,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>  
>  		need_serialize = sd->flags & SD_SERIALIZE;
>  		if (need_serialize) {


