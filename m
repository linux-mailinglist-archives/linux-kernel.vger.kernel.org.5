Return-Path: <linux-kernel+bounces-124901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB3891D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786261C25F01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925812609F5;
	Fri, 29 Mar 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa6M9Fy0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B492609CE;
	Fri, 29 Mar 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716397; cv=none; b=NzvLP2CgZABDEHnoOtygJQUizSv2jG4dCBwPxj5BbdXJMKrGlLyZTydFJ0w3PyCnO6HfHyLoRYcGSRl+EEAWYLebWFyOzTip82KtHYGbJ4HIKDRsCpWpXH4f2or3DnL8GTUUsOa2fTIIEFKYgdejnEMaXwoZk3Zc+0RXwdhTRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716397; c=relaxed/simple;
	bh=WPIjX/2qHFPCedFEYL9s01CISXiCP6wWXcAuXar04gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tR2f+ANVOH9Lr23F+APO1Lzibbq7d7/pn31vZ9P8dMOVpPuWzWITDB2qOYdXf8/HY+I4iVi/LCJ2x4s9k5E8EHJEII4YVQ7u3X+Mi1yU09KzKoAazx/xAuJzUsfmF7qv/AmUVruU5M6AqHMV07Nro0zuwJZVZs/o3oZcB9gnej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa6M9Fy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A84CC43399;
	Fri, 29 Mar 2024 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716397;
	bh=WPIjX/2qHFPCedFEYL9s01CISXiCP6wWXcAuXar04gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xa6M9Fy0/W9SWHw7WEcLTfKnkR4PbZHdLvpkMjdFNkIpq3Z0JuM4dE9AZ1KV0snVq
	 FnQQiGWOWtOj1G1B9h11gGorPIx5Vzbt8LR8G1BB3A/CZ+8dQUk86muSpAyqGuVOTI
	 XlHOUduZboRobQhTZB6FZsHb5M7cpJ1nyvzWgmqzlwe4W/y92byaOtRAJO6p49FTR6
	 2Erk52wSakRg4kCICrld7wg/LNgCpiV+vhNpEiyK/S6pxvQQeAe7GxbI7oIO5levbl
	 JDTyAZUB+XxLIrBT10XHwXq7IQ6UyQd5DJHd5Ol6Xn8wz0Oyv+Mvyw6Ywd9TcEmVly
	 quIvljZLZgTTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	frederic@kernel.org,
	quic_neeraju@quicinc.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/52] rcu-tasks: Repair RCU Tasks Trace quiescence check
Date: Fri, 29 Mar 2024 08:45:11 -0400
Message-ID: <20240329124605.3091273-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 2eb52fa8900e642b3b5054c4bf9776089d2a935f ]

The context-switch-time check for RCU Tasks Trace quiescence expects
current->trc_reader_special.b.need_qs to be zero, and if so, updates
it to TRC_NEED_QS_CHECKED.  This is backwards, because if this value
is zero, there is no RCU Tasks Trace grace period in flight, an thus
no need for a quiescent state.  Instead, when a grace period starts,
this field is set to TRC_NEED_QS.

This commit therefore changes the check from zero to TRC_NEED_QS.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcupdate.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d2507168b9c7b..e7474d7833424 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -205,9 +205,9 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 	do {									\
 		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
 										\
-		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
+		if (unlikely(READ_ONCE((t)->trc_reader_special.b.need_qs) == TRC_NEED_QS) &&	\
 		    likely(!___rttq_nesting)) {					\
-			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
+			rcu_trc_cmpxchg_need_qs((t), TRC_NEED_QS, TRC_NEED_QS_CHECKED);	\
 		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
 			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
 			rcu_tasks_trace_qs_blkd(t);				\
-- 
2.43.0


