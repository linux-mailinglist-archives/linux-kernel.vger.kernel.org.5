Return-Path: <linux-kernel+bounces-80332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890A2862D7A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE0EB20F13
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37721EB27;
	Sun, 25 Feb 2024 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr7isJqi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA21CD1A
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901725; cv=none; b=VxEPXX6wNl46Neidqc2E0cwufMNgex61j7gLdBTBUEWXGBe7EyPUPrPTczGLAnkDz7mnViKDXogzl09cLXsbb8ybVlu1+OZ1QaXd1RuFYA8kyx2yUuTC7boMox4rvGQWdjF0V8xiJX6kFullJTVLDp3xiWKKBQfMxQRMJxPUocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901725; c=relaxed/simple;
	bh=IamgszwyZ3IggU9+C9+L0AHD8yJxSmoVUB5dySoZ5Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4M2D3xpw0j5V+aiE1AMsLBbqdMxGaoHwVgeTjW0ICkl1KxI3tn4Hc6fJSpIiYZsAtKV37D+0pJITbO6hglQOrdpkWdltkPD2nKxlRaWDSAPV9l5yss7J9MZNCCnlLDRT+Yf1U69+j6LvGSOVBS1g7AV+Id+56AhWP6LKNUCLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr7isJqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A0AC433F1;
	Sun, 25 Feb 2024 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901724;
	bh=IamgszwyZ3IggU9+C9+L0AHD8yJxSmoVUB5dySoZ5Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rr7isJqiDhIDuwueOypOg8KMlIwexB8lFBwW6JDcheReDFJIAwiF9oMKhwR3hn5m4
	 6kjrKILkI8H8+slfeeQgWj3RXKnXHBMup23qMYJ/v7et58hB+WXGPnvGyXVgO3lAfg
	 iVz6jjvFdasMsVUL4YTGL50zhFjP7auQKSNSkg3ny+BirlxSZyWg7iUFANKU+QTGco
	 fPypIq2Cr6Lsiu59j1PXby4azbkRFhQR5QhDACyprCPu6bW98bun6Jbmpty5DBukLv
	 8fPUUr0qfcTQRUj1GjpgAvTfeOvWPHArfoRtiuDKYhxJGmVdzVJaAcpLiH/lz1Kfbt
	 XnMVKHhbjo+qg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 05/16] tick: s/tick_nohz_stop_sched_tick/tick_nohz_full_stop_tick
Date: Sun, 25 Feb 2024 23:54:57 +0100
Message-ID: <20240225225508.11587-6-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225225508.11587-1-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
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
index 4e34967edc0d..9f75f5621965 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1040,7 +1040,7 @@ static void tick_nohz_retain_tick(struct tick_sched *ts)
 }
 
 #ifdef CONFIG_NO_HZ_FULL
-static void tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
+static void tick_nohz_full_stop_tick(struct tick_sched *ts, int cpu)
 {
 	if (tick_nohz_next_event(ts, cpu))
 		tick_nohz_stop_tick(ts, cpu);
@@ -1075,7 +1075,7 @@ static void __tick_nohz_full_update_tick(struct tick_sched *ts,
 	int cpu = smp_processor_id();
 
 	if (can_stop_full_tick(cpu, ts))
-		tick_nohz_stop_sched_tick(ts, cpu);
+		tick_nohz_full_stop_tick(ts, cpu);
 	else if (ts->tick_stopped)
 		tick_nohz_restart_sched_tick(ts, now);
 #endif
-- 
2.43.0


