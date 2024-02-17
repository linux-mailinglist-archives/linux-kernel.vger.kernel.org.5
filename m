Return-Path: <linux-kernel+bounces-70096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6F78592FD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9428449F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9CF80037;
	Sat, 17 Feb 2024 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kb7PIdjw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF57E760;
	Sat, 17 Feb 2024 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708205459; cv=none; b=YHj4yXlwSwu1rAWk1hPFO8JYEe2mSUHsIDTsCgpe/pdx46lJSBr2sGtaa/ce0fqortD0oURHhbU+tRcpjsI1JqTIKfS/eQZ1UgcFOZ/7IA0gHHGBuueDoEI0MuBALT3VXeEq6ToLkP6XjaStalr6V0o0eU4dlJmMZ+xjgk9Q8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708205459; c=relaxed/simple;
	bh=czOliQ0OxjGx6AeLHhquochMzRqKg9PUNsJjQq3EbPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EkUpwxA8RKRbEL0XlDl92yxRxC339UDUqw+6kxOcbZIhh4pSQV+ny2LAnZ8l41FQk/vVZIh83lhist6LNIMDlp2K+3Q5pDQJRZrR/nS5o0dpzRKKKPfIkM4oyMuPPgHksD4IjbBfk+dyxoBUlXtsYs2myMHVQT/RJs9uZyd/ShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kb7PIdjw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HLTsDW019092;
	Sat, 17 Feb 2024 21:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=60n
	ZSbuMq1De8FlLK4k1D6fMOSTbtJSL1lSZrb1xVfY=; b=kb7PIdjwaeYF+nIcIEL
	HBsBUVwWVtHHpwS+WOPgd/B/LGaEYxfJb9rbEIz3XWUBRVmg7VmnVKR6UdFz8uTL
	aQLoUL3lM5ZqN00tabMahHpHwe5K+QutL0wt+vQvRmMIqMzxyVZFeDagxSQun62S
	nBoMPgNeYNllVq3hnONEdKcYZu+1Ut4+Xy2AXmOxyD9UebqBSIYjyMmFwyWcM/Aj
	WSqyRUa/zH5d1HOpbNTzG5J68fxqv5eDMKh7S4+MtqaPXgPY+8JnC4TrovvCJVOc
	27wgxpbGTnWj0YUjBhWTkNmmsnFkOHxUa4nrY3g75si3Y8dbNf9VHZpQ/xtrmtBO
	l5g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wam4q11y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 21:30:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41HLUiow016969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 21:30:44 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 17 Feb
 2024 13:30:44 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 17 Feb 2024 13:30:43 -0800
Subject: [PATCH] dt-bindings: net: wireless: qcom: Update maintainers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240217-ath1xk-maintainer-v1-1-9f7ff5fb6bf4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIIl0WUC/x2MQQqAIBAAvyJ7TlCJzL4SHSTXXCILlQikvycd5
 jCHmQoZE2GGiVVIeFOmMzaRHYM12LghJ9cclFC9UFJzW4J8dn5YiqWBiQ/Gr9brUXpnoHVXQk/
 P/5yX9/0AjyxS9GMAAAA=
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath11k@lists.infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rozfTO-K88W-M-tEmD9hjBJvAWSV-ZPx
X-Proofpoint-GUID: rozfTO-K88W-M-tEmD9hjBJvAWSV-ZPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=643 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170178

Add Jeff Johnson as a maintainer of the qcom,ath1*k.yaml files.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml     | 1 +
 Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml | 1 +
 Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index 7758a55dd328..9b3ef4bc3732 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -8,6 +8,7 @@ title: Qualcomm Technologies ath10k wireless devices
 
 maintainers:
   - Kalle Valo <kvalo@kernel.org>
+  - Jeff Johnson <jjohnson@kernel.org>
 
 description:
   Qualcomm Technologies, Inc. IEEE 802.11ac devices.
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 817f02a8b481..41d023797d7d 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -9,6 +9,7 @@ title: Qualcomm Technologies ath11k wireless devices (PCIe)
 
 maintainers:
   - Kalle Valo <kvalo@kernel.org>
+  - Jeff Johnson <jjohnson@kernel.org>
 
 description: |
   Qualcomm Technologies IEEE 802.11ax PCIe devices
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 7d5f982a3d09..672282cdfc2f 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -9,6 +9,7 @@ title: Qualcomm Technologies ath11k wireless devices
 
 maintainers:
   - Kalle Valo <kvalo@kernel.org>
+  - Jeff Johnson <jjohnson@kernel.org>
 
 description: |
   These are dt entries for Qualcomm Technologies, Inc. IEEE 802.11ax

---
base-commit: 3ab6aff5793c3c7bdf6535d9b0024544a4abbdd5
change-id: 20240217-ath1xk-maintainer-69fcaf781fd9


