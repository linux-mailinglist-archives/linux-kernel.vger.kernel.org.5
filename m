Return-Path: <linux-kernel+bounces-30725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D75E83239B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDCF28421B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10483C32;
	Fri, 19 Jan 2024 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="moCEPN6T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A668186F;
	Fri, 19 Jan 2024 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705634629; cv=none; b=SKfC4Zstmz0L0LdgAahAdY3QA0rRkAXvyQj7rpk8tzxvfMWiRZRGxtqiL5n/50VWgmm6wGzgk+JT+cIB8cw/aOFqW/ffdtJIRrcxr5ENCwUxhFWucpFlGXkamZC9uW1qrrlbwPW4YkalgO7DabSKOLLj5OO2EOoGEQqjE+s9zrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705634629; c=relaxed/simple;
	bh=Uewh1FnrdtUjaw3IbQp5/cVxlxfhVTRPnk+3maWKx+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khZAeISMvl4xQQNnOce9uezdmtkkmydrbhIAJIkhIlmjvki/kjnenXNvzI8dyFhvqvwRk2EBx25RCRGQo2xRZLEcnZSKRJ8atBbouMlOp7Bsvk/egqDPdf3YsuRVBp8hJ/o/+YF3zhwWb4GH6Ij0VDGVynPJpBrLC2+8BAqT1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=moCEPN6T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J0f8bZ031574;
	Fri, 19 Jan 2024 03:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=eG0cw3V2V7bP1GdeOMsX
	cfVKOjDgrWaClaMQX8x+Rcc=; b=moCEPN6Tu3lLFU3iTIFnjd9XAojWFiCJfjkW
	N+ISLLzZYSWQnUjSIwWnDkgeIrihb9EsrpMNp/I0RR8ZQa0jlLvi2rNCOyQFzDWc
	dfljbvPajztqrUfo7GXbLJ3f/I9Wve5yIObYX/GN6i0tgv+JgjYrY9Cz+IxPLe04
	LxY61RU5ULvFVh6IBU83kk+smcPYYzs2uQ5k+2s/3rUSc/JVn1+LSjXhT2FAON5j
	P+6mJzlP+KDrJp8wLxBmRsgxjLDQzthu3gs0YGgDg8gajybFn1tMfSF1dhDQsonI
	hN26aoFjgpmYX5ESAc6fm+oeSdANIL/UkPAPPR98OSOfjcDyEg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq403hue3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J3NWCx005461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:32 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 19:23:27 -0800
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH v4 01/10] coresight-tpdm: Optimize the store function of tpdm simple dataset
Date: Fri, 19 Jan 2024 11:22:54 +0800
Message-ID: <1705634583-17631-2-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
References: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YKVaIyHCUjWlngrNat9x1vbWd0xlDZWy
X-Proofpoint-ORIG-GUID: YKVaIyHCUjWlngrNat9x1vbWd0xlDZWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=882 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401190012

Replace spin lock/unlock to avoid forgetting to unlock when the
function exits. And refine methods for handling various conditions.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 39 ++++++++++----------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index bd13a548375c..0427c0fc0bf3 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -77,51 +77,50 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
 					 size_t size)
 {
 	unsigned long val;
-	ssize_t ret = size;
+	ssize_t ret = -EINVAL;
 
 	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct tpdm_dataset_attribute *tpdm_attr =
 		container_of(attr, struct tpdm_dataset_attribute, attr);
 
 	if (kstrtoul(buf, 0, &val))
-		return -EINVAL;
+		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	guard(spinlock)(&drvdata->spinlock);
 	switch (tpdm_attr->mem) {
 	case DSB_TRIG_PATT:
-		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
+		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT) {
 			drvdata->dsb->trig_patt[tpdm_attr->idx] = val;
-		else
-			ret = -EINVAL;
+			ret = size;
+		}
 		break;
 	case DSB_TRIG_PATT_MASK:
-		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
+		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT) {
 			drvdata->dsb->trig_patt_mask[tpdm_attr->idx] = val;
-		else
-			ret = -EINVAL;
+			ret = size;
+		}
 		break;
 	case DSB_PATT:
-		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
+		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT) {
 			drvdata->dsb->patt_val[tpdm_attr->idx] = val;
-		else
-			ret = -EINVAL;
+			ret = size;
+		}
 		break;
 	case DSB_PATT_MASK:
-		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
+		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT) {
 			drvdata->dsb->patt_mask[tpdm_attr->idx] = val;
-		else
-			ret = -EINVAL;
+			ret = size;
+		}
 		break;
 	case DSB_MSR:
-		if (tpdm_attr->idx < drvdata->dsb_msr_num)
+		if (tpdm_attr->idx < drvdata->dsb_msr_num) {
 			drvdata->dsb->msr[tpdm_attr->idx] = val;
-		else
-			ret = -EINVAL;
+			ret = size;
+		}
 		break;
 	default:
-		ret = -EINVAL;
+		break;
 	}
-	spin_unlock(&drvdata->spinlock);
 
 	return ret;
 }
-- 
2.17.1


