Return-Path: <linux-kernel+bounces-58011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C1B84E056
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A50B2D122
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643057D413;
	Thu,  8 Feb 2024 11:56:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7297D3ED;
	Thu,  8 Feb 2024 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393419; cv=none; b=pugkKUKYyjcHcYh+SoQlz4CLDEVgGBuGv5YFFPObHEjB9foixXnwwcl+RudmdiBgKwtaO2i9B6OewlooYGP3zyzEyefpiwbBJhDAtTW/Jy9GFO/TeFzKF2WLhMkIKFfVEfWjYAivYG3bzvba0xsfvy81KLGbWGACDE7H8WMvK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393419; c=relaxed/simple;
	bh=NpxfFJNwCfR0NV7bGJK2imc9EJ1KwDO/FM+S2qjTl28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkvOo4LqiYmWt9sLgrjnAvfl5k6c4c09qozFkSXBh+EhrGjWBg46iqo9OQLgdene638QPWgCMSKbmuk1ey/YjmEYx2+Og01eHmQGGAvH3aHIp8PuFkg4sykfJLFxt2YLM8J9FNYeJs1omONV6HzLAZHRq5jQIgtinpovWmOreIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D326F1FB;
	Thu,  8 Feb 2024 03:57:38 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F260D3F5A1;
	Thu,  8 Feb 2024 03:56:53 -0800 (PST)
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
Subject: [PATCH v8 17/23] powercap/dtpm_devfreq: Use new Energy Model interface to get table
Date: Thu,  8 Feb 2024 11:55:51 +0000
Message-Id: <20240208115557.1273962-18-lukasz.luba@arm.com>
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

Energy Model framework support modifications at runtime of the power
values. Use the new EM table API which is protected with RCU. Align the
code so that this RCU read section is short.

This change is not expected to alter the general functionality.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm_devfreq.c | 34 ++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index 612c3b59dd5b..f40bce8176df 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -37,11 +37,16 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	struct devfreq *devfreq = dtpm_devfreq->devfreq;
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
+	struct em_perf_state *table;
 
-	dtpm->power_min = pd->table[0].power;
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
 
-	dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
+	dtpm->power_min = table[0].power;
 
+	dtpm->power_max = table[pd->nr_perf_states - 1].power;
+
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -51,20 +56,23 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	struct devfreq *devfreq = dtpm_devfreq->devfreq;
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
+	struct em_perf_state *table;
 	unsigned long freq;
 	int i;
 
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
 	for (i = 0; i < pd->nr_perf_states; i++) {
-		if (pd->table[i].power > power_limit)
+		if (table[i].power > power_limit)
 			break;
 	}
 
-	freq = pd->table[i - 1].frequency;
+	freq = table[i - 1].frequency;
+	power_limit = table[i - 1].power;
+	rcu_read_unlock();
 
 	dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
 
-	power_limit = pd->table[i - 1].power;
-
 	return power_limit;
 }
 
@@ -89,8 +97,9 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
 	struct devfreq_dev_status status;
+	struct em_perf_state *table;
 	unsigned long freq;
-	u64 power;
+	u64 power = 0;
 	int i;
 
 	mutex_lock(&devfreq->lock);
@@ -100,19 +109,22 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 	freq = DIV_ROUND_UP(status.current_frequency, HZ_PER_KHZ);
 	_normalize_load(&status);
 
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		if (pd->table[i].frequency < freq)
+		if (table[i].frequency < freq)
 			continue;
 
-		power = pd->table[i].power;
+		power = table[i].power;
 		power *= status.busy_time;
 		power >>= 10;
 
-		return power;
+		break;
 	}
+	rcu_read_unlock();
 
-	return 0;
+	return power;
 }
 
 static void pd_release(struct dtpm *dtpm)
-- 
2.25.1


