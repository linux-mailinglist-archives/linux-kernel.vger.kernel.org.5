Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB91E7E6A28
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjKIL7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjKIL6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:58:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2113245;
        Thu,  9 Nov 2023 03:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699531096; x=1731067096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bc2NqY0FfTLxQFLE+kpmzGaygrY6ACRFJUEE0bOLoRA=;
  b=j2e7k5bdZN/pboTez8y67goVwrDUqYpXjEkBpWTdf8wztHgRUWw24E9I
   Gt7HNzOEjy3nvJHNdNO4t6lxC64f+8clnwvrlr+0Suqkn4cCC4ZGdlClw
   DTP/nM35kBBKRk525IKzbIYuvCHQ9995EKu8lGcwFHWHzlmxCE6JGsgNO
   e9aXk7R02BW/yQc4UDhUsJYfvhdvBWmYohhPPrqExMySHc1qkA+k/QBbX
   P/64pEFYrHycwIsEe8oS/Kd69SmCqmCX8+RKvDUO7LqM2Rv7gDRjm4dRr
   EBS5kJ8qTgVd1vzxmDrMalcX8zcJs4ij4U8msVWkTbs064VhEJaOnGURR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="2936738"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="2936738"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:58:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="766976960"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="766976960"
Received: from shadphix-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.83.35])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:58:08 -0800
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, peterz@infradead.org,
        tony.luck@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, seanjc@google.com,
        pbonzini@redhat.com, rafael@kernel.org, david@redhat.com,
        dan.j.williams@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, ying.huang@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, nik.borisov@suse.com,
        bagasdotme@gmail.com, sagis@google.com, imammedo@redhat.com,
        kai.huang@intel.com
Subject: [PATCH v15 19/23] x86/virt/tdx: Improve readability of module initialization error handling
Date:   Fri, 10 Nov 2023 00:55:56 +1300
Message-ID: <845816bee8cd921e9792d762e9d70962c9e65158.1699527082.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699527082.git.kai.huang@intel.com>
References: <cover.1699527082.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With keeping TDMRs upon successful TDX module initialization, now only
put_online_mems() needs to be done even when module initialization is
successful.  On the other hand, all other four "out_*" labels before
them explicitly check the return value and only clean up when module
initialization fails.

This isn't ideal.  Make all other four "out_*" labels only reachable
when module initialization fails to improve the readability of error
handling.  Rename them from "out_*" to "err_*" to reflect the fact.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

v14 -> v15:
 - Rebase due to TDH.SYS.RD patch (minor)

v13 -> v14:
 - Fix spell typo (Rick)
 - Add Kirill/Rick's tags

v12 -> v13:
  - New patch to improve error handling. (Kirill, Nikolay)


---
 arch/x86/virt/vmx/tdx/tdx.c | 69 +++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 753e435a3040..e8cd91692ccf 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1081,22 +1081,22 @@ static int init_tdx_module(void)
 
 	ret = get_tdx_tdmr_sysinfo(&tdmr_sysinfo);
 	if (ret)
-		goto out_free_tdxmem;
+		goto err_free_tdxmem;
 
 	/* Allocate enough space for constructing TDMRs */
 	ret = alloc_tdmr_list(&tdx_tdmr_list, &tdmr_sysinfo);
 	if (ret)
-		goto out_free_tdxmem;
+		goto err_free_tdxmem;
 
 	/* Cover all TDX-usable memory regions in TDMRs */
 	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &tdmr_sysinfo);
 	if (ret)
-		goto out_free_tdmrs;
+		goto err_free_tdmrs;
 
 	/* Pass the TDMRs and the global KeyID to the TDX module */
 	ret = config_tdx_module(&tdx_tdmr_list, tdx_global_keyid);
 	if (ret)
-		goto out_free_pamts;
+		goto err_free_pamts;
 
 	/*
 	 * Hardware doesn't guarantee cache coherency across different
@@ -1111,40 +1111,16 @@ static int init_tdx_module(void)
 	/* Config the key of global KeyID on all packages */
 	ret = config_global_keyid();
 	if (ret)
-		goto out_reset_pamts;
+		goto err_reset_pamts;
 
 	/* Initialize TDMRs to complete the TDX module initialization */
 	ret = init_tdmrs(&tdx_tdmr_list);
-out_reset_pamts:
-	if (ret) {
-		/*
-		 * Part of PAMTs may already have been initialized by the
-		 * TDX module.  Flush cache before returning PAMTs back
-		 * to the kernel.
-		 */
-		wbinvd_on_all_cpus();
-		/*
-		 * According to the TDX hardware spec, if the platform
-		 * doesn't have the "partial write machine check"
-		 * erratum, any kernel read/write will never cause #MC
-		 * in kernel space, thus it's OK to not convert PAMTs
-		 * back to normal.  But do the conversion anyway here
-		 * as suggested by the TDX spec.
-		 */
-		tdmrs_reset_pamt_all(&tdx_tdmr_list);
-	}
-out_free_pamts:
 	if (ret)
-		tdmrs_free_pamt_all(&tdx_tdmr_list);
-	else
-		pr_info("%lu KBs allocated for PAMT\n",
-				tdmrs_count_pamt_kb(&tdx_tdmr_list));
-out_free_tdmrs:
-	if (ret)
-		free_tdmr_list(&tdx_tdmr_list);
-out_free_tdxmem:
-	if (ret)
-		free_tdx_memlist(&tdx_memlist);
+		goto err_reset_pamts;
+
+	pr_info("%lu KBs allocated for PAMT\n",
+			tdmrs_count_pamt_kb(&tdx_tdmr_list));
+
 out_put_tdxmem:
 	/*
 	 * @tdx_memlist is written here and read at memory hotplug time.
@@ -1152,6 +1128,31 @@ static int init_tdx_module(void)
 	 */
 	put_online_mems();
 	return ret;
+
+err_reset_pamts:
+	/*
+	 * Part of PAMTs may already have been initialized by the
+	 * TDX module.  Flush cache before returning PAMTs back
+	 * to the kernel.
+	 */
+	wbinvd_on_all_cpus();
+	/*
+	 * According to the TDX hardware spec, if the platform
+	 * doesn't have the "partial write machine check"
+	 * erratum, any kernel read/write will never cause #MC
+	 * in kernel space, thus it's OK to not convert PAMTs
+	 * back to normal.  But do the conversion anyway here
+	 * as suggested by the TDX spec.
+	 */
+	tdmrs_reset_pamt_all(&tdx_tdmr_list);
+err_free_pamts:
+	tdmrs_free_pamt_all(&tdx_tdmr_list);
+err_free_tdmrs:
+	free_tdmr_list(&tdx_tdmr_list);
+err_free_tdxmem:
+	free_tdx_memlist(&tdx_memlist);
+	/* Do things irrelevant to module initialization result */
+	goto out_put_tdxmem;
 }
 
 static int __tdx_enable(void)
-- 
2.41.0

