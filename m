Return-Path: <linux-kernel+bounces-44683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC56842615
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017FDB257C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6986BB2B;
	Tue, 30 Jan 2024 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYZIrhXs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359E6BB5E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620463; cv=none; b=sKzmKby78639TpT3lkouhvX7T5Ev2QObRDPn7CEl290gj0DWyvzEXqPDPopjQQJQqOHpJrKVbVMLS/JdkT4TERr6z12/7xwc38zp58Eqh5+xXV2ysF6wTfvkKFsv/d9qdpBefPfeg9cQ87bnFSKEqJosH0N8bhX152LNGifFfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620463; c=relaxed/simple;
	bh=yCvjq75MG5lal2aoR5CJIjlQvsuAuYZd+/xwaBRiyWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlTzQ8zQ0uL7vZCRqBT3T1cAZJhPN4CsMD149I46zVHUW3xrbbLurm5fOI8duUlp4EyNCRHDW3Y+knp9fHNI10wtZGb/ETuuIc2ScYtNnaunjumnjxySETumf3a8VnJ8/JTkZZXZo1fobMmuyc0CUJzloVoXpooxml3SHrJznjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYZIrhXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD65DC433F1;
	Tue, 30 Jan 2024 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620462;
	bh=yCvjq75MG5lal2aoR5CJIjlQvsuAuYZd+/xwaBRiyWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYZIrhXsCkivSFCFCcqxyVyfyBW5b32qzmemiHnXjllfQMguGWygoJfX/s3xJgKIQ
	 Npk7xj+iJ3VRzPWbadCThqwUiEC4xHfb+VOHYVKE3Zfc47MmebtPd/xKLhzfIn5u2A
	 +f3z9UIcYfOK/3kw/XFQ5W3LLxwtax9MhDdFCd6YaUNwNuWWeoOW8YQezXKyPPzDVA
	 A9K255xR7tf19UwM89aIJQoIZmwNXTNVLNycEZMgdxOQJDObJn0yyeYqHCkA30dSub
	 j49KSh4mkRQFetWdnR2Mr9dhYKM50Lh8lWT8ap0YJGSBBaK0rbhuPG2AtLr3M907tZ
	 WpbT9c8ajIANA==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	ricardo.neri-calderon@linux.intel.com,
	sshegde@linux.ibm.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v2 3/6] sched/fair: cleanup sched_use_asym_prio
Date: Tue, 30 Jan 2024 21:17:05 +0800
Message-ID: <20240130131708.429425-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130131708.429425-1-alexs@kernel.org>
References: <20240130131708.429425-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

And simplify the one line code. No function change.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8d70417f5125..ebd659af2d78 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9741,10 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
  */
 static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 {
-	if (!sched_smt_active())
-		return true;
-
-	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
+	return (!sched_smt_active()) ||
+		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
 }
 
 /**
-- 
2.43.0


