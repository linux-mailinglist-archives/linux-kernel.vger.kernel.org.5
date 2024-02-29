Return-Path: <linux-kernel+bounces-87420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A07F86D42F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3591C21553
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EFA1428FE;
	Thu, 29 Feb 2024 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E04MSEm8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6713F447;
	Thu, 29 Feb 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238521; cv=none; b=u11JJW1f8AHRzCs3qMRuKj6i5L1w+yEIO7eS82mgh6pafZyW1yKCbwzzGh5Z983T89YgQLccYSw+TvQW1WOmxgNJl+EoDjxPE2+hLsPF6BXrmZaNmOBrdd8IcKVH0h0PxlKnXHe0vmqdEiFzZhJDcYUDPo/tpkWW/bU1NCV0tp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238521; c=relaxed/simple;
	bh=VqsCIPtHHNaI9OJXGog4COezsI+ULkRiq4knYU05kVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gk+YeXdiZdK+ZpJAOWdEjXB8Gi7MNl+N+gDW7HtaPg3F8DVjJdsL7etE4sztjkZ9e+5Dn8O6umKKIl/nc1Awiqb8K3fTVSyCjWn0TjIAFBFkTg+FOONaMH22ym8YHkCjoWvIEkL+dbstBbcy/zk/sHlYPNr1U5zKBatEFq8iaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E04MSEm8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TKCwmo028811;
	Thu, 29 Feb 2024 20:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aFSYUu6iOQ75R2cDUfv7WMc6lcFBEd6AFrkiNERi2io=;
 b=E04MSEm8hea7TxGMWoKZaAPgtbB/Pyl7thJ8rmgF0R4nJ96Nkuw5rpehrte1LuyPn/ON
 3LWfFPSIKxhNOXpE8hkjEpNuiZpv/p8TC1OH2m5VT9NUYSXF56TeiTPSTfC/g3ri15er
 Ri7ey4hC7ShDcll+OzkHJHGZZ+8CieXVTd0OYN7rLAiXbp77bRncpgIKvFKP3qa/tk0U
 XD5gDsRrmngRWBO+UMB10eUqJlWrI3GeyCVWs7C8NKnOG/QBQbIItBk9weVYXWUuwKSC
 UDCb76BH6wblf29NBRl1XNddp3NeOmFOHo4UYdAw3pwJU3j31X67ED/wZhicWKK0tdmM Xw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk0rygae8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:28:31 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TJrNsC024127;
	Thu, 29 Feb 2024 20:28:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0kqpjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:28:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41TKSRFa7144144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 20:28:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41FE858055;
	Thu, 29 Feb 2024 20:28:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EBD15804B;
	Thu, 29 Feb 2024 20:28:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 20:28:26 +0000 (GMT)
Message-ID: <122110de-7f54-4b6c-a2aa-cc9d4280a08a@linux.ibm.com>
Date: Thu, 29 Feb 2024 15:28:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] crypto: ecdsa - Adjust tests on length of key
 parameters
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-3-stefanb@linux.ibm.com>
 <20240229091605.GA11866@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240229091605.GA11866@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2Q2Oxr8PaMFkgNpCTwBr4zp0EeTJ2PbJ
X-Proofpoint-ORIG-GUID: 2Q2Oxr8PaMFkgNpCTwBr4zp0EeTJ2PbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=967 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290159



On 2/29/24 04:16, Lukas Wunner wrote:
> On Fri, Feb 23, 2024 at 03:41:41PM -0500, Stefan Berger wrote:
>> @@ -239,7 +239,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
>>   	keylen--;
>>   	digitlen = keylen >> 1;
>>   
>> -	ndigits = digitlen / sizeof(u64);
>> +	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
>>   	if (ndigits != ctx->curve->g.ndigits)
>>   		return -EINVAL;
> 
> This deletes a line inserted by the preceding patch in the series.
> I'd prefer just squashing the two patches together.
> 
Hm, I moved this part here into 1/10 and left he other hunk in 2/10 
since they deal with slightly different issues.

    Stefan

> Thanks,
> 
> Lukas

