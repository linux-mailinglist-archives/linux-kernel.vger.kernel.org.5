Return-Path: <linux-kernel+bounces-115564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A61889425
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22579296D84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04224E3D0;
	Mon, 25 Mar 2024 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm7lNIKf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8512D1FA;
	Sun, 24 Mar 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321095; cv=none; b=XeHH2aGZAMFtzAtBKkPs3iC3zOWnhBHJrfg8p4vc5cyKTY7Lm8VecaPX+WLqVImdOaKWeGY3rYV92vpkcyj8N/NQzLhSrVzFR46+KsuMXtGY00PE0waJtsrhNkkFkUlfvaUsEWUAwkkKEdI7QSZXFpiYwZpHOe2Eh4ySd2Ec/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321095; c=relaxed/simple;
	bh=p65xs8vC9CJdrFtATSUTKtFfuO2Na/xsx+WT/DECHWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAptNlXJE7xmczuzL1gXbhYCm2gAXNJ41c8IpWYGHRYvKj7ufKbaz8vBtDkNX9vkYuS4Uryro9vqXu9dYbO5T4fo3vzdEKW3eBSZZiTWqJLShhQcxTRtUSWH5jGXRfCN732aUU/FUxKWHPJpc3zg5HCdOI82BJL6VLsfcVo5Qe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm7lNIKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D018C433F1;
	Sun, 24 Mar 2024 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321095;
	bh=p65xs8vC9CJdrFtATSUTKtFfuO2Na/xsx+WT/DECHWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jm7lNIKf9zakiaVdEtlMgakXJddYJ3/jiEzW3fj/kyg41Ehe3gBfRE7FEoWYIVY8j
	 O4cIjKCBoir6h80cJC3I5v6p+g+Tn319usLQ8yUMLNrrWQCjZ7qQ8XBJd51VadhOL0
	 h6ty1eENvoPNh6dO+x/7112MkvFs4mEltp0PJA5hethEA6Wp3+l+5Dp+3pJlgygNmT
	 A10JEfGBBfg8wHS8MxOh1vWH1e86V2Fn9HMK2KBZ7HOEiZqKAgvc0ShFeeOv8I27TY
	 pZS6n/mL3aUQ8DUv0uJAzUpgEmUmqtm/+Mpja7mTX3qk+GFkCYwE7LAWdVR61umCye
	 W9CcZIemHAzqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dhruva Gole <d-gole@ti.com>,
	Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 658/713] cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()
Date: Sun, 24 Mar 2024 18:46:24 -0400
Message-ID: <20240324224720.1345309-659-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sibi Sankar <quic_sibis@quicinc.com>

[ Upstream commit f37a4d6b4a2c77414e8b9d25dd5ee31537ce9b00 ]

In the existing code, per-policy flags don't have any impact i.e.
if cpufreq_driver boost is enabled and boost is disabled for one or
more of the policies, the cpufreq driver will behave as if boost is
enabled.

Fix this by incorporating per-policy boost flag in the policy->max
computation used in cpufreq_frequency_table_cpuinfo and setting the
default per-policy boost to mirror the cpufreq_driver boost flag.

Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Tested-by:Yipeng Zou <zouyipeng@huawei.com> <mailto:zouyipeng@huawei.com>
Reviewed-by: Yipeng Zou <zouyipeng@huawei.com> <mailto:zouyipeng@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c    | 18 ++++++++++++------
 drivers/cpufreq/freq_table.c |  2 +-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 934d35f570b7a..5104f853a923e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -644,14 +644,16 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
 	if (policy->boost_enabled == enable)
 		return count;
 
+	policy->boost_enabled = enable;
+
 	cpus_read_lock();
 	ret = cpufreq_driver->set_boost(policy, enable);
 	cpus_read_unlock();
 
-	if (ret)
+	if (ret) {
+		policy->boost_enabled = !policy->boost_enabled;
 		return ret;
-
-	policy->boost_enabled = enable;
+	}
 
 	return count;
 }
@@ -1419,6 +1421,9 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_free_policy;
 		}
 
+		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
+		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+
 		/*
 		 * The initialization has succeeded and the policy is online.
 		 * If there is a problem with its frequency table, take it
@@ -2755,11 +2760,12 @@ int cpufreq_boost_trigger_state(int state)
 
 	cpus_read_lock();
 	for_each_active_policy(policy) {
+		policy->boost_enabled = state;
 		ret = cpufreq_driver->set_boost(policy, state);
-		if (ret)
+		if (ret) {
+			policy->boost_enabled = !policy->boost_enabled;
 			goto err_reset_state;
-
-		policy->boost_enabled = state;
+		}
 	}
 	cpus_read_unlock();
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index c4d4643b6ca65..c17dc51a5a022 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -40,7 +40,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 	cpufreq_for_each_valid_entry(pos, table) {
 		freq = pos->frequency;
 
-		if (!cpufreq_boost_enabled()
+		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
 		    && (pos->flags & CPUFREQ_BOOST_FREQ))
 			continue;
 
-- 
2.43.0


