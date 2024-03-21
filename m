Return-Path: <linux-kernel+bounces-109757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E4F885552
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273D41C211CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EF36A003;
	Thu, 21 Mar 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nc0K4Vuo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4B69D0A;
	Thu, 21 Mar 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008750; cv=none; b=D6wt3N0NKmRzgE9+IFbqUMgIF3zSYat4nXKpaxESWWfMtMI1aoGqklV3zCSNpfzexowfGXbQxbn8GJ6v40+idUN6nJ0JjSMycLkrTsBXzMKuyVQsyNcgUiaZQrX7y2R66bEm/j3OCw+hmP/wdj4ctWc8qbZ0Z4pedmJnM5meb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008750; c=relaxed/simple;
	bh=bTRm0OaqeGaCGhYMA9/gloFrnHmIIA2/BRRyqgoOlsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOrTAQAmtC0u82I2VK3P9EdsEsPWA2gL/5lsPGlwY9ZPJtuJkJrwcTxUFK/xoOD5WvqLmU8lVOUTOxsyFZqaRAKiYtBLVcDsz/ZqWBS9VPjCna54+mXS8U97Qw/n2ClgNlvbjqbP8kFw+fFKgnPEyAOQ0EkoHPFxnXsvFeiIUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nc0K4Vuo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L381W4020941;
	Thu, 21 Mar 2024 08:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TgvQ7/lNkwrIuZ3UxnO3PdQJ4gBGnpT9psXzERSElUc=;
 b=nc0K4VuoU1n8H9VU69BXyen8YJGf9fPxGJGvFeqnAf+j3ENyBlVhctGm3iCmTcGMfQuw
 m0liN/4bnAS7ry7NUO2Ln4IFUMBztjz4dge2AMV1NHKKGr9vX0Gc5ftDyMk9Fc+L66DW
 i0yo5ve5aVUHnD/IYYlxH56Se7eGlzA0jBMk4BsMhQoAkfnLX3twFsKtooZpz8EiqjWL
 YjFvyJYu7ErBo7uC8RLIZreOnUK6LahRMN4amzTip3ejbFe142sd18eb8TsXAisZ2MuB
 +PyWcnr6W0P0FC8fAsq/tnu20QMd6OHOtCRAZd4iVpIZshlcysODzGup3WIrY42M5r6Q rw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0cq6gfqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:21 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42L8CK38021043;
	Thu, 21 Mar 2024 08:12:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0cq6gfq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L70oWh011539;
	Thu, 21 Mar 2024 08:12:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8mbmwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42L8CERi52363730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 08:12:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 699682004D;
	Thu, 21 Mar 2024 08:12:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 710E520040;
	Thu, 21 Mar 2024 08:12:13 +0000 (GMT)
Received: from [9.179.15.41] (unknown [9.179.15.41])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 08:12:13 +0000 (GMT)
Message-ID: <f9bfbc0f-7cfc-47c0-b06c-23ee3e70a420@linux.ibm.com>
Date: Thu, 21 Mar 2024 09:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 04/11] net/smc: implement some unsupported
 operations of loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
 <20240317100545.96663-5-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240317100545.96663-5-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zMdHERrm4guDYR7wqLN0wpP71ZXjF05n
X-Proofpoint-GUID: vjwH-pVcUOklswEqS_9Q9jEoncFSHu8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403210054



On 17/03/2024 11:05, Wen Gu wrote:
> vlan operations are not supported currently since the need for vlan in
> loopback-ism situation does not seem to be strong.
> 
> signal_event operation is not supported since no event now needs to be
> processed by loopback-ism device.

Hi Wen Gu,

Could we re-phrase this commit message please? I had some trouble 
reading it. Maybe something along:

Operations that loopback-ism does not support currently:
- vlan operations, since there is no strong use-case for it
- signal_event operations, since there are no events to be processed
     by the loopback-ism device.

Thanks
- Jan

> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_loopback.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
> index 7656a2474500..253128c77208 100644
> --- a/net/smc/smc_loopback.c
> +++ b/net/smc/smc_loopback.c
> @@ -49,6 +49,32 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>   	return 0;
>   }
>   
> +static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int smc_lo_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int smc_lo_set_vlan_required(struct smcd_dev *smcd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int smc_lo_reset_vlan_required(struct smcd_dev *smcd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
> +			       u32 trigger_irq, u32 event_code, u64 info)
> +{
> +	return 0;
> +}
> +
>   static int smc_lo_supports_v2(void)
>   {
>   	return SMC_LO_V2_CAPABLE;
> @@ -77,11 +103,11 @@ static const struct smcd_ops lo_ops = {
>   	.query_remote_gid = smc_lo_query_rgid,
>   	.register_dmb		= NULL,
>   	.unregister_dmb		= NULL,
> -	.add_vlan_id		= NULL,
> -	.del_vlan_id		= NULL,
> -	.set_vlan_required	= NULL,
> -	.reset_vlan_required	= NULL,
> -	.signal_event		= NULL,
> +	.add_vlan_id = smc_lo_add_vlan_id,
> +	.del_vlan_id = smc_lo_del_vlan_id,
> +	.set_vlan_required = smc_lo_set_vlan_required,
> +	.reset_vlan_required = smc_lo_reset_vlan_required,
> +	.signal_event = smc_lo_signal_event,
>   	.move_data		= NULL,
>   	.supports_v2 = smc_lo_supports_v2,
>   	.get_local_gid = smc_lo_get_local_gid,

