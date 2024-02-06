Return-Path: <linux-kernel+bounces-54833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7184B438
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F231C2194C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF11350CB;
	Tue,  6 Feb 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IfxY8m9A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17B1350C2;
	Tue,  6 Feb 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220092; cv=none; b=psE6az7CD3RSK0GXgbYWopyG0RVywiMsQ+gpxvurguFbiAf3oa3bQOGYrJZLh9bgTPIQbVNAOUysaEKStzb9N9i8xylGZNZIpax+LwcSu0rqP4R+GMMsTJN0JEmBDvHiDAsM+NqaKXaTwFtOo9f2vbpdhGjEewZxBtmchITvaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220092; c=relaxed/simple;
	bh=xAYKHqlHEthQAN+4S4NMMj+DMvc0iEget2l+WujxX2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfe8cLD8wLhdIF2oLGr4s1LFePR+SqCKtLb2XyoVnKCX2ykQ6uexJyNSgApcpGduOv6/CH4sln9CUmMNhf02iVGa6HYg0WRSwLNcR8E48XeVs+HVdOfQ6dTVCK+JTl51p7QCwoGrdgUNHincZNcN+JMscABQypHcHRi2mXuxGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IfxY8m9A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41680FhJ012641;
	Tue, 6 Feb 2024 11:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Q1uvwE06BQI1HQ/N/wQtkdLnTP7ndnAwOmAar30LvIY=; b=If
	xY8m9AqIzjjTD2JUqEDIYKlzXdlItBU83ZJ/kXQnvIrhdpEmgcFAsP3gVind195R
	grW64moPenso0cSZhcBUpbzGIfisUyoTsFyVNvbWqr8rw4DOJgUZhU8005akhcFL
	hGfiG5sEbRYEIBmGqsVYdaDg8/qU+rjsGwqyiic7lXBE2QF+c7vzozzzX6vw3jim
	xNoDkJmvV/MUWkHd+XHN1KwGkBsqpPk323nlbDgcYhMQ+RileXLMi4toWw43m44F
	yTBfoo/KCBN986zPnNv5UB+m4tvNRrmy6uwBrcinCgQY/t3912aytQUIeGJjrB6U
	em8NARbQPy2rvxeOnZpQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3a1bs7u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 11:48:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416Bm5Ux022362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 11:48:05 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 03:48:01 -0800
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
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 1/3] arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
Date: Tue, 6 Feb 2024 17:17:43 +0530
Message-ID: <20240206114745.1388491-2-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: BTowN4mj4dYaI5d79jPQyLznzV8_X3a_
X-Proofpoint-ORIG-GUID: BTowN4mj4dYaI5d79jPQyLznzV8_X3a_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=930 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060083

Add USB and DWC3 node for tertiary port of SC8280 along with multiport
IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
platforms.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..29dbf2a9cdba 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3331,6 +3331,88 @@ system-cache-controller@9200000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		usb_2: usb@a4f8800 {
+			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
+			reg = <0 0x0a4f8800 0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
+				 <&gcc GCC_USB30_MP_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
+				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi",
+				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";
+
+			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MP_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 859 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 127 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 129 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 128 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 131 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 130 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 133 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 132 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "pwr_event_1", "pwr_event_2",
+					  "pwr_event_3", "pwr_event_4",
+					  "hs_phy_1",	 "hs_phy_2",
+					  "hs_phy_3",	 "hs_phy_4",
+					  "dp_hs_phy_1", "dm_hs_phy_1",
+					  "dp_hs_phy_2", "dm_hs_phy_2",
+					  "dp_hs_phy_3", "dm_hs_phy_3",
+					  "dp_hs_phy_4", "dm_hs_phy_4",
+					  "ss_phy_1",	 "ss_phy_2";
+
+			power-domains = <&gcc USB30_MP_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_MP_BCR>;
+
+			interconnects = <&aggre1_noc MASTER_USB3_MP 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_MP 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			wakeup-source;
+
+			status = "disabled";
+
+			usb_2_dwc3: usb@a400000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a400000 0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x800 0x0>;
+				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
+				       <&usb_2_hsphy1>, <&usb_2_qmpphy1>,
+				       <&usb_2_hsphy2>,
+				       <&usb_2_hsphy3>;
+				phy-names = "usb2-0", "usb3-0",
+					    "usb2-1", "usb3-1",
+					    "usb2-2",
+					    "usb2-3";
+				dr_mode = "host";
+			};
+		};
+
 		usb_0: usb@a6f8800 {
 			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
-- 
2.34.1


