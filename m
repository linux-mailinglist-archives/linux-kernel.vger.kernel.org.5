Return-Path: <linux-kernel+bounces-114748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7E288923B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF0A1C2DE9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981311ACB76;
	Mon, 25 Mar 2024 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuFP+JKw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042821953A;
	Sun, 24 Mar 2024 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323349; cv=none; b=LfUvWYuRgOtOQyRzYQLpw5/o9kprUB7EX7GaSMckYHS2rVnDslRnQEJz5S9Ei38wGH1Swt/+tIF558DlJcZ7HEXfSvwYUXkBrNDp9xpeenvWA8mR79mXggUIkKijI0Yu39d7LH6cDAND5XP+U2LiyyHjk7aF10Nk3VeUHeGwOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323349; c=relaxed/simple;
	bh=2REYRR3vG1n+VWSclweLeQyiFhonzjceeaMjCWgigcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQW6DXAa8QqWgBpNxTxoWmmUZimgYmkgaWwZMwCqFJJz/8t+ERMaSzaBhNlCXzjxYhb8fRVwHp3W4A+8lzhXcNv3QRcSa1cOfj2WMAt5dlGk7t+FEl7Oouu4xFVvV1UNrtPOMy/IEQ1LNdLIFqnzpDJWD9f1nl4UfYLYN0L16E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuFP+JKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12A9C43399;
	Sun, 24 Mar 2024 23:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323348;
	bh=2REYRR3vG1n+VWSclweLeQyiFhonzjceeaMjCWgigcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuFP+JKwDWZ2QMxy3PlPHv9vBrij9FvmvMZrzwgHa2UxoEbo4FAo4obU4ljN9NzXy
	 QLer94242o2sxl0ww4i2AIMS+vQAxuowBaaUbYRknp5YnTcID2Pd7xgsaTdRuSgqPB
	 qCBU7WrUlnIY97Vmoa+44MCS3pbGULXWPObuBcTzclwpnuXgJecismKhnk5SdryZlq
	 naxs/BAh+KEBvVceKdOWbCZbBAK4oPHXcqyH3p6YXVBru0NoYVm2PKiBhMywcAKpBY
	 oX+BgWNG5cq2Wj0zexOAYeDC8H4leEV3d9gbq5waJH31wNQH+KvQlHAOuEycGQ4zAD
	 MoIzDaw+lJJvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 048/317] timekeeping: Fix cross-timestamp interpolation for non-x86
Date: Sun, 24 Mar 2024 19:30:28 -0400
Message-ID: <20240324233458.1352854-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index d21280b3b2ea7..dfa6649c490de 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1244,10 +1244,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
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


