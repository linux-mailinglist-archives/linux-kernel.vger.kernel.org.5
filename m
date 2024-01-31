Return-Path: <linux-kernel+bounces-45663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28638433BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A51B257E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96959FBE1;
	Wed, 31 Jan 2024 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bky9jtv1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599CFBE7;
	Wed, 31 Jan 2024 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667549; cv=none; b=hwjS6dHOXHwz2ntDDT9TKsFj6Dy99mqzd3uT+QFW/LO54jRONuYyLVMuYAnmj4W4eQgVXpE0mPYdzVbdc50fy6T4So7hhsLd4Kol5tqIZhYg1PAxbW4vxb2yfxLvt0zWPNVaJ6JQLEdfUnMwgkPDeLuAw3EWc/TzbfP67EIiBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667549; c=relaxed/simple;
	bh=EazMTTYX9oeR/uhQC7ENeexop7S60anC75kEcPjLk3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRlHFImZmwG4Mz3li7x4FxYVz0PLReapV15ZazSPnIaKRoDn33httJ7f9rwiVRYT8JdR1Prr4WBqou00qc2UVj8oW7IKXt0V7IbjzXs2jM6gNwmLgUHmSd65ZeM2qDRc60Q+bXAkv0ena5H3kxbThI1ckHle5SV/V620uBfxpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bky9jtv1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706667547; x=1738203547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EazMTTYX9oeR/uhQC7ENeexop7S60anC75kEcPjLk3Y=;
  b=Bky9jtv1AmGnEyLuST7iUPm66tWCHVgLTmBmJ/2GNDFZNRdmDWmk4Mz7
   Tm0tF6d4Ud8gS0k+mjha5BeRWmMPLMi4RsvgN7arXDcia0PfUo4dAvFq8
   e9uNu/jUlFYVRDsyMIOz0Uh8hAJ0gOxpj9OcJbFHQOsMVEhMGFDTa+bm8
   CjWU/82fsxz80z/VvOvlJpcSf9zcQvCJoTLgE4qhogq8jGGyQnbyl+Rx5
   wBR959dZwA5DgbM2cZDW+xSf5zGn3fa98HthE+k/MIk6kp/+VPSa4xWD7
   nWIFSZPtvJCxX0jmTwSQOIMksi/0NHwhjJxx69/k2AtVqjl3FBQafxuwZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24939137"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="24939137"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:19:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907714731"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907714731"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:18:59 -0800
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
	Baoquan He <bhe@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 2/4] ACPI: NUMA: Add handler for SRAT RINTC affinity structure
Date: Wed, 31 Jan 2024 10:31:59 +0800
Message-Id: <a1e20de53156f50385c7609507982f08866e859b.1706603678.git.haibo1.xu@intel.com>
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

Add RINTC affinity structure handler during parsing SRAT table.
The ARCH specific implementation will be added in next patch.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 drivers/acpi/numa/srat.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/acpi.h     |  3 +++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 0214518fc582..503abcf6125d 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -165,6 +165,19 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 		}
 	}
 	break;
+
+	case ACPI_SRAT_TYPE_RINTC_AFFINITY:
+		{
+			struct acpi_srat_rintc_affinity *p =
+			    (struct acpi_srat_rintc_affinity *)header;
+			pr_debug("SRAT Processor (acpi id[0x%04x]) in proximity domain %d %s\n",
+				 p->acpi_processor_uid,
+				 p->proximity_domain,
+				 (p->flags & ACPI_SRAT_RINTC_ENABLED) ?
+				 "enabled" : "disabled");
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
 			header->type);
@@ -448,6 +461,21 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
 }
 #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
 
+static int __init
+acpi_parse_rintc_affinity(union acpi_subtable_headers *header,
+			 const unsigned long end)
+{
+	struct acpi_srat_rintc_affinity *rintc_affinity;
+
+	rintc_affinity = (struct acpi_srat_rintc_affinity *)header;
+	acpi_table_print_srat_entry(&header->common);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_rintc_affinity_init(rintc_affinity);
+
+	return 0;
+}
+
 static int __initdata parsed_numa_memblks;
 
 static int __init
@@ -501,7 +529,7 @@ int __init acpi_numa_init(void)
 
 	/* SRAT: System Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
-		struct acpi_subtable_proc srat_proc[4];
+		struct acpi_subtable_proc srat_proc[5];
 
 		memset(srat_proc, 0, sizeof(srat_proc));
 		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
@@ -512,6 +540,8 @@ int __init acpi_numa_init(void)
 		srat_proc[2].handler = acpi_parse_gicc_affinity;
 		srat_proc[3].id = ACPI_SRAT_TYPE_GENERIC_AFFINITY;
 		srat_proc[3].handler = acpi_parse_gi_affinity;
+		srat_proc[4].id = ACPI_SRAT_TYPE_RINTC_AFFINITY;
+		srat_proc[4].handler = acpi_parse_rintc_affinity;
 
 		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
 					sizeof(struct acpi_table_srat),
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..a65273db55c6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -269,6 +269,9 @@ acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
 
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 
+static inline void
+acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa) { }
+
 #ifndef PHYS_CPUID_INVALID
 typedef u32 phys_cpuid_t;
 #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
-- 
2.34.1


