Return-Path: <linux-kernel+bounces-110155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED2885AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5128E1F222EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9BD84FBE;
	Thu, 21 Mar 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mya7w6N0"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF681E489;
	Thu, 21 Mar 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031913; cv=none; b=XxRmfa3Bz38NcCfwN4VAU+vsxN6p2A83p8BzKWOXl3ZXnj8+cIealZzR5x3JLvM4rHLJV2xU0Q0Fsbqkp5jka5iVoucUQvsqz0ikiiKFlLwTCnStuzmnN60qnQ7r20GzKpxpd4sLCFTAItysRfoiHLEg/tXlsuFtGGlWm8V01uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031913; c=relaxed/simple;
	bh=RAQ520Hii3irGnjwDHNU7yDztGgwPSbcqoKrMeg0w4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6gwnDNhdfgrUYdD8aXlHIscGtSinXb2ZvGnXXdHTg+G5bOEzXdiKIZN63a3FLF+grWJhRiRiLZCk8VAwp8DeDICFfYcg1y78RQ0uuaMhrHO4iGpbz88P3otdMv5eMZDWe4DecYTPsXPvtV7C5VhqjJ1WN6R+rW2VRKpL5iLmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mya7w6N0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LEZZqm029685;
	Thu, 21 Mar 2024 14:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gpJiJIbsLQEj0SH7oUtsPYbzPyoaC3a2bGY1xXzVpAk=;
 b=Mya7w6N0V0qpC5UW3GfgIMF/p9VlO2rs8zLtq3bORPyBXSgt2sK5vAyFkhThDevHU6CT
 enTTJVu2v7v6i220QyB0EhELicTdN9/Ced1mh5FOkjhsTd0C7Ya+YDxjdsivpsELmNEb
 HTyCrguQ/dbzpaU5niHtQBLuHTA54Pr5+S2rQGzpSZh+2bQvYoTL4VQHvsOUR7ado+SX
 +jUQlRtE4N54yzJbG+BNT110upUBqvH79d9j8EQZ6jvlT1Jg5Hwpb7gowKIBMU6D2nvs
 z8aokhbt7af5SDS87UryQ6IdR3dF+HGYUbvno8JRQfiDd4fff4I/LgqcOa3F8pszjUmC cA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0nnng9n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 14:38:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LD1Fpk011539;
	Thu, 21 Mar 2024 14:38:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8mdpc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 14:38:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LEcK1N24576636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 14:38:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10C8558070;
	Thu, 21 Mar 2024 14:38:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 757615806C;
	Thu, 21 Mar 2024 14:38:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 14:38:19 +0000 (GMT)
Message-ID: <fd0c6728-91f5-4de8-963c-bb7c4d00dbb5@linux.ibm.com>
Date: Thu, 21 Mar 2024 10:38:18 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: ecrdsa - Fix module auto-load on add_key
Content-Language: en-US
To: Vitaly Chikunov <vt@altlinux.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Paul Wolneykien <manowar@altlinux.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20240318004241.2925876-1-vt@altlinux.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240318004241.2925876-1-vt@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8UwHRqbJLSe8gp1P0MCTWVfXQN9lHs7g
X-Proofpoint-ORIG-GUID: 8UwHRqbJLSe8gp1P0MCTWVfXQN9lHs7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403210105



On 3/17/24 20:42, Vitaly Chikunov wrote:
> Add module alias with the algorithm cra_name similar to what we have for
> RSA-related and other algorithms.
> 
> The kernel attempts to modprobe asymmetric algorithms using the names
> "crypto-$cra_name" and "crypto-$cra_name-all." However, since these
> aliases are currently missing, the modules are not loaded. For instance,
> when using the `add_key` function, the hash algorithm is typically
> loaded automatically, but the asymmetric algorithm is not.
> 
> Steps to test:
> 
> 1. Cert is generated usings ima-evm-utils test suite with
>     `gen-keys.sh`, example cert is provided below:
> 
>    $ base64 -d >test-gost2012_512-A.cer <<EOF
>    MIIB/DCCAWagAwIBAgIUK8+whWevr3FFkSdU9GLDAM7ure8wDAYIKoUDBwEBAwMFADARMQ8wDQYD
>    VQQDDAZDQSBLZXkwIBcNMjIwMjAxMjIwOTQxWhgPMjA4MjEyMDUyMjA5NDFaMBExDzANBgNVBAMM
>    BkNBIEtleTCBoDAXBggqhQMHAQEBAjALBgkqhQMHAQIBAgEDgYQABIGALXNrTJGgeErBUOov3Cfo
>    IrHF9fcj8UjzwGeKCkbCcINzVUbdPmCopeJRHDJEvQBX1CQUPtlwDv6ANjTTRoq5nCk9L5PPFP1H
>    z73JIXHT0eRBDVoWy0cWDRz1mmQlCnN2HThMtEloaQI81nTlKZOcEYDtDpi5WODmjEeRNQJMdqCj
>    UDBOMAwGA1UdEwQFMAMBAf8wHQYDVR0OBBYEFCwfOITMbE9VisW1i2TYeu1tAo5QMB8GA1UdIwQY
>    MBaAFCwfOITMbE9VisW1i2TYeu1tAo5QMAwGCCqFAwcBAQMDBQADgYEAmBfJCMTdC0/NSjz4BBiQ
>    qDIEjomO7FEHYlkX5NGulcF8FaJW2jeyyXXtbpnub1IQ8af1KFIpwoS2e93LaaofxpWlpQLlju6m
>    KYLOcO4xK3Whwa2hBAz9YbpUSFjvxnkS2/jpH2MsOSXuUEeCruG/RkHHB3ACef9umG6HCNQuAPY=
>    EOF
> 
> 2. Optionally, trace module requests with: trace-cmd stream -e module &
> 
> 3. Trigger add_key call for the cert:
> 
>    # keyctl padd asymmetric "" @u <test-gost2012_512-A.cer
>    939910969
>    # lsmod | head -3
>    Module                  Size  Used by
>    ecrdsa_generic         16384  0
>    streebog_generic       28672  0
> 
> Repored-by: Paul Wolneykien <manowar@altlinux.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Tested-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   crypto/ecrdsa.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/crypto/ecrdsa.c b/crypto/ecrdsa.c
> index f3c6b5e15e75..3811f3805b5d 100644
> --- a/crypto/ecrdsa.c
> +++ b/crypto/ecrdsa.c
> @@ -294,4 +294,5 @@ module_exit(ecrdsa_mod_fini);
>   MODULE_LICENSE("GPL");
>   MODULE_AUTHOR("Vitaly Chikunov <vt@altlinux.org>");
>   MODULE_DESCRIPTION("EC-RDSA generic algorithm");
> +MODULE_ALIAS_CRYPTO("ecrdsa");
>   MODULE_ALIAS_CRYPTO("ecrdsa-generic");

