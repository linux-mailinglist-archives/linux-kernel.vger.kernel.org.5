Return-Path: <linux-kernel+bounces-5479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67574818B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127441F22D66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04C11C6B3;
	Tue, 19 Dec 2023 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D7+iiYBo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252321CA91;
	Tue, 19 Dec 2023 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJFMmsY005041;
	Tue, 19 Dec 2023 15:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OjDSW67WfOHNYepERi2F4vGTbKkUTWV7AvtejFbFzoE=;
 b=D7+iiYBocTfjcTadmJeolJolk9pb8W5gGpAtlC9eG86ZGWJA/v4SGa6Xh2NC7dqKsHfR
 UlDH06osgD30u367G+JzyWxhZF2Pz1+KjFQoOj+ZyFN6sMRFqjUvE752Xs1hg1weOpQX
 d7QUXr5pxydfSZ9D7RYrqC/dGH0B2ZJieCJsWngt0iocw5l2v5dhPgZjL692rsGzaVhg
 RMT2MyoYQNvmqq/KQRbFDN9hsGGvSnF0fVHsAeA4175ifoIQgXkPtbs7pGIWY/7B9FQK
 IGQ0NOSscLVfWd6sPsGBn+788vwYJBSmkQzsZAAEkIf1BlP7JSCCsbP6myvFOqqPGExH 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3dmn852q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:23:47 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJFNlkN008798;
	Tue, 19 Dec 2023 15:23:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3dmn851r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:23:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJDM8ag010900;
	Tue, 19 Dec 2023 15:23:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7ngjjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:23:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJFNi4h44368316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:23:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5548D20043;
	Tue, 19 Dec 2023 15:23:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14C1520040;
	Tue, 19 Dec 2023 15:23:44 +0000 (GMT)
Received: from [9.152.224.160] (unknown [9.152.224.160])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 15:23:44 +0000 (GMT)
Message-ID: <21124441-d57b-46d4-8926-dedf7d2485d2@linux.ibm.com>
Date: Tue, 19 Dec 2023 16:23:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] icuv: make iucv_bus const
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, wenjia@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <2023121950-prankster-stomp-a1aa@gregkh>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <2023121950-prankster-stomp-a1aa@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rn_94nL-4GRqZWWVvHjyJ_6GpxjrfHM8
X-Proofpoint-ORIG-GUID: l5lIv2UJc5DrTxWxvfRCfMp55OCb-7sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 mlxlogscore=644 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190115



On 19.12.23 16:07, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the iucv_bus variable to be a constant structure as well, placing
> it into read-only memory which can not be modified at runtime.
> 
> Cc: Alexandra Winter <wintera@linux.ibm.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Acked-by: Alexandra Winter <wintera@linux.ibm.com>

