Return-Path: <linux-kernel+bounces-112938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B07AF887FE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B111C211EE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC779B99;
	Sun, 24 Mar 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXKHtYKC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40137640F;
	Sun, 24 Mar 2024 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319750; cv=none; b=DQ0w2fGi+Y3Eh3ibbBNepaQakH8EP9FU4AwSs0Q1GV9WTvI1tlZjdQ69p3uDczp6ymqSNqj+gQx3atnUZf51y9U2Ag63mbgUP3EWXjbIhVZBH5FMxB5m/8CueuR1o0dtXo+1/35u5VRD17J/a/z94zl31gB+iueEg+h69U9FIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319750; c=relaxed/simple;
	bh=4NV8jozK46/fbyAfW2dcGTbTjJRTkGsTkxZjNikSahs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpK59C2QTBOw/y/aYTaW5ztO6QW4UJDDVag7+xQnsOKxToILznH5RLsXzZffqOaOfuOx38EfWkMdrvm6FdR4rYk93Uazo8MJ8n9VJVjnjfTNEaK0u3EVigW0hax7c1AItulriLXV4FW4k9v8MMRymkwjNU89Jp7PqK0acNSRczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXKHtYKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D3FC43394;
	Sun, 24 Mar 2024 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319750;
	bh=4NV8jozK46/fbyAfW2dcGTbTjJRTkGsTkxZjNikSahs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mXKHtYKCvBtvhjztJhqODT9tBFVoMdFJ+yCqRZHRMV+o56We4jF2CDlh5rttorNh2
	 klWoBNGz6aauUn3JJiN53jXMnG44iFd3pdeYOuwK4kEi2YyVvZx4Wq2zGqJEF0wkPf
	 zT+PCH6wjRB5OU7pfy9vcHiQeiLsUNZI/UrgGONfqp7hbNP9o+3Z9UvliUBGideGvM
	 ubSy50qP/mMNo8+2VKxAWjDwtGjyX0QcS9TRsaEiMtP+MXmWO1gQO5OT13VbD3jkBe
	 48nBgF3bNKJunMNNnqtdnGukgo8MZFEmkZm3w6nRPA4kGvEI8w6tlxSMe/P/VaYBte
	 Zj8iSK5iwCTeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 051/715] timekeeping: Fix cross-timestamp interpolation for non-x86
Date: Sun, 24 Mar 2024 18:23:50 -0400
Message-ID: <20240324223455.1342824-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Hilber <peter.hilber@opensynergy.com>

[ Upstream commit 14274d0bd31b4debf28284604589f596ad2e99f2 ]

So far, get_device_system_crosststamp() unconditionally passes
system_counterval.cycles to timekeeping_cycles_to_ns(). But when
interpolating system time (do_interp == true), system_counterval.cycles is
before tkr_mono.cycle_last, contrary to the timekeeping_cycles_to_ns()
expectations.

On x86, CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE will mitigate on
interpolating, setting delta to 0. With delta == 0, xtstamp->sys_monoraw
and xtstamp->sys_realtime are then set to the last update time, as
implicitly expected by adjust_historical_crosststamp(). On other
architectures, the resulting nonsense xtstamp->sys_monoraw and
xtstamp->sys_realtime corrupt the xtstamp (ts) adjustment in
adjust_historical_crosststamp().

Fix this by deriving xtstamp->sys_monoraw and xtstamp->sys_realtime from
the last update time when interpolating, by using the local variable
"cycles". The local variable already has the right value when
interpolating, unlike system_counterval.cycles.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20231218073849.35294-4-peter.hilber@opensynergy.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timekeeping.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4e9f2f88c9d6e..8aab7ed414907 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1261,10 +1261,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				      tk_core.timekeeper.offs_real);
 		base_raw = tk->tkr_raw.base;
 
-		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono,
-						     system_counterval.cycles);
-		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw,
-						    system_counterval.cycles);
+		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
+		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	xtstamp->sys_realtime = ktime_add_ns(base_real, nsec_real);
-- 
2.43.0


