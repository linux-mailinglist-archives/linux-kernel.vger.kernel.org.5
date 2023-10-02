Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF607B5CF7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjJBWA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjJBWA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:00:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0865CB0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696284053; x=1727820053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2+S0sBELZz8cu4/nPPlTew2jxCEXoyQGzddLHftHbA=;
  b=VSTu3bFtvThwQEMEZbdEcepUrsKt41Yi91nQxrXKQ7Hwns5aVUBk+yam
   lQdEGMf5vmoZ/AQ3ySviPlKLVHyYWF0WcaIBEsDIImyliUrDwMvzvSBjj
   tzau6g/jGdovQFAwCWfDMQYRA8GtvkGFpMLmdxrOGHycW+AuCjTK2wNmH
   NHHmyMsy2SxpRbhrqHC32Sqa64KuhdjTmIqkOa697o1AEVzZElsFgP+xU
   6B54zgtoRm2PVLYWEyi150vnOdefkQUxgh/mMfiWlZ0BDF/93U1XnOkfG
   Gh3A1amFmfOIbEYqpT8ri6jn66X9P6v9flHmefiVo5+nQP94ks9aGR1KM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4312859"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="4312859"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 15:00:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="821011423"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="821011423"
Received: from viggo.jf.intel.com (HELO ray2.intel.com) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2023 15:00:50 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, nathan@kernel.org
Cc:     x86@kernel.org, acdunlap@google.com, ashok.raj@intel.com,
        bp@alien8.de, dave.hansen@linux.intel.com, david@redhat.com,
        dionnaglaze@google.com, hpa@zytor.com, jacobhxu@google.com,
        jgross@suse.com, jroedel@suse.de, khalid.elmously@canonical.com,
        kim.phillips@amd.com, kirill.shutemov@linux.intel.com,
        llvm@lists.linux.dev, luto@kernel.org, mingo@redhat.com,
        nikunj@amd.com, peterz@infradead.org, pgonda@google.com,
        rientjes@google.com, rppt@kernel.org, seanjc@google.com,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] x86/boot: Move x86_cache_alignment initialization to correct spot
Date:   Mon,  2 Oct 2023 15:00:45 -0700
Message-Id: <20231002220045.1014760-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002200426.GA4127272@dev-arch.thelio-3990X>
References: <20231002200426.GA4127272@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c->x86_cache_alignment is initialized from c->x86_clflush_size.
However, commit fbf6449f84bf moved c->x86_clflush_size initialization
to later in boot without moving the c->x86_cache_alignment assignment.

This presumably left c->x86_cache_alignment set to zero for longer
than it should be.

The result was an oops on 32-bit kernels while accessing a pointer
at 0x20.  The 0x20 came from accessing a structure member at offset
0x10 (buffer->cpumask) from a ZERO_SIZE_PTR=0x10.  kmalloc() can
evidently return ZERO_SIZE_PTR when it's given 0 as its alignment
requirement.

Move the c->x86_cache_alignment initialization to be after
c->x86_clflush_size has an actual value.

Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach")
Cc: Adam Dunlap <acdunlap@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jacob Xu <jacobhxu@google.com>
Link: https://lore.kernel.org/all/20231002200426.GA4127272@dev-arch.thelio-3990X/
---
 arch/x86/kernel/cpu/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8d7063e4f63c9..9c51ad5bbf319 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1141,6 +1141,7 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 		}
 	}
 	c->x86_cache_bits = c->x86_phys_bits;
+	c->x86_cache_alignment = c->x86_clflush_size;
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
@@ -1594,8 +1595,6 @@ static void __init cpu_parse_early_param(void)
  */
 static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 {
-	c->x86_cache_alignment = c->x86_clflush_size;
-
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 	c->extended_cpuid_level = 0;
 
-- 
2.34.1

