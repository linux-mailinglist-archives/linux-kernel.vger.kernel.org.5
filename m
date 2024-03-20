Return-Path: <linux-kernel+bounces-108246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839CD88085B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73BB1C221CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53414A3F;
	Wed, 20 Mar 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WOC4bKhR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B405A3F;
	Wed, 20 Mar 2024 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710892910; cv=none; b=uBxq/zqTFZtVnNfJOUQ1aJBiF+rRbBRLnddx6hyvMa9vnWLnKoq3dIeFuXnowvB012OJM+3zieGJYHgdb+05aF3a66lP1TlgcxSDBRnNCcU4M/XNeuJUiamKJHzfEPCoqhTy2yZn4pvyeA0vEPJNpRgRuwZNlNhFVDgRSAW/osM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710892910; c=relaxed/simple;
	bh=IVDEuG+K92OuDuMDDkbiP/QqPunhdWup9XhuuFTQ6EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=QFnQqmtlifWmn72GxWUQalT4JlLVBP1zB+Fm20gimQneb4wsJNkvrMiWc1Q/rJnGiVtH1vYwqHDKjyRiYkGMjk8eb9q2nFlS2PBuXhn2zouHbcMRV/QeOB9YTbxqyaZq4EF8NJKP02rKu2Xgns6bxxtoLHJOHEPwpHQHCkVxxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WOC4bKhR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JNouPt018330;
	Wed, 20 Mar 2024 00:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=4uI
	TGLS/QZjOWMPZgyipRrXMGrLg+jzf6SI8nKo+Z+8=; b=WOC4bKhRZz0q5pmyONC
	rvFMp+Iv+Or58wy5uCE966xPPsQ08fHbtFzVNwKJSMmjyvJPYg2BEZsCUkCpHOdA
	fTc2CBcuy7di2nbyovhNndohIjeK80/HciA1f18n3fd9zmIuOaJEnCoCvBaUesv/
	7/sYP4Bht2c+5V7MXtAHA+B5v79Dn4IrQbFcWKI5M/i3p5ndqFz8vkHSS17z2Ap1
	ce/0m4fXOOkrjBQnuOtWFuPipwzv3Rayqq4dpX6cThNJ6j7VzTy/95JKcGYdjgbi
	fSTcF3YXYNdwCKHv9BFyLGJX9+/lg5mdg33F7s8ugRfRNdpiIIwxlYkF2uENnWwU
	P5Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy5ws2ar0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 00:01:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K01jvY000929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 00:01:45 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 17:01:45 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 19 Mar 2024 17:01:45 -0700
Subject: [PATCH] MAINTAINER: Split Qualcomm SoC and linux-arm-msm entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240319-maintainer-qcom-split-v1-1-735d975af2c2@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGgn+mUC/x2MQQqAIBAAvxJ7bkEtovpKdChdayGtNCII/550m
 MMcZl6IFJgi9MULgW6OvPsssixAr5NfCNlkByVULSrZoZvYXxkKeOrdYTw2vnBulGkra4WVAnJ
 7BLL8/N9hTOkD7C8//2cAAAA=
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710892905; l=2706;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=IVDEuG+K92OuDuMDDkbiP/QqPunhdWup9XhuuFTQ6EA=;
 b=F82yes7eMWd7dX2kJuy9TH2n31AaQTZ+JP6fKLodn1Sq26GFhGEMqMYLb1nevbQOlYmQ0FiIk
 XLqvemc5LqZDg376ElOzkv2HQIllihJKoOeLGElNkHVt7KvRhX/GcUh
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LmMn40Sz1oN78SlHLnrhOLZPO3Pefy1l
X-Proofpoint-GUID: LmMn40Sz1oN78SlHLnrhOLZPO3Pefy1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=1 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190186

The Qualcomm Support entry in MAINTAINERS has served the purpose of both
defining the scope of the Qualcomm support, and to make Qualcomm-related
patches show up on the linux-arm-msm mailing list.

While this continues to serve our needs, it occasionally do create
confusion about the ownership.

Split the entry to clarify which components are maintained under the
qcom-soc tree.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 MAINTAINERS | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82896c3e0559..6196757a10aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2586,12 +2586,8 @@ F:	arch/arm64/boot/dts/qcom/sc7180*
 F:	arch/arm64/boot/dts/qcom/sc7280*
 F:	arch/arm64/boot/dts/qcom/sdm845-cheza*
 
-ARM/QUALCOMM SUPPORT
-M:	Bjorn Andersson <andersson@kernel.org>
-M:	Konrad Dybcio <konrad.dybcio@linaro.org>
+ARM/QUALCOMM MAILING LIST
 L:	linux-arm-msm@vger.kernel.org
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
 F:	Documentation/devicetree/bindings/*/qcom*
 F:	Documentation/devicetree/bindings/soc/qcom/
 F:	arch/arm/boot/dts/qcom/
@@ -2627,6 +2623,33 @@ F:	include/dt-bindings/*/qcom*
 F:	include/linux/*/qcom*
 F:	include/linux/soc/qcom/
 
+ARM/QUALCOMM SUPPORT
+M:	Bjorn Andersson <andersson@kernel.org>
+M:	Konrad Dybcio <konrad.dybcio@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
+F:	Documentation/devicetree/bindings/arm/qcom-soc.yaml
+F:	Documentation/devicetree/bindings/arm/qcom.yaml
+F:	Documentation/devicetree/bindings/bus/qcom*
+F:	Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+F:	Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+F:	Documentation/devicetree/bindings/reserved-memory/qcom
+F:	Documentation/devicetree/bindings/soc/qcom/
+F:	arch/arm/boot/dts/qcom/
+F:	arch/arm/configs/qcom_defconfig
+F:	arch/arm/mach-qcom/
+F:	arch/arm64/boot/dts/qcom/
+F:	drivers/bus/qcom*
+F:	drivers/firmware/qcom/
+F:	drivers/soc/qcom/
+F:	include/dt-bindings/arm/qcom,ids.h
+F:	include/dt-bindings/firmware/qcom,scm.h
+F:	include/dt-bindings/soc/qcom*
+F:	include/linux/firmware/qcom
+F:	include/linux/soc/qcom/
+F:	include/soc/qcom/
+
 ARM/RDA MICRO ARCHITECTURE
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

---
base-commit: 226d3c72fcde130a99d760895ebdd20e78e02cb5
change-id: 20240319-maintainer-qcom-split-b62d83ff0f10

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


