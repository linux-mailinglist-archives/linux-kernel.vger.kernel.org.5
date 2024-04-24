Return-Path: <linux-kernel+bounces-156657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7248B0665
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5501C22C34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4776A158DD7;
	Wed, 24 Apr 2024 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lVSVn+oT"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFC1E4A9;
	Wed, 24 Apr 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952136; cv=none; b=E9w95c77itvCowqDQ8yoV5Lgw7iJl1ao17UfaFXhw1IJC44qaNt4Iicno/GpftYkJaVqWeEB94bisals1OZINscGag3ttyU4DEiSJIXtW7VNtKBybDtDM3YMY/DqxFuqbWWJAsbetZMqg7WyGz7+0lW6lI1o2nzBTmWMprgnEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952136; c=relaxed/simple;
	bh=gjvTM5WoCXZfZuumlfuDjOkBqIB5Kok9g+SQrAlXbwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hfJhj/maLigu2fPsbNfIIZH0OHn+U7wGF03k7HH0ooEiyLuFYYCvoBSZ6jCdk2lqvA//I60hX3Wn7f69CCaJZ4941/UV7+w26eI8iSSZ9WMomyrLu+TLo6xg7+ZRqztPlnE/78Mm2mTVMjQdIKTJGw3IyF/3UKKJO5nA1bgcH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lVSVn+oT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43O8wGvH000580;
	Wed, 24 Apr 2024 09:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=S0JRj5pKLCFlpW9XNhYLC6VhpFJ6oksErg2cwtnNIwA=;
 b=lVSVn+oT24geL8ikK+8OKBUOkD822sF0qrmdAm1Mhxuz2BwRqh5o5+oMCadT1z5MS/er
 FjYR/9TnFlzqX7VsHa9yXa9JZ5DGaMlC1HyOGIHRRXWAXx0UoehRLvNlFPdo7by4/okj
 5go4aMacrv2g7XkLwI+hGBx4Ekicn8IynUbCz54fDvQfoKdHqT+qbiBkKp5LAce0us3o
 1FIcpVW+8/E9f18ZKoV62EQfmI/9QRPb9in8OzO7JIOdQrzhEOQenSxuCpJdJiT1u8+6
 0vkCEfx6Hr5IC0ySYzeNhW7DeeVCXceBaaWk1hi8TWb6fSM/+JAfDvl/fP94nmQebPYL ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpy12g38t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:48:21 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43O9mKIZ013420;
	Wed, 24 Apr 2024 09:48:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpy12g38q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:48:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43O7mRPq023065;
	Wed, 24 Apr 2024 09:21:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1p2tv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:21:21 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43O9LJLx23200476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 09:21:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D8258052;
	Wed, 24 Apr 2024 09:21:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EF2258050;
	Wed, 24 Apr 2024 09:21:15 +0000 (GMT)
Received: from [9.152.212.241] (unknown [9.152.212.241])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Apr 2024 09:21:15 +0000 (GMT)
Message-ID: <3b6b4973-0973-40e4-a107-4c81840c9ed3@linux.ibm.com>
Date: Wed, 24 Apr 2024 11:21:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, broonie@kernel.org, linux-s390@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>
References: <20240423213844.122920086@linuxfoundation.org>
 <CA+G9fYsm9OYUh+H9X2kpJWXsPdde36=WbSWc+mU0vO0i-QaWOw@mail.gmail.com>
Content-Language: en-US
From: Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <CA+G9fYsm9OYUh+H9X2kpJWXsPdde36=WbSWc+mU0vO0i-QaWOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tz9a1ZkTDNaYgCbEfl71qQD-ElGlqFD3
X-Proofpoint-GUID: cWVFI8ZpF-PAsklbHzHAdnBTc4Y9cm5k
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240041

On 24.04.2024 09:57, Naresh Kamboju wrote:
> On Wed, 24 Apr 2024 at 03:16, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 5.15.157 release.
>> There are 71 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> 
> The s390 defconfig build failed with gcc-12 and clang-17 on the Linux
> stable-rc linux.5.15.y branch.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> ---
> drivers/s390/cio/qdio_main.c: In function 'qdio_int_handler':
> drivers/s390/cio/qdio_main.c:761:52: error: incompatible type for
> argument 2 of 'ccw_device_start'
>   761 |                 rc = ccw_device_start(cdev, irq_ptr->ccw,
> intparm, 0, 0);
>       |                                             ~~~~~~~^~~~~
>       |                                                    |
>       |                                                    struct ccw1
> In file included from arch/s390/include/asm/qdio.h:13,
>                  from drivers/s390/cio/qdio_main.c:18:
> arch/s390/include/asm/ccwdev.h:172:50: note: expected 'struct ccw1 *'
> but argument is of type 'struct ccw1'
>   172 | extern int ccw_device_start(struct ccw_device *, struct ccw1 *,
>       |                                                  ^~~~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:289: drivers/s390/cio/qdio_main.o] Error 1
> 
> 
> Suspected commit:
> --------
> s390/qdio: handle deferred cc1
>   [ Upstream commit 607638faf2ff1cede37458111496e7cc6c977f6f ]

This is due to a type change of field 'ccw' in 'struct qdio_irq' that
was introduced in v5.17 via commit 718ce9e10171 ("s390/qdio: avoid
allocating the qdio_irq with GFP_DMA").

The following change to commit 607638faf2ff ("s390/qdio: handle deferred
cc1") fixes the compile error on v5.15:

--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -758,7 +758,7 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,

 	if (rc == -EAGAIN) {
 		DBF_DEV_EVENT(DBF_INFO, irq_ptr, "qint retry");
-		rc = ccw_device_start(cdev, irq_ptr->ccw, intparm, 0, 0);
+		rc = ccw_device_start(cdev, &irq_ptr->ccw, intparm, 0, 0);
 		if (!rc)
 			return;
 		DBF_ERROR("%4x RETRY ERR", irq_ptr->schid.sch_no);


