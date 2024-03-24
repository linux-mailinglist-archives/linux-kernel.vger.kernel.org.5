Return-Path: <linux-kernel+bounces-114441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D099888FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11AC1F2D209
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB2A178CE6;
	Sun, 24 Mar 2024 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luljrPgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38621E320;
	Sun, 24 Mar 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321860; cv=none; b=okzuBRXY6eG3QP2YNvSrr3KN1YbuRf/ZU/m5p5T66WlEeVCjdzH0yo8BGAzovx0vxEcJRsEU+JGpUyZdy7bgzlz5mYiNEV1V8eX2bdnd8VL3qKBxVdvCwpexq18XTijFDGFWLoAgSbq/YY3NLBS54N8Q6byMzVk/AFO5ZPyPmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321860; c=relaxed/simple;
	bh=3S2RwZFT75eJhmbFon2zqX8sSbTuGW5cNX+oKcmp2es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTFwR6UMtB4oQbDOMmVeGPM1S6IZDkm5/Fua1aJZfY2eSUNyXJLRWKEV6ACHIW1qBZmx/kRWgfx+DgEsQGxYgNioSZvjcqpWd9OMyWWdXr306AsbeZd4x++PCTKk/0M+nHvQrxHL8w7uYsCF7SHo2UuaYZE2AXbOKlOr3SyN26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luljrPgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A32C433F1;
	Sun, 24 Mar 2024 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321859;
	bh=3S2RwZFT75eJhmbFon2zqX8sSbTuGW5cNX+oKcmp2es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luljrPgvgnh+8sSASifE0ytR5oiBiYtpEHcrVTqmDRL7fF1NmHnYcWFWWwiH1ZLXy
	 fj/34ej4soPB88GTjoGcDypiPyRLfj8eIdZ8IAgD8iXnfGWxrxyTDsLDypufgMTXMz
	 DAo/S4jfdn7LcPnSJczaDFOflS+h59nsexykav+pGPRhGmKNfuwoPv/uZDSxtqwtVq
	 /oju5AJaNhEtO1uJeWAa7ZekksnIRrv8dkJComsnpcbSKBEXT6q0saLyP2rUt+Sq7d
	 92zGIS8JkAIvkUrEkwa0ZcjGDEN/4KCCnuVgSGTJ1rq3UiTr4FldOAxJSY5jmKmx4o
	 qVD34hzIjvitA==
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
Subject: [PATCH 6.6 587/638] cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()
Date: Sun, 24 Mar 2024 19:00:24 -0400
Message-ID: <20240324230116.1348576-588-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 60ed89000e82d..4bc7c793de3b9 100644
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
@@ -2756,11 +2761,12 @@ int cpufreq_boost_trigger_state(int state)
 
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


