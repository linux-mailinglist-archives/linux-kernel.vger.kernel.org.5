Return-Path: <linux-kernel+bounces-27236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8683982EC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECF31C22B89
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC1F134C6;
	Tue, 16 Jan 2024 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iin3idrR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IP5KSt3E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E6134A3;
	Tue, 16 Jan 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Jan 2024 10:08:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705399701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Awifqxg6eOBMIPHwm/f2jqMJMZMe9tEsWAtoE0BA5w=;
	b=Iin3idrR5MZ/nYHs+cYEsV+nEIlY6DHvv2qPF2ngONsM98z0snV5Y2/CfdNjbcpNLu480W
	qdntxcOkNVC5Yhx6bGrnqpSRO2E6arjUNGDhL2AfTnu30764nYzgnBEpWRLuQDNc/xWGzT
	mBMjciieIvAaxgrTgxajtDziN69N7D2DiOKWF3WqdN0ComW2ucwVuhgVvSEYFLnmfYC4+O
	q8NY/vbl3qBPeGZfBi9QZKqKSsc1weB0RrnQIfIvxy77GozjPoC9cNbUjYkJ/Pscd4k4JV
	jv/5AryD7oG8OCJqCLA7zHi3scL5x9ad0FbLldIX63omB9BJ8pP0qhmvXkqHWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705399701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Awifqxg6eOBMIPHwm/f2jqMJMZMe9tEsWAtoE0BA5w=;
	b=IP5KSt3ELERRE2YEvC1Ydl8wwWpVpWNiLC0dT6a1jo7G/ywSa/YSKcO5bWzk1jSmF4zA4o
	4VzZtEmakW8noeDA==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix frequency selection for
 non-invariant case
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Wyes Karny <wkarny@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240114183600.135316-1-vincent.guittot@linaro.org>
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170539970061.398.16662091173685476681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27
Gitweb:        https://git.kernel.org/tip/e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Sun, 14 Jan 2024 19:36:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 16 Jan 2024 10:41:25 +01:00

sched/fair: Fix frequency selection for non-invariant case

Linus reported a ~50% performance regression on single-threaded
workloads on his AMD Ryzen system, and bisected it to:

  9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")

When frequency invariance is not enabled, get_capacity_ref_freq(policy)
is supposed to return the current frequency and the performance margin
applied by map_util_perf(), enabling the utilization to go above the
maximum compute capacity and to select a higher frequency than the current one.

After the changes in 9c0b4bb7f630, the performance margin was applied
earlier in the path to take into account utilization clampings and
we couldn't get a utilization higher than the maximum compute capacity,
and the CPU remained 'stuck' at lower frequencies.

To fix this, we must use a frequency above the current frequency to
get a chance to select a higher OPP when the current one becomes fully used.
Apply the same margin and return a frequency 25% higher than the current
one in order to switch to the next OPP before we fully use the CPU
at the current one.

[ mingo: Clarified the changelog. ]

Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Bisected-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Wyes Karny <wkarny@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Wyes Karny <wkarny@gmail.com>
Link: https://lore.kernel.org/r/20240114183600.135316-1-vincent.guittot@linaro.org
---
 kernel/sched/cpufreq_schedutil.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 95c3c09..eece624 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
 	if (arch_scale_freq_invariant())
 		return policy->cpuinfo.max_freq;
 
-	return policy->cur;
+	/*
+	 * Apply a 25% margin so that we select a higher frequency than
+	 * the current one before the CPU is fully busy:
+	 */
+	return policy->cur + (policy->cur >> 2);
 }
 
 /**

