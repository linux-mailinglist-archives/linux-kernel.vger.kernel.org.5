Return-Path: <linux-kernel+bounces-120270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5388D522
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD331F2C639
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1122F08;
	Wed, 27 Mar 2024 03:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hFgqz3C5"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6D23769;
	Wed, 27 Mar 2024 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511120; cv=none; b=ibjz1OTpnOmDlhMepR+mF+Gsn8xUqYnNGdHtPDtvvqdnoZCn/RW4nftwffaeqcDgf5PKJBoS383jmNnupJsuriHEPVuxjFolRNOHJu4GWDKAT+FU+/0lVFrneGyV7nQkLtTvSdejGcAzYNJ1JDN725nn+9WcVb1oWAzgZeGGCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511120; c=relaxed/simple;
	bh=2rncZZlIdofYt8J5dhgNenPopK97Jv62P6DPdFmFmEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNf8WOzVRliyRBXV21Klsy7sLX8NKzvz7a/+ycN8GfxJy1qir0YtCjt7BWCLA+fiMOJSQ9dy0C2BeMHpkp24WsRjPy4fGdwWdmmbbIGT/NxDZWXUj/+jMX1+1EdNnyODsGIFGsnfDlhTXQBVBn/UQ9mMm7bg357HRP44EMMDtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hFgqz3C5; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711511115; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HMclX/5CZM0rvzHm0A+OVqL2+Az2IuqscyUeEgI8how=;
	b=hFgqz3C53jk84ahj6xu/K1j4zck6eKx8Rh8MsUcrk3NvxlUDuMus4h09RrbVYw4l6zUkEXWlWcnPkEv7qU9JIvo8AFFT/xZ/tQUqdJ7NU4PjNhfIADrlma655fcnjKct51Vd6JyPz4luZqnDpHi0ndjU+ZOmelm2Ub8nMDdx38o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3NKOdQ_1711511112;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W3NKOdQ_1711511112)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 11:45:15 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	tianruidond@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 2/2] ACPICA: AEST: Add support for the AEST V2 table
Date: Wed, 27 Mar 2024 11:45:00 +0800
Message-Id: <20240327034500.95601-3-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240327034500.95601-1-tianruidong@linux.alibaba.com>
References: <20240327034500.95601-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPICA commit ebb49799c78891cbe370f1264844664a3d8b6f35

AEST V2 was published[1], add V2 support based on AEST V1.

[1]: https://developer.arm.com/documentation/den0085/latest/

Link: https://github.com/acpica/acpica/commit/ebb4979
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 include/acpi/actbl2.h | 88 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c32e97855031..97ea17ae932c 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -77,8 +77,8 @@
  *
  * AEST - Arm Error Source Table
  *
- * Conforms to: ACPI for the Armv8 RAS Extensions 1.1 Platform Design Document
- * September 2020.
+ * Conforms to: ACPI for the Armv8 RAS Extensions 1.1(Sep 2020) and
+ * 2.0(May 2023) Platform Design Document.
  *
  ******************************************************************************/
 
@@ -108,7 +108,9 @@ struct acpi_aest_hdr {
 #define ACPI_AEST_SMMU_ERROR_NODE           2
 #define ACPI_AEST_VENDOR_ERROR_NODE         3
 #define ACPI_AEST_GIC_ERROR_NODE            4
-#define ACPI_AEST_NODE_TYPE_RESERVED        5	/* 5 and above are reserved */
+#define ACPI_AEST_PCIE_ERROR_NODE           5
+#define ACPI_AEST_PROXY_ERROR_NODE          6
+#define ACPI_AEST_NODE_TYPE_RESERVED        7 /* 7 and above are reserved */
 
 /*
  * AEST subtables (Error nodes)
@@ -180,6 +182,12 @@ struct acpi_aest_vendor {
 	u8 vendor_specific_data[16];
 };
 
+struct acpi_aest_vendor_v2 {
+	char acpi_hid[8];
+	u32 acpi_uid;
+	u8 vendor_specific_data[16];
+};
+
 /* 4: Gic Error */
 
 struct acpi_aest_gic {
@@ -195,6 +203,18 @@ struct acpi_aest_gic {
 #define ACPI_AEST_GIC_ITS                   3
 #define ACPI_AEST_GIC_RESERVED              4	/* 4 and above are reserved */
 
+/* 5: PCIe Error */
+
+struct acpi_aest_pcie {
+	u32 iort_node_reference;
+};
+
+/* 6: Proxy Error */
+
+struct acpi_aest_proxy {
+	u64 node_address;
+};
+
 /* Node Interface Structure */
 
 struct acpi_aest_node_interface {
@@ -209,11 +229,57 @@ struct acpi_aest_node_interface {
 	u64 addressing_mode;
 };
 
+/* Node Interface Structure V2 */
+
+struct acpi_aest_node_interface_header {
+	u8 type;
+	u8 group_format;
+	u8 reserved[2];
+	u32 flags;
+	u64 address;
+	u32 error_record_index;
+	u32 error_record_count;
+};
+
+#define ACPI_AEST_NODE_GROUP_FORMAT_4K          0
+#define ACPI_AEST_NODE_GROUP_FORMAT_16K         1
+#define ACPI_AEST_NODE_GROUP_FORMAT_64K         2
+
+struct acpi_aest_node_interface_common {
+	u32 error_node_device;
+	u32 processor_affinity;
+	u64 error_group_register_base;
+	u64 fault_inject_register_base;
+	u64 interrupt_config_register_base;
+};
+
+struct acpi_aest_node_interface_4k {
+	u64 error_record_implemented;
+	u64 error_status_reporting;
+	u64 addressing_mode;
+	struct acpi_aest_node_interface_common common;
+};
+
+struct acpi_aest_node_interface_16k {
+	u64 error_record_implemented[4];
+	u64 error_status_reporting[4];
+	u64 addressing_mode[4];
+	struct acpi_aest_node_interface_common common;
+};
+
+struct acpi_aest_node_interface_64k {
+	u64 errorrecordimplemented[14];
+	u64 errorstatusreporting[14];
+	u64 addressingmode[14];
+	struct acpi_aest_node_interface_common common;
+};
+
 /* Values for Type field above */
 
-#define ACPI_AEST_NODE_SYSTEM_REGISTER      0
-#define ACPI_AEST_NODE_MEMORY_MAPPED        1
-#define ACPI_AEST_XFACE_RESERVED            2	/* 2 and above are reserved */
+#define ACPI_AEST_NODE_SYSTEM_REGISTER			0
+#define ACPI_AEST_NODE_MEMORY_MAPPED			1
+#define ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED	2
+#define ACPI_AEST_XFACE_RESERVED			3   /* 2 and above are reserved */
 
 /* Node Interrupt Structure */
 
@@ -226,6 +292,16 @@ struct acpi_aest_node_interrupt {
 	u8 reserved1[3];
 };
 
+/* Node Interrupt Structure V2 */
+
+struct acpi_aest_node_interrupt_v2 {
+	u8 type;
+	u8 reserved[2];
+	u8 flags;
+	u32 gsiv;
+	u8 reserved1[4];
+};
+
 /* Values for Type field above */
 
 #define ACPI_AEST_NODE_FAULT_HANDLING       0
-- 
2.33.1


