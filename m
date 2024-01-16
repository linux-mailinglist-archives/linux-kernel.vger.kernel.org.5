Return-Path: <linux-kernel+bounces-26617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7002C82E436
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CC41C2242A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221310A13;
	Tue, 16 Jan 2024 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrNUJl1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C5F9F6;
	Tue, 16 Jan 2024 00:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE47C43390;
	Tue, 16 Jan 2024 00:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705363735;
	bh=jPWL0niYtMIZ4LWIOzaXcxKw/FiVWY+7ZQrXeF2El8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrNUJl1RwH6vphCO04my5NfkqP1zMLhvulXHN/9OimLuh/H/VAI1w1h291gQrXUNK
	 XZuyJRbwMxxofirRoWKpi1UQKwKZqoXLc9X+VWJGFoorId7p7/kAVKD+DyG5btqrBq
	 jcvMIlVK9/8eUF83cPTINPs79+Pzl0kKxYqTrUULQ99ffLSOqN8xvmVpJbzslA2y/z
	 XXdqUMU68EurnfG1/UelV/jBobqMq2n+n9ytFYdaH98JVizvwMbtUWPI7lCrF6VreI
	 7GMbuEPkvvuoDcB6r91s3FsCwaTNOlnt6ctLJ6F+LXoQaOd/N2Pk7o31Ip42NAIRVQ
	 u6fCGaB5EjsqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 5/8] cpufreq: Use the fixed and coherent frequency for scaling capacity
Date: Mon, 15 Jan 2024 19:08:17 -0500
Message-ID: <20240116000838.212299-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116000838.212299-1-sashal@kernel.org>
References: <20240116000838.212299-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Vincent Guittot <vincent.guittot@linaro.org>

[ Upstream commit 599457ba15403037b489fe536266a3d5f9efaed7 ]

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different from the frequency that has been
used to compute the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent frequency
that can be used to compute the capacity for a given frequency.

[ Also fix a arch_set_freq_scale()  newline style wart in <linux/cpufreq.h>. ]

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20231211104855.558096-3-vincent.guittot@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 include/linux/cpufreq.h   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 934d35f570b7..44db4f59c4cc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -454,7 +454,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 
 	arch_set_freq_scale(policy->related_cpus,
 			    policy->cur,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 
 	spin_lock(&policy->transition_lock);
 	policy->transition_ongoing = false;
@@ -2174,7 +2174,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 
 	policy->cur = freq;
 	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 	cpufreq_stats_record_transition(policy, freq);
 
 	if (trace_cpu_frequency_enabled()) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 1c5ca92a0555..afda5f24d3dd 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1203,6 +1203,7 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.43.0


