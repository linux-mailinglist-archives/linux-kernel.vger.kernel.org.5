Return-Path: <linux-kernel+bounces-57752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811D784DD03
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B051C22C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5976BFA9;
	Thu,  8 Feb 2024 09:32:44 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05E6BB2F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384764; cv=none; b=i+hR/F3bZ2fVTb5Tne9cDsJMtr2LkzFmGhDd5ATi13Bi/qaAM6yZfs8V/4OkXXylOaDvurJXIODW6i/pUvH/WdX4GqDWtdPQp6kFqeBtoBiFVTC3DiIDBTkpA3vo5vv7A9hJG3J76cukYvIjhJsAOLVVq3OLxW7wSb3D7OOTs+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384764; c=relaxed/simple;
	bh=77RDjA7vu16sLKzoTYcGU4lvILnaItQ4kSRq9AXWhwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3f/KijE2Gew/xbBWWfEDAJNPLW1sx70aAvG2aZEv55RY5m2m2eZP568vQH2fib14Emf9qohqFoRlOrjw500TulKanh+gcak0si9iy/NDx9k8Fiv5023VyzK+y81begq6BxvSLA4N9nCmscBM8NCdpa6DNwL7LyXE77mrcr7sxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4189VnjY048930;
	Thu, 8 Feb 2024 17:31:49 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TVsF769WXz2K4gjP;
	Thu,  8 Feb 2024 17:31:39 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 8 Feb 2024 17:31:47 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
        Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent
 Guittot <vincent.guittot@linaro.org>,
        Yu Zhao <yuzhao@google.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 2/3] sched: introduce a macro for getting approximat CFS part of a timing value
Date: Thu, 8 Feb 2024 17:31:35 +0800
Message-ID: <20240208093136.178797-2-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4189VnjY048930

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

A timing value within CFS task could be deemed as being composed
of CFS part and RT part(preempt by RT). We would like to know the
previous value in some scenarios. Introducin a macro here to get its
approximate value by means of CPU utils.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 kernel/sched/sched.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b0cffc9c0f0d..a6f0051d0b15 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -179,6 +179,16 @@ extern int sched_rr_timeslice;
  */
 #define RUNTIME_INF		((u64)~0ULL)
 
+/*
+ * val is a period of time which composed by CFS part and RT part from CPU's
+ * point of view.
+ * This macro provide its approximate proportion of CFS part by remove the
+ * preempted time by RT.
+ */
+#define CFS_PROPORTION(task, val)               \
+	(div64_ul(task_rq(task)->cfs.avg.util_avg * val,                                \
+		  task_rq(task)->cfs.avg.util_avg + task_rq(task)->avg_rt.util_avg + 1))          \
+
 static inline int idle_policy(int policy)
 {
 	return policy == SCHED_IDLE;
-- 
2.25.1


