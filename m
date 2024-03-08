Return-Path: <linux-kernel+bounces-96866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAECB876261
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E968284006
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E668356745;
	Fri,  8 Mar 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DGV2WEJx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FE55C18;
	Fri,  8 Mar 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894692; cv=none; b=F300FwnywXKsSqbRG6bl2d7OCQgStcoxLjfG865w7KYDbIhgKMRu7bpsgH37kS5DWyoMhMB/08Ia7NCOXsrX8cQjiI/Zos51X//y6Hx7IzIocvotBnQZ0AExMoZ7eeskHuUA+SLrdVskvU0gS6oRSLSxaS8muRRULJ6Ueh+BDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894692; c=relaxed/simple;
	bh=PwBP36oa/1ya7DgHCgl3s8pna248l/mNWtOjYUzA5Mo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdkUzeiTiEqu7k2hnwoN3evz0djYUqzhCZHTtuutvqrZa1ajv4igP8z/IxZj5L5P/YnbK8CK3GaF9oXAWWkfrVsnlZEMruoPEjcjdLhw5vnLDQJdKlqLMGnPlt1xWnW/9BmznrDKlt9ChfxRFqeoZyZQXZ911QEnqLjtNptXmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DGV2WEJx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428A5jtr027172;
	Fri, 8 Mar 2024 10:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XbzGmI/H+M7jrcCmm5O2fs2KrZylOonYBZ9JNoiny3s=; b=DG
	V2WEJxsPWMNs5aCf53D6RIlCFveXMD2Me/1Dg5bi6YeBZjNNpVL3zcaIpE3r6yZv
	1QH1hem0bZS3RcNIoc0KLMlmy5loesI8Sd++DxDQ4TTFk67ncl5oznCUIS93dS8k
	AQcsDbyYXock4ECmKY/m9Qb/np/j8aCf2eNYdkjf4vZ81wBtCU5AgPwjVRK4adGT
	GbeEeN01mCRo9dv4+LwHzoVEo2WFLH7tqmL1TpPJ9I1Fpztffj9yNP6fsQeCmgz6
	UvQUibRDiKTsZL3zi4kQSMCePW+uV7YPcYUHlyp/EWvOOyO47Ru75CW9GZTjmVG5
	gqIfnotd6Jna7JFRhycw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqyfsr79r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 10:44:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428AicmT016118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 10:44:38 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 02:44:33 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH V3 2/2] cpufreq: scmi: Enable boost support
Date: Fri, 8 Mar 2024 16:14:10 +0530
Message-ID: <20240308104410.385631-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308104410.385631-1-quic_sibis@quicinc.com>
References: <20240308104410.385631-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: z5IqSlU8GBXzu3i9Asa1x7JbYnmalQTy
X-Proofpoint-ORIG-GUID: z5IqSlU8GBXzu3i9Asa1x7JbYnmalQTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080085

The X1E80100 SoC hosts a number of cpu boost frequencies, so let's enable
boost support if the freq_table has any opps marked as turbo in it.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
* Don't set per-policy boost flags from the cpufreq driver. [Viresh]

 drivers/cpufreq/scmi-cpufreq.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 0b483bd0d3ca..3b4f6bfb2f4c 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -30,6 +30,7 @@ struct scmi_data {
 
 static struct scmi_protocol_handle *ph;
 static const struct scmi_perf_proto_ops *perf_ops;
+static struct cpufreq_driver scmi_cpufreq_driver;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
@@ -167,6 +168,12 @@ scmi_get_rate_limit(u32 domain, bool has_fast_switch)
 	return rate_limit;
 }
 
+static struct freq_attr *scmi_cpufreq_hw_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+	NULL,
+};
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp, domain;
@@ -276,6 +283,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->transition_delay_us =
 		scmi_get_rate_limit(domain, policy->fast_switch_possible);
 
+	if (policy_has_boost_freq(policy)) {
+		ret = cpufreq_enable_boost_support();
+		if (ret) {
+			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
+			goto out_free_opp;
+		} else {
+			scmi_cpufreq_hw_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
+			scmi_cpufreq_driver.boost_enabled = true;
+		}
+	}
+
 	return 0;
 
 out_free_opp:
@@ -334,7 +352,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.attr	= cpufreq_generic_attr,
+	.attr	= scmi_cpufreq_hw_attr,
 	.target_index	= scmi_cpufreq_set_target,
 	.fast_switch	= scmi_cpufreq_fast_switch,
 	.get	= scmi_cpufreq_get_rate,
-- 
2.34.1


