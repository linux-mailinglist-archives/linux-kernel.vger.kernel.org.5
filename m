Return-Path: <linux-kernel+bounces-46350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E22A843E69
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D651C21B62
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5374E3E;
	Wed, 31 Jan 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5DvL+Ch"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B6D78676
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700738; cv=none; b=sXIRX6sIrCjosGIlvxRHnNBCmHfum8yLmTBFlNZuymUb2IO5b4ZkkwX7lKF1NnqNjHTLI+XG7d2s7BMXbr16hQiC59+bqvg9vfVcqQNXrfqdkViGeHs5A8xGss7/d9iFVSNFiXYS3a++DPfoSJJfixIWHo0KK016wVPEdnMjGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700738; c=relaxed/simple;
	bh=YJkpXfj77W6zId/DBHAD6wMYoSjxGXRmcWi4w8zk/iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kT+gPbtV50JlfbDyD0fOta8oflTdcnkYneBAaYNhNX5MhJgV5KC3DUeXTl6f0d8dq2HeuEJMTDLiKwRlhEfmQ5LMVtrq73t/xHDka46Te6cyq6JoqemaL+WpXx78LCaA9226CzdK/AU98Ths6NrOjiu7wmZrsKEA+ZSfAGIDpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5DvL+Ch; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706700734; x=1738236734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YJkpXfj77W6zId/DBHAD6wMYoSjxGXRmcWi4w8zk/iY=;
  b=d5DvL+ChUDBvlVnEbdQZioyHTdviW0BkX9OmBLqQnsiPYSETKmyYDYIf
   xy3CTewBeXz+g2p7rUDSz4HMkf71XKHhLyJ21ypFzWfKEbBdXwe9VAEdb
   d2PhQO1gacDn33hw/zk8ByaTkKNEQOmNKa+PYdejflMFGkrIoS3xzlXoV
   veV0w3aLyevNexrmwxVcqa8g1yqwEZXnjdDHGZ5BWwB87+9ARpNpGCVzi
   qRvnkoyjlq1fdDG/tUW+Ulwzch6V+cDC5Mw5cCYxl9rJ4zOhOQdKgZKRZ
   dvEDYQsqn/uEqoksjaWGR0HPBlf77TxS5k0PbNGl9o6+Ip9JTfWeU8rwg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3414182"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3414182"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878764802"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="878764802"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:10 -0800
From: "Huang, Kai" <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	thomas.lendacky@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com
Subject: [PATCH 2/4] x86/virt/tdx: Advertise the CC_ATTR_HOST_MEM_INCOHERENT for TDX host
Date: Wed, 31 Jan 2024 11:31:54 +0000
Message-Id: <ebbc67eb2c6052dd56fda31cd22bb830d3d290ef.1706698706.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706698706.git.kai.huang@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kai Huang <kai.huang@intel.com>

On the TDX capable platform, during kexec() the old kernel needs to
flush dirty cachelines of all TDX private memory otherwise they may
silently corrupt the new kernel's memory.

Advertise the new introduced CC_ATTR_HOST_MEM_INCOHERENT attribute for
TDX host platform so the cache will be flushed during kexec().

Note theoretically cache flush is only needed when TDX module is
initialized, but the module initialization is done at runtime so just
advertise the CC attribute when the platform has TDX enabled.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/Kconfig            |  1 +
 arch/x86/coco/core.c        | 21 ++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.c |  3 +++
 include/linux/cc_platform.h |  3 ++-
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 502986237cb6..ac3b32149a77 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1975,6 +1975,7 @@ config INTEL_TDX_HOST
 	depends on CONTIG_ALLOC
 	depends on !KEXEC_CORE
 	depends on X86_MCE
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
 	  host and certain physical attacks.  This option enables necessary TDX
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 8d6d727e6e18..ecb15852b69d 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -12,11 +12,12 @@
 
 #include <asm/coco.h>
 #include <asm/processor.h>
+#include <asm/cpufeature.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
 static u64 cc_mask __ro_after_init;
 
-static bool noinstr intel_cc_platform_has(enum cc_attr attr)
+static bool noinstr intel_cc_platform_guest_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
@@ -29,6 +30,24 @@ static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 	}
 }
 
+static bool noinstr intel_cc_platform_host_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_HOST_MEM_INCOHERENT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool noinstr intel_cc_platform_has(enum cc_attr attr)
+{
+	if (boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return intel_cc_platform_host_has(attr);
+
+	return intel_cc_platform_guest_has(attr);
+}
+
 /*
  * Handle the SEV-SNP vTOM case where sme_me_mask is zero, and
  * the other levels of SME/SEV functionality, including C-bit
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d6826a76f78..9f1fed458a32 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -37,6 +37,7 @@
 #include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
+#include <asm/coco.h>
 #include "tdx.h"
 
 static u32 tdx_global_keyid __ro_after_init;
@@ -1488,5 +1489,7 @@ void __init tdx_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_HOST_PLATFORM);
 
+	cc_vendor = CC_VENDOR_INTEL;
+
 	check_tdx_erratum();
 }
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 2f7273596102..654777d64dc0 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -53,7 +53,8 @@ enum cc_attr {
 	 * Use this in places where the cache coherency of the memory matters
 	 * but the encryption status does not.
 	 *
-	 * Includes all systems that set CC_ATTR_HOST_MEM_ENCRYPT.
+	 * Includes all systems that set CC_ATTR_HOST_MEM_ENCRYPT, but
+	 * additionally adds TDX hosts.
 	 */
 	CC_ATTR_HOST_MEM_INCOHERENT,
 
-- 
2.34.1


