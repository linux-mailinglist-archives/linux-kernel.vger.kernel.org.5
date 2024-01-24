Return-Path: <linux-kernel+bounces-37627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8483B2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341401C222BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E0134737;
	Wed, 24 Jan 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJkM7GP6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A544133428;
	Wed, 24 Jan 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126667; cv=none; b=Dmo/ZpGL7uRz9XZJV2GKiLBXDOyZ8bpyAZZcqqgXNntNl/W7VN87X/FG6UDvg5P8OinHB0auP5M/wWrFZXKSDpj70brdzyiFPBaAbrP9PJUafIdzDFtUWuv3ph9LaF7r6a3pvX4LKiQJeexsI7ltOH59Tm8UDSemWC4GDZEgoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126667; c=relaxed/simple;
	bh=pbx8GN6oF7bpvrPHhUbumLfrIjuzdnl/0AJX9PTq6Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYV+lrMEngZ/PJJRE8VFN9IQJP+x9IAlMunnMLsXBaUiQv5CM/mB3880SZk5wqok1lv+VtKcyl2Xz3pWZR5GBIrtzaaVDWnOQygp45XwnTM2F7D/75O6IoVLaIkbAjXPiYWqIclIr67VmKhi7vheoIz4uYFTDt1q8XExfUC4MqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJkM7GP6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706126665; x=1737662665;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pbx8GN6oF7bpvrPHhUbumLfrIjuzdnl/0AJX9PTq6Qc=;
  b=MJkM7GP6ofo0vuI5UOFie09sf5ecwHE6gd2RQRAMct/WzoSzvtBrYU8H
   uknLbOAXm2fAX+qMN1jRkGE9goVwm8jj4a18giOe0eEU+nbjPOhqmeFCG
   HiWWoz44wiFcugfd7XcqdMIosCLS0Af+u4vrcAiRMBTb9rJ6pr7YyzIa4
   C9zO6BLlX2KYp/Rmn76pQATnD+UtSSPG9cGRf9SEyK9iTH3+wrqiEZIcC
   zF+nf3m5EhLmDOJD9Kcr7bs4mLht1WBhBtVywaRp1zLS4mBKOwTLS0waD
   k3KeL7Qy3pBHVOjo9KPQyXX+8UYeKcDo9Yne6pis+cSxUPguJe6IeIngH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1836109"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1836109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117735135"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117735135"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.0.0.223]) ([10.251.14.61])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:22 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Wed, 24 Jan 2024 12:03:48 -0800
Subject: [PATCH v7 3/5] Documentatiion/ABI: Add ABI documentation for
 sys-bus-dax
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-vv-dax_abi-v7-3-20d16cb8d23d@intel.com>
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
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5934;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=pbx8GN6oF7bpvrPHhUbumLfrIjuzdnl/0AJX9PTq6Qc=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKkbc505nke437328TqL7m7B7XeMf4c4z14x5ZK/0LvjS
 1xWGTi97ChlYRDjYpAVU2T5u+cj4zG57fk8gQmOMHNYmUCGMHBxCsBEvtQxMmzIv34xu9h1/lQW
 WXGViZ17Pltryjld/3Ve88XRDX2x874y/LM8U6QgKhpdXrq7oI+tdtmOgq1avXd62RekHvr6/FK
 NPw8A
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Add the missing sysfs ABI documentation for the device DAX subsystem.
Various ABI attributes under this have been present since v5.1, and more
have been added over time. In preparation for adding a new attribute,
add this file with the historical details.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-dax | 136 ++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
new file mode 100644
index 000000000000..6359f7bc9bf4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-dax
@@ -0,0 +1,136 @@
+What:		/sys/bus/dax/devices/daxX.Y/align
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) Provides a way to specify an alignment for a dax device.
+		Values allowed are constrained by the physical address ranges
+		that back the dax device, and also by arch requirements.
+
+What:		/sys/bus/dax/devices/daxX.Y/mapping
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(WO) Provides a way to allocate a mapping range under a dax
+		device. Specified in the format <start>-<end>.
+
+What:		/sys/bus/dax/devices/daxX.Y/mapping[0..N]/start
+What:		/sys/bus/dax/devices/daxX.Y/mapping[0..N]/end
+What:		/sys/bus/dax/devices/daxX.Y/mapping[0..N]/page_offset
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) A dax device may have multiple constituent discontiguous
+		address ranges. These are represented by the different
+		'mappingX' subdirectories. The 'start' attribute indicates the
+		start physical address for the given range. The 'end' attribute
+		indicates the end physical address for the given range. The
+		'page_offset' attribute indicates the offset of the current
+		range in the dax device.
+
+What:		/sys/bus/dax/devices/daxX.Y/resource
+Date:		June, 2019
+KernelVersion:	v5.3
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The resource attribute indicates the starting physical
+		address of a dax device. In case of a device with multiple
+		constituent ranges, it indicates the starting address of the
+		first range.
+
+What:		/sys/bus/dax/devices/daxX.Y/size
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) The size attribute indicates the total size of a dax
+		device. For creating subdivided dax devices, or for resizing
+		an existing device, the new size can be written to this as
+		part of the reconfiguration process.
+
+What:		/sys/bus/dax/devices/daxX.Y/numa_node
+Date:		November, 2019
+KernelVersion:	v5.5
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) If NUMA is enabled and the platform has affinitized the
+		backing device for this dax device, emit the CPU node
+		affinity for this device.
+
+What:		/sys/bus/dax/devices/daxX.Y/target_node
+Date:		February, 2019
+KernelVersion:	v5.1
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The target-node attribute is the Linux numa-node that a
+		device-dax instance may create when it is online. Prior to
+		being online the device's 'numa_node' property reflects the
+		closest online cpu node which is the typical expectation of a
+		device 'numa_node'. Once it is online it becomes its own
+		distinct numa node.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/available_size
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The available_size attribute tracks available dax region
+		capacity. This only applies to volatile hmem devices, not pmem
+		devices, since pmem devices are defined by nvdimm namespace
+		boundaries.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/size
+Date:		July, 2017
+KernelVersion:	v5.1
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The size attribute indicates the size of a given dax region
+		in bytes.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/align
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The align attribute indicates alignment of the dax region.
+		Changes on align may not always be valid, when say certain
+		mappings were created with 2M and then we switch to 1G. This
+		validates all ranges against the new value being attempted, post
+		resizing.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/seed
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The seed device is a concept for dynamic dax regions to be
+		able to split the region amongst multiple sub-instances.  The
+		seed device, similar to libnvdimm seed devices, is a device
+		that starts with zero capacity allocated and unbound to a
+		driver.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/create
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) The create interface to the dax region provides a way to
+		create a new unconfigured dax device under the given region, which
+		can then be configured (with a size etc.) and then probed.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/delete
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(WO) The delete interface for a dax region provides for deletion
+		of any 0-sized and idle dax devices.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/id
+Date:		July, 2017
+KernelVersion:	v5.1
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The id attribute indicates the region id of a dax region.

-- 
2.43.0


