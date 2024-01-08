Return-Path: <linux-kernel+bounces-19663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BDB82708A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB3B1F20ECA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE654655D;
	Mon,  8 Jan 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oy9rb+Ty"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7646527;
	Mon,  8 Jan 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4089cbVJ028386;
	Mon, 8 Jan 2024 14:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=SfiBgtHRUBdygY0Bs1Dt
	0reFevWncEuss/A9TFYO1Bk=; b=Oy9rb+TyQn6MpGBYLnbNfZl+wauG+dMKqzIo
	CaEf93pWywJIMR7O8zhYqp7I+Y+Dmha6kWHIxJGF+fwkXQ6E/fwelsvF9CI0CISa
	6/JGLBizp+Xcrd4EzWjRFNb2PGKUpXwPCStf0EuYfmthB4g387gNVSuFVdvlIyvU
	9gVELG8invm6DEX3XXfs6uCGxXNx314O9dtvrV3GmDMAL6cmF4s98GcVD8jxXrCh
	Avv3z59lwNLl4xUDOrp2kGYCUSr3Ju1dvp5EIGob7eXogEwL+KbnFRRFR1+547jF
	fmofqm+k9qM5z7P9Go8lJsyO6pyq6Ic6NH82y8oln+Fz5xwCrA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8mx987f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 14:01:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408E1gMl003984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 14:01:42 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 06:01:38 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 1/3] firmware: arm_scmi: Add perf_notify_support interface
Date: Mon, 8 Jan 2024 19:31:16 +0530
Message-ID: <20240108140118.1596-2-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: v4zCZrKco8xHRw5bT_OK5dyjStkSyflJ
X-Proofpoint-ORIG-GUID: v4zCZrKco8xHRw5bT_OK5dyjStkSyflJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080120

Add a new perf_notify_support interface to the existing perf_ops to export
info regarding limit/level change notification support.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 16 ++++++++++++++++
 include/linux/scmi_protocol.h    |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 8ea2a7b3d35d..c167bb5e3607 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -949,6 +949,21 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 	return pi->power_scale;
 }
 
+static int scmi_notify_support(const struct scmi_protocol_handle *ph, u32 domain,
+			       struct scmi_perf_notify_info *info)
+{
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return -EINVAL;
+
+	info->perf_limit_notify = dom->perf_limit_notify;
+	info->perf_level_notify = dom->perf_level_notify;
+
+	return 0;
+}
+
 static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.num_domains_get = scmi_perf_num_domains_get,
 	.info_get = scmi_perf_info_get,
@@ -963,6 +978,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.est_power_get = scmi_dvfs_est_power_get,
 	.fast_switch_possible = scmi_fast_switch_possible,
 	.power_scale_get = scmi_power_scale_get,
+	.perf_notify_support = scmi_notify_support,
 };
 
 static int scmi_perf_set_notify_enabled(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..b0947d004826 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -117,6 +117,11 @@ struct scmi_perf_domain_info {
 	bool set_perf;
 };
 
+struct scmi_perf_notify_info {
+	bool perf_limit_notify;
+	bool perf_level_notify;
+};
+
 /**
  * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
@@ -139,6 +144,7 @@ struct scmi_perf_domain_info {
  *	for a given device
  * @power_scale_mw_get: indicates if the power values provided are in milliWatts
  *	or in some other (abstract) scale
+ * @perf_notify_support: indicates if limit and level change notification is supported
  */
 struct scmi_perf_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
@@ -165,6 +171,8 @@ struct scmi_perf_proto_ops {
 	bool (*fast_switch_possible)(const struct scmi_protocol_handle *ph,
 				     u32 domain);
 	enum scmi_power_scale (*power_scale_get)(const struct scmi_protocol_handle *ph);
+	int (*perf_notify_support)(const struct scmi_protocol_handle *ph, u32 domain,
+				   struct scmi_perf_notify_info *info);
 };
 
 /**
-- 
2.17.1


