Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB0281298A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443410AbjLNHiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443335AbjLNHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:38:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D98EA3;
        Wed, 13 Dec 2023 23:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702539496; x=1734075496;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jYMqTdWolji6J2rYKSsSVwH7OXLij+oakPFuQznWwJY=;
  b=ADwO/gQ3mOTOcE4xSwYOzyfhLCfYfPsYd3LZ5c71TNmXiQoDARXJtebF
   zdp+eb3yCGs+dzBjEAxGzqLyyXUtZQp+S9wBUizms6Sus0P1FPXV2kUKS
   Y9c65u6ge5R3I62bEFR5fUCpHT2DtvFAgXn6Oibd04jZuIHSvLcpGYZpK
   QnhwA9NgQe09rA7ycbo7FffxGFbG+sgCTEN3sxySyA826KVZI47uo9Kp9
   8p3Jwzgf6y2hd01x+K2vuQCxsdhNABKvcj34M6uzvtu/WtxsdmN/MLqVO
   yGuJScFb3HjzKq+ZA34drmwl8++Liejg/B8R7/+IbRsFZU463Sv0x2yoP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481275541"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="481275541"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723972075"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="723972075"
Received: from llblake-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.213.191.124])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:38:14 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 14 Dec 2023 00:37:57 -0700
Subject: [PATCH v5 4/4] dax: add a sysfs knob to control memmap_on_memory
 behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-vv-dax_abi-v5-4-3f7b006960b4@intel.com>
References: <20231214-vv-dax_abi-v5-0-3f7b006960b4@intel.com>
In-Reply-To: <20231214-vv-dax_abi-v5-0-3f7b006960b4@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Li Zhijian <lizhijian@fujitsu.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-433a8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3902;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=jYMqTdWolji6J2rYKSsSVwH7OXLij+oakPFuQznWwJY=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKlVGx4xGLwMeT8h+dTH8ILmoEoW649mq5eJfrI008iZd
 dHkQLRRRykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDaEi1MAJhKYxsgw/8ehpzXc1V8u7tt1
 7WqTeHdgvEtK+ZM+7val85Qn6ao7MjLsucZTNdV7da/OS+73H804o1XEmnZ7n/p5accFhRezdDU
 4AA==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/dax/bus.c                       | 38 +++++++++++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-dax | 17 +++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 6226de131d17..f4d3beec507c 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1245,6 +1245,43 @@ static ssize_t numa_node_show(struct device *dev,
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
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_device_driver *dax_drv;
+	ssize_t rc;
+	bool val;
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
+	guard(device)(dev);
+	dax_drv = to_dax_drv(dev->driver);
+	if (dax_drv && dev_dax->memmap_on_memory != val &&
+	    dax_drv->type == DAXDRV_KMEM_TYPE)
+		return -EBUSY;
+	dev_dax->memmap_on_memory = val;
+
+	return len;
+}
+static DEVICE_ATTR_RW(memmap_on_memory);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1271,6 +1308,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_align.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_memmap_on_memory.attr,
 	NULL,
 };
 
diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
index 6359f7bc9bf4..40d9965733b2 100644
--- a/Documentation/ABI/testing/sysfs-bus-dax
+++ b/Documentation/ABI/testing/sysfs-bus-dax
@@ -134,3 +134,20 @@ KernelVersion:	v5.1
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

