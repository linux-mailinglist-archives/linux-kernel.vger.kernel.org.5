Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77407CEB29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjJRW1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJRW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:27:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD02114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697668031; x=1729204031;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=75QujgEWINW/qGGyCr9s22g4nyJiNVG3a7cStBj1G6Y=;
  b=Enh+iBuh+LHMVKC7G0ph17YNABdMBiiB/qtBgmQZrI9DJydxHAlwCQdc
   otuWa/SGhER4rBjPbFOEHQAiNXQLz4vbYjQvCjAUQuq1Homc3riqk9xDv
   fzoQjkrNvedR1GeHwYYH075qhIOmFUZUFmOP2SbrYdBenEprtD6D1WtzX
   tutyKiVG8RHkLE/+lty3nMRFAqdQEwCJQwLOXocsT/cb3b5Zcetn58yta
   fS7YkeV57tK1eCwEmy9eAgBR/Wk1pfPpc4FNusVKmMAx90VQrDxgOVfiG
   3xSqQz+QFpYXhuQ4PKOG+Hpcxi0wbfMPYVgDz3mE3XUw12GywbZKD9a3Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452598562"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452598562"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 15:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="750272751"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="750272751"
Received: from minhjohn-mobl.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.212.43.53])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 15:26:48 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     Adam Dunlap <acdunlap@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Felix Held <felix-coreboot@felixheld.de>
Subject: Reserved bits and commit x86/sev-es: Set x86_virt_bits to the
 correct value straight away, instead of a two-phase approach
Date:   Wed, 18 Oct 2023 15:26:47 -0700
Message-ID: <87r0lry3bs.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara,
        CA 95052. USA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Hi,

On both AMD and Intel platform, when memory encryption is enabled (TME
on Intel, SME or SVE on AMD), the number of physical address bits
should be lowered. Both AMD code (arch/x86/kernel/cpu/amd.c) and Intel
code (arch/x86/kernel/cpu/intel.c) support this.

I recently noticed though that Intel code is not lowering the number
of physical address bits as part of the early cpu initialization
(c_early_init) and this is leading to MTRRs sanity check failure in
generic_get_mtrr() with the following logs.

mtrr: your BIOS has configured an incorrect mask, fixing it.
mtrr: your BIOS has configured an incorrect mask, fixing it.
[...]

I have been working on fixing this following a similar approach to
what AMD code does: lower the number of physical address bits at early
initialization.
- AMD: early_init_amd() -> detect_tme()  -> c->x86_phys_bits -= [...]
- Intel: early_init_intel() -> early_detect_mem_encrypt() -> c->x86_phys_bits -= [...]

I posted the patch on the LKML (cf. <https://lore.kernel.org/lkml/65d26d679843e26fd5e6252a08391f87243a49c9.camel@intel.com/T/>)

It works just fine on v6.6-rc6. However, this morning Kirill brought
up commit fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct
value straight away, instead of a two-phase approach") on the tip
branch to my attention and I believe it should break the AMD early
flow and is breaking the patch I submitted on my local tests.

This commit moves the get_cpu_address_sizes() call after
the this_cpu->c_early_init() call.

@@ -1601,7 +1607,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
		 cpu_detect(c);
		 get_cpu_vendor(c);
		 get_cpu_cap(c);
- get_cpu_address_sizes(c);
  setup_force_cpu_cap(X86_FEATURE_CPUID);
  cpu_parse_early_param();

@@ -1617,6 +1622,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
		 setup_clear_cpu_cap(X86_FEATURE_CPUID);
	 }

+ get_cpu_address_sizes(c);
+ setup_force_cpu_cap(X86_FEATURE_ALWAYS);

  cpu_set_bug_bits(c);

In the light of commit fbf6449f84bf I am wondering what is the right
approach to fix the regression for AMD and then fix the MTRR check for
Intel. Should we introduce a new cpu_dev callback to read the number
of reserved bits and take it into account in get_cpu_address_sizes() ?

Regards,

-- 
*Jeremy*
/One Emacs to rule them all/

--=-=-=--
