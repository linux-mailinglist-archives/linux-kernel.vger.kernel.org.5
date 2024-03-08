Return-Path: <linux-kernel+bounces-96864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0945A87625A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44731F23383
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F40A5578E;
	Fri,  8 Mar 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HpKzKaSb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551755769;
	Fri,  8 Mar 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894682; cv=none; b=QOvi3/4DszFyKT4NtXxgrBeBPPfhHu9GKBQ2cpZvNGDc9Q5v8qGJ67OIBn5o3M/G3VdB0BtFY4hDyRSPXI9YNRzjJWFNwDwqGYSyi5MIz3YCShiaWd8hUlrADX9Lrg6v3DUFoOjsTuClIe8BhFAuGaFnV01jcMDXX0bf7oVj3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894682; c=relaxed/simple;
	bh=CDf+ZrpckgqawHriterDf0Z51iDnWUR98sMP1ZCkCcQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r7gXbYpX11RadzYTVuBFY0K3fd9ApMi6gvg5C/DyLtF7WAzT6YzWv4oHLKa9bpgOj0gRqlBjZHTCOJ2ba0PbUY4JMiiR+gn1RcoVPPY3Gz6M95yoh7/ztJCsqN56qu0yhk4kndwueOlavnVubsQbZTu8KjBWmg2o92wqtzRx1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HpKzKaSb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428AcgY7024753;
	Fri, 8 Mar 2024 10:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=oHPpqhk
	nyChfBM4lrsRTOMW/Otu0VRLifBkDhrtQt8I=; b=HpKzKaSbHSmisCSrv+0RY/o
	TAmSJZfRhnzX5a3vo8qEZtBQtu3nC4UQ+Re/Yj6dG3HoQRtcSiZde2MyoV1Fgqf0
	BCai4Ohyf/1i+aXet9VpMCRHUc1E16LoOplgRME56T84YHHHhMCt/cIWynZe6UmT
	pRce0ABFXQpAFcR/s+jTO9xn47fEoy0QvSxXh+8rBMhyC163mqojh9/33438Fo9G
	AjOHmIyjf4MYj1qWtECsMFm59uFHuDOXxjdzrsx6my0SLgzeW9hHOllF3lEVaYcD
	XDc9bkBHc6+f0Yp+O+2NAT2LTel5Se+rUhAsyuSkRltrgxS321UvIi8axqIoQAg=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8n1gus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 10:44:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428AiT1u012660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 10:44:29 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 02:44:24 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH V3 0/2] cpufreq: scmi: Add boost frequency support
Date: Fri, 8 Mar 2024 16:14:08 +0530
Message-ID: <20240308104410.385631-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OGf4W-cBp8WJ0t_BbiwapnFMGxYvWFkk
X-Proofpoint-GUID: OGf4W-cBp8WJ0t_BbiwapnFMGxYvWFkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080085

This series adds provision to mark dynamic opps as boost capable and adds
boost frequency support to the scmi cpufreq driver.

V3:
* Don't set per-policy boost flags from the cpufreq driver. [Viresh]
* Drop patch 1 since Viresh already pulled it in.
* Drop depends on bug link. [Viresh]

V2:
* Document boost flag. [Lukasz]
* Remove sustained_freq check. [Pierre]
* simplify sustained_freq_khz calculation. [Sudeep]
* fix default per-policy state. [Dietmar]
* fix typo in commit message in patch 3.

Sibi Sankar (2):
  firmware: arm_scmi: Add support for marking certain frequencies as
    boost
  cpufreq: scmi: Enable boost support

 drivers/cpufreq/scmi-cpufreq.c   | 20 +++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c |  8 +++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.34.1


