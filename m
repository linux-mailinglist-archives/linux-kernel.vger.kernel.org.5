Return-Path: <linux-kernel+bounces-19666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F66827094
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C6C1C21F50
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C05647782;
	Mon,  8 Jan 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i9kxvcAv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8994654D;
	Mon,  8 Jan 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408BgcYI015255;
	Mon, 8 Jan 2024 14:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=1wSjxuT/iAH9PZBT3uHn
	E13TeuGmyWFfZuSvtiQEhYQ=; b=i9kxvcAvG0mTt10sh3+3RTU06ZiRjCxLs5mu
	9Bc+lN81S+Xcgx/SSPwJaPBfsPX0AujGESc8y8AY5YipYHk00y0yKXAu/yTHmO+S
	imBV/kIc4ZlezT74zW3PbAYlbVWmQsS7HlvyxMm0qQJeutwgiKsNrZr08EI0rFfv
	lnCPebOTqcMU+XmgM3MrLB6fly2saH2xXAsDpIt6ohPcEvRAGEYtXZ7L8fgqBZhc
	HjcYNCJe2+HgatIfi5SGFunbGk3bNyz9jdkCylAKHR10kLVtLLE9RrjXlZk2olKj
	NIU/DfRtT6V+34GyjpjWq6YQ9z4jhnknnXUWO1a0WZQ78wUD5A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8n09738-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 14:02:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408E1jql020970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 14:01:45 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 06:01:42 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 2/3] firmware: arm_scmi: Add perf_opp_xlate interface
Date: Mon, 8 Jan 2024 19:31:17 +0530
Message-ID: <20240108140118.1596-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108140118.1596-1-quic_sibis@quicinc.com>
References: <20240108140118.1596-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: R5D3casVtRTZy-PqIhmC_qx1iFnJMUVd
X-Proofpoint-ORIG-GUID: R5D3casVtRTZy-PqIhmC_qx1iFnJMUVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401080120

Add a new perf_opp_xlate interface to the existing perf_ops to translate
a given perf index to frequency.

This can be used by the cpufreq driver and framework to determine the
throttled frequency from a given perf index and apply HW pressure
accordingly.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 21 +++++++++++++++++++++
 include/linux/scmi_protocol.h    |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index c167bb5e3607..f26390924e1c 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -964,6 +964,26 @@ static int scmi_notify_support(const struct scmi_protocol_handle *ph, u32 domain
 	return 0;
 }
 
+static int scmi_perf_opp_xlate(const struct scmi_protocol_handle *ph, u32 domain,
+			       int idx, unsigned long *freq)
+{
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
+
+	if (idx >= dom->opp_count)
+		return -ERANGE;
+
+	if (!dom->level_indexing_mode)
+		*freq = dom->opp[idx].perf * dom->mult_factor;
+	else
+		*freq = dom->opp[idx].indicative_freq * dom->mult_factor;
+
+	return 0;
+}
+
 static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.num_domains_get = scmi_perf_num_domains_get,
 	.info_get = scmi_perf_info_get,
@@ -979,6 +999,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.fast_switch_possible = scmi_fast_switch_possible,
 	.power_scale_get = scmi_power_scale_get,
 	.perf_notify_support = scmi_notify_support,
+	.perf_opp_xlate = scmi_perf_opp_xlate,
 };
 
 static int scmi_perf_set_notify_enabled(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b0947d004826..9c285ae89848 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -145,6 +145,7 @@ struct scmi_perf_notify_info {
  * @power_scale_mw_get: indicates if the power values provided are in milliWatts
  *	or in some other (abstract) scale
  * @perf_notify_support: indicates if limit and level change notification is supported
+ * @perf_opp_xlate: translates the given perf index to frequency in Hz
  */
 struct scmi_perf_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
@@ -173,6 +174,8 @@ struct scmi_perf_proto_ops {
 	enum scmi_power_scale (*power_scale_get)(const struct scmi_protocol_handle *ph);
 	int (*perf_notify_support)(const struct scmi_protocol_handle *ph, u32 domain,
 				   struct scmi_perf_notify_info *info);
+	int (*perf_opp_xlate)(const struct scmi_protocol_handle *ph, u32 domain,
+			      int idx, unsigned long *freq);
 };
 
 /**
-- 
2.17.1


