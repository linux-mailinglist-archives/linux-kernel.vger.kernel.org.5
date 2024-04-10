Return-Path: <linux-kernel+bounces-138294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504CE89EF64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF2B28414E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1546F157E9B;
	Wed, 10 Apr 2024 10:03:34 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2E8F4E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743413; cv=none; b=BRNqBrVYNg5u3ldcrhSk08PGU2a+BjRcX744wzHFZKoLEHpd0vEolWmj0hWv601BzPUlyPxvO+b5VWqqO+m6ctHc96lgstvcn6gDY+BBlyCl8vfcF64kxr21toz04f1aoVrKm7huyOS+qLmU0vhQj6rkcR8kWgG4PRDWueGimog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743413; c=relaxed/simple;
	bh=ElFxRXFnLreP2B/j6C2YdLwoMXQn2kE494QqHuqzJBY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s+b4bG/NQjef5MItJJBT8Az1FVYiCMElbO+jRsyeRs6Wr9nBisc+KKGtP3OFuP+97yIwKUePXZrEGil+DnujF+2debvcweToJLFNRXRoulcqGhRfXbRTNOyb6r8mcYZZ2Gs+51Hv6e38cmZaoB/8L9yJyAkweVg0XKbse0fMXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VDyyX29TxzNnM7;
	Wed, 10 Apr 2024 18:01:08 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EF4B1402CE;
	Wed, 10 Apr 2024 18:03:24 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 18:03:23 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 1/2] perf: arm_pmu: Only show online CPUs in device's "cpus" attribute
Date: Wed, 10 Apr 2024 17:58:32 +0800
Message-ID: <20240410095833.63934-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
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
[root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
/bin/dmesg | grep -i perf may provide additional information.

This is due to PMU's "cpus" is not updated and still contains offline
CPUs and perf will try to open perf event on the offlined CPUs.

Make "cpus" attribute only shows online CPUs and introduced a new
"supported_cpus" where users can get the range of the CPUs this
PMU supported monitoring.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/arm_pmu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 8458fe2cebb4..acbb0e1d0414 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -558,13 +558,35 @@ static ssize_t cpus_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
-	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
+	cpumask_var_t mask;
+	ssize_t n;
+
+	/* If allocation failed then show the supported_cpus */
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
+
+	cpumask_and(mask, &armpmu->supported_cpus, cpu_online_mask);
+	n = cpumap_print_to_pagebuf(true, buf, mask);
+	free_cpumask_var(mask);
+
+	return n;
 }
 
 static DEVICE_ATTR_RO(cpus);
 
+static ssize_t supported_cpus_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
+}
+
+static DEVICE_ATTR_RO(supported_cpus);
+
 static struct attribute *armpmu_common_attrs[] = {
 	&dev_attr_cpus.attr,
+	&dev_attr_supported_cpus.attr,
 	NULL,
 };
 
-- 
2.24.0


