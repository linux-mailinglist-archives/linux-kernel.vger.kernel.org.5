Return-Path: <linux-kernel+bounces-95146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689B88749C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09627B237A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6082D64;
	Thu,  7 Mar 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTS6cv1e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150582880;
	Thu,  7 Mar 2024 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800542; cv=none; b=YuLt6voZ4RUNoE+ABLEVerK/DjnsJRQDYN3TaMMSPSX3w9UKo2H6EJskT6Ur+CXbWvPgxXWI0KRuYWndodVG2aiFswjgCFYL4s3TKr9l4psVD0sCsWzMi0kvO/Buos+7zVkYPIYN/rkywu2wFYMbK7m3z9DH/VOz5336HFXKhkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800542; c=relaxed/simple;
	bh=5KryanhO2TCSYIQImaXR38V4BObe+z/AOy3oiI3D08M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PS0I8EWAklf+sm0/XU4FLZmoxkws87Yd6nA1uLr3M/ow9mKdaIdHnSXP7yLwvd68JA5a6d7Fy9BcMtKNEJNd+dozUx0d0OIMSQNJIJOKyRoo+qwt6QTE0NWQWBcohCwMKYET19EM7I9+SaXq7Uh+8fmNtPnUe46ITDbxxvdsrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTS6cv1e; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709800541; x=1741336541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5KryanhO2TCSYIQImaXR38V4BObe+z/AOy3oiI3D08M=;
  b=gTS6cv1eopzTqq8ZiXLkvEUrfuS693iP/M4UpjAIEmq2u7NG7FwIbE/H
   1ta+gQaTEnh6kQifVQHQrhrquR/Mjk7tTvbExR5O0a6z4OczMCNVMZv6d
   OwvK3G+SI/1PAKeAglYoW6ypBH0tVmgS93EJQArm190UxUm/eYvDxEVsl
   55fzF1/dHFdpp6mYHNmsnFnudZn9U5g5DOSInBFjLUXAThjeXiDr1Lwfj
   gyIyXAmIsg/NAG11sLEOnTZKaJhQiV8qHBausNkPOFvjSRqqJna+SAOei
   CAdP213t5riE9ZHVi8OIgdMzk1B9N1quLdQHXSjE3Zb64wW346StOwcRx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4600483"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4600483"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:35:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="14699744"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orviesa004.jf.intel.com with ESMTP; 07 Mar 2024 00:35:30 -0800
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
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Tony Luck <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 4/6] ACPI: NUMA: Make some NUMA related parse functions common
Date: Thu,  7 Mar 2024 16:47:56 +0800
Message-Id: <c8b86184d9e6d078e9b9949d4837bc6e392c3f52.1709780590.git.haibo1.xu@intel.com>
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

The acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
and acpi_parse_cfmws() functions are common enough to be used
on platforms that support ACPI_NUMA(x86/arm64/loongarch).
Remove the condition to avoid long defined(CONFIG_ARCH) check
when new platform(riscv) support was enabled.

Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 drivers/acpi/numa/srat.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 1946431c0eef..938c4adb7ec4 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -219,7 +219,6 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
-#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
  * I/O localities since SRAT does not list them.  I/O localities are
@@ -351,13 +350,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	(*fake_pxm)++;
 	return 0;
 }
-#else
-static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
-				   void *arg, const unsigned long table_end)
-{
-	return 0;
-}
-#endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
 
 static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
-- 
2.34.1


