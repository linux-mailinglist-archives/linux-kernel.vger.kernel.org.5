Return-Path: <linux-kernel+bounces-3172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09878816850
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBE11C209A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F3107AB;
	Mon, 18 Dec 2023 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FCC89TqK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03912B7D;
	Mon, 18 Dec 2023 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI7MpDZ003476;
	Mon, 18 Dec 2023 08:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ttEgV6madoRDju+rlOp1FQWerew2onQEJcXleU51T3s=;
 b=FCC89TqKzUK+FqBkdlBptR24DCxlVILowPXVCeDniHUxwEKZJVksehE4ZDSKrER9kv+V
 GP1gTR4vFeLngXgtksaWqXFQx14ATJM1bw1ePvOV0POGlf+pHVkeAKuplwqetisurgne
 KbgrgmjG9hJmx0KEWijUI9tjDHPJ0u8hwINWbAb3DK81TRD/kbYwIX+fz8FdMosbE1u9
 4Rnih9jRuwFBk3OoMQq708GPORKFYBO9NfNKGIrMn4jCRJa1fZaDodxCXlsLNp6lX8dW
 DzwxPMiy0yPFHEb2KQetuZpINOGYT+gpCxeQB/4+8+hg95Q+anP4bZbmlCXiC3Wrj009 Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2grfb85e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:39:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BI7ueHh028570;
	Mon, 18 Dec 2023 08:39:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2grfb84q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:39:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI6C4mt010870;
	Mon, 18 Dec 2023 08:39:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7n7my5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:39:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BI8dCvt43713058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 08:39:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0464D20063;
	Mon, 18 Dec 2023 08:39:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F5522004F;
	Mon, 18 Dec 2023 08:39:10 +0000 (GMT)
Received: from [9.171.88.206] (unknown [9.171.88.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Dec 2023 08:39:10 +0000 (GMT)
Message-ID: <63aa2995-7980-430d-84be-58ce204f5172@linux.ibm.com>
Date: Mon, 18 Dec 2023 09:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/10] net/smc: unify the structs of accept or
 confirm message for v1 and v2
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
 <1702371151-125258-4-git-send-email-guwen@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1702371151-125258-4-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UO1qgJwfFPMOQQrV-3BomPAcQvH5gWbj
X-Proofpoint-ORIG-GUID: -2R8J05IhAk-ttGXp60Nga28F0Dwdfqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxlogscore=673 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180061



On 12.12.23 09:52, Wen Gu wrote:
> The structs of CLC accept and confirm messages for SMCv1 and SMCv2 are
> separately defined and often casted to each other in the code, which may
> increase the risk of errors caused by future divergence of them. So
> unify them into one struct for better maintainability.
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/af_smc.c  | 50 +++++++++++++++---------------------------
>  net/smc/smc_clc.c | 65 ++++++++++++++++++++++++-------------------------------
>  net/smc/smc_clc.h | 32 ++++++++++-----------------
>  3 files changed, 57 insertions(+), 90 deletions(-)
> 

[...]
Thank you very much, Wen Gu. I think this makes it much easier to spot the
places in the accept/confirm code code where v1 vs v2 really make a difference.
I understand that this is not really related to v2.1, but I feel it is worth
simplifying the already complex strucutres before adding even more complexity.



> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 1697b84..614fa2f 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -259,29 +259,22 @@ struct smc_clc_fce_gid_ext {
>  struct smc_clc_msg_accept_confirm {	/* clc accept / confirm message */
>  	struct smc_clc_msg_hdr hdr;
>  	union {
> -		struct smcr_clc_msg_accept_confirm r0; /* SMC-R */
> -		struct { /* SMC-D */
> -			struct smcd_clc_msg_accept_confirm_common d0;
> -			u32 reserved5[3];
> -		};
> -	};
> -} __packed;			/* format defined in RFC7609 */
> -
> -struct smc_clc_msg_accept_confirm_v2 {	/* clc accept / confirm message */
> -	struct smc_clc_msg_hdr hdr;
> -	union {
>  		struct { /* SMC-R */
> -			struct smcr_clc_msg_accept_confirm r0;
> +			struct smcr_clc_msg_accept_confirm _r0;
> +			/* v2 only, reserved and ignored in v1: */
>  			u8 eid[SMC_MAX_EID_LEN];
>  			u8 reserved6[8];
>  		} r1;
>  		struct { /* SMC-D */
> -			struct smcd_clc_msg_accept_confirm_common d0;
> +			struct smcd_clc_msg_accept_confirm_common _d0;
> +			/* v2 only, reserved and ignored in v1: */
>  			__be16 chid;
>  			u8 eid[SMC_MAX_EID_LEN];
>  			u8 reserved5[8];
>  		} d1;
>  	};
> +#define r0	r1._r0
> +#define d0	d1._d0

This adds complexity. 
If you add the v2-only fields to struct smcr_clc_msg_accept_confirm and 
struct smcd_clc_msg_accept_confirm_common respectively, you can avoid the
#define and the extra layer in the struct. 
Actually there are already v2-only fields in smcd_clc_msg_accept_confirm_common
and smcd_clc_msg_accept_confirm_common (gid and others). So you could add the 
correct informative comments there.

>  };

You have removed the __packed attribute.
patch 07/10 adds it back for the SMC-D case, but the SMC-R case needs it as well.


[...]

