Return-Path: <linux-kernel+bounces-86884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D83D786CC39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66835B2575B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1CC137775;
	Thu, 29 Feb 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bEQ3KDEP"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F151353F8;
	Thu, 29 Feb 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218725; cv=none; b=N2Rp+Z8+zljKdvLjSvB5a0GuDNGLhMfUD0B9+eLh3QfKuj8GJu/dzRTGFtyLOubUq3+44OxmGJpEaw4Q/phmxv8org6n8TGt3b4XOnNfA464mDDvVeOF4PjR6IdgfS4tTKApVEWO1cLZoylvyGH4sWU/Qz4+KJH2XyFJjOrCLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218725; c=relaxed/simple;
	bh=vt8AtWviueFaNUh2SIRA7kFo2RoOzji6O8iI5DEzmzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+w+I1AgTm9+iiZCIEUuRBkGSmythVUTQFTwzbKqIP3GUwnIlZsMcSKfU3vAt5EnXrvZIsLxU9sugXtHVA9uxEWpEQ3hWXOLPET2OO9bnaRwCZJVPelgsRFW1ZYGCV2BJwhAul7FGAvsrrKCGzsmnb3vT8dvwgtjJic2eh2Ftt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bEQ3KDEP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TES2QI014349;
	Thu, 29 Feb 2024 14:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r/t14PRcRophG5LFLb15IuPPFzri/0d0atNhzF7nkec=;
 b=bEQ3KDEPRcFxBuYEmgeihUIoqRNivj6jS0cHkOSvcHTrpB0EDA5M88FacHVcH8A7Gfoo
 3vRLMIG+q6bUZKvn++PMR0dx252dkekBX3t8D5wqA3T6IiUdsZdOXPrcbyR4fqETMwoj
 FW/6MHWHiYO7vnVGFKZUVOx0K9eXinmgGEwiuMG4LxgWdFV/TFER/CxMi//JDI2XX8EL
 wDwYdT+rjvktyp8G+5iY4MxrCAK+c71FNMAoOD+BdpRVI4GVjnolb8APUYlOsfE/EwX1
 ErzkdMDenZkBj/EvMnlkLNkQR0kZEcY+C04wemh/CjfqBmdMcJBilgP0IsRhqUn6tX8q og== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjuq7rutv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 14:57:35 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TDf9UY008782;
	Thu, 29 Feb 2024 14:57:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftstxakd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 14:57:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41TEvVhF57606594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 14:57:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F1958063;
	Thu, 29 Feb 2024 14:57:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9980E5805B;
	Thu, 29 Feb 2024 14:57:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 14:57:30 +0000 (GMT)
Message-ID: <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
Date: Thu, 29 Feb 2024 09:57:30 -0500
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
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240229091105.GA29363@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e8QKhuV7oPEm9p7MO45mPyckdj26FnXI
X-Proofpoint-ORIG-GUID: e8QKhuV7oPEm9p7MO45mPyckdj26FnXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290114



On 2/29/24 04:11, Lukas Wunner wrote:
> On Fri, Feb 23, 2024 at 03:41:40PM -0500, Stefan Berger wrote:
>> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>> +					 u64 *out, unsigned int ndigits)
>> +{
>> +	unsigned int sz = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
>> +	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
>> +	unsigned int o = sz - nbytes;
>> +
>> +	memset(tmp, 0, o);
>> +	memcpy(&tmp[o], in, nbytes);
>> +	ecc_swap_digits(tmp, out, ndigits);
>> +}
> 
> Copying the whole key into tmp seems inefficient.  You only need
> special handling for the first few bytes of "in" (6 bytes in the
> P521 case) and could use ecc_swap_digits() to convert the rest
> of "in" directly to "out" without using tmp.
> 
> So it would be sufficient to allocate the first digit on the stack,
> memset + memcpy, then convert that to native byte order into "in[0]"
> and use ecc_swap_digits() for the rest.
> 
> And the special handling would be conditional on "!o", so is skipped
> for existing curves.

Thanks. It looks like this now:

static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
                                          u64 *out, unsigned int ndigits)
{
         unsigned int o = nbytes & 7;
         u64 msd = 0;
         size_t i;

         if (o == 0) {
                 ecc_swap_digits(in, out, ndigits);
         } else {
                 for (i = 0; i < o; i++)
                         msd = (msd << 8) | in[i];
                 out[ndigits - 1] = msd;
                 ecc_swap_digits(&in[o], out, ndigits - 1);
         }
}


   Stefan

> 
> Thanks,
> 
> Lukas

