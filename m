Return-Path: <linux-kernel+bounces-137136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DB89DD62
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE551F27391
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8256812F5A3;
	Tue,  9 Apr 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TQGwxGhn"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92450275;
	Tue,  9 Apr 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674609; cv=none; b=jhGviijee7PwxdKSn3/Tm90rhCA5CjYA8x1hHAj4JkuglOZ/wUVLBtjahw4++jvsbA5/byoAYxRzhBWJVCFfWdexkFBB4MsnkiDO74hDmk4lPVf460jANxVPYcMaxpzrAQnDinhCwfPelS2FKBUBRst0lrsUcF098yTe2xqCD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674609; c=relaxed/simple;
	bh=8UlTg8j6ocCBr9ZUSD4wmdtI2bTkObCtkFj62vhwuw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H/5kb4TcSkXNZ8RRm6CiX2w23YtJqjBjsEs8TDfGw9h5aDcZ9aI2gwEblqkoOOVnV3ZSti1vWcNV7zUbErrEUs8pLKhXpaKykt0n89Komjabx5rgkxRAZqpKqn+IT+p0cl6a2XiOmqrDc1UvNqdzc7/T9gerol1PWtrGRhXJyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TQGwxGhn; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zrsJr
	OCadXpPuoPk+52SBSIqCEh//3eDbnMhgnMRd0A=; b=TQGwxGhnjHFH5LunvhukP
	KTpHvSdd9t05bxDwU5bg81PfyCCAS7aF061G7rZktS1nOvNd4cdD++eZWrbNvhUb
	NM73OsakGQuDURSQN4iX2toLQwGlYzZK8L3Iifc5mpZHZnwNsGn2uICP1d4s4xZ5
	eVIr1LjSAOySORBeQdUVA4=
Received: from localhost.localdomain (unknown [101.86.11.106])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3H4hjVhVmOQRjAg--.14788S4;
	Tue, 09 Apr 2024 22:53:46 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com
Cc: inuxppc-dev@lists.ozlabs.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] cpufreq: Convert to exit callback returning void
Date: Tue,  9 Apr 2024 07:53:16 -0700
Message-Id: <20240409145316.5181-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H4hjVhVmOQRjAg--.14788S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3CFW5Wr4UJFyfAFy5tFW3GFg_yoWDuF48pF
	WUZrWvyrW8JF4Dtw17CF4Du34ak3Z2y3yUK345C3sYv3ZrJF15Wa4DGryUAF4FkrykWF4S
	yrn5tay7GF48JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zic18DUUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiWAW7q2VOCUOPmAABs6

For the exit() callback function returning an int type value,
this leads many driver authors mistakenly believing that error
handling can be performed by returning an error code. However,
the returned value is ignored, and to improve this situation,
it is proposed to modify the return type of the exit() callback
function to void.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/cpufreq/pasemi-cpufreq.c       | 4 +---
 drivers/cpufreq/powernv-cpufreq.c      | 4 +---
 drivers/cpufreq/ppc_cbe_cpufreq.c      | 3 +--
 drivers/cpufreq/qcom-cpufreq-hw.c      | 4 +---
 drivers/cpufreq/qoriq-cpufreq.c        | 4 +---
 drivers/cpufreq/scmi-cpufreq.c         | 4 +---
 drivers/cpufreq/scpi-cpufreq.c         | 4 +---
 drivers/cpufreq/sh-cpufreq.c           | 4 +---
 drivers/cpufreq/sparc-us2e-cpufreq.c   | 3 +--
 drivers/cpufreq/sparc-us3-cpufreq.c    | 3 +--
 drivers/cpufreq/speedstep-centrino.c   | 4 +---
 drivers/cpufreq/tegra194-cpufreq.c     | 4 +---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 3 +--
 13 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 039a66bbe1be..0c00a033bd9e 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -204,7 +204,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return err;
 }
 
-static int pas_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static void pas_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	/*
 	 * We don't support CPU hotplug. Don't unmap after the system
@@ -217,8 +217,6 @@ static int pas_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 		iounmap(sdcasr_mapbase);
 	if (sdcpwr_mapbase)
 		iounmap(sdcpwr_mapbase);
-
-	return 0;
 }
 
 static int pas_cpufreq_target(struct cpufreq_policy *policy,
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index fddbd1ea1635..50c62929f7ca 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -874,7 +874,7 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static void powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct powernv_smp_call_data freq_data;
 	struct global_pstate_info *gpstates = policy->driver_data;
@@ -886,8 +886,6 @@ static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 		del_timer_sync(&gpstates->timer);
 
 	kfree(policy->driver_data);
-
-	return 0;
 }
 
 static int powernv_cpufreq_reboot_notifier(struct notifier_block *nb,
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index 88afc49941b7..5ee4c7bfdcc5 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -113,10 +113,9 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static void cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	cbe_cpufreq_pmi_policy_exit(policy);
-	return 0;
 }
 
 static int cbe_cpufreq_target(struct cpufreq_policy *policy,
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 70b0f21968a0..bb818111162d 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -573,7 +573,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	return qcom_cpufreq_hw_lmh_init(policy, index);
 }
 
-static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
+static void qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	struct qcom_cpufreq_data *data = policy->driver_data;
@@ -583,8 +583,6 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	qcom_cpufreq_hw_lmh_exit(data);
 	kfree(policy->freq_table);
 	kfree(data);
-
-	return 0;
 }
 
 static void qcom_cpufreq_ready(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 0aecaecbb0e6..3519bf34d397 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -225,7 +225,7 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return -ENODEV;
 }
 
-static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static void qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cpu_data *data = policy->driver_data;
 
@@ -233,8 +233,6 @@ static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	kfree(data->table);
 	kfree(data);
 	policy->driver_data = NULL;
-
-	return 0;
 }
 
 static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 3b4f6bfb2f4c..bf5f17f0dfb1 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -308,7 +308,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
-static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
+static void scmi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scmi_data *priv = policy->driver_data;
 
@@ -316,8 +316,6 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 	free_cpumask_var(priv->opp_shared_cpus);
 	kfree(priv);
-
-	return 0;
 }
 
 static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index d33be56983ed..8d73e6e8be2a 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -167,7 +167,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
-static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
+static void scpi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scpi_data *priv = policy->driver_data;
 
@@ -175,8 +175,6 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 	kfree(priv);
-
-	return 0;
 }
 
 static struct cpufreq_driver scpi_cpufreq_driver = {
diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index b8704232c27b..aa74036d0420 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -135,14 +135,12 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int sh_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static void sh_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 	struct clk *cpuclk = &per_cpu(sh_cpuclk, cpu);
 
 	clk_put(cpuclk);
-
-	return 0;
 }
 
 static struct cpufreq_driver sh_cpufreq_driver = {
diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index 2783d3d55fce..8a0cd5312a59 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -296,10 +296,9 @@ static int us2e_freq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int us2e_freq_cpu_exit(struct cpufreq_policy *policy)
+static void us2e_freq_cpu_exit(struct cpufreq_policy *policy)
 {
 	us2e_freq_target(policy, 0);
-	return 0;
 }
 
 static struct cpufreq_driver cpufreq_us2e_driver = {
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index 6c3657679a88..b50f9d13e6d2 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -140,10 +140,9 @@ static int us3_freq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int us3_freq_cpu_exit(struct cpufreq_policy *policy)
+static void us3_freq_cpu_exit(struct cpufreq_policy *policy)
 {
 	us3_freq_target(policy, 0);
-	return 0;
 }
 
 static struct cpufreq_driver cpufreq_us3_driver = {
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 75b10ecdb60f..28e65bcf7242 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -400,7 +400,7 @@ static int centrino_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int centrino_cpu_exit(struct cpufreq_policy *policy)
+static void centrino_cpu_exit(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 
@@ -408,8 +408,6 @@ static int centrino_cpu_exit(struct cpufreq_policy *policy)
 		return -ENODEV;
 
 	per_cpu(centrino_model, cpu) = NULL;
-
-	return 0;
 }
 
 /**
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 59865ea455a8..07ea7ed61b68 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -551,14 +551,12 @@ static int tegra194_cpufreq_offline(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int tegra194_cpufreq_exit(struct cpufreq_policy *policy)
+static void tegra194_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
-
-	return 0;
 }
 
 static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 9ac4ea50b874..b2a42cdb9582 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -447,7 +447,7 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
+static void ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev;
 
@@ -459,7 +459,6 @@ static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
 	}
 
 	put_cluster_clk_and_freq_table(cpu_dev, policy->related_cpus);
-	return 0;
 }
 
 static struct cpufreq_driver ve_spc_cpufreq_driver = {
-- 
2.25.1


