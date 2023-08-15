Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6A77CB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjHOLCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbjHOLCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:02:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A466B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692097342; x=1723633342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cGlGp69+Yi04l3Ge9e+rlhaP5w8TZwyOOJNeTUrTOrI=;
  b=BJl+0haTHFwPnMpjTqKEy8PG5QGg0ajMTiHrwf95kT5o0jAiZSO/0qNd
   nNyrro2t4cgbGGRZleheOorh0PAqzNojXdytW825WbFr6h0q4L3nSe1CA
   IqKfOcW8Jh7PxiVJho8TymG+Yc7Zg0kyMeuvqjAOleZ3xumebxceEYitS
   ros/7uqWCGFMIyqlpHSGVkZTcBlzhqL+Sj2o2DdT1wlmr0dhNmamsqzpO
   GahIgyIu6G9QWwaE9dAcVvZmIWdQVeAZXssCphujWDghr4mQR0Zbbb8lB
   FA89Z32EnG/c+GzFWiMSAzoP+MxTqNNFsl14she69egIyHnZVrtNa4j1/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436148242"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436148242"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763236098"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763236098"
Received: from fwafula-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.73.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:18 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v4 01/12] x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro
Date:   Tue, 15 Aug 2023 23:01:55 +1200
Message-ID: <e7d1157074a0b45d34564d5f17f3e0ffee8115e9.1692096753.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692096753.git.kai.huang@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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

