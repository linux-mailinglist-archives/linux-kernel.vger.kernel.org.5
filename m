Return-Path: <linux-kernel+bounces-162674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260D38B5ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F6D283F44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471FF84D0B;
	Mon, 29 Apr 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZZaRH0Ch"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB882D69;
	Mon, 29 Apr 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407672; cv=none; b=qQMuXIx863A+gYvBzq5PGvc80foppmdJO4oVkF60+UTJfIu1EqckgMKTLC/y9eh+buMwVg4oCt5Ug/iq87M9RETpjvCVvXkSqFk6l+p1ot5lRUKRolhKJBRwDrbWJydw5+wyPlnKn9Va2GkJWnjVTj3BZwVIefFmu34Hb0Odi94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407672; c=relaxed/simple;
	bh=YpWz6dyPMsWgPKci9Mv3aLudoCRrteUIAN4b3Y5cerE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hXOETWvtn2IX+TeYGTzasBSxMy1Ao+P6VT7mMIBK1QkR1x7gwNoaPYKocaLVvw2QiTqraouwqCIjRtpgLSUXE2XG6KY93UiUp3BQ5KpznxKJClvIyrlaGiJZ3uJYszAlcf4bnJP2Ln95ebFW/oEsZhHwoPyy23DiatMFPQ3ZEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZZaRH0Ch; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T9k65N013509;
	Mon, 29 Apr 2024 16:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=tnNMZkU
	t8rEws8GJkMM2V4jzl2sD/mdNSlIZ2rZ92l8=; b=ZZaRH0ChN4HJ5y0k+nUEXZx
	yrLSxB0+sRBLhQGSG/9h2IGo2X54385bPywFSjfikNlyyYbjlMOlfZ2LATSDXllD
	RzJo+hr9gx0y0zdy0JnLCNanNOn8m63TN7xufLeEsp6sk1OPEvjKDFVZo/E3BLq2
	cXy7tPj1hurgpQhFmPrE5D7mwcLztIDEf++NUecRKq3RqHuynobQ7EGqt+sdp8E9
	cA0Ck18K/bWKdnN0vB6B1UkgamurqdzNJ4taGbltMpjjYw0rljrGUX9hAQRRloca
	Z+f6qMOIulFVqQJIbp5JGf4V+9qs8+DmI5kLQtfYA7hRFa5cDGojrjdTr+pSrTw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt85sa5t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:21:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TGL1w7024076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:21:01 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 09:20:57 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Johan Hovold
	<johan@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v16 0/2] Add DT support for Multiport controller on SC8280XP
Date: Mon, 29 Apr 2024 21:50:46 +0530
Message-ID: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: d8I84FR02c9eXrWdP3gI5bl2tsJa8khp
X-Proofpoint-ORIG-GUID: d8I84FR02c9eXrWdP3gI5bl2tsJa8khp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=613 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290105

Series [1] introduces binding and driver support for DWC3 Multiport
controllers. This series adds support for tertiary controller of SC8280
and enabled multiport controller for SA8295P-ADP platform.

Till v13 [2] the DT was pushed along with driver code. Separated the DT
changes from driver update and pushing it as this series. The first two
versions were marked as v1 and v2. Marked this as v16 to avoid missing
of change log till v13.

Changes in v16:
Marked it as v16 rather than v3 since till v13, there were DT changes
sent along with driver code but were separated and this version is
supposed to be v16.
Fixed interrupt triggers from EDGE_RISING to EDGE_BOTH.

Link to v15:
https://lore.kernel.org/all/20240213082724.1789096-1-quic_kriskura@quicinc.com/

Changes in v15:
SA8540 Ride related code changes have been dropped and will pushed later
due to unavailability of hardware with either Andrew or me for testing the
gpio hog changes suggested in v1.
Implemented vbus boost regulators as fixed regulators instead of modelling
their enable pins as pinctrl nodes.

Link to v14:
https://lore.kernel.org/all/20240206114745.1388491-1-quic_kriskura@quicinc.com/

[1]: https://lore.kernel.org/all/20240420044901.884098-1-quic_kriskura@quicinc.com/
[2]: https://lore.kernel.org/all/20231007154806.605-1-quic_kriskura@quicinc.com/#r

Krishna Kurapati (2):
  arm64: dts: qcom: sc8280xp: Add USB DWC3 Multiport controller
  arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB
    ports

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 83 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi   | 82 +++++++++++++++++++++++
 2 files changed, 165 insertions(+)

-- 
2.34.1


