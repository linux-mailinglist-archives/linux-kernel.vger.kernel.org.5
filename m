Return-Path: <linux-kernel+bounces-87157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B286D066
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3975B23F55
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25196CC0E;
	Thu, 29 Feb 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CUnI60bg"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5416065F;
	Thu, 29 Feb 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227223; cv=none; b=j7cTQUsIeQ3MdPB3TfEdBzjWEY+jU5ddivbFedRwPr9X9fh+3ECFoX3ixRwUmAnfALQCHs8qWnbGItsIhFbiA4uKYdK7EJgtujDIWVzmtHLib0EZrteIjW7VEyL9Zb4oshAxcSnQzbEK5pGihsC6r3lnOVoEorAc63qH0iLJkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227223; c=relaxed/simple;
	bh=J47JN2zuNOB1XU/wuoC0gP1HXwEli68V7Qws6Hwuei4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNMfMPG9+EUI7ecjT3BpCHYGE65fXWT6/VpqRalv6gri7TSlwLdY/faMlm+pdQEGxmp94AkK9j0aTzMkI08urLvAncpVgrkwNdlmCY/4pPBC0vH/5ySX+J83oLV0ebPW2zFRJQqzU7rDI2PmyvV+Sd+Fok0I3fGagQUkVCZ2tzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CUnI60bg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TH7FeS008358;
	Thu, 29 Feb 2024 17:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IV5mhgJj7xbmsvQquxXg5BKgRYaJLGVppM18LS4QUV4=;
 b=CUnI60bgJJmq7b3KSui100LllhNOKjH3+z7o5BffpDHGukfpsGKGodc6T1Qnn2/+oJ9S
 2RAeSKSZdA3Ef6JnVDwxu6tOW6cOJen9W4wGytPeMrPng2B2BhlxzupTNBDdiQuVenhn
 DBBsUz+z715spEO6LcwVWRQW3rAVN6IxP7WcD8+kcpdQfTLdJvFp86cALfpEzkSX8Vfy
 Fev4x/OgO4ssIJzLw7aRCWO5oRwneotrqw0MWRjLmYNGgEg1KOx6VMXLnNAuogpO/vI5
 xMcQg0sZwsg5Nr04iDwfNL6mo4daglWg6CJ26rzVJoj3dNnlZetTmAtG37YNhoVhUfiG EA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjx1t8exg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 17:20:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TFZ92V008211;
	Thu, 29 Feb 2024 17:20:13 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mps6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 17:20:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41THKBLd21234200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 17:20:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8924058071;
	Thu, 29 Feb 2024 17:20:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D20A15806F;
	Thu, 29 Feb 2024 17:20:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 17:20:08 +0000 (GMT)
Message-ID: <88b7574d-c9eb-47c2-928b-e9e19ba7835d@linux.ibm.com>
Date: Thu, 29 Feb 2024 12:20:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
 <20240229091105.GA29363@wunner.de>
 <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
 <20240229164810.GA7144@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240229164810.GA7144@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lOMZ-E5THFawRCYSPAOOJE_ZezzTMpeI
X-Proofpoint-ORIG-GUID: lOMZ-E5THFawRCYSPAOOJE_ZezzTMpeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_03,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=734 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290134



On 2/29/24 11:48, Lukas Wunner wrote:
> On Thu, Feb 29, 2024 at 09:57:30AM -0500, Stefan Berger wrote:
>> static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>>                                           u64 *out, unsigned int ndigits)
>> {
>>          unsigned int o = nbytes & 7;
>>          u64 msd = 0;
>>          size_t i;
>>
>>          if (o == 0) {
>>                  ecc_swap_digits(in, out, ndigits);
>>          } else {
>>                  for (i = 0; i < o; i++)
>>                          msd = (msd << 8) | in[i];
>>                  out[ndigits - 1] = msd;
>>                  ecc_swap_digits(&in[o], out, ndigits - 1);
>>          }
>> }
> 
> Might be beneficial to add a code comment explaining the else-branch
> is for curves with key length not a multiple of 64 bits (such as NIST P521).

Will do. I am also using this here now since it's safer: 
ecc_swap_digits(&in[o], out, (nbytes - o) >> 3);

    Stefan

> 
> Otherwise LGTM, thanks!
> 
> Lukas

