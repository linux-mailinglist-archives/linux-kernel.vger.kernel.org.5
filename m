Return-Path: <linux-kernel+bounces-85213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5106986B256
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE6A2859BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC721852;
	Wed, 28 Feb 2024 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BR4G5LBd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56373512;
	Wed, 28 Feb 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131928; cv=none; b=SQ9+6AMk42cRbG42T7+TZNrLaC9Bk30/rupZ8gyulcprvWPO/prNhhHM7qymLhtaKQr7LMDkywlFOdjkayfubC1KvteyCFbtygzoW2GUSuDnksqyFH754YJqg85WfmTkYzx4q6Pj4qA1npxZWEVZmegsWmH9wDx4TL93LmObfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131928; c=relaxed/simple;
	bh=YuzPr/pUdgOvZo3aDBGVazRapIDvDMx9I9rmCW9ywCI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=d0cUzqqNtizqSg3C4B2EEGxdE5Zrc0fHmM85AQM2Oc2fb1iPi9SBEA/09/PMV8VaNjRYtV1twEQWyktdO8NbER0jXzkGM/3OT8SfHgQdV28HefmZKl8Gfes1sCvnVH9vk/P8nWWwPQz9xymVdFzjWWRWP21R6i/NmjbaN9deFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BR4G5LBd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S5wtDR010518;
	Wed, 28 Feb 2024 14:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=ZtQZ+vDba4cuCZ
	FMSf7GWTaVAO7ja60gBBTtaY9ezBo=; b=BR4G5LBdJ022mYDrU3X6YaEY0yncAS
	X9qp5ZLfD7iTQrs/zsmJg4SzMA+mspHTCfPPKKPBYKKgS1nREFa3Unuf9jGhulDX
	euhKteHJiAeO43PF7U7zZqjXNt1asUUQ9zfS8rbLZkk9JabhAC/QRRW9XQ7cqj4s
	9jbdSZcwwrHFZ8TI/g4BuSn7I7p0ZDWsHOfCrAwha8g8vn1XsX347AEMwcrwNeJ6
	vL/y7RHClrM3ftvtu/DiKkPP8HqwTCnwbe5VbfiQ0O0RrrzAqkKiSVHMsogWKUg0
	NeJ64LaoZU9nQNQLkeRjlU8JlUcIpvmcMDqzsN0r/z0x47W8KiTgmVVg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whukssk5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:52:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SEq1XD025810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:52:01 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 06:51:57 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: [PATCH 0/3] Add support for the IPQ5321 SoC
Date: Wed, 28 Feb 2024 20:21:48 +0530
Message-ID: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIRI32UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyML3cyCQlNjI0Pd4uxS3eLSgoL8ohLdpBQDcwNTsxTTVANDJaDOgqL
 UtMwKsKnRsbW1ADeK8ORlAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709131917; l=786;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=YuzPr/pUdgOvZo3aDBGVazRapIDvDMx9I9rmCW9ywCI=;
 b=cGHxo4VmHZIbQe8CmqgtCxMY5z643MCViWxvvgRnEhVgQxjiH+NMGySGCR83RZ2Qj99qYLaTn
 zsYC+RDrGyJAZIXPNk4ta83Y29uRvRFHKqcYNM5WPrEHUs7//PqsfnE
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bL9oBc5xQ5AKJdvtitrNtMYtRMdW19pa
X-Proofpoint-ORIG-GUID: bL9oBc5xQ5AKJdvtitrNtMYtRMdW19pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=657 clxscore=1011 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280116

IPQ5321 SoC belong to IPQ5332 family. Add the SoC ID and the cpufreq
support. Maximum cpufreq for IPQ5321 is 1.1GHZ, which is determined
based on the eFuse.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Kathiravan Thirumoorthy (3):
      dt-bindings: arm: qcom,ids: Add SoC ID for IPQ5321
      soc: qcom: socinfo: Add SoC ID for IPQ5321
      cpufreq: qcom-nvmem: add support for IPQ5321

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 drivers/soc/qcom/socinfo.c           | 1 +
 include/dt-bindings/arm/qcom,ids.h   | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
change-id: 20240228-ipq5321-sku-support-bd07056d5e01

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


