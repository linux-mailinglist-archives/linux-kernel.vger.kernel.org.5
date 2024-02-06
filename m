Return-Path: <linux-kernel+bounces-54835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776EF84B43E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD781C23495
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B8135403;
	Tue,  6 Feb 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dHBWgFQs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14011350DD;
	Tue,  6 Feb 2024 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220103; cv=none; b=Wk8y7fvBxpb/pD5RbzBuA9/amtdf92ch9DZk5NgWMdahb/8qcEzxT27uC2XpdrbdU6T90vkeoQ4Me2Nu4/Z8dGD93EKsFfl36HYQcrjVu+MiT1DM5TxBS8vwq9UKxCZ6MKkQjYvQfWjUyKkCFK+ZaHBq5pinwIs/kUMEldhcSbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220103; c=relaxed/simple;
	bh=mo1peyyhYxwfTesx8Zr64R9MnjTL6PGDJ7Iqv8jM3CU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsxSjZuq7r+cUCmNTUM6F/Pn+RaM43qGJUvw6jGOE+Fig5Cksuxn6dBy7q8bpT4IikRmCLGwrlVp5Wyo6ymEp6I72mYdDaGARWOcJbpuiQCvT1WXkYnlZ3LWphKfmfj3clhYCp9MANFlpQjdv3VTvdMpKQ9GyBEyONu6NPsTHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dHBWgFQs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4169ikWC011210;
	Tue, 6 Feb 2024 11:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Cwas9GDCQhLs6GetbOYqxVtVesjr2/z+ggxAwZyD9BM=; b=dH
	BWgFQszbhvs46yHrdZ7pkTv7WGtFgTKW30yaiE9PJCx9m+piajTQY5bC0omxwSbE
	730n8xMYcEdLgvUis6EU/crJdI1mYryTA1T5oufVKVDmir/yOqHmZ27orkwHrWhH
	qMngpzWQ0qZynNOB4qaxXZ/Mm4Zx9Of6qFOkhdJnz/ZSD7wHOlypcVCvbNkTqC5D
	j7lRkNsFk5THE+OCUffgpPp2WNbpLZc5QkK/rA/xhn0jGdbCDiYsuZwSDTnoc7WG
	/cnUD+bt2PBVBy7IHQmEdp57bBj7DuK3wtoa+ASpYFjD57IThDWjJ53hXS45juRf
	GA0TIGn+1TbYddFX4JwQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3e7g0sau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 11:48:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416BmEOC022471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 11:48:14 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 03:48:10 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>,
        "Krishna
 Kurapati" <quic_kriskura@quicinc.com>
Subject: [PATCH 3/3] arm64: dts: qcom: sa8540-ride: Enable first port of tertiary usb controller
Date: Tue, 6 Feb 2024 17:17:45 +0530
Message-ID: <20240206114745.1388491-4-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8s9CMTG--YGThm0e0lDKyxhvJLYFXkKj
X-Proofpoint-ORIG-GUID: 8s9CMTG--YGThm0e0lDKyxhvJLYFXkKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=747 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060083

From: Andrew Halaney <ahalaney@redhat.com>

There is now support for the multiport USB controller this uses so
enable it.

The board only has a single port hooked up (despite it being wired up to
the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
which by default on boot is selected to mux properly. Grab the gpio
controlling that and ensure it stays in the right position so USB 2.0
continues to be routed from the external port to the SoC.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Co-developed-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index b04f72ec097c..eed1ddc29bc1 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -503,6 +503,18 @@ &usb_2_qmpphy0 {
 	status = "okay";
 };
 
+&usb_2 {
+	pinctrl-0 = <&usb2_en>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	phy-names = "usb2-port0", "usb3-port0";
+	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
@@ -655,4 +667,13 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	usb2_en: usb2-en-state {
+		/* TS3USB221A USB2.0 mux select */
+		pins = "gpio24";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
 };
-- 
2.34.1


