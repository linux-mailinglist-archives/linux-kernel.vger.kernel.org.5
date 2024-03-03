Return-Path: <linux-kernel+bounces-89905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCAB86F71E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A48A281018
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AB47A15A;
	Sun,  3 Mar 2024 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ODy+0TXT"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C52F844;
	Sun,  3 Mar 2024 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709499796; cv=none; b=UmObmAb96x9FXVgdNPOTE+H4A/fQsqgn/t7awUL5fSqYzNhsigvaUt2U+QwjFIj4CG+YeXk9t5LXw3XvPT7QX5kaXa2aPx/TjxXgoWrkYiDcF6az7omY1TBXDiiHs1UrwxxiqTWxrn1+rTk7GunCKKUNBYwPxXxn2Is6D4eYOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709499796; c=relaxed/simple;
	bh=Q1SlwDX2IPHS63/TeBvyFRgdP7QEewyNH57bHy4Jg+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEECHYi6FFX8dYp63Ug5/zrbNre6fWUsfjYLkxoIcHYcLAqCm2+VjpmltwqSrpystzBviJz/i1wLGnDMWFxD7WJrOgz3QivhN3eQGwxXdp8YN5f+lJbMFOnWW6NdKmZhV0PUTtPfcBiHwGyuB5GcYS0GP4K5ycij7UpXuzuLKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ODy+0TXT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 423KWKDb012105;
	Sun, 3 Mar 2024 21:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1O7XTeLo80WEdjsYTG8xbnDjbah2VcPOv5sifLZlx30=;
 b=ODy+0TXTIVuv//Eh1lRYBkiFzQZY9UH8a1YRWsYpAhgO8Y05nHgu8HryhXRGj2ePKtLh
 77SkuSAejLTjPJBaFKvOzbQAqraL7+0P37Q4OF9gMk2s7rq9/dHzQXNTT70sqoN/VNll
 N/pjvz37PnmL2mHzSJxigmErDbHUsFRwWZYJAk9pCz/5kdk/wcKBTJsh7V8B43uddvtP
 s8VbRRj7LoZy3LZ2spLwHDH9VIIafnJCEdLwJDOZeitB9MM+48vr8SJZrB/8g/C5/6Os
 SaObH4V9P59eVfLYC0X9EMlpXbYOBfqzv9bhVDVmu0LGLUbIW1mDcCCMTUat6VEaFdyA sw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wn0b0gehf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 21:03:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 423IEN9R010910;
	Sun, 3 Mar 2024 21:03:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh51v375-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 21:03:07 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 423L34wd14942878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Mar 2024 21:03:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 436EB58070;
	Sun,  3 Mar 2024 21:03:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 393AF58055;
	Sun,  3 Mar 2024 21:03:03 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 Mar 2024 21:03:03 +0000 (GMT)
Message-ID: <24151f46-e7b3-434b-88e3-b53ac783eb13@linux.ibm.com>
Date: Sun, 3 Mar 2024 16:03:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] crypto: asymmetric_keys - Adjust signature size
 calculation for NIST P521
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-12-stefanb@linux.ibm.com>
 <20240303184745.GA9392@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240303184745.GA9392@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 01j3a4jF8HoaSlz1sMeq-Ray_McknfV9
X-Proofpoint-GUID: 01j3a4jF8HoaSlz1sMeq-Ray_McknfV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_11,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=872 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403030178



On 3/3/24 13:47, Lukas Wunner wrote:
> On Thu, Feb 29, 2024 at 09:20:06PM -0500, Stefan Berger wrote:
>> Adjust the calculation of the maximum signature size for support of
>> NIST P521. While existing curves may prepend a 0 byte to their coordinates
>> (to make the number positive), NIST P521 will not do this since only the
>> first bit in the most significant byte is used.
>>
>> If the encoding of the x & y coordinates requires more than 128 bytes then
>> an additional byte is needed for the encoding of the length. Take this into
>> account when calculating the maximum signature size.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
Thanks. I have to adjust the commit text and comment in the patch, 
though. It should be '... requires at least 128 bytes then ...'

