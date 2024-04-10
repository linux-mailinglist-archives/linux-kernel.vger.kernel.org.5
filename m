Return-Path: <linux-kernel+bounces-138295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703B89EF65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7581D1C21CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BB158D62;
	Wed, 10 Apr 2024 10:03:34 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6796156C6B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743414; cv=none; b=mPtHtJPCt7ef81gd9JGlzTJnhz3iDuWt0Yntyh3biK1PBpKgKN/5eMVIAc5/UkmXxww80mylnaL2tSvp3hu/DK4J+GvtB47PBtrz6vxrPzAwydo5eLHtDibvjHC4yYSk8JJ8X0Xl2vfoKGok6K6I1bmOhBXy6HFh8HoLZANsV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743414; c=relaxed/simple;
	bh=aKH0GORu0FeDvjtPV4fOTHpIA4ay6AYThgTuOB/WIHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3NIB0MvJHjffaWtWH1I0UpV1oJG6sHWBgLP63ReA0KIiCcg4XVaTWguZzTWT49B/Tr+IGbJujzhAECuzaAbS5lIFqQ44DqYpEwPtR5aQI8RKAo4/6EB6owwXF0EWQsQLH/hWKk6luDiTo9hJ96VUzeMmlOavS0g8a9/ZClqxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VDz052JHlz21kdn;
	Wed, 10 Apr 2024 18:02:29 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id B648D14037E;
	Wed, 10 Apr 2024 18:03:24 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 18:03:24 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 2/2] perf: arm_spe: Only show online CPUs in device's "cpumask" attribute
Date: Wed, 10 Apr 2024 17:58:33 +0800
Message-ID: <20240410095833.63934-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240410095833.63934-1-yangyicong@huawei.com>
References: <20240410095833.63934-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

When there're CPUs offline after system booting, perf will failed:
[root@localhost ~]# /home/yang/perf record -e arm_spe_0//
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (arm_spe_0//).
/bin/dmesg | grep -i perf may provide additional information.

This is due to PMU's "cpumask" is not updated and still contains offline
CPUs and perf will try to open perf event on the offlined CPUs.

Make "cpumask" attribute only shows online CPUs and introduced a new
"supported_cpus" where users can get the range of the CPUs this
PMU supported monitoring.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/arm_spe_pmu.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 35f0de03416f..c3123570f955 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -254,13 +254,33 @@ static ssize_t cpumask_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
+	cpumask_var_t mask;
+	ssize_t n;
 
-	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
+	/* If allocation failed then show the supported_cpus */
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
+
+	cpumask_and(mask, &spe_pmu->supported_cpus, cpu_online_mask);
+	n = cpumap_print_to_pagebuf(true, buf, mask);
+	free_cpumask_var(mask);
+
+	return n;
 }
 static DEVICE_ATTR_RO(cpumask);
 
+static ssize_t supported_cpus_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
+}
+static DEVICE_ATTR_RO(supported_cpus);
+
 static struct attribute *arm_spe_pmu_attrs[] = {
 	&dev_attr_cpumask.attr,
+	&dev_attr_supported_cpus.attr,
 	NULL,
 };
 
-- 
2.24.0


