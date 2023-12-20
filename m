Return-Path: <linux-kernel+bounces-6833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC5819E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E27F1F21551
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE8219F7;
	Wed, 20 Dec 2023 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XNRmQV4S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FEF2135A;
	Wed, 20 Dec 2023 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKBM91A029635;
	Wed, 20 Dec 2023 11:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XyJmZFNQjJdjPZR5ZR/LVt85GyOnRFs6uij6ZyeOJws=;
 b=XNRmQV4SmH5utrQkjDChTd3Ct7i8lveaSkqFh7C+ls8d3buRdOmQ4dWJMFVgjpk1gJfv
 UAqCSRwj9THZRzEiMUQVh8Hr+72cfPgKJjZvfHqg5U+TFujlJt8qzUfugCbtfty6uAr9
 OjmdEYQhtxnDhQd0fu1y/ONbuozrIpDrHdtAtanAkpaM0Oy3aZBLubuDEORmJG3HQoHb
 Ewv6Avj+3kdkq5bmiyv2N2IzCClxcH3/TB/z7Dtzx4hsBO6e4etWo9yT5Ei9A9NAY1XL
 0PISTwW6EAzSwx8d4qJv4E3qQlfjRIHN5wQbGGBU2lYxdNXoiOD9GUbb+Jzzg+ywb/st hA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3yb50bdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 11:37:58 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BKBO1qJ002112;
	Wed, 20 Dec 2023 11:37:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3yb50bd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 11:37:58 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKAcBVV004828;
	Wed, 20 Dec 2023 11:37:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1pkyx800-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 11:37:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKBbro47209602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 11:37:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A46720040;
	Wed, 20 Dec 2023 11:37:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF1C20043;
	Wed, 20 Dec 2023 11:37:53 +0000 (GMT)
Received: from [9.152.224.160] (unknown [9.152.224.160])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 11:37:53 +0000 (GMT)
Message-ID: <ab835e29-ad4a-4377-b80a-8ef6bb35ef7b@linux.ibm.com>
Date: Wed, 20 Dec 2023 12:37:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/10] net/smc: unify the structs of accept or
 confirm message for v1 and v2
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
 <20231219142616.80697-4-guwen@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231219142616.80697-4-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MpqjPWw7u7JA0NR-yffqx25IKCsS4RuZ
X-Proofpoint-GUID: wOPMZo8ahzEIcE_rVYubprY4USmvFRuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=633 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200081



On 19.12.23 15:26, Wen Gu wrote:
>  struct smc_clc_msg_accept_confirm {	/* clc accept / confirm message */
> -	struct smc_clc_msg_hdr hdr;
> -	union {
> -		struct smcr_clc_msg_accept_confirm r0; /* SMC-R */
> -		struct { /* SMC-D */
> -			struct smcd_clc_msg_accept_confirm_common d0;
> -			u32 reserved5[3];
> -		};
> -	};
> -} __packed;			/* format defined in RFC7609 */
> -
> -struct smc_clc_msg_accept_confirm_v2 {	/* clc accept / confirm message */
>  	struct smc_clc_msg_hdr hdr;
>  	union {
>  		struct { /* SMC-R */
>  			struct smcr_clc_msg_accept_confirm r0;
> -			u8 eid[SMC_MAX_EID_LEN];
> -			u8 reserved6[8];
> -		} r1;
> +			struct { /* v2 only */
> +				u8 eid[SMC_MAX_EID_LEN];
> +				u8 reserved6[8];
> +			} __packed r1;
> +		};
>  		struct { /* SMC-D */
>  			struct smcd_clc_msg_accept_confirm_common d0;
> -			__be16 chid;
> -			u8 eid[SMC_MAX_EID_LEN];
> -			u8 reserved5[8];
> -		} d1;
> +			struct { /* v2 only, but 12 bytes reserved in v1 */
> +				__be16 chid;
> +				u8 eid[SMC_MAX_EID_LEN];
> +				u8 reserved5[8];
> +			} __packed d1;
> +		};
>  	};
>  };


I still think the __packed at the outmost level is the safest place.
Like you have it now the compiler could place unused memory between
ro and r1 or between d0 and d1.
Afaik compilers don't do that, if the blocks are word-aligned, but 
there is no guarantee. 

Up to you. My R-b still applies.
Sandy

