Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49A27727B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHGO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjHGO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:27:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03910D4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691418474; x=1722954474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Zlmippzoi9DzqmMZMkxhBrZSu0A1LY1gGDgN1+bH2U=;
  b=XDxP2y9JzQ6NenxmIZ9EdyDGyR+JXoafyq+OzvmCWsRfiiScOAWzrpsn
   FnKoEkaQvza/AwLaEB6TN9KhXFglosGQ7VVAMs9ajXKNFLwLYVU4VX1AO
   usisNuyXqsj4yygJZ0bmKw7CnPCBMGymzZ3+qNvxutrF6hBtlrRp81pDn
   ilqRCPlGSF3lobby8ySYiGXSospLu8UJbZ6oD81rCUkE7Z8DCHs5DV9di
   v1i2lTezL5QVV1NwNfJrBtbh5WEBF/KzMvIv2VLP8MB8mLnQFYq9WgNGa
   xGsBuZjb87JCSlxisIYvmpUxhCOdGbJexHGOiTArYpTd+jqcVf6o0doYR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="456938857"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="456938857"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796341150"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="796341150"
Received: from aamakine-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.48.92])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:27:50 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EC01D10A122; Mon,  7 Aug 2023 17:27:47 +0300 (+03)
Date:   Mon, 7 Aug 2023 17:27:47 +0300
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
Subject: Re: [PATCH v3 11/12] x86/virt/tdx: Allow SEAMCALL to handle #UD and
 #GP
Message-ID: <20230807142747.7x6my6wp2nttto5y@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <659b10910c206cb4a8de314fcf7cd58814279aa6.1690369495.git.kai.huang@intel.com>
 <20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name>
 <b15b45ff5dc2fcfa08dfb3171c269d9ab0349088.camel@intel.com>
 <20230807095307.l7khgiu5y55pqq22@box.shutemov.name>
 <c4b1ab39b8e6e03e40ca390a41c96d096325428f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b1ab39b8e6e03e40ca390a41c96d096325428f.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 12:41:13PM +0000, Huang, Kai wrote:
> On Mon, 2023-08-07 at 12:53 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Mon, Aug 07, 2023 at 02:14:37AM +0000, Huang, Kai wrote:
> > > On Sun, 2023-08-06 at 14:41 +0300, kirill.shutemov@linux.intel.com wrote:
> > > > On Wed, Jul 26, 2023 at 11:25:13PM +1200, Kai Huang wrote:
> > > > > @@ -20,6 +21,9 @@
> > > > >  #define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
> > > > >  #define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
> > > > >  
> > > > > +#define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
> > > > > +#define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
> > > > 
> > > > Is there any explantion how these error codes got chosen? Looks very
> > > > arbitrary and may collide with other error codes in the future.
> > > > 
> > > 
> > > Any error code has TDX_SW_ERROR is reserved to software use so the TDX module
> > > can never return any error code which conflicts with those software ones.
> > > 
> > > For why to choose these two, I believe XOR the TRAP number to TDX_SW_ERROR is
> > > the simplest way to achieve: 1) costing minimal assembly code; 2)
> > > opportunistically handling #GP too, allowing caller to distinguish the two
> > > errors.
> > 
> > My problem is that it is going to conflict with errno-based errors if we
> > going to take this path in the future. Like these errors are the same as
> > (TDX_SW_ERROR | EACCES) and (TDX_SW_ERROR | ENXIO) respectively.
> > 
> 
> Is there any use case that we need those definitions?
> 
> Even we have such requirement in the future, we still have many bits available
> after taking out the bits of TDX_SW_ERROR thus I assume we can do some bit shift
> when this really happens?? 

Okay, fair enough.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
