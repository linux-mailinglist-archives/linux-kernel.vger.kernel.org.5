Return-Path: <linux-kernel+bounces-107189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01087F8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B11F225E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2154665;
	Tue, 19 Mar 2024 08:04:08 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416650249;
	Tue, 19 Mar 2024 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835448; cv=none; b=LVTWwgj8dzI5780xZI0zhoiY5rW9bXgNUDPz0LWY+CdfN8f1LNCGOkOoJPP5lDK9f0srrZqOjiH6e2WNDhBTikCROl9qlv9FoHnAvuyxjmqMQJLvD5fncIHLJkkBR3tNvl3jqWQLIsvZx5vAOBJvMIWpccRnw0z7m3CTxVnHc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835448; c=relaxed/simple;
	bh=jPagy+6Vtiqf4ADTxsQnEjlQZkWSGwoCZ/usyF4Bckg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nc/iAIaaGhyUt7gN51AVXlzGocW3MSqTW4IvAe8BzyktfZKg1/WyT68CaGQk0g1uCTl3c1rJ/x+JuuVOVt3t89KsYMR8JqJDQTy3Gl2xIWpUburM4dCsEwLSja/HCyNLVUSolw5eWLmA9HZ47nD/KBlvQAgMXSnfcD9etnINL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42J826Dn062112;
	Tue, 19 Mar 2024 16:02:06 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TzPKg1K50z2LJNYK;
	Tue, 19 Mar 2024 16:00:39 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 19 Mar 2024 16:02:04 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <ke.wang@unisoc.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xuewen.yan94@gmail.com>,
        <di.shen@unisoc.com>
Subject: [PATCH] cpufreq: Use a smaller freq for the policy->max when verify
Date: Tue, 19 Mar 2024 16:01:53 +0800
Message-ID: <20240319080153.3263-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 42J826Dn062112

When driver use the cpufreq_frequency_table_verify() as the
cpufreq_driver->verify's callback. It may cause the policy->max
bigger than the freq_qos's max freq.

Just as follow:

unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_available_frequencies
614400 768000 988000 1228800 1469000 1586000 1690000 1833000 2002000 2093000

unisoc:/sys/devices/system/cpu/cpufreq/policy0 # echo 1900000 > scaling_max_freq
unisoc:/sys/devices/system/cpu/cpufreq/policy0 # echo 1900000 > scaling_min_freq
unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_max_freq
2002000
unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_min_freq
2002000

When user set the qos_min and qos_max as the same value, and the value
is not in the freq-table, the above scenario will occur.

This is because in cpufreq_frequency_table_verify() func, when it can not
find the freq in table, it will change the policy->max to be a bigger freq,
as above, because there is no 1.9G in the freq-table, the policy->max would
be set to 2.002G. As a result, the cpufreq_policy->max is bigger than the
user's qos_max. This is unreasonable.

So use a smaller freq when can not find the freq in fre-table, to prevent
the policy->max exceed the qos's max freq.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/cpufreq/freq_table.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index c4d4643b6ca6..1d98b8cf1688 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -70,7 +70,7 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
 				   struct cpufreq_frequency_table *table)
 {
 	struct cpufreq_frequency_table *pos;
-	unsigned int freq, next_larger = ~0;
+	unsigned int freq, prev_smaller = 0;
 	bool found = false;
 
 	pr_debug("request for verification of policy (%u - %u kHz) for cpu %u\n",
@@ -86,12 +86,12 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
 			break;
 		}
 
-		if ((next_larger > freq) && (freq > policy->max))
-			next_larger = freq;
+		if ((prev_smaller < freq) && (freq <= policy->max))
+			prev_smaller = freq;
 	}
 
 	if (!found) {
-		policy->max = next_larger;
+		policy->max = prev_smaller;
 		cpufreq_verify_within_cpu_limits(policy);
 	}
 
-- 
2.25.1


