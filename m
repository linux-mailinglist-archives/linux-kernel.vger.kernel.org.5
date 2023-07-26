Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA137634D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGZL0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGZLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:25:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE497
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690370756; x=1721906756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oSb35rSSfZzXciHeR7XfbDeXQzhFQiHGeJe1U0x1DkU=;
  b=AS7wrlAUMicyHSZ4ajkecNbZZnirlyUSt+XdAfgVXc70G61aG02/k95i
   +BVXqQC6f0dqYW71TvR4vMFIGq2LYOhmKqN7M7iW/b64ZySwAI1M7PDsv
   hhRpBhYi3IEarrlVPJOsxfbJMNlNNxa9sNzE7fwbRtXxZNTgSfXSBLBV9
   rEldtsw8NYKtCWeEZRpVgXnFeL4oCYSAdyWPWEJpgPT/IQ2hpEyoKywP1
   RpAbsTRfBjvs3DeApx4WEoLghHGIttLTzx/jiFSjye9SiBvUMa635FZRh
   wsnEQuuTw5eITIbvMiZg3zR4/JRri59sZiHJHMgZuAOYnzxLnCKi/fsYb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370663870"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="370663870"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791810917"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="791810917"
Received: from bterry-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.177.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:25:49 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v3 01/12] x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro
Date:   Wed, 26 Jul 2023 23:25:03 +1200
Message-ID: <a451f3aecf53d463246a6fa4d322791ade4a78e7.1690369495.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690369495.git.kai.huang@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the TDX_HYPERCALL asm, after the TDCALL instruction returns from the
untrusted VMM, the registers that the TDX guest shares to the VMM need
to be cleared to avoid speculative execution of VMM-provided values.

RSI is specified in the bitmap of those registers, but it is missing
when zeroing out those registers in the current TDX_HYPERCALL.

It was there when it was originally added in commit 752d13305c78
("x86/tdx: Expand __tdx_hypercall() to handle more arguments"), but was
later removed in commit 1e70c680375a ("x86/tdx: Do not corrupt
frame-pointer in __tdx_hypercall()"), which was correct because %rsi is
later restored in the "pop %rsi".  However a later commit 7a3a401874be
("x86/tdx: Drop flags from __tdx_hypercall()") removed that "pop %rsi"
but forgot to add the "xor %rsi, %rsi" back.

Fix by adding it back.

Fixes: 7a3a401874be ("x86/tdx: Drop flags from __tdx_hypercall()")
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdcall.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index b193c0a1d8db..2eca5f43734f 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -195,6 +195,7 @@ SYM_FUNC_END(__tdx_module_call)
 	xor %r10d, %r10d
 	xor %r11d, %r11d
 	xor %rdi,  %rdi
+	xor %rsi,  %rsi
 	xor %rdx,  %rdx
 
 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
-- 
2.41.0

