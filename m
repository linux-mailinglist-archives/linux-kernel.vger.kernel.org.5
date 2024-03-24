Return-Path: <linux-kernel+bounces-116312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F96889E29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEEB1F3732E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3CE3D233C;
	Mon, 25 Mar 2024 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZPA2ty/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FC2922A1;
	Sun, 24 Mar 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324246; cv=none; b=MS3+PHvjk61ji4YTLsCcjHe5rpL4Rj2JGkVqdJHZaRtYwG3jTL6vZR8y4OZ0qY+1hLN0jMI/xf/7EOnNPFmBom4vvulUV6u5SQUE5VjiJ9nElyWq7d6BGbs6UtktMTfu0+gFWHBs3nWbtt+91CBDpHTxJt9Qo3pBINqDZjW5BZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324246; c=relaxed/simple;
	bh=QlKPp7qNBSAXPKEws/Yji1u9tXamMxzPDlnODcN9YBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzQU8bhuQ/74CZPup2yeJNpe6RRNqs+rThDrW/5OfQpBlFFi5fHYTllAz4NkOjaDCKeeEBR2BarweFkh33B+4VLpW/0esucG9dCXiL8Rl/NRMwMbVL4ipzww3NlbQVEQCAstRgRuHPvjZ9b01UXMte5a4o54tgROCso6r8O61Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZPA2ty/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27B7C43394;
	Sun, 24 Mar 2024 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324244;
	bh=QlKPp7qNBSAXPKEws/Yji1u9tXamMxzPDlnODcN9YBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZPA2ty/BSPkSEmQsVIxACcSTLwLdmP41rG7/IAYc18GEEwe6/RlCtjBf0SFwNj9w
	 qnevFXyDrSOms1pskQnr6ZjsLMkFhWf/+anKYCkAy2KvzygJaX/1xAj/z4vo551zOj
	 EVRPsDU6PeoJo0ax+GIhero8cJhhBWRx66R0RmzlQ1dAwaqSRXfXGDwFD3QR+NnC+/
	 SQNwUlnfCHcatk7cafyqDVFl4ueaAEm0EZ0znq9tqJJA4G1R89E3ysf6wAPbEdCoXa
	 Sv9fs7mW8KVam9WDFFpWQw8UTC6sC1+Xrn+U1IOHPwkkoiZ/+p0s1MiNJ7DZ5gtZYD
	 8909C83GHgwNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/148] timekeeping: Fix cross-timestamp interpolation for non-x86
Date: Sun, 24 Mar 2024 19:48:11 -0400
Message-ID: <20240324235012.1356413-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index ab36b20cdbec2..e43706e2c038f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1172,10 +1172,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
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


