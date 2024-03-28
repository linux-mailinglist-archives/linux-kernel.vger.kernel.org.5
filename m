Return-Path: <linux-kernel+bounces-122775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A696088FD11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D761C28869
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F37957895;
	Thu, 28 Mar 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LKRKJw9i"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797E2561D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621926; cv=none; b=phdxv6QUk1iKDFK5rAG1wkxilALARNWsesCOtuU31C2NfeQWIaIK/9sKknsH10YUqS9Hd9GcTQVpuw7OCQTqzEySnfIvnzcoZMfuxhUVZiD8Mxbg26I3Rczhe12FoYjla95bL/vOANNN8HmTbGykSSsEOPgu7DSswLR0zOnQ3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621926; c=relaxed/simple;
	bh=DbApLdDZAmNNw+lBFSYQMYJ85045pjEt/MqBmNGIQHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mffMZnUMwmxJJF6kxnuJUFpqAMNbD3efTXY5smzz7V37zKgc0iC/xMDTlh167hWQ0PWhrccfFV9ZCksJ1AsUciLfbqzwlvR5OADMj9nWf4TOK274Ofqt5rOI4f45C+WQetDwcVWgHHfKsgv8Z016ngERmTdo+8fHS+O7RZf3Ghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LKRKJw9i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SADI01017816;
	Thu, 28 Mar 2024 10:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=xq1vdUjsxLabunhH0HEjKDIOKqNQwqt0iOgnsoCq9ao=;
 b=LKRKJw9iQ+Wa2o4VIy9baJSdFHtK8Ys98tKiHYBa3FOvwtEDZyn9L4UjF2gXscgDPsvq
 uUIpH7K6WgqIPB5mjg30OHCgHB0p0LyfoFmlWUaEECM4tLgFGmQ0Qe1dCxCHvCgmALcX
 sgpg07bZ4MAaF+O5xqyoxTDijbsDno18xQyOVljctGYDMh6ZWosUTtCUdZ3C0SxSHCEi
 uBv48E73dl7fUBwBdgccecYeuBS6fDoCaZ3LumY3Po7z9xioV8N5yng+lIcfjaW/enm5
 SPCLdxdRan1lpXTEirDGoM5fKxb0K+9lXJ9q6pXL4E14mj9T1qHbRlNauG9446+BNufL Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x56ke014e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:31:41 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SAVfC3015323;
	Thu, 28 Mar 2024 10:31:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x56ke0148-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:31:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42S908Yo011358;
	Thu, 28 Mar 2024 10:26:39 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmmcgfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:26:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42SAQbrl38797786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 10:26:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A79F5805E;
	Thu, 28 Mar 2024 10:26:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8328758066;
	Thu, 28 Mar 2024 10:26:29 +0000 (GMT)
Received: from [9.43.118.127] (unknown [9.43.118.127])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 10:26:29 +0000 (GMT)
Message-ID: <8bce19b2-37d9-4722-ba83-0088a4c9fc6a@linux.ibm.com>
Date: Thu, 28 Mar 2024 15:56:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] sched/eevdf: Curb wakeup preemption further
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
        Tobias Huschle <huschle@linux.ibm.com>,
        Luis Machado <luis.machado@arm.com>, Chen Yu <yu.c.chen@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Tianchen Ding
 <dtcccc@linux.alibaba.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20240325060226.1540-1-kprateek.nayak@amd.com>
Content-Language: en-US
Reply-To: 20240325060226.1540-1-kprateek.nayak@amd.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240325060226.1540-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aENkfz_59so_ETzrpR3Nu2gWvO2tvIiW
X-Proofpoint-ORIG-GUID: zh8Eo6U9UnoE-zQvMXu7JZu83wE4E-ej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_10,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=823 spamscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280070

Hi Prateek,

On 25/03/24 11:32, K Prateek Nayak wrote:
> Wakeup preemption problem
> =========================
> 
> With the curr entity's eligibility check, a wakeup preemption is very
> likely when an entity with positive lag joins the runqueue pushing the
> avg_vruntime of the runqueue backwards, making the vruntime of the
> current entity ineligible. This leads to aggressive wakeup preemption
> which was previously guarded by wakeup_granularity_ns in legacy CFS.

Is base_slice_ns not guarding it in EEVDF?

> Below figure depicts one such aggressive preemption scenario with EEVDF:

Thanks and Regards
Madadi Vineeth Reddy

