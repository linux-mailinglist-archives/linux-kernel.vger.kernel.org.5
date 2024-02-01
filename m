Return-Path: <linux-kernel+bounces-47557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC6844F61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988C1292E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B4E3A1A8;
	Thu,  1 Feb 2024 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QxdbsFnY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94539FFF;
	Thu,  1 Feb 2024 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756869; cv=none; b=gV/N9W9dKwhl4qE/iYg25hF/mozd0am24jycrSEK3zVpFujDTZS9WX3ZuqDRSu3ou7V3xpEHgevKOGQ6q9lNc8GgJdxVoZJ8fRdmW0wc3D4Wfrx6ilttjze62z32Y6JJJTkrXKB7urB63yA0GtyYFajSVWDDzQZC05+krCdveAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756869; c=relaxed/simple;
	bh=KTULhIMFFnxhtlNK2d7CqhHMEe0edZVqfB4S1Oawrns=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Va8u4SD0nw8heFYPqJlv9g4W0PXb1A22PkZrbco9vsf7LX3PNSIo3ept6dJre9QVz03a9uEg4iGsnz+PN1QrhDJkanJyR1Gn7LBvKSsWW7fjqnfG3lVLbvsrmOeo1xrqYJkgmr4gephCypz/ppyLZzV9OoliuN+Kg+gHbxDI4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QxdbsFnY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4111cvwk023887;
	Thu, 1 Feb 2024 03:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=2K80p9Ro1kzJR3
	1H55txCImJwMy/lTnQpim7GWGUU7M=; b=QxdbsFnYBxXH6luq7C/95hWf37EIr2
	fAslw6/3KOSunDjWnlUG+BXhcJQwgr/M7bSOSSlS5ZQlij1Sg35d/fhWG3T+3Ay/
	EbTa6uZ/EBABOK0TcKyjwLVtlcQzXzNNvpfaXpjTADkuNzqFOag8NgG/BHzWZacO
	BPXsoB18ILAz7Rly2hZPNk2W4gPlxz0jeSvTEtfwwL/qYu2oS2VgjRyNK+nFVsXH
	iDoDK6Z7KONNfTBTLLdsunE+/FbMF6ko/W+d618rkcq1+TTWXdM7A230Jkb7t+6U
	qqxJG/cZFj+ImbRTsrXWC9IdzXwe0QVGhIjOpL24Pp1YDntCHL+sIaEQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyq0dsv9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 03:07:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41137bxF021092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 03:07:37 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 19:07:36 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v4 0/3] arm64: dts: qcom: sc8280xp-x13s: Enable touchscreen
Date: Wed, 31 Jan 2024 19:07:25 -0800
Message-ID: <20240131-x13s-touchscreen-v4-0-39c0f9925d3c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0Ku2UC/33NTQ6CMBCG4auQrq3pH1pceQ/jAoepdGGrLTQYw
 t0trDASl++XzDMjiRgsRnIqRhIw2Wi9y6F2BYG2dnektslNBBOKcVHSgctIO99DGyEgOqp03o2
 RIBSSfPYMaOywkJdr7tbGzof38iHxef2DJU4ZrW8atBYNmgrOr96CdbAH/yAzl8SaOGwQIhOlP
 CoAqJCz5peQa6LaIGQmQNWVlEwqrspvYpqmD7c9f0s4AQAA
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
        Rob Herring <robh@kernel.org>,
        Daniel Thompson
	<daniel.thompson@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706756856; l=1510;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=KTULhIMFFnxhtlNK2d7CqhHMEe0edZVqfB4S1Oawrns=;
 b=Q/w7+dVOLB1MZw1u1Z0xh8MEEY88SiMhHVsiOZ3XiwKHL1/hKIS1o4KJaZ4+vI2uR/t3aH/Os
 OgSpP99AVNlBtMbsZQ83emamzWBmi4RMBbEBcMp6XSxGKc2frEixY4L
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ScSEMI9-SANWbESWSv6WcfKX9sUGIDRU
X-Proofpoint-ORIG-GUID: ScSEMI9-SANWbESWSv6WcfKX9sUGIDRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 mlxlogscore=793
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2402010023

This documents and defines the necessary properties for the I2C
HID-based touchscreen found in some SKUs of the Lenovo Thinkpad X13s to
work.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v4:
- Introduced the patch in the HID driver removing the comment about the
need to update the binding.
- Link to v3: https://lore.kernel.org/r/20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com

Changes in v3:
- Rewrote the commit message, to properly describe the problem being
  resolved.
- Link to v2: https://lore.kernel.org/r/20240126-x13s-touchscreen-v2-0-5374ccc9e10d@quicinc.com

Changes in v2:
- Dropped output-high from &ts0_default, to avoid bouncing the reset
  line unnecessarily
- Link to v1: https://lore.kernel.org/r/20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com

---
Bjorn Andersson (3):
      dt-bindings: HID: i2c-hid: Document reset-related properties
      HID: i2c-hid-of: Remove comment about post-reset in DT binding
      arm64: dts: qcom: sc8280xp-x13s: Fix/enable touchscreen

 Documentation/devicetree/bindings/input/hid-over-i2c.yaml  | 6 ++++++
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 7 +++++--
 drivers/hid/i2c-hid/i2c-hid-of.c                           | 5 -----
 3 files changed, 11 insertions(+), 7 deletions(-)
---
base-commit: 8bf1262c53f50fa91fe15d01e5ef5629db55313c
change-id: 20240125-x13s-touchscreen-48012ff3c24e

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


