Return-Path: <linux-kernel+bounces-57995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4E84E020
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE9B22D62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEA071B3A;
	Thu,  8 Feb 2024 11:56:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097146F539;
	Thu,  8 Feb 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393374; cv=none; b=buPSAkS4IWGv/Va7gUoj5EVww2HuYSoD740uREPxqCDeSMENlHYTranK+7jeu2hZvI0BfiHuo2tYm1Lj/FGKygi1vRSN1blRGE0tdjesY+AltgfwENNUxfZ3Z5tAp61QuCmbn5eYM6ieVDeP518L5hkIxhs4R4yQxkcBdV6hRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393374; c=relaxed/simple;
	bh=3JyBDbzGvfBhPotIs1tob8kBWsx0vCf+QiqaU2yqhXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QCDOTfLlwkCoo7z7JqreCrMP5TaHHlIOsESR85/btC5G1LnJhaVw8eLY2DXHVCCYRqLJHaG1y5/VptsocjbTub/mD7gnr2/LOuIDIeQ8fXn22Zq3CDZhdXoV4cmg7MTTBN8R2sRfQ8uF0RqXzY+RyD90F8bK+GMYlGk1QfE3aNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA411515;
	Thu,  8 Feb 2024 03:56:53 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA42B3F5A1;
	Thu,  8 Feb 2024 03:56:08 -0800 (PST)
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
	xuewen.yan94@gmail.com,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: [PATCH v8 02/23] PM: EM: Extend em_cpufreq_update_efficiencies() argument list
Date: Thu,  8 Feb 2024 11:55:36 +0000
Message-Id: <20240208115557.1273962-3-lukasz.luba@arm.com>
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

In order to prepare the code for the modifiable EM perf_state table,
make em_cpufreq_update_efficiencies() take a pointer to the EM table
as its second argument and modify it to use that new argument instead
of the 'table' member of dev->em_pd.

No functional impact.

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 8b9dd4a39f63..8c373b151875 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -237,15 +237,15 @@ static int em_create_pd(struct device *dev, int nr_states,
 	return 0;
 }
 
-static void em_cpufreq_update_efficiencies(struct device *dev)
+static void
+em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
 {
 	struct em_perf_domain *pd = dev->em_pd;
-	struct em_perf_state *table;
 	struct cpufreq_policy *policy;
 	int found = 0;
 	int i;
 
-	if (!_is_cpu_device(dev) || !pd)
+	if (!_is_cpu_device(dev))
 		return;
 
 	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
@@ -254,8 +254,6 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
 		return;
 	}
 
-	table = pd->table;
-
 	for (i = 0; i < pd->nr_perf_states; i++) {
 		if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
 			continue;
@@ -397,7 +395,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 	dev->em_pd->flags |= flags;
 
-	em_cpufreq_update_efficiencies(dev);
+	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
-- 
2.25.1


