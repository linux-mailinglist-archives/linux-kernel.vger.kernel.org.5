Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523107E805F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjKJSKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346004AbjKJSHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:07:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A773289C;
        Fri, 10 Nov 2023 04:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699617970; x=1731153970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H4jWVByc4wLVM37wWeWXhVD/EeBwVYgk2+75za4Oepk=;
  b=Vdkefv52mc/Q/PDtw5C2ustxHKgM0Wv5nKn5C5mdGLoR6Jud5mlOmoyK
   NZJIejI7ygoKQNWQg1S9J77yaE1QCTyHy686jp8SxZTqguij6gQ5K3Deb
   l/FTFsZeoitqvoxKVX1LIE1RR68hNIrv2BhqkZnxB3NegFXAAH+d6GnqT
   WjzMaEEcNkp/hHvfsNsMlX4UaRiKOHOfcyhLHiZuMOgtU2Z951aBYRrBZ
   /C3yRMXmCwrjYOv80VBhhTD/dlaGLFifvVzAahWCpNzgcGbOuh42w5pqv
   QDCb9ef5Og3OVrlO8lPgr8NVXi/PNncHyp14zXUQua41vTSN255gx+zMs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3160825"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="3160825"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 04:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="829637766"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="829637766"
Received: from amazouz-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.43.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 04:06:04 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B3BC3103614; Fri, 10 Nov 2023 15:06:01 +0300 (+03)
Date:   Fri, 10 Nov 2023 15:06:01 +0300
From:   kirill.shutemov@linux.intel.com
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Message-ID: <20231110120601.3mbemh6djdazyzgb@box.shutemov.name>
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 07:41:33PM +0100, Jeremi Piotrowski wrote:
> It's not disregard, the way the kernel behaves in this case is correct except
> for the error in reporting CPU vendor. Users care about seeing the correct
> information in dmesg.

I think it is wrong place to advertise CoCo features. It better fits into
Intel/AMD-specific code that knows better what it is running on. Inferring
it from generic code has been proved problematic as you showed.

Maybe just remove incorrect info and that's it?

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c290c55b632b..f573a97c0524 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -40,42 +40,6 @@ bool force_dma_unencrypted(struct device *dev)
 	return false;
 }
 
-static void print_mem_encrypt_feature_info(void)
-{
-	pr_info("Memory Encryption Features active:");
-
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
-		pr_cont(" Intel TDX\n");
-		return;
-	}
-
-	pr_cont(" AMD");
-
-	/* Secure Memory Encryption */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		/*
-		 * SME is mutually exclusive with any of the SEV
-		 * features below.
-		 */
-		pr_cont(" SME\n");
-		return;
-	}
-
-	/* Secure Encrypted Virtualization */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		pr_cont(" SEV");
-
-	/* Encrypted Register State */
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		pr_cont(" SEV-ES");
-
-	/* Secure Nested Paging */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		pr_cont(" SEV-SNP");
-
-	pr_cont("\n");
-}
-
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void)
 {
@@ -85,7 +49,7 @@ void __init mem_encrypt_init(void)
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
 
-	print_mem_encrypt_feature_info();
+	pr_info("Memory Encryption is active\n");
 }
 
 void __init mem_encrypt_setup_arch(void)
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
