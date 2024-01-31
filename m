Return-Path: <linux-kernel+bounces-45662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE348433B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC98A28E030
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DCFD262;
	Wed, 31 Jan 2024 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+JT9BFr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1961FA1;
	Wed, 31 Jan 2024 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667532; cv=none; b=FDrFZTP2x6dK2Q+kBPterafeKpwfHi69yGY9OjMfZiDGou+MTT2wxBWyfq0qhds+btdEEumnWMbe+G6Zb7qef1F/korVn8pz1PtEDG3/m6L079gFOPBwA9eOlXD2sWVBC+j/QyPf+8QRVOd1O7FArVXl5NP9Nl4XMyh1fJR3h0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667532; c=relaxed/simple;
	bh=vVb6RIIvOt4enB6/MzuWcA6dkAPHXShQ2Vxb7to1nk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fpq5EE1+7gF2tglGVmgST1Zl+/rEUXH8B9TPiseQKZ6TGAaBB19MGuoNfBKTN9/z+QwPyoeQ0d4VmquZHXegsq6nY4EZ6t1WhhGUlKDnCCdX0XIodE28/Q4Jziyg1CbKifwT6lDMsc/RT1ejsHjyTjSlHvU02w3X5ZNJAxq6bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+JT9BFr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706667530; x=1738203530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVb6RIIvOt4enB6/MzuWcA6dkAPHXShQ2Vxb7to1nk8=;
  b=c+JT9BFrlYhYTn4TBb/f5zXZo1yTFyR3qoIN6jw7BatTkPRW/VrnDze6
   RkgGTTiFlgRFqmGjQEDbdjRwQcPX8+SDDY7ynKSavq0pjyCiy9UvORqoE
   AWnMnlxeOeOKreQ+xUYd/j3CYupCET5kiJ5Fsbpm1sT+lv8ocL2iNUAc2
   Fcw4DrGALZwT+0qx7gV2NQ/q02E50eqYhxvBSy6NMUbH5TcyLT2syjrvg
   9XQfmB7BTRmZBipZlBqfan4b6aZ7aevCxrPFE00HYrB+Wf13kyL7+m1yf
   TZTpYNd2nyv8Q1GvF6PlOxtCy7zCiw9hpiIseeJfH/uApcyV0xsumx/Ik
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24939042"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="24939042"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907714702"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907714702"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:18:41 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	sunilvl@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 1/4] ACPICA: SRAT: Add RISC-V RINTC affinity structure
Date: Wed, 31 Jan 2024 10:31:58 +0800
Message-Id: <6473e0bb42524e4f29112290a92539d1a800eb69.1706603678.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706603678.git.haibo1.xu@intel.com>
References: <cover.1706603678.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPICA commit 93caddbf2f620769052c59ec471f018281dc3a24

Add definition of RISC-V Interrupt Controller(RINTC)
affinity structure which was approved by UEFI forum
and will be part of next ACPI spec version(6.6).

Link: https://github.com/acpica/acpica/commit/93caddbf
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 include/acpi/actbl3.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index c080d579a546..5202e3fc9b41 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -192,7 +192,8 @@ enum acpi_srat_type {
 	ACPI_SRAT_TYPE_GIC_ITS_AFFINITY = 4,	/* ACPI 6.2 */
 	ACPI_SRAT_TYPE_GENERIC_AFFINITY = 5,	/* ACPI 6.3 */
 	ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY = 6,	/* ACPI 6.4 */
-	ACPI_SRAT_TYPE_RESERVED = 7	/* 7 and greater are reserved */
+	ACPI_SRAT_TYPE_RINTC_AFFINITY = 7,	/* ACPI 6.6 */
+	ACPI_SRAT_TYPE_RESERVED = 8	/* 8 and greater are reserved */
 };
 
 /*
@@ -296,6 +297,21 @@ struct acpi_srat_generic_affinity {
 #define ACPI_SRAT_GENERIC_AFFINITY_ENABLED     (1)	/* 00: Use affinity structure */
 #define ACPI_SRAT_ARCHITECTURAL_TRANSACTIONS   (1<<1)	/* ACPI 6.4 */
 
+/* 7: RINTC Affinity (ACPI 6.6) */
+
+struct acpi_srat_rintc_affinity {
+	struct acpi_subtable_header header;
+	u16 reserved;           /* Reserved, must be zero */
+	u32 proximity_domain;
+	u32 acpi_processor_uid;
+	u32 flags;
+	u32 clock_domain;
+};
+
+/* Flags for struct acpi_srat_rintc_affinity */
+
+#define ACPI_SRAT_RINTC_ENABLED     (1)	/* 00: Use affinity structure */
+
 /*******************************************************************************
  *
  * STAO - Status Override Table (_STA override) - ACPI 6.0
-- 
2.34.1


