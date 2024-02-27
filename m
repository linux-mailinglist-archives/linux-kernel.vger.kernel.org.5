Return-Path: <linux-kernel+bounces-82935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C2868BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320DB1C2293A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166DE136980;
	Tue, 27 Feb 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DoBgcFgk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B536713664E;
	Tue, 27 Feb 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025312; cv=none; b=f6qHAfYnoTz6HJvtDmufbtaAqaHHCvrhMdXsk0wnpWABfNIg5F7jXwun6wtMOUUtfw9Z6ZWK4Dv52yehrbbLQv2nXPjSetgCsq5dWfkwKmge+eZiiXLPTidgHFZtjg9DHzC+BJD+HSaPoM9y+8jKY3EQjIuoxn1u8Rm8jKkhOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025312; c=relaxed/simple;
	bh=iH0cmn/PzDVCeYjVzbKKlG/flQNqKVr7ns0XcjV4cMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JY047KBJ2iE9/rUaR5Zke4azfAETDHXWuZU4XUa9n155p0OGQm6HKIV1gJ/Hwg0HkRyfU2k2K6QtQ1oe25oF/f0Yd3MQAX1z3IrQwFWN8ujv9OE7SDVH6weOM8fIGgFFdo6yXy5DVr9VLTKZshRmbypS583nZ/mRbWjk0AbfC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DoBgcFgk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R6Ohis031405;
	Tue, 27 Feb 2024 09:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=vm43AHf
	KrpEAmlriQ1rL1f2nqgUvYYMyaY7EE4JlVIo=; b=DoBgcFgkB/NgO9Y7roAYTZA
	SZaXAyGc8cIXmAlrwcWstuwxBJ6uCb4ZCS9zUL+cBqGV/5g8+r6+G8Y3iHTYqMQe
	cPIgbTepYBK1sfKU2UxWTb6kFqmzmo2WdzFZnUPxNgsNflVCyweC2+AMfqjwmIjz
	RpFAlBqrZ2M6ycYsN6GGXEaTl/PClhXWZhfOS56z0gUoaVg8OCWSvtp29p/v5KpU
	IDtpvE7hP09LiL4C0qfgcSpYZBxmmMupmHu5IDOR3Pn8wQYuuFNryyNaQlbkpJdt
	lmvZQr1lQQoLVBCUycUPSEcxZxWX1qs/x0+DB706UrrM3OuWnUz3TqpXLnlOM5Q=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh6ws8rdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 09:14:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R9EvIS026172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 09:14:57 GMT
Received: from hu-kshivnan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 01:14:51 -0800
From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
To: <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
        "Vincent
 Donnefort" <vincent.donnefort@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_namajain@quicinc.com>,
        <quic_rgottimu@quicinc.com>, kernel <kernel@quicinc.com>,
        Shivnandan Kumar
	<quic_kshivnan@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] cpufreq: Limit resolving a frequency to policy min/max
Date: Tue, 27 Feb 2024 14:43:51 +0530
Message-ID: <20240227091351.1144757-1-quic_kshivnan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ePEAwZl82dk9kvHeNAIxGCDV8ak971nS
X-Proofpoint-GUID: ePEAwZl82dk9kvHeNAIxGCDV8ak971nS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402270072

Resolving a frequency to an efficient one should not transgress policy->max
(which can be set for thermal reason) and policy->min. Currently there is
possibility where scaling_cur_freq can exceed scaling_max_freq when
scaling_max_freq is inefficient frequency. Add additional check to ensure
that resolving a frequency will respect policy->min/max.

Cc: <stable@vger.kernel.org>
Fixes: 1f39fa0dccff ("cpufreq: Introducing CPUFREQ_RELATION_E")
Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
--

Changes in v2:
-rename function name from cpufreq_table_index_is_in_limits to cpufreq_is_in_limits
-remove redundant outer parenthesis in return statement
-Make comment single line

--
---
 include/linux/cpufreq.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..7741244dee6e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1021,6 +1021,19 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
+static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy,
+						    int idx)
+{
+	unsigned int freq;
+
+	if (idx < 0)
+		return false;
+
+	freq = policy->freq_table[idx].frequency;
+
+	return freq == clamp_val(freq, policy->min, policy->max);
+}
+
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
 						 unsigned int relation)
@@ -1054,7 +1067,8 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 		return 0;
 	}
 
-	if (idx < 0 && efficiencies) {
+	/* Limit frequency index to honor policy->min/max */
+	if (!cpufreq_is_in_limits(policy, idx) && efficiencies) {
 		efficiencies = false;
 		goto retry;
 	}
-- 
2.25.1


