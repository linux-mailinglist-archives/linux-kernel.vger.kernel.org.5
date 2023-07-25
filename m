Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B96762734
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGYXMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjGYXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:12:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71733193
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690326760; x=1721862760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4s9F2RMzca1SnjP8iJv+eGAM2teJG1YvpI+AnkF73n0=;
  b=eAhiDWPCb1a5cDcwcOnG3a9L48NSFiJkhy2MCGfC5t+L0uKRQvXHABGS
   zy9a8fCiSz2dud3euK8lMMhwvme55VDIDIDLToiuptqCGqbdnU6jIJasV
   Z7b8OgjIHxcFKlp/KVzMjvuMaklfi8NnamlSS0dIQ8Ni3DUfAM1hHeyhc
   W/ud3AfD/FUpMaZTfMyZG9Ujoo4/XVyU7RRnbJkVbc+Yp4N6Opujxev8J
   pnH5Xq23xtvqOGRvvbHyUb54VV5xgQrWL48JXbOdYOQFJAuxETRMnGO1h
   c91p9TvR3Pdt3VsQjxDkRSdeX8vHSub6YSjhtHH8ZcBu1CBcXK3RkYclU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="434119089"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="434119089"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 16:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="850212118"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="850212118"
Received: from mlytkin-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.57.129])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 16:12:36 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 55635103A12; Wed, 26 Jul 2023 02:12:33 +0300 (+03)
Date:   Wed, 26 Jul 2023 02:12:33 +0300
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
Message-ID: <20230725231233.mu2yarso3tcamimu@box.shutemov.name>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
 <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
 <BYAPR21MB16888FB226E2829E3B5C517BD737A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230724231927.pah3dt6gszwtsu45@box.shutemov.name>
 <SN6PR2101MB169365BD0B7C2A6ADEC798A4D703A@SN6PR2101MB1693.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR2101MB169365BD0B7C2A6ADEC798A4D703A@SN6PR2101MB1693.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:51:24PM +0000, Michael Kelley (LINUX) wrote:
> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Monday, July 24, 2023 4:19 PM
> > 
> > On Thu, Jul 13, 2023 at 02:43:39PM +0000, Michael Kelley (LINUX) wrote:
> > > From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Saturday, July 8, 2023 11:09 PM
> > > >
> > > > On Sat, Jul 08, 2023 at 11:53:08PM +0000, Michael Kelley (LINUX) wrote:
> > > > > From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Friday, July 7, 2023 7:07 AM
> > > > > >
> > > > > > On Thu, Jul 06, 2023 at 04:48:32PM +0000, Michael Kelley (LINUX) wrote:
> > > > > > > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tuesday, June 6, 2023 2:56 AM
> > > > >
> > > > > [snip]
> > > > >
> > > > > >
> > > > > > It only addresses the problem that happens on transition, but
> > > > > > load_unaligned_zeropad() is still a problem for the shared mappings in
> > > > > > general, after transition is complete. Like if load_unaligned_zeropad()
> > > > > > steps from private to shared mapping and shared mapping triggers #VE,
> > > > > > kernel should be able to handle it.
> > > > >
> > > > > I'm showing my ignorance of TDX architectural details, but what's the
> > > > > situation where shared mappings in general can trigger a #VE?  How
> > > > > do such situations get handled for references that aren't from
> > > > > load_unaligned_zeropad()?
> > > > >
> > > >
> > > > Shared mappings are under host/VMM control. It can just not map the page
> > > > in shared-ept and trigger ept-violation #VE.
> > >
> > > I know you are out on vacation, but let me follow up now for further
> > > discussion when you are back.
> > >
> > > Isn't the scenario you are describing a malfunctioning or malicious
> > > host/VMM?  Would what you are describing be done as part of normal
> > > operation?   Kernel code must have switched the page from private to
> > > shared for some purpose.  As soon as that code (which presumably
> > > does not have any entry in the exception table) touches the page, it
> > > would take the #VE and the enter the die path because there's no fixup.
> > > So is there value in having load_unaligned_zeropad() handle the #VE and
> > > succeed where a normal reference would fail?
> > 
> > #VE on shared memory is legitimately used for MMIO. But MMIO region is
> > usually separate from the real memory in physical address space.
> > 
> > But we also have DMA.
> > 
> > DMA pages allocated from common pool of memory and they can be next to
> > dentry cache that kernel accesses with load_unaligned_zeropad(). DMA pages
> > are shared, but they usually backed by memory and not cause #VE. However
> > shared memory is under full control from VMM and VMM can remove page at
> > any point which would make platform to deliver #VE to the guest. This is
> > pathological scenario, but I think it still worth handling gracefully.
> 
> Yep, pages targeted by DMA have been transitioned to shared, and could
> be scattered anywhere in the guest physical address space.  Such a page
> could be touched by load_unaligned_zeropad().  But could you elaborate
> more on the "pathological scenario" where the guest physical page isn't
> backed by memory?
> 
> Sure, the VMM can remove the page at any point, but why would it do
> so?  Is doing so a legitimate part of the host/guest contract that the guest
> must handle cleanly?  More importantly, what is the guest expected to
> do in such a case?  I would expect that at some point such a DMA page
> is accessed by a guest vCPU with an explicit reference that is not
> load_unaligned_zeropad().  Then the guest would take a #VE that
> goes down the #GP path and invokes die().
> 
> I don't object to make the load_unaligned_zeropad() fixup path work
> correctly in response to a #VE, as it seems like general goodness.  I'm
> just trying to make sure I understand the nuances of "why".  :-)

We actually triggered the issue during internal testing. I wrote initial
patch after that. But looking back on the report I don't have an answer
why the page triggered #VE. Maybe VMM or virtual BIOS screwed up and put
MMIO next to normal memory, I donno.

> > > I'd still like to see the private <-> shared transition code mark the pages
> > > as invalid during the transition, and avoid the possibility of #VE and
> > > similar cases with SEV-SNP.  Such approach reduces (eliminates?)
> > > entanglement between CoCo-specific exceptions and
> > > load_unaligned_zeropad().  It also greatly simplifies TD Partition cases
> > > and SEV-SNP cases where a paravisor is used.
> > 
> > I doesn't eliminates issue for TDX as the scenario above is not transient.
> > It can happen after memory is converted to shared.
> 
> Notwithstanding, do you have any objections to the private <-> shared
> transition code being changed so it won't be the cause of #VE, and
> similar on SEV-SNP?

I am not yet convinced it is needed. But let's see the code.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
