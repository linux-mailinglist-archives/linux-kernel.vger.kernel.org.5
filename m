Return-Path: <linux-kernel+bounces-58006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439EC84E02D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768211C262C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCC7318E;
	Thu,  8 Feb 2024 11:56:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F64D7AE62;
	Thu,  8 Feb 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393403; cv=none; b=Vq68Qmn7ROtnT37JJ9bUsp3bAU1RuHEv2f0nuHNNxVazEKrbEt77yZeDZe12l0emB18LsTBNxykzRQdnJNt2nTa7OrsgS66Kuh6zW5SYI7A2kzeEr+x3eRGB0BaL+OveS+W3xHJm7bcnnIMyZOVYJKk1kQGdR78rD5hlkoug6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393403; c=relaxed/simple;
	bh=t1KyvAYlPGYt5k4QNfvPcCk4liGk3G3znjAuCwRkKtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlMawcnW0V2rpm9OHZbIXaSMDI5BXsm9YBynNnD1geIcME4RrafRyGimkB0lga63BI7jOq4bQwsorGFuvqOC/PNof1VLHNAScUPL3M2fznWYXOK4o5Xgt+c4ycWNrq5chVmV1IpHjReWUY8yFIz7d9vbRG+ghDXov3QZllc1OU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D937F1FB;
	Thu,  8 Feb 2024 03:57:23 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 055293F5A1;
	Thu,  8 Feb 2024 03:56:38 -0800 (PST)
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
Subject: [PATCH v8 12/23] PM: EM: Add em_perf_state_from_pd() to get performance states table
Date: Thu,  8 Feb 2024 11:55:46 +0000
Message-Id: <20240208115557.1273962-13-lukasz.luba@arm.com>
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

Introduce a wrapper to get the performance states table of the performance
domain. The function should be called within the RCU read critical
section.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 324a3a8e0a2d..158dad6ea313 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -338,6 +338,23 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
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
@@ -384,6 +401,11 @@ int em_dev_update_perf_domain(struct device *dev,
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


