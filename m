Return-Path: <linux-kernel+bounces-116113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3578896B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DF1C305FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB43AB7AC;
	Mon, 25 Mar 2024 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCep375C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E64C2801F7;
	Sun, 24 Mar 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323632; cv=none; b=bmehlgJK4dZnn645HFoBO9mGmJz6J6gvTw7lUsV6aOemYNWbzmKdI2BvaVaxcU2UuDuh+97ErOMB37Mq2XRfPLXbKvPWwTz62EBt1AKrpWvGRPUwlxljfPozaNtL/a0FM3MawG5fuwQlHAEIKxLWfCWZgor3vyrdAxIZRf8XIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323632; c=relaxed/simple;
	bh=oD17ofTA2Z/4lB9MfJbdZTrDP3Xqo6BRlFf4yaezyaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zghl3Wl8IGEsSgOs1RTxGbvwL5PTb6at89aPClJk9dOJGo2CNob+ShuWn7SJXdIXQ6G3R2Ey0VLTEq8sK+TpGrrXXWFfeU/fHTB7a6PwMaZxb1dsGvFnc1TuLikvMNgpS7vvIZXhrMJMu2KHqOs8DRqC+FkL7XqJZLNUhnR+xr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCep375C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298FFC43394;
	Sun, 24 Mar 2024 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323632;
	bh=oD17ofTA2Z/4lB9MfJbdZTrDP3Xqo6BRlFf4yaezyaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCep375CE6YNV1yR3a3TcXYpMoIsLj1BjjiwJvp/AqTw72qSxO595Q8VkV0YsR6xI
	 jY8s38dhhCG6VMYoRQREZ6SGGnrwT9YCsi1zmtwIMWTwy0l9KeQsS9E7TOrtxUEB0V
	 A6iFExh1BwUEvRblFf8n3ak9k9QMAqFhWTEtra9ReGbmj92Tm+FMKRqPhBpcDvWomk
	 aI97x+ETqoGDM6lO/MOH1hVGqUHs8tJgN1YmpcPKVnVHbzGz/FX/THNVg827PuKtPs
	 bfAJWFz1CWHZh7quVtNRHOnWrswg1TKrTci5KrJwIU3WYl5+YpYneicXLhF5+gD99w
	 DVHSmPjKPtBsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	Robert Kolchmeyer <rkolchmeyer@google.com>
Subject: [PATCH 5.10 003/238] rcu-tasks: Provide rcu_trace_implies_rcu_gp()
Date: Sun, 24 Mar 2024 19:36:31 -0400
Message-ID: <20240324234027.1354210-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 8716a17063518..0122c03da24af 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -201,6 +201,18 @@ static inline void exit_tasks_rcu_stop(void) { }
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
index c5624ab0580c5..105fdc2bb004c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1015,6 +1015,8 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
+
+	// If you remove the following line, update rcu_trace_implies_rcu_gp()!!!
 	synchronize_rcu();
 	// Any tasks that exit after this point will set ->trc_reader_checked.
 }
-- 
2.43.0


