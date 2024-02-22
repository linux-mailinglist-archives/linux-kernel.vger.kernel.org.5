Return-Path: <linux-kernel+bounces-76650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832BB85FA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A771F240CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B245137C3B;
	Thu, 22 Feb 2024 13:57:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F35A1474C1;
	Thu, 22 Feb 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610242; cv=none; b=KYJzgxKiO2MBQ1aAAeTSzukZ8Q1OpNVpkzNALYAhLnRM0t6YEYxWkLFXtE56x3qbwKGhUZnQyY8JROm0ue26pTzF9xz3hR7eUQeZHkFezgeqzlM5KxWwEnYiRVvXuuH+VQsAe5Jr93QyWgCNj9UtRWVysmMaQmepUMnw6atKdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610242; c=relaxed/simple;
	bh=+gm91ZtyDofHjM2c3cnsnbGIdaQIAtNdEWIE4qR/lL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSlJEyo3bWGclTIMNMLE8SMll0EAk/cP4wF0ZZ+d+RvbClSCxy6lRKn9fW1t9SaXwrrr/0BDe7GkbBnYj7tRfRtTynJKapn6enbR8gh6r6P3NVU4vsVVteYJslHtPW+wailNrZ4+V9XwUc7dar+HwtYS/aOkfgxdf77SYZg/ZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4934B1007;
	Thu, 22 Feb 2024 05:57:59 -0800 (PST)
Received: from e126645.arm.com (unknown [10.57.50.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 946493F762;
	Thu, 22 Feb 2024 05:57:18 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/3] cpufreq: scmi: Set transition_delay_us
Date: Thu, 22 Feb 2024 14:57:01 +0100
Message-Id: <20240222135702.2005635-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222135702.2005635-1-pierre.gondois@arm.com>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the newly added callbacks:
- rate_limit_get()
- fast_switch_rate_limit()
to populate policies's `transition_delay_us`, defined as the
'Preferred average time interval between consecutive
invocations of the driver to set the frequency for this policy.'

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 4ee23f4ebf4a..0b483bd0d3ca 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -144,6 +144,29 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 	return 0;
 }
 
+static int
+scmi_get_rate_limit(u32 domain, bool has_fast_switch)
+{
+	int ret, rate_limit;
+
+	if (has_fast_switch) {
+		/*
+		 * Fast channels are used whenever available,
+		 * so use their rate_limit value if populated.
+		 */
+		ret = perf_ops->fast_switch_rate_limit(ph, domain,
+						       &rate_limit);
+		if (!ret && rate_limit)
+			return rate_limit;
+	}
+
+	ret = perf_ops->rate_limit_get(ph, domain, &rate_limit);
+	if (ret)
+		return 0;
+
+	return rate_limit;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp, domain;
@@ -250,6 +273,9 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		perf_ops->fast_switch_possible(ph, domain);
 
+	policy->transition_delay_us =
+		scmi_get_rate_limit(domain, policy->fast_switch_possible);
+
 	return 0;
 
 out_free_opp:
-- 
2.25.1


