Return-Path: <linux-kernel+bounces-83658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA92869CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB515286898
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7147F58;
	Tue, 27 Feb 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UGvvmZQ2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3D20B38;
	Tue, 27 Feb 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052852; cv=none; b=YyQ2XikuSVlAlmhmZ/2N/MR51rpZ6WaZx7fhbV9LRAYCxtn4N/GrmN/uHDORCJipt1+6q6ff3O550vg4w2cCOnJXOY7y90xiYXaNpQ3Q7T5kiulCs0pxgq7vFtkA7cOEhORNqRLVa8AVBw4wyZu2fOpscoAOcsfAOw6Gn2mkaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052852; c=relaxed/simple;
	bh=ORmW0WBG9KWPvbCXc8G4LCpMmf42CvrygThu8ao8NgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVl9UNjRIfJl5wmbkIjmMtp6PFOhwlSU8Va0+Nc8gDlQQxLQzb795KODBc6EbPCFZmN1/nlI6PPfPr4rQdFNuTmCqxK6Xp3Kx6zv0vyuTBPShWRNCJRvUzRxICAeDQn+Qt9nUaObZoK7SGbMwwo+yw4QnWgqAzvX4kjjQQ4tP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UGvvmZQ2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RAto7V008656;
	Tue, 27 Feb 2024 16:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Xp1rHqH7daGk6V3hwTqtNayvUghKARCkNNKi0hgJW7Y=; b=UG
	vvmZQ2ILsxzeyqYBfNToIyqjiUgdKhtT5TGaG0nn9q9KjZxIZxT6S6bhzaWNrsgq
	PvT5H1avgvRGBNj6d6QAt8YjJZcCitYb5Nus4CGvj2Bh2/pLaUz36Rp4J2nURc4b
	LHyrM14EjaPOETb524qb97iQMksUMgcCGpKXcw6SuXhxNrTt+oJnvQ6CqJ11JI83
	HCbx1Flno1CCuMYqiUrcxmDbT7VFcEq1E2RQfn7NEQnwvRnHjrALMLQhMyAxe3vv
	8ne10xnajE/CrtHP1YDoBnYW42YTcu5Yjq1wDZWlSqd1oAVcLhCmhm4ZGnmpInud
	RXHCES4xAazM7BeJxlaA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whedvrw05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:53:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RGroFU008292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:53:50 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 08:53:45 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <dietmar.eggemann@arm.com>, <marcan@marcan.st>, <sven@svenpeter.dev>,
        <alyssa@rosenzweig.io>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <xuwei5@hisilicon.com>, <zhanjie9@hisilicon.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <asahi@lists.linux.dev>, <linux-pm@vger.kernel.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH 2/2] cpufreq: apple-soc: Align per-policy and global boost flags
Date: Tue, 27 Feb 2024 22:23:09 +0530
Message-ID: <20240227165309.620422-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227165309.620422-1-quic_sibis@quicinc.com>
References: <20240227165309.620422-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: GVzO79U-yeiPTRFZ4WX9MhuCVs55PVoh
X-Proofpoint-ORIG-GUID: GVzO79U-yeiPTRFZ4WX9MhuCVs55PVoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270130

With the cpufreq_driver.boost_enabled flag set by default, the per-policy
boost flags are left in a disabled state. Fix this by enabling the
per-policy boost flag by default on policies supporting boost.

Logs:
root:/sys/devices/system/cpu/cpufreq# cat boost policy*/boost
1
0
0

Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 021f423705e1..b85c250e30d0 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -289,6 +289,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 		} else {
 			apple_soc_cpufreq_hw_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 			apple_soc_cpufreq_driver.boost_enabled = true;
+			policy->boost_enabled = true;
 		}
 	}
 
-- 
2.34.1


