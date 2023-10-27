Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E797DA29E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346595AbjJ0VsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjJ0VsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:48:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62951B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698443280; x=1729979280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UoPN6wqg8vsDig2jNtuHHAlQ6REgxZFigbKwjOSy/v0=;
  b=bKoXb67b1KMV2Zx29rmNQxlRqkZCLKVKm5n2yW92gVM/H8PUWBvJW7QK
   c3nFp+q+aCoz2fJghxVhgX5mmMYz8UiAR0WpoXSRCEYeqg3Js12uXS9Bb
   wzs53OJY9qY/BOnp+oyOXfORFiDsUsWosEc6+alchGqGd6I8ObbU4sGRI
   WY5Grksth0r/FwM6+m9kfGzvse77i6N+1eVyGKpfO3stb2ryKz1rYEUvP
   ro19dFxnodRgmqbJia5eXSaBgQ6FmcmSffRFDV8mC91gOusavvb7/U3xv
   nTkHW+wT81BEqz4YNqZU7piIPUd66UzVBt4++eekoO01gmi8fxE1CHP5+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="650516"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="650516"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 14:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="753242181"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="753242181"
Received: from arouf-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.202.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 14:47:58 -0700
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
Subject: [PATCH v2] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Date:   Fri, 27 Oct 2023 14:47:44 -0700
Message-Id: <20231027214744.1742056-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
In terms of security, the problematic case is guest PTEs mapping the
shared alias GFNs, since the VMM has control of the shared mapping in the
EPT/NPT.

Such conversion errors may herald future system instability, but are
temporarily survivable with proper handling in the caller. The kernel
traditionally makes every effort to keep running, but it is expected that
some coco guests may prefer to play it safe security-wise, and panic in
this case. To accommodate both cases, warn when the arch breakouts for
converting memory at the VMM layer return an error to CPA. Security focused
users can rely on panic_on_warn to defend against bugs in the callers. Some
VMMs are not known to behave in the troublesome way, so users that would
like to terminate on any unusual behavior by the VMM around this will be
covered as well.

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

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
For v2:
 - Update commit log to call out importance of PTEs being shared in
   guest for there to be a problem, and that some users may want to
   terminate the guest on any unsual behavior. (Michael Kelley)
 - Remove out label (Thomas Lendacky, Sathyanarayanan Kuppuswamy)

v1 is here:
https://lore.kernel.org/lkml/20231024234829.1443125-1-rick.p.edgecombe@intel.com/
---
 arch/x86/mm/pat/set_memory.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e..34f2c0c88a6b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2153,7 +2153,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
 	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
-		return -EIO;
+		goto vmm_fail;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2167,12 +2167,19 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	cpa_flush(&cpa, 0);
 
 	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!ret) {
-		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
-			ret = -EIO;
-	}
+	if (ret)
+		return ret;
 
-	return ret;
+	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+		goto vmm_fail;
+
+	return 0;
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

