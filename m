Return-Path: <linux-kernel+bounces-17006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D131824718
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732451C24071
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9F28E2C;
	Thu,  4 Jan 2024 17:15:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6033428E23;
	Thu,  4 Jan 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D26CF153B;
	Thu,  4 Jan 2024 09:15:43 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 677083F64C;
	Thu,  4 Jan 2024 09:14:55 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com
Subject: [PATCH v6 03/23] PM: EM: Find first CPU active while updating OPP efficiency
Date: Thu,  4 Jan 2024 17:15:33 +0000
Message-Id: <20240104171553.2080674-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104171553.2080674-1-lukasz.luba@arm.com>
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Energy Model might be updated at runtime and the energy efficiency
for each OPP may change. Thus, there is a need to update also the
cpufreq framework and make it aligned to the new values. In order to
do that, use a first active CPU from the Performance Domain. This is
needed since the first CPU in the cpumask might be offline when we
run this code path.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 42486674b834..aa7c89f9e115 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -243,12 +243,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
 	struct em_perf_domain *pd = dev->em_pd;
 	struct cpufreq_policy *policy;
 	int found = 0;
-	int i;
+	int i, cpu;
 
 	if (!_is_cpu_device(dev) || !pd)
 		return;
 
-	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
+	/* Try to get a CPU which is active and in this PD */
+	cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
+	if (cpu >= nr_cpu_ids) {
+		dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
+		return;
+	}
+
+	policy = cpufreq_cpu_get(cpu);
 	if (!policy) {
 		dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
 		return;
-- 
2.25.1


