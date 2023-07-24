Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBADE76030D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGXXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXXTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:19:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F410B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690240774; x=1721776774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lPX5G4Hwb8d5uK9dWZsNfEJ0rXLN4ufzUHm/7m8OYCA=;
  b=BpASkEJ20Nprqz0TEKkHDb35JRfxu+bUz7sraLboWIFQLIWxelOmSAC9
   J8VjsF+5We6d7TciW/dhpM75/r2jw9X+1Z9VyEH2QRYqdMBxT8zZk23WF
   foKebWPXCZhdVLVGRnHzGV0dOMOSbWSEsDMUHzeRgQeO4cUTOuZgJUd/1
   nNuKg0QnFgiuOjmasNcaUpMt9VjH+DoG+rFw9pi+nKwCShJ8aXKFQI7e4
   sK3rwvRxK1kwwi89gATVsvN2qI6IBZhg/44qloLWvPPDf/4lCOVxL3xa8
   TJ2h0IX6V6tKuVEBDZ0GTac2kn85nbUItTmCG2LgWge33RabW8gckuBXE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="365032765"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="365032765"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 16:19:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="849791515"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="849791515"
Received: from asmaaabd-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 16:19:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B7F45103A25; Tue, 25 Jul 2023 02:19:27 +0300 (+03)
Date:   Tue, 25 Jul 2023 02:19:27 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Message-ID: <20230724231927.pah3dt6gszwtsu45@box.shutemov.name>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
 <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
 <BYAPR21MB16888FB226E2829E3B5C517BD737A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16888FB226E2829E3B5C517BD737A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:43:39PM +0000, Michael Kelley (LINUX) wrote:
> From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Saturday, July 8, 2023 11:09 PM
> > 
> > On Sat, Jul 08, 2023 at 11:53:08PM +0000, Michael Kelley (LINUX) wrote:
> > > From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Friday, July 7, 2023 7:07 AM
> > > >
> > > > On Thu, Jul 06, 2023 at 04:48:32PM +0000, Michael Kelley (LINUX) wrote:
> > > > > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tuesday, June 6,
> > 2023 2:56 AM
> > >
> > > [snip]
> > >
> > > >
> > > > It only addresses the problem that happens on transition, but
> > > > load_unaligned_zeropad() is still a problem for the shared mappings in
> > > > general, after transition is complete. Like if load_unaligned_zeropad()
> > > > steps from private to shared mapping and shared mapping triggers #VE,
> > > > kernel should be able to handle it.
> > >
> > > I'm showing my ignorance of TDX architectural details, but what's the
> > > situation where shared mappings in general can trigger a #VE?  How
> > > do such situations get handled for references that aren't from
> > > load_unaligned_zeropad()?
> > >
> > 
> > Shared mappings are under host/VMM control. It can just not map the page
> > in shared-ept and trigger ept-violation #VE.
> 
> I know you are out on vacation, but let me follow up now for further
> discussion when you are back.
> 
> Isn't the scenario you are describing a malfunctioning or malicious
> host/VMM?  Would what you are describing be done as part of normal
> operation?   Kernel code must have switched the page from private to
> shared for some purpose.  As soon as that code (which presumably
> does not have any entry in the exception table) touches the page, it
> would take the #VE and the enter the die path because there's no fixup.
> So is there value in having load_unaligned_zeropad() handle the #VE and
> succeed where a normal reference would fail?

#VE on shared memory is legitimately used for MMIO. But MMIO region is
usually separate from the real memory in physical address space.

But we also have DMA.

DMA pages allocated from common pool of memory and they can be next to
dentry cache that kernel accesses with load_unaligned_zeropad(). DMA pages
are shared, but they usually backed by memory and not cause #VE. However
shared memory is under full control from VMM and VMM can remove page at
any point which would make platform to deliver #VE to the guest. This is
pathological scenario, but I think it still worth handling gracefully.

> I'd still like to see the private <-> shared transition code mark the pages
> as invalid during the transition, and avoid the possibility of #VE and
> similar cases with SEV-SNP.  Such approach reduces (eliminates?)
> entanglement between CoCo-specific exceptions and
> load_unaligned_zeropad().  It also greatly simplifies TD Partition cases
> and SEV-SNP cases where a paravisor is used.

I doesn't eliminates issue for TDX as the scenario above is not transient.
It can happen after memory is converted to shared.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
