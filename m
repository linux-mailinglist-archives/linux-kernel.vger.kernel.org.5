Return-Path: <linux-kernel+bounces-114952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D2888C51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95149B24213
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02E2DC9D2;
	Mon, 25 Mar 2024 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OayZDEjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873CF179FDD;
	Sun, 24 Mar 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323667; cv=none; b=h20A/rPDCu+hwqG57eGUJPiYTPf7MQvo8NNHGNlOpYot0HxHwgWGHQz9LLZ+7blzfB5qa4p70Zs4hUbM8isvC5J2CfrXrGX1ja10Affx8PfLRz1Yd0CJDIW0a6dK5NlGJbA/KPG/9iTYoPMXMhFkK6FZoL0bWRhyPQ0T78h4BdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323667; c=relaxed/simple;
	bh=bkgkY4MimmFGIFsqql8oT8WjKyOt0XojbbENl0nJP7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9PCOc30jlehk2aYaK+oPS4wfucVr8aCMP7D1Nv/chapIfCmXI/znIX3EsY70swzx9wqISlL6I1j/CGKT6jv/19UjTC5LSVJDA1Dfwjl9KKwx6n6xqGdWysmaSqbp9HsTK3MpF3GJo1VwowtpHLuwENznxGgV5TMTKa8bXY0/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OayZDEjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B79C43390;
	Sun, 24 Mar 2024 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323666;
	bh=bkgkY4MimmFGIFsqql8oT8WjKyOt0XojbbENl0nJP7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OayZDEjjo9BnrNuEEhq3UF7iJxGjPVl8s7heX1wflSF/KHNuX+LoGah7MJ4psnmbS
	 wopZGe2A1uGLfZod+qeb1CckK5DqBPC3D3kw3qNqeOQQhxP16qRmnpAfY4cHxUymFC
	 F0Rm/B1Y41XHDlsvETGARrHr6m/kItginwl6uBmjDOc3HLlBaCLI4fi+1qSTqwcYJ4
	 dwPiNKrc7sgYSYtZdJArN+uEGdMGGSotaXbX6Q0q8rMscDumG1fkgwE/4QI+7/K26A
	 zWNYTF8APlkNO+NM69FTaCxq72GERvXUGEuDqDunhMwUEZQLIw9k+A9DGV+Tt29cou
	 pULmw1vBrxs/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 038/238] timekeeping: Fix cross-timestamp interpolation for non-x86
Date: Sun, 24 Mar 2024 19:37:06 -0400
Message-ID: <20240324234027.1354210-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 6f615db414769..629a07e6a0bfc 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1248,10 +1248,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
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


