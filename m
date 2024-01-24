Return-Path: <linux-kernel+bounces-37629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C683B2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD8D2891E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3A1350E1;
	Wed, 24 Jan 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFuZahct"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E41339A1;
	Wed, 24 Jan 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126670; cv=none; b=e3O5nJdt4MIJ4CNfq4H67cDNEAql4Zd4DO/hNpMhsLUx12Zt+r51ycth0J+IKjvWRwKJ7WbE4so6j0Re5aZ1RlEg9BjfArKNIX/93/m5mJNSFtV/RkoH+h5UxukZWFAa3Bx3wudFot4iNu8KZd+RyPwkuTcsz8LfcHjctaTQgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126670; c=relaxed/simple;
	bh=LlNwsQ9722KaImXgMJUAbGVELQS9Qj5zVBOISdpjDqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvyS7mCxYJMx63aqpnqShxOC2gAzRsb48Px3ffQi+XwT1YjlWU/jd314kjUr/xC/Wyi6+4hBF2uty8yN7h4q2hIHGGr9eCE4vFWO4LPo7v+tX1rz0EA2HA0IBcG/EVHw0pJpPjINtUR91ruFPLL4cdPtW9uw5mWxFu+NsxUcYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFuZahct; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706126667; x=1737662667;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LlNwsQ9722KaImXgMJUAbGVELQS9Qj5zVBOISdpjDqE=;
  b=jFuZahctn9V358ON/5NnxJVP3aGmB0Zp54MQRkGjQ5FR0yxZbBmR7fMk
   h3oaYazLoso+RErHrp3FqeGsPnkxi94FGXt27KNzlVDBOZiOLuNTJ4TM/
   vWHOc6w1x8hz6I9tK0Fq62I6iJy8fB8GVkLccbghKOKf2WKEAiYOrUsbM
   C/2NTfA6vLlxulig55vlx5srSQcOjBstqbFwSBw3IvstTCBe9ox5AfcqY
   zPmIE4d+HwlPiuqj6zI8LCynuSBrI1H2dfHf4As/rSqczHX66MKVRPf2y
   dTu9cRsVpnss8c2X9JUI/xvvs/r0Y4bDscjOsg3oSjQ0ode01L8jmQEGe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1836126"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1836126"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117735146"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117735146"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.0.0.223]) ([10.251.14.61])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:25 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Wed, 24 Jan 2024 12:03:50 -0800
Subject: [PATCH v7 5/5] dax: add a sysfs knob to control memmap_on_memory
 behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-vv-dax_abi-v7-5-20d16cb8d23d@intel.com>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
In-Reply-To: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Huang Ying <ying.huang@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
 Li Zhijian <lizhijian@fujitsu.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4012;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=LlNwsQ9722KaImXgMJUAbGVELQS9Qj5zVBOISdpjDqE=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKkbc50VeD8v+CjLFhJhfFzu8RSjtH97erzz9l4Qf8Enc
 LfQ66hyRykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACbiH8TwV1Ju2kePSfLnrhke
 2viisS8mpjzc/qGgQObvl8E/GFTs9Rn+B7+fyvC/VG61dh1TyJMbdnVpnpttknc4N2ev5nkgpin
 HBAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

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
Reviewed-by: Huang, Ying <ying.huang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.c                       | 43 +++++++++++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-dax | 17 +++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0fd948a4443e..27c86d0ca711 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1349,6 +1349,48 @@ static ssize_t numa_node_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t memmap_on_memory_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sysfs_emit(buf, "%d\n", dev_dax->memmap_on_memory);
+}
+
+static ssize_t memmap_on_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	if (val == true && !mhp_supports_memmap_on_memory()) {
+		dev_dbg(dev, "memmap_on_memory is not available\n");
+		return -EOPNOTSUPP;
+	}
+
+	rc = down_write_killable(&dax_dev_rwsem);
+	if (rc)
+		return rc;
+
+	if (dev_dax->memmap_on_memory != val && dev->driver &&
+	    to_dax_drv(dev->driver)->type == DAXDRV_KMEM_TYPE) {
+		up_write(&dax_dev_rwsem);
+		return -EBUSY;
+	}
+
+	dev_dax->memmap_on_memory = val;
+	up_write(&dax_dev_rwsem);
+
+	return len;
+}
+static DEVICE_ATTR_RW(memmap_on_memory);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1375,6 +1417,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_align.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_memmap_on_memory.attr,
 	NULL,
 };
 
diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
index 6359f7bc9bf4..b34266bfae49 100644
--- a/Documentation/ABI/testing/sysfs-bus-dax
+++ b/Documentation/ABI/testing/sysfs-bus-dax
@@ -134,3 +134,20 @@ KernelVersion:	v5.1
 Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) The id attribute indicates the region id of a dax region.
+
+What:		/sys/bus/dax/devices/daxX.Y/memmap_on_memory
+Date:		January, 2024
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
2.43.0


