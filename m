Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3523A75AE58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGTM26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGTM2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:28:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A500C2122
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856133; x=1721392133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oSb35rSSfZzXciHeR7XfbDeXQzhFQiHGeJe1U0x1DkU=;
  b=nDH06bjU2vOM/DmIZqYaMBHIa9TeFrDPB8JhVomt8+lsebsu9Em2TG10
   HxH+UcioQVCCdKY7JEfDq7uzHTzVgkjuGRRnoA8ME8V7YuwtNjWTV6hbz
   p/ogk7oLIdWzn2GCXOo+5TU4YxFOaFMyv1T+QTehBcq+4a+1DoabaPY1V
   DeLw3Se9vpgZozgpNxBI/V2TsczViEQRR42F/2ADnr3xFGCRs+FgmmO3/
   i3qnmlp2XKXp8G2PC6+Qz96b60/+/rvrmKpRlWl7XkmB+MPVhvIqjnsl3
   2h6xW03T1kFQr0gPo5HIUZ9/rV68sPhk60FonwdnF5CxC2cDy0/K4n6i5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356677932"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="356677932"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898255859"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898255859"
Received: from moorer9x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.157.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:28:49 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v2 01/11] x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro
Date:   Fri, 21 Jul 2023 00:28:04 +1200
Message-ID: <81a99ecf3ea355d2b4e413b3d10c47e595373f28.1689855280.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689855280.git.kai.huang@intel.com>
References: <cover.1689855280.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

