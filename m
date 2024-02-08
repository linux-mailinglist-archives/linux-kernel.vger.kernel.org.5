Return-Path: <linux-kernel+bounces-58002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD07084E025
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9B11C260CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D3178B4B;
	Thu,  8 Feb 2024 11:56:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D276C8C;
	Thu,  8 Feb 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393395; cv=none; b=EHPF3sn6H6Tm5Oj+djv0oSMzvK3o5G/YbsRd8xIQgRracFad4RShO/PwpoW0h8q0dbW8xtqx70716cl9ztLaha07auqhbdiaFvPyqTHzaCiq3E2xLq4iJaTAx2Ye3WVAFw2/g+DeZrm8adeymspOMOZ5XLxTOj/FfDZsZ+xVkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393395; c=relaxed/simple;
	bh=jSDNw/gdJcgEyLMwynWhjBDaJb3Vfg+ndN6jLvTWrnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsDiU52HOnBD2TH1ARYvj99ykGkU3sxuCKb3mdeZZjdW9DAe+lLnUFcObwUNvL0tj/REtwVfPsK9SL9rzaN/khhr6fimeGgxYcmkEdYdWL11FPoPAiqI62WZOea23at/scH5J3ANugeJ04znIWqHL4p+Bw56+Gmt5t8CvRFad3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06C7B1FB;
	Thu,  8 Feb 2024 03:57:15 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 274A53F5A1;
	Thu,  8 Feb 2024 03:56:30 -0800 (PST)
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
	wvw@google.com,
	xuewen.yan94@gmail.com
Subject: [PATCH v8 09/23] PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
Date: Thu,  8 Feb 2024 11:55:43 +0000
Message-Id: <20240208115557.1273962-10-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208115557.1273962-1-lukasz.luba@arm.com>
References: <20240208115557.1273962-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new Energy Model (EM) supports runtime modification of the performance
state table to better model the power used by the SoC. Use this new
feature to improve energy estimation and therefore task placement in
Energy Aware Scheduler (EAS).

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 8ddf1d8a9581..5f842da3bb0c 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -239,9 +239,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long allowed_cpu_cap)
 {
 	unsigned long freq, ref_freq, scale_cpu;
+	struct em_perf_table *em_table;
 	struct em_perf_state *ps;
 	int cpu, i;
 
+#ifdef CONFIG_SCHED_DEBUG
+	WARN_ONCE(!rcu_read_lock_held(), "EM: rcu read lock needed\n");
+#endif
+
 	if (!sum_util)
 		return 0;
 
@@ -264,9 +269,10 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
-	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
-				      pd->flags);
-	ps = &pd->table[i];
+	em_table = rcu_dereference(pd->em_table);
+	i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
+				      freq, pd->flags);
+	ps = &em_table->state[i];
 
 	/*
 	 * The capacity of a CPU in the domain at the performance state (ps)
-- 
2.25.1


