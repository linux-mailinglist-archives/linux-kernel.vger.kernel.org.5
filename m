Return-Path: <linux-kernel+bounces-104538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EBF87CF68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDCA1F23604
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E038380;
	Fri, 15 Mar 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c1obpH+v"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032263D39A;
	Fri, 15 Mar 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514133; cv=none; b=bt7QuE/f9U3gPxfVSmqNqEd/YMSdlXvSjzLk0pw/jNGG12NAlqEprjkIAeX2k2ECYSqzLq9VZrQn6ZXKcwBH8n/zMIIYS45RNmu3YMtu8N3EM22T/s8ccrf6zswylQfXMLCl5cD0Et+sSzzifQjMNnn487XqEqd5wHlCVLLva1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514133; c=relaxed/simple;
	bh=Op+e53i/ntRdkK1aejc0+Na+L8nTCLPizychhhbnMTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xz3iWkapGI6H9wqqZ5paAH2LrrjjroMc4f8SwikOjLK6Uu2C9mNupeDWZV5OqYbyvn5g7BqCP3WgdqF7Vcu4kWvCrDaKo6h4Nx09s7c5HpMXmKM6sA6eA7ULhZmJSFFf7cl+aq+72lmj+YlRMZQLNuEPSt2IbRHrf8EdXwLEd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c1obpH+v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FEVLAC025315;
	Fri, 15 Mar 2024 14:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3M4Y9jZ9gGDqlcNV9GfsLutODv89uFrn8K42saIXIU4=;
 b=c1obpH+vCIwRuQl3DMvoMNEgR/Owgau8+vd1GO8uDbVekFvN6sQyrDX5nqmflTlYJnW4
 7HepXSlSvVCjgjMiPSA8b7WwMWzZIrHDmhrzgM803tMgpE4NB6GOaAdS4W2cAiioGY9y
 OtWF27QxWjzu6k0wFWO2HfglY6pRlkCh2j5dhfxzP0sclf02b0h0bD+WiHFO9A2Rs5GP
 fH8D3YP8jeGxTr++dN5niU39ek7H3RbC/ip02Ouv81LxdQkZY79OrTrKqX+CfKentjSr
 7gVAD7+XKkBb7mU9eI48lEI7GzC9hxmixuXwkUrDtq0z6rnnjEvTPOma3csSllbam63H /Q== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvpdyhnd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 14:48:50 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42FCcWgJ018119;
	Fri, 15 Mar 2024 14:48:50 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23tvmuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 14:48:49 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FEmkcO42140134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 14:48:48 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5066E58064;
	Fri, 15 Mar 2024 14:48:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A841258052;
	Fri, 15 Mar 2024 14:48:44 +0000 (GMT)
Received: from [9.61.180.144] (unknown [9.61.180.144])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 14:48:44 +0000 (GMT)
Message-ID: <48d70b2c-788c-4ff0-9a03-c063aabdec07@linux.ibm.com>
Date: Fri, 15 Mar 2024 10:48:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] s390/vfio-ap: ap_config sysfs attribute for
 mdevctl automation
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240313205807.30554-1-jjherne@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240313205807.30554-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vzWsLAEr6Y-k2PRFYfd-BlJIz_QWlwNG
X-Proofpoint-GUID: vzWsLAEr6Y-k2PRFYfd-BlJIz_QWlwNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_02,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403150120

Unless someone else chooses to review these, my opinion is that they are 
good to go.

On 3/13/24 4:58 PM, Jason J. Herne wrote:
> Mdevctl requires a way to atomically query and atomically update a vfio-ap
> mdev's current state. This patch set creates the ap_config sysfs attribute.
> This new attribute allows reading and writing an mdev's entire state in one go.
> If a newly written state is invalid for any reason the entire state is rejected
> and the target mdev remains unchanged.
>
> Changelog
> ==========
> v3
>    - Optimization: hot unplug functions skip apcb update if nothing was actually
>      unplugged.
>    - Hot unplug functions modified to zero bitmaps before use.
>    - Rename ap_matrix_length_check to ap_matrix_overflow_check
>    - Fixed omissions and errors in several commit messages and the docs.
>    - Added Tested-by tags.
> v2
>    - Rebased patched on top of latest master
>    - Reworked code to fit changes introduced by f848cba767e59
>        s390/vfio-ap: reset queues filtered from the guest's AP config
>    - Moved docs changes to separate patch
>
>
> Jason J. Herne (5):
>    s390/ap: Externalize AP bus specific bitmap reading function
>    s390/vfio-ap: Add sysfs attr, ap_config, to export mdev state
>    s390/vfio-ap: Ignore duplicate link requests in
>      vfio_ap_mdev_link_queue
>    s390/vfio-ap: Add write support to sysfs attr ap_config
>    docs: Update s390 vfio-ap doc for ap_config sysfs attribute
>
>   Documentation/arch/s390/vfio-ap.rst   |  30 ++++
>   drivers/s390/crypto/ap_bus.c          |  13 +-
>   drivers/s390/crypto/ap_bus.h          |  22 +++
>   drivers/s390/crypto/vfio_ap_ops.c     | 220 ++++++++++++++++++++++++--
>   drivers/s390/crypto/vfio_ap_private.h |   6 +-
>   5 files changed, 262 insertions(+), 29 deletions(-)
>

