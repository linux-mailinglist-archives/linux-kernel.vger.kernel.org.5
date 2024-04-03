Return-Path: <linux-kernel+bounces-130187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3774A897524
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FC81C25C99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DA8152538;
	Wed,  3 Apr 2024 16:23:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184D15218F;
	Wed,  3 Apr 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161408; cv=none; b=fAtN3KhKF+oxT6fG77f+M3zyYcswJ5FOaCObpm65+CVytNEo/pUHaMTFyAoNZLJvfsrKKVkFMbLThEFhU7DaXei36pDRm7QCHLwLoKGBLVoulrXqWB2XWBSaFZwIurgH9U3vOtshlMpC8MYm2Y+FterIHC8wyhfkW1rSZuy+Kdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161408; c=relaxed/simple;
	bh=0eUlnvrqigfBBPIoBqRDi/ZXh4M8CY7dC6afPqLOJW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkLoZajq1UWwUv9l1pnsGL/SHNs69UMELK4KCLGTzxx/NBACnV26fqmPC6zY1YosWiVF84pyCoii1sQRzVysBdQ0oUv16OtRstCpd0vYPm2b9O2YUpFogsOfUQJm7reBCkbcllECDkRl4KuaLlHGtNHTbH62xENUDNkoh0Tt+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5430D1684;
	Wed,  3 Apr 2024 09:23:57 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A56D3F7B4;
	Wed,  3 Apr 2024 09:23:24 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	linux-samsung-soc@vger.kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	quic_sibis@quicinc.com
Subject: [PATCH 2/2] cpufreq: scmi: Update Energy Model with allowed performance limits
Date: Wed,  3 Apr 2024 17:23:15 +0100
Message-Id: <20240403162315.1458337-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403162315.1458337-1-lukasz.luba@arm.com>
References: <20240403162315.1458337-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Energy Model (EM) supports performance limits updates. Use the SCMI
notifications to get information from FW about allowed frequency scope for
the CPUs.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index d946b7a082584..90c8448578cb1 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -185,12 +185,25 @@ static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event,
 {
 	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
 	struct scmi_perf_limits_report *limit_notify = data;
+	unsigned int limit_freq_max_khz, limit_freq_min_khz;
 	struct cpufreq_policy *policy = priv->policy;
-	unsigned int limit_freq_khz;
+	struct em_perf_domain *pd;
+	int ret;
+
+	limit_freq_max_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
+	limit_freq_min_khz = limit_notify->range_min_freq / HZ_PER_KHZ;
 
-	limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
+	pd = em_cpu_get(policy->cpu);
+	if (pd) {
+		ret = em_update_performance_limits(pd, limit_freq_min_khz,
+						   limit_freq_max_khz);
+		if (ret)
+			dev_warn(priv->cpu_dev,
+				 "EM perf limits update failed\n");
+	}
 
-	policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
+	policy->max = clamp(limit_freq_max_khz, policy->cpuinfo.min_freq,
+			    policy->cpuinfo.max_freq);
 
 	cpufreq_update_pressure(policy);
 
-- 
2.25.1


