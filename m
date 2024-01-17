Return-Path: <linux-kernel+bounces-28782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792238302FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133532875BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48CC1EB49;
	Wed, 17 Jan 2024 09:56:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60381EB2F;
	Wed, 17 Jan 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485394; cv=none; b=eIvRiQii+uYZzTSr1hJ0Tm5Ep7zIt4I6EQCbN7AWb1BkIYryE10YqJ4UR6lHV4gwadAJ691QnHth4wdXYeNwNy6bG5pw7NZSgLLiWCC3WI9uYXQGgU987Y/wPNHMEDyYeG5TmUwSMSI1eSOYfcMGgHFVlBYjK+PiOl/FUM3hrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485394; c=relaxed/simple;
	bh=gHen9X6HPGwhxQEt4lAep0V5ayco+8boFV7pC+UpjsY=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=Vv4VT9GvTTeKHiqWidhgP90lWhxU27P7qu4NfJALoLNTc4x0fbSpOnkQJSqQxOw2hBNjJG/hgEoLOk6dpBCfniD/tN0zuBOmUZ/DW97TNEU2WXbluGYFO8Xo1RbSk1SmNl7+8rPX1cBdk3WJnGZs5SBlgjC5vdLt9rs3+tVQyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97303DA7;
	Wed, 17 Jan 2024 01:57:18 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2BF13F5A1;
	Wed, 17 Jan 2024 01:56:29 -0800 (PST)
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
Subject: [PATCH v7 12/23] PM: EM: Add em_perf_state_from_pd() to get performance states table
Date: Wed, 17 Jan 2024 09:57:03 +0000
Message-Id: <20240117095714.1524808-13-lukasz.luba@arm.com>
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

Introduce a wrapper to get the performance states table of the performance
domain. The function should be called within the RCU read critical
section.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 494df6942cf7..5ebe9dbec8e1 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -339,6 +339,23 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 	return pd->nr_perf_states;
 }
 
+/**
+ * em_perf_state_from_pd() - Get the performance states table of perf.
+ *				domain
+ * @pd		: performance domain for which this must be done
+ *
+ * To use this function the rcu_read_lock() should be hold. After the usage
+ * of the performance states table is finished, the rcu_read_unlock() should
+ * be called.
+ *
+ * Return: the pointer to performance states table of the performance domain
+ */
+static inline
+struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)
+{
+	return rcu_dereference(pd->em_table)->state;
+}
+
 #else
 struct em_data_callback {};
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
@@ -385,6 +402,11 @@ int em_dev_update_perf_domain(struct device *dev,
 {
 	return -EINVAL;
 }
+static inline
+struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)
+{
+	return NULL;
+}
 #endif
 
 #endif
-- 
2.25.1


