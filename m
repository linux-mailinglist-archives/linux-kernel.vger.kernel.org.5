Return-Path: <linux-kernel+bounces-28779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391848302F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608941C24517
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3511DFFB;
	Wed, 17 Jan 2024 09:56:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D271DFE4;
	Wed, 17 Jan 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485385; cv=none; b=WesBguIDJn7oq3+hiRCRw3W2AO5FSjgbXwR1X7Qv46kqupMKTsm8qDVzA4NWz2HsLxomUuJfrtdUxnCdyIkMW8m5Aa/byyoNxwkyIctemZBu9CGw5UiuXyw3wam69HNVyaKuJiW8qdGbLnhlzHPHy1gHLMY14anwTcep57E/hPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485385; c=relaxed/simple;
	bh=UPf3IlTjbfs1uJDF7MgDBR/YT9j9f7nwbAxnlwxTSxY=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=NoOW22rk6SedTYQciegYE+G9ioZkuq3wSiYy027b6taeDlwniZ5fhz06Jw5UsbeTdTb/YXtFqS0KaLJLcsXDg0g+8kauWLR9Tzia7fvVYn3G6RahVVY1LuDT/eLHn5p1cMbTBjjJNk9skt8hnMgnsYIzkv9NS7qu72pDs+9/ug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC31B11FB;
	Wed, 17 Jan 2024 01:57:09 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8D4A3F5A1;
	Wed, 17 Jan 2024 01:56:20 -0800 (PST)
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
Subject: [PATCH v7 09/23] PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
Date: Wed, 17 Jan 2024 09:57:00 +0000
Message-Id: <20240117095714.1524808-10-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
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

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 585c5ffc898b..fcd8de1a2dbd 100644
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
 
@@ -265,9 +270,10 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
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


