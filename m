Return-Path: <linux-kernel+bounces-39281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA283CE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE24E1F28AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DEF13BEA0;
	Thu, 25 Jan 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gc+eEYjJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8013A270;
	Thu, 25 Jan 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216723; cv=none; b=oyeodUHP+mGg+cCk9r9F67KFfcKaaWjhHDMID4ylpKRAni7fVxUVCVHLz0de0Hgad6hEKrd/98hpJlA7HCLq+awvWCpwaX7dXY2lMUYGoIPtbmBelUdrYnBb6oZFdDAXQzAFEXUamwRAgI6i8Z3gegJzgcRGDRuRqkeUhCAnVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216723; c=relaxed/simple;
	bh=LmGmDzI8fc2erGli/opzJCTKeAu3YbTeUxNqQMXGvfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N5s3dDoLebE8m5oPghQhFOiNgEfGsdI15IDUi173DK/Im9uEaXxjhQC7p+QWybJguMKWxMraAgda52YcAT2wMf8HrAgDWFguAh7mBez8/vLuJ72UvLJxxx84Jaw2soXZ/c+mYElnlieEKhfEGm+TzT/B5QhngtSUpd07GpXnn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gc+eEYjJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PKspPU025870;
	Thu, 25 Jan 2024 21:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=Guz8yeo3QmRlknBvsUNYp41mzoUQ4HdU0LuZ2ETVe5U
	=; b=Gc+eEYjJ/zgOCjJBIyzVzdWrHhF+Srh0dyp5rFq6G3KIuy5Mf9ApjqyA9AH
	17svFBNknDjwXXBAQyRLvz12qa+QrAfZ1HCeW8Fi/1pSFqFixUpY4Wtrgur+GRAp
	pH+iox6HPb4F2nEMufTQWVMcRdqvcciQ663gf5yrm/rCpgC8OKyTjbgq7BK+4P7m
	WR1FFoVGVJAjdg4i3763q/n2Tta9XYMRk/XBbZfwc0ZpbD84t7jhSZXJ4UJ0ApPq
	rjRVQxUsMeRuOapZMnxOtrPfKmziOTQ5bmA+h7wwmeypRAI5tmclA4ZuZxCvTBdM
	HPjkJhbRQqIUNPU9PNqj5Nk1BtQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vun5yhttt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PL5Dof031709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 13:05:12 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 25 Jan 2024 13:05:11 -0800
Subject: [PATCH v4 5/8] arm64: dts: qcom: sa8540p: Drop gfx.lvl as
 power-domain for gpucc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240125-sa8295p-gpu-v4-5-7011c2a63037@quicinc.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
In-Reply-To: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Johan Hovold
	<johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706216711; l=931;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=LmGmDzI8fc2erGli/opzJCTKeAu3YbTeUxNqQMXGvfo=;
 b=u9FlUDXd2mted5WERgripiyIdu+uZIZ3WCUu15t7ciCTpRhYBZUwbpujSMEt4io2RcPeN/uIT
 B4aiGhYCbStBQRCDdoUDeAMDg8b8uZ5q8pcKl2Jfbjpv35ORPuHIIZj
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1viBghwdJNG506hMMaP6-NWIFc1uuk7n
X-Proofpoint-ORIG-GUID: 1viBghwdJNG506hMMaP6-NWIFc1uuk7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=832 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250152

The SA8295P and SA8540P uses an external regulator (max20411), and
gfx.lvl is not provided by rpmh. Drop the power-domains property of the
gpucc node to reflect this.

Fixes: eec51ab2fd6f ("arm64: dts: qcom: sc8280xp: Add GPU related nodes")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8540p.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 96b2c59ad02b..23888029cc11 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -168,6 +168,9 @@ opp-2592000000 {
 };
 
 &gpucc {
+	/* SA8295P and SA8540P doesn't provide gfx.lvl */
+	/delete-property/ power-domains;
+
 	status = "disabled";
 };
 

-- 
2.25.1


