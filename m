Return-Path: <linux-kernel+bounces-151773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC0F8AB3B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87589B21A10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC613D28A;
	Fri, 19 Apr 2024 16:47:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352413C9C8;
	Fri, 19 Apr 2024 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545274; cv=none; b=iZOChKCd32U7k06wOfjL9s9ftbXdXrAyC/g61G7ICJe6CRxyaRfF042WNGaPf5LLU86dyMpZ3EUnaHcCrPutN5HW1YFhlUTC0m8fS2JM3UrFWcqpI2SO75m1vjjcSKff4w1MvL3VCxkWCHa43F0Nm7EwMQ20nHkvYtkPCjEPwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545274; c=relaxed/simple;
	bh=tDSifUiE4U4D1GwvzyJbNw4EOl+iDD7KH4clCnPWrcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiXSK0SPi+x87/mMaU4I2+m/qnShzEikIm9RU/pIodCGi1Drd3aist0x/0qVXdW+o76K8u9YTTDtFrfZ2Y6m6UaQI9OFP4DGK+nZrqREkVJfwG3Z/rkRmeKMZWczDCNPZvfs0sFtsyowR5Pm7DM/qiTO0sjzdgcLiwCLZTXzb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLgWC65WBz6K626;
	Sat, 20 Apr 2024 00:45:43 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id A9B64140A35;
	Sat, 20 Apr 2024 00:47:50 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:47:49 +0100
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v8 09/10] ras: scrub: Add scrub control attributes for ACPI RAS2
Date: Sat, 20 Apr 2024 00:47:18 +0800
Message-ID: <20240419164720.1765-10-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240419164720.1765-1-shiju.jose@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add scrub control attributes for ACPI RAS2 patrol scrub feature.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../ABI/testing/sysfs-class-scrub-configure   |  28 +++-
 drivers/ras/memory_scrub.c                    | 131 ++++++++++++++++++
 include/linux/memory_scrub.h                  |   8 ++
 3 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Documentation/ABI/testing/sysfs-class-scrub-configure
index 3ed77dbb00ad..7178776249f8 100644
--- a/Documentation/ABI/testing/sysfs-class-scrub-configure
+++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
@@ -15,12 +15,21 @@ Description:
 		correspond to each scrub device registered with the
 		scrub subsystem.
 
-What:		/sys/class/ras/rasX/scrub/name
+What:		/sys/class/ras/rasX/scrub/addr_range_base
 Date:		March 2024
 KernelVersion:	6.9
 Contact:	linux-kernel@vger.kernel.org
 Description:
-		(RO) name of the memory scrubber
+		(RW) The base of the address range of the memory region
+		to be scrubbed (on-demand scrubbing).
+
+What:		/sys/class/ras/rasX/scrub/addr_range_size
+Date:		March 2024
+KernelVersion:	6.9
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The size of the address range of the memory region
+		to be scrubbed (on-demand scrubbing).
 
 What:		/sys/class/ras/rasX/scrub/enable_background
 Date:		March 2024
@@ -29,6 +38,21 @@ Contact:	linux-kernel@vger.kernel.org
 Description:
 		(RW) Enable/Disable background(patrol) scrubbing if supported.
 
+What:		/sys/class/ras/rasX/scrub/enable_on_demand
+Date:		March 2024
+KernelVersion:	6.9
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) Enable/Disable on-demand scrubbing the memory region
+		if supported.
+
+What:		/sys/class/ras/rasX/scrub/name
+Date:		March 2024
+KernelVersion:	6.9
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) name of the memory scrubber
+
 What:		/sys/class/ras/rasX/scrub/rate_available
 Date:		March 2024
 KernelVersion:	6.9
diff --git a/drivers/ras/memory_scrub.c b/drivers/ras/memory_scrub.c
index 7e995380ec3a..ace6c59b8993 100755
--- a/drivers/ras/memory_scrub.c
+++ b/drivers/ras/memory_scrub.c
@@ -29,6 +29,83 @@ struct scrub_device {
 };
 
 #define to_scrub_device(d) container_of(d, struct scrub_device, dev)
+static ssize_t addr_range_base_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	u64 base, size;
+	int ret;
+
+	ret = scrub_dev->ops->read_range(dev, &base, &size);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%llx\n", base);
+}
+
+static ssize_t addr_range_size_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	u64 base, size;
+	int ret;
+
+	ret = scrub_dev->ops->read_range(dev, &base, &size);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%llx\n", size);
+}
+
+static ssize_t addr_range_base_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	u64 base, size;
+	int ret;
+
+	ret = scrub_dev->ops->read_range(dev, &base, &size);
+	if (ret)
+		return ret;
+
+	ret = kstrtou64(buf, 16, &base);
+	if (ret < 0)
+		return ret;
+
+	ret = scrub_dev->ops->write_range(dev, base, size);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t addr_range_size_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t len)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	u64 base, size;
+	int ret;
+
+	ret = scrub_dev->ops->read_range(dev, &base, &size);
+	if (ret)
+		return ret;
+
+	ret = kstrtou64(buf, 16, &size);
+	if (ret < 0)
+		return ret;
+
+	ret = scrub_dev->ops->write_range(dev, base, size);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
 static ssize_t enable_background_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
@@ -62,6 +139,39 @@ static ssize_t enable_background_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", enable);
 }
 
+static ssize_t enable_on_demand_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	bool enable;
+	int ret;
+
+	ret = scrub_dev->ops->get_enabled_od(dev, &enable);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", enable);
+}
+
+static ssize_t enable_on_demand_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret < 0)
+		return ret;
+
+	ret = scrub_dev->ops->set_enabled_od(dev, enable);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
@@ -122,13 +232,19 @@ static ssize_t rate_available_show(struct device *dev,
 	return sysfs_emit(buf, "0x%llx-0x%llx\n", min_sr, max_sr);
 }
 
+DEVICE_ATTR_RW(addr_range_base);
+DEVICE_ATTR_RW(addr_range_size);
 DEVICE_ATTR_RW(enable_background);
+DEVICE_ATTR_RW(enable_on_demand);
 DEVICE_ATTR_RO(name);
 DEVICE_ATTR_RW(rate);
 DEVICE_ATTR_RO(rate_available);
 
 static struct attribute *scrub_attrs[] = {
+	&dev_attr_addr_range_base.attr,
+	&dev_attr_addr_range_size.attr,
 	&dev_attr_enable_background.attr,
+	&dev_attr_enable_on_demand.attr,
 	&dev_attr_name.attr,
 	&dev_attr_rate.attr,
 	&dev_attr_rate_available.attr,
@@ -142,6 +258,14 @@ static umode_t scrub_attr_visible(struct kobject *kobj,
 	struct scrub_device *scrub_dev = to_scrub_device(dev);
 	const struct scrub_ops *ops = scrub_dev->ops;
 
+	if (a == &dev_attr_addr_range_base.attr ||
+	    a == &dev_attr_addr_range_size.attr) {
+		if (ops->read_range && ops->write_range)
+			return a->mode;
+		if (ops->read_range)
+			return 0444;
+		return 0;
+	}
 	if (a == &dev_attr_enable_background.attr) {
 		if (ops->set_enabled_bg && ops->get_enabled_bg)
 			return a->mode;
@@ -149,6 +273,13 @@ static umode_t scrub_attr_visible(struct kobject *kobj,
 			return 0444;
 		return 0;
 	}
+	if (a == &dev_attr_enable_on_demand.attr) {
+		if (ops->set_enabled_od && ops->get_enabled_od)
+			return a->mode;
+		if (ops->get_enabled_od)
+			return 0444;
+		return 0;
+	}
 	if (a == &dev_attr_name.attr)
 		return ops->get_name ? a->mode : 0;
 	if (a == &dev_attr_rate_available.attr)
diff --git a/include/linux/memory_scrub.h b/include/linux/memory_scrub.h
index f0e1657a5072..d8edb48677c9 100755
--- a/include/linux/memory_scrub.h
+++ b/include/linux/memory_scrub.h
@@ -15,16 +15,24 @@ struct device;
 
 /**
  * struct scrub_ops - scrub device operations (all elements optional)
+ * @read_range: read base and offset of scrubbing range.
+ * @write_range: set the base and offset of the scrubbing range.
  * @get_enabled_bg: check if currently performing background scrub.
  * @set_enabled_bg: start or stop a bg-scrub.
+ * @get_enabled_od: check if currently performing on-demand scrub.
+ * @set_enabled_od: start or stop an on-demand scrub.
  * @get_name: get the memory scrubber name.
  * @rate_avail_range: retrieve limits on supported rates.
  * @rate_read: read the scrub rate
  * @rate_write: set the scrub rate
  */
 struct scrub_ops {
+	int (*read_range)(struct device *dev, u64 *base, u64 *size);
+	int (*write_range)(struct device *dev, u64 base, u64 size);
 	int (*get_enabled_bg)(struct device *dev, bool *enable);
 	int (*set_enabled_bg)(struct device *dev, bool enable);
+	int (*get_enabled_od)(struct device *dev, bool *enable);
+	int (*set_enabled_od)(struct device *dev, bool enable);
 	int (*get_name)(struct device *dev, char *buf);
 	int (*rate_avail_range)(struct device *dev, u64 *min, u64 *max);
 	int (*rate_read)(struct device *dev, u64 *rate);
-- 
2.34.1


