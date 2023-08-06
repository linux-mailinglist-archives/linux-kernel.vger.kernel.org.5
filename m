Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCFC771484
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjHFLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFLZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:25:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25565124
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691321157; x=1722857157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=68miEvSVasvEY+tKlNO9fz6HRWTvE3VikButgMb02Zw=;
  b=ToLnY2vAKb/OwvRlDTCGbZMtKH+uHhDVjPlTAR7r+/4tH2xBDQgkYF0R
   WXhRS0nyLV0V+rf9/JRfBk7+Y/UyfnBMpBDj9bNKh1w99+6vcvYo21MDz
   2kc7SjxGgu3IrxERU5iTheMsHUC3kDxwvJrTCWSL4zNeoomP9IlU+HBU7
   50oTEP2IXrtEb81GCkd9w/hh+R/RB/HkO/h+g2l35vkiU2efiy6toYv5p
   wQN0GpL763Vx78qzlPZU3tE00HjEORk/h6UCmnlWrdcLpgiQOC2G57r4T
   qaZgaZoQQvjk0xK5Zpc+Afx1Vq8ctNvLtFnoAIHyQKARa+S0xt2e85WcB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="369281208"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="369281208"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="854331429"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="854331429"
Received: from mvalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.63.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:25:52 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3550410A117; Sun,  6 Aug 2023 14:25:50 +0300 (+03)
Date:   Sun, 6 Aug 2023 14:25:50 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 08/12] x86/tdx: Reimplement __tdx_hypercall() using
 TDX_MODULE_CALL asm
Message-ID: <20230806112550.fnji2jjcpwjzucm4@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <9e5fe4d530587e9ff52f041df1abe16f039ce8b6.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e5fe4d530587e9ff52f041df1abe16f039ce8b6.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:10PM +1200, Kai Huang wrote:
> Now the TDX_HYPERCALL asm is basically identical to the TDX_MODULE_CALL
> with both '\saved' and '\ret' enabled, with two minor things though:
> 
> 1) The way to restore the structure pointer is different
> 
> The TDX_HYPERCALL uses RCX as spare to restore the structure pointer,
> but the TDX_MODULE_CALL assumes no spare register can be used.  In other
> words, TDX_MODULE_CALL already covers what TDX_HYPERCALL does.
> 
> 2) TDX_MODULE_CALL only clears shared registers for TDH.VP.ENTER
> 
> For this just need to make that code available for the non-host case.
> 
> Thus, remove the TDX_HYPERCALL and reimplement the __tdx_hypercall()
> using the TDX_MODULE_CALL.
> 
> Extend the TDX_MODULE_CALL to cover "clear shared registers" for
> TDG.VP.VMCALL.  Introduce a new __tdcall_saved_ret() to replace the
> temporary __tdcall_hypercall().
> 
> The __tdcall_saved_ret() can also be used for those new TDCALLs which
> require more input/output registers than the basic TDCALLs do.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
