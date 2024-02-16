Return-Path: <linux-kernel+bounces-68739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E046857F39
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839C11C250CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23212CDBC;
	Fri, 16 Feb 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r2qhOFjR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D93768F2;
	Fri, 16 Feb 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093460; cv=none; b=sJ7OuCuDlArf4Xtut+jcmd40UtDD0drq2bRn8mcz2/wSDNqNb73MQ01hhOriuHF6tqR1yLgmQZ96GzpHWpVLL5lmbAT3WjaZ3eaqT3FBWtIkspHlf4FHEOtqMxzjXuAVKEvQniRrM/eEjSo1tBdlvmcdNTBpZg+ce52bkkLPaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093460; c=relaxed/simple;
	bh=ttSbueMpnZzxUwwuEo1qu9ErDitQEVMUZYtC+Z8xcRI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aR5eQCsHQVaY121QGhaAYHV1/V2TUf9EgUQfErP/98mEDn/V9SdmQKFPPRI2x2hiApPZaAk3s9Fz61foxw3LLhWuZkcWcrmkbKwR6mkuRl+xSxohZqAaFZ4eF6rp2XG0cs+iknstZoUIjoZHoSTXT+UyQ8fwWBhzv6vsVjA7leI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r2qhOFjR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GDbf69023625;
	Fri, 16 Feb 2024 14:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kVLFjMdLRyAqk9/I67nXGPs5FqcWXlsOTQVhBYO1On8=;
 b=r2qhOFjRW8UTcSLercnUjAKOfnpW1VemTl4XGyr3VSFyBEs0k6u5RgQZTiYfCEpqlnYH
 BbVOBLosYSN7OCeGGn84q9ErXB9wpL81bBkzkeJzQfZMENKwfWaYxGzvBHrbrf3WQEX4
 a6FHFb2LNSzVwdhXaq8ltFDPPR0l9WqgXuqp0Zff9zUJkuyHWY9nBP6+4fQyjFVS/uCK
 450dEyT6beQWQntNlx0VTQS1ldADlxtx9YpIhRgCul5L0Pi+EWrX7MxnKtRr0GvXolyE
 z+lv1SxWtiY0x/eRCfi/EkjFsEZDtu4k+JdlSgDNNd3EaTkZzbzdUzVSylRvTWuY8zbV cA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa8rfh83d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:24:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GE7pwv010422;
	Fri, 16 Feb 2024 14:24:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa8rfh834-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:24:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GD1XpS024975;
	Fri, 16 Feb 2024 14:24:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpur63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:24:14 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GEOBqF26411536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 14:24:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33EF358045;
	Fri, 16 Feb 2024 14:24:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 297E258052;
	Fri, 16 Feb 2024 14:24:08 +0000 (GMT)
Received: from [9.171.40.55] (unknown [9.171.40.55])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 14:24:07 +0000 (GMT)
Message-ID: <417a1b7c-4136-4f96-a614-9fd976dc884d@linux.ibm.com>
Date: Fri, 16 Feb 2024 15:24:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next 09/15] net/smc: introduce loopback-ism statistics
 attributes
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-10-guwen@linux.alibaba.com>
Content-Language: en-GB
In-Reply-To: <20240111120036.109903-10-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rVHuDyuLSug9_H380LkCjAEYrlEvWBIf
X-Proofpoint-ORIG-GUID: h1k7cY6hFCi6W2gBuQh3wf0176dc4VQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=805 malwarescore=0 bulkscore=0 adultscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160115



On 11.01.24 13:00, Wen Gu wrote:
> This introduces some statistics attributes of loopback-ism. They can be
> read from /sys/devices/virtual/smc/loopback-ism/{xfer_tytes|dmbs_cnt}.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_loopback.c | 74 ++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_loopback.h | 22 +++++++++++++
>   2 files changed, 96 insertions(+)
> 

I've read the comments from Jiri and your answer. I can understand your 
thought. However, from the perspective of the end user, it makes more 
sense to integetrate the stats info into 'smcd stats'. Otherwise, it 
would make users confused to find out with which tool to check which 
statisic infornation. Sure, some improvement of the smc-tools is also needed

