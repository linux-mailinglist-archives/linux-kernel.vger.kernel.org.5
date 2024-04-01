Return-Path: <linux-kernel+bounces-126626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98E3893A90
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D413B21338
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0682C210F8;
	Mon,  1 Apr 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VNJqI4gL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8523BF;
	Mon,  1 Apr 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711970092; cv=none; b=R7bMXP1b6qBdnBhPs5HOFrJQc3NbcTljMqpx5qE+2UW2jC3hTga1E85qpb2C1/woJ9B1VFTY1fcfZzWk0ogpgoTGimPwXBjuJfvMREEI49x5YnRqCIt3/o9PDpZ1JwRrOR/xOhwcdBYadKRO++1jJI2eaWmS1uubR6+J5ZmJkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711970092; c=relaxed/simple;
	bh=uPpz1+YPk6pEFNyVGUm8Ju6ugEHPYyKo8BgAJkpwAgw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=OD+4BYn3FSKw54ygXKFyCokjh3gKZrQl7Sf6vUzKhPTUeEXl/fyi1sFkKoWB9kAxVvPtft1igpYvekqO3gJnYs/VCrLRMsQXwIhOBWfkX2mUtdKCHD76f3oZB/xgX8wOvH3RPuHwaOgFPXOLuOfqgr6HWuM44fmMhX9GmkMcM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VNJqI4gL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431BD6Z9008379;
	Mon, 1 Apr 2024 11:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=8Q1y9RxixJZneN
	wyQJKf0rVZLRpRtKub62NwKg9kzY4=; b=VNJqI4gLYfqYCs4htaot7Kkog8tyP8
	T+xq7SnzVzr2CbICE8aoJQ7+TkNiWrFOdHWMDZ1igUbJKSAzAxQ0sP1QQ6ESX9EA
	v+eyYQ6r8KmMB8kcXGit+MWwl4sS0WmBGSRxBfhTSV5dA4oDxnrrvgMhQbsqx5rv
	hVrO/YgihtUV/Tj0M0+Q9AyxnClXNPgwZN4IpMr7J7waZs9oBCSDWc/j3l9ujLHO
	T81qCgz+9yiPI3KpdT6N81K5MlYekeFZWwfAyNgU8/ZNnZ2tUM4cCf0dgJquFUpF
	76COGPy3xVWmyCUCvS+ML4w0nSxIZ/d84iMd1mjuVTwM6myqQ13LJzlA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7ub382j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 11:14:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431BEj31010692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 11:14:45 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Apr 2024 04:14:40 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH v2 0/2] Add DT support for video clock controller on SM8150
Date: Mon, 1 Apr 2024 16:44:22 +0530
Message-ID: <20240401-videocc-sm8150-dt-node-v2-0-3b87cd2add96@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6XCmYC/3WNyw6CMBBFf4V07Zg+EKsr/8OwwOkgs6DFFhsN4
 d+txK3Lc5J77iISRaYkztUiImVOHHwBvasEDp2/E7ArLLTUtTTSQmZHARHSaNVBgpvBB0fQ9Ko
 xt/qk+yOKMp4i9fzawte28MBpDvG9/WT1tb+kMv+SWYGEjiyhQas16svjycge9xhG0a7r+gFrD
 g+NvgAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Taniya
 Das" <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rzrwSoIdyXWypGfPYeCbuG39IukRXgLp
X-Proofpoint-ORIG-GUID: rzrwSoIdyXWypGfPYeCbuG39IukRXgLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_08,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=787 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010080

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Changes in v2:
- As per Dmitry's comments, there is no need to update to index based
  lookup for already existing drivers, hence keeping clock-names property.
- Updated the videocc bindings to add AHB clock for the sm8150 platform.
- Link to v1: https://lore.kernel.org/r/20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com

---
Satya Priya Kakitapalli (2):
      dt-bindings: clock: qcom: Update SM8150 videocc bindings
      arm64: dts: qcom: sm8150: Add video clock controller node

 .../devicetree/bindings/clock/qcom,videocc.yaml         | 17 ++++++++++++++++-
 arch/arm64/boot/dts/qcom/sa8155p.dtsi                   |  4 ++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi                    | 13 +++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)
---
base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
change-id: 20240308-videocc-sm8150-dt-node-6f163b492f7c

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


