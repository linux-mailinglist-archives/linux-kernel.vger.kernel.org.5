Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1637F754E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjKXNen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjKXNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:34:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B58E173B;
        Fri, 24 Nov 2023 05:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700832847; x=1732368847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BqOo8o3FAxQ3sv9OF/Du7NB3vD4Ym6X99rsyMxspLOM=;
  b=KTge55eBh93oK3Q0xtIOLcD0Un9M7udXR1ayJ26jEE/EHZzmEw7zG4wF
   Q/9nvVX1jC3i36KBf5ItSg6EtXPKPWEqQsC2ZiKh0+z6BUSDZyxevz1gN
   NPsGFdcKMcsZI+TAfcSOnUHUTvn7aGsnDXbX/zo8WqBJ3HgX0BaEplYVc
   Vok53/RAOQhz4HnngzcolIitnDYRSak1mc8IektnZtw860eGY9nEsUeNt
   r72Cxpz+I31Z5n4sAP70mU5hyaizpNkuD60iAPkFKaNE9SHxZbZWaYUNZ
   fntzwTIalpjc+y9HrkvK48YgPHLE8iHCHLNnHqLKQou/m8A11ltYanHgj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389576992"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389576992"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:34:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15634065"
Received: from dlemiech-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.59.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:34:02 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A48F510A38A; Fri, 24 Nov 2023 16:33:58 +0300 (+03)
Date:   Fri, 24 Nov 2023 16:33:58 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Message-ID: <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:04:56PM +0100, Jeremi Piotrowski wrote:
> On 24/11/2023 11:43, Kirill A. Shutemov wrote:
> > On Fri, Nov 24, 2023 at 11:31:44AM +0100, Jeremi Piotrowski wrote:
> >> On 23/11/2023 14:58, Kirill A. Shutemov wrote:
> >>> On Wed, Nov 22, 2023 at 06:01:04PM +0100, Jeremi Piotrowski wrote:
> >>>> Check for additional CPUID bits to identify TDX guests running with Trust
> >>>> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
> >>>> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
> >>>>
> >>>> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is visible
> >>>> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
> >>>> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
> >>>> aware mechanisms for what's left. So currently such guests do not have
> >>>> X86_FEATURE_TDX_GUEST set.
> >>>>
> >>>> We want the kernel to have X86_FEATURE_TDX_GUEST set for all TDX guests so we
> >>>> need to check these additional CPUID bits, but we skip further initialization
> >>>> in the function as we aren't guaranteed access to TDX module calls.
> >>>
> >>> I don't follow. The idea of partitioning is that L2 OS can be
> >>> unenlightened and have no idea if it runs indide of TD. But this patch
> >>> tries to enumerate TDX anyway.
> >>>
> >>> Why?
> >>>
> >>
> >> That's not the only idea of partitioning. Partitioning provides different privilege
> >> levels within the TD, and unenlightened L2 OS can be made to work but are inefficient.
> >> In our case Linux always runs enlightened (both with and without TD partitioning), and
> >> uses TDX functionality where applicable (TDX vmcalls, PTE encryption bit).
> > 
> > What value L1 adds in this case? If L2 has to be enlightened just run the
> > enlightened OS directly as L1 and ditch half-measures. I think you can
> > gain some performance this way.
> > 
> 
> It's primarily about the privilege separation, performance is a reason
> one doesn't want to run unenlightened. The L1 makes the following possible:
> - TPM emulation within the trust domain but isolated from the OS
> - infrastructure interfaces for things like VM live migration
> - support for Virtual Trust Levels[1], Virtual Secure Mode[2]
> 
> These provide a lot of value to users, it's not at all about half-measures.

Hm. Okay.

Can we take a step back? What is bigger picture here? What enlightenment
do you expect from the guest when everything is in-place?

So far I see that you try to get kernel think that it runs as TDX guest,
but not really. This is not very convincing model.

Why does L2 need to know if it runs under TDX or SEV? Can't it just think
it runs as Hyper-V guest and all difference between TDX and SEV abstracted
by L1?

So far, I failed to see coherent design. Maybe I just don't know where to
look.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
