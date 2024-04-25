Return-Path: <linux-kernel+bounces-158307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC928B1E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79ED1C231DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F186641;
	Thu, 25 Apr 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UReQpdv3"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB384DE6;
	Thu, 25 Apr 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037683; cv=none; b=FDxnCb16UP9bo4MNI/9m8tw8GyvdmOob53ACqjW44+tbPe69YO7O76T7LS2BoYTMIsnTBxrFlm5yjEVMokCYwmZKrB3YXS+pwWt+Jg7mzqM+FVDM38iPIpCRyeIkv+TU3g08VmGBTK2QovQiitlNTkrnMxGPiu0R0WIxO1Lvb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037683; c=relaxed/simple;
	bh=5JEtP0YgJBdXih/ZcnvEmCqK+JklmCvRY/KLEJlOKdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DxLUKOtHwdT6kgcZmwjPfiJwa3B79rGbxOcZfSYqKeclVFtKEUQR4FkPE0ZI+LmC+xfuyGM37HPaWcwuiq4v9WFh7YFP0tk0x9XsVHm5LkuFD2PIVYBIYG8p9U0AtL26gsL8U2uEG/2vQILz1Ruab9of4goElFsgPsASsAMN7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UReQpdv3; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714037676; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XM7ij0If3WF0JBNX1i/Nd5TClC00Y289tpdDGzmcErU=;
	b=UReQpdv3Rmk4Smm37AIcmn0MfVF2nC8hVYE9HSv1imvXW7H1ambynnrgn6P672UNt/3B39c3eYe5CfGE4bztMTGeleA/6ScJ8OXeTtI3w+prEw2/NqFzvN6D8yuvEtczxwQ9ibN4tlDoquh0Pv6X7BaWSrwdx0PrzmN+2BtoeTM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5F0WnH_1714037673;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W5F0WnH_1714037673)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 17:34:35 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	sudeep.holla@arm.com
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	tianruidong@linux.alibaba.com
Subject: [PATCH v3 1/1] ACPICA: AEST: Add support for the AEST V2 table
Date: Thu, 25 Apr 2024 17:34:26 +0800
Message-Id: <20240425093426.76130-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240425093426.76130-1-tianruidong@linux.alibaba.com>
References: <20240425093426.76130-1-tianruidong@linux.alibaba.com>
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
index 007cfdfd5d29..ae747c89d92c 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -78,8 +78,8 @@
  *
  * AEST - Arm Error Source Table
  *
- * Conforms to: ACPI for the Armv8 RAS Extensions 1.1 Platform Design Document
- * September 2020.
+ * Conforms to: ACPI for the Armv8 RAS Extensions 1.1(Sep 2020) and
+ * 2.0(May 2023) Platform Design Document.
  *
  ******************************************************************************/
 
@@ -109,7 +109,9 @@ struct acpi_aest_hdr {
 #define ACPI_AEST_SMMU_ERROR_NODE           2
 #define ACPI_AEST_VENDOR_ERROR_NODE         3
 #define ACPI_AEST_GIC_ERROR_NODE            4
-#define ACPI_AEST_NODE_TYPE_RESERVED        5	/* 5 and above are reserved */
+#define ACPI_AEST_PCIE_ERROR_NODE           5
+#define ACPI_AEST_PROXY_ERROR_NODE          6
+#define ACPI_AEST_NODE_TYPE_RESERVED        7 /* 7 and above are reserved */
 
 /*
  * AEST subtables (Error nodes)
@@ -188,6 +190,12 @@ typedef struct acpi_aest_vendor {
 
 } acpi_aest_vendor;
 
+struct acpi_aest_vendor_v2 {
+	char acpi_hid[8];
+	u32 acpi_uid;
+	u8 vendor_specific_data[16];
+};
+
 /* 4: Gic Error */
 
 typedef struct acpi_aest_gic {
@@ -204,6 +212,18 @@ typedef struct acpi_aest_gic {
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
 
 typedef struct acpi_aest_node_interface {
@@ -219,11 +239,57 @@ typedef struct acpi_aest_node_interface {
 
 } acpi_aest_node_interface;
 
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
+	u64 error_record_implemented[14];
+	u64 error_status_reporting[14];
+	u64 addressing_mode[14];
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
 
@@ -237,6 +303,16 @@ typedef struct acpi_aest_node_interrupt {
 
 } acpi_aest_node_interrupt;
 
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


