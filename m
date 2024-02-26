Return-Path: <linux-kernel+bounces-82048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B68867E45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91FB1C2CA72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8412DDB6;
	Mon, 26 Feb 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="km1NyRKX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF312F5BA;
	Mon, 26 Feb 2024 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968170; cv=none; b=gVeOEAQ3Uliy1WF7k6L2VFDO8StiY+YhKUIVSDw2zcptDw4dSZVL0Ee8vEgK0AhoMXrNfRxgDYbs8iieSFj1/C/Vr5aSMGI5Woknj5wDuUNSMJbRPsOgpFT61w0pXgyqAC5z4twY2Kt5NmgNCT7IEl8QaSzKP0o4qdcLTFUYNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968170; c=relaxed/simple;
	bh=U8t2ESsI4CcVZphAgS7e2T8l+PJy2Q0N4kwscHHmEZ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Szxxq48mIoJ0rMwiU55w5lL0rWwAD8YnOaIv/zPM3HA8S/ABgS5teMTGkmDHZbFQsnH+cqwoOqnhQXsWYgVBT19FYxIQXDUdJG3oGqzh1SvQQDCfW+38iyzOGNRA8RrOtsRPp7WBQ5DO5/LmHwxgBV0+fqBK8JyCJ+a9nSLP5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=km1NyRKX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF8vAO011259;
	Mon, 26 Feb 2024 17:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=WSMjhNn
	35cLADacMh39W7rFnj1+8t1bmLlgzSAMVrNE=; b=km1NyRKXzx35zPvzLX9P1QB
	gqTbo5SRkfPSP3nNm0WPgrlWIbBruGetHF/YPfTIF5o6GwTUUA2U0SHFuMlBVgge
	U10D5qBw/K2XU9Zisa/yS6HPmHPudSjOr1Hxxntw9GXjGC/msodgG9DDL22lzSig
	GwLgw+ZDw7VbktDlpM6EfqM1oIVWE2Y+czP13rCDR2LcKcbsoS1zDJnIySvo08Ej
	d+KbFIdDR2qzDeFo9/6iVP1Pkq7nXjYOzlwEKavH22UGyYnrItQy0eD8qU1ycEzp
	dM78ivoSwxw8W4N/9b/g6qmD745bwB2XqMqvYSjZGLwrkTGZveHOIEZC2diKedA=
	=
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxpsjj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:22:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QHMX3G006877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:22:33 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 09:22:32 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robdclark@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v5 0/7] Add support for Translation Buffer Units
Date: Mon, 26 Feb 2024 09:22:11 -0800
Message-ID: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lV5dc0zywG9KoHXOSOzomwlzH-RcRpX-
X-Proofpoint-ORIG-GUID: lV5dc0zywG9KoHXOSOzomwlzH-RcRpX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=934
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260132

The TCUs (Translation Control Units) and TBUs (Translation Buffer
Units) are key components of the MMU-500. Multiple TBUs are connected
to a single TCU over an interconnect. Each TBU contains a TLB that
caches page tables. The MMU-500 implements a TBU for each connected
master, and the TBU is designed, so that it is local to the master.
A common TBU DT schema is added to describe the TBUs.

The Qualcomm SDM845 and SC7280 platforms have an implementation of the
SMMU-500, that has multiple TBUs. A vendor-specific DT schema is added
to describe the resources for each TBU (register space, power-domains,
interconnects and clocks).

The TBU driver will manage the resources and allow the system to
operate the TBUs during a context fault to obtain details by doing
s1 inv, software + hardware page table walks etc. This is implemented
with ATOS/eCATs as the ATS feature is not supported. Being able to
query the TBUs is useful for debugging various hardware/software
issues on these platforms.

v5:
- Drop the common TBU bindings and child nodes. These TBU functionalities
  are only Qualcomm specific and not generic. In the unmodified ARM MMU-500
  implementation there are no TBU-specific resources, so just make them
  standalone DT nodes. (Robin)
- The "qcom,stream-id-range" DT property now takes a phandle to the smmu
  and a stream ID range.

v4: https://lore.kernel.org/all/20240201210529.7728-1-quic_c_gdjako@quicinc.com/
- Create a common TBU schema. Move the vendor-specific properties into
  a separate schema that references the common one. (Rob)
- Drop unused DT labels in example, fix regex. (Rob)
- Properly rebase on latest code.

v3: https://lore.kernel.org/r/20231220060236.18600-1-quic_c_gdjako@quicinc.com
- Having a TBU is not Qualcomm specific, so allow having TBU child
  nodes with no specific constraints on properties. For some of the
  vendor compatibles however, add a schema to describe specific
  properties and allow validation. (Rob)
- Drop the useless reg-names DT property on TBUs. (Rob)
- Make the stream-id-range DT property a common one. (Rob)
- Fix the DT example. (Rob)
- Minor fixes on the TBU driver.
- Add support for SC7280 platforms.

v2: https://lore.kernel.org/r/20231118042730.2799-1-quic_c_gdjako@quicinc.com
- Improve DT binding description, add full example. (Konrad)
- Drop Qcom specific stuff from the generic binding. (Rob)
- Unconditionally try to populate subnodes. (Konrad)
- Improve TBU driver commit text, remove memory barriers. (Bjorn)
- Move TBU stuff into separate file. Make the driver builtin.
- TODO: Evaluate whether to keep TBU support as a separate driver
  or just instantiate things from qcom_smmu_impl_init()

v1: https://lore.kernel.org/r/20231019021923.13939-1-quic_c_gdjako@quicinc.com

Georgi Djakov (7):
  dt-bindings: iommu: Add Qualcomm TBU bindings
  iommu/arm-smmu-qcom-tbu: Add Qualcomm TBU driver
  iommu/arm-smmu: Allow using a threaded handler for context interrupts
  iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845
  arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
  iommu/arm-smmu-qcom: Use the custom fault handler on more platforms
  arm64: dts: qcom: sc7280: Add DT nodes for the TBUs

 .../devicetree/bindings/iommu/qcom,tbu.yaml   |  65 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  89 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  70 +++
 drivers/iommu/Kconfig                         |   9 +
 drivers/iommu/arm/arm-smmu/Makefile           |   1 +
 .../iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c    | 495 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    |   8 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  12 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |   3 +
 10 files changed, 752 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c


