Return-Path: <linux-kernel+bounces-95145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF478749BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E826B234C8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E966A82D64;
	Thu,  7 Mar 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPAvbsS1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA25882C63;
	Thu,  7 Mar 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800528; cv=none; b=ZgSw/7ypVTyuxV6cPBaLjOde6c4Yyh0kkELAJOCTSZvRhLQ7Mi8fugMxnr74bYIucB9ZlN+lEoznWSHQ3ml4TuOdX3xOPjxTsMYTQRoZtFo26J2M+gWGtFkmzwlq2xc2/THW+wv9Pr0NjFIZ4R5oDXYM/IvyOW7tJpWVn0MPaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800528; c=relaxed/simple;
	bh=zlLV9ie8bQV5hBn/ivuNmVBmT3a1tMf86LVGS17OHVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nd54Ox+i3U0E3M82XpmYgJA7P/N02KGPjgipUG/fy1ZpOxQ5qP3vB7VFRfZX34bdOxMiP+0ZtxP1xU2klIQlcnjpoEVD6Fdp7ijrtevvdt8noLhNBmiTQ3cduAOTsjpU3ikvhSpuBlcHvrNq5y0XpwiKYA4nhrH+/DaA9OPYDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPAvbsS1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709800525; x=1741336525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zlLV9ie8bQV5hBn/ivuNmVBmT3a1tMf86LVGS17OHVw=;
  b=TPAvbsS1LJ5kIwCQobuAorEoq1E2BRVx2vCq8rN3939A6LKQI3uY+tl/
   aCVkjI9mFPj34tLd2D9fIUY3cF3iQKpxxOJIUHQ6M2LC0ZllZyrtaxvBD
   yugv0X86al4F41ZLITplf9w3A8gulm6xORwSdTgiu/mOwN8hUs0AfHta8
   cl0tM3URpw4QI1y1Zu8+WrJ/zhRNhsl+2pq25RZwPQMsuDK7Fb0tdUvAF
   HpOoj+p9s1gJFN7sRypj4LKejDXqQzbuGMu7rPtC+iAzY3dE2TaHEh+AQ
   9uj0r5Q2qdiubuxSYevp5PRbfmBBh1DjnoSMsKMFHvAP4eOAl70WatQXB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4600448"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4600448"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:35:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="14699692"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orviesa004.jf.intel.com with ESMTP; 07 Mar 2024 00:35:12 -0800
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 3/6] ACPI: NUMA: Add handler for SRAT RINTC affinity structure
Date: Thu,  7 Mar 2024 16:47:55 +0800
Message-Id: <91a4bc39444c80ea960bbd070bea489d27628cb6.1709780590.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709780590.git.haibo1.xu@intel.com>
References: <cover.1709780590.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RINTC affinity structure handler during parsing SRAT table.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 drivers/acpi/numa/srat.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 0214518fc582..1946431c0eef 100644
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
+			  const unsigned long end)
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
-- 
2.34.1


