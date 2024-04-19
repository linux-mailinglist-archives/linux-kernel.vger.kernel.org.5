Return-Path: <linux-kernel+bounces-151819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87B88AB451
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D81286F63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9375A13B299;
	Fri, 19 Apr 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y+F7MDih"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA424C63A;
	Fri, 19 Apr 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547436; cv=none; b=PHCGocpjgWOVyJAUwrNaRi28URmaxghXAWnd2P+R/4aT+Dn2wlLAkuIesdrFWl3aEgGgyR4wL7uQU5nTQzuWiYl7vVoEaTqd//kSW0z9RUUYyCaqjHrmAxBw7+pNftR5usnjApF9o1At+N0NSC1S5nClAZV0XR01tVERVMmtpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547436; c=relaxed/simple;
	bh=BK0T3Ph1aGHxJtSL9RG30RA0mM8JBF3nRKIEK7Tsigk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1jKtUvG64BKtO1ap7WXnnvE+jhFnb8/qU/hJ4YyqCazH044L/UtpYXyQeHzbIQPTPvhAf4Caouc2KEsiv9PB2XseLfqPnCwMBy0pNnMR3EAqT8TPi54V0M39HcsBONEE67p6b4Rylno+rdKqbo2nPN7U462XsXlWOs7R8PUwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y+F7MDih; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JHHVUg021435;
	Fri, 19 Apr 2024 17:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Li8QEJCoygMjxlapAv/HEj/Slh+EPe7jVKxtNtgjPRk=;
 b=Y+F7MDihdtzAqnPXtUqsXCnyqYEoeDA0azmI/jMVgRobQASTw3jVqC740+W6o/E4lGN9
 wZZKPo+o41VJY+XO57JEutDHsAAuMf7w5ZOePYJOhtmLW0kDtB7/HDOv8ACpnlHtsKb0
 FjNwZHPSn6dh6shHGwXcA6LpI/EjLKktGG1ApBgCBFdH6zNk6uaWDaXYU1t8EPQYd7kY
 aV3bPx9ZIo/0IxXEQK2pskv5HhFkhbPlOue5/PtbqfVmUGnXtjeJcPsVwY8VmqZad40b
 yO5oHE9AS+JeE/Ra4PDgglwILOcOiSRWR3AFPdIIyLh4xtChCydnYqD+eBz8QunIbmbs 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkvvk00v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 17:23:42 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43JHNfLw031899;
	Fri, 19 Apr 2024 17:23:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkvvk00um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 17:23:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43JFQZGG010509;
	Fri, 19 Apr 2024 17:23:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xkbmm4yus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 17:23:39 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43JHNb2519202684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 17:23:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C5C5804B;
	Fri, 19 Apr 2024 17:23:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A7AB58063;
	Fri, 19 Apr 2024 17:23:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Apr 2024 17:23:36 +0000 (GMT)
Message-ID: <4aa3459c-e029-40fa-a7f5-f858ba0e3c0f@linux.ibm.com>
Date: Fri, 19 Apr 2024 13:23:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] crypto: ecdh - Pass private key in proper byte
 order to check valid key
Content-Language: en-US
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
        git@jvdsn.com, hkario@redhat.com, simo@redhat.com,
        Salvatore Benedetto <salvatore.benedetto@intel.com>
References: <20240418152445.2773042-1-stefanb@linux.ibm.com>
 <20240418152445.2773042-2-stefanb@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240418152445.2773042-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DfMq2rMGWiHXAuHWeWvUuF6-sCLtpu4h
X-Proofpoint-GUID: zD2WPq62wFSasLYwgbb7EqFXqNRr5fI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_12,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404190132



On 4/18/24 11:24, Stefan Berger wrote:
> ecc_is_key_valid expects a key with the most significant digit in the last
> entry of the digit array. Currently ecdh_set_secret passes a reversed key
> to ecc_is_key_valid that then passes the rather simple test checking
> whether the private key is in range [2, n-3]. For all current ecdh-
> supported curves (NIST P192/256/384) the 'n' parameter is a rather large
> number, therefore easily passing this test.
> 
> Throughout the ecdh and ecc codebase the variable 'priv' is used for a
> private_key holding the bytes in proper byte order. Therefore, introduce
> priv in ecdh_set_secret and copy the bytes from ctx->private_key into
> priv in proper byte order by using ecc_swap_digits. Pass priv to
> ecc_is_valid_key.
> 

Fixes: 3c4b23901a0c ("crypto: ecdh - Add ECDH software support")

> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   crypto/ecdh.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/ecdh.c b/crypto/ecdh.c
> index 3049f147e011..c02c9a2b9682 100644
> --- a/crypto/ecdh.c
> +++ b/crypto/ecdh.c
> @@ -27,7 +27,9 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
>   			   unsigned int len)
>   {
>   	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
> +	u64 priv[ECC_MAX_DIGITS];
>   	struct ecdh params;
> +	int ret = 0;
>   
>   	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
>   	    params.key_size > sizeof(u64) * ctx->ndigits)
> @@ -40,13 +42,16 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
>   				       ctx->private_key);
>   
>   	memcpy(ctx->private_key, params.key, params.key_size);
> +	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
>   
>   	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
> -			     ctx->private_key, params.key_size) < 0) {
> +			     priv, params.key_size) < 0) {
>   		memzero_explicit(ctx->private_key, params.key_size);
> -		return -EINVAL;
> +		ret = -EINVAL;
>   	}
> -	return 0;
> +	memzero_explicit(priv, sizeof(priv));
> +
> +	return ret;
>   }
>   
>   static int ecdh_compute_value(struct kpp_request *req)

