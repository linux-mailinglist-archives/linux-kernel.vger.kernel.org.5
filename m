Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6417D5ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjJXXs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344663AbjJXXsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:48:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDBA2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698191332; x=1729727332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qfQ0PVM3UW/2NAqWFmhrhM2gR9XLfLx4/JHO0E0jUkg=;
  b=OZWfy3/DZrHUc5EZlBZ/SMFVlmRWDt5RSu1klA3Pwjb7F0qBXaz1SCdS
   R3JyHTeemVCz3vtDWewZyevoyF4vXm0gBjSSFX6kwxGQVH9Tabz9L4QcR
   xIZY+NitxsIRwPL88AiXoy9gvM40dEc82AvYFcWQBs3/hEmzXQZ6wagRq
   ZTwZNDzhsLhVIyXtbekZFxeU7HxlAp8GTQ+9+nT33G29obAFkpZKEdrzr
   SRShObxXz9CUgAo21kpcoVRFScY44JGNRg1QMjjdrL00e0uftD+hDpxMp
   Ik+w6RCtpqz7C93f3eGL7i9/GixvJs89t+Z81dxJ0oTFfnz0bU/xOaAj2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="377569338"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="377569338"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 16:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762271652"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="762271652"
Received: from lioneldi-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.7.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 16:48:50 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Date:   Tue, 24 Oct 2023 16:48:29 -0700
Message-Id: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TDX it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to take
care to handle these errors to avoid returning decrypted (shared) memory to
the page allocator, which could lead to functional or security issues.

Such errors may herald future system instability, but are temporarily
survivable with proper handling in the caller. The kernel traditionally
makes every effort to keep running, but it is expected that some coco
guests may prefer to play it safe security-wise, and panic in this case.
To accommodate both cases, warn when the arch breakouts for converting
memory at the VMM layer return an error to CPA. Security focused users
can rely on panic_on_warn to defend against bugs in the callers.

Since the arch breakouts host the logic for handling coco implementation
specific errors, an error returned from them means that the set_memory()
call is out of options for handling the error internally. Make this the
condition to warn about.

It is possible that very rarely these functions could fail due to guest
memory pressure (in the case of failing to allocate a huge page when
splitting a page table). Don't warn in this case because it is a lot less
likely to indicate an attack by the host and it is not clear which
set_memory() calls should get the same treatment. That corner should be
addressed by future work that considers the more general problem and not
just papers over a single set_memory() variant.

Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
This is a followup to the "Handle set_memory_XXcrypted() errors"
series[0].

Previously[1] I attempted to create a useful helper to both simplify the
callers and provide an official example of how to handle conversion
errors. Dave pointed out that there wasn't actually any code savings in
the callers using it. It also required a whole additional patch to make
set_memory_XXcrypted() more robust.

I tried to create some more sensible helper, but in the end gave up. My
current plan is to just add a warning for VMM failures around this. And
then shortly after, pursue open coded fixes for the callers that are
problems for TDX. There are some SEV and SME specifics callers, that I am
not sure on. But I'm under the impression that as long as that side
terminates the guest on error, they should be harmless.

[0] https://lore.kernel.org/lkml/20231017202505.340906-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/20231017202505.340906-2-rick.p.edgecombe@intel.com/
---
 arch/x86/mm/pat/set_memory.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e..dade281f449b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2153,7 +2153,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
 	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
-		return -EIO;
+		goto vmm_fail;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2167,12 +2167,20 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	cpa_flush(&cpa, 0);
 
 	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!ret) {
-		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
-			ret = -EIO;
-	}
+	if (ret)
+		goto out;
 
+	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+		goto vmm_fail;
+
+out:
 	return ret;
+
+vmm_fail:
+	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s.\n",
+		  (void *)addr, numpages, enc ? "private" : "shared");
+
+	return -EIO;
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
-- 
2.34.1

