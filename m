Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B435765450
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjG0Msf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjG0Msd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:48:33 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E903B1737
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690462112; x=1721998112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8FxoD7XbQTi048PFDj7HD73MEU7uEbz7jFpoEHMrqAk=;
  b=f5O7v/QMwVyD+jfXC3kV8bMIt6vG7PkfIDsRfLJdNU/0y+ewKCHxxHon
   lrpwdpTg7KyKMvLZ2Xafer+Sl8P5Ifdm3BbPF5vUYXUpKz1d2Ysa63T/A
   wCXxonRenQ8k1lPjaOIl/AtcDJMIfJ1DohAVSobH0ZdCprAVRurMn+6Cq
   IKV8N2oLDsUPsGwq/U+Kbt5he+SvjYUNUEaC0CNUH/KB4a9xPp45mMt1O
   uUS+EzevMEl+KJanBxZirQtiNi9OED8oJVbRfS6qH/6l88Sc3kOU1NNLB
   0XVxPrWC9x753TwxoSCDztHpZ3d5gTSbiokQfo2Je4j5n7CaZHwi1TyaG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371906204"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="371906204"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 05:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="677145430"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="677145430"
Received: from lzhiguno-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.222])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 05:48:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 41A19109503; Thu, 27 Jul 2023 15:48:26 +0300 (+03)
Date:   Thu, 27 Jul 2023 15:48:26 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 01/12] x86/tdx: Zero out the missing RSI in
 TDX_HYPERCALL macro
Message-ID: <20230727124826.obblw2vtkavr4f2o@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <a451f3aecf53d463246a6fa4d322791ade4a78e7.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a451f3aecf53d463246a6fa4d322791ade4a78e7.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:03PM +1200, Kai Huang wrote:
> In the TDX_HYPERCALL asm, after the TDCALL instruction returns from the
> untrusted VMM, the registers that the TDX guest shares to the VMM need
> to be cleared to avoid speculative execution of VMM-provided values.
> 
> RSI is specified in the bitmap of those registers, but it is missing
> when zeroing out those registers in the current TDX_HYPERCALL.
> 
> It was there when it was originally added in commit 752d13305c78
> ("x86/tdx: Expand __tdx_hypercall() to handle more arguments"), but was
> later removed in commit 1e70c680375a ("x86/tdx: Do not corrupt
> frame-pointer in __tdx_hypercall()"), which was correct because %rsi is
> later restored in the "pop %rsi".  However a later commit 7a3a401874be
> ("x86/tdx: Drop flags from __tdx_hypercall()") removed that "pop %rsi"
> but forgot to add the "xor %rsi, %rsi" back.
> 
> Fix by adding it back.
> 
> Fixes: 7a3a401874be ("x86/tdx: Drop flags from __tdx_hypercall()")
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
