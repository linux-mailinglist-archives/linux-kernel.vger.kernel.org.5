Return-Path: <linux-kernel+bounces-158445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E08B203E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F221C23342
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDBC12AAD2;
	Thu, 25 Apr 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rPdPWaj6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8383CCD;
	Thu, 25 Apr 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044614; cv=none; b=GsXtTYrzk1LjX3IiFRdnbr/y7Mbzk/NyHtLsmNKTy8iaNPKyUrUfCihNlSPiM8AVBB7KanEMytBtr9ToiJVItuqPa97DlpI17f9ZmngYGB6AcrT4wIEPG3Izbp51YksW2X4KRe65IqaMnmurflFXRD8weQpmkng0DAf+pDfJ/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044614; c=relaxed/simple;
	bh=o91Zqorto3uCbSR/kms3zbOEKIrpTlA3e7wslzLMHsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3M9hI9PjhrMmvHg3SzGBiUBXIEbD4b6/8QzLbmobdmoADos8HbCWKoPeGtSYsQA+dLa8Jjw9EIgWci2IEXoQV7P5+c4BJTEXKYCcSpJC/bvc9P/YbqAUipAxrKgOiWOaEfCdRjCwKxpch95lj9XXkwV+GWxh9mCeGBGTUaUx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rPdPWaj6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PBSqn4019831;
	Thu, 25 Apr 2024 11:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=s30cXplagGEF8F5+SVbLY7eK/Hk2JW/YkmOEOYJCp14=;
 b=rPdPWaj62NhTMhAhXEEKvNA5IjgGv+nFAGxT6Vrm7RzL0ofdOz3b3Ve/KJkH4LjfWvgK
 KU4pvwV/luJUA6CKgIGjJRwm0j5S3dkYAK+Xc3svz+/k+wl34dz6nNLeOhJqOfZB84A1
 aaUB7lQ+G4TtOixhFwqTspLF3HevywkSx6zAPot8O8r9iTNB360a0mlUCE47B6CSUAm+
 +2d0Nf3Xf6EHf4Qtzo5nrdIcYxZVVlTuhcrmPwFHtGGqJR/ZB1rkZh/UOas78kjJhMzo
 LmROvfRvazMz1EY5e2ZQczzLMXl+Y8FVoY7RjYPjVhCELT0LsxIzHZHHee61U9eFKDOE og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqpax0033-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:30:00 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PBU0EN022413;
	Thu, 25 Apr 2024 11:30:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqpax002x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:30:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43PB09l6029929;
	Thu, 25 Apr 2024 11:29:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmr1tsp5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:29:59 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43PBTtTu44368316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 11:29:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A90915805D;
	Thu, 25 Apr 2024 11:29:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C44755806D;
	Thu, 25 Apr 2024 11:29:52 +0000 (GMT)
Received: from [9.171.19.157] (unknown [9.171.19.157])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Apr 2024 11:29:52 +0000 (GMT)
Message-ID: <ef936c58-e87c-4078-a4dc-ed7313dba2a3@linux.ibm.com>
Date: Thu, 25 Apr 2024 13:29:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 07/11] net/smc: register loopback-ism into
 SMC-D device list
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <20240414040304.54255-8-guwen@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240414040304.54255-8-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UaTnRjRQCjrzhkPCca6SggP16Y3mDQZC
X-Proofpoint-ORIG-GUID: 36ykBGmnFCfFbNKSPxFv2t52Zp-ttRQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_11,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250083



On 14.04.24 06:03, Wen Gu wrote:
> After the loopback-ism device is ready, add it to the SMC-D device list
> as an ISMv2 device, and always keep it at the beginning to ensure it is
> preferred for providing a shortcut for data transfer within the same
> kernel.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_ism.c      | 30 +++++++++++++++++++++---------
>   net/smc/smc_ism.h      |  1 +
>   net/smc/smc_loopback.c | 20 +++++++++++++-------
>   3 files changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index 188fd28423c2..6bed0a61b746 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -91,6 +91,11 @@ bool smc_ism_is_v2_capable(void)
>   	return smc_ism_v2_capable;
>   }
>   
> +void smc_ism_set_v2_capable(void)
> +{
> +	smc_ism_v2_capable = true;
> +}
> +
>   /* Set a connection using this DMBE. */
>   void smc_ism_set_conn(struct smc_connection *conn)
>   {
> @@ -439,7 +444,7 @@ static struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
>   static void smcd_register_dev(struct ism_dev *ism)
>   {
>   	const struct smcd_ops *ops = ism_get_smcd_ops();
> -	struct smcd_dev *smcd;
> +	struct smcd_dev *smcd, *fentry;
>   
>   	if (!ops)
>   		return;
> @@ -454,16 +459,23 @@ static void smcd_register_dev(struct ism_dev *ism)
>   	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
>   		smc_pnetid_by_table_smcd(smcd);
>   
> +	if (smcd->ops->supports_v2())
> +		smc_ism_set_v2_capable();
>   	mutex_lock(&smcd_dev_list.mutex);
> -	if (list_empty(&smcd_dev_list.list)) {
> -		if (smcd->ops->supports_v2())
> -			smc_ism_v2_capable = true;
> -	}
> -	/* sort list: devices without pnetid before devices with pnetid */
> -	if (smcd->pnetid[0])
> +	/* sort list:
> +	 * - devices without pnetid before devices with pnetid;
> +	 * - loopback-ism always at the very beginning;
> +	 */
> +	if (!smcd->pnetid[0]) {
> +		fentry = list_first_entry_or_null(&smcd_dev_list.list,
> +						  struct smcd_dev, list);
> +		if (fentry && smc_ism_is_loopback(fentry))
> +			list_add(&smcd->list, &fentry->list);
> +		else
> +			list_add(&smcd->list, &smcd_dev_list.list);
> +	} else {
>   		list_add_tail(&smcd->list, &smcd_dev_list.list);
> -	else
> -		list_add(&smcd->list, &smcd_dev_list.list);
> +	}

Nit: here the pair of curly brackets are unnecessary.

[...]

