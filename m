Return-Path: <linux-kernel+bounces-42673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7838404B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF9B1C22703
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F4D60DD6;
	Mon, 29 Jan 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZND2vu2O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD260DC1;
	Mon, 29 Jan 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530357; cv=none; b=UFtvKUYjdWZme4PcxjrOAtm8sQ7QbFddX410WJDZ3nPGYnjnI97K+C4sfp7sdHUKBZ/Nv3XBDEa6rEH/jDPXiqxf5bqs2eTil881Xg0ainpwRY6ASvUxo+FNL8c1GPGcwEiGgledn9Zr31VlzqKJoh1EbEv0XvlTMU92PZ4fnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530357; c=relaxed/simple;
	bh=D3zG+4hD2sT228dFOqw1L83HsPwyb5IykHEPgivCucM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRXkHam81u9Atr2fXp2pca3TpB7zfx15DB+8t89cW1ZWE90Y6eJ2iXSYeSYlZWGsLQa/C+5h//SfbRZRQVVjcoJ/J5N2dZgWws/TBva7gQ8aUJ0WFQ6RQiTx3DbD5P1X8h31okAkg0e4/+MBoEDlggK8Wrd05+fN4oxrdThKVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZND2vu2O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T6gMYk025007;
	Mon, 29 Jan 2024 12:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=AbNKmiJ
	NTRVU/tBq36ysiUQ3MmyL1LwSWkWkl4M+C5o=; b=ZND2vu2O356PMYlc+tXmtpp
	KGEbBS/d6FcV8TfX9JBC0tsMm+k+F+IaJpr3xybha2hi4sd+DBJaECzxzpgeLkP7
	LX+UWD3waxyZ6+Lb8o1agVkPLrVvxPmeGTVA4FxcGlQgbpwPuSVfBHqyQPB3u43J
	1Ho2FB2kK/Aln4o6CMGipjceYAKhJamn/hGyr3Efp+4nLFZahDJuYrHuarr+Q1Dp
	iR/JUAIoITt/NHAZNC/nlIpb+iYzaIqaZeWgAkbTf3gIWbYXzJQhkChBUSadW210
	StKT+uuQfNdpQkxf06mQMUw1/KfI3CTfp6uyEok4/iO41kAYEMAxvuzgn8DyevQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvtkmbhe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 12:12:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TCBqld009691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 12:11:52 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 04:11:42 -0800
From: Suraj Jaiswal <quic_jsuraj@quicinc.com>
To: <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma
	<bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose
 Abreu" <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi
	<psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, Rob Herring
	<robh@kernel.org>
CC: <kernel@quicinc.com>
Subject: [PATCH net-next v10 0/3] Ethernet common fault IRQ support
Date: Mon, 29 Jan 2024 17:41:26 +0530
Message-ID: <20240129121129.3581530-1-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1dKb6_-dB6eYWhcQI7GIMSoKkc3kkSJD
X-Proofpoint-GUID: 1dKb6_-dB6eYWhcQI7GIMSoKkc3kkSJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_07,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=878 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290089

From: Suraj Jaiswal <jsuraj@qti.qualcomm.com>

Add support to listen Ethernet HW common safery IRQ for correctable and 
uncorrectable fault. The safety IRQ will be triggered for ECC(error
correction code), DPP(data path parity, FSM(finite state machine) error.

Changes since v10:
- Update commit message

Changes since v9:
- prevent race condition of safety IRQ handling

Changes since v8:
- Use shared IRQ for sfty
- update error message

Changes since v7:
- Add support of common sfty irq on stmmac_request_irq_multi_msi.
- Remove uncecessary blank line.

Changes since v6:
- use name sfty_irq instead of safety_common_irq.

Changes since v5:
- Add description of ECC, DPP, FSM

Changes since v4:
- Fix DT_CHECKER warning
- use name safety for the IRQ.

Suraj Jaiswal (3):
  dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for
    sa8775p
  arm64: dts: qcom: sa8775p: enable safety IRQ
  net: stmmac: Add driver support for common safety IRQ

 .../devicetree/bindings/net/qcom,ethqos.yaml  |  9 ++--
 .../devicetree/bindings/net/snps,dwmac.yaml   |  6 ++-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 10 +++--
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 41 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 ++++
 7 files changed, 67 insertions(+), 11 deletions(-)

-- 
2.25.1


