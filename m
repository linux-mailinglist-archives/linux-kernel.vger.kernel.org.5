Return-Path: <linux-kernel+bounces-74888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5685DF39
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BC81F238D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D57C6E9;
	Wed, 21 Feb 2024 14:25:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFB7C0A4;
	Wed, 21 Feb 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525549; cv=none; b=TiFWRRVt07IsJeLHsP9Fx2woT3mytjtn8hRhemS9FKvbOZF0MKnIBCy80m6+bB9rLLG4uGcRmBBPQJEeB1Q+A4DUHMJdlWqKM7VjOKjKIpDS4TCWp9H/E2XrLG8Buc+1LyKL8gwvjLh0B+tTkP/9thMxHFw4CB3CHcyEExKOBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525549; c=relaxed/simple;
	bh=FN17hH5gkQQBYlZx2WhO542GI/gzqDhOeYOvKF8ZGgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NyPMEs6HcY6d5004+HpvdUckW/8WRri0YXi92ojUHHB0ooIVi3z3ke272BurSGk2yNVuP8WVTvKHQh5vBLpIBae7rq3GeVgoqxwtnKA64Kr5p0kThHLIgK0SU4T6G0x+J96UtF9QYH3ZD3cuQxgt5YSh8xXqSOtCWjBMl81hqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6B31007;
	Wed, 21 Feb 2024 06:26:25 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.11.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88D793F762;
	Wed, 21 Feb 2024 06:25:45 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] PM: EM: Fix nr_states warnings in static checks
Date: Wed, 21 Feb 2024 14:25:50 +0000
Message-Id: <20240221142550.1814055-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the static checks nr_states has been mentioned by the kernel test
robot. Fix the warning in those 2 places.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 7101fa3fa0c0..b686ac0345bd 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -280,6 +280,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
  * em_dev_compute_costs() - Calculate cost values for new runtime EM table
  * @dev		: Device for which the EM table is to be updated
  * @table	: The new EM table that is going to get the costs calculated
+ * @nr_states	: Number of performance states
  *
  * Calculate the em_perf_state::cost values for new runtime EM table. The
  * values are used for EAS during task placement. It also calculates and sets
@@ -728,7 +729,6 @@ static void em_check_capacity_update(void)
 		struct cpufreq_policy *policy;
 		unsigned long em_max_perf;
 		struct device *dev;
-		int nr_states;
 
 		if (cpumask_test_cpu(cpu, cpu_done_mask))
 			continue;
@@ -749,7 +749,6 @@ static void em_check_capacity_update(void)
 		cpumask_or(cpu_done_mask, cpu_done_mask,
 			   em_span_cpus(pd));
 
-		nr_states = pd->nr_perf_states;
 		cpu_capacity = arch_scale_cpu_capacity(cpu);
 
 		rcu_read_lock();
-- 
2.25.1


