Return-Path: <linux-kernel+bounces-37384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661D483AF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B23728636D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EB986140;
	Wed, 24 Jan 2024 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIz2KY1g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B58612A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115922; cv=none; b=bCIx9Cq2y2Kxzw7g98fnVevu355T6PhPACp7pkioX3YLNSYu6T74fHlp+YoZG5ssPWPrZ4JsQUDhdLTyXicQhe3PS4RPaWIyKTSaOOduKYjWkiBuT1+rN580EjPbc9hV58P6gDTvUHs/4H0XQF3DOw1x5nTLkKwWKqAQ0OiQHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115922; c=relaxed/simple;
	bh=0LrXhB2ixhZpFzsE9HHdFubiObIt2PX57sKxj0n5aZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFnqp3qjthDqeUS52Gj5EdwGQbVw+QvtE0qej3ENbN+G6iUixKKx0eLB1DPCpAFGVAdMkiTXNyxZbXQyGZaI6r5/Ze55X1GYSsASqEVoR0KMX9NS+yUtqow/VlnGqsioftuq4z4fD2Aye+DHKsCb4FBqJJka3gcuaijBfPKSJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIz2KY1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A0CC433F1;
	Wed, 24 Jan 2024 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115921;
	bh=0LrXhB2ixhZpFzsE9HHdFubiObIt2PX57sKxj0n5aZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIz2KY1gZDEGMSGD7zEtFfKm94op/OWJg68D5tTMsPTovhjhswFAsd1eMM2gEqXUg
	 vG+2GMOtOUU0ZCGH3cU2W84E3pvQfPZM+affknLuf8UYMlkLk+hyxDS+Obi+tZ4q9c
	 V+xgwTPOS1Z0QUZMaO6qwUZoqG1BWdQSr9JAU7bdsk4Th1ya4sgBfB05UuCcW2GkOH
	 YPDL/aNftJ3PPbE/jp/UjzKqUfupXVSspRj9Dg0neer946GgN9BltG1J2TbeRiIBe/
	 gKOQNl6ofysUJIoqB9YLW6y/NYFOccznSrfEw7ayKD343vfU6cwfsvVJ2jh+QdQTfK
	 LT1AjCs2vg3hQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 05/15] tick: s/tick_nohz_stop_sched_tick/tick_nohz_full_stop_tick
Date: Wed, 24 Jan 2024 18:04:49 +0100
Message-ID: <20240124170459.24850-6-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170459.24850-1-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tick_nohz_stop_sched_tick() is only about nohz_full and not about
dynticks-idle. Reflect that in the function name to avoid confusion.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c311b7388685..4089bd274d8e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -998,7 +998,7 @@ static void tick_nohz_retain_tick(struct tick_sched *ts)
 }
 
 #ifdef CONFIG_NO_HZ_FULL
-static void tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
+static void tick_nohz_full_stop_tick(struct tick_sched *ts, int cpu)
 {
 	if (tick_nohz_next_event(ts, cpu))
 		tick_nohz_stop_tick(ts, cpu);
@@ -1033,7 +1033,7 @@ static void __tick_nohz_full_update_tick(struct tick_sched *ts,
 	int cpu = smp_processor_id();
 
 	if (can_stop_full_tick(cpu, ts))
-		tick_nohz_stop_sched_tick(ts, cpu);
+		tick_nohz_full_stop_tick(ts, cpu);
 	else if (ts->tick_stopped)
 		tick_nohz_restart_sched_tick(ts, now);
 #endif
-- 
2.43.0


