Return-Path: <linux-kernel+bounces-158681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69078B23C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0556E1C217CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E024214A4F4;
	Thu, 25 Apr 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsBm04ot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6E14A638;
	Thu, 25 Apr 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054723; cv=none; b=gIETPVrJTrNViUs3Pyx61ujL9/6ZTA4y6DzItTtt3RCJl8evmdrwJuf0CBC5pA5cKuumznJ5yS618CskwngtCkRLgRDfK4bL3dRxYnr4iZwodNEHFK/ovGmL9W6fBkjhBPsKvRSBBR40ceYt+8CdyZ+3Af01iGVLm+iI6R4dq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054723; c=relaxed/simple;
	bh=oWn7dZnPUbJ0NRHYi9j4G6EoVEgpYFIuT/xSiRP9ym0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCQ0VoFRej3BkxsGqI1C5UJEvDSfWJERQbat8K41mqhgj+UAOiA/R/XXLYeoiduEDj8hJnSnPeCTaIp4SQRdE84jRTasO6Wk0+WzZD6EXcL2Nej87UsKl871YWuQ1Fx4ku7sww6Pg6K5QGW1x53ARMSvVPjhnyMP5ZjtflyXJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsBm04ot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F4EC2BD11;
	Thu, 25 Apr 2024 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714054722;
	bh=oWn7dZnPUbJ0NRHYi9j4G6EoVEgpYFIuT/xSiRP9ym0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsBm04otJfZFnVGVAw0Qk1SvePe/dQeMx2VnGXtyXvpPSIxjUp7/tkACsct9tpO60
	 rPvlSxCFbXXsWv0emlN1qWIiY1rbAO1lbqJ1G2HGR4aoH3cCQ14vGZZMxcmMzjWZFg
	 odIQrevGPEEb0/WwUIPOgKWTmwJwsF5Y95ScpOgK6YHk9YK4Fp6L+m8RjP7zy945LI
	 dnUq1F9xCvxl7cx+lyVCeblSRJjJ+dFrcJjXR16V1rDox0/x6BEhE5u784aiGOC+NI
	 qiH/tozt83x8QaKhz64pyQ+ZRBM5dwTuR2i24lMhESEBG6ICgO/Qy7ajKpwnF2Bkx2
	 5BIwfV2RuyWBw==
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
Subject: [PATCH 1/4] rcu/nocb: Fix segcblist state machine comments about bypass
Date: Thu, 25 Apr 2024 16:18:32 +0200
Message-ID: <20240425141835.19776-2-frederic@kernel.org>
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

The parts explaining the bypass lifecycle in (de-)offloading are out
of date and/or wrong. Bypass is simply enabled whenever SEGCBLIST_RCU_CORE
flag is off.

Fix the comments accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcu_segcblist.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 659d13a7ddaa..1e5b4ef167ca 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -141,7 +141,7 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
- *  |   handles callbacks concurrently. Bypass enqueue is enabled.             |
+ *  |   handles callbacks concurrently. Bypass enqueue is disabled.            |
  *  |   Invoke RCU core so we make sure not to preempt it in the middle with   |
  *  |   leaving some urgent work unattended within a jiffy.                    |
  *  ----------------------------------------------------------------------------
@@ -154,8 +154,7 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   CB/GP kthreads and local rcu_core() handle callbacks concurrently      |
- *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary. Disable    |
- *  |   bypass enqueue.                                                        |
+ *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary.            |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
@@ -185,7 +184,7 @@ struct rcu_cblist {
  *  |                                                                          |
  *  | Callbacks processed by rcu_core() from softirqs or local                 |
  *  | rcuc kthread, while holding nocb_lock. Forbid nocb_timer to be armed.    |
- *  | Flush pending nocb_timer. Flush nocb bypass callbacks.                   |
+ *  | Flush pending nocb_timer.                                                |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
-- 
2.44.0


