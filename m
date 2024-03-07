Return-Path: <linux-kernel+bounces-95148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336108749CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6571D1C21710
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7D982881;
	Thu,  7 Mar 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jk4CwirG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFD82885;
	Thu,  7 Mar 2024 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800578; cv=none; b=Tu1pkyGZnZe7yquDpcX2I2NhZz/6gtxV/KrC3cRtJkkVbZa64cIt1jZqwav6r8A3ILzdwPmz58wGs82nDgrDgCNLoFA3GRFXegZD58PTVIxWhUeDQ7oR+7Eq3k1kHfLqjWW62KFVCnDJOw4MWYqXNAzTJM9p9DtaVs9roaATneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800578; c=relaxed/simple;
	bh=u6KLTZtmTIu5DykU16R/5uPB7IyWMKQDWEnAzeiRdU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfCQeXfWljqju5o+YK9hGPNmHoAUVnOGaU20WncO3HwbVypblbRwQV+33tEW0vWXhtF1ALzvzUdvCgVfAJopUTjhL+Wvy2gzk5LmmMq671vZC7FlPjNx1Rg42El4XJYvy2EEfsJpYuxL5AinLFO/niNx1eXb9EB62NNAXHh5Mm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jk4CwirG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709800577; x=1741336577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6KLTZtmTIu5DykU16R/5uPB7IyWMKQDWEnAzeiRdU8=;
  b=Jk4CwirGcOrTGxwCRxOnHVewOY48k+K1y/9LtKipoS8R9+6L1Ph0btlm
   RySYvV43aIptACLYTmLrfbhbfYXlkhUsk75anJD/PtQQSYv6LJfE9wFPD
   xZjFi1FfDGiuD5qMC1YnntjN+hkWQB5NXjV43EDlT+p5EzmtFzXGAq0ny
   eH4+Z66j7nM0XfFimD9mLCnQAC/5lmJpsKFSGXUFA2Ksmh3z52JC1sFJ8
   aMfd+kacuwL1znBijGWPqZ7TIWlaooseJWLRjyZM7aIyuHbDVAr4IcGvN
   IRwdYJ1KgVeymAiMu2EPM3H4r2oJFIwthYmn1WCrN5fDCftmAs8IOtZqR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4600549"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4600549"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:36:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="14699817"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orviesa004.jf.intel.com with ESMTP; 07 Mar 2024 00:36:06 -0800
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
	Charlie Jenkins <charlie@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Tony Luck <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
Date: Thu,  7 Mar 2024 16:47:58 +0800
Message-Id: <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>
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

Enable ACPI based NUMA for RISCV in Kconfig.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0bfcfec67ed5..0fb55f166701 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -447,6 +447,7 @@ config NUMA
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
+	select ACPI_NUMA if ACPI
 	select OF_NUMA
 	select USE_PERCPU_NUMA_NODE_ID
 	help
-- 
2.34.1


