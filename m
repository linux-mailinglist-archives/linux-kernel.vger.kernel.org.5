Return-Path: <linux-kernel+bounces-47560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8370844F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C541C2357B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349213BB21;
	Thu,  1 Feb 2024 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WprsB0x3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90E39FEE;
	Thu,  1 Feb 2024 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756870; cv=none; b=LXAIDUgXYWzCx/PbOyDYVESq+X1o51l0IjXONgN2KzqGOHeb534AcfTv0EavLN2oBkaYac9SvaFSPfUaL+0V58SFUDjD+ens3wooCiZyVg9K/hZO3LDuVPma1Sg3l8sqq0sp8QUgO2Igef6uSIU9qVs8Sw0Rn7kORM1+HoiBSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756870; c=relaxed/simple;
	bh=MoRw1dvp9q20rL17HKDLbT7sCyR/jdb0fyHfS34winc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jXR+7rDlNdS8MBit0WkL9NvdSFjR+VmVkUcWyjB3+Te2dgU8qV5s1OtHzy/Jy3CdXjb05oexIqKk7zrRw2n088t9AV8+8uO1KwUv01EV584OWkNNwktJxIa3+vk4YYw1UJtU/72bu+4wZ1rwG6HwZsULIt0HOmU38EWxVLgcW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WprsB0x3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4111Kfok027995;
	Thu, 1 Feb 2024 03:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=sX4VxdfIsnL+tdWp3LoayzvgcW94nG+ngD23WBFimt8
	=; b=WprsB0x37ZQEi9jQG/N7FpZ02NBGjyjQQIUH53Bsyi1rvAB6ynQhyqHWYVZ
	Gtu3ySq6TArmw9bVSZuQyFCc6jrjfLcUdTF15w49sAZNOrxhXsJtq6JNtw0uXNrU
	hoIO3JgpFn0aWtYVo8dWbXVrXFe0UQp3wIBu6V2HCbSoI1CD2r8uFSx+s5kKQ/AN
	UBrnPsPQ2e87/g0VoFrhR/4Nm8R1cMWg+8bxAkQYViF2aBO2dK8CubM3wqigpFMF
	zDzHmv5ywcbBKPa+/QYWcG0iDzT7Lhifw2Yl/4j7oJ3VVT6At6uSMS64VVzFaLsb
	foGTwG03pKNRG7smME4PXFq9vjg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyuath3eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 03:07:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41137bCV011510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 03:07:37 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 19:07:37 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 31 Jan 2024 19:07:27 -0800
Subject: [PATCH v4 2/3] HID: i2c-hid-of: Remove comment about post-reset in
 DT binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240131-x13s-touchscreen-v4-2-39c0f9925d3c@quicinc.com>
References: <20240131-x13s-touchscreen-v4-0-39c0f9925d3c@quicinc.com>
In-Reply-To: <20240131-x13s-touchscreen-v4-0-39c0f9925d3c@quicinc.com>
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
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706756856; l=993;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=MoRw1dvp9q20rL17HKDLbT7sCyR/jdb0fyHfS34winc=;
 b=/M9zBZB3SmoH/QAn+2wPj6uQR5PeB3Q5Yw1tI9jdKtom1ZGSZqRp6P3XebJRV3XlM1MwH7Lsa
 o9ycylbI9QYAZI+YvigI5vM4FwuHerwZyRaajqvZovyM61teLXXDTeM
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LdVVLgMPnV7vixFBSCnh1nZF-T9BK7ZE
X-Proofpoint-GUID: LdVVLgMPnV7vixFBSCnh1nZF-T9BK7ZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=950 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010023

With the "post-reset-deassert-delay-ms" property added to the DeviceTree
binding, the comment is no longer valid, remove it.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index c4e1fa0273c8..bbc2afb86eb6 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -104,11 +104,6 @@ static int i2c_hid_of_probe(struct i2c_client *client)
 	if (!device_property_read_u32(dev, "post-power-on-delay-ms", &val))
 		ihid_of->post_power_delay_ms = val;
 
-	/*
-	 * Note this is a kernel internal device-property set by x86 platform code,
-	 * this MUST not be used in devicetree files without first adding it to
-	 * the DT bindings.
-	 */
 	if (!device_property_read_u32(dev, "post-reset-deassert-delay-ms", &val))
 		ihid_of->post_reset_delay_ms = val;
 

-- 
2.25.1


