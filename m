Return-Path: <linux-kernel+bounces-37389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523883AF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C707F1C23D12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DBD1272CA;
	Wed, 24 Jan 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyiwnhku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187C1272BD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115933; cv=none; b=OOS6kInZWYh81VpAQhgxWCMN9dELvQPq+E+r4WghaiG6DhBZSxBXU2lXUe4oepEcBB3T2YmT3A+8nun97Mo7bV4o5nIB5OssHBh88+XikaywdTwATHH0RyUwNi71Mh1b5xwoHyjrnlrMBy3/eVeOpR6KfIrcvQJYdDrfL8l/3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115933; c=relaxed/simple;
	bh=xd9lp8Dgdk3GeTXPSlcpQ+XIBvUrAdTXmBLHdrTRoNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTdM0eT2EbmWRNh1Fxv8OqQtOlI2cqY2fHqnya8sOSjRq6VzdweKLZmXNhciSDo8lcNfY6nssL3fQO+M64TqiuW3M0YRYy8YSy+qWZ+FQrBq8wtknjR9HLX2lHbgUaTUwlJb5fsa27JtNq4gkvGwePvFuadSY07a9v2VEGQo9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyiwnhku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9F7C43390;
	Wed, 24 Jan 2024 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115933;
	bh=xd9lp8Dgdk3GeTXPSlcpQ+XIBvUrAdTXmBLHdrTRoNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dyiwnhku/izDEmU5i9UcrzJoBersWd9xawziwUnL9ig6NdCzpjo+HyFv4hbHyVClj
	 EvSJLB5669yZJOa0zipBW5kH5Yop6DN8kEhUF+w02RlKTo9WXM7JpZFtr9//XMpqvs
	 8KKejZReOjht4rqgK536aSxhUz1OrPEqj1O3ZISMVP+9lbr99Pl7+Pfbu9AY2IMw87
	 Wb9AcrbamYC+qpqXFkWFlQckCSuZxK3139LdAr/S0ibu8/KQCmx29i8B5/2/rxRMfJ
	 oiMEdGprze6Q6eV0FwydQmmw/ep+pErXxGF7PQmf8C4MMvE5GI8w5p7MHst9sLpDle
	 PzPuHWXkYByoQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 10/15] tick: Assume the tick can't be stopped in NOHZ_MODE_INACTIVE mode
Date: Wed, 24 Jan 2024 18:04:54 +0100
Message-ID: <20240124170459.24850-11-frederic@kernel.org>
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

The full-nohz update function checks if the nohz mode is active before
proceeding. It considers one exception though: if the tick is already
stopped even though the nohz mode is inactive, it still moves on in
order to update/restart the tick if needed.

However in order for the tick to be stopped, the nohz_mode has to be
either NOHZ_MODE_LOWRES or NOHZ_MODE_HIGHRES. Therefore it doesn't make
sense to test if the tick is stopped before verifying NOHZ_MODE_INACTIVE
mode.

Remove the needless related condition.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index e8e3b5d447e9..3104fff89007 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1044,7 +1044,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	if (!tick_nohz_full_cpu(smp_processor_id()))
 		return;
 
-	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
+	if (ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
 	__tick_nohz_full_update_tick(ts, ktime_get());
-- 
2.43.0


