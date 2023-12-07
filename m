Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429928092D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjLGU4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGU4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:56:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED191713;
        Thu,  7 Dec 2023 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701982585; x=1733518585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n3FnhgX0cW+i0sQ51vehSslGZAw1aIhqgl0Q6Iu8nas=;
  b=L7y6tU9x+1WX7V0HrYX9My0D2b4ShSkWmwiNYC6o1fHZQc1/TsnCKe2T
   CWcjz29txcSvl7wJMmJRcUg20haQSCWxdvqIezIcLYjAp5QGbJcJ36tiH
   lSV88xtAu+E8EW5S7yxVsi5KTpUQXCbU2pVM3XvnE//HC6Nb6JEijcH61
   yzePQlJFKstw3hyQ2xImy3KjZKEjd+BVUpedy6fp68ozILLhGKwcOpeFB
   E2GNDarrbNxslIMXlM8N+e0ZCe5CpLUbDVbMgNIt5y6O12WQLw2vc71b9
   F+cnGnBnjvCXb1P9ztUewJBTumbwu6ke1/7ZA8J2GMLKyFBIsYTMFlAl9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1383440"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1383440"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 12:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915699144"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="915699144"
Received: from agrische-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.188])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 12:56:18 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4BE2310A42E; Thu,  7 Dec 2023 23:56:16 +0300 (+03)
Date:   Thu, 7 Dec 2023 23:56:16 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
        "cascardo@canonical.com" <cascardo@canonical.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Message-ID: <20231207205616.4eybazmxianjgud5@box>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <DM8PR11MB575090573031AD9888D4738AE786A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9ab71fee-be9f-4afc-8098-ad9d6b667d46@linux.microsoft.com>
 <20231205105407.vp2rejqb5avoj7mx@box.shutemov.name>
 <0c4e33f0-6207-448d-a692-e81391089bea@linux.microsoft.com>
 <20231206225415.zxfm2ndpwsmthc6e@box.shutemov.name>
 <66cff831-1766-4b82-b95a-bc3790a6f24b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cff831-1766-4b82-b95a-bc3790a6f24b@linux.microsoft.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 06:06:38PM +0100, Jeremi Piotrowski wrote:
> > 
> >> This doesn't work in partitioning when TDVMCALLs go to L0: TDVMCALL_MAP_GPA bypasses
> >> L1 and TDX_ACCEPT_PAGE is L1 responsibility.
> >>
> >> If you want to see how this is currently supported take a look at arch/x86/hyperv/ivm.c.
> >> All memory starts as private and there is a hypercall to notify the paravisor for both
> >> TDX (when partitioning) and SNP (when VMPL). This guarantees that all page conversions
> >> go through L1.
> > 
> > But L1 guest control anyway during page conversion and it has to manage
> > aliases with TDG.MEM.PAGE.ATTR.RD/WR. Why do you need MAP_GPA for that?
> >
> 
> When the L2 wants to perform a page conversion it needs to notify L1 of this so that it
> can do its part managing the aliases. Without L1 involvement the conversion doesn't
> happen. MAP_GPA is not suitable for this purpose as I've described and you've confirmed
> above.

Memory conversion causes exit to L1 as there will be no aliases in L2
otherwise. There's no need to intercept MAP_GPA for that. See section
21.8 of TD partitioning spec.

>  
> > One possible change I mentioned above: make TDVMCALL exit to L1 for some
> > TDVMCALL leafs (or something along the line).
> > 
> 
> You can explore changes to TDVMCALL handling in the TDX module but I don't see any reason
> this would be adopted, because a shared hypercall to control page visibility for SNP & TDX is
> already part of Hyper-V ABI and works great for this purpose.
> 
> > I would like to keep it transparent for enlightened TDX Linux guest. It
> > should not care if it runs as L1 or as L2 in your environment.
> 
> I understand that is how you would prefer it but, as we've established in these emails,
> that doesn't work when the L1 paravisor provides services to the L2 with an L1 specific
> protocol and TDVMCALLs are routed to L0 for performance reasons. It can't be done
> transparently with TDX 1.5 calls alone and we already have TDX 1.5 deployed to users with
> an upstream kernel.

TDX 1.5 is not set in stone (yet). The spec is still draft. We can add
capabilities if we make case for them.

Let's try to shift the discussion to how to make TDX better rather than
adding workaround to kernel.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
