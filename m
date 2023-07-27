Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD15765477
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjG0NCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjG0NCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:02:17 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365921FFC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690462937; x=1721998937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F6awQahw+TUrdL9bQV+qksR//IXVBzUbgGUgF9l3SMs=;
  b=cCRh/8YV2TRZz6U+03yw2+w1Z76lC5EBcqGTa6shjivwQWpA9rWviqKF
   /q8nhyDb2YTvmXZemv4TBJc/yIzW4Fn8TrT3SagxYnWNM+dMSCFqKfvDb
   TBG445SmIYiX7wsIcVs1uchm85B+kAb2c3KUMF8GgE0yT+WsJ96QqIZE4
   DeC+yXO8Lv+cq71X83f0fziCLI89USfYaPJ4ehxUdfY5l9ApjlKgK/SBF
   rJbjIn5NTAj+ktxpuG2qxBqeBtR2r4W0I1wlpQSubdW2vfunZ1W5vyMqI
   MMMwIqjixMXczLXJiNazABaGtP9+wWptI/UjMb4nOVyRZZDfAnQs/0OyH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367179967"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367179967"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="756621709"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="756621709"
Received: from lzhiguno-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.222])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:02:10 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C884D109503; Thu, 27 Jul 2023 16:02:07 +0300 (+03)
Date:   Thu, 27 Jul 2023 16:02:07 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 04/12] x86/tdx: Rename __tdx_module_call() to
 __tdcall()
Message-ID: <20230727130207.4uzswwgywhdho5i7@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <ba2a29b02a18c9a366fe2364c166d11f401de329.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba2a29b02a18c9a366fe2364c166d11f401de329.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:06PM +1200, Kai Huang wrote:
> __tdx_module_call() is only used by the TDX guest to issue TDCALL to the
> TDX module.  Rename it to __tdcall() to match its behaviour, e.g., it
> cannot be used to make host-side SEAMCALL.
> 
> Also rename tdx_module_call() which is a wrapper of __tdx_module_call()
> to tdcall().
> 
> No functional change intended.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Fair enough:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
