Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD6C7ECC30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjKOT1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjKOT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:27:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FEF1AB;
        Wed, 15 Nov 2023 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700076431; x=1731612431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I+mMbHRrdn5krrXbIHqhTFESIktjUGAwXJKl6TU3/ec=;
  b=ipjzapR9PRyq61AZichvhS4svsfE/zIjMAtdfYmZJfi6SN9GdKzipuaU
   deMjsUdqDCtoIvU21N/7vnoZOg7lJBbF/ZCVmFXXVu0fBC1OlUB/+fPuK
   Ixj6x7kaZV8S++xx87Ti3flc3OJ63ASaaUdAE0iZ4U8ZzwouVUgD2MEW/
   rzmQWcG5V0xWPMvrdWZ4+jJKGVO4G0DMLOUO6QL6VP7hU20+Kx3naWjd1
   X4gdbRW3+M56ix3DPKZ1DjuYYzY7FHmxQlMZ2wm9GU8h87Tzpsjbeaqw9
   wGqhiWCKJg1m4+bgDHfQEY4GtBWYAgAykKIVrxz748ThLGP3T1PI/vo4l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="394858927"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="394858927"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="882482919"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="882482919"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:26:50 -0800
Date:   Wed, 15 Nov 2023 11:26:50 -0800
From:   Isaku Yamahata <isaku.yamahata@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "isaku.yamahata@linux.intel.com" <isaku.yamahata@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Shahar, Sagi" <sagis@google.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v15 05/23] x86/virt/tdx: Handle SEAMCALL no entropy error
 in common code
Message-ID: <20231115192650.GB1109547@ls.amr.corp.intel.com>
References: <cover.1699527082.git.kai.huang@intel.com>
 <9565b2ccc347752607039e036fd8d19d78401b53.1699527082.git.kai.huang@intel.com>
 <20231114192447.GA1109547@ls.amr.corp.intel.com>
 <63e9754ec059190cd1734650b8968952cbe00ee9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63e9754ec059190cd1734650b8968952cbe00ee9.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:41:46AM +0000,
"Huang, Kai" <kai.huang@intel.com> wrote:

> 
> > > +#include <asm/archrandom.h>
> > > +
> > > +typedef u64 (*sc_func_t)(u64 fn, struct tdx_module_args *args);
> > > +
> > > +static inline u64 sc_retry(sc_func_t func, u64 fn,
> > > +			   struct tdx_module_args *args)
> > > +{
> > > +	int retry = RDRAND_RETRY_LOOPS;
> > > +	u64 ret;
> > > +
> > > +	do {
> > > +		ret = func(fn, args);
> > > +	} while (ret == TDX_RND_NO_ENTROPY && --retry);
> > 
> > This loop assumes that args isn't touched when TDX_RND_NO_ENTRYPOY is returned.
> > It's not true.  TDH.SYS.INIT() and TDH.SYS.LP.INIT() clear RCX, RDX, etc on
> > error including TDX_RND_NO_ENTRY.  Because TDH.SYS.INIT() takes RCX as input,
> > this wrapper doesn't work.  TDH.SYS.LP.INIT() doesn't use RCX, RDX ... as
> > input. So it doesn't matter.
> > 
> > Other SEAMCALLs doesn't touch registers on the no entropy error.
> > TDH.EXPORTS.STATE.IMMUTABLE(), TDH.IMPORTS.STATE.IMMUTABLE(), TDH.MNG.ADDCX(),
> > and TDX.MNG.CREATE().  TDH.SYS.INIT() is an exception.
> 
> If I am reading the spec (TDX module 1.5 ABI) correctly the TDH.SYS.INIT doesn't
> return TDX_RND_NO_ENTROPY.

The next updated spec would fix it.
                                  

> TDH.SYS.LP.INIT indeed can return NO_ENTROPY but as
> you said it doesn't take any register as input.  So technically the code works
> fine.  (Even the TDH.SYS.INIT can return NO_ENTROPY the code still works fine
> because the RCX must be 0 for TDH.SYS.INIT.)

Ah yes, I agree with you. So it doesn't matter.


> Also, I can hardly think out of any reason why TDX module needs to clobber input
> registers in case of NO_ENTROPY for *ANY* SEAMCALL.  But despite that, I am not
> opposing the idea that it *MIGHT* be better to "not assume" NO_ENTROPY will
> never clobber registers either, e.g., for the sake of future extendibility.  In
> this case, the below diff should address:

Now we agreed that TDH.SYS.INIT() and TDH.SYS.LP.INIT() doesn't matter,
I'm fine with this patch. (TDX KVM handles other SEAMCALLS itself.)

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
