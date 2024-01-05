Return-Path: <linux-kernel+bounces-18422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59838825D39
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4742832FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D59360BE;
	Fri,  5 Jan 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CZWJ+NS3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C22360AB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405NHbCV020756;
	Fri, 5 Jan 2024 23:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dk/9wd6mk3XvZJWT8D4yhYy3MZa/HSdG4Hz96XTchxU=; b=CZ
	WJ+NS3JjiyZGK8T76F0FHD6IbqLXfW7zbXwuPixpQRzp+N9sYxVVJLVNafizcSX3
	ak8M+IpPImgZMIL/344Eq+bM3CFo1eZIpuF7nk9Jgg7S4sAIwPeF7EE8O5W32He7
	vCFNite6oVl9f2bn+Uw6QbeW1kf4XXV++K7FgurEkJvXHkEf+U9l30ctK+zl70RL
	fmuyb9iGkG1zNXUdntfj3geoxZKQxBk0TBil4qfVkJYb+2mE6USZbfrFtrPIcFAs
	8c4xIqK7aEgY/AEPtAr6F9g/y0Q0Uz+hnUvql+Rw+rpwPgUL0dddBPOxSaYCJsMM
	lH0hpHA9JIqEEhj+moYw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve95utghp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 23:47:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405NkwMo026789
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 23:46:58 GMT
Received: from [10.110.39.102] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 15:46:57 -0800
Message-ID: <b9b5b669-0318-93c8-c6a0-dbbb797320f2@quicinc.com>
Date: Fri, 5 Jan 2024 15:46:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Content-Language: en-US
To: Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy
	<quic_cgoldswo@quicinc.com>
CC: Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>, Roman Gushchin
	<guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, Joonsoo Kim
	<js1304@gmail.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
 <Y9r6LtMOPHfxr7UL@google.com>
From: Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
In-Reply-To: <Y9r6LtMOPHfxr7UL@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -c1JALMRyMNc0HBfXDpf2g4SW5q-enf8
X-Proofpoint-ORIG-GUID: -c1JALMRyMNc0HBfXDpf2g4SW5q-enf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=439 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050182


On 2/1/2023 3:47 PM, Minchan Kim wrote:
>
> I like this patch for different reason but for the specific problem you
> mentioned, How about making reclaimer/compaction aware of the problem:
>
> IOW, when the GFP_KERNEL/DMA allocation happens but not enough memory
> in the zones, let's migrates movable pages in those zones into CMA
> area/movable zone if they are plenty of free memory.

Hi Minchan,

Coming back to this thread after a while.

If the CMA region is usually free, allocating pages first in the non-CMA
region and then moving them into the CMA region would be extra work since
it would happen most of the time. In such cases, wouldn't it be better to
allocate from the CMA region itself?

Sukadev


