Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855697BF885
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjJJKYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjJJKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:24:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2EEC1;
        Tue, 10 Oct 2023 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696933490; x=1728469490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ToiBWz7vYPbjtT1A6Pw5OFHNHbyj94PnFPsrgizUBr0=;
  b=IuEk7NOTKFYEC2WTk3dFsT30TSl9zVW8afVbVMiobe17n2ws1tf7Wsq8
   ZcmAV+JBAnOrb/RiYJgwxU9CisvIStaXjaAqhhwRyrZG3yAeRkPq9t6B3
   Nlrkqk4DfjAxjwqX4gHzVV5sk8xlVFxAbyzSp9Wj9u9MWlXFIWCIaX6ba
   Hx/U0uODEDVIYAuOG7UWUm2cZfVUUPixlSOdbAucYvSLYzSdqP6JW5sl2
   T1bTGRzqpQqMx2mqHy4U6C+foNS1dJnV4iekowTfx9bTREztmvv/bMSiQ
   nAB9NAUBrssc2KPw1pXWRsCSj6GU7OPnecQpZRDO76+ulp9ST6DAMBRz+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364654363"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="364654363"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="927087670"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="927087670"
Received: from albertmo-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.38])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:24:37 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CA51710989E; Tue, 10 Oct 2023 13:24:34 +0300 (+03)
Date:   Tue, 10 Oct 2023 13:24:34 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Disable KASAN on text_poke_early() in
 apply_alternatives()
Message-ID: <20231010102434.ncn3mxk7cesec6s5@box.shutemov.name>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
 <20231010084041.ut5sshyrofh27yyx@box.shutemov.name>
 <20231010091235.GFZSUVgzTetLj2K+s8@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010091235.GFZSUVgzTetLj2K+s8@fat_crate.local>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:12:35AM +0200, Borislav Petkov wrote:
> On Tue, Oct 10, 2023 at 11:40:41AM +0300, Kirill A. Shutemov wrote:
> > __VIRTUAL_MASK_SHIFT used in many places. I don't think it is good idea to
> > give up on patching completely.
> 
> Have you even looked at boot_cpu_has()'s asm?

Obviously not :/

Okay, as alternative, the patch below also make the issue go away.

But I am not sure it is fundamentaly better. boot_cpu_has() generates call
to __asan_load8_noabort(). I think it only works because all KASAN code
has ASAN instrumentation disabled.

diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index de75306b932e..bfe97013abb0 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -12,8 +12,15 @@
  * for kernel really starts from compiler's shadow offset +
  * 'kernel address space start' >> KASAN_SHADOW_SCALE_SHIFT
  */
+
+#ifdef USE_EARLY_PGTABLE_L5
+#define __KASAN_VIRT_SHIFT	(__pgtable_l5_enabled ? 56 : 47)
+#else
+#define __KASAN_VIRT_SHIFT	(boot_cpu_has(X86_FEATURE_LA57) ? 56 : 47)
+#endif
+
 #define KASAN_SHADOW_START      (KASAN_SHADOW_OFFSET + \
-					((-1UL << __VIRTUAL_MASK_SHIFT) >> \
+					((-1UL << __KASAN_VIRT_SHIFT) >> \
 						KASAN_SHADOW_SCALE_SHIFT))
 /*
  * 47 bits for kernel address -> (47 - KASAN_SHADOW_SCALE_SHIFT) bits for shadow
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
