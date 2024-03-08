Return-Path: <linux-kernel+bounces-96418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C427875BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBD31C20F3C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A59224EC;
	Fri,  8 Mar 2024 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PKb8h0YU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B3219FD;
	Fri,  8 Mar 2024 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860222; cv=none; b=cQ68fT0da4xeSw5H3Zk9WnCFL8ZELpvQeu21KqBXsjBwR7VJq6dHIwgRPBYRDdPT7gtTzQaKfYhdvKnU53ba82hNBfRj8Q5wo0lbgN3iTc13AgCj8TUzepy5L9RDIHv6T4JH6aHwAj+Di/stvq+i+FJA6nXWz/oq7tVnlXUTiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860222; c=relaxed/simple;
	bh=gsq1qaqDZuKtkZEjmhFcNJ0Oz98c/gwFuViMAOndml0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mMrbCnMbABD1sMJV8y4sJvmnol5VTAitZ4RcH9p7HBjIVcphz9ia9H41Nx2PaEvZzQkD8+BTWcyGWKFV7lrr0B4wp9qNFgKWkzT3w9F10+8evM2ih+dSTM7iZI0QuVZ0eLpPYRHYvEeavm5rSJInATOkrzhChZ6ovbGT1FKYLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PKb8h0YU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4280iOKF018041;
	Fri, 8 Mar 2024 01:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=1FOBliT
	XVZjNoR4w147dMcGdIAtKZY7dRZ/ierdbGAI=; b=PKb8h0YU/XHmVnTLthmIxcK
	gns1wRl0DQHBboluNSOmW71kMYpUF8onH6cAeV9CUGI0dKlrJqueRsiMWwTMXaNF
	Fizb8n8S+JCj6y8U5hrDrgPaLG3G5MWHzk69wbfs8SWtz8GSEJt9fm48aFlOGNYN
	w1L29pYyRoQ73qIYOOWV9OPB6BJuquYr+u8d1ZYKFzv8oDPIwNiZ6KHmoAoMbb6v
	AsGlgEwoFuLCEPy6UoRlsdP8fL4n/j2mh82ICjrcNc39sPPO/oAj/VhyFty1FpXO
	EQc528JzF/cOOG6eX2tra80UZQ/oA2wvq/r/FCm4c2kgzN0IH9sohIPf4cfn9Yg=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8qgd4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 01:10:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4281A7qV000484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 01:10:07 GMT
Received: from maow2-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 17:10:05 -0800
From: Kassey Li <quic_yingangl@quicinc.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC: <quic_yingangl@quicinc.com>
Subject: [PATCH] workqueue: add function in event of workqueue_activate_work
Date: Fri, 8 Mar 2024 09:09:29 +0800
Message-ID: <20240308010929.1955339-1-quic_yingangl@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bLgoSJfrZTGi0izl7Ov7QcWYirb5-T75
X-Proofpoint-ORIG-GUID: bLgoSJfrZTGi0izl7Ov7QcWYirb5-T75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_18,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080007

The trace event "workqueue_activate_work" only print work struct.
However, function is the region of interest in a full sequence of work.
Current workqueue_activate_work trace event output:

    workqueue_activate_work: work struct ffffff88b4a0f450

With this change, workqueue_activate_work will print the function name,
align with workqueue_queue_work/execute_start/execute_end event.

checkpatch.pl will report below error for the space:

	ERROR: space prohibited after that open parenthesis '('
	#28: FILE: include/trace/events/workqueue.h:67:
	+               __field( void *,        function)

	total: 1 errors, 0 warnings, 16 lines checked

fix this error.

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 include/trace/events/workqueue.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 262d52021c23..a42c1a293459 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -63,14 +63,16 @@ TRACE_EVENT(workqueue_activate_work,
 	TP_ARGS(work),
 
 	TP_STRUCT__entry(
-		__field( void *,	work	)
+		__field(void *,	work)
+		__field(void *,	function)
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


