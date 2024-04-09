Return-Path: <linux-kernel+bounces-137233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3089E030
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD48B3381E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C26A13D603;
	Tue,  9 Apr 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cZ48z1uN"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FADA1350EA;
	Tue,  9 Apr 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676634; cv=none; b=H7EHo2lCKV4W7XPhJ0cA9Kykj8MRFckyNIVEXwRRBNzyY17VWGoSV0kMlzDm5OG9F/MNjkLmd1LRY2NfgWZysTpL5wWffbEfuZH9I3tlAt1K9puWpDhP6/4l72QInLYK5CTCm/n3Invyii19BQKA7hnFETuAiuj56eu1D02hYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676634; c=relaxed/simple;
	bh=bO8+JxJJ+jOpvLRPOxTz7o4jgTkbhw8KAAg+RhqSWHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TEMAYdu7kUJ+GB/OI/QxfaWeZ0ozVieVj/zNZaHPVBahwuFh3HwZiXZHYVDjV+EAPkNRtZaYh6FzVyoBsHLkm4nq17kE/yAbkmjlpw2V0Q/MVDcZ8RsbACXkQ1SuAuvyhRKOkXJYL6p9zCHBsqz1qXbPDgLU8doihSrkX3IIV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cZ48z1uN; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KMeVx
	9urEbgIiWLKZLj3qrvOfX+TjMtH4pk5sw16JKM=; b=cZ48z1uNDiCg9DxPE3kL4
	nAJoCXYuZAea0++lEQ2WbjIYPNFFzZ+zvCYOah/F9/OWfuexyInpBoKzYilKwxWE
	t9eje8qx/snD8MAVlkl+YAUL0ukfCb5LfYWnz/gh+BaVbdpcDqYtcV+UBVAU2sIR
	pFbV3Gv5VRq8K0OjX5LcKI=
Received: from localhost.localdomain (unknown [101.86.11.106])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3vzSsXhVmuJxkAg--.27367S4;
	Tue, 09 Apr 2024 23:29:11 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	marcan@marcan.st,
	sven@svenpeter.dev,
	alyssa@rosenzweig.io,
	mmayer@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] cpufreq: Convert to exit callback returning void
Date: Tue,  9 Apr 2024 08:28:37 -0700
Message-Id: <20240409152837.5792-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vzSsXhVmuJxkAg--.27367S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF4UXFy3Xw4fZFyDXrW7XFb_yoWxJw43pF
	W5urWjyr48JFWDt3srCw4Du3Wak3Z2y3yUG345GasYvw17JF1Yg3WDGryUCFZ5urWkGF4a
	yrn5Xay7GF48JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKAq7q2XAk0Zm+QAAsd

For the exit() callback function returning an int type value,
this leads many driver authors mistakenly believing that error
handling can be performed by returning an error code. However,
the returned value is ignored, and to improve this situation.
it is proposed to modify the return type of the exit() callback
function to void.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/cpufreq/acpi-cpufreq.c      | 4 +---
 drivers/cpufreq/apple-soc-cpufreq.c | 4 +---
 drivers/cpufreq/bmips-cpufreq.c     | 4 +---
 drivers/cpufreq/cppc_cpufreq.c      | 3 +--
 drivers/cpufreq/cpufreq-dt.c        | 3 +--
 drivers/cpufreq/cpufreq-nforce2.c   | 6 ------
 drivers/cpufreq/e_powersaver.c      | 3 +--
 include/linux/cpufreq.h             | 2 +-
 8 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..33f18140e9a4 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -906,7 +906,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return result;
 }
 
-static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static void acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 
@@ -919,8 +919,6 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	free_cpumask_var(data->freqdomain_cpus);
 	kfree(policy->freq_table);
 	kfree(data);
-
-	return 0;
 }
 
 static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 021f423705e1..af34c22fa273 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -305,7 +305,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
-static int apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
+static void apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct apple_cpu_priv *priv = policy->driver_data;
 
@@ -313,8 +313,6 @@ static int apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 	iounmap(priv->reg_base);
 	kfree(priv);
-
-	return 0;
 }
 
 static struct cpufreq_driver apple_soc_cpufreq_driver = {
diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
index 39221a9a187a..17a4c174553d 100644
--- a/drivers/cpufreq/bmips-cpufreq.c
+++ b/drivers/cpufreq/bmips-cpufreq.c
@@ -121,11 +121,9 @@ static int bmips_cpufreq_target_index(struct cpufreq_policy *policy,
 	return 0;
 }
 
-static int bmips_cpufreq_exit(struct cpufreq_policy *policy)
+static void bmips_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	kfree(policy->freq_table);
-
-	return 0;
 }
 
 static int bmips_cpufreq_init(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 64420d9cfd1e..dccb9c1f087d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -688,7 +688,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
-static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
@@ -705,7 +705,6 @@ static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 			 caps->lowest_perf, cpu, ret);
 
 	cppc_cpufreq_put_cpu_data(policy);
-	return 0;
 }
 
 static inline u64 get_delta(u64 t1, u64 t0)
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 2d83bbc65dd0..eaf02579ea74 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -166,10 +166,9 @@ static int cpufreq_offline(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int cpufreq_exit(struct cpufreq_policy *policy)
+static void cpufreq_exit(struct cpufreq_policy *policy)
 {
 	clk_put(policy->clk);
-	return 0;
 }
 
 static struct cpufreq_driver dt_cpufreq_driver = {
diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index f7a7bcf6f52e..fedad1081973 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -359,11 +359,6 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int nforce2_cpu_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver nforce2_driver = {
 	.name = "nforce2",
 	.flags = CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
@@ -371,7 +366,6 @@ static struct cpufreq_driver nforce2_driver = {
 	.target = nforce2_target,
 	.get = nforce2_get,
 	.init = nforce2_cpu_init,
-	.exit = nforce2_cpu_exit,
 };
 
 #ifdef MODULE
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index ab93bce8ae77..6e958b09e1b5 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -360,14 +360,13 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int eps_cpu_exit(struct cpufreq_policy *policy)
+static void eps_cpu_exit(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 
 	/* Bye */
 	kfree(eps_cpu[cpu]);
 	eps_cpu[cpu] = NULL;
-	return 0;
 }
 
 static struct cpufreq_driver eps_driver = {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9956afb9acc2..ffb8d85d73ee 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -386,7 +386,7 @@ struct cpufreq_driver {
 
 	int		(*online)(struct cpufreq_policy *policy);
 	int		(*offline)(struct cpufreq_policy *policy);
-	int		(*exit)(struct cpufreq_policy *policy);
+	void		(*exit)(struct cpufreq_policy *policy);
 	int		(*suspend)(struct cpufreq_policy *policy);
 	int		(*resume)(struct cpufreq_policy *policy);
 
-- 
2.25.1


