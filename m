Return-Path: <linux-kernel+bounces-124838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC2A891D89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2317AB2B41F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626A1BAC25;
	Fri, 29 Mar 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Kz4QTs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BE1B8853;
	Fri, 29 Mar 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716265; cv=none; b=GXKIjbmyP2K1oXKRJlHDDffcpniYKzEaZBvVKZu6SCyBqIxx6FXKgXjgY4M7HWE0l+ek6uP2Asd3yk5FCl64egCZaoGT1uTC7tSH2aTqW1f9UfP6kpE7Q6tWqjeU0vjLvSmeuua4DGzVZ14NLdzctcfiheSdSLwvTXaZBIWP6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716265; c=relaxed/simple;
	bh=slTNCGICSXhv0R9PYIlhq5xx5106itMekrzuvhanb7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGL9TG7BiiySVwsTwpvufY4hbL38ZuopFSMY7/7mZmWxbQX5wS/p2htc86JKI5lPHXsPmol3XwT3JaBrTg9omCC7lXZlteG1pCOGUVo4ewIewk1VUTsg1s2lkM43xVL9l75Czz7NFKRvLjFdNjYK5ZljPxictkVfO/IKTZnl8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+Kz4QTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1702C43330;
	Fri, 29 Mar 2024 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716264;
	bh=slTNCGICSXhv0R9PYIlhq5xx5106itMekrzuvhanb7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+Kz4QTsFlfd9P97Qxj7RXfWbLFiZNbfy3h2GajNbEuLYx5AOrqOoAF1RGtDXCEmx
	 xOw4fb/tilNInjF619RdKEoxHjeYeu6VQ9uQun8YPPOIn7+3oNE7Q0Y1PFEkMchL5B
	 iIgY73pQe87Y+BIEbC/TR2L93S/BwthjM28XOv5SniGHn1ST3hdUOjOai8z1CO8J7n
	 TlwkM4dnDd/uyNLFK1gLk1uoNWU5qA51rGauEb9y5k0iCfgTK35kwWiLxpRY8O+K4L
	 pGHYU1aRXG8o+T3B1f05G2EkzxiAc2rAITY1m93g8QssWfzmTkVP2qF4RStV6u9lYQ
	 qFv/I4VksI+pA==
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
Subject: [PATCH AUTOSEL 6.6 29/75] rcu-tasks: Repair RCU Tasks Trace quiescence check
Date: Fri, 29 Mar 2024 08:42:10 -0400
Message-ID: <20240329124330.3089520-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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


