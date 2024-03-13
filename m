Return-Path: <linux-kernel+bounces-101648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD7087A9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25251F22F78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02D41202;
	Wed, 13 Mar 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nFoH0v54"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53641A80;
	Wed, 13 Mar 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341885; cv=none; b=WH/w/BDt9x8PyxRWSpA79xpmGHGwGWU4AlUt7Apirchdg2hT1EIOb/pLyftHKXivk0Ewhf13gQ0OV2D4HM8TiWHK7Kj9Z/DaRBetmn37449CDF38JI6ozEBjBl4RypVPLBgw7XutaUYA7D5psyvwtug/pe+tMA6BbhtY0CZzxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341885; c=relaxed/simple;
	bh=tSGx9aucqe8tQCPIADE6/TpidPfmFhxkVtgWt4Hiedg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JD+VthQXYN+T1vrL/1zMhrAR9zcAxtoJJXMrG3BiysaBt+aEexCZUmhm17NkVqfTqO40PjyxUZQpBlvGkLhb5vBOrCTKauLwRLAfwmsH4zPdBFPWduei3/TudCTwU6wBb4gDC2Pv5NTXpTjyKyVDGLGsJTIIxQdpXyBtdJ5OPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nFoH0v54; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DEkSME032625;
	Wed, 13 Mar 2024 14:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qCBGe7ZpGBK727TUdwf0kV6d1Z3WZ5UJrEChvor47KI=;
 b=nFoH0v54fCnS+13SbTV48uan5wHeVVd/GrgUDZAP0ZnJl0+KWaS+YoWINN94WnebmNTx
 4xSM9m6R+aywMQb8jh1sQpxwBRK3egzr6sSUsoaS6CMNUISd2CqRq5w3KYyzmR5XLoLf
 4Aka3MJc45UXovgRhsGRmY3YtXnga3xCGMasqvzXCkc7sqYhhj2zbuxZBSLZ1r28DSwG
 VzzEa8UY9hWILb40BidH0K1hC4mNVE7N1swqzHtUiXlP3nuv7ZqXlkITsNvWruuPTj8o
 LF7D0y7hRGWpN6ygYDW6adeesQda/qoxh4XDYIFCB9n2UnI+8c/Lpw0KsIWhYBaM1FUr Yw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wud2rhsje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 14:58:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DCRcu7015524;
	Wed, 13 Mar 2024 14:58:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fyxpfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 14:58:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DEvsbc28836604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 14:57:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56D792004B;
	Wed, 13 Mar 2024 14:57:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C8AC20040;
	Wed, 13 Mar 2024 14:57:54 +0000 (GMT)
Received: from [9.152.212.186] (unknown [9.152.212.186])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 13 Mar 2024 14:57:54 +0000 (GMT)
Message-ID: <b4fd2ff7-9b3e-4059-9277-bef5d66bd129@linux.ibm.com>
Date: Wed, 13 Mar 2024 15:57:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] s390/cio: Use while (i--) pattern to clean up
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20240222134501.236871-1-andriy.shevchenko@linux.intel.com>
From: Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <20240222134501.236871-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uVmDOjz8i9J3DGbIBqVN4JHevMLiIa1K
X-Proofpoint-GUID: uVmDOjz8i9J3DGbIBqVN4JHevMLiIa1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=630 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130111



On 2/22/24 14:45, Andy Shevchenko wrote:
> Use more natural while (i--) patter 

typo: pattern

to clean up allocated resources.
> 
> Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> ---
>   drivers/s390/cio/ccwgroup.c | 4 ++--
>   drivers/s390/cio/chsc.c     | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Otherwise, looks sane to me.
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Sorry for taking a while to get back to this.The patch ended up getting
lost in the shuffle after my vacation.

