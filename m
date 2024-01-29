Return-Path: <linux-kernel+bounces-43149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6474840C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470071F24926
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB4715703B;
	Mon, 29 Jan 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XFH4jAma"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83248154BF0;
	Mon, 29 Jan 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547193; cv=none; b=fI8k+rMxcl0rZ/yBbdV6ey6Yki5XQXejzigQ8qPXGN/+Emsoe7y81JhsJrwxf0Bi6GST+087jZ9o2RQwhrhf837zytOu/ScP9ix1oo4br6frwsQzcjZxaFQ02eEzngjpWEJ1xmio+TY/Mv1lWx6Ffe9QBNU8/kl0diVSByb/vb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547193; c=relaxed/simple;
	bh=7IF3NRzkq7YYR37XIex5QmrIK/n0fB3HatMOIeK/cRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ0wTYeszUUyp0AyT8NuXfkaBXGXALwPbjs4orB/+LY5WKucwOM85NhqkhlgVfZ1Ixsc+97LvvPXfDWi+xU3XE89d08L8ILrZDb31Ohp2iZTyOFXYn3N1G2jlpafqOs4heT/k8qjWHAiKKycqn0qdPHv6dc/FpalvHuxX1sKRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XFH4jAma; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGhM0Q013516;
	Mon, 29 Jan 2024 16:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uBbid1amquyLIJr4bv4Vc6+0vlJFqIwuorIR4rfEizY=;
 b=XFH4jAma6yKsf+fdSqmODgkKkygoAmxgpJiWmUtQA8b7GaQfs0Cb9uORzmvR1C5LaRmM
 0F7oQrvIkSPifBeh8lp5AZ+aVP2k4asZE61i8gL1sO3desMR22F59fO/46600kjBPFmx
 Kg23VVSg083gdhWfr5zAcVWB7QR3xLq50WIT8vQI9OuBZ8uxzatg5lP/avJQdS7oyjJ6
 QEXz/2O4lsNX6J39K57caKV3VpfBssBZO210P1ywneoufcAFP5d8h/Fwtp8jVcFaizK3
 QK66cko0z08h9c+FzJSTA816WAehdkD9P7p0G9oxWtWZsP0GiJH5qvo/46ISoAadv/NX TQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxfsp89m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 16:53:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40TG8d7E011266;
	Mon, 29 Jan 2024 16:53:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweck92gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 16:53:09 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40TGr8Gr57606618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 16:53:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 132F958056;
	Mon, 29 Jan 2024 16:53:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB4425803F;
	Mon, 29 Jan 2024 16:53:07 +0000 (GMT)
Received: from [9.61.175.71] (unknown [9.61.175.71])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jan 2024 16:53:07 +0000 (GMT)
Message-ID: <324d5277-8272-458f-b7fc-f0a21a50af64@linux.ibm.com>
Date: Mon, 29 Jan 2024 11:53:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] s390/vfio-ap: queue_configuration sysfs attribute for
 mdevctl automation
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com
References: <20240126143533.14043-1-jjherne@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240126143533.14043-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: assim4J50zwtlhPGROSHkPBsBlbFeqSs
X-Proofpoint-GUID: assim4J50zwtlhPGROSHkPBsBlbFeqSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=644 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290124

Isn't this v4 of this series?

On 1/26/24 9:35 AM, Jason J. Herne wrote:
> Mdevctl requires a way to atomically query and atomically update a vfio-ap
> mdev's current state. This patch set creates the queue_configuration sysfs
> attribute.  This new attribute allows reading and writing an mdev's entire
> state in one go. If a newly written state is invalid for any reason the entire
> state is rejected and the target mdev remains unchanged.
>
> Jason J. Herne (3):
>    s390/ap: Externalize AP bus specific bitmap reading function
>    s390/vfio-ap: Add sysfs attr, queue_configuration, to export mdev
>      state
>    s390/vfio-ap: Add write support to sysfs attr ap_config
>
>   Documentation/arch/s390/vfio-ap.rst   |  27 ++++
>   drivers/s390/crypto/ap_bus.c          |  13 +-
>   drivers/s390/crypto/ap_bus.h          |  22 +++
>   drivers/s390/crypto/vfio_ap_ops.c     | 213 +++++++++++++++++++++++---
>   drivers/s390/crypto/vfio_ap_private.h |   6 +-
>   5 files changed, 248 insertions(+), 33 deletions(-)
>

