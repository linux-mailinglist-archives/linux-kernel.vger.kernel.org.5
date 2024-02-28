Return-Path: <linux-kernel+bounces-85027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C51E86AF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07948288074
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA25145B3F;
	Wed, 28 Feb 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz9H3awJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30BC208C5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123935; cv=none; b=VMRTpM2n95O70iYr4vUaJLzGJGmCx4b0HcqKQEZ91tyRfjztY65OKeVqa+mVCf3kPzxA/E3SX3x4kBwlIqTxHjyus70BTMhjV9jbM9xLbZ1dsejmZR0G5WdE/t6PU2y93OmKFoCtYYb8Q5eSy6cbMspIzN/U5dQHvZx4iARlyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123935; c=relaxed/simple;
	bh=7cnjA/uqqVLDP9FxayoqBzFTuC1LUGy1jPcMo2DDjj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kqw/2bmSJEqCyXtCBeB6qXrlN3sWS5S9Q50+nC7PwF3r2q1ZZp/3gM2br21StCeucLzIdKcsTBBkNT8E+/9DHPer6ntS6Gygi2bd/kA0MuJ4EKaiFVioy/+wG2bAKrVDlLA/H4FwRrK24i77+rj6FgNxTMKsT3hy+Xrh5RNE+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz9H3awJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E2DC433F1;
	Wed, 28 Feb 2024 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709123935;
	bh=7cnjA/uqqVLDP9FxayoqBzFTuC1LUGy1jPcMo2DDjj8=;
	h=From:To:Cc:Subject:Date:From;
	b=hz9H3awJAnI9uvaFM0/Gwz1pYgLWsWCnIBjb1ZS3C5a4aOJW0PSgkzIF5I9OJneZ6
	 OUHspRCcUfoLp/5F6rKm/Bzk6S3DHrG7qK0uSotcgMF2WQvIABS8rdV0fmTFk50cyX
	 Nhf5T0yeo3xWzyExErIfUrScaLqj4XoWaJpd3c7JWsgDo7Vt5L42hLHRgiKcSmKic+
	 7HtG3W9RipPcS/76NCWlG5OE9tmKp6Zlk/nsO2Xsrgrpqz6IfeOyZd6auf8jSLAYbt
	 UUWU6sHY2aZ+2Ia4DLq+1Wz+wEdE2OeZuTXVK1PP8mlf426Om5j7lNqDvzNjp36LT1
	 /aQPhBppuTlYg==
From: Arnd Bergmann <arnd@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Peng Liu <liupeng17@lenovo.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tick/sched: fix build failure for CONFIG_NO_HZ_COMMON=n
Date: Wed, 28 Feb 2024 13:38:41 +0100
Message-Id: <20240228123850.3499024-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

In configurations with CONFIG_TICK_ONESHOT but no CONFIG_NO_HZ or
CONFIG_HIGH_RES_TIMERS, tick_sched_timer_dying() is stubbed out,
but still defined as a global function as well:

kernel/time/tick-sched.c:1599:6: error: redefinition of 'tick_sched_timer_dying'
 1599 | void tick_sched_timer_dying(int cpu)
      |      ^
kernel/time/tick-sched.h:111:20: note: previous definition is here
  111 | static inline void tick_sched_timer_dying(int cpu) { }
      |                    ^

This configuration only appears with ARM CONFIG_ARCH_BCM_MOBILE,
which should not actually select CONFIG_TICK_ONESHOT.

Adjust the #ifdef for the stub to match the condition for building the
tick-sched.c file for consistency with the definition and to avoid
the build regression.

Fixes: 3aedb7fcd88a ("tick/sched: Remove useless oneshot ifdeffery")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/tick-sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 58d8d1c49dd3..e11c4dc65bcb 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -105,7 +105,7 @@ struct tick_sched {
 extern struct tick_sched *tick_get_tick_sched(int cpu);
 
 extern void tick_setup_sched_timer(bool hrtimer);
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
+#if defined CONFIG_TICK_ONESHOT
 extern void tick_sched_timer_dying(int cpu);
 #else
 static inline void tick_sched_timer_dying(int cpu) { }
-- 
2.39.2


