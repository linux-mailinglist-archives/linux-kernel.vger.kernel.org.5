Return-Path: <linux-kernel+bounces-127599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A5894E33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E231F212A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1056B89;
	Tue,  2 Apr 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YIL4iGjr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3B1759F;
	Tue,  2 Apr 2024 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048659; cv=none; b=twgVyrozHHOQZRAuPhJ4E6QYBJhF6pw7cfKYtWQMd8Fj76BFZek0RQW2GymN662QQj44EqLwpusPfdgyW3htmqfBX7DrxnVb+xQY8TmPpjZZP0OFsXjb71FgKm4QK4IIdte3723yHz5rOaiTmW+3zODhlKr9KxKgQmZglQiX+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048659; c=relaxed/simple;
	bh=RwUKRshkyxwavuoKzAaWZtcXxCTWkOI6EjSIeLMZ8oc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5dhf7IXZLiiCe33U849eVgmlOTzRxOPaiRRYsmtzLA8ZQ7YP3fKhuaM6uz3iwV92KTrIT/txohoAFR1cwueqv1KNuQLMg3wgdKPdsEBduWHpVZR2Or2pXBWW53SOHnELsgnXs7OWPoW20Ml5cCkthObCK3hdaliV+IHwYGfXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YIL4iGjr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4328w1LQ003750;
	Tue, 2 Apr 2024 09:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=1J9OIPA
	V8klAaL5etivGBMD4koRlDv/DMUPpD25johQ=; b=YIL4iGjrtfeNBoUWbibm7jn
	W2b4jopJkbRDy+5Ei3W0CdetACiapnDN8oA36nKobsKoFCma02BfzrYzPZIpZk9L
	LCA9SWxyLnFwj/WUsVKOro0a6JnUTmbMVAKSXwddJV8G9089JRv1CQtrx6m1GJ0b
	UZCDTLw7kGbdOc+ntMgcPJk9APR4jJKx6CLkXwcO5IOigds8F+BEP3F4be4uXc2d
	jWAwOv0u4gaElBGqVHEHtgxfq9j5M90voIYvwskPBA5v23IYYtDYGCIar85f+WYn
	jyFs2Skq0mPkE8brkNgOo76EW8+Pn3aI1RZcyrNn20HOmOInwKrD0+xVx/BxBhw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8eymg0q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 09:04:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432949RU002168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 09:04:09 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 02:04:05 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        Komal Bajaj
	<quic_kbajaj@quicinc.com>
Subject: [PATCH v2 0/2] Enable various remoteprocs for qcm6490-idp and qcs6490-rb3gen2
Date: Tue, 2 Apr 2024 14:33:47 +0530
Message-ID: <20240402090349.30172-1-quic_kbajaj@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XjChGYmYHBvWPUEFsH5LQwTkT5ysDk31
X-Proofpoint-ORIG-GUID: XjChGYmYHBvWPUEFsH5LQwTkT5ysDk31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=329 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020064

Enable various applicable remoteproc nodes for qcm6490-idp
and qcs6490-rb3gen2.

Firmwares are not shared at linux-firmware.git, it is under legal approval process.
Meantime, submitting the DT node changes for FW for review.

--------
Changes in v2:
* Updating the firmware name from mdt to mbn
* Link to v1: https://lore.kernel.org/all/20231220114225.26567-1-quic_kbajaj@quicinc.com/

Komal Bajaj (2):
  arm64: dts: qcom: qcm6490-idp: Enable various remoteprocs
  arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs

 arch/arm64/boot/dts/qcom/qcm6490-idp.dts     | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

--
2.42.0


