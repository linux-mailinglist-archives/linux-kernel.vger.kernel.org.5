Return-Path: <linux-kernel+bounces-95147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA068749C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D299283F47
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFEC82D63;
	Thu,  7 Mar 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlMbRhjg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C881AA3;
	Thu,  7 Mar 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800559; cv=none; b=XK0mnDNZNraYcvWGMkTG4jk8kJLk1jh6AokL9eAWGtJfxQeY5PpIXFw+epRAI4HdPljEaCLj4Mvx2jsMl4j+e4Qt6C0UUvzsyhy5lR7qR0V1S0yE47p/393jNSQBe/4cV7wsd5mMCrYLIuUsZ3YaQNYD1W1EOOnJL/6TkEXZBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800559; c=relaxed/simple;
	bh=G2PxXHztRKQAfPknbFAyA05wr44/TwgHtP5gL+9Rl30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPNzR79niHrAKuceYUaEJWfsc0gbvDm0Gl9FAv2DcTnsmiMS5AKqwwSl1mNFb+oTKHipMlgjH+Ho5IBjGmyS7Z6OthBhg4Aa5+S0+ATDoCEK5ROidy8jjm8iS21Vs8f14DEX/yeJHY52smGM/Q9/q33X1vSJylB4ZyXo4tYw2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlMbRhjg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709800558; x=1741336558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G2PxXHztRKQAfPknbFAyA05wr44/TwgHtP5gL+9Rl30=;
  b=MlMbRhjgnbhxaH6xbO5QVtZeitPU4cpXqTYCT2iAATg2xEdfUFhvHb1K
   p6hfiXKPGAUBeVz7D7f4aE2eWaJ7PthSn54iT+qFJyi8Tevcd6pCGCeDD
   sKEW0Y2oUJWCpaMI4gvy/ieJEXAzF60GRh7v4QpL9WDPhF65LnLuQ4ErF
   Y05/WNMncqoclrt5yCR7GccqN+jX8bOHH9tKyomHTEhLDzNGuyEoHBXL5
   hQkFL9+yJJ/EA/KBjrgnqeTGTmYtZJtW0WBXassTSDQbnl3YwnOy/jgcO
   Jsu1uFi/eGg68uW4GF+WZrKE/aXQGOCxvjf7AGa3H7vQ8k0/naCXuGGq4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4600517"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4600517"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:35:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="14699786"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orviesa004.jf.intel.com with ESMTP; 07 Mar 2024 00:35:48 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	sunilvl@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
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
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
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
Subject: [PATCH v2 5/6] ACPI: NUMA: Remove ARCH depends option in ACPI_NUMA Kconfig
Date: Thu,  7 Mar 2024 16:47:57 +0800
Message-Id: <f23da383a8fdbee15acd41fdcd38ef3a89045a43.1709780590.git.haibo1.xu@intel.com>
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

x86/arm64/loongarch would select ACPI_NUMA by default and riscv
would do the same thing, so the dependency is no longer needed
since these are the four architectures that support ACPI.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 drivers/acpi/numa/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index 849c2bd820b9..2bf47ad1ec9b 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -2,7 +2,6 @@
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
-	depends on (X86 || ARM64 || LOONGARCH)
 	default y if ARM64
 
 config ACPI_HMAT
-- 
2.34.1


