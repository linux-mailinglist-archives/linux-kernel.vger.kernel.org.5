Return-Path: <linux-kernel+bounces-107279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1307C87FA54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4592C1C21BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF827C6CC;
	Tue, 19 Mar 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kGWFmmCO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3A54BE2;
	Tue, 19 Mar 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839288; cv=none; b=R03coJ4jQFjUbaK1//GUXY0ge/cLnzuZNf/Wa58MQ4qLDEyEbv9VngIwjF11+YhNAl4AVuQMu0eMrrZqoTr9bm+3IHJgyUNIUV7CsNdsXUfphXfeSW5OeAljgxoDpRoscF/q4YDSqPoN/jmkkGDcGuUfUSrq181MO5D3vr237HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839288; c=relaxed/simple;
	bh=1YarG7GbSGGH/lbImy8EevZHEMUEWi3oXQdaJmqDZDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FUWRUWuGtyYLEY8k9oTIAGK0bJU1jc/2b+pXZo7PbZPhDMfc3WkqMTJo+HC5Rbon0QIrxJVRgIaU/xZHsulnhP7GxKO8ctDqx2LbN46Fo/P/e57x6N+ql2XStGwo0aW69JyZhhzZcwQ3Q7n8iKYO0dWvyssUpZmGWbVM6YjGQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kGWFmmCO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J4Q8YM029011;
	Tue, 19 Mar 2024 09:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=wwYFukg
	eyuIky5uAAKxxD46KLlDXv5v6ZWiYYzTNLzw=; b=kGWFmmCO8DHqJ07PnHE1nwI
	Grq9EeuzuGUdy+SbgqZYp/CTHsDh64GR7DxzDZosR++IVx1tm6aq+hrVSYYhJ83g
	dUCQOvmwyaZDjVyrpp1rF21OdiDXVGEJ/0Oa7p6LU+4cVqhvYKWY6Ai+2Kv7zlYJ
	E3ANOHI15vfgmPwriGFn5j/z2oVOcuBTtPhCsUFZF3OnxUh/mMUAVGsxBH/Eao5m
	u1mkMHfSXNAt0L5tfFtFwE3VPPeB7Jxi4E5yQHoF7S1PRWTLip0K4DBFlcH1uhqN
	zSrJTaYvjaLvJGd86Gj8LEBOUWIacxOjDzXE/QE1ayobjuUf1Ig5wGconDXkXvQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2cjrnue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:07:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J97sUA027195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:07:54 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 02:07:49 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 0/4] Add USB Support on Qualcomm's QDU/QRU1000 Platform
Date: Tue, 19 Mar 2024 14:37:24 +0530
Message-ID: <20240319090729.14674-1-quic_kbajaj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: BbcRD6RuQmQNMSU6OMuTTVs-P-h3R06-
X-Proofpoint-GUID: BbcRD6RuQmQNMSU6OMuTTVs-P-h3R06-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=561 suspectscore=0
 mlxscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403190068

This series adds support of USB3 PHY support for Qualcomm's QDU/QRU1000 Platform.

---------
Changes in v2:
* Dropped extra lines
* Sorted the tables alphabetically
* Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120215.16845-1-quic_kbajaj@quicinc.com/

Komal Bajaj (4):
  dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QDU1000
  dt-bindings: phy: qcom,qmp-usb: Add QDU1000 USB3 PHY
  dt-bindings: usb: dwc3: Add QDU1000 compatible
  phy: qcpm-qmp-usb: Add support for QDU1000/QRU1000

 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |  2 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |  1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  3 ++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 49 +++++++++++++++++++
 4 files changed, 55 insertions(+)

--
2.42.0


