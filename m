Return-Path: <linux-kernel+bounces-112748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87370887DC3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A62E280FAC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6BC1B5AA;
	Sun, 24 Mar 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYEFdWci"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0338392;
	Sun, 24 Mar 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299983; cv=none; b=CZ2ffJ7dsafg8SG1WnO63u3FLTaiMVWpLUv1cYQ9PX1t4adCUXtNp/mC77IHpwmn6bIX5+SiswW4QifOPiyIYTdlevPKOnsk/e7TY/SKIJ993Qfy0c0tUnAjzXYmUGMumQiydgdjzSWi7KCW7ZsbY9xeQdxu3KQ2i/hv9eWfFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299983; c=relaxed/simple;
	bh=n3dwFLGnz0x5/8VbdajTE3uMTl9p8TRcdorbblTdFAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXh6g1JaFHy6Cxe7PVDvcJmTQRiYjnnKycaEntVARNiP3cacNApTjf9fGEW4l3dtTw9CJDxlK2n9sITpABoplGCnn+ABuRYpIDZSah/FZY5g7X3liPX6Jx711rNQJy7fumLIbgNGh2//qeD6Ha4YrGmulcYKHe5Tsj1WiFLpabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYEFdWci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E215EC433A6;
	Sun, 24 Mar 2024 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299983;
	bh=n3dwFLGnz0x5/8VbdajTE3uMTl9p8TRcdorbblTdFAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYEFdWciT5tF8L1P7SfWCs5+mqSeZ8ALXXyCzy/F+pf1W3XGwjzVAqfhdtUr6OypU
	 VDXu3phAFdnyqjXbYXoyD04UQOLc+eZwlPPp2Sj1QrHRTPwqrLYXhqS7ZZtZx64nO0
	 o0Aav22kvtLBwSMLHgay7okkos6hThf1S4WZ4E/TgC3Ds5Lwp/u80dcYgWImYnzltI
	 tYIpLQ8Yc/GLRMDMSKLXRTMoHROn7gJz8SfaPTZZ1E6SyRX485z7hYnEJD9hHw0kWW
	 GW8r1CY9LF4Fp0zImWmm8M7r9iq8ZX1/Rhp+kAfnHaNDXpAALIAwQ+EGdGaR0z21XV
	 +FZe0XkGgy82A==
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
Subject: [PATCH AUTOSEL 6.7 02/11] rcu-tasks: Repair RCU Tasks Trace quiescence check
Date: Sun, 24 Mar 2024 13:06:05 -0400
Message-ID: <20240324170619.545975-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170619.545975-1-sashal@kernel.org>
References: <20240324170619.545975-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.10
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
index 31d523c4e0893..457694a274bcf 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -187,9 +187,9 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
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


