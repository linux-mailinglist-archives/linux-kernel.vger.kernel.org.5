Return-Path: <linux-kernel+bounces-76113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116E85F319
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FD41C2343E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5C24A0D;
	Thu, 22 Feb 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TAZkXbiB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA5101C2;
	Thu, 22 Feb 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590959; cv=none; b=a3tvo04Bml8UGYXZ547TCw3H/ZPjkonjcOJYyxbTwDyIfzLYrXZhD0oItZ2Pm481GdPH967Uzyzhf7aMBSr/EIH/g0tjKylA6pGFl0byXG8MasN1FUa5FCLUye2L1sfEZzeOSFR66moJb2G380iNvA1cgsdF1W5wtqCMLH3FfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590959; c=relaxed/simple;
	bh=zDaKnyithl6OHzhgLveEH/2y+xN3MZ7oYAM+dHUYzMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DDLfp0x2ZMkAvTWTw8pgu/gwEKbKGWXJN5iXSiGqFGTphLdJl0FPK0MaVk6nM4ZyE66KTw1upuKyG4jyPbipNhqVFjvL4zuWOhiWJbsvZcoUUhJ9rJ2NX4Sj8pNjLuUgkYoBSeVntUR81lwzXBGceuJwq99BWGNj5WAKx9tXFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TAZkXbiB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M1TFdI030580;
	Thu, 22 Feb 2024 08:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=RyvY7D5
	kwxmNjfCTlpzX6mhKqRWYnDZna4huJoRzCkY=; b=TAZkXbiB18MmAzvUCqAY5Mn
	8Y7sOZ+MOoxDL2ZjLEPUZQhjOS2HmLrxrYBBAkXizxeeqQCVOcICuVLikCQROOTp
	tPvhVNZNV2PdEqZ0AjroEXc+qFEsyu4sAgHRy3Fah4d1kV1vrUeXAw2kofE0FjyN
	kHnZwUr4o8hkp9qPZWe8IagO0g6Gw/Arlgr8DBSZ4pYRypZTNsDb4FNEbORkiMng
	agOVcgW/pERenJsNGFT8mVQw32EyJhYFQk3omoFxX/1VgC76wGjW5l7y49/XZx3h
	IK1o63aO6ZdjHPTwRVpfa30HxFXKB1hDDoLI5+amnK30QuR0g8p4DxA8IcpF42w=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdsk4s7hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 08:35:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M8Zn4O011157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 08:35:49 GMT
Received: from hu-kshivnan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 00:35:43 -0800
From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_namajain@quicinc.com>, <stable@vger.kernel.org>,
        Shivnandan Kumar
	<quic_kshivnan@quicinc.com>
Subject: [PATCH] cpufreq: Limit resolving a frequency to policy min/max
Date: Thu, 22 Feb 2024 14:05:15 +0530
Message-ID: <20240222083515.1065025-1-quic_kshivnan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: c_Pn0TXMvAFxGOdkq490IRMQQALF-utb
X-Proofpoint-GUID: c_Pn0TXMvAFxGOdkq490IRMQQALF-utb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220067

Resolving a frequency to an efficient one should not transgress policy->max
(which can be set for thermal reason) and policy->min. Currently there is
possibility where scaling_cur_freq can exceed scaling_max_freq when
scaling_max_freq is inefficient frequency. Add additional check to ensure
that resolving a frequency will respect policy->min/max.

Fixes: 1f39fa0dccff ("cpufreq: Introducing CPUFREQ_RELATION_E")
Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
---
 include/linux/cpufreq.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..42d98b576a36 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1021,6 +1021,19 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
+static inline bool cpufreq_table_index_is_in_limits(struct cpufreq_policy *policy,
+						    int idx)
+{
+	unsigned int freq;
+
+	if (idx < 0)
+		return false;
+
+	freq = policy->freq_table[idx].frequency;
+
+	return (freq == clamp_val(freq, policy->min, policy->max));
+}
+
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
 						 unsigned int relation)
@@ -1054,7 +1067,10 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 		return 0;
 	}
 
-	if (idx < 0 && efficiencies) {
+	/*
+	 * Limit frequency index to honor policy->min/max
+	 */
+	if (!cpufreq_table_index_is_in_limits(policy, idx) && efficiencies) {
 		efficiencies = false;
 		goto retry;
 	}
-- 
2.25.1


