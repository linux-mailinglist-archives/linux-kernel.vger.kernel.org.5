Return-Path: <linux-kernel+bounces-117409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D288AAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8B81C3E26C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3761146A9B;
	Mon, 25 Mar 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SYEpR+Hp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3E146587;
	Mon, 25 Mar 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381811; cv=none; b=jSwYIukFYXhHuAf5thvLePD5b9OZZoqDNlPdRBWXscdLZDNMbTgVxNzasXs5fN9QvEJEBDmkWHTxi80Kd5DueVRW6If6btw3H0RWuWDqh3awUHgW3GHdYpW/S1sAZEMbkm07DivhgDxYEJ0hjGtUBVW3huyVwjDGTdRR1oHL1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381811; c=relaxed/simple;
	bh=zX04EH+4MwyZ3/UQjXgdCLOvVCK1C+C2iTBk3fYJ2gs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=H/m/CSPEXuoYKwLOhR/5tpdDjN56lM3VkgTtZLgFE7Nilk7zdAX5YwmNPI+JIFTFIZdlDlQdSlvyujV+D8NwGG4dfLrAPpwid5DgqJ8Pwbd1azea7Ikqv9TpUV1Dg6KHnvucTCrKIaJgnNGSdLqidFWFP9O4xLCdBh+KEkHLLMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SYEpR+Hp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PEPCsL010575;
	Mon, 25 Mar 2024 15:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=O2/Zpcx3MdIsGM
	tkmh42I91WJh8rWahn55GaFo9B+xQ=; b=SYEpR+HpP06HEtWq+GfgI9mcWQToTf
	3s1QDNFlIyPbiMamhrGJbmow4TITLxIgAKsw6zxwF0jrw2+vCWjxw93GL+2gva5e
	in0q3dbR4ARKZlZcytJlDS0aUB9wnrAl5S+xopupWuI+4np3TCi6Kl8BVmQTg42J
	3BqQSUPXWYopIIa5qUTs3kEr2vSvQz0OWhGASjGHb83WtD1d4BhmtFkw8AoJzGRF
	dP0aK174vaji4vIkjXefrx+7JA94ptP7KhjYvvw+OXIKXU8cKWOyDdNFSOvFgCId
	KkH9EYeMaASfr8A5EMU0rOxT+K8axipg9euS+zvMTDHPndP4an5CpheQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3b0yr6vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:50:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PFo47Y016230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:50:04 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 08:49:59 -0700
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: [PATCH v2 0/3] Add support for the IPQ5321 SoC
Date: Mon, 25 Mar 2024 21:19:47 +0530
Message-ID: <20240325-ipq5321-sku-support-v2-0-f30ce244732f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABudAWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDIyML3cyCQlNjI0Pd4uxS3eLSgoL8ohLdpBQDcwNTsxTTVANDJaDOgqL
 UtMwKsKnRsbW1AFhtsH1lAAAA
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
 Thirumoorthy" <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711381799; l=1152;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=zX04EH+4MwyZ3/UQjXgdCLOvVCK1C+C2iTBk3fYJ2gs=;
 b=Qs4iXLAMy20KVWlXuT9mh8zhJadcZTmFL8Rya4FKgU7Xf2fv0zlDUAjCZ65CA/gHgC4ne3JLb
 nHDMyT50v2hCGRyjZtmor9bUYGqmljk6ZkRpP1GCLU3X/+m/X1iyhDH
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ML8yShBGWV8r-9TTJSSTWPdI8OF5FI7d
X-Proofpoint-GUID: ML8yShBGWV8r-9TTJSSTWPdI8OF5FI7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxlogscore=643 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250087

IPQ5321 SoC belong to IPQ5332 family. Add the SoC ID and the cpufreq
support. Maximum cpufreq for IPQ5321 is 1.1GHZ, which is determined
based on the eFuse.

Viresh is okay to merge the cpufreq change via qcom tree[1] and provided
his Ack.

[1]
https://lore.kernel.org/linux-arm-msm/20240306053200.6iwrviltwt3pnfnt@vireshk-i7/

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in v2:
	- rebase on next-20240325
	- pick up the tags
	- Link to v1:
	  https://lore.kernel.org/linux-arm-msm/20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com/

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
base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
change-id: 20240228-ipq5321-sku-support-bd07056d5e01

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


