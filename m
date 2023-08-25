Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF273789254
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjHYX2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjHYX2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:28:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289C2210D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693006113; x=1724542113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=in1Btn1PedfK1mlpkECoYu0edNlcFiot2ISLi0R/Bik=;
  b=Nfdg+buQeYelZ6MJklvjiFYHopzsM8UL71dhOUPCSGV7rZynj1REIboL
   kY8Hu8yzeNGYGw77G6kXOCKDJVxyRQJHc1ws6qAGX3R1fV5aFfX+AQrcQ
   CDkDvpx5g5pVzTPtVZHCADOU99FT0UDk1zNmu6AYmgahkSglSVM02IYtc
   6OXdQEDXjtMSuDfjHQ0pL9fXO4YNDT6igqhRiKhlnvT6rAccY5Zf3vjS/
   OXUsWriHQ14/9zMltcWMB8nk1LGcbeOAgNcrAnWy/PJg43ha7xLA4ej/u
   Yi85wCQDjOh/So4WJyuyqVbz2kcMsnRLHHBeO6TP3FrWiPqr6hA/liIkX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="438767510"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="438767510"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="807688839"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="807688839"
Received: from naikshri-mobl7.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.41.113])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:28:24 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0BFDE109FED; Sat, 26 Aug 2023 02:28:22 +0300 (+03)
Date:   Sat, 26 Aug 2023 02:28:22 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v4 05/12] x86/tdx: Pass TDCALL/SEAMCALL input/output
 registers via a structure
Message-ID: <20230825232822.6vt6rexyts6ibfx3@box>
References: <cover.1692096753.git.kai.huang@intel.com>
 <483616c1762d85eb3a3c3035a7de061cfacf2f14.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <483616c1762d85eb3a3c3035a7de061cfacf2f14.1692096753.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:01:59PM +1200, Kai Huang wrote:
> Currently, the TDX_MODULE_CALL asm macro, which handles both TDCALL and
> SEAMCALL, takes one parameter for each input register and an optional
> 'struct tdx_module_output' (a collection of output registers) as output.
> This is different from the TDX_HYPERCALL macro which uses a single
> 'struct tdx_hypercall_args' to carry all input/output registers.
> 
> The newer TDX versions introduce more TDCALLs/SEAMCALLs which use more
> input/output registers.  Also, the TDH.VP.ENTER (which isn't covered
> by the current TDX_MODULE_CALL macro) basically can use all registers
> that the TDX_HYPERCALL does.  The current TDX_MODULE_CALL macro isn't
> extendible to cover those cases.
> 
> Similar to the TDX_HYPERCALL macro, simplify the TDX_MODULE_CALL macro
> to use a single structure 'struct tdx_module_args' to carry all the
> input/output registers.  Currently, R10/R11 are only used as output
> register but not as input by any TDCALL/SEAMCALL.  Change to also use
> R10/R11 as input register to make input/output registers symmetric.
> 
> Currently, the TDX_MODULE_CALL macro depends on the caller to pass a
> non-NULL 'struct tdx_module_output' to get additional output registers.
> Similar to the TDX_HYPERCALL macro, change the TDX_MODULE_CALL macro to
> take a new 'ret' macro argument to indicate whether to save the output
> registers to the 'struct tdx_module_args'.  Also introduce a new
> __tdcall_ret() for that purpose, similar to the __tdx_hypercall_ret().
> 
> Note the tdcall(), which is a wrapper of __tdcall(), is called by three
> callers: tdx_parse_tdinfo(), tdx_get_ve_info() and tdx_early_init().
> The former two need the additional output but the last one doesn't.  For
> simplicity, make tdcall() always call __tdcall_ret() to avoid another
> "_ret()" wrapper.  The last caller tdx_early_init() isn't performance
> critical anyway.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
