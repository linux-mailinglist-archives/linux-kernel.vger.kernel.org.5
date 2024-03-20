Return-Path: <linux-kernel+bounces-108909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F2E8811CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2F5285A42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C44084D;
	Wed, 20 Mar 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bL2hD6Ds"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739B405C1;
	Wed, 20 Mar 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938712; cv=none; b=XSHrsHPvatnloPPebBa6b6Y14GLKCnDIaBh+BMd72sl25Pyi3tzM+y81G2amfmR2JLw6ny4J7i5Pj9eLT+omKRTgrNKcNnSVfpFGb939zKH1Mr0gnH1d0ueFFC5CvC6I9H29lMKiOJ8LiV0BVwWolWAakoxZiyusXgd1Oh8xg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938712; c=relaxed/simple;
	bh=M+jLpqNCSTThaV/XD30izZdx/tur/4DdP2zwdLgTgus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcGFAQ5VckTM4BKJRQDWiBzFYhTxBwJTBnyDEv1OzSThW4zhd2JJIU7X99i5oIBqLAM4cvehUJZBxxWUK04eRVDghJaC8xhyom1DLKdIgCNhRpl5Y2EaWHVnp5dgZ3oId9D0uHgbSFB+jGeeGNLoRpJlq3gsg1gq2x4twWRtEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bL2hD6Ds; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBsES1003699;
	Wed, 20 Mar 2024 12:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=u7sRbJZWvIiDpX8J1X/tK1ktvVul+hbxljtVvQ3NwD4=;
 b=bL2hD6DsXLphExTBMtop8z2xa2OztYFPu1UX2/6kJdtCtPAXry7rowS7K2X4LJGfQp2o
 Ak7VtfdWry3TQCEWZaS3clYrlZbqqWTaHqCP0yFC9ejueoM5EipauCWHZbkSGKBAsvFf
 rOpW+niuPF8GWdJw/vx/5ZezHPr/BaqKlF+UCulbprczbjQ0lqZJ6ShQH9RWGCVooINa
 TGbaVcv5UBKO1o9NKyWCrP7ghN2ua0vCcGMkSaK1JILQQuCUzIDhT2Y4qkIiyjokbDaU
 3YmHiPWhqvBvlbCcdGYgXBci4P9CuugYZUrV9Q9b2yjxAOAWOImXLUjXi3+/dLlQ4caZ 0w== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyxxr04kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 12:44:57 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KAvaU9017231;
	Wed, 20 Mar 2024 12:44:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrteh5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 12:44:56 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KCisqA14484034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 12:44:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 306CF58067;
	Wed, 20 Mar 2024 12:44:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34DE558063;
	Wed, 20 Mar 2024 12:44:53 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 12:44:53 +0000 (GMT)
Message-ID: <5c6c5f51-125b-4cc7-ac27-5a5358d514c7@linux.ibm.com>
Date: Wed, 20 Mar 2024 08:44:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] Add support for NIST P521 to ecdsa
Content-Language: en-US
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5BTVYp90osdRIhdfm98Jz0sOqXNgYyOQ
X-Proofpoint-ORIG-GUID: 5BTVYp90osdRIhdfm98Jz0sOqXNgYyOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200100

I apologize for the missing part in the title.

    Stefan

On 3/20/24 07:47, Stefan Berger wrote:
> This series adds support for the NIST P521 curve to the ecdsa module
> to enable signature verification with it.
> 
> An issue with the current code in ecdsa is that it assumes that input
> arrays providing key coordinates for example, are arrays of digits
> (a 'digit' is a 'u64'). This works well for all currently supported
> curves, such as NIST P192/256/384, but does not work for NIST P521 where
> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
> converting byte arrays to digits and adjusting tests on input byte
> array lengths to tolerate arrays not providing multiples of 8 bytes.
> 
> Regards,
>     Stefan
> 
> v7:
>   - Applied T-b tag from Christian to all patches
>   - Applied R-b tag from Jarkko to some patches
>   - Rephrased some patch descriptions per Jarkko's request
> 
> v6:
>   - Use existing #defines for number of digits rather than plain numbers
>     (1/13, 6/13) following Bharat's suggestion
>   - Initialize result from lowest 521 bits of product rather than going
>     through tmp variable (6/13)
> 
> v5:
>   - Simplified ecc_digits_from_bytes as suggested by Lukas (1/12)
>   - Using nbits == 521 to detect NIST P521 curve rather than strcmp()
>     (5,6/12)
>   - Nits in patch description and comments (11/12)
> 
> v4:
>   - Followed suggestions by Lukas Wummer (1,5,8/12)
>   - Use nbits rather than ndigits where needed (8/12)
>   - Renaming 'keylen' variablest to bufsize where necessary (9/12)
>   - Adjust signature size calculation for NIST P521 (11/12)
> 
> v3:
>   - Dropped ecdh support
>   - Use ecc_get_curve_nbits for getting number of bits in NIST P521 curve
>     in ecc_point_mult (7/10)
> 
> v2:
>   - Reformulated some patch descriptions
>   - Fixed issue detected by krobot
>   - Some other small changes to the code
> 
> Stefan Berger (13):
>    crypto: ecc - Use ECC_CURVE_NIST_P192/256/384_DIGITS where possible
>    crypto: ecdsa - Convert byte arrays with key coordinates to digits
>    crypto: ecdsa - Adjust tests on length of key parameters
>    crypto: ecdsa - Extend res.x mod n calculation for NIST P521
>    crypto: ecc - Add nbits field to ecc_curve structure
>    crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
>    crypto: ecc - Add special case for NIST P521 in ecc_point_mult
>    crypto: ecc - Add NIST P521 curve parameters
>    crypto: ecdsa - Replace ndigits with nbits where precision is needed
>    crypto: ecdsa - Rename keylen to bufsize where necessary
>    crypto: ecdsa - Register NIST P521 and extend test suite
>    crypto: asymmetric_keys - Adjust signature size calculation for NIST
>      P521
>    crypto: x509 - Add OID for NIST P521 and extend parser for it
> 
>   crypto/asymmetric_keys/public_key.c       |  14 ++-
>   crypto/asymmetric_keys/x509_cert_parser.c |   3 +
>   crypto/ecc.c                              |  44 +++++--
>   crypto/ecc_curve_defs.h                   |  49 ++++++++
>   crypto/ecdsa.c                            |  62 ++++++---
>   crypto/ecrdsa_defs.h                      |   5 +
>   crypto/testmgr.c                          |   7 ++
>   crypto/testmgr.h                          | 146 ++++++++++++++++++++++
>   include/crypto/ecc_curve.h                |   2 +
>   include/crypto/ecdh.h                     |   1 +
>   include/crypto/internal/ecc.h             |  24 +++-
>   include/linux/oid_registry.h              |   1 +
>   12 files changed, 335 insertions(+), 23 deletions(-)
> 

