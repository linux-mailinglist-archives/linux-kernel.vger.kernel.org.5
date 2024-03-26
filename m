Return-Path: <linux-kernel+bounces-120026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD91388D072
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B35C1C2E801
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC05613DB8C;
	Tue, 26 Mar 2024 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MsUKIw9y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ACE13C831;
	Tue, 26 Mar 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490854; cv=none; b=mAhAn2z97MeZJ2XiYORj6n3TdK+UDhC5YAFB/5CUhaaskTubYNvOfNKt4viX6F28JZMAry+z/z35gbl0gt7uv2160PvdfqTCRhxZV5rffo32o1Lv7VnI7RaA0Qic+Uhrn0YJpj977gByiMG7ojOs/kF/Imzb7wRU/gtnCC7tzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490854; c=relaxed/simple;
	bh=jTS7FgItFpU9cDGgCvhlPoCSnqjTktDvWdP8n9VpBvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WOxP3ApGVGwYVqgiH5fzFxhUTiKh4KNrt0VRratED+SqMCCGqCpaN8Ks+roDLGNDHSyuGIxhrY5+UkhmSb035OkGmxlpDL0ijPLWCjDW28YctJjy8UFOEyrHlSARKSSKLiMzXg0ARGBe0PuKAYugheaJ6ghv+OIz2UzoJ+Yvp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MsUKIw9y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QLj7dG021173;
	Tue, 26 Mar 2024 22:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=fS8f3m9
	ecVLmb249Cl5w4LbFnKVWeHEC1Yz9UUxx2nU=; b=MsUKIw9ykWHDaKfobww/1rm
	SfxCBTf+2M6Yztz5tHo1L4POyUIM4U0EmlKXZ5YU3mymGiatjDJJkMBJimMUl1Cn
	3frN28JkFaFih6rkg6jsmc+cmYfyf8KbE8iEJ4Kd5HfKYyXH3S8e8DrMD57SI6OQ
	KamCLdbxKmxDVHyvSQnYSP7nITUosrDXCDG7SO23iV4udbTeC7c3X4YLWaLfWE42
	flcKrwVvKn9Jp4bX/R21xYULlwTdwypQkJ7AZbzCFYaz6SgHHP+QbUuBBV9mkJ6w
	E8tsBtKmYoPB5uAZ2qFgMXLq5wjoWied+ifuV/c2Dq8DXsXceDg7PYRkrr3+cvA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x403q14gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:07:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QM7R38028659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:07:27 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 15:07:27 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 0/4] Add GPIO support for various PMICs
Date: Tue, 26 Mar 2024 15:06:25 -0700
Message-ID: <20240326220628.2392802-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zlyno8vQqL6X9TZLupaYIHdKpUcLkJto
X-Proofpoint-GUID: zlyno8vQqL6X9TZLupaYIHdKpUcLkJto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=720
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260159

Add GPIO support for PMXR2230, PM6450, PMIH0108 and PMD8028

Changes since v1:
  - Removed wildcard character from PMIC names
  - Combined patch 3/5 and 4/5
  - Made subjects and commit messages consistent between changes

Anjelique Melendez (3):
  dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH0108 and PMD8028 support
  pinctrl: qcom: spmi-gpio: Add PMXR2230 and PM6450 support
  pinctrl: qcom: spmi-gpio: Add PMIH0108 and PMD8028 support

David Collins (1):
  dt-bindings: pinctrl: qcom,pmic-gpio: Add PMXR2230 and PM6450 support

 .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 26 +++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      |  4 +++
 2 files changed, 30 insertions(+)

-- 
2.34.1


