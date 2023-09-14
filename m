Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F259D79F5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjINAXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINAXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:23:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0AAE4B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694650976; x=1726186976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EKyuUzvr0nNAa0J3FNXg9JKMAQ4z8z9p0ACPk8X62P0=;
  b=noeI27PIUW1aPkCFuOv4ydy/FlbEZuWfUK039dPtDoe4m8boLkLjLJvP
   woMlqXq8vmutcsZ9uRfAtsehLwtDgKU+HSleAjTf2YN8kuonxp67q/E5B
   mHdlP5Fsq+nhfwNB/1+QfZt/T8xpU9ZWxidNlKcu0GdF47mb1HS/AVhHg
   B5D4T6/1AN+f6VjWG62UO5eHmC672dogmBAC/5fsQpIUpcPG+EjH0GczS
   Jq+f+YyMCPIBqF+b/ZX2LmlcjdDFX4MOwQO6R7X82pdySxq9ztV3MML2X
   esTK1jTi8sUD6Ju3SGRbkzNtB/ctVc+LX54/0UEMZvwvgoQbUAbQrjUTN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="409773037"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="409773037"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 17:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="809839532"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="809839532"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 17:22:55 -0700
Date:   Wed, 13 Sep 2023 17:22:55 -0700
From:   Isaku Yamahata <isaku.yamahata@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        isaku.yamahata@linux.intel.com
Subject: Re: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Message-ID: <20230914002255.GC3638268@ls.amr.corp.intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
 <0728094e1d8751355360987f17fcc2db18b43ce7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0728094e1d8751355360987f17fcc2db18b43ce7.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 11:01:28PM +0000,
"Huang, Kai" <kai.huang@intel.com> wrote:

> On Tue, 2023-08-15 at 23:01 +1200, Kai Huang wrote:
> > Hi Peter, Kirill,
> > 
> > This series unifies the assembly code for TDCALL/SEAMCALL and TDVMCALL.
> > Now all of them use one singe TDX_MODULE_CALL asm macro.  More
> > information please see cover letter of v2 (see link below).
> > 
> > Tested by booting TDX guest, initializing TDX module, and running TDX
> > guest successfully, all with this series applied.
> > 
> > 
> 
> Hi Peter,
> 
> Sorry to ping, but could you take a look whether you are OK with this series?
> 
> Basically Kirill has provided his Reviewed-by for all the patches except the
> last one (Add unused registers to 'struct tdx_module_args' to optimize VP.ENTER
> for KVM), which he didn't like.  But it is pretty much a standalone optimization
> patch we either can have or drop when applying, so I'll leave to you.
> 
> Also feel free to let me know if I can help you on anything to offload part of
> your load? :-)

Because the optimization patch was dropped in tip x86/tdx tree, TDX KVM can't
use __seamcall_saved_ret() because the argument doesn't match.  There is no
user of __seamcall_saved_ret().
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
