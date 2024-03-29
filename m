Return-Path: <linux-kernel+bounces-124750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91E7891C20
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6BE1C26BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC893147C73;
	Fri, 29 Mar 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktrxV8jT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67317D222;
	Fri, 29 Mar 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716076; cv=none; b=N2J7V5rdOqn4KjMVU/lXoYz+PaMMf98JRXnOJhjKfyFaLq6iDcVL9d8BBTaQkc3EsAH3gcGunpdJ4RMoQCgSWuvTbDWcSSBrDp/0IYPhMfa4WDBLzvF791fIKV/NJGhqM2Khzs+qtKLz01UdB6qXDSSpqV60pFHi/TRgQk6ah0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716076; c=relaxed/simple;
	bh=bxVGzJ3AzIudmCa/MTstvcMBg6Yvgfv7mF2wpvMvwZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhRQ9BGi2m1qT1AJ1ZY3LhtCUjPL1mFTTWWienKykO74B15gy4fOCeDIF45qFX9RLuXLN/EFq2SjCayhhTh/hiPKdtLzEE6OQcCjs8Mp75z8cjo3zY68UDR/2mDnaPpN6mn9xJZTpCV8z5EkAbpxAj63Ocgo5PP3KdRinLiV4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktrxV8jT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8544C43394;
	Fri, 29 Mar 2024 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716075;
	bh=bxVGzJ3AzIudmCa/MTstvcMBg6Yvgfv7mF2wpvMvwZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ktrxV8jT4zq0rqCiFoyqXEC5CfAfRBHzGFm7HXBVpX9AJU/hfKUJazGyR5UnphNF4
	 YvPSGfy+qEe2sn85gqpPxBog2PXhsd+7nDExoRq/IshrGFqlmC0eqTdKIMDc/vCQZv
	 b7FYK45H3J9KJpCGDNpBAkNbbSOUitkddTBPMe2xh5m/Ek//Ce3MmVVVI7FPpz808r
	 hH9iY6St0Yn17EHalTfNTx9qz+oaeYBbRb+htSKZ5aeIJr6lwuxO574dIplQxpAEAi
	 UpD/0uvkARoRRkPy9IE2BNESNeg0x99G3PqUWtwbiP1mbRArnS13noXGceGWh18bWT
	 P4H4o90v+LOBA==
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
Subject: [PATCH AUTOSEL 6.8 41/98] rcu-tasks: Repair RCU Tasks Trace quiescence check
Date: Fri, 29 Mar 2024 08:37:12 -0400
Message-ID: <20240329123919.3087149-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 0746b1b0b6639..16f519914415e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -184,9 +184,9 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
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


