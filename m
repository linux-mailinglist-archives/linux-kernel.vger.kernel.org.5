Return-Path: <linux-kernel+bounces-52531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6DB849957
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1521F21326
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E71A587;
	Mon,  5 Feb 2024 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C9+r26/d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2B1B7EA;
	Mon,  5 Feb 2024 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134296; cv=none; b=HqNAYD6Ys3pAE+Cgb2e2boQvu3hkNrDM5Dc7lpNhX2inDzBx0h33BtiFoX8KGHx7qyh/fWXX83E+yMP7SPTHMDr+qsGdDaHiOcQQV5nTnifAm/Gx+bSl7aRQ3Qagt7mORoSTnP5ExzIueDpmfRd/2Z4hYxsFvMR4rcv5jyTNbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134296; c=relaxed/simple;
	bh=RYHnkHzjQTO1csC37QGC5LASS/49QmvTHhynWg7zK+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvx0YT//jwchMUqA9lLFYk1oD53ToHZOL7j/UluFOwCwIAsUJf31mnyq/SEK5Z9sI30yBrBwE3PbHyHQdPgxE+V/bB9ymX9h4KBnGQsMdIiQjIAVwNACqnYmn7R3UJCJpmTr24qMlBf7LC6pYrunQQXVII+vM4g1BN83Zd3qR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C9+r26/d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415Bng2R009513;
	Mon, 5 Feb 2024 11:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=+FLjOha
	9hsz0N3kTVXjRHky3yB34sbwW32/QLwTYprw=; b=C9+r26/dK0WzIXaQaQ82lO9
	ff/omTQjeEz2tHhxj8Ee8GMWuN16q6rsAYeQQkhnqPpQ+csk28MH7rykyfplrXYA
	/mDfvYwFWUIol1+at6oOHJ9q8MzGrZ9jP8Ykauajg17161r1TrkB7axbZcRvLVHl
	0vLrI1/YKionBAaD119IMsKbdCZPgX8RCw5F2Y+0sSD01g8dwf58XCfEmuDvj0zU
	c4OZlXqf7FyUM8AwD7f6VSpxLKNj/g1XZ5gOMyXM5e8jXkSb4EWamcyUI5ba0OxK
	g1zj+wn3qrz2JLaAFfyHeWcnSONoPuuYo97h0HjaFrelp92/HN+5WIrFM75Hd8Q=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rk70r23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 11:58:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415BwAKj004961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 11:58:10 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 03:58:05 -0800
From: Jingyi Wang <quic_jingyw@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_jingyw@quicinc.com>, <kernel@quicinc.com>
Subject: [RFC PATCH 0/6] arm64: dts: qcom: Introduce AIM500 platform device tree
Date: Mon, 5 Feb 2024 19:57:15 +0800
Message-ID: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
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
X-Proofpoint-GUID: 5VZmEekwiCFsCTUmWV2-tpTTxyo59yLu
X-Proofpoint-ORIG-GUID: 5VZmEekwiCFsCTUmWV2-tpTTxyo59yLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=491 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050091

Add the device tree for the AIM500 AIoT board along with usb, regulators,
serial and PCIe found in this board.

AIM500 Series is a highly optimized family of modules designed to support
AIoT and Generative AI applications which is based on SM8650P soc with
addtional functions like PMIC and bluetooth. And AIM500 AIoT is mounted
onto Qualcomm AIoT carrier board to support verification, evaluation and
development.

Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---

This patch series has some open discussion topics depend on [1], including:
1. memory map will have a large reserved region for firmware related,
   since currently firmware features are still in developing and easily to
   be changed.
2. vph_pwr was open whether it should be put in som.dtsi, or board.dts. we
   can see vph_pwr may have different design and implementation from
   different boards design, while vph_pwr needed to be one of the som input,
   and then the vph_pwr is used inside som to different pmics input. So we
   proposed have the definition in som.dtsi, and have it's own implementation
   in board.dts.
3. board compatible like aim300-aiot was open whether can be added or not.
   We added currently since it will fail dt binding check if not.

[1] https://lore.kernel.org/linux-arm-msm/20240119100621.11788-1-quic_tengfan@quicinc.com/#t

And we got following error while doing dtb check:
sm8650p-aim500-aiot.dtb: usb@a6f8800: interrupt-names: ['hs_phy_irq', 'ss_phy_irq', 'dm_hs_phy_irq', 'dp_hs_phy_irq'] is too short
Which should be caused by missing intertupt name "pwr_event" in sm8650.dtsi

Jingyi Wang (6):
  dt-bindings: arm: qcom: Document sm8650p soc and AIM500 AIoT board
  dt-bindings: arm: qcom,ids: Add SoC ID for SM8650P
  soc: qcom: socinfo: Add SM8650P SoC ID table entry
  arm64: dts: qcom: sm8650p: introduce sm8650p dtsi
  arm64: dts: qcom: add base AIM500 dtsi
  arm64: dts: qcom: add AIM500 AIoT

 .../devicetree/bindings/arm/qcom.yaml         |   9 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm8650p-aim500-aiot.dts     | 314 ++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi  | 409 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650p.dtsi         | 180 ++++++++
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   1 +
 7 files changed, 915 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8650p-aim500-aiot.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8650p.dtsi

--
base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379 
2.25.1


