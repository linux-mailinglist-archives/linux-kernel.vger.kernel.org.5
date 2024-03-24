Return-Path: <linux-kernel+bounces-112759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FAC887DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347201C20D2C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337545BF0;
	Sun, 24 Mar 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAvvk6Bd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555BA1B94B;
	Sun, 24 Mar 2024 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300009; cv=none; b=GSfEsGx8ojzbI1UIRhJc8jS0VjzdJIiWQCn9g36u8jGuq+4a2PZuK0DqFuPl85PIxDjMOwJu2epPIqexvoy+8SeaefMglxv+Vgd398ArMahMSTdcCO9Jcznhv68JCCzUURCvZnhEKZsxFEcqT76tYtJetF+RLo+g6/tOb2W/OA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300009; c=relaxed/simple;
	bh=slTNCGICSXhv0R9PYIlhq5xx5106itMekrzuvhanb7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UssRqOYFCvaD7QYyPpkt32latGHHu+TrFrtZRl+btzb1Bn17tGLzYFDOJQEwa7Shl85GA02n+vby3lri1MCmKaOHqC+e7sKWNGvlP66GnZz9haHNU5Or5BchEdrnu6qceQh1KEcxCNo/4UHbyFFQW0IeXp2+Y7a4pO4myJvzWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAvvk6Bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFB5C433B1;
	Sun, 24 Mar 2024 17:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300009;
	bh=slTNCGICSXhv0R9PYIlhq5xx5106itMekrzuvhanb7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAvvk6BdouyZ5ad9CrQa2cYMzsbRCZTMWGyKwz6X1pV+N1tBTauCG1Xq+nbPCqRp/
	 SbsDnsF65I+8t8cXGBkcSKo7In3UQPR4J0MCFjaP9CoHa/SAtrRzL1FKDHsfmON5+6
	 kqKmdvxsaUmCMzVtjnluHOsjcFMUwvDWtqZa1j6BVsZPvYbarfhQ2rrlh78JFVoN0Q
	 rUqvck1g4vRicbSaaWqDDX2CXUueQp7oKkRbiT50cM9qO9obACK1LXfiQFEyq109Rd
	 R6JMEX2zKglqaZM9vnuzkOc4thsr4y702FjD+KqmxL9uai2dfJEcZvrr/L86i2ip2M
	 sDxmo7FhWNUdA==
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
Subject: [PATCH AUTOSEL 6.6 02/11] rcu-tasks: Repair RCU Tasks Trace quiescence check
Date: Sun, 24 Mar 2024 13:06:32 -0400
Message-ID: <20240324170645.546220-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170645.546220-1-sashal@kernel.org>
References: <20240324170645.546220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.22
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
index 44aab5c0bd2c1..f9173b972c7e2 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -189,9 +189,9 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
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


