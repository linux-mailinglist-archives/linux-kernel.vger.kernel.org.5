Return-Path: <linux-kernel+bounces-6741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F98819CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60F21F21AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287E20332;
	Wed, 20 Dec 2023 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WFNUzZsz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2222030B;
	Wed, 20 Dec 2023 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BK9M0p8013415;
	Wed, 20 Dec 2023 10:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iwWma8cZ9aS71ZfZwoeukmPm1JcbbrlRzgqA4zD+xZQ=;
 b=WFNUzZszzkQrOaiZTRoYgHJ/Ir0+JVztUcP59yDaXg51htpfVJ4pkJfyT5eIoWjPuATO
 zbMnddbNouq5fDlYABNidADjWhZnoOT37a/ALrtUQDIAgIbuNLvOVt5NEeJMNzjFW/sU
 9bb/9PVgUHqMFrgggF7C3mldKbVUrGgMrKd7wZnCX6bjIATcHX23SPOjfzj+tX+N7Mf6
 hra958VusMgj6yO/earqP7aQm0cy+MAwLAvn34BKo7U9HS2T+5GOfZ343CwhnoePFz+Q
 p713ho1TjoS64mY8iSXqyn1bhqviUTSjMV7ra9r6dINkrEj1n8uicLz9DcIjQwbkb1+n LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3n4gvjnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:27:52 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BK9v0wk002163;
	Wed, 20 Dec 2023 10:27:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3n4gvjn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:27:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BK7xdUe010900;
	Wed, 20 Dec 2023 10:27:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nnr6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:27:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKARk8128049954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 10:27:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2038B20065;
	Wed, 20 Dec 2023 10:27:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5DC62004B;
	Wed, 20 Dec 2023 10:27:45 +0000 (GMT)
Received: from [9.152.224.160] (unknown [9.152.224.160])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 10:27:45 +0000 (GMT)
Message-ID: <f43f77f9-416b-4ef6-9def-f0dd1b7a3efb@linux.ibm.com>
Date: Wed, 20 Dec 2023 11:27:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/10] net/smc: unify the structs of accept or
 confirm message for v1 and v2
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
 <20231219142616.80697-4-guwen@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231219142616.80697-4-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xkfw8UmfKOyny7_hP9KLIrMxYIubc7sT
X-Proofpoint-GUID: juB57zyeVn9VWg97zh-jhQs1JKxOQAqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=775
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200073



On 19.12.23 15:26, Wen Gu wrote:
> The structs of CLC accept and confirm messages for SMCv1 and SMCv2 are
> separately defined and often casted to each other in the code, which may
> increase the risk of errors caused by future divergence of them. So
> unify them into one struct for better maintainability.
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/af_smc.c  | 52 +++++++++++++------------------------
>  net/smc/smc_clc.c | 65 ++++++++++++++++++++---------------------------
>  net/smc/smc_clc.h | 42 +++++++++++++-----------------
>  3 files changed, 62 insertions(+), 97 deletions(-)

Thanks a lot Wen Gu, I really love this.
Using an unnamed union is a great solution here. Now the code is so much more
readable and maintainable

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>



