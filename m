Return-Path: <linux-kernel+bounces-113543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62788852B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4903D1C2474F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE31C2326;
	Sun, 24 Mar 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+0FmSk/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293E1C230D;
	Sun, 24 Mar 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320345; cv=none; b=S7DsZZ7LFX5K0kr96cOfRx+L5g5yj4nOsg+EkeHjhmPZaz6lFrN9A+FgfgywvgBpFeJDGDiseLPYbu/qwokRfqSF5U+3D/1MIKs1YcbMYLTOjTYK6pGvOvEQ0rS27a5KE5NhnWb1xNKNCX5MkgrkrtFPhPwwJf538Zj8tU+JWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320345; c=relaxed/simple;
	bh=5owybSETCYpp/UVbihl69EMPTb3L1SV374MwjH88fko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdokLhIPiuYpBGLMcBeV3d1BlSyDmIpUq+YR6WRiqJE81XtmcwuxxeV80lf0eryEbrGq3/yzcW8RXPWI0dzUROAvQ1IifPQ2D4Q8Ed21686b9BAyFMLtEIQ/Ye1RNvBhzuRvuVBsrVgLluyZAQ3Tif0MF4sifBW5UlPSiZ/jRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+0FmSk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E56C433F1;
	Sun, 24 Mar 2024 22:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320345;
	bh=5owybSETCYpp/UVbihl69EMPTb3L1SV374MwjH88fko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+0FmSk/WxMrNY89fwtJ94E1v8m/mqROOLlttugudbRMzkXRAWpAtLYNPDL+9eQji
	 WxKjH7Q2MrjCblJYym3wAtp4vp/5iOU0yXuGgCXfDCGu/y3UMM+66D7eWD+MVH0qL4
	 3yVTY4uVdtGueR2v+V/UO7/vJWFklfYUYphBg3CRReawyy0U83Q2g7Ebrxn8Xz6McS
	 rkR3O1ob2kDfYNM0tJ28cgHwp+Bn5iS0frpLK5GWlq6ikVn3yF5EqKZzob5a7ehXLS
	 Vnzmssuw6o3+S8FDUVo4fhA6EtWV6ElQ7bfMSw+2/geUDnAn3XiIENsKdp8eHL3VQC
	 A35H7MxsOc9cQ==
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
Subject: [PATCH 6.8 652/715] cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()
Date: Sun, 24 Mar 2024 18:33:51 -0400
Message-ID: <20240324223455.1342824-653-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 44db4f59c4cc6..7d570b44777ac 100644
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


