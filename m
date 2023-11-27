Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD617FA090
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjK0NRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjK0NRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:17:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F821B4;
        Mon, 27 Nov 2023 05:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701091036; x=1732627036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wpYM9lkUhA7Ume69eMZFogv/ktPexXBBfq5eJqiJgJQ=;
  b=hT1Rg1Kx+yyyALD20R2mwYQ58N3oXMMN1rdRxFkCHTIfnNMl0YVQWqb5
   C+gZKp/70iAuMo0AXuYnzrXD5XgXTd11Cc3SE3IY0rsfV4T8kEwebyQ3y
   /Oy4nBk3u3wCuolAwxoU8bfDp6oGsDkhcp9MgCi1b/AVD5ADarIDMsgGl
   tSLR94ERMxsMnxPeFY5Wpjlb3zvrYTWvUE+W6e4Hdq8gTOAc9XqlFcBwy
   uTWzXDZ+sZED2mWT74Pdw0Ug2j2cxJPxeCAqZE6Mha1SUazl+idr9YqX8
   fXxW51nWaNCkZ3pD3YEDpJThIe7H7n8YuLugJ3TQZzDNPI7bsUZ8/GBu3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="423833689"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="423833689"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 05:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="718031617"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="718031617"
Received: from zhipengw-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.237])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 05:17:13 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (coretemp) Fix core count limitation
Date:   Mon, 27 Nov 2023 21:16:51 +0800
Message-Id: <20231127131651.476795-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127131651.476795-1-rui.zhang@intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, coretemp driver only supports 128 cores per package.
This loses some core temperation information on systems that have more
than 128 cores per package.
 [   58.685033] coretemp coretemp.0: Adding Core 128 failed
 [   58.692009] coretemp coretemp.0: Adding Core 129 failed

Fix the problem by using a per package list to maintain the per core
temp_data instead of the fixed length pdata->core_data[] array.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 110 ++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 58 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index cef43fedbd58..1bb1a6e4b07b 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -39,11 +39,7 @@ static int force_tjmax;
 module_param_named(tjmax, force_tjmax, int, 0444);
 MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
-#define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
-#define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
-#define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
 
 enum coretemp_attr_index {
 	ATTR_LABEL,
@@ -90,17 +86,17 @@ struct temp_data {
 	struct attribute *attrs[TOTAL_ATTRS + 1];
 	struct attribute_group attr_group;
 	struct mutex update_lock;
+	struct list_head node;
 };
 
 /* Platform Data per Physical CPU */
 struct platform_data {
 	struct device		*hwmon_dev;
 	u16			pkg_id;
-	u16			cpu_map[NUM_REAL_CORES];
-	struct ida		ida;
 	struct cpumask		cpumask;
-	struct temp_data	*core_data[MAX_CORE_DATA];
 	struct device_attribute name_attr;
+	struct mutex		core_data_lock;
+	struct list_head	core_data_list;
 };
 
 struct tjmax_pci {
@@ -491,6 +487,23 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
 	return tdata;
 }
 
+static struct temp_data *get_tdata(struct platform_data *pdata, int cpu)
+{
+	struct temp_data *tdata;
+
+	mutex_lock(&pdata->core_data_lock);
+	list_for_each_entry(tdata, &pdata->core_data_list, node) {
+		if (cpu >= 0 && !tdata->is_pkg_data && tdata->cpu_core_id == topology_core_id(cpu))
+			goto found;
+		if (cpu < 0 && tdata->is_pkg_data)
+			goto found;
+	}
+	tdata = NULL;
+found:
+	mutex_unlock(&pdata->core_data_lock);
+	return tdata;
+}
+
 static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 			    int pkg_flag)
 {
@@ -498,37 +511,29 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
-	int err, index, attr_no;
+	int err, attr_no;
 
 	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 		return 0;
 
+	tdata = get_tdata(pdata, pkg_flag ? -1 : cpu);
+	if (tdata)
+		return -EEXIST;
+
+	tdata = init_temp_data(cpu, pkg_flag);
+	if (!tdata)
+		return -ENOMEM;
+
 	/*
 	 * Find attr number for sysfs:
 	 * We map the attr number to core id of the CPU
 	 * The attr number is always core id + 2
 	 * The Pkgtemp will always show up as temp1_*, if available
 	 */
-	if (pkg_flag) {
-		attr_no = PKG_SYSFS_ATTR_NO;
-	} else {
-		index = ida_alloc(&pdata->ida, GFP_KERNEL);
-		if (index < 0)
-			return index;
-		pdata->cpu_map[index] = topology_core_id(cpu);
-		attr_no = index + BASE_SYSFS_ATTR_NO;
-	}
-
-	if (attr_no > MAX_CORE_DATA - 1) {
-		err = -ERANGE;
-		goto ida_free;
-	}
-
-	tdata = init_temp_data(cpu, pkg_flag);
-	if (!tdata) {
-		err = -ENOMEM;
-		goto ida_free;
-	}
+	if (pkg_flag)
+		attr_no = 1;
+	else
+		attr_no = tdata->cpu_core_id + 2;
 
 	/* Test if we can access the status register */
 	err = rdmsr_safe_on_cpu(cpu, tdata->status_reg, &eax, &edx);
@@ -547,20 +552,18 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		if (get_ttarget(tdata, &pdev->dev) >= 0)
 			tdata->attr_size++;
 
-	pdata->core_data[attr_no] = tdata;
-
 	/* Create sysfs interfaces */
 	err = create_core_attrs(tdata, pdata->hwmon_dev, attr_no);
 	if (err)
 		goto exit_free;
 
+	mutex_lock(&pdata->core_data_lock);
+	list_add(&tdata->node, &pdata->core_data_list);
+	mutex_unlock(&pdata->core_data_lock);
+
 	return 0;
 exit_free:
-	pdata->core_data[attr_no] = NULL;
 	kfree(tdata);
-ida_free:
-	if (!pkg_flag)
-		ida_free(&pdata->ida, index);
 	return err;
 }
 
@@ -571,9 +574,9 @@ coretemp_add_core(struct platform_device *pdev, unsigned int cpu, int pkg_flag)
 		dev_err(&pdev->dev, "Adding Core %u failed\n", cpu);
 }
 
-static void coretemp_remove_core(struct platform_data *pdata, int indx)
+static void coretemp_remove_core(struct platform_data *pdata, int cpu)
 {
-	struct temp_data *tdata = pdata->core_data[indx];
+	struct temp_data *tdata = get_tdata(pdata, cpu);
 
 	/* if we errored on add then this is already gone */
 	if (!tdata)
@@ -582,11 +585,11 @@ static void coretemp_remove_core(struct platform_data *pdata, int indx)
 	/* Remove the sysfs attributes */
 	sysfs_remove_group(&pdata->hwmon_dev->kobj, &tdata->attr_group);
 
-	kfree(pdata->core_data[indx]);
-	pdata->core_data[indx] = NULL;
+	mutex_lock(&pdata->core_data_lock);
+	list_del(&tdata->node);
+	mutex_unlock(&pdata->core_data_lock);
 
-	if (indx >= BASE_SYSFS_ATTR_NO)
-		ida_free(&pdata->ida, indx - BASE_SYSFS_ATTR_NO);
+	kfree(tdata);
 }
 
 static int coretemp_device_add(int zoneid)
@@ -601,7 +604,8 @@ static int coretemp_device_add(int zoneid)
 		return -ENOMEM;
 
 	pdata->pkg_id = zoneid;
-	ida_init(&pdata->ida);
+	mutex_init(&pdata->core_data_lock);
+	INIT_LIST_HEAD(&pdata->core_data_list);
 
 	pdev = platform_device_alloc(DRVNAME, zoneid);
 	if (!pdev) {
@@ -629,7 +633,6 @@ static void coretemp_device_remove(int zoneid)
 	struct platform_device *pdev = zone_devices[zoneid];
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 
-	ida_destroy(&pdata->ida);
 	kfree(pdata);
 	platform_device_unregister(pdev);
 }
@@ -699,7 +702,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	struct platform_device *pdev = coretemp_get_pdev(cpu);
 	struct platform_data *pd;
 	struct temp_data *tdata;
-	int i, indx = -1, target;
+	int target;
 
 	/* No need to tear down any interfaces for suspend */
 	if (cpuhp_tasks_frozen)
@@ -710,19 +713,10 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	if (!pd->hwmon_dev)
 		return 0;
 
-	for (i = 0; i < NUM_REAL_CORES; i++) {
-		if (pd->cpu_map[i] == topology_core_id(cpu)) {
-			indx = i + BASE_SYSFS_ATTR_NO;
-			break;
-		}
-	}
-
-	/* Too many cores and this core is not populated, just return */
-	if (indx < 0)
+	tdata = get_tdata(pd, cpu);
+	if (!tdata)
 		return 0;
 
-	tdata = pd->core_data[indx];
-
 	cpumask_clear_cpu(cpu, &pd->cpumask);
 
 	/*
@@ -732,20 +726,20 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 */
 	target = cpumask_any_and(&pd->cpumask, topology_sibling_cpumask(cpu));
 	if (target >= nr_cpu_ids) {
-		coretemp_remove_core(pd, indx);
-	} else if (tdata && tdata->cpu == cpu) {
+		coretemp_remove_core(pd, cpu);
+	} else if (tdata->cpu == cpu) {
 		mutex_lock(&tdata->update_lock);
 		tdata->cpu = target;
 		mutex_unlock(&tdata->update_lock);
 	}
 
+	tdata = get_tdata(pd, -1);
 	/*
 	 * If all cores in this pkg are offline, remove the interface.
 	 */
-	tdata = pd->core_data[PKG_SYSFS_ATTR_NO];
 	if (cpumask_empty(&pd->cpumask)) {
 		if (tdata)
-			coretemp_remove_core(pd, PKG_SYSFS_ATTR_NO);
+			coretemp_remove_core(pd, -1);
 		hwmon_device_unregister(pd->hwmon_dev);
 		pd->hwmon_dev = NULL;
 		return 0;
-- 
2.34.1

