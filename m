Return-Path: <linux-kernel+bounces-26101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085082DB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050531F22983
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC317C64;
	Mon, 15 Jan 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RyWK6cnq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nI9H8aRP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E211799A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3N/e3ayce4s+S+psHat1NbmR2VoGUdUGd0vnbZups1E=;
	b=RyWK6cnqw0ZSnAWy/fuDH3dP0nS91x8d3ZEE8sFVaN+Vwyu+FNf6Eo8e15EGEiU0TVhbBP
	CEiUEWxOavweTRQ5m0Az1upcpffWC2rkjj1sjatSDdEBJ3v2H/uwX97TZ+kDziSmES9dPj
	oQ0z9ycusV9RXflK9FcIJEv3PAO1wO405l7j3tR3MOq6Q1A8GZfSywxZJ54WOnXBdaxU5U
	jifuboiqZw+UW2BdbBgpEV2Wa2WrBuq57KGcfP53oo5YC9B0bViLiLuuhE3rFoDv/Ln+gW
	t7odEXusxS4BmTv+2pDa7dzXH8jx7ahZCyNgV5jvZgJmFqO1ROABdBOk49NG+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3N/e3ayce4s+S+psHat1NbmR2VoGUdUGd0vnbZups1E=;
	b=nI9H8aRP8bIz2zRhY61S/vNnS4ySyBwwN2VLZ3UTM6sC9x7IvA1EKT80kGdS6DDSY3JvvZ
	JIxNDTZi3oKmaoAQ==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v10 06/20] workqueue: Use global variant for add_timer()
Date: Mon, 15 Jan 2024 15:37:29 +0100
Message-Id: <20240115143743.27827-7-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of the NOHZ pull at expiry model will change the timer
bases per CPU. Timers, that have to expire on a specific CPU, require the
TIMER_PINNED flag. If the CPU doesn't matter, the TIMER_PINNED flag must be
dropped. This is required for call sites which use the timer alternately as
pinned and not pinned timer like workqueues do.

Therefore use add_timer_global() to make sure TIMER_PINNED flag is dropped.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
v6:
  - New patch: As v6 provides unconditially setting TIMER_PINNED flag in
    add_timer_on() workqueue requires new add_timer_global() variant.
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..31a6b0831318 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1955,7 +1955,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	if (unlikely(cpu != WORK_CPU_UNBOUND))
 		add_timer_on(timer, cpu);
 	else
-		add_timer(timer);
+		add_timer_global(timer);
 }
 
 /**
-- 
2.39.2


