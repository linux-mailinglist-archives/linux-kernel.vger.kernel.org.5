Return-Path: <linux-kernel+bounces-1522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D199814FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F234F28687D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998F3C6AC;
	Fri, 15 Dec 2023 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tt8mXvCE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBD3FB0B;
	Fri, 15 Dec 2023 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFICaEs019649;
	Fri, 15 Dec 2023 18:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dVW3SnfMl0mCJfi3oJkoPR9xq6Yf+K2lsGRlI93QcLg=; b=Tt
	8mXvCEfCTwjl3pgVPOVK/+OT7XOu2YOQBzPdIuUe3MZ5licAb0gxu0IMBnb4yV85
	jzKXXprHfUNKtz0RMAEdIO0JkC4wE02Uq68Nzmj+XEMf5SXIB5hdhX9hJTamEbTe
	4DHXqMsHIyXub4Ts9S0zAEB4lkUcxolkhdo9qYy3786nqxmbGZ6rbyGDbA813C4+
	x3mLTaYbEw2fBWc6GURTQcmjJpUNcsay/c8sag4VKjpEgHklZAptPSJFEIXNjF6X
	Ubb6aAgbkMFpUku2GYwd4FyJQO6pLo1H6UDzcD+QaozPjgguh1tVz0UIBy45sWmW
	UYKhzYqbN8Tv8jQGKWMA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0p100xfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 18:23:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFINhRd026163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 18:23:44 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 10:23:43 -0800
Message-ID: <8aee3661-f04d-f9db-3513-2cd14b6fa67b@quicinc.com>
Date: Fri, 15 Dec 2023 11:23:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v5 1/2] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>, Bhaumik Bhatt <bbhatt@codeaurora.org>,
        <stable@vger.kernel.org>
References: <1702276972-41296-1-git-send-email-quic_qianyu@quicinc.com>
 <1702276972-41296-2-git-send-email-quic_qianyu@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1702276972-41296-2-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vIFhtdXyPc9OFpGAyf7fJHgL8XeBr0fA
X-Proofpoint-ORIG-GUID: vIFhtdXyPc9OFpGAyf7fJHgL8XeBr0fA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=715 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150129

On 12/10/2023 11:42 PM, Qiang Yu wrote:
> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
> 
> Protect WP accesses such that multiple threads queueing buffers for
> incoming data do not race.
> 
> Meanwhile, if CONFIG_TRACE_IRQFLAGS is enabled, irq will be enabled once
> __local_bh_enable_ip is called as part of write_unlock_bh. Hence, let's
> take irqsave lock after TRE is generated to avoid running write_unlock_bh
> when irqsave lock is held.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 189ff97cca53 ("bus: mhi: core: Add support for data transfer")
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Seems to work fine for AIC100

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

