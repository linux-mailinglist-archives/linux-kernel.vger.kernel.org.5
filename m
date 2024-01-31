Return-Path: <linux-kernel+bounces-45996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC5843903
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB5B23DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E2C5DF35;
	Wed, 31 Jan 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bSz6ItBv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75586605CC;
	Wed, 31 Jan 2024 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689650; cv=none; b=sF7mGaPfGWCPiCjKVWPRfOHfsI7nvOAorCvMad8YAwBjkNOC5PlafliF7l4iDIqUZqNChzD64leEYM+LncPmQJ6rjoGentkMe6OQAs+KkJ3Me5l36RRByizNJAQYlCimcLBOay6d4YzGdSWRODvbaLp8D1/sQQ/F+iI0UMFJUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689650; c=relaxed/simple;
	bh=PTEOKC6/qcbD9lkAoHNJMFMTvZ4gPN0L8pPtiSKbgZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fZAdy6Wv7oRMeB96kYjpDDM9tuAox+0QBonlr2F2wgNYIPLLu/B0nibc+064ECmqvxeT/k0VDLdNTBPztiLdyB2DrC6tpWj4m6406X4la+udiCK1Tey+7+x1Y1455pk0EbAabCNqZU2kuCzPYNRAp34lOPZtL1d7NvP5PKbvRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bSz6ItBv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V76sWG029058;
	Wed, 31 Jan 2024 08:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=tYl3s9p
	5OEXscwNJG7uavE127SKilayG8iPqXxCe7J8=; b=bSz6ItBvDwSjImIX4XsrWzR
	R8KShudwp38LAKxVNx1rHyudHgMKzVBQFsVFuYC/ELgdcCelfYh+JAxcgLLHYUXk
	f787NNero5aIzZwUXCCljJimxiLZfEeq7O87wAeYkcGKjSPGWXqNKpIFHCtzgjKy
	trxNtTqA/aj3/g/H32I/U0CaC9OLuujK6MopMdh5xYjqj0PIis1pFkDsXZuRMcdY
	dx0E1b6ggjvkm5hFhLTynrRG15pan0nD10xohbXDjaX4lRjyoX6sUepCiRndYx9q
	1PINXuPRlWDOhUW5d0AufID5aLq8GhirX5UuXsZsS2yRo9/c8sHCPdKD6zUHSOA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy9b8saew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:26:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V8QeQM025364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:26:40 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 00:26:39 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Leo Yan
	<leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Mathieu
 Poirier" <mathieu.poirier@linaro.org>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>
Subject: [PATCH v3 0/2] coresight: core: Add device name support
Date: Wed, 31 Jan 2024 00:26:24 -0800
Message-ID: <20240131082628.6288-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7IEwbEnrFHWUphbr28oJoRi62uk0ZeO9
X-Proofpoint-ORIG-GUID: 7IEwbEnrFHWUphbr28oJoRi62uk0ZeO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1011 spamscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310063

With current design, the name of the non-cpu bounded coresight
component is the device type with the number. And with 'ls' command
we can get the register address of the component. But from these
information, we can't know what the HW or system the component belongs
to. Add device-name in DT to support it.

cti_sys0 -> ../../../devices/platform/soc@0/138f0000.cti/cti_sys0
cti_sys1 -> ../../../devices/platform/soc@0/13900000.cti/cti_sys1
tpdm0 -> ../../../devices/platform/soc@0/10b0d000.tpdm/tpdm0
tpdm1 -> ../../../devices/platform/soc@0/10c28000.tpdm/tpdm1
tpdm2 -> ../../../devices/platform/soc@0/10c29000.tpdm/tpdm2

Change since V2:
1. Fix the error in coresight core.
drivers/hwtracing/coresight/coresight-core.c:1775:7: error: assigning to 'char *' from 'const char *' discards qualifiers

2. Fix the warning when run dtbinding check.
Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml: device-name: missing type definition

Change since V1:
1. Change coresight-name to device name.
2. Add the device-name in coresight dt bindings.


Mao Jinlong (2):
  coresight: core: Add device name support
  dt-bindings: arm: Add device-name in the coresight components

 .../bindings/arm/arm,coresight-catu.yaml      |  6 +++
 .../bindings/arm/arm,coresight-cpu-debug.yaml |  6 +++
 .../bindings/arm/arm,coresight-cti.yaml       |  6 +++
 .../arm/arm,coresight-dummy-sink.yaml         |  6 +++
 .../arm/arm,coresight-dummy-source.yaml       |  6 +++
 .../arm/arm,coresight-dynamic-funnel.yaml     |  6 +++
 .../arm/arm,coresight-dynamic-replicator.yaml |  6 +++
 .../bindings/arm/arm,coresight-etb10.yaml     |  6 +++
 .../bindings/arm/arm,coresight-etm.yaml       |  6 +++
 .../arm/arm,coresight-static-funnel.yaml      |  6 +++
 .../arm/arm,coresight-static-replicator.yaml  |  6 +++
 .../bindings/arm/arm,coresight-stm.yaml       |  6 +++
 .../bindings/arm/arm,coresight-tmc.yaml       |  6 +++
 .../bindings/arm/arm,coresight-tpiu.yaml      |  6 +++
 .../bindings/arm/qcom,coresight-tpda.yaml     |  6 +++
 .../bindings/arm/qcom,coresight-tpdm.yaml     |  6 +++
 drivers/hwtracing/coresight/coresight-core.c  | 37 ++++++++++---------
 .../hwtracing/coresight/coresight-platform.c  | 31 ++++++++++++++++
 include/linux/coresight.h                     |  3 +-
 19 files changed, 149 insertions(+), 18 deletions(-)

-- 
2.41.0


