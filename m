Return-Path: <linux-kernel+bounces-101056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E314487A1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208CC1C21CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B91AD5D;
	Wed, 13 Mar 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o/77wRxB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFEF10A01
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297628; cv=none; b=cF6jO6Uye5goRk1f8C3XD3fxbF81IYxFamJ8hQmHcorrKRuyBicwFiNJMyJZ6fvTfqmAGF1xfoXZHP7uFPtbbFKM4lKiyucn9X4mPUZuW3qw0K9v1KgVMfE7MKGMB3xrHSs/d50tSriSgBXlh+NRoDOLASA08PEuoM7vwbM6mfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297628; c=relaxed/simple;
	bh=+K/FKfti3Nj0kOhpdCUwG016PJqeTd53qMAjVG593kc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kIjezO/Lpu7oq+EeBuSGhrd+kgFPTCaYhiLnpOu+GiVZHSM3gnwTQLDeYSUymKi5IG8tF15mkLbOrRnlvx8SDtAKm6OyzGpj34h6o87ceUXG9fjRWgTzkFZPzQF3kdzqtzzo4QLdsngj60be7Njx5qbkyEpzPv8p6KbZhnPcVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o/77wRxB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D0i85g030836;
	Wed, 13 Mar 2024 02:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=nuZQdTp
	E8n5WXrtvuYHG2CjC/2zEP82Dx6wnYshTNNU=; b=o/77wRxBtU8IzRJYQjqlGE+
	PHbWyvGBFK8n3d8PGg4lFuFerY70wj/n53BFxzkPUpC4zVa5JhjK+6Wm8BpPtg3X
	5eOi4+ZyFoG0RdOHE5zdAjaKAOT6gHY0KEegYhvXCCqtiPl2anXfA6xs8mGjZK5C
	8OlEW4UTP+6Zf6c+oo8CgJ4TqoShUehxKugnqpqQVQbqSsygMK8fht3nYWU9E+Z4
	92plBGYJ5nd+07yB7oXHwiI/NSckUekqd5YxhRA4iYH+tjncosgXr1Xw8KTX5uih
	CwtwnP50KY+jvuWJw1KlmvaElvM9WfIdjdQOOdByFqdl+Ewhvu5nuOrT0DJ4tBw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtw3h0svw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 02:39:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42D2dh0E020109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 02:39:44 GMT
Received: from maow2-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 19:39:41 -0700
From: Kassey Li <quic_yingangl@quicinc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
CC: <quic_yingangl@quicinc.com>
Subject: [PATCH] sched/headers: do not set last_queued to 0 in arrive
Date: Wed, 13 Mar 2024 10:39:20 +0800
Message-ID: <20240313023920.3338035-1-quic_yingangl@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ysbnF2eIhVX6v_3zmWJ3gjf5o8LWpXW8
X-Proofpoint-GUID: ysbnF2eIhVX6v_3zmWJ3gjf5o8LWpXW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_02,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130017

The pcount accounting for Task A missed in the step 4:

1. Task A enqueued
2. Task A arrive and hit CPU
3. Task B arrive and hit CPU, preempted Task A, Task A is still in rq
   as TASK_RUNNING
4. Task A arrive and hit CPU again.

This change leaves enqueue/dequeue on last_queued only, and
correct the pcount accounting.

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 kernel/sched/stats.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 38f3698f5e5b..3decd2261875 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -229,8 +229,17 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 		return;
 
 	now = rq_clock(rq);
-	delta = now - t->sched_info.last_queued;
-	t->sched_info.last_queued = 0;
+
+	/*
+	 * last_arrival > last_queued means a task in the rq, it is not the
+	 * first time hits the CPU.
+	 */
+
+	if(unlikely(t->sched_info.last_arrival > t->sched_info.last_queued))
+		delta = now - t->sched_info.last_arrival;
+	else
+		delta = now - t->sched_info.last_queued;
+
 	t->sched_info.run_delay += delta;
 	t->sched_info.last_arrival = now;
 	t->sched_info.pcount++;
-- 
2.25.1


