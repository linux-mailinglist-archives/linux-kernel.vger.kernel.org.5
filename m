Return-Path: <linux-kernel+bounces-158682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E08B23C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4EF1C212BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A314A4F8;
	Thu, 25 Apr 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq2MEd/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925714B07F;
	Thu, 25 Apr 2024 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054725; cv=none; b=plSO4qk/OghDzLTwqOWgY+fqrEmY9WcVq/TY02cPzh9TgYrsUBY7YO8NwprEBhj6C1SVZ5Jo9dfF4lhEOK5FAggND+t1TnQDU5R8hu8WxVjQywny+X5F3M0AJzvIP01CrBFRpdQBIUxaISHFYXM6uSriRycssDz74/G02uTh7C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054725; c=relaxed/simple;
	bh=wr/k54/ZbmkJrW0gFVZmsbDqX6q/04QoSGB4f9Qio68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/yESSODd4nyMsHXbhOfLMRUsEMhEBNU+edKY775tmBcai7++g7pm/8cPC1DiqRW0p9iVayHz9bN+akKxgAelaTD9cxPhJR/KV2zzqknTvzoEQxt6yJZED0IjmQvGBAX8vSgwNPq61Y9hPXLXGDrBubceDo+Yc5NxXDhv9YMP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq2MEd/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9B9C3277B;
	Thu, 25 Apr 2024 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714054724;
	bh=wr/k54/ZbmkJrW0gFVZmsbDqX6q/04QoSGB4f9Qio68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uq2MEd/VbFTsTKhY/bgmCW/Dsfw62uIx7LwnY0NMPiED+g0w52R+vS3XyFRQi6Qsy
	 o4YoaSu+3eQai48eccTaQaeOyT8sYAMU6agb2dXPrGM+PiNkWEwBvaU1eOEgI7xlrW
	 4KtKcDbR1Rs2wExkTQs7DTHISPF0t+o5tj5e5zPdOJPpcES16Lihw0HOs3tUNk4LJP
	 1elMI/BQsGh3bWZozn9QTILN29UAJ+lGvCxcf1XOypuGQcUm+i3PG8wktk1Va+PjGO
	 9XcnYWA4JzhabA5oRTlC3zejvXh3aL/rklavhhEeoBl01iw0I38u8GoyHCzfOBtzXi
	 +E4zMjy6ICdgw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 2/4] rcu/nocb: Fix segcblist state machine stale comments about timers
Date: Thu, 25 Apr 2024 16:18:33 +0200
Message-ID: <20240425141835.19776-3-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425141835.19776-1-frederic@kernel.org>
References: <20240425141835.19776-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The (de-)offloading process used to take care about the NOCB timer when
it depended on the per-rdp NOCB locking. However this isn't the case
anymore for a long while. It can now safely be armed and run during the
(de-)offloading process, which doesn't care about it anymore.

Update the comments accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcu_segcblist.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 1e5b4ef167ca..8018045989af 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -80,8 +80,7 @@ struct rcu_cblist {
  *  |       SEGCBLIST_RCU_CORE | SEGCBLIST_LOCKING | SEGCBLIST_OFFLOADED       |
  *  |                                                                          |
  *  | Callbacks processed by rcu_core() from softirqs or local                 |
- *  | rcuc kthread, while holding nocb_lock. Waking up CB and GP kthreads,     |
- *  | allowing nocb_timer to be armed.                                         |
+ *  | rcuc kthread, while holding nocb_lock. Waking up CB and GP kthreads.     |
  *  ----------------------------------------------------------------------------
  *                                         |
  *                                         v
@@ -183,8 +182,7 @@ struct rcu_cblist {
  *  |                SEGCBLIST_RCU_CORE | SEGCBLIST_LOCKING                    |
  *  |                                                                          |
  *  | Callbacks processed by rcu_core() from softirqs or local                 |
- *  | rcuc kthread, while holding nocb_lock. Forbid nocb_timer to be armed.    |
- *  | Flush pending nocb_timer.                                                |
+ *  | rcuc kthread, while holding nocb_lock.                                   |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
-- 
2.44.0


