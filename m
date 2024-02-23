Return-Path: <linux-kernel+bounces-78258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDEA8610D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EBD1C21921
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0107AE47;
	Fri, 23 Feb 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bLcq86JP"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76A627FC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689337; cv=none; b=oYP8wObeqiBheJhx7pDVeT+kPvnx5Tfj0hUcwqaGaozDErCW2HH+MW7vr+taVpNIulD1iKlTVCzE/ucIPj4yA7CU8v9w2FykM1XkvQ7Hkr4dgauGc/abukefMVXKp+MaZxYraq8P+hI/zBLD5itQZZgIS0ZQdSATMqUZS2MCp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689337; c=relaxed/simple;
	bh=cvHhbH5015GODLP9rzC/0ihNiAUiBPPcD/8uRZNKXRQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dV7XyWpgV4w4fgrWTAp8PoFlDQONvgxrXLFaTZNIochwTdX7BGcgRmrL5xYgYN3y/KU8UIdNKZ0dwxexLIYBgfnANF33yN0Oo30rH2DVTCUFypwVn1kJBOY4XliVJ8boVaIqVH4DWfG9mTHOQCojJPBLyk6Vhnl0ht2nNgT09GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bLcq86JP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NBVjtC003784;
	Fri, 23 Feb 2024 11:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=ZgAbRxJ5InPZt9odwVM5BuYjWb/ovDZ+HPdjW5c9yV4=;
 b=bLcq86JPHhlnQl/61YZprtkm2+am7buD3eFyinDhrwzabUm6Ye/o3KCR+HPx9kzUR434
 VRX094cVk1vH9Zq6H+wGcBa8vgvQM8mjfy63xI8IkAesSZVWace2muiIOvbMgRdpUqPn
 YOoHPTTZRqxw81/RZ+hr2/9t77nEfpb6IGnm8O8/QEBDZn4X9iFJBC/ZvJxCNhIZmh79
 lpjOWeOCta/tYX123A1Ja2TI065UfnAKUAIBDn7cGIG8JvK1W15++RQzddkVHpr5kuy5
 5uxrcBBzaYLsGlB03SnLyjGkmnLA85NazAuv0pKP49MZHLAVUb8HtWq1l4Plex/IaxcW LA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wetjqrky1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:55:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NBhJjA009577;
	Fri, 23 Feb 2024 11:55:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pw3x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:55:28 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NBtPLm37421476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 11:55:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA7BC58058;
	Fri, 23 Feb 2024 11:55:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F54B5805B;
	Fri, 23 Feb 2024 11:55:23 +0000 (GMT)
Received: from [9.171.23.236] (unknown [9.171.23.236])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 11:55:23 +0000 (GMT)
Message-ID: <0818a331-cea3-4962-88ad-09bccbd3659d@linux.ibm.com>
Date: Fri, 23 Feb 2024 17:25:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org
From: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: Question about DOUBLE_TICK's role alongside EEVDF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4KNkVefN7YCc6OyWCoabgxtlIyIlN0G3
X-Proofpoint-GUID: 4KNkVefN7YCc6OyWCoabgxtlIyIlN0G3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxscore=0 clxscore=1031 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230085

Hi,

I hope you're doing well. I've been looking into some recent changes in the
scheduler code and would like to get your perspective on a few things.

I was examining commit 5e963f2bd465 ("sched/fair: Commit to EEVDF"), which
removed the check_preempt_tick method. As a result, the DOUBLE_TICK feature used
within the entity_tick function no longer seems to directly influence scheduling
decisions. I understand that this feature was designed to handle interactions
between periodic ticks and the high-resolution timer (hrtick).

Here's my understanding so far (please correct me if there are any inaccuracies):

DOUBLE_TICK: Enabled periodic ticks to proceed even when an hrtick timer was
active, potentially canceling the hrtick timer in __schedule if active.

Commit 5e963f2bd465: Removed a key decision point where DOUBLE_TICK played a
role, making its current utility questionable.

This brings me to my main question: As we transition towards EEVDF for
calculating preemption points(based on entity lag) and the scheduler manages
resource allocation in quanta, is there a continued need for the hrtick timer?

In the case of multiple processes with different nice values, EEVDF handles
their preemption according to their lag. However, the exact behavior depends on
the values of base_slice_ns and config_hz.

It's possible I don't have all the pieces of the puzzle, so my question might
not make sense. But I wanted to bring forth this point. It would be great to
know your thoughts.

Thank you for your time.

-- vishal.c


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..73e1372d1a0d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5510,12 +5510,6 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity
*curr, int queued)
                resched_curr(rq_of(cfs_rq));
                return;
        }
-       /*
-        * don't let the period tick interfere with the hrtick preemption
-        */
-       if (!sched_feat(DOUBLE_TICK) &&
-                       hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
-               return;
 #endif
 }

