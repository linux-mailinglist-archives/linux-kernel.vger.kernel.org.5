Return-Path: <linux-kernel+bounces-137273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630B89DFC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A7E1C229A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A713AD3F;
	Tue,  9 Apr 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="VVAUIcWE"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA513848D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678101; cv=none; b=iBs3C2C+QSpTN+kGA4mul9Dtuc4F7ovu64AeUYhNKMZG8ZJjDLD9f+35rj6FuYyrdCHkdhpKped57FKftCyB28b3yyaz+MII/6cnVxuIsGzcAIH/9TVCoLqtax0M+2z0VS6FOy5A/DP5Mb6CVo5ZIta8dLccbdxvYM4/CGICIwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678101; c=relaxed/simple;
	bh=zMoMI6Y8NnIAGXZYelYaCmAhdyyFcFxPl/znHIrKb24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p9h8aVA5HUa6Y4C3I4q+R8TC+aI0VBEyje0rqKSxiVf28OSzVh7CRFSjy8gmPXRMcwBJ9rCUw7N67d+dvu04J3n/1L/s43LfBi00gY4d4NKfgncLeGn/6aXVjNAxDsavKIcwDCADAfsVHHa/aV/FgKSm8WMboHvn8Inr145b+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=VVAUIcWE; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439D4fFp008513;
	Tue, 9 Apr 2024 15:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=0O4+3qEWm9jlR2SK6bIrORu+/O4WDfq7PBhv/s3MeKE=;
 b=VVAUIcWEfk+4SR4IlXrLhTcJv+9QG40AA0xiWkrH95PlEvkHDZIF5lhfSPseg4Wq7NaE
 9BtTo8akcZ11br2KseKxPWFh7UPE7puUeg/smvFuot1D8+FMttNZV6IxnQ1HL164O0ge
 vsODoy1xAWhhMuf+u1OU2T/SNzWC1u9Thqq2AZynKswm1OjGCHAm55vlA60y9ROcZOGC
 T6Cub9fpqqsbfOB6Uk7VY4DOH0hqk9u/RgZ70zBim328PmB0RlBw7iqDJ8pDH5UN0Sfk
 BsSeOaeqdQWokXsu2wWovPhW8uNhBbjfyKFFBPAFPoGDyl+IoUi/nsoT/20kTpjlzVjI tw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xd5xshg61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:54:08 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id F07D680034F;
	Tue,  9 Apr 2024 15:54:06 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id D00EF800ED5;
	Tue,  9 Apr 2024 15:54:05 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id 32EC1302F4723; Tue,  9 Apr 2024 10:54:05 -0500 (CDT)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc: russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH 0/2 RESEND] sched/topology: Optimize topology_span_sane()
Date: Tue,  9 Apr 2024 10:52:48 -0500
Message-Id: <20240409155250.3660517-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cHKAOqpP8mztbiGfrAHVRihXOfHyp258
X-Proofpoint-ORIG-GUID: cHKAOqpP8mztbiGfrAHVRihXOfHyp258
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=450 suspectscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404090104

A soft lockup is being detected in build_sched_domains() on 32 socket
Sapphire Rapids systems with 3840 processors.

topology_span_sane(), called by build_sched_domains(), checks that each
processor's non-NUMA scheduling domains are completely equal or
completely disjoint. If a non-NUMA scheduling domain partially overlaps
another, scheduling groups can break.

This series adds for_each_cpu_from() as a generic cpumask macro to
optimize topology_span_sane() by removing duplicate comparisons. The
total number of comparisons is reduced from N * (N - 1) to
N * (N - 1) / 2 (per non-NUMA scheduling domain level), decreasing the
boot time by approximately 20 seconds and preventing the soft lockup on
the mentioned systems.

RESEND because Valentin Schneider reported that PATCH 2/2 wasn't
delivered to all recipients.

Kyle Meyer (2):
  cpumask: Add for_each_cpu_from()
  sched/topology: Optimize topology_span_sane()

 include/linux/cpumask.h | 10 ++++++++++
 kernel/sched/topology.c |  6 ++----
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.44.0


