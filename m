Return-Path: <linux-kernel+bounces-42178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DF83FD7D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7092816BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D8F446C4;
	Mon, 29 Jan 2024 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mIF+KXVF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9E3D3AC;
	Mon, 29 Jan 2024 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505119; cv=none; b=G3zKu1NgDXf/P1Fm19N+DEvA5qdS4BtyU4QbgjvfUeVzhAIffnjBytL1a4xrHburCTIDZ1z0t7VNraauLqoYIbHI0hLNNmUMVT+TVJWlHZFVD1d28ylh3G+FRilyWUS1dLennctQTpmO9wKmLcSZ/uh4yFXF+HQi61pfEUF1ph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505119; c=relaxed/simple;
	bh=/Xbx5iud/jNw2n247ZZHQLr3VIYzbgeqZXaBadjU2wM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZlQP9JQhyx7S2nzEVpy0eVzV/rGV7O/iys7m5oS32krU9b1tfm715Pz+tATMORqHA1oAbkOiCk9zKOAObsnSNIqAqQbm1Pwp9TqhVUgIFfueci0U68dkKJ4/gtW8WGOHUGO/IlTZ3FwWvDOHV5BHzIZCtS8EIAa2vZDrgFvIKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mIF+KXVF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4BRUg002358;
	Mon, 29 Jan 2024 05:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=dllY4O7
	uZ73K357nbzp17SDxldytUa04WbNlzeykXLw=; b=mIF+KXVF8GNMpBZHPWdfYVZ
	kjirV/gR6jSvkMlRYPUlVin0hZU7vP6VsKg/PB4TQBdRneOMJ0AGnxKrF/yBbsTY
	3cWfKx7raeHerjzB4gQG39rqLRTL+cVoPp3JbMTDGQ4yb8rzelgbwgYpI6PD1p/o
	7qzId+3SW5oeMQzYkjbPbXD2Hm8UzNjwgNS8ZA090apYfMcvY6VZSWNLtsvPHnsN
	VhMiKxhN1VTETApTD3W88UDufScYv1HnnRSeJYWi+4TXy8baqFjcQEMeoSeHX/bw
	6QfVjnziwFoBa9W3QQyan/Sl8AeBOh8jQ6kcifqyGSSFddGRfCm/uwpCzou7nhQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvu4ctrdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:11:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T5BPVI023202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:11:25 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:11:18 -0800
From: Devi Priya <quic_devipriy@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <p.zabel@pengutronix.de>,
        <richardcochran@gmail.com>, <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V3 0/7] Add NSS clock controller support for IPQ9574
Date: Mon, 29 Jan 2024 10:40:57 +0530
Message-ID: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: iERiaerN-W2X_6N-QiAi-qUOlGUuE5zd
X-Proofpoint-ORIG-GUID: iERiaerN-W2X_6N-QiAi-qUOlGUuE5zd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=922 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290033

Add bindings, driver and devicetree node for networking sub system clock 
controller on IPQ9574. Also add support for NSS Huayra type alpha PLL and
add support for gpll0_out_aux clock which serves as the parent for 
some nss clocks.

Some of the nssnoc clocks present in GCC driver is
enabled by default and its RCG is configured by bootloaders, so enable
those clocks in driver probe.

The NSS clock controller driver depends on the below patchset which adds
support for multiple configurations for same frequency.
https://lore.kernel.org/linux-arm-msm/20231220221724.3822-1-ansuelsmth@gmail.com/

Changes in V3:
	- Detailed change logs are added to the respective patches.

V2 can be found at:
https://lore.kernel.org/linux-arm-msm/20230825091234.32713-1-quic_devipriy@quicinc.com/

Devi Priya (7):
  clk: qcom: clk-alpha-pll: Add NSS HUAYRA ALPHA PLL support for ipq9574
  dt-bindings: clock: gcc-ipq9574: Add definition for GPLL0_OUT_AUX
  clk: qcom: gcc-ipq9574: Add gpll0_out_aux clock & enable few nssnoc
    clocks
  dt-bindings: clock: Add ipq9574 NSSCC clock and reset definitions
  clk: qcom: Add NSS clock Controller driver for IPQ9574
  arm64: dts: qcom: ipq9574: Add support for nsscc node
  arm64: defconfig: Build NSS Clock Controller driver for IPQ9574

 .../bindings/clock/qcom,ipq9574-nsscc.yaml    |   69 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |   39 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/qcom/Kconfig                      |    7 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-alpha-pll.c              |   10 +
 drivers/clk/qcom/clk-alpha-pll.h              |    1 +
 drivers/clk/qcom/gcc-ipq9574.c                |   83 +-
 drivers/clk/qcom/nsscc-ipq9574.c              | 3068 +++++++++++++++++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |    1 +
 .../dt-bindings/clock/qcom,ipq9574-nsscc.h    |  152 +
 .../dt-bindings/reset/qcom,ipq9574-nsscc.h    |  134 +
 12 files changed, 3511 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
 create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c
 create mode 100644 include/dt-bindings/clock/qcom,ipq9574-nsscc.h
 create mode 100644 include/dt-bindings/reset/qcom,ipq9574-nsscc.h


base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
-- 
2.34.1


