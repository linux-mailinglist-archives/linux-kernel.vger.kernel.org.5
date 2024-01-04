Return-Path: <linux-kernel+bounces-17016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E35824730
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA141F21313
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC62E647;
	Thu,  4 Jan 2024 17:15:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41DE2E629;
	Thu,  4 Jan 2024 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D0271007;
	Thu,  4 Jan 2024 09:16:09 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDE523F64C;
	Thu,  4 Jan 2024 09:15:20 -0800 (PST)
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
Subject: [PATCH v6 12/23] PM: EM: Add helpers to read under RCU lock the EM table
Date: Thu,  4 Jan 2024 17:15:42 +0000
Message-Id: <20240104171553.2080674-13-lukasz.luba@arm.com>
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

To use the runtime modifiable EM table there is a need to use RCU
read locking properly. Add helper functions for the device drivers and
frameworks to make sure it's done properly.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index f33257ed83fd..cfaf5d8b1aad 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -338,6 +338,20 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 	return pd->nr_perf_states;
 }
 
+static inline struct em_perf_state *em_get_table(struct em_perf_domain *pd)
+{
+	struct em_perf_table __rcu *table;
+
+	rcu_read_lock();
+	table = rcu_dereference(pd->em_table);
+	return table->state;
+}
+
+static inline void em_put_table(void)
+{
+	rcu_read_unlock();
+}
+
 #else
 struct em_data_callback {};
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
@@ -384,6 +398,11 @@ int em_dev_update_perf_domain(struct device *dev,
 {
 	return -EINVAL;
 }
+static inline struct em_perf_state *em_get_table(struct em_perf_domain *pd)
+{
+	return NULL;
+}
+static inline void em_put_table(void) {}
 #endif
 
 #endif
-- 
2.25.1


