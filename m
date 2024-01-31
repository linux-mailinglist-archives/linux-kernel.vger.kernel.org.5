Return-Path: <linux-kernel+bounces-47349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E441844CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B301C238D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC764B5B1;
	Wed, 31 Jan 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbsKGu5K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9F4A992
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742697; cv=none; b=KG8bxaSCM1FA0fhX2WyN2CphNwwIq42l7YMnTEmuJ+BKYtYkg9MSktqEJ6tcf7U4UM3vs7MyjN1rar0Q6BmBJicVO/bg7bSkSiN78mkIbvH0oPMytnjsIhKIYLewCjr/ZR4No+yG+bDNfr047+Cp5TWIz4iwe2ccl4Je8oKEYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742697; c=relaxed/simple;
	bh=DNVESk4JIRTsWnUA2aWEEPPDA9xQmhtXj6gZKFnVhtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq8BMrSLFQkx1fZ3cu/qsSPI1ZZxW5cw2pG1zW/Mv0SPgjbgcGTP3ac69oyEjT4FcIAq9W+SUFA19NEfZW4Rz4meO4UTuzVQy2Scl1h9HJxiz2/lqxtx868/l24VXbNsDxxbhVxaxI/IxX/jO7CCIl4XrZEVe3QraideXHA8xj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbsKGu5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDDAC433F1;
	Wed, 31 Jan 2024 23:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742697;
	bh=DNVESk4JIRTsWnUA2aWEEPPDA9xQmhtXj6gZKFnVhtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbsKGu5K9ARWebN1/wgqhx3Hax4JJH7izJQs//Hwto3c1/HHCv0aLnZ8162+bZQ3+
	 RF0yyAuOeYzTu3E18vifIj2SnzSk1CDYnljj3qYvoPEfA2kAwAdzkg/mIV3OdTsW8V
	 FAZ9R+6cMeFJrJNGkeczff7FEn32rkVytbk60Z1c58buVh5zvo2pTR7FRfJ9BDMeQo
	 1fbifoNBrHmnyKC9Os57r1uaZJ8aKcrEfG9NHxKeG0tcVhZCEMSm1Dy8NhGO1JI2wc
	 RLnbP7SsWTjG4HX3WOalwaDMQ0bW9RRtv4E7BKl1RQS4wbiJsT51lo0xDkuVrHnURL
	 PfFdHveSF5s+A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 05/15] tick: s/tick_nohz_stop_sched_tick/tick_nohz_full_stop_tick
Date: Thu,  1 Feb 2024 00:11:10 +0100
Message-ID: <20240131231120.12006-6-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131231120.12006-1-frederic@kernel.org>
References: <20240131231120.12006-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tick_nohz_stop_sched_tick() is only about nohz_full and not about
dynticks-idle. Reflect that in the function name to avoid confusion.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c4bf796a3285..1fd7319b58b3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -997,7 +997,7 @@ static void tick_nohz_retain_tick(struct tick_sched *ts)
 }
 
 #ifdef CONFIG_NO_HZ_FULL
-static void tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
+static void tick_nohz_full_stop_tick(struct tick_sched *ts, int cpu)
 {
 	if (tick_nohz_next_event(ts, cpu))
 		tick_nohz_stop_tick(ts, cpu);
@@ -1032,7 +1032,7 @@ static void __tick_nohz_full_update_tick(struct tick_sched *ts,
 	int cpu = smp_processor_id();
 
 	if (can_stop_full_tick(cpu, ts))
-		tick_nohz_stop_sched_tick(ts, cpu);
+		tick_nohz_full_stop_tick(ts, cpu);
 	else if (ts->tick_stopped)
 		tick_nohz_restart_sched_tick(ts, now);
 #endif
-- 
2.43.0


