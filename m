Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0842581216E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442796AbjLMW2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:28:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F369C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702506518; x=1734042518;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HpuAdMiAO4lybLIeFgEemGJAj2QUz6odxBEV0pixzpo=;
  b=M2LonyVjEfb0Wa2C6H6ZuvGYgT7yQr5WgMWO57yQFRkMDR9mRcDz+iVj
   dClFnZMFe7vsx+gGPyB7sQ3dALIIA4Sx1Ce9cGZ1vBzz1mX7+NGSlgbEX
   iVl0hMACTJjIYd/fAqbcCf3DMSgwHiE2Wmr5dU7qJsVFVHCtyH/DBbORN
   wKNgHBNAw2OEDKqFLgw3KAO8IJDdl+Ddh6kZyd7C0yIizD09BgWdampRl
   Hnxz/pOF6tvNGMxiFluPUxK+uhjhXYuTx4Xu2q4rX3mxcm3vtEzTD6gPn
   KnIS0B+9JgvljcozuZ/hI/bRocLZ3mm2KjYSTnX0syBofGrgVvhNaCXIu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="461504633"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="461504633"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:28:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="892186286"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="892186286"
Received: from gears-pc1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.221.130])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:28:35 -0800
From:   Kai Huang <kai.huang@intel.com>
To:     dave.hansen@intel.com, arnd@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kirill.shutemov@linux.intel.com, bp@alien8.de,
        peterz@infradead.org, tglx@linutronix.de, tony.luck@intel.com,
        mingo@redhat.com, hpa@zytor.com, kai.huang@intel.com
Subject: [PATCH] x86/virt/tdx: Make TDX host depend on X86_MCE
Date:   Thu, 14 Dec 2023 11:28:25 +1300
Message-ID: <20231213222825.286809-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A build failure was reported that when INTEL_TDX_HOST is enabled but
X86_MCE is not, the tdx_dump_mce_info() function fails to link:

  ld: vmlinux.o: in function `tdx_dump_mce_info':
  ...: undefined reference to `mce_is_memory_error'
  ...: undefined reference to `mce_usable_address'

The reason is in such configuration, despite there's no caller of
tdx_dump_mce_info() it is still built and there's no implementation for
the two "mce_*()" functions.

Make INTEL_TDX_HOST depend on X86_MCE to fix.

It makes sense to enable MCE support for the TDX host anyway.  Because
the only way that TDX has to report integrity errors is an MCE, and it
is not good to silently ignore such MCE.  The TDX spec also suggests
the host VMM is expected to implement the MCE handler.

Note it also makes sense to make INTEL_TDX_HOST select X86_MCE but this
generates "recursive dependency detected!" error in the Kconfig.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Closes: https://lore.kernel.org/all/20231212214612.GHZXjUpBFa1IwVMTI7@fat_crate.local/T/
Fixes: 70060463cb2b ("x86/mce: Differentiate real hardware #MCs from TDX erratum ones")
Link: https://lore.kernel.org/all/20231212214612.GHZXjUpBFa1IwVMTI7@fat_crate.local/T/#m1a109c29324b2bbd0b3b1d45c218012cd3a13be6
Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 01cdb16acff6..92c03cb99b3e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1974,6 +1974,7 @@ config INTEL_TDX_HOST
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
 	depends on !KEXEC_CORE
+	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
 	  host and certain physical attacks.  This option enables necessary TDX
-- 
2.43.0

