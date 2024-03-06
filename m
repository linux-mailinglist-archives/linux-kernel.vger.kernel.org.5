Return-Path: <linux-kernel+bounces-94074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99BA873972
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51BA28A808
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835EF133987;
	Wed,  6 Mar 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sFTIrNgG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232211EF1C;
	Wed,  6 Mar 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736082; cv=none; b=kS8kKcPdJRDkGV47RSkM6uh+TFv88O8y+yqDuq5IpgDH1vicPhXAQLjuj/ZmPIUaatJL0+huuML/1s6WD/CinyFOfkT75EDipTiTfKyqjxKNqYzF2PmcFVV4wK94UqSnyBTMg+G/SDug0/iLSsZx9Ra+Yg8vvRRpTGedOH/3Of0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736082; c=relaxed/simple;
	bh=v1Ac9isgFo1SvjQrlhB8yqgYob9tsu2/e2aGtQpdqrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6nvihR1qQ+ctZFjJsSp+gNxrwPbrKzrykBDkXOSm9nRdup8VeQu1Cz+FqbQ9Xr2MIHAvd2dyhjp/N+9kH8sEIW8DRNkLnKYMz+/HUrcc8wyz22o27/AQHgzSbAdk3YOydPxdnDLXceo42i3Sdprx2nEaRIiXCM1vBbx0OYBrik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sFTIrNgG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426EVAJZ013878;
	Wed, 6 Mar 2024 14:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YcIckR1N4R8UaZvi64KtSbh/ndFqDambcZqgdU+W+Rc=;
 b=sFTIrNgG8YNvs9pA6HRbCyv8khDpAKAh/q2y6G6FoozQ80T+5H6HO3ja00cJnJZEH4Sq
 hDy4WEztc5y3NT6Ue2ZeiuhydqBPcuuFko7l6n685xlYQu0qNT7hXNMdojen0M+7oW6o
 xrw4cAntKXpGqbyoE47ueI3qKDAb0tgR2V8sI6/Ia5Um5nMtMwnWxcDSGAGQp1riY8TE
 drMZiBEh8F2fpp9mSy+szBuk7mDr94rUmapvBNmbjrhEu7/VMiNT0M+vzr1HTBTZ3p0w
 JLHqe5TsMIvGGoPdnVJiYQ9pV64IhhqCLXmBX6wNHzykfOG/d8bVfOBdJwJhHkoQpPv6 3w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpsw29e4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:41:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426C3dEj024166;
	Wed, 6 Mar 2024 14:40:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsagp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:40:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426Eeoi022937874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:40:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B489A58062;
	Wed,  6 Mar 2024 14:40:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFC5958060;
	Wed,  6 Mar 2024 14:40:49 +0000 (GMT)
Received: from [9.61.164.86] (unknown [9.61.164.86])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:40:49 +0000 (GMT)
Message-ID: <90651f57-04bc-1353-6c48-d27e31b146ca@linux.ibm.com>
Date: Wed, 6 Mar 2024 09:40:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/5] s390: doc: Update doc
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
 <20240306140843.10782-6-jjherne@linux.ibm.com>
 <2fa94183-b015-4247-986b-562f3ed0306f@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <2fa94183-b015-4247-986b-562f3ed0306f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aTRwOwLqrQzAygFQycV_GgcboB0cdJeH
X-Proofpoint-ORIG-GUID: aTRwOwLqrQzAygFQycV_GgcboB0cdJeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_09,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxlogscore=795 lowpriorityscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060118

On 3/6/24 9:38 AM, Matthew Rosato wrote:
> On 3/6/24 9:08 AM, Jason J. Herne wrote:
>> fix me
> 
> ^^ Oops, just needs a small message here.
> 
> 

NACK, looks good to me :)

This is what I get for thinking "nahh, no need to double check the docs 
patch... It's fine."  I'll fix for v3 or reply with an updated patch if 
there's no other rework.

