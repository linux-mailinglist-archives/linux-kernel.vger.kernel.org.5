Return-Path: <linux-kernel+bounces-62100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BE0851B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854AAB2263F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1793EA78;
	Mon, 12 Feb 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XhoQwY6c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21A3F8D0;
	Mon, 12 Feb 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759024; cv=none; b=bh6TpMOWeZ6iabcPs5WiDEoYu4YlTibLgJsCh7XgCScp9TBSarGk/Gh3k+eC6lsRM3d0EnOGjeWcQ6NFy1akcokcvI+FA+oAXgD1Q3+sa7v2jGL1jbEqPJAO3gEyyuro9ML0PyK5ouROI3QUISXmNGg9Ch16D82RVCPfYpAHjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759024; c=relaxed/simple;
	bh=ZHz2/Ii2ezqNSyAK1WHFHID3r78PJgY7A/ovJL/qKVs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=jmTSR4mlhIzMxwCKl7bgT+36ScVYSpnRNXsjGd74trdIFiYtvRpGXqy/Y1yTi4CrmiG7XZjZclNG27VRu42ycFHyMnT6kMrCCV9mfJ9DAOpy86u1yMBGHFXVjsYmdOjCmMSnOOkmTgDRSuk2MqK2c+YFcNRVN9Br1TlkXUdVjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XhoQwY6c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CDWMM2029846;
	Mon, 12 Feb 2024 17:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mFP93yrNCBsj8NEPJw3QpaEx/+1X39HZCQ2vhvFATU4=; b=Xh
	oQwY6cFCoNr21eQv9CMDQAUN7ZiaLKUEdtxPi3MgdyjEdOuwPlLIHKWehZ9u8xCL
	sjxkBxx6GIaP3s+LGEywfy87A0U4WWgXCWcyA9/hlHAUqlKHR/TaBDULqOeTZRzo
	tMltdFXGh7to9XIi8kwIcSPUO4Z/axOC5RdlyyiGW2763+2dGDql2TYioJOQwdlv
	ze9sVhH4Nq3a8jRUD3jwLcihDTMdZwlGPPlxfkP3UHNrcdzvW5ZJCHw/7Lfdj5a6
	cvMKKBUAxyQmtoBgx9aYxkzvkA8cXWh+UjKa9hXh+UKHWFrw2aeS42E+QRVdMMgS
	cbQvmBe8NPNwKQk/fbDA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ju78t7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:30:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CHU0wC027045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:30:00 GMT
Received: from [10.216.55.125] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 09:29:53 -0800
Message-ID: <13da9cd9-218d-4b3f-98f8-62edcd91a23e@quicinc.com>
Date: Mon, 12 Feb 2024 22:59:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
Subject: Re: [PATCH v4 03/10] iommu/arm-smmu-qcom: Add support for TBUs
To: <quic_c_gdjako@quicinc.com>
CC: <andersson@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <djakov@kernel.org>,
        <iommu@lists.linux.dev>, <joro@8bytes.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cgoldswo@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <quic_sukadev@quicinc.com>,
        <robdclark@gmail.com>, <robh+dt@kernel.org>, <robin.murphy@arm.com>,
        <will@kernel.org>
References: <20240201210529.7728-4-quic_c_gdjako@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240201210529.7728-4-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9AwD145O5tY5kb5MEBPsEImeSD339Gw-
X-Proofpoint-GUID: 9AwD145O5tY5kb5MEBPsEImeSD339Gw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120133

Hi

The following patch would introduce a use-after-free bug which was found 
during KASAN testing on qcm6490 with the patch.

diff 
<https://lore.kernel.org/all/20240201210529.7728-4-quic_c_gdjako@quicinc.com/#iZ2e.:20240201210529.7728-4-quic_c_gdjako::40quicinc.com:1drivers:iommu:arm:arm-smmu:arm-smmu-qcom.c> 
--git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c index 
8b04ece00420..ca806644e6eb 100644 --- 
a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c +++ 
b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c @@ -1,12 +1,14 @@   // SPDX-License-Identifier: GPL-2.0-only
  /*
   * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved    */
  
  #include <linux/acpi.h>
  #include <linux/adreno-smmu-priv.h>
  #include <linux/delay.h>
  #include <linux/of_device.h>
+#include <linux/of_platform.h>   #include <linux/firmware/qcom/qcom_scm.h>
  
  #include "arm-smmu.h"
@@ -446,6 +448,7 @@ static struct arm_smmu_device 
*qcom_smmu_create(struct arm_smmu_device *smmu,   	const struct device_node *np = smmu->dev->of_node;
  	const struct arm_smmu_impl *impl;
  	struct qcom_smmu *qsmmu;
+ int ret;   
  	if (!data)
  		return ERR_PTR(-EINVAL);
@@ -469,6 +472,12 @@ static struct arm_smmu_device 
*qcom_smmu_create(struct arm_smmu_device *smmu,   	qsmmu->smmu.impl = impl;
  	qsmmu->cfg = data->cfg;
  
+ INIT_LIST_HEAD(&qsmmu->tbu_list); + mutex_init(&qsmmu->tbu_list_lock); 
+ ret = devm_of_platform_populate(smmu->dev); // smmu has been freed by 
devm_krealloc() above but is being accessed here again later. This 
causes use-after-free bug. + if (ret) + return ERR_PTR(ret); +   	return &qsmmu->smmu;
  }

Can it be done like below?
  	qsmmu->smmu.impl = impl;
  	qsmmu->cfg = data->cfg;
  
+ INIT_LIST_HEAD(&qsmmu->tbu_list); + mutex_init(&qsmmu->tbu_list_lock); 
+ ret = devm_of_platform_populate(qsmmu->smmu.dev);// Using the struct 
to which smmu was copied instead of freed ptr. Thanks, Pratyush


