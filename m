Return-Path: <linux-kernel+bounces-124728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74A891BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3F11C26CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5920178236;
	Fri, 29 Mar 2024 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RulDcYR4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F14178221;
	Fri, 29 Mar 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716021; cv=none; b=k4wOTwI4kRIh8AoayOluuuwwaHN9bSTpOedVjG4tfD5gA4ccD1JfXIx6RgX3i5VbmIkTJ/TQKKRMZSzMaE238X+wvXfC1Q3dtsBcKyf7YgIQ1TZKtHXJjH/PL8dT0gKJj2FdVobLirQd6fSjpoOO3xaXknVc50cAwOQzRStyK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716021; c=relaxed/simple;
	bh=clxWihJjspTTiqyEKqg1yvayyGIOfGSuJL9pp69ouIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3UrH+dHNddJrHYM0AtkvSaBW5ArR8QyjeDs+TVwMfdRA7EKQL2k6ktDpKdAxPdLwmtawXHvoig4TE9g8ZVbcPeH2j0ed5iLvucHS1yw98AOiWX6c//5oNr0NX/1IPOhJKGNlgPhxn0q4ICEVx2AZOvex4R7OE49JKWGgp2qh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RulDcYR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0DBC433F1;
	Fri, 29 Mar 2024 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716021;
	bh=clxWihJjspTTiqyEKqg1yvayyGIOfGSuJL9pp69ouIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RulDcYR4PYxvCisoNsTeFWA/dnjd6YjHDBMI23hNP1NiPNnsEeGEZlkn/aejH3qzF
	 4f7Ohl7WcAmMeKR4KByGePTEuf2rw5Jvs34Z7r7PSlSGNISd3EhGQ/6hKdk9I3y3Dw
	 Kwcv2tqSuE7cHgbv0aSIKcGUSbhwZfI5auoKILkkq+UtyR6B2RnxepNgKwG2RoXIK0
	 CEyJKemqEvD1pFgeoLqPjW5Qv43waF/T0gOdsfqme8shiotVJaS9WgoLZHi9SiqL2/
	 rlUDkeXzerG9JkQR2OpTpo7n+XrRrF1W07CEoWInDT2Ja+WOWumizr7zbtL8Kcss6T
	 WnXXI2sOjft3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 19/98] printk: For @suppress_panic_printk check for other CPU in panic
Date: Fri, 29 Mar 2024 08:36:50 -0400
Message-ID: <20240329123919.3087149-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 0ab7cdd00491b532591ef065be706301de7e448f ]

Currently @suppress_panic_printk is checked along with
non-matching @panic_cpu and current CPU. This works
because @suppress_panic_printk is only set when
panic_in_progress() is true.

Rather than relying on the @suppress_panic_printk semantics,
use the concise helper function other_cpu_in_progress(). The
helper function exists to avoid open coding such tests.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-7-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16c..d9f20d222293b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2270,8 +2270,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) &&
-	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.43.0


