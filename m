Return-Path: <linux-kernel+bounces-45665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B98433BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0903828ECB3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC24182C1;
	Wed, 31 Jan 2024 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icImzQlZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7620DE3;
	Wed, 31 Jan 2024 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667584; cv=none; b=YXjIKHkLcYUPAMgVKyIhRc+26WDhwI25Ch9qfb1SKNrSK+9kFYYhzlhPTGXCGcE/z9GeY7eg79xNnvWau68rAH2nnmaZuQmJZYPqfEE5wjdS7nxgwX6iTo2DSdjphTrC+4UCD5Cidcf4HrN6M/fYevUFq5p1Ab+6OrsxrNOigzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667584; c=relaxed/simple;
	bh=DiVbdcfk8LX+ol56FVokjIK00/hL0BAvFjQKr27Ubus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIVDgCuszfLFYngmSH4DzWKO5hL3ffsCBU3HNNWTZnmIrK4zszauSA//hAZimFVW8RuoD4FIDj8lAHfgpDLQNKiO80KEEm5Dm6r9FktAy8ltE7ugsh5zkqDl5jE3PO/KGnyJXpBO0ohEyWiNpmpPkWlqY95fuDOK1wX1bOJcuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icImzQlZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706667583; x=1738203583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DiVbdcfk8LX+ol56FVokjIK00/hL0BAvFjQKr27Ubus=;
  b=icImzQlZdau0hJenETKLQXFl18VO/Fe1XIvk8VEbkP9lw3QAvDemsrMG
   NWWnHvnQ639Zlrc5sIQqwhGvENLjToTfiKktds65zITan2402h37rz+b2
   kA0FKWYTqYeHUjsdQ1hxe4SC166J8Jmkg9TSTbV00hiA8h43mFt09EAJ6
   UKIDArshA3SR3DQW9Kiu9hLh95F1w0ln8HZHCcN2vzfjC0bdcyNQOJEdB
   yJqdsc0wUMbs935Tf6fEEsrdjahqcAtwZ6F4fwvK5Jh6pLLvPlqyHCAL3
   Xz5nA3V7Dqm4u0ak6mQ6gl6wNKJlDiL7TF2Bpx6Q7uZS5ivWOPXjfgX+G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24939230"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="24939230"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:19:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907714867"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907714867"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:19:34 -0800
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
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 4/4] ACPI: RISCV: Enable ACPI based NUMA
Date: Wed, 31 Jan 2024 10:32:01 +0800
Message-Id: <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
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

Enable ACPI based NUMA for RISCV in Kconfig.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 arch/riscv/Kconfig        | 1 +
 drivers/acpi/numa/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..e586ab959f34 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -438,6 +438,7 @@ config NUMA
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
+	select ACPI_NUMA if ACPI
 	select OF_NUMA
 	select USE_PERCPU_NUMA_NODE_ID
 	help
diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index 849c2bd820b9..525297c44250 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -2,7 +2,7 @@
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
-	depends on (X86 || ARM64 || LOONGARCH)
+	depends on (X86 || ARM64 || LOONGARCH || RISCV)
 	default y if ARM64
 
 config ACPI_HMAT
-- 
2.34.1


