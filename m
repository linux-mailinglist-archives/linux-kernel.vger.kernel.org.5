Return-Path: <linux-kernel+bounces-6958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D4819FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270111F2314B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0EB30662;
	Wed, 20 Dec 2023 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmiITibH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36438DD8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703078929; x=1734614929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zbk8DUk6AVrOwj/yWHcoFKk6SEPSTMmsuNjz9utineQ=;
  b=JmiITibHc/VSQuokn7sq3j0LlTcwXKYySdjRd5XhVQmD8BG0TRjDPCD0
   3vsffm4aEasdfz/bovTZ3o0eVXwkQJiMpAHkIEDEr1YJMkfjXH91TVK/h
   efgdlnrru64upw2zM2NYolmTvgEwbKrIPOoQdH7nmrnC5tuPs8Hq5oD2h
   lQSkoozyjK7sW18KhW7EaQbkQXf32qw8BPARxZlEGLjmkR2i6FwmKA5WP
   R/fB4+VCrSoU1apQ/RwfTvOpi1ud0nUZKaqRMxdc6fn9HSaahR2lKB8iS
   RuB5dghcSGcAfjWTOCzPUTErwb8CkY8u5+EFyGFXSISGqXOFgfWNWkqGq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="17367465"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="17367465"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 05:28:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="805258493"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="805258493"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2023 05:28:45 -0800
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH] Documentation: iommu/vt-d: Add the document for Intel IOMMU debugfs
Date: Wed, 20 Dec 2023 21:25:19 +0800
Message-Id: <20231220132519.11077-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This document guides users to dump the Intel IOMMU internals by debugfs.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 Documentation/ABI/testing/debugfs-intel-iommu | 278 ++++++++++++++++++
 1 file changed, 278 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-intel-iommu

diff --git a/Documentation/ABI/testing/debugfs-intel-iommu b/Documentation/ABI/testing/debugfs-intel-iommu
new file mode 100644
index 000000000000..86b3f7f85db9
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-intel-iommu
@@ -0,0 +1,278 @@
+What:		/sys/kernel/debug/iommu/intel/iommu_regset
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file dumps all the register contents for each IOMMU device.
+
+		Example in Kabylake:
+
+		::
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/iommu_regset
+
+		 IOMMU: dmar0 Register Base Address: 26be37000
+
+		 Name                    Offset          Contents
+		 VER                     0x00            0x0000000000000010
+		 GCMD                    0x18            0x0000000000000000
+		 GSTS                    0x1c            0x00000000c7000000
+		 FSTS                    0x34            0x0000000000000000
+		 FECTL                   0x38            0x0000000000000000
+
+		 [...]
+
+		 IOMMU: dmar1 Register Base Address: fed90000
+
+		 Name                    Offset          Contents
+		 VER                     0x00            0x0000000000000010
+		 GCMD                    0x18            0x0000000000000000
+		 GSTS                    0x1c            0x00000000c7000000
+		 FSTS                    0x34            0x0000000000000000
+		 FECTL                   0x38            0x0000000000000000
+
+		 [...]
+
+		 IOMMU: dmar2 Register Base Address: fed91000
+
+		 Name                    Offset          Contents
+		 VER                     0x00            0x0000000000000010
+		 GCMD                    0x18            0x0000000000000000
+		 GSTS                    0x1c            0x00000000c7000000
+		 FSTS                    0x34            0x0000000000000000
+		 FECTL                   0x38            0x0000000000000000
+
+		 [...]
+
+What:		/sys/kernel/debug/iommu/intel/ir_translation_struct
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file dumps the table entries for Interrupt
+		remapping and Interrupt posting.
+
+		Example in Kabylake:
+
+		::
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/ir_translation_struct
+
+		 Remapped Interrupt supported on IOMMU: dmar0
+		 IR table address:100900000
+
+		 Entry SrcID   DstID    Vct IRTE_high           IRTE_low
+		 0     00:0a.0 00000080 24  0000000000040050    000000800024000d
+		 1     00:0a.0 00000001 ef  0000000000040050    0000000100ef000d
+
+		 Remapped Interrupt supported on IOMMU: dmar1
+		 IR table address:100300000
+		 Entry SrcID   DstID    Vct IRTE_high           IRTE_low
+		 0     00:02.0 00000002 26  0000000000040010    000000020026000d
+
+		 [...]
+
+		 ****
+
+		 Posted Interrupt supported on IOMMU: dmar0
+		 IR table address:100900000
+		 Entry SrcID   PDA_high PDA_low  Vct IRTE_high          IRTE_low
+
+What:		/sys/kernel/debug/iommu/intel/dmar_translation_struct
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file dumps Intel IOMMU DMA remapping tables, such
+		as root table, context table, PASID directory and PASID
+		table entries in debugfs. For legacy mode, it doesn't
+		support PASID, and hence PASID field is defaulted to
+		'-1' and other PASID related fields are invalid.
+
+		Example in Kabylake:
+
+		::
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/dmar_translation_struct
+
+		 IOMMU dmar1: Root Table Address: 0x103027000
+		 B.D.F   Root_entry
+		 00:02.0 0x0000000000000000:0x000000010303e001
+
+		 Context_entry
+		 0x0000000000000102:0x000000010303f005
+
+		 PASID   PASID_table_entry
+		 -1      0x0000000000000000:0x0000000000000000:0x0000000000000000
+
+		 IOMMU dmar0: Root Table Address: 0x103028000
+		 B.D.F   Root_entry
+		 00:0a.0 0x0000000000000000:0x00000001038a7001
+
+		 Context_entry
+		 0x0000000000000000:0x0000000103220e7d
+
+		 PASID   PASID_table_entry
+		 0       0x0000000000000000:0x0000000000800002:0x00000001038a5089
+
+		 [...]
+
+What:		/sys/kernel/debug/iommu/intel/invalidation_queue
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file exports invalidation queue internals of each
+		IOMMU device.
+
+		Example in Kabylake:
+
+		::
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/invalidation_queue
+
+		 Invalidation queue on IOMMU: dmar0
+		 Base: 0x10022e000      Head: 20        Tail: 20
+		 Index          qw0                    qw1                     qw2
+		     0   0000000000000014        0000000000000000        0000000000000000
+		     1   0000000200000025        0000000100059c04        0000000000000000
+		     2   0000000000000014        0000000000000000        0000000000000000
+
+		      		qw3                  status
+			 0000000000000000        0000000000000000
+			 0000000000000000        0000000000000000
+			 0000000000000000        0000000000000000
+
+		 [...]
+
+		 Invalidation queue on IOMMU: dmar1
+		 Base: 0x10026e000      Head: 32        Tail: 32
+		 Index           qw0                     qw1                   status
+		     0   0000000000000004        0000000000000000         0000000000000000
+		     1   0000000200000025        0000000100059804         0000000000000000
+		     2   0000000000000011        0000000000000000         0000000000000000
+
+		 [...]
+
+What:		/sys/kernel/debug/iommu/intel/dmar_perf_latency
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file is used to control and show counts of
+		execution time ranges for various types per DMAR.
+
+		Firstly, write a value to
+		/sys/kernel/debug/iommu/intel/dmar_perf_latency
+		to enable sampling.
+
+		The possible values are as follows:
+
+		* 0 - disable sampling all latency data
+
+		* 1 - enable sampling IOTLB invalidation latency data
+
+		* 2 - enable sampling devTLB invalidation latency data
+
+		* 3 - enable sampling intr entry cache invalidation latency data
+
+		* 4 - enable sampling prq handling latency data
+
+		Next, read /sys/kernel/debug/iommu/intel/dmar_perf_latency gives
+		a snapshot of sampling result of all enabled monitors.
+
+		Examples in Kabylake:
+
+		::
+
+		 1) Disable sampling all latency data:
+
+		 $ sudo echo 0 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 2) Enable sampling IOTLB invalidation latency data
+
+		 $ sudo echo 1 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 IOMMU: dmar0 Register Base Address: 26be37000
+				 <0.1us   0.1us-1us    1us-10us  10us-100us   100us-1ms
+		 inv_iotlb           0           0           0           0           0
+
+		 		 1ms-10ms      >=10ms     min(us)     max(us) average(us)
+		 inv_iotlb           0           0           0           0           0
+
+		 [...]
+
+		 IOMMU: dmar2 Register Base Address: fed91000
+		 		 <0.1us   0.1us-1us    1us-10us  10us-100us   100us-1ms
+		 inv_iotlb           0           0          18           0           0
+
+				 1ms-10ms      >=10ms     min(us)     max(us) average(us)
+		 inv_iotlb           0           0           2           2           2
+
+		 3) Enable sampling devTLB invalidation latency data
+
+		 $ sudo echo 2 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 IOMMU: dmar0 Register Base Address: 26be37000
+				 <0.1us   0.1us-1us    1us-10us  10us-100us   100us-1ms
+		 inv_devtlb           0           0           0           0           0
+
+				 >=10ms     min(us)     max(us) average(us)
+		 inv_devtlb           0           0           0           0
+
+		 [...]
+
+What:		/sys/kernel/debug/iommu/intel/<bdf>/domain_translation_struct
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file dumps a specified page table of Intel IOMMU
+		in legacy mode or scalable mode.
+
+		For a device that only supports legacy mode, dump its
+		page table by the debugfs file in the debugfs device
+		directory. e.g.
+		/sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.
+
+		For a device that supports scalable mode, dump the
+		page table of specified pasid by the debugfs file in
+		the debugfs pasid directory. e.g.
+		/sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
+
+		Examples in Kabylake:
+
+		::
+
+		 1) Dump the page table of device "0000:00:02.0" that only supports legacy mode.
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct
+
+		 Device 0000:00:02.0 @0x1017f8000
+		 IOVA_PFN                PML5E                   PML4E
+		 0x000000008d800 |       0x0000000000000000      0x00000001017f9003
+		 0x000000008d801 |       0x0000000000000000      0x00000001017f9003
+		 0x000000008d802 |       0x0000000000000000      0x00000001017f9003
+
+		 PDPE                    PDE                     PTE
+		 0x00000001017fa003      0x00000001017fb003      0x000000008d800003
+		 0x00000001017fa003      0x00000001017fb003      0x000000008d801003
+		 0x00000001017fa003      0x00000001017fb003      0x000000008d802003
+
+		 [...]
+
+		 2) Dump the page table of device "0000:00:0a.0" with PASID "1" that
+		 supports scalable mode.
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/0000:00:0a.0/1/domain_translation_struct
+
+		 Device 0000:00:0a.0 with pasid 1 @0x10c112000
+		 IOVA_PFN                PML5E                   PML4E
+		 0x0000000000000 |       0x0000000000000000      0x000000010df93003
+		 0x0000000000001 |       0x0000000000000000      0x000000010df93003
+		 0x0000000000002 |       0x0000000000000000      0x000000010df93003
+
+		 PDPE                    PDE                     PTE
+		 0x0000000106ae6003      0x0000000104b38003      0x0000000147c00803
+		 0x0000000106ae6003      0x0000000104b38003      0x0000000147c01803
+		 0x0000000106ae6003      0x0000000104b38003      0x0000000147c02803
+
+		 [...]
-- 
2.21.3


