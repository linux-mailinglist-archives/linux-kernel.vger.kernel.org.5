Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72F78DD75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244147AbjH3Sue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244438AbjH3NL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:11:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651CFCD7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693401114; x=1724937114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HLlwTVXS9iMeZ1L4KBSbq0Q+tuxm+t8Afphf5KGLsnk=;
  b=YgNxlX6m9tMpsjLifsvvv0mjsuZKO1MR3ACAiqM21ZCrKNKZ98G0hrDd
   CISCeHaSuvnrD52xcyTQcUNU2gATBoJb12AIJST+f4a44dTkUocThNqdt
   EwukuhxcumizQpmaUcO4txSvEfVxJ+4ss3vY+ZMqvca6BOB22dTq58Cai
   AydoMN3nt6eZmyC9yVUXJP7o1CMQLTXG+DbqQxqduy9V/8DFh0fsONZvX
   pqtBNT7HcwpO+Ce6lE+t6KRihH5jb5EypcaAK4dQxyHUtANeeW1dG2FhJ
   rTIXX7Cy5CGJ1B/QrxSEtcH0Qs+xYIRyFt9RRPaE6wnDONTXXUYuAg1UX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="406638569"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="406638569"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 06:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="688904503"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="688904503"
Received: from tguenthe-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.57.167])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 06:10:31 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1F6521099E2; Wed, 30 Aug 2023 16:10:28 +0300 (+03)
Date:   Wed, 30 Aug 2023 16:10:28 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v4 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Message-ID: <20230830131028.lbtwtefap7khvt44@box.shutemov.name>
References: <cover.1692096753.git.kai.huang@intel.com>
 <0cbf25e7aee3256288045023a31f65f0cef90af4.1692096753.git.kai.huang@intel.com>
 <20230825233558.xzqukr3vbccii7f4@box>
 <1a40b4dc8d155618723671685e7ad53e3fce0aa4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a40b4dc8d155618723671685e7ad53e3fce0aa4.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 12:50:11AM +0000, Huang, Kai wrote:
> On Sat, 2023-08-26 at 02:35 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Tue, Aug 15, 2023 at 11:02:01PM +1200, Kai Huang wrote:
> > > +	/*
> > > +	 * Failure of __tdcall_hypercall() indicates a failure of the TDVMCALL
> > > +	 * mechanism itself and that something has gone horribly wrong with
> > > +	 * the TDX module.  __tdx_hypercall_failed() never returns.
> > > +	 */
> > > +	if (__tdcall_hypercall(TDG_VP_VMCALL, &margs))
> > > +		__tdx_hypercall_failed();
> > 
> > Do we even need __tdx_hypercall_failed() anymore? Just call panic()
> > directly, no?
> > 
> 
> __tdx_hypercall() is currently annotated with 'noinstr' (which is also the
> behaviour of the old code).  We need it otherwise we will get build warning like
> below:
> 
> https://lore.kernel.org/lkml/a23ce8fd289141cea3a1b4f3dace221dca847238.camel@intel.com/T/#m205b29ce3e33983ec6be733c2afffbfd5cb653ff

Okay, fair enough. We can return back to it later.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
