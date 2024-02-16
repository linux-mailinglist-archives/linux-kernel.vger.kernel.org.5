Return-Path: <linux-kernel+bounces-68742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E31857F48
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D468D28DD7A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14BD12D741;
	Fri, 16 Feb 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JJQrksBb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1B12BF38;
	Fri, 16 Feb 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093596; cv=none; b=r8E3y6/X7J+KzJ+ig7sVIjDTynp+rl1kO8XThgOtd+0mlVcVw0DoItv+JCPc1qZR1EBm0AeuXlgT/1yrCfPdVQ/0LW4irpmDS48Kgjs6az28XoDrFKcX8P3OFN4Qvv6ZsiTD2CVPsr7xgkLqtO0Z/qNBGHnUBUXUgfwdIRTf7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093596; c=relaxed/simple;
	bh=5LcLqcwF4UiRaEFh9QJG+7wP8nw7SEEVXGasMmGvzJk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=itsf8HXYOMMVIlwGNqMSlgd3EWygX3O+HSNyL4YhFHtBeZ3CJ6d8bbXpH/g31nmUiuEuwBHyK41/wXFoI0wwvEN+EBnNQCRyqoJs09+++frmeKa6SpjyGjuc4Y5u/O/onXUF+rI6OpeSMdWzHDJMNqaupg5uxS+wKLsktlHk1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JJQrksBb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GDPgqQ004421;
	Fri, 16 Feb 2024 14:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : from
 : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ji4rvO9DHftDYidWqssdtYSxRgzOurvrC6QAxs3U3yY=;
 b=JJQrksBbEN+gkUcT6zg/m8hNO8e3id0sE/L3QpcJ9N9LoyjdAmAIXkPdwsbasMTKeuQT
 bs7OA7majyzp3jLKATj+epeAG5Xr3ppb5hWihFy8husgKN6f4vz9M1pOJwW9Xys/F2Qb
 AQtIvqMw/+b5mVZFJP1W+Gx0tqAG7GL1eUuYIC5Wb34zJVmb/K0U52ByNOv3qnzDtyYo
 qXIbbUzJr4+FbMPYzFWfjyUZ3o0RrkIeaqAcm56sSva9PtbAq3N/XSWV99LwULzwgvEO
 fc8kz1RB7DG9R4KSaPF8gk/f2dGtC9S01kZapqTArIOweXn0rYENF8oYYgb+pigyjVHb cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7e82xym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:26:30 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GEKdUK027007;
	Fri, 16 Feb 2024 14:26:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7e82xnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:26:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GDa3DO016203;
	Fri, 16 Feb 2024 14:25:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6myn3nxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:25:59 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GEPuaM49086776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 14:25:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A204858045;
	Fri, 16 Feb 2024 14:25:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5EBD58054;
	Fri, 16 Feb 2024 14:25:50 +0000 (GMT)
Received: from [9.171.40.55] (unknown [9.171.40.55])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 14:25:50 +0000 (GMT)
Message-ID: <b3b71f26-239f-49c9-98e8-7eba2c4ecf69@linux.ibm.com>
Date: Fri, 16 Feb 2024 15:25:50 +0100
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next 14/15] net/smc: introduce loopback-ism DMB data
 copy control
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-15-guwen@linux.alibaba.com>
Content-Language: en-GB
In-Reply-To: <20240111120036.109903-15-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mKVPBnQH21vMKZ-uew-k2Oz2qy5ICA7m
X-Proofpoint-ORIG-GUID: TJoCJXkpQ4iB9GLJycmXdhEXFhv5BFbf
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160116



On 11.01.24 13:00, Wen Gu wrote:
> This provides a way to {get|set} whether loopback-ism device supports
> merging sndbuf with peer DMB to eliminate data copies between them.
> 
> echo 0 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # support
> echo 1 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # not support
> 
Besides the same confusing as Niklas already mentioned, the name of the 
option looks not clear enough to what it means. What about:
echo 1 > /sys/devices/virtual/smc/loopback-ism/nocopy_support # merge mode
echo 0 > /sys/devices/virtual/smc/loopback-ism/nocopy_support # copy mode

> The settings take effect after re-activating loopback-ism by:
> 
> echo 0 > /sys/devices/virtual/smc/loopback-ism/active
> echo 1 > /sys/devices/virtual/smc/loopback-ism/active
> 
> After this, the link group related to loopback-ism will be flushed and
> the sndbufs of subsequent connections will be merged or not merged with
> peer DMB.
> 
> The motivation of this control is that the bandwidth will be highly
> improved when sndbuf and DMB are merged, but when virtually contiguous
> DMB is provided and merged with sndbuf, it will be concurrently accessed
> on Tx and Rx, then there will be a bottleneck caused by lock contention
> of find_vmap_area when there are many CPUs and CONFIG_HARDENED_USERCOPY
> is set (see link below). So an option is provided.
> 
> Link: https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
We tried some simple workloads, and the performance of the no-copy case 
was remarkable. Thus, we're wondering if it is necessary to have the 
tunable setting in this loopback case? Or rather, why do we need the 
copy option? Is that because of the bottleneck caused by using the 
combination of the no-copy and virtually contiguours DMA? Or at least 
let no-copy as the default one.


