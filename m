Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8C480DF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbjLKWwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjLKWw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:52:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7941BEA;
        Mon, 11 Dec 2023 14:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702335154; x=1733871154;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ehImgNx/k9AKKVzaSKbOLo1Mb4OGFvOlrdKezvX51Qs=;
  b=mnl9ktrZGwft0/ztMbnaEwHkUOfGIrXRU4xt86tHV4frmXtPYovdRLoZ
   IMSC4a8pWqUwRubFfhtYBz0bb/MXhtcvfNmUObtHHoRHk8m643AYvw52S
   d6Fkkcywz7i3afFoqumBy/h2G8/61m2Nva+0KJ3OsUfeBkC8ZFy0p21HR
   6CZx4H08XPXSAtBBnVGHc45SRLlA5KKKVNo56k85wB/HslnQCsOz/SPW1
   UO3HX0gAqDxNREqo9mDzWSeqldoIrpzcwoJb795ZFfaBdHUPT//TiSDlH
   +HIEZnqaJE+m5z9fa7ra2d4q7F/uuGz0D9G2xf0mK6DXa3xCXhZVPzMrh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8083760"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8083760"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:52:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946511338"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946511338"
Received: from tlyon-mobl2.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.89.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:52:29 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 11 Dec 2023 15:52:18 -0700
Subject: [PATCH v3 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-vv-dax_abi-v3-2-acf6cc1bde9f@intel.com>
References: <20231211-vv-dax_abi-v3-0-acf6cc1bde9f@intel.com>
In-Reply-To: <20231211-vv-dax_abi-v3-0-acf6cc1bde9f@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Li Zhijian <lizhijian@fujitsu.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-433a8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4067;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=ehImgNx/k9AKKVzaSKbOLo1Mb4OGFvOlrdKezvX51Qs=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKnlk9bs0Q08u36yeE9D5odPpy9eCq97f3DXZimjGV/ut
 wuXmyXv6ChlYRDjYpAVU2T5u+cj4zG57fk8gQmOMHNYmUCGMHBxCsBEWsUY/sp/05f8vH7V+2LJ
 dUduyLd3/SlOK1JcbvvFQTuv8drym+kMPxlNnmheye0rqIxzYlwU819lzccdx/O5BCPvnUnwMTD
 zZAMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sysfs knob for dax devices to control the memmap_on_memory setting
if the dax device were to be hotplugged as system memory.

The default memmap_on_memory setting for dax devices originating via
pmem or hmem is set to 'false' - i.e. no memmap_on_memory semantics, to
preserve legacy behavior. For dax devices via CXL, the default is on.
The sysfs control allows the administrator to override the above
defaults if needed.

Cc: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.c                       | 47 +++++++++++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-dax | 17 ++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1ff1ab5fa105..2871e5188f0d 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1270,6 +1270,52 @@ static ssize_t numa_node_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t memmap_on_memory_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sprintf(buf, "%d\n", dev_dax->memmap_on_memory);
+}
+
+static ssize_t memmap_on_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct device_driver *drv = dev->driver;
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+	struct dax_device_driver *dax_drv = to_dax_drv(drv);
+	ssize_t rc;
+	bool val;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	if (dev_dax->memmap_on_memory == val)
+		return len;
+
+	device_lock(dax_region->dev);
+	if (!dax_region->dev->driver) {
+		device_unlock(dax_region->dev);
+		return -ENXIO;
+	}
+
+	if (dax_drv->type == DAXDRV_KMEM_TYPE) {
+		device_unlock(dax_region->dev);
+		return -EBUSY;
+	}
+
+	device_lock(dev);
+	dev_dax->memmap_on_memory = val;
+	device_unlock(dev);
+
+	device_unlock(dax_region->dev);
+	return len;
+}
+static DEVICE_ATTR_RW(memmap_on_memory);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1296,6 +1342,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_align.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_memmap_on_memory.attr,
 	NULL,
 };
 
diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
index a61a7b186017..b1fd8bf8a7de 100644
--- a/Documentation/ABI/testing/sysfs-bus-dax
+++ b/Documentation/ABI/testing/sysfs-bus-dax
@@ -149,3 +149,20 @@ KernelVersion:	v5.1
 Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) The id attribute indicates the region id of a dax region.
+
+What:		/sys/bus/dax/devices/daxX.Y/memmap_on_memory
+Date:		October, 2023
+KernelVersion:	v6.8
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) Control the memmap_on_memory setting if the dax device
+		were to be hotplugged as system memory. This determines whether
+		the 'altmap' for the hotplugged memory will be placed on the
+		device being hotplugged (memmap_on_memory=1) or if it will be
+		placed on regular memory (memmap_on_memory=0). This attribute
+		must be set before the device is handed over to the 'kmem'
+		driver (i.e.  hotplugged into system-ram). Additionally, this
+		depends on CONFIG_MHP_MEMMAP_ON_MEMORY, and a globally enabled
+		memmap_on_memory parameter for memory_hotplug. This is
+		typically set on the kernel command line -
+		memory_hotplug.memmap_on_memory set to 'true' or 'force'."

-- 
2.41.0

