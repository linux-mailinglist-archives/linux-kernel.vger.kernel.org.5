Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9978BDD4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjH2FYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjH2FYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AADE19F;
        Mon, 28 Aug 2023 22:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286645; x=1724822645;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eqjAzrt81I+d9AMuS1dkyNzCVMovQ02UMNJu2fNRH7k=;
  b=KeUhA/cW9TuXGx+gqvjc3Cy2kXP3W3Uoq/LVBYEdXjlu4xXD4Kp+2m9U
   VbeVl8ttwF7edltSlXYYzA3Tyi3R8F2Arii9XGh0duxQWm18lh+eS+Oen
   uRJt3cIAbZ5swnc7fBKd/F5SurTSFLEN4YXduEGgHGjgCqx9Ke9aCyqRK
   1V/B4J10lYqv+GzksD/1pqv2/GlNRkYr+2fELdxsy3Ta3b5g15eVX3Ti4
   XXErMtsXu7bRUBtiiPXAPaceMUuaaUAqEAERaR9+W9uZdoPVoffiOIz0b
   bwioPyWkoqBqlyNE2nZ73hSWXcMScUZ8NFW5bARl6g48982l+H1LUUzg4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625204"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625204"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556355"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556355"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:39 -0700
From:   ira.weiny@intel.com
Date:   Mon, 28 Aug 2023 22:20:58 -0700
Subject: [PATCH RFC v2 07/18] cxl/mem: Expose device dynamic capacity
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-7-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=5256;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=7WyZeI7HHwXXYdsbWOXaLecKTJZGgbj+4df/Tk05OHo=;
 b=Ng6gxuVs6hObZp1XDMup9d7Jt4+YhxIKbSzV+524D2TKZYVOzwv4NsuEfZxvxWJBfvqDSV9Tp
 M+qmC/Y9zL0Bk2ciJfu5YrQNlBWD8MwP3DmnbUYE6K/2kkINQGMgDev
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navneet Singh <navneet.singh@intel.com>

To properly configure CXL regions on Dynamic Capacity Devices (DCD),
user space will need to know the details of the DC Regions available on
a device.

Expose driver dynamic capacity configuration through sysfs
attributes.

Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
[iweiny: Rebased on latest master/type2 work]
[iweiny: add documentation for sysfs entries]
[iweiny: s/dc_regions_count/region_count/]
[iweiny: s/dcY_size/regionY_size/]
[alison: change size format to %#llx]
[iweiny: change count format to %d]
[iweiny: Formatting updates]
[iweiny: Fix crash when device is not a mem device: found with cxl-test]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 17 ++++++++
 drivers/cxl/core/memdev.c               | 77 +++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 2268ffcdb604..aa65dc5b4e13 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -37,6 +37,23 @@ Description:
 		identically named field in the Identify Memory Device Output
 		Payload in the CXL-2.0 specification.
 
+What:		/sys/bus/cxl/devices/memX/dc/region_count
+Date:		July, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Number of Dynamic Capacity (DC) regions supported on the
+		device.  May be 0 if the device does not support Dynamic
+		Capacity.
+
+What:		/sys/bus/cxl/devices/memX/dc/regionY_size
+Date:		July, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Size of the Dynamic Capacity (DC) region Y.  Only
+		available on devices which support DC and only for those
+		region indexes supported by the device.
 
 What:		/sys/bus/cxl/devices/memX/serial
 Date:		January, 2022
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 492486707fd0..397262e0ebd2 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -101,6 +101,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t region_count_show(struct device *dev, struct device_attribute *attr,
+				 char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	int len = 0;
+
+	len = sysfs_emit(buf, "%d\n", mds->nr_dc_region);
+	return len;
+}
+
+struct device_attribute dev_attr_region_count =
+	__ATTR(region_count, 0444, region_count_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -454,6 +468,62 @@ static struct attribute *cxl_memdev_security_attributes[] = {
 	NULL,
 };
 
+static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
+}
+
+#define REGION_SIZE_ATTR_RO(n)						\
+static ssize_t region##n##_size_show(struct device *dev,		\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
+{									\
+	return show_size_regionN(to_cxl_memdev(dev), buf, (n));		\
+}									\
+static DEVICE_ATTR_RO(region##n##_size)
+REGION_SIZE_ATTR_RO(0);
+REGION_SIZE_ATTR_RO(1);
+REGION_SIZE_ATTR_RO(2);
+REGION_SIZE_ATTR_RO(3);
+REGION_SIZE_ATTR_RO(4);
+REGION_SIZE_ATTR_RO(5);
+REGION_SIZE_ATTR_RO(6);
+REGION_SIZE_ATTR_RO(7);
+
+static struct attribute *cxl_memdev_dc_attributes[] = {
+	&dev_attr_region0_size.attr,
+	&dev_attr_region1_size.attr,
+	&dev_attr_region2_size.attr,
+	&dev_attr_region3_size.attr,
+	&dev_attr_region4_size.attr,
+	&dev_attr_region5_size.attr,
+	&dev_attr_region6_size.attr,
+	&dev_attr_region7_size.attr,
+	&dev_attr_region_count.attr,
+	NULL,
+};
+
+static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	/* Not a memory device */
+	if (!mds)
+		return 0;
+
+	if (a == &dev_attr_region_count.attr)
+		return a->mode;
+
+	if (n < mds->nr_dc_region)
+		return a->mode;
+
+	return 0;
+}
+
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -482,11 +552,18 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
 	.attrs = cxl_memdev_security_attributes,
 };
 
+static struct attribute_group cxl_memdev_dc_attribute_group = {
+	.name = "dc",
+	.attrs = cxl_memdev_dc_attributes,
+	.is_visible = cxl_dc_visible,
+};
+
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
 	&cxl_memdev_security_attribute_group,
+	&cxl_memdev_dc_attribute_group,
 	NULL,
 };
 

-- 
2.41.0

