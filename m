Return-Path: <linux-kernel+bounces-109756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F293F88554F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C81B217C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DE169965;
	Thu, 21 Mar 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtvEqzOO"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E91DFD2;
	Thu, 21 Mar 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008743; cv=none; b=ds0zCJVc1ZrlExNgCCq4uy07UdwtHsEjLl3Mk+XXzfKrEv7Xc+5Yj7doiOWVE8IvjMPMVppaYPbhyGJlnrq6xXYewdcG7kRYcedcUGZgw+W+ovMZOIE9lSuAiHeJV/Zq5Qg5U1BZbaBgtJTu39DLzNm9vU1KGnPQVatto4r8Ynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008743; c=relaxed/simple;
	bh=Y5ZeIQxxplZjP+2ftDx3tKZUmx1EfAOSG+vymJxxwTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZ75FIkn8Y5vLTkdWhT+MqsJkBJzVqJw+KnIB9BGx++8lN+CK6qv3Zow761kxI2v5RgKbGZntTWLz5kAZpFs2DUMrXNIebCv6Rn9fyn5dRWGlEtiIHaSVqHC1CUkk+roO/sLQpukRkPwYeCK0QcCfzJlQ8j7DGIAO5RFXfGXeaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtvEqzOO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L7P5i9017606;
	Thu, 21 Mar 2024 08:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nEGtdn6he/K+u4Y47ZnogzEXw04Dyf37SSmQdM/1jlU=;
 b=qtvEqzOOZ3nLUhy45Ckxn5k3RTcEYiin4ArTnND2aOJgjoCTGbIa2Ri1AWU5QhY/9dxK
 7eClp1WGX1KRjrFchCXkEyEbrLM/qBM3Udo2/O/wefVVC1Bjguml7zNkz9HPdFVrpRsL
 JvaDCQ1V1tMO2tRnSQlVdhWNcTwyw29IgCxq5BQjvdDMkjeZULkZb0xK788em6fW+/CU
 ER//JdNesAtHZbkjB8ajvDf2Y0MAKKqcigb9mXYQrwqmIy4lPuyMv9O3FJQtSQfiVVpj
 ZnkxoLNVAYj7NmRvmZD6/UzePL0ooEG1qu9aM99oWAKMG69F16+C7aIIrjSwv5DW2roX Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0an3rp1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:16 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42L8CFqF025615;
	Thu, 21 Mar 2024 08:12:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0an3rp1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L5haSw017203;
	Thu, 21 Mar 2024 08:12:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrtkyvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42L8C9Ix29688444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 08:12:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E47C2004D;
	Thu, 21 Mar 2024 08:12:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 683AA20043;
	Thu, 21 Mar 2024 08:12:08 +0000 (GMT)
Received: from [9.179.15.41] (unknown [9.179.15.41])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 08:12:08 +0000 (GMT)
Message-ID: <468c16e7-b546-4017-8876-358b87f70f84@linux.ibm.com>
Date: Thu, 21 Mar 2024 09:12:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 03/11] net/smc: implement ID-related
 operations of loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
 <20240317100545.96663-4-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240317100545.96663-4-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gRtfKIEeDgj5V86TPw5KA5BFCiVrzAuU
X-Proofpoint-GUID: hkWypUmg4_EHa5qaOKZT6ERHZYzXYDP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403210055



On 17/03/2024 11:05, Wen Gu wrote:
> This implements GID and CHID related operations of loopback-ism device.
> loopback-ism acts as an ISMv2. It's GID is generated randomly by UUIDv4
> algorithm and CHID is reserved 0xFFFF.

Hi Wen Gu,

Please add that loopback-ism uses an extended GID instead of a GID here 
aswell.

> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_loopback.c | 62 ++++++++++++++++++++++++++++++++++++++----
>   net/smc/smc_loopback.h |  3 ++
>   2 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
> index e9170d86e58f..7656a2474500 100644
> --- a/net/smc/smc_loopback.c
> +++ b/net/smc/smc_loopback.c
> @@ -19,11 +19,62 @@
>   #include "smc_loopback.h"
>   
>   #if IS_ENABLED(CONFIG_SMC_LO)
> +#define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
> +
>   static const char smc_lo_dev_name[] = "loopback-ism";
>   static struct smc_lo_dev *lo_dev;
>   
> +static void smc_lo_generate_id(struct smc_lo_dev *ldev)
> +{
> +	struct smcd_gid *lgid = &ldev->local_gid;
> +	uuid_t uuid;
> +
> +	uuid_gen(&uuid);
> +	memcpy(&lgid->gid, &uuid, sizeof(lgid->gid));
> +	memcpy(&lgid->gid_ext, (u8 *)&uuid + sizeof(lgid->gid),
> +	       sizeof(lgid->gid_ext));
> +
> +	ldev->chid = SMC_LO_CHID;
> +}

Minor comment. The function name implies that there is one id set whle
there are two different ones. The chid assignment can be easily looked 
over. Maybe changing the function name to `smc_lo_generate_ids` would 
prevent this. What do you think?

Thanks
- Jan

> +
> +static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
> +			     u32 vid_valid, u32 vid)
> +{
> +	struct smc_lo_dev *ldev = smcd->priv;
> +
> +	/* rgid should be the same as lgid */
> +	if (!ldev || rgid->gid != ldev->local_gid.gid ||
> +	    rgid->gid_ext != ldev->local_gid.gid_ext)
> +		return -ENETUNREACH;
> +	return 0;
> +}
> +
> +static int smc_lo_supports_v2(void)
> +{
> +	return SMC_LO_V2_CAPABLE;
> +}
> +
> +static void smc_lo_get_local_gid(struct smcd_dev *smcd,
> +				 struct smcd_gid *smcd_gid)
> +{
> +	struct smc_lo_dev *ldev = smcd->priv;
> +
> +	smcd_gid->gid = ldev->local_gid.gid;
> +	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
> +}
> +
> +static u16 smc_lo_get_chid(struct smcd_dev *smcd)
> +{
> +	return ((struct smc_lo_dev *)smcd->priv)->chid;
> +}
> +
> +static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
> +{
> +	return &((struct smc_lo_dev *)smcd->priv)->dev;
> +}
> +
>   static const struct smcd_ops lo_ops = {
> -	.query_remote_gid	= NULL,
> +	.query_remote_gid = smc_lo_query_rgid,
>   	.register_dmb		= NULL,
>   	.unregister_dmb		= NULL,
>   	.add_vlan_id		= NULL,
> @@ -32,10 +83,10 @@ static const struct smcd_ops lo_ops = {
>   	.reset_vlan_required	= NULL,
>   	.signal_event		= NULL,
>   	.move_data		= NULL,
> -	.supports_v2		= NULL,
> -	.get_local_gid		= NULL,
> -	.get_chid		= NULL,
> -	.get_dev		= NULL,
> +	.supports_v2 = smc_lo_supports_v2,
> +	.get_local_gid = smc_lo_get_local_gid,
> +	.get_chid = smc_lo_get_chid,
> +	.get_dev = smc_lo_get_dev,
>   };
>   
>   static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
> @@ -95,6 +146,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
>   
>   static int smc_lo_dev_init(struct smc_lo_dev *ldev)
>   {
> +	smc_lo_generate_id(ldev);
>   	return smcd_lo_register_dev(ldev);
>   }
>   
> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
> index 9dd44d4c0ca3..55b41133a97f 100644
> --- a/net/smc/smc_loopback.h
> +++ b/net/smc/smc_loopback.h
> @@ -20,10 +20,13 @@
>   
>   #if IS_ENABLED(CONFIG_SMC_LO)
>   #define SMC_LO_MAX_DMBS		5000
> +#define SMC_LO_CHID		0xFFFF
>   
>   struct smc_lo_dev {
>   	struct smcd_dev *smcd;
>   	struct device dev;
> +	u16 chid;
> +	struct smcd_gid local_gid;
>   };
>   #endif
>   

