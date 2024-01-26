Return-Path: <linux-kernel+bounces-40361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E783DF01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF4FB26B88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D01EA76;
	Fri, 26 Jan 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CVhH7N5o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA31DFDF;
	Fri, 26 Jan 2024 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287313; cv=none; b=oUfiY5DiWXOD9iepjIY9gVOLJgJKozpoKbULm5MTFvTmWPKgx04QRh5oPqFzpLpr8T+vmN8l/9O7uKUCNMAwoUVex81RDNgn6zdduXN09izusl9U4FvOH+OYznVgPN0gE2eI24WPjwSVDEh6hldtSQXt5oLQSpCBV9Le9iCI8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287313; c=relaxed/simple;
	bh=Q5ll4q5lvJAymtLsVpDyifwPNXDgZaxPEqeqRNTEN34=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=juxT+fS/KexsRjCjcqc04KraHmZqJM6rc4yvfgtczfHqz3SJLOAPvslLrTQE2evo2ULYzw8hkYsnE1urSpVknYzXNJl/49uze7nNltwp/4M18uL0r8uaPkuoNJ4QebO9LbO0rMPp521HioCuCRD0mQyBjyX8uJQeHBcMjFNBBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CVhH7N5o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QEMTMj004042;
	Fri, 26 Jan 2024 16:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=Jmj86YkFm2SONk
	KQOP1OZXnKDTuXwbf/MJ2CuPb3vJo=; b=CVhH7N5ov9ZYkinDHeSGrF3QBCnAEi
	AEOYOGzbNcgYyxO6LLmtky2ekEXRdnI1AAt47n+I3N70KXTduIZlDoBG/7WTrF1b
	51lKeul2FaFOPvvqB4+G97lhmXt0o3J24Tc0gusqX6UsPFh4Iule0wZfDUo6z/Fc
	YU/0xdh4wTYqwytFsZm6hIthy8wtk5VXG49e8c/z7UtdstQabb7xoz+9uWRiUSLi
	3IttUlHQpzy4z6V0HNJGPd8hTWcWoZUbpa/uh6GfSWhmtP3/wlKCIDS5n2QAQZiC
	qbTwgkpCmNjPw0Oj5SooGU5EFuYJFe0r+sEyGez3ZMNvOGDRrBN5pZkA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv51dhjug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:41:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QGfeOK032141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:41:41 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 08:41:40 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v2 0/2] arm64: dts: qcom: sc8280xp-x13s: Enable touchscreen
Date: Fri, 26 Jan 2024 08:41:37 -0800
Message-ID: <20240126-x13s-touchscreen-v2-0-5374ccc9e10d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMHgs2UC/32NQQ7CIBBFr9LMWgxQTNCV9zBd1OkgsxAUWlLTc
 HexB3D5XvLf3yBTYspw6TZIVDhzDA30oQP0Y3iQ4KkxaKmNVPokVtVnMccFfcZEFISxzTvXozY
 EbfZK5Hjdk7ehsec8x/TZH4r62T+xooQU492itXoid8bre2HkgEeMTxhqrV8IzhAhsgAAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina
	<jikos@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706287300; l=954;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=Q5ll4q5lvJAymtLsVpDyifwPNXDgZaxPEqeqRNTEN34=;
 b=4RyspDI3dYsYG8KgHSCOERzD9k7Ut5v3qEKzoqu7ttTcAKwDPMBYMQYmsnkIIreFt/Lrgu8yK
 Xy6t8wQqnY9A4TXB5Tp6rC+FZqrdAoA8iJtWREpdiC5t+QiScBLq7kF
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ndv6sRr__38ZcxrsxfRsQU08npXlpI7O
X-Proofpoint-GUID: ndv6sRr__38ZcxrsxfRsQU08npXlpI7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=750 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401260122

This documents and defines the necessary properties for the I2C
HID-based touchscreen found in some SKUs of the Lenovo Thinkpad X13s to
work.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v2:
- Dropped output-high from &ts0_default, to avoid bouncing the reset
  line unnecessarily
- Link to v1: https://lore.kernel.org/r/20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com

---
Bjorn Andersson (2):
      dt-bindings: HID: i2c-hid: Document reset-related properties
      arm64: dts: qcom: sc8280xp-x13s: Fix/enable touchscreen

 Documentation/devicetree/bindings/input/hid-over-i2c.yaml  | 6 ++++++
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)
---
base-commit: 8bf1262c53f50fa91fe15d01e5ef5629db55313c
change-id: 20240125-x13s-touchscreen-48012ff3c24e

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


