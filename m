Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067287BAECF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjJEW2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJEW2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:28:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F13F95
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696544927; x=1728080927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ak/CqPJFuvAGz1nL0ORtkufKNGBvhTu0OaUcGSyyRI=;
  b=NQDAL77cxVWjqS0QEh9xfZYC2CSjJedtz4Pwek6IwrL/17DcsTS1gON3
   1ZDxwJ5dg0vklw2Hxv1Kesgc3bodm/Cz7KZ2HlM9/52I6o5urYMEcxJbh
   mWru4VTxHsTfcL+ajbgemCCUhyPRvnmA3WOIU3p4r3L0JQXwfr1nuwwHX
   yT+sGs47w2MhM4roDqPhZQzBZCeSnYQN1Ew3UgnkkV/3NWq0hzy0Y8ieN
   c3ec2hMMZfT3tGI46gncUDAnAKwlooDDiTKI62YwVZ8AuJ4EvM270tpFf
   M8ZLa6bJxqMxyKWW1eVBjqIY8txfUn/vMfS7FYesynebqU/ZuKX5FlCFO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="5195866"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="5195866"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 15:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817796476"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817796476"
Received: from kvsudesh-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.251.222.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 15:28:43 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id BFE0B10A12D; Fri,  6 Oct 2023 01:28:39 +0300 (+03)
Date:   Fri, 6 Oct 2023 01:28:39 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Kalra, Ashish" <ashish.kalra@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Message-ID: <20231005222839.jt2du72xogg3c5ny@box>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
 <20231005212828.veeekxqc7rwvrbig@box>
 <e0459b50-7e21-7548-8151-9010ee88b0a6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0459b50-7e21-7548-8151-9010ee88b0a6@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 05:01:23PM -0500, Kalra, Ashish wrote:
> On 10/5/2023 4:28 PM, Kirill A. Shutemov wrote:
> > On Thu, Oct 05, 2023 at 01:41:38PM -0500, Kalra, Ashish wrote:
> > > > +static void unshare_all_memory(bool unmap)
> > > > +{
> > > > +	unsigned long addr, end;
> > > > +	long found = 0, shared;
> > > > +
> > > > +	/*
> > > > +	 * Walk direct mapping and convert all shared memory back to private,
> > > > +	 */
> > > > +
> > > > +	addr = PAGE_OFFSET;
> > > > +	end  = PAGE_OFFSET + get_max_mapped();
> > > > +
> > > > +	while (addr < end) {
> > > > +		unsigned long size;
> > > > +		unsigned int level;
> > > > +		pte_t *pte;
> > > > +
> > > > +		pte = lookup_address(addr, &level);
> > > 
> > > IIRC, you were earlier walking the direct mapping using
> > > walk_page_range_novma(), any particular reason to use lookup_address()
> > > instead ?
> > 
> > walk_page_range_novma() wants mmap lock to be taken, but it is tricky as
> > we run here from atomic context in case of crash.
> > 
> > I considered using trylock to bypass the limitation, but it is a hack.
> > 
> > > 
> > > > +		size = page_level_size(level);
> > > > +
> > > > +		if (pte && pte_decrypted(*pte)) {
> > > 
> > > Additionally need to add check for pte_none() here to handle physical memory
> > > holes in direct mapping.
> > 
> > lookup_address() returns NULL for none entries.
> > 
> 
> Looking at lookup_address_in_pgd(), at pte level it is simply returning
> pte_offset_kernel() and there does not seem to be a check for returning NULL
> if pte_none() ?

Hm. You are right.

I think it yet another quirk in how lookup_address() implemented. We need
to make it straight too.

There's two options: either make lookup_address() return pointer for entry
even if it is NULL, or add check for pte_none() after pte_offset_kernel()
and return NULL if it is true.

I like the first option more as it allows caller to populate the entry if
it wants.

> > > > +			int pages = size / PAGE_SIZE;
> > > > +
> > > > +			/*
> > > > +			 * Touching memory with shared bit set triggers implicit
> > > > +			 * conversion to shared.
> > > > +			 *
> > > > +			 * Make sure nobody touches the shared range from
> > > > +			 * now on.
> > > > +			 *
> > > > +			 * Bypass unmapping for crash scenario. Unmapping
> > > > +			 * requires sleepable context, but in crash case kernel
> > > > +			 * hits the code path with interrupts disabled.
> > > 
> > > In case of SNP we will need to temporarily enable interrupts during this
> > > unsharing as we invoke set_memory_encrypted() which then hits a BUG_ON() in
> > > cpa_flush() if interrupts are disabled.
> > 
> > Do you really need full set_memory_encrypted()? Can't you do something
> > ligher?
> > 
> We need to modify the PTE for setting c-bit to 1 so that will require
> cpa_flush(), though probably can add something lighter to do
> clflush_cache_range() directly ?

For TDX, I don't touch shared bit as nobody suppose to touch the memory
after the point (ans set_memory_np() enforces it for !crash case).

Can't SNP do the same?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
