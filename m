Return-Path: <linux-kernel+bounces-19662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9BB827087
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D341F22EE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130146535;
	Mon,  8 Jan 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CDhUsrJK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9674597A;
	Mon,  8 Jan 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408CKZ6d013064;
	Mon, 8 Jan 2024 14:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=XSdf+yYKlevuqvUAJL2ZB1zbnY7c7soWv8e8oy1iaoM=; b=CD
	hUsrJKcTPqhAVS5jeiB8uIQgjrzTVGCTR8O8smRHlzIlFkKdXCAHkUF7wb6T6opk
	22o1/MqfDRBLbJb8ViZzvY1Y5eZxkxcY0HmwHgyWhsH0Jr39fisscM9V11q140pz
	hcU9XWurgEgb6YVj0Oz0KkY3wWyQ66r+GJApZm1spC9AAdhtuFovamDLv879+1lu
	7iOLnGiaaEAp5cAgm0MZ7gwNTqyTM6Gp6o8vXlvtb6NXwkIXgB1ILL9wcsXa1CC8
	pY/QYEEhv4C5EkuKQMwYP8z4jDiwOQC7oFDamda2adCxlruxKb6X2rtYrvdIn3Be
	Ydp6xn9h0BeFeWCWbkbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbu2gvce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 14:01:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408E1cfu009427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 14:01:38 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 06:01:34 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 0/3] firmware: arm_scmi: Register and handle limits change notification
Date: Mon, 8 Jan 2024 19:31:15 +0530
Message-ID: <20240108140118.1596-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1VpS28Qtf73KLRqQFxwLRRczD4qm_F08
X-Proofpoint-ORIG-GUID: 1VpS28Qtf73KLRqQFxwLRRczD4qm_F08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1011 mlxlogscore=469 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401080119

This series registers for scmi limits change notifications and adds
perf_notify_support/perf_opp_xlate interfaces which are used by the
scmi cpufreq driver to determine the throttled frequency and apply HW
pressure.

Depends on:
HW pressure: https://patchwork.kernel.org/project/linux-arm-msm/cover/20231221152407.436177-1-vincent.guittot@linaro.org/

Sibi Sankar (3):
  firmware: arm_scmi: Add perf_notify_support interface
  firmware: arm_scmi: Add perf_opp_xlate interface
  cpufreq: scmi: Register for limit change notifications

 drivers/cpufreq/scmi-cpufreq.c   | 42 +++++++++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c | 37 ++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h    | 11 +++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)

-- 
2.17.1


