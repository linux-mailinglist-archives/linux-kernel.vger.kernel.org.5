Return-Path: <linux-kernel+bounces-113655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9708885E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461201F240AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0B8664C;
	Sun, 24 Mar 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omOoOBsP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953A1D567F;
	Sun, 24 Mar 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320568; cv=none; b=L4ZVBgOWaNqOf+6LgGqQSHLtGJujBpP5X6zK9bxmTYxtazurD78ri1jdqVk8dV8krLxhO4tT59WvbK3TTtKNHSDcHv9zMLcfbfHa6bY0fwJGoF6kouE4OUO26SIgmTSZCCcQMuH2dNYJKwvhOvbWS/OW7RimNdHwx247dkIG950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320568; c=relaxed/simple;
	bh=4NV8jozK46/fbyAfW2dcGTbTjJRTkGsTkxZjNikSahs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=didY5AWvnQWDmMh2Fjg7Xy0pGyeZaGWEnR4Ix33NKsaxiMhz5KBKYjU2VAsI6Cvo+UbNqZZJKIKQPVN8Qkuje8UN1JBnf200BsHtODMn01IW1agPemgF8rGSguYxGuCqh//6d1pSdspDYQQRIfC+hrj0BU8oVHyOYOPcsSOyafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omOoOBsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835B8C43601;
	Sun, 24 Mar 2024 22:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320567;
	bh=4NV8jozK46/fbyAfW2dcGTbTjJRTkGsTkxZjNikSahs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omOoOBsPIr1gGvh6MP4aUB63/50MhZF+NjLL3u1d7f0TcQRy5pkp+icxqElonSmOa
	 BKj7/zwfPb86eARvHJD23VcXLMZSR63qT4IY72WI/3X/8b1Cx67jXIUrP/oXbphuUV
	 dLQ7Gz24CoWRdxBNskW7L7ujGnpyTNU8uaRjQaIAzQWPUN/ZzAJCvADp9KeQYxlDM6
	 SjNBdQpHnBt8XvpbmLEjmeaz1Z18OWyAqkNcbxM9WgV+bBoOEYnVFzV3B/JrZ38BMo
	 ueKlvu81knbBwHrtoGQifsSyNKCOB7Fm3wRzx6OMtqHUlEWSGHcRsnPgWmnc4eJUIh
	 Zy21q59Q9r1iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 128/713] timekeeping: Fix cross-timestamp interpolation for non-x86
Date: Sun, 24 Mar 2024 18:37:34 -0400
Message-ID: <20240324224720.1345309-129-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


