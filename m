Return-Path: <linux-kernel+bounces-23883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A78B82B32C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88C11F27915
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241851012;
	Thu, 11 Jan 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k0APHmvs"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE751000;
	Thu, 11 Jan 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGUDYx020123;
	Thu, 11 Jan 2024 16:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QfofUW+gNGgsqCak0mF/ypLKjhwjuZva/HN79itdiTk=;
 b=k0APHmvsPttHDwNU56VB4OLnkX4tquHovsq2RMMG5YZ2wV9hl0Jjcl0oJ6/zbeHgmbnp
 1FnT3NpHvlIosdb0qSh5A0l8mqlg6Z3bCK6s8Lum09BzCu1ofatCzmeGuozQzdgijosy
 5LF5sOR2m1JkuoUeKelGd+VO6W9ltNBZ/iRCJicIB3v4dG6XB+bFWZLOT5hlXLLzRhdv
 ESjdRZLKXTqw3ZC+PQToqBWyDHEAuz6v7T78BQT4MFRd7PR/a6+WaqE1jOTU2EuybI1v
 mrOY1fXpFS/NFNDH3uL7XNzBIMxW0XoUYSnBjUqpp8JvTVSJjEGEPdInJDgsuf7xEFgc Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjj673g48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:43:11 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40BGUuAg023403;
	Thu, 11 Jan 2024 16:43:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjj673g3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:43:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGBmBa027253;
	Thu, 11 Jan 2024 16:43:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw2c5am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:43:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40BGh9Fm9831052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 16:43:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F3758059;
	Thu, 11 Jan 2024 16:43:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 953C758043;
	Thu, 11 Jan 2024 16:43:08 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jan 2024 16:43:08 +0000 (GMT)
Message-ID: <77fe0ccd-53ff-4773-9787-0d038434297f@linux.ibm.com>
Date: Thu, 11 Jan 2024 10:43:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] tpm: tis-i2c: Add more compatible strings
To: Conor Dooley <conor@kernel.org>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        Joel Stanley <joel@jms.id.au>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
References: <20231214144954.3833998-1-ninad@linux.ibm.com>
 <20231214144954.3833998-2-ninad@linux.ibm.com>
 <20240109-saddling-nintendo-c7fbb46bb0dd@spud>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20240109-saddling-nintendo-c7fbb46bb0dd@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8AxYTwGMAwDRaW4WCoovdG1HTbAqRiPR
X-Proofpoint-ORIG-GUID: uNmibd16FkQaA9myJV97P3x6KBBICxxn
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110131

Hello Conor,

On 1/9/24 11:11, Conor Dooley wrote:
> On Thu, Dec 14, 2023 at 08:49:53AM -0600, Ninad Palsule wrote:
>> From: Joel Stanley <joel@jms.id.au>
>>
>> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>>
>> https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
>>
>> Add a compatible string for it, and the generic compatible.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> I don't understand why you broke this series up and dropped patches.
> NAK, these compatibles are not documented.
>
The original series has three patches:

1) Adding compatibility string which I am adding in this series.

2) Adding schema for the TIS I2c devices which is already covered by 
Lukas's patch (already merged in linux-next) 
https://lore.kernel.org/all/3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de/

3) Removing "Infineon,slb9673" from trivial-devices.yaml which is not 
done as it is already added in the TPM specific file. I will add it in 
my patch. Good catch!

Thanks for the review.

Regards,

Ninad


