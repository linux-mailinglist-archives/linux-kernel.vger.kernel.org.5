Return-Path: <linux-kernel+bounces-96444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B53875C4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F03AB21F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12A23757;
	Fri,  8 Mar 2024 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PHK59pfb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA3E139F;
	Fri,  8 Mar 2024 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864325; cv=none; b=N8juqPV/s3lJyAxtJaSMOnCZfGPnZF5suexejcr1ZQpeSCNHRBARXfQfD4ociZjakUajeQGGJ1UljH2gMIOsmfpmE+XT3GyQwRVE0k/lwwkDPX3+VUgh15oa20s/zyGPPW12amf705qud+SxUFMPgL3Up9wqvJoHuqS0IPf9Gz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864325; c=relaxed/simple;
	bh=bywYpKyGb8Sirxl0IhlArhlGMgpB8tAblYWIh3Sho5w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4lCfQ5z4AERtStWI3R7RKa+tfXcF/4zgZx90ruv6TtWWTo/v0bQGbZko/EyqUtHVgp91Kuh4yTM9HJly7GBuh1sk6o9p9J3DkOq4gntBMIj48zE05wk4Hl4qKpeO2YTlL5KjZTWxX5GuWq0E1hDF22I83PAj6MljCFIngt5vMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PHK59pfb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4281If8J004043;
	Fri, 8 Mar 2024 02:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=W39k49f
	Y0eK5MNpdhOpAeNh7xbdfZg2QC+MT/mSBsiQ=; b=PHK59pfbc1nl4EUDl/cY+ev
	Yq7xyDRpTPfIWGbB2guZ+1ijWiR+QeoLXw98vAlq6CHrAu6/FesDF8s5xf/UUgjd
	AfBc9XBxcA89z708zpYpVDT+6OI/C+GgQdoDCR+ClbaN1uj8PfQ3gKQwhPu2bocD
	oa6KMwdCrlKVvYT1YExsmPCEGk656tGG7gej3lnn+eOZhT8jwDMcws1DDHy4WHsj
	zzAuHvDANUf6Ao7+Z9/Cv1tXgmnl7d2YxsnxL3yRJpGNMoXxz7Q0KAGK/vMCrjmZ
	rapfaxMIelD78Awx7ptmwSn7SaAwcebnl6XFm0dYstzB9tTr91WzRn7sab7YUxQ=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8n8gny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 02:18:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4282IVSv016858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 02:18:31 GMT
Received: from maow2-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 18:18:29 -0800
From: Kassey Li <quic_yingangl@quicinc.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC: <quic_yingangl@quicinc.com>
Subject: [PATCH v2] workqueue: add function in event of workqueue_activate_work
Date: Fri, 8 Mar 2024 10:18:18 +0800
Message-ID: <20240308021818.2306176-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tmbZ4J3a6OyeZu8ZJMcomtVxBBmTs2FI
X-Proofpoint-ORIG-GUID: tmbZ4J3a6OyeZu8ZJMcomtVxBBmTs2FI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_01,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=880 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080017

The trace event "workqueue_activate_work" only print work struct.
However, function is the region of interest in a full sequence of work.
Current workqueue_activate_work trace event output:

    workqueue_activate_work: work struct ffffff88b4a0f450

With this change, workqueue_activate_work will print the function name,
align with workqueue_queue_work/execute_start/execute_end event.

    workqueue_activate_work: work struct ffffff80413a78b8 function=vmstat_update

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
Changelog:
v1: https://lore.kernel.org/all/20240308010929.1955339-1-quic_yingangl@quicinc.com/
v1->v2:
- do not follow checkpatch in TRACE_EVENT() macros
- add sample "workqueue_activate_work: work struct ffffff80413a78b8 function=vmstat_update"
---
 include/trace/events/workqueue.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 262d52021c23..6ef5b7254070 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -64,13 +64,15 @@ TRACE_EVENT(workqueue_activate_work,
 
 	TP_STRUCT__entry(
 		__field( void *,	work	)
+		__field( void *,	function)
 	),
 
 	TP_fast_assign(
 		__entry->work		= work;
+		__entry->function	= work->func;
 	),
 
-	TP_printk("work struct %p", __entry->work)
+	TP_printk("work struct %p function=%ps ", __entry->work, __entry->function)
 );
 
 /**
-- 
2.25.1


