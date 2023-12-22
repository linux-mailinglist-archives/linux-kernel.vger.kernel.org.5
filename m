Return-Path: <linux-kernel+bounces-9415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6808881C534
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0991F2607F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F5B67F;
	Fri, 22 Dec 2023 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bY9Ujvu/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB724B667;
	Fri, 22 Dec 2023 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM4nqiE008465;
	Fri, 22 Dec 2023 06:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Ov057Jf
	M0nywquhd/RmS04QwX7i6Uok5/3b7ZY6jK9c=; b=bY9Ujvu/FlS/NbImqDxkKEv
	Ts3cdPa1ZHNfViNHQkMCWOJTqxVPECHuG5GHwJA2FlMZWfF8e3WIy009W7Z+Nw6X
	Uq5+VBueNehzi7nxeA4v8BzxR6ZpoPThFo4lZqBIZNjpTzilcxE63Fp0fOC5YXTr
	PYKrPkcHA2hV5aNP5/Kz6nlXHZ3Jj10ORyO/eKEXdWf+YDI9hbbkns9hs3b+jtL9
	HuM/NFwfQ1g/ZjJM3Q2eG9nEkcX+5YkIi3Eu5aAAcPuuT4zXl93+R7U/vsuHo8qg
	i1dzkfMckrNbbB2ANdRpuNUiHgSdrhJHxXWtwTNywGqpQ4ekxTE4dhCYaxekDVA=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4pq3a43r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 06:37:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM6b23q017313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 06:37:02 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 22:36:57 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, "Andy
 Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Conor
 Dooley" <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH v5 0/2] Refine USB interrupt vectors on Qualcomm platforms
Date: Fri, 22 Dec 2023 12:06:46 +0530
Message-ID: <20231222063648.11193-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
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
X-Proofpoint-GUID: FMBqYKSEAsFDAfaS8uw7V7lYPtRyTk3l
X-Proofpoint-ORIG-GUID: FMBqYKSEAsFDAfaS8uw7V7lYPtRyTk3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 mlxlogscore=880 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220045

Qualcomm targets define the following interrupts for usb wakeup:
{dp/dm}_hs_phy_irq, hs_phy_irq, pwr_event, ss_phy_irq.

But QUSB2 Phy based targets have another interrupt which gets triggered
in response to J/K states on dp/dm pads. Its functionality is replaced
by dp/dm interrupts on Femto/m31/eusb2 phy based targets for wakeup
purposes. Exceptions are some targets like SDM845/SDM670/SM6350 where
dp/dm irq's are used although they are qusb2 phy targets.

Currently in QUSB2 Phy based DT's, te qusb2_phy interrupt is named and
used as "hs_phy_irq" when in fact it is a different interrupt (used by
HW validation folks for debug purposes and not used on any downstream
target qusb/non-qusb).

On some non-QUSB2 targets (like sm8450/sm8550), the pwr_event IRQ was
named as hs_phy_irq and actual pwr_event_irq was skipped.

This series tries to address the discrepancies in the interrupt numbering
adding the missing interrupts and correcting the existing ones.

This series has been compared with downstream counter part and hw specifics
to ensure the numbering is right. Since there is not functionality change
the code has been only compile tested.

Changes in v5:
Fixed commit header on v4-1 bindings patch.
Provide lore link instead of patchwork link for v3.

Changes in v4:
Udpated commit text indicating why pwr_event interrupt was added as the first
one and fixed some typos present in v3.
While at it, rebase on top of latest linux-next fixing merge conflicts.

Changes in v3:
Separated out the DT changes and pushed only bindings and driver update.
Modified order of irq descriptions to match them with permutations defined.
Fixed nitpicks mentioned by reviewers in v2.

Changes in v2:
Removed additional compatibles added for different targets in v1.
Specified permuations of interrupts possible for QC targets and regrouped
interrupts for most of the DT's.

Link to v4:
https://lore.kernel.org/all/20231222062720.10128-1-quic_kriskura@quicinc.com/

Link to v3:
https://lore.kernel.org/all/20231211121124.4194-1-quic_kriskura@quicinc.com/

Link to v2:
https://lore.kernel.org/all/20231204100950.28712-1-quic_kriskura@quicinc.com/

Link to v1: (providing patchwork link since threading was broken in v1)
https://patchwork.kernel.org/project/linux-arm-msm/cover/20231122191259.3021-1-quic_kriskura@quicinc.com/

Krishna Kurapati (2):
  The high speed related interrupts present on QC targets are as
    follows:
  usb: dwc3: qcom: Rename hs_phy_irq to qusb2_phy_irq

 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 138 ++++++++----------
 drivers/usb/dwc3/dwc3-qcom.c                  |  22 +--
 2 files changed, 70 insertions(+), 90 deletions(-)

-- 
2.42.0


