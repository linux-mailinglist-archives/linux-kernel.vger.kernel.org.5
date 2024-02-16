Return-Path: <linux-kernel+bounces-68717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB7857EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF63282192
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6012DDB1;
	Fri, 16 Feb 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f3bfQzZs"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9112D778;
	Fri, 16 Feb 2024 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092676; cv=none; b=nTFd1Cu5Te4aWEPq46zzULlPMr0p4RBdEiYUGjjQqSVnMhDebh4tqWk6Q7jBpeRIU9/3+ZOcdgxJ/gsoJU6p/R2LzcBkELQaAZW5L4p0K/fMfMtG43MaokKXHWAOzUmwYJijV2cldJrXUnG9D5rSOgF3vjFc50GnMnsc2uP7e8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092676; c=relaxed/simple;
	bh=2bctLjJu1CNalpP9XkMgtsWlrtyNTMVUDArTVHoqU08=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UtAZwXJzhiLS9dG0W9NZxTkyXXq9u7abp4gGkVhfmDtFRTyOUU+ssj/zx6foBUksN1LzBC2yQbLr+6GUbJ/QrZMHZ6Oe2HjYl8UzqOJdBJiGolRvK7TOmmBs9+rGw+lFFTJMsgCSg99fUxL10V2FjqRIpfDn7p4WNzZnhK1RpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f3bfQzZs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCtsoA009450;
	Fri, 16 Feb 2024 14:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AQ3pb+i/hg43l2d6kpsPZq9HQhZMcN8L4NDp00NKoKU=;
 b=f3bfQzZsBQdkQfVjoDW82nQzvCg88W5VODU4XOgdKmMzDIaZ/d15l2IOfSC+1nJLZff/
 V6TVj+T1rVmKwbJR82Euw9PDNTTrJg7Mlwpqu/L+LBjXirkYyRUoeMI3avGqZMg6rgKE
 JCRX60OqTPWpFQXwbE9kIbtLCXMsDMLxjxCm2nJOKjZXxzLMoYoO/I5jCgRSEWbMXUM1
 A1XJI/pQgInEl5qaMlf3BqCP8Th7jo34zevK3ulR02b8dU2OSmWt2rtDlsvSiwQ1ipSC
 Srws4MHzb2sA0IoM/mSPQxlI1F1rZMH5/IRPS6qzmBJLgERTLljBkmX4ceJj7QF18LP0 ag== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7ehasae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:11:09 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GEAuIi018241;
	Fri, 16 Feb 2024 14:11:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7ehasa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:11:08 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GBjYOl009914;
	Fri, 16 Feb 2024 14:11:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p63b76j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:11:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GEB4B847186470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 14:11:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE7058045;
	Fri, 16 Feb 2024 14:11:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3605C58069;
	Fri, 16 Feb 2024 14:11:01 +0000 (GMT)
Received: from [9.171.40.55] (unknown [9.171.40.55])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 14:11:00 +0000 (GMT)
Message-ID: <0be9c41b-19f9-437a-9a3a-8ed15cbbd155@linux.ibm.com>
Date: Fri, 16 Feb 2024 15:11:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next 03/15] net/smc: introduce virtual ISM device
 loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-4-guwen@linux.alibaba.com>
Content-Language: en-GB
In-Reply-To: <20240111120036.109903-4-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vnw048yDMNPGQbBmJ_RanSxABMRM0wBY
X-Proofpoint-GUID: Uq9Yw-bVdQ-ATQV7Uh6LO2Z-VrtkYZ1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_11,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160112



On 11.01.24 13:00, Wen Gu wrote:
> This introduces a kind of virtual ISM device loopback-ism for SMCDv2.1.
> loopback-ism is implemented by software and serves inter-process or
> inter-container SMC communication in the same OS instance. It is created
> during SMC module loading and destroyed upon unloading. The support for
> loopback-ism can be configured via CONFIG_SMC_LO.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/Kconfig        |  13 +++
>   net/smc/Makefile       |   2 +-
>   net/smc/af_smc.c       |  12 ++-
>   net/smc/smc_loopback.c | 181 +++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_loopback.h |  33 ++++++++
>   5 files changed, 239 insertions(+), 2 deletions(-)
>   create mode 100644 net/smc/smc_loopback.c
>   create mode 100644 net/smc/smc_loopback.h
> 
> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
> index 746be3996768..e191f78551f4 100644
> --- a/net/smc/Kconfig
> +++ b/net/smc/Kconfig
> @@ -20,3 +20,16 @@ config SMC_DIAG
>   	  smcss.
>   
>   	  if unsure, say Y.
> +
> +config SMC_LO
> +	bool "SMC_LO: virtual ISM loopback-ism for SMC"
> +	depends on SMC
> +	default n
> +	help
> +	  SMC_LO provides a kind of virtual ISM device called loopback-ism
Don't forget to update "s/virtual/emulated/" later. ;-)

<...>

