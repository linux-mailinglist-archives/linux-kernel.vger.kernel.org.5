Return-Path: <linux-kernel+bounces-120198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FBD88D454
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE6F2E45C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7F9249EB;
	Wed, 27 Mar 2024 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d+CFBINC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29721345;
	Wed, 27 Mar 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505089; cv=none; b=X6in/bP/Wkhb0pAGxQuzdIDIBlMzwF1C2Y4rgGWr3coAYrLzdPK9PVF8SHlS1WCPsc/rKCwbEGtWYEQ7qCyLcyAeSOsysX32x/fZ+ddIe2pWp99u/dY/g6mHIoh9B/7EApoipWzMbV5f9M0L0baLyoBRV6i4XSEzlLDCVbNEhvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505089; c=relaxed/simple;
	bh=kYZZCT+tVZo+wzi0+UGkVOFjutWFIRGaQL+n6olgMg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Frjwb2S8ws47kOI6Tb1DqsJrrQCyPKQ64O5nbT5mNnSnNIUJFFxSZw1udmu4+qDzjyNwxtSsG/vSAQyRUZXXNpxPQ2BP9dCAhKfkXA/RujaXqXxSIcHMKB2Gsdx86iYvAm5IFGj09DFijaqCItH8wF0KSdvavvH7mgVA+Z8W9Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d+CFBINC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R0Yx1o022470;
	Wed, 27 Mar 2024 02:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=NXtVgefK4raQ7faPqjNggnc9tYgAinpwX/+19HWeAgw
	=; b=d+CFBINCH8idOKWeWMinfcjd5FvlzQfqP+GdTZTClZZJTKzNhBca1lEaoNp
	5CPztrnefQavU5J0ud2+jdAfNErVAMipDdHzNE3sTohvSQ1lSJWiKGCMxhtDcERE
	naY2o7dhi6GBy74B+wcJWdpoR7QHLXq7yQiuF670stdEgQYvDjyUFfWMTE9Fq2Oa
	LMlQjzwkI1UeNzmAh8Yjev6uKwQjpctmpOFzXKruXIsMyxedqaLC7Rt2E17ZiBIe
	6XcxQdAQ8S8dmS6deOstprhx8MWCk/YdobcGlAjloCx3BMq5lkQ7mDgPFeXRnxix
	vybF+KgNzOaQYJSJtwBu2+HqVHw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x477yrc4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R24VMA027983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:31 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 19:04:31 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 26 Mar 2024 19:04:23 -0700
Subject: [PATCH v2 6/6] arm64: defconfig: Enable sc7280 display and gpu
 clock controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240326-rb3gen2-dp-connector-v2-6-a9f1bc32ecaf@quicinc.com>
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711505069; l=956;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=kYZZCT+tVZo+wzi0+UGkVOFjutWFIRGaQL+n6olgMg0=;
 b=zkorffrQN9mVJC8RuXXwtfcolWMKRUwtUWWDvACQ24nysSOgx3ebbpq/n6xIw91LeWeCC/FRO
 T1T3C7weM+/CTWJP6fSlcry1ZRiQqoRWR6qDCfaBdJZU13DyJqyPKQk
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gkvihbcHLx--v0QnJq73ln0SJ_QwFeYC
X-Proofpoint-ORIG-GUID: gkvihbcHLx--v0QnJq73ln0SJ_QwFeYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=919 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403270012

Enable the SC7280 display and gpu clock controllers to enable display
support on the QCS6490 RB3gen2.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c45a465a071..a25a28e6117b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1287,6 +1287,7 @@ CONFIG_QCM_DISPCC_2290=m
 CONFIG_QCS_GCC_404=y
 CONFIG_QDU_GCC_1000=y
 CONFIG_SC_CAMCC_8280XP=m
+CONFIG_SC_DISPCC_7280=m
 CONFIG_SC_DISPCC_8280XP=m
 CONFIG_SA_GCC_8775P=y
 CONFIG_SA_GPUCC_8775P=m
@@ -1294,6 +1295,7 @@ CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
 CONFIG_SC_GCC_8180X=y
 CONFIG_SC_GCC_8280XP=y
+CONFIG_SC_GPUCC_7280=m
 CONFIG_SC_GPUCC_8280XP=m
 CONFIG_SC_LPASSCC_8280XP=m
 CONFIG_SDM_CAMCC_845=m

-- 
2.25.1


