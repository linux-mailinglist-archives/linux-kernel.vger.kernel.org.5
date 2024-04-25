Return-Path: <linux-kernel+bounces-159051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DD48B28A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7127CB24BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B665715216D;
	Thu, 25 Apr 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EF1JDHJJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9392C1514D9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071585; cv=none; b=N8bxoCx+snx701tq9fYo/FnQS3T1hiiOCztJPyAi1eueK1dcIWkYhx8uKGqjgn0sA0e4KZxsJd2YJBeIHUxVMPSqBBB7DHUHyv15ubxYc12TO2ZinAFDobok9Ar2FWf3l2Zc98qfRpyRUyYjNj8kgVk6ftgnbJcy+Lg4TXaw8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071585; c=relaxed/simple;
	bh=5C6zNSy4/2fDi0G/VYNh1plSgWvrbg3nFQBR/aDxNik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IT1C1A0BuFqU85EcIzM8FI517FJen1AYGdDbFLUdMvolimOkqVwwObv5eu1i89Rx2ipYy0AMsFAeoaKqgW6mrvdpIPuRO2F5kQrliOnWmdEfDpf/VqVz+2LJWexXRdv0TzhvSvmzefjoM2fxIVDpq1WpRWdFYkRfm7Ml+pJ4sj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EF1JDHJJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PEYjV4002706;
	Thu, 25 Apr 2024 18:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LpWQj2agrBscOTWLDNZ2TUQqcQ07PBdL0wdDCx/qiRo=; b=EF
	1JDHJJjiRG6WGlfF2Oc5UdptJ6hIV2+ogBIqwjhmPo2dkwVjY2Q61+HhonI7zXaL
	Y+jkVXwCwJ/jCVMP0uX9tzWniEyCf0z6DgCI3sDipIIwwgaqwbSdxi2RdvDnkCRb
	j58t2Y5juxsm2LbCEIAn48pmx+NHsSo9kEpAxX3t7nI9uQbvo2kXGqUGDAQ2ob1q
	4zkcdDnorIzvg076Y7LMQX82yHsYJKCby7m7Bdr1Eorg1JYoBSulIChAGCs5jb7l
	bHrsKYXMvnGEfZPOJtK+mNQzG1i2ZThvR6T56dylubKr8968CPh8EEAO2clrHXUQ
	bC7gjR9w+QD4U8OEpUzg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqrwwrnfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:59:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PIxOKs030249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:59:24 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 11:59:23 -0700
Message-ID: <8c55dba5-6308-685e-13da-e728197d8101@quicinc.com>
Date: Thu, 25 Apr 2024 12:59:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
Content-Language: en-US
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, <linux-kernel@vger.kernel.org>
CC: Oded Gabbay <ogabbay@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner
	<christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>,
        <etnaviv@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2PY6mTTuSoTIfvx0SDz3oNbowXinSuZ6
X-Proofpoint-ORIG-GUID: 2PY6mTTuSoTIfvx0SDz3oNbowXinSuZ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_19,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404250136

On 4/24/2024 12:37 AM, Tomeu Vizoso wrote:
> If we expose a render node for NPUs without rendering capabilities, the
> userspace stack will offer it to compositors and applications for
> rendering, which of course won't work.
> 
> Userspace is probably right in not questioning whether a render node
> might not be capable of supporting rendering, so change it in the kernel
> instead by exposing a /dev/accel node.
> 
> Before we bring the device up we don't know whether it is capable of
> rendering or not (depends on the features of its blocks), so first try
> to probe a rendering node, and if we find out that there is no rendering
> hardware, abort and retry with an accel node.
> 
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> Cc: Oded Gabbay <ogabbay@kernel.org>

I hope Oded chimes in as Accel maintainer.  I think Airlie/Vetter had 
also previously mentioned they'd have opinions on what is Accel vs DRM.

This gets a nack from me in its current state.  This is not a strong 
nack, and I don't want to discourage you.  I think there is a path forward.

The Accel subsystem documentation says that accel drivers will reside in 
drivers/accel/ but this does not.

Also, the commit text for "accel: add dedicated minor for accelerator 
devices" mentions -

"for drivers that
declare they handle compute accelerator, using a new driver feature
flag called DRIVER_COMPUTE_ACCEL. It is important to note that this
driver feature is mutually exclusive with DRIVER_RENDER. Devices that
want to expose both graphics and compute device char files should be
handled by two drivers that are connected using the auxiliary bus
framework."

I don't see any of that happening here (two drivers connected by aux 
bus, one in drivers/accel).

I think this is the first case we've had of a combo DRM/Accel usecase, 
and so there isn't an existing example to refer you to on how to 
structure things.  I think you are going to be the first example where 
we figure all of this out.

On a more implementation note, ioctls for Accel devices should not be 
marked DRM_RENDER_ALLOW.  Seems like your attempt to reuse as much of 
the code as possible trips over this.

-Jeff

