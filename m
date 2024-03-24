Return-Path: <linux-kernel+bounces-112771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A28887DF4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8B728173C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC1A5676F;
	Sun, 24 Mar 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcSR9zVP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050355E74;
	Sun, 24 Mar 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300033; cv=none; b=d5lptE+TRVbLHQQv2v8FYn4pXLY9+Ky6jHOAlEu1eIEMzsPcpgbV/J+3Ir6Y4syErm5ul9UxLL3MQjpIdBFwusL9CDlhqGkJ0BvbYMSe942WwErXQPC1JqKhSYjW9oV8pBTJNgZIOFApGRAQGQKGnF/zOUiTJFStTP9jcVBnf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300033; c=relaxed/simple;
	bh=WPIjX/2qHFPCedFEYL9s01CISXiCP6wWXcAuXar04gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEAt7uKhIh+7fV4PJkkrMVhbDDY3JsHUpcGwP7qVsXWtD+lCR4uMN2K6Br+NWe4hoX86RbEpuHInrLooe5Fu5oWzeZSqgyHxCjhkg15OEC3EI0I8yNCuSKcElB7/jMGNKzzB7qMvtzlqBoi4vBtIiTfKg9tGApZBiiMo16BZIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcSR9zVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D76FC43394;
	Sun, 24 Mar 2024 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300033;
	bh=WPIjX/2qHFPCedFEYL9s01CISXiCP6wWXcAuXar04gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcSR9zVPe8VR9tyvUyoqcUmnRujBIpegzsqs/SzSGSeDKoSRmAXt64MLcV7XmGNcj
	 BkiLA0ODUf/Gi3jIQ3SOwOPaeCoMKGVDOelEEeU6631f/z46FSxFr9K1vRE2XKrzZA
	 pgN3C9s4CGZElU6QM6kPV6k9GWDDfTK5yk4snXMKLMTELb+cIJUDqebK7T1O6bhRKx
	 Upi3o1KvyR+k0CjU/UA0fKP8570WYs1ufTC10BHN11S0ZK6AcDALME9wrXYaG7zdxY
	 +O/o3anEqFK/s1Is+TuXv47HWgJ6aH/ropAsdEo5YXUfKSSsu2RQg3Nw/BZ6E1ajMp
	 0xT0JCx74LQRg==
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
Subject: [PATCH AUTOSEL 6.1 2/7] rcu-tasks: Repair RCU Tasks Trace quiescence check
Date: Sun, 24 Mar 2024 13:07:02 -0400
Message-ID: <20240324170709.546465-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170709.546465-1-sashal@kernel.org>
References: <20240324170709.546465-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.82
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


