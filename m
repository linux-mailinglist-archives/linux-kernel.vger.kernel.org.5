Return-Path: <linux-kernel+bounces-32792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8783601F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB9EB28918
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ABB3A287;
	Mon, 22 Jan 2024 10:53:25 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FA3A262;
	Mon, 22 Jan 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920804; cv=none; b=d1sYyOX41FzeOcg/irKFMBz3YO4s+dlQYs8JEPZ45BgZpeeGul8ylMccEuQSYhZ8OS2X6qubLkl+OHUo3GrsVakXs3mlUzEYLUu3FXugnyEnsJsLR0oqXR4PwW+oUDY03VD6gehnYUJnusMLuvR44PwI27qA67OaFjjLmzM/a9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920804; c=relaxed/simple;
	bh=L5FK5n7+byXHvnUmc8Yx9kLf5H8D13l2oGTx6wWEyso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvm0Qgmj66VkvMu8pp4vzCb3XPkP2dEyk0Kpp/1P/3zmzuSajiOlP/PZz8QxlzXEq5to8Uq1WhcR0Marmq0kXLzGw82OCZBxdMRB+btRdasIXeApwqaCPm2Y0ktP8/N+TK34nGJhWZ0fVI+QuKgk6Ih2NF57oxPLTc2owCpklfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 96ff3509ed9fbd29; Mon, 22 Jan 2024 11:53:14 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 010D666952F;
	Mon, 22 Jan 2024 11:53:13 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: rafael@kernel.org, viresh.kumar@linaro.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Directly use stored ratios for max frequencies
Date: Mon, 22 Jan 2024 11:53:13 +0100
Message-ID: <6021639.lOV4Wx5bFT@kreacher>
In-Reply-To: <20240118120513.1018808-1-srinivas.pandruvada@linux.intel.com>
References: <20240118120513.1018808-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

On Thursday, January 18, 2024 1:05:13 PM CET Srinivas Pandruvada wrote:
> Avoid unnecessary calculation for converting frequency to performance
> ratio by using a scaling factor for the maximum non turbo and turbo
> frequency. Here the driver already stored performance ratios for max
> non turbo and turbo frequency by reading from MSR_HWP_CAPABILITIES.
> Directly use those ratios without any calculations.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2ca70b0b5fdc..6bbc21ca96e0 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2532,7 +2532,14 @@ static void intel_pstate_update_perf_limits(struct cpudata *cpu,
>  		int freq;
>  
>  		freq = max_policy_perf * perf_ctl_scaling;
> -		max_policy_perf = DIV_ROUND_UP(freq, scaling);
> +
> +		if (freq == cpu->pstate.turbo_freq)
> +			max_policy_perf = cpu->pstate.turbo_pstate;
> +		else if (freq == cpu->pstate.max_freq)
> +			max_policy_perf = cpu->pstate.max_pstate;
> +		else
> +			max_policy_perf = DIV_ROUND_UP(freq, scaling);
> +
>  		freq = min_policy_perf * perf_ctl_scaling;
>  		min_policy_perf = DIV_ROUND_UP(freq, scaling);
>  	}
> 

This needs to take all of the cases in which the analogous formula
for computing a perf level is used, which are a few.

Also, one can argue that this is a fix, because it prevents the CPU
capacity from being limited artificially if the E-core-to-P-core scaling
factor used by the platform to produce the HWP_CAP numbers is smaller
than expected by the kernel.

So here's my version of this patch (lightly tested):

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] cpufreq: intel_pstate: Refine computation of P-state for given frequency

On systems using HWP, if a given frequency is equal to the maximum turbo
frequency or the maximum non-turbo frequency, the HWP performance level
corresponding to it is already known and can be used directly without
any computation.

Accordingly, adjust the code to use the known HWP performance levels in
the cases mentioned above.

This also helps to avoid limiting CPU capacity artificially in some
cases when the BIOS produces the HWP_CAP numbers using a different
E-core-to-P-core performance scaling factor than expected by the kernel.

Fixes: f5c8cf2a4992 ("cpufreq: intel_pstate: hybrid: Use known scaling factor for P-cores")
Cc: 6.1+ <stable@vger.kernel.org> # 6.1+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   55 +++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -529,6 +529,30 @@ static int intel_pstate_cppc_get_scaling
 }
 #endif /* CONFIG_ACPI_CPPC_LIB */
 
+static int intel_pstate_freq_to_hwp_rel(struct cpudata *cpu, int freq,
+					unsigned int relation)
+{
+	if (freq == cpu->pstate.turbo_freq)
+		return cpu->pstate.turbo_pstate;
+
+	if (freq == cpu->pstate.max_freq)
+		return cpu->pstate.max_pstate;
+
+	switch (relation) {
+	case CPUFREQ_RELATION_H:
+		return freq / cpu->pstate.scaling;
+	case CPUFREQ_RELATION_C:
+		return DIV_ROUND_CLOSEST(freq, cpu->pstate.scaling);
+	}
+
+	return DIV_ROUND_UP(freq, cpu->pstate.scaling);
+}
+
+static int intel_pstate_freq_to_hwp(struct cpudata *cpu, int freq)
+{
+	return intel_pstate_freq_to_hwp_rel(cpu, freq, CPUFREQ_RELATION_L);
+}
+
 /**
  * intel_pstate_hybrid_hwp_adjust - Calibrate HWP performance levels.
  * @cpu: Target CPU.
@@ -546,6 +570,7 @@ static void intel_pstate_hybrid_hwp_adju
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
 	int perf_ctl_turbo = pstate_funcs.get_turbo(cpu->cpu);
 	int scaling = cpu->pstate.scaling;
+	int freq;
 
 	pr_debug("CPU%d: perf_ctl_max_phys = %d\n", cpu->cpu, perf_ctl_max_phys);
 	pr_debug("CPU%d: perf_ctl_turbo = %d\n", cpu->cpu, perf_ctl_turbo);
@@ -559,16 +584,16 @@ static void intel_pstate_hybrid_hwp_adju
 	cpu->pstate.max_freq = rounddown(cpu->pstate.max_pstate * scaling,
 					 perf_ctl_scaling);
 
-	cpu->pstate.max_pstate_physical =
-			DIV_ROUND_UP(perf_ctl_max_phys * perf_ctl_scaling,
-				     scaling);
+	freq = perf_ctl_max_phys * perf_ctl_scaling;
+	cpu->pstate.max_pstate_physical = intel_pstate_freq_to_hwp(cpu, freq);
 
-	cpu->pstate.min_freq = cpu->pstate.min_pstate * perf_ctl_scaling;
+	freq = cpu->pstate.min_pstate * perf_ctl_scaling;
+	cpu->pstate.min_freq = freq;
 	/*
 	 * Cast the min P-state value retrieved via pstate_funcs.get_min() to
 	 * the effective range of HWP performance levels.
 	 */
-	cpu->pstate.min_pstate = DIV_ROUND_UP(cpu->pstate.min_freq, scaling);
+	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, freq);
 }
 
 static inline void update_turbo_state(void)
@@ -2528,13 +2553,12 @@ static void intel_pstate_update_perf_lim
 	 * abstract values to represent performance rather than pure ratios.
 	 */
 	if (hwp_active && cpu->pstate.scaling != perf_ctl_scaling) {
-		int scaling = cpu->pstate.scaling;
 		int freq;
 
 		freq = max_policy_perf * perf_ctl_scaling;
-		max_policy_perf = DIV_ROUND_UP(freq, scaling);
+		max_policy_perf = intel_pstate_freq_to_hwp(cpu, freq);
 		freq = min_policy_perf * perf_ctl_scaling;
-		min_policy_perf = DIV_ROUND_UP(freq, scaling);
+		min_policy_perf = intel_pstate_freq_to_hwp(cpu, freq);
 	}
 
 	pr_debug("cpu:%d min_policy_perf:%d max_policy_perf:%d\n",
@@ -2908,18 +2932,7 @@ static int intel_cpufreq_target(struct c
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 
-	switch (relation) {
-	case CPUFREQ_RELATION_L:
-		target_pstate = DIV_ROUND_UP(freqs.new, cpu->pstate.scaling);
-		break;
-	case CPUFREQ_RELATION_H:
-		target_pstate = freqs.new / cpu->pstate.scaling;
-		break;
-	default:
-		target_pstate = DIV_ROUND_CLOSEST(freqs.new, cpu->pstate.scaling);
-		break;
-	}
-
+	target_pstate = intel_pstate_freq_to_hwp_rel(cpu, freqs.new, relation);
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, false);
 
 	freqs.new = target_pstate * cpu->pstate.scaling;
@@ -2937,7 +2950,7 @@ static unsigned int intel_cpufreq_fast_s
 
 	update_turbo_state();
 
-	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
+	target_pstate = intel_pstate_freq_to_hwp(cpu, target_freq);
 
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
 




