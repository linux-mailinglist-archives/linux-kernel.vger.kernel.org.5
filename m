Return-Path: <linux-kernel+bounces-87310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1A86D287
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6FD28449D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4205C12F387;
	Thu, 29 Feb 2024 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C2JZT0gS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5C224D7;
	Thu, 29 Feb 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232349; cv=none; b=WW1QWrxA/e5qEMe2mGhohVbvC5JQJ+iAbCMEbr1vl9kw9a6BaxMcnY1yKSk36QSgcRufYeMvl+Oxo6R/2kqvI6h0A+pZO5W6Pd8Gn2rx2xsiWBVmFAP9ZSapB1mPxPag6Eh4flvgZo1XBvzMG4AlknP+9JvPn960Wj0ED99sWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232349; c=relaxed/simple;
	bh=srDQGGkHiAhws+fa4eSK+i2bnu9b0FjHTKnPBFQOPkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M46tn0lcFOzY2p1lsJaKWlbO5zfAuRUma9AnSl5CLr2Dat+TzNjVitdLAOJXAdYG1FvOPXInBOyadc/nUWMPXapkENsYC2ws0IhnhFCaa877yi890ugD7Lg4W8p8Mllwcc+EdSzFQX3mOKoEcM+ErX50PknSpxpynPGPPuWrNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C2JZT0gS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TIVINc010426;
	Thu, 29 Feb 2024 18:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D9o3Kfl5WFxHfdGBbvRR+ALXYgzdRvMHt5vVY/Spbj4=;
 b=C2JZT0gSbsio1mNQ1WEmGl4LT6yQrDsRofTmerA81PCKo/LEHPh4dwF35iVgVWFvoKMQ
 X+nhOiZ/h/5qdsytkA8BEkOF/v1AkehrwaDfo9+VCxlIzzmX9e+E+6VzJJEm64tfjUWO
 XnzGGMIgz4HMgTaJcSkhlC7hdyxwB6gg9E1McMGGsjI6oaD0oetvacOARJPDEo7w+t8R
 t29P5Ak2h4RQIkICI932Epm1/iK2HmyWJymLWJebmRMGrKSNqzwyIgb3Vv1XlIENDhRD
 lDVtSPU3RUeXbsgWK0Bi8E1KfkTVInHFJS9HezXAlVypNbqp50MGGHLtriISMSXCXNwN ZQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjxug926q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 18:45:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41THOwAv008178;
	Thu, 29 Feb 2024 18:45:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mqbpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 18:45:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41TIjbkC39387560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 18:45:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CF2258076;
	Thu, 29 Feb 2024 18:45:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E8CB58074;
	Thu, 29 Feb 2024 18:45:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 18:45:36 +0000 (GMT)
Message-ID: <b749d5ee-c3b8-4cbd-b252-7773e4536e07@linux.ibm.com>
Date: Thu, 29 Feb 2024 13:45:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add support for NIST P521 to ecdsa
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240229093419.GA32424@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240229093419.GA32424@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4VdUngd0qbAv4ZhZpXJPYWucAscKEPsh
X-Proofpoint-ORIG-GUID: 4VdUngd0qbAv4ZhZpXJPYWucAscKEPsh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_04,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290144



On 2/29/24 04:34, Lukas Wunner wrote:
> On Fri, Feb 23, 2024 at 03:41:39PM -0500, Stefan Berger wrote:
>> This series adds support for the NIST P521 curve to the ecdsa module.
>>
>> An issue with the current code in ecdsa is that it assumes that input
>> arrays providing key coordinates for example, are arrays of digits
>> (a 'digit' is a 'u64'). This works well for all currently supported
>> curves, such as NIST P192/256/384, but does not work for NIST P521 where
>> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
>> converting byte arrays to digits and adjusting tests on input byte
>> array lengths to tolerate arrays not providing multiples of 8 bytes.
> 
> Don't you also need to amend software_key_query()?  In the "issig" case,
> it calculates len = crypto_sig_maxsize(sig), which is 72 bytes for P521,
> then further below calculates "info->max_sig_size = 2 * (len + 3) + 2;"
> 
> I believe the ASN.1 encoded integers are just 66 bytes instead of 72,
> so info->max_sig_size is 6 bytes too large.  Am I missing something?

Right! Good catch. While the 'keyctl pkey_verify' interface was already 
working the space was too generous with 72 bytes. So I adjusted 
ecdsa_max_size now to base the size calculations on nbits rather than 
ndigits and we now get 66 bytes.

For so-far supported curves the max_sig_size is:

2 bytes for sequence (0x30) + following length as single byte
Each coordinate may have a 0 prepended to make a possibly negative 
number positive:

  => 2 + 2 * (2 + 1 + len)

In case of NIST P521 the max signature length is calculated as follows:

3 bytes for sequence (0x30) + following length as 2 bytes
The coordinates won't have a preprended 0 byte since only 1 bit is used 
in the highest bit, so only 2 bytes for

  => 3 + 2 * (2 + len)

We would have to adjust the math there as well. The max. signature size 
for NIST P521 is 139 rather than 140 with the first formula.

    Stefan



> 
> Thanks,
> 
> Lukas

