Return-Path: <linux-kernel+bounces-87424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D686D43E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2861F23F46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4901A1428FC;
	Thu, 29 Feb 2024 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bYdTaTPK"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFF1428E0;
	Thu, 29 Feb 2024 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238591; cv=none; b=qRIxSirQzA9GVl18bzMJtFYqGMCUwyDaG9HG9/RXqoK9csAhYBSA1xtl9U3sWdXWP4OC5vW5ZOcgvJzFE0PI749Vjpjha/Vxro/xRDn97w/Zeook4KtsR9ubI/O8uvhFlFiKWdffcA+pMU8Qgjr8P7+gv4QH2KIDP3n+0iKE21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238591; c=relaxed/simple;
	bh=QrhFl7E6Li6WE3UgfE5eeDFHXvNCYJaAYjR49lKDZv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4HbF2OOwx6B7JrPDFwi/gJl8nXQhEBYyjWutJoM+4XOL+YIZYNFHdbQl8wH++KzxlpHdEBBRdAkdiqRi8qRPMZqFZHqpBRQjwVM0AxFNspyhcjt3jSK6QJeNfL+zf4UdM8O1hD9PHyfj9oqG6N/F0o7CQEtaBKELi0jlzItB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bYdTaTPK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TKD5kT012650;
	Thu, 29 Feb 2024 20:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PBg+gMB7bf5lDowU5BKUpKKCa2MjD+00vjMdHznDRq0=;
 b=bYdTaTPKWqVulhan9y3PB/IBfk+azxrWIL983UBt7ovk1NIwib/wE6doGIrqCkP35fp/
 dHaq9266ihd5hnlOb9xQEBWy+qBOgk5u+Ql+O5/q6EK9/sHlwXl15yt/mW+hM4XtVicr
 rUn6AU9U76PMCMTLgE7KivfkSmlrGJPMy75fdhW/Ko5NgiWJ6zYErguj/cc8Yrar4C4i
 1TBOLZQM8BTERR+8ljqjsDnAsUnXTTynCLpMhuR0gZn0J7f9GdOIPEMywKBuS3/JuYUA
 rwazV55ZerAULTzXff9f1idrpcJ4Sq1zNhEMwBfAu+6Ne/bt0LjFNfe6XmnWAT+pQhIN YQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk0rv8gnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:29:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TJpfYY024154;
	Thu, 29 Feb 2024 20:29:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0kqpt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:29:38 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41TKTZGR33882408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 20:29:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CF225805B;
	Thu, 29 Feb 2024 20:29:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C61D35806B;
	Thu, 29 Feb 2024 20:29:34 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 20:29:34 +0000 (GMT)
Message-ID: <bd4f59d7-5633-4259-83b2-97fe28ee2610@linux.ibm.com>
Date: Thu, 29 Feb 2024 15:29:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] crypte: ecc - Implement ecc_curve_get_nbits to
 get number of bits
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-7-stefanb@linux.ibm.com>
 <20240227201552.GA32765@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240227201552.GA32765@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K_owe_xLI1ZgbAYkwAlJM9t4bygaibjX
X-Proofpoint-GUID: K_owe_xLI1ZgbAYkwAlJM9t4bygaibjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290159



On 2/27/24 15:15, Lukas Wunner wrote:
> On Fri, Feb 23, 2024 at 03:41:45PM -0500, Stefan Berger wrote:
>> --- a/include/crypto/internal/ecc.h
>> +++ b/include/crypto/internal/ecc.h
>> @@ -75,6 +75,17 @@ static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>>   	ecc_swap_digits(tmp, out, ndigits);
>>   }
>>   
>> +/**
>> + * ecc_curve_get_nbits() - Get the number of bits of the curve
>> + * @curve:    The curve
>> + */
>> +static inline unsigned int ecc_curve_get_nbits(const struct ecc_curve *curve)
>> +{
>> +	if (curve->nbits)
>> +		return curve->nbits;
>> +	return curve->g.ndigits << ECC_DIGITS_TO_BYTES_SHIFT * 8;
>> +}
> 
> Since you're amending struct ecc_curve with an extra nbits value anyway,
> why not statically fill it in for all curves, instead of adding this
> extra complexity in the code?

I filled in all curves now, including ecrdsa cruves and curve25519.

    Stefan

> 
> Thanks,
> 
> Lukas

