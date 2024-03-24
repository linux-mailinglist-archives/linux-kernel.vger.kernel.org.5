Return-Path: <linux-kernel+bounces-114721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429CC889220
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D921F2D0AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD219DF63;
	Mon, 25 Mar 2024 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt8uQE8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E32720E8;
	Sun, 24 Mar 2024 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323304; cv=none; b=hKCqiSZPQHbBrK86LQUX0Tyq9c9h+6rGkPPLW9x/v4PaWivbwHW9UmQaoND52dIJ4PeHGASATZhHSmCCQMW7UW/ekemGX7ZRvFOz26S80GvFiRJ9txtvwZhEOB8iDSVKBcUld+daFT9yENRmQgfJMdtUh+ShEjq/72lk4LKqkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323304; c=relaxed/simple;
	bh=XKTmuBbNGSq3qZq3k0AUkJ2Hx5fh0J1VoqUv/mzSn9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrR+m8REJQRw7Otb0Qkfard3WNtOSR4oGkrnZP9oxfMoXv+L9UyeQp+DPiOkd3fRUNvLtjjXvsCymUuKlbfcq0ii1pAYrJjLTs+R6ZFBTgM/ChcRTVfJuixCyOZs5aUR8BHPidWEIGCgSN6b9WCED8Rke7mJQ5ltLoUofN7kna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt8uQE8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66730C433F1;
	Sun, 24 Mar 2024 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323303;
	bh=XKTmuBbNGSq3qZq3k0AUkJ2Hx5fh0J1VoqUv/mzSn9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rt8uQE8VRLnOPx4T9F9BoqD9BDPG3Ge6wtvgXYDAIofg93jfgMk+JVH3LJrbbvb4W
	 xYqPOGP03LQoOZcG824h5iDGvjNM7AoHdw2OioAyliU1BJT7WRQkFMf8OvF502Snxc
	 tOeRuUFfV5b2FEwVgJqFZtJb4JeTaCK4paiCRUnkz8Rak9DpvGI2CBciKZIYusA+mg
	 pyW2Iu7qGXd0PYpXlHjbNHYAi4OSTmOxKXWYBDVnMT56PUBr2ooQQgFwwYmPjqGcqp
	 ZCg7F1KsBWsRFH4eYXMSrcA827PGvIm0YiQPffYkWgRfcCC/asnRZ6FFug9kTobTZe
	 mIscEe+ZduHJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	Robert Kolchmeyer <rkolchmeyer@google.com>
Subject: [PATCH 5.15 003/317] rcu-tasks: Provide rcu_trace_implies_rcu_gp()
Date: Sun, 24 Mar 2024 19:29:43 -0400
Message-ID: <20240324233458.1352854-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit e6c86c513f440bec5f1046539c7e3c6c653842da ]

As an accident of implementation, an RCU Tasks Trace grace period also
acts as an RCU grace period.  However, this could change at any time.
This commit therefore creates an rcu_trace_implies_rcu_gp() that currently
returns true to codify this accident.  Code relying on this accident
must call this function to verify that this accident is still happening.

Reported-by: Hou Tao <houtao@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Link: https://lore.kernel.org/r/20221014113946.965131-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 876673364161 ("bpf: Defer the free of inner map when necessary")
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 10108826191ab30388e8ae9d54505a628f78a7ec)
Signed-off-by: Robert Kolchmeyer <rkolchmeyer@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcupdate.h | 12 ++++++++++++
 kernel/rcu/tasks.h       |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 13bddb841ceb1..e3b12de36e924 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -205,6 +205,18 @@ static inline void exit_tasks_rcu_stop(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
+/**
+ * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
+ *
+ * As an accident of implementation, an RCU Tasks Trace grace period also
+ * acts as an RCU grace period.  However, this could change at any time.
+ * Code relying on this accident must call this function to verify that
+ * this accident is still happening.
+ *
+ * You have been warned!
+ */
+static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
+
 /**
  * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
  *
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 28f628c702452..b24ef77325eed 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1098,6 +1098,8 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
+
+	// If you remove the following line, update rcu_trace_implies_rcu_gp()!!!
 	synchronize_rcu();
 	// Any tasks that exit after this point will set ->trc_reader_checked.
 }
-- 
2.43.0


