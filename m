Return-Path: <linux-kernel+bounces-129002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC89896301
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB661F247C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E023C6A4;
	Wed,  3 Apr 2024 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ANSBk0/U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5371BF38;
	Wed,  3 Apr 2024 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115218; cv=none; b=WSTq86/t/hhyavBHdZb0aiqOe+M4IqBCCjKF/QKnGl+t60VHhDzBfT+fOsgA+GDHuBRAtW/v9smKWlv4AXoITFmdqRe/4YcqMgdZAoAppU21Mh3Na/fmRP7Lp9jAOhbe6GOtYqPQoQFJ+TWqFJayrFQe+X3KeCQ0HcTeC/9ElR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115218; c=relaxed/simple;
	bh=AEFN2g1XqQAecQq1StxHkP71nlCNzxJ4zfazB8iCrlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EIRhBNxz2/OOri3N4HI3LHuWykaW6DRvd90vgQL06J13PPrVp8XqzxbMPOvS74m1g+sCSVHkGdIxQ1XlEhvBVCKaOLY95AzrYndT0/Kx3p9OtR2zl60M23l4koE0o6R1xKuovedoBt9bGSC/QYJ/P5Tn9wImkeLiltWs+i3pqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ANSBk0/U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4332lUWN023778;
	Wed, 3 Apr 2024 03:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=uda
	rEq835bWsxBbl4fFgf5SjERhaLcJ8nmX7hUUcsw8=; b=ANSBk0/UI4G7a2ie820
	lbcdyGoepIQbJMpCNNb7R+O5MLeUE/6lGrff0W1ek/cPNsLtJudHga56Huay1REu
	GM/XN8LJla0etgOh/Kky8NivICbisB131SUmvmt5mBau85q0wq5BlvNaS6zcydZ+
	7lQzYgoxUGKDWVUTSkiWxIFADhxTZxbdRT2BRs7a1SxzaCMjohzQFKjSdgWCXgxd
	T/Chw4sjdWWKu2R9XaT6uK+ZnDV7EGG2Y3swp93cLBsstcTnEmtPjZ40wDYqfw3R
	vnbK8IsyRQM6YFSldG6+t0NE78PNUkMKOcPK0Nr5bzQhbACwjVBlpdbzseYssKvI
	gPQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8h5et2h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 03:33:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4333XWwX004513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 03:33:32 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 20:33:32 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 2 Apr 2024 20:33:30 -0700
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Specify zap region for
 gpu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240402-rb3gen2-gpu-v1-1-a51bb6080968@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAnODGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMz3aIk4/TUPCPd9IJSXRNjE+Nk05Rk81QTAyWgjoKi1LTMCrBp0bG
 1tQAlmUG2XQAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Caleb
 Connolly" <caleb.connolly@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Naina Mehta <quic_nainmeht@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712115212; l=1207;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=AEFN2g1XqQAecQq1StxHkP71nlCNzxJ4zfazB8iCrlA=;
 b=K/4SewJRqhlkt7jqZGNMR03arzmhdAQ9z42dJXSQImn/LkfzH0lEFhCiDcW3kXBVyHERMI+j1
 WUWKo6fse8kAvLq3JYpCNJ7DRi3pqXP7wOLS+9YK2q3bBiMS7xt9Zaf
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b2GODJPS76v8uTFfKlmc3j1erMDh8Wrj
X-Proofpoint-ORIG-GUID: b2GODJPS76v8uTFfKlmc3j1erMDh8Wrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_02,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=784 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404030023

Without the zap region defined the enabled GPU will, if able to find the
other firmware files, attempt to initialize itself without the zap
firmware loading, which causes the rb3gen2 to freeze or crash.

Add the zap-shader node and define the memory-region and firmware path
to avoid this problem.

Fixes: 04cf333afc75 ("arm64: dts: qcom: Add base qcs6490-rb3gen2 board dts")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 63ebe0774f1d..5b81b5e0b4ce 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -471,6 +471,13 @@ &gcc {
 			   <GCC_WPSS_RSCP_CLK>;
 };
 
+&gpu {
+	zap-shader {
+		memory-region = <&gpu_microcode_mem>;
+		firmware-name = "qcom/qcs6490/a660_zap.mbn";
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

---
base-commit: 727900b675b749c40ba1f6669c7ae5eb7eb8e837
change-id: 20240326-rb3gen2-gpu-4343c5dc7e40

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


