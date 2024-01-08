Return-Path: <linux-kernel+bounces-19664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0082708E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8651283901
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E6A46BB1;
	Mon,  8 Jan 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A8KnOfJU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012834652E;
	Mon,  8 Jan 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408D7s5t018810;
	Mon, 8 Jan 2024 14:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=FZJXGcGWWSz5YokYWmw0
	WSWSVvdN0ciyGwybnoRxiHE=; b=A8KnOfJUJ2CUHGcBaNbaJLKhz8cwL1VHWXAF
	ZYvyK8T2v0KLKEdaa/ns/mOM5Bg9+/RmO6ABegCAsiB4Oy8cB3IeR6vxV31N50b3
	FEesVzdzFaCvxgZ/GYOiYxRnLr0Tu8nflWwn68oN5iplLJl4DU+9qoAV8DShMKqL
	PBUjqBKPFQE4wkO5TfzHQipiT5ibcrmetp5cUckugSKvBbCHDEonuB+UTmkbQCE5
	Ei/db1GTyLIrFEzJWcsA/IyYhq4PqNJGyZ3p0ftMsMiGIIJAhAonGOOyEz7hr6+K
	wVBKqFQ9EkhrkBJi/FdDE/dKpym4a7hqSEht4Ipqdog5MdoABw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbjygwaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 14:01:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408E1nif004519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 14:01:49 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 06:01:45 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 3/3] cpufreq: scmi: Register for limit change notifications
Date: Mon, 8 Jan 2024 19:31:18 +0530
Message-ID: <20240108140118.1596-4-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: 2wcr9TqM6Gggil7z6caXdyBhWfUUhCA4
X-Proofpoint-ORIG-GUID: 2wcr9TqM6Gggil7z6caXdyBhWfUUhCA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401080120

Register for limit change notifications if supported with the help of
perf_notify_support interface and determine the throttled frequency
using the perf_opp_xlate to apply HW pressure.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 42 +++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 4ee23f4ebf4a..53bc8868455d 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -25,9 +25,13 @@ struct scmi_data {
 	int domain_id;
 	int nr_opp;
 	struct device *cpu_dev;
+	struct cpufreq_policy *policy;
 	cpumask_var_t opp_shared_cpus;
+	struct notifier_block limit_notify_nb;
 };
 
+const struct scmi_handle *handle;
+static struct scmi_device *scmi_dev;
 static struct scmi_protocol_handle *ph;
 static const struct scmi_perf_proto_ops *perf_ops;
 
@@ -144,6 +148,22 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 	return 0;
 }
 
+static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	unsigned long freq_hz;
+	struct scmi_perf_limits_report *limit_notify = data;
+	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
+	struct cpufreq_policy *policy = priv->policy;
+
+	if (perf_ops->perf_opp_xlate(ph, priv->domain_id, limit_notify->range_max, &freq_hz))
+		return NOTIFY_OK;
+
+	/* Update HW pressure (the boost frequencies are accepted) */
+	arch_update_hw_pressure(policy->related_cpus, (freq_hz / HZ_PER_KHZ));
+
+	return NOTIFY_OK;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp, domain;
@@ -151,6 +171,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
+	struct scmi_perf_notify_info info = {};
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -250,6 +271,25 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		perf_ops->fast_switch_possible(ph, domain);
 
+	ret = perf_ops->perf_notify_support(ph, domain, &info);
+	if (ret)
+		dev_warn(cpu_dev, "failed to get supported notifications: %d\n", ret);
+
+	if (info.perf_limit_notify) {
+		priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
+		ret = handle->notify_ops->devm_event_notifier_register(scmi_dev, SCMI_PROTOCOL_PERF,
+							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
+							&domain,
+							&priv->limit_notify_nb);
+		if (ret) {
+			dev_err(cpu_dev, "Error in registering limit change notifier for domain %d\n",
+				domain);
+			return ret;
+		}
+	}
+
+	priv->policy = policy;
+
 	return 0;
 
 out_free_opp:
@@ -321,8 +361,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
 	struct device *dev = &sdev->dev;
-	const struct scmi_handle *handle;
 
+	scmi_dev = sdev;
 	handle = sdev->handle;
 
 	if (!handle)
-- 
2.17.1


