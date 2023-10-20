Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E947D0C21
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376719AbjJTJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376629AbjJTJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:40:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6531AE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794800; x=1729330800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZ9h/1dkx6WDuYKgtpvasjXyeVxLzD5QLg3183XfY9k=;
  b=nTtuD1Wm0+qqoYw/c8Flk3USxB4nqlQA9dPmXq1cqdgFZuB1vIKzwPKY
   XT06MQHaklnGQjfSqU6WmJZRKcuJkbc0ozGRaj/+ruvUlK6zzPmgB/Sgz
   Lg5GVAlfPSfM7Fa45MQA20XnhsxwT7GjyXe4Fu0M6l3Twet3V+z1PjQMn
   /BsfbVwbKq1GzVftqZJnVmQjGs64U+s5tBLTwVjyABKPZtJPrOYzm9pWj
   NEKy2AFf/UeZnhCQA2NwTqfMcSb4ldRI/4u05+4erabAZRVQTTrII3Kge
   jRu8usAJGCWtE42Tz6JJury1BrvMf+DAMFGXijUG3c3PsHjzJo+77DK3v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472687483"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472687483"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750862349"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750862349"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:39:55 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A0949109D0A; Fri, 20 Oct 2023 12:39:52 +0300 (+03)
Date:   Fri, 20 Oct 2023 12:39:52 +0300
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
Message-ID: <20231020093952.nx3a6fid2jqdumnw@box>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
 <20231005212828.veeekxqc7rwvrbig@box>
 <e0459b50-7e21-7548-8151-9010ee88b0a6@amd.com>
 <20231005222839.jt2du72xogg3c5ny@box>
 <f4228262-02f9-3af5-8ef5-be109b5d3d13@amd.com>
 <20231020092111.ho2rmhve23kgcxbr@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020092111.ho2rmhve23kgcxbr@box>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 12:21:11PM +0300, Kirill A. Shutemov wrote:
> On Fri, Oct 06, 2023 at 02:24:11PM -0500, Kalra, Ashish wrote:
> > 
> > On 10/5/2023 5:28 PM, Kirill A. Shutemov wrote:
> > > On Thu, Oct 05, 2023 at 05:01:23PM -0500, Kalra, Ashish wrote:
> > > > On 10/5/2023 4:28 PM, Kirill A. Shutemov wrote:
> > > > > On Thu, Oct 05, 2023 at 01:41:38PM -0500, Kalra, Ashish wrote:
> > > > > > > +static void unshare_all_memory(bool unmap)
> > > > > > > +{
> > > > > > > +	unsigned long addr, end;
> > > > > > > +	long found = 0, shared;
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Walk direct mapping and convert all shared memory back to private,
> > > > > > > +	 */
> > > > > > > +
> > > > > > > +	addr = PAGE_OFFSET;
> > > > > > > +	end  = PAGE_OFFSET + get_max_mapped();
> > > > > > > +
> > > > > > > +	while (addr < end) {
> > > > > > > +		unsigned long size;
> > > > > > > +		unsigned int level;
> > > > > > > +		pte_t *pte;
> > > > > > > +
> > > > > > > +		pte = lookup_address(addr, &level);
> > > > > > 
> > > > > > IIRC, you were earlier walking the direct mapping using
> > > > > > walk_page_range_novma(), any particular reason to use lookup_address()
> > > > > > instead ?
> > > > > 
> > > > > walk_page_range_novma() wants mmap lock to be taken, but it is tricky as
> > > > > we run here from atomic context in case of crash.
> > > > > 
> > > > > I considered using trylock to bypass the limitation, but it is a hack.
> > > > > 
> > > > > > 
> > > > > > > +		size = page_level_size(level);
> > > > > > > +
> > > > > > > +		if (pte && pte_decrypted(*pte)) {
> > > > > > 
> > > > > > Additionally need to add check for pte_none() here to handle physical memory
> > > > > > holes in direct mapping.
> > > > > 
> > > > > lookup_address() returns NULL for none entries.
> > > > > 
> > > > 
> > > > Looking at lookup_address_in_pgd(), at pte level it is simply returning
> > > > pte_offset_kernel() and there does not seem to be a check for returning NULL
> > > > if pte_none() ?
> > > 
> > > Hm. You are right.
> > > 
> > > I think it yet another quirk in how lookup_address() implemented. We need
> > > to make it straight too.
> > > 
> > > There's two options: either make lookup_address() return pointer for entry
> > > even if it is NULL, or add check for pte_none() after pte_offset_kernel()
> > > and return NULL if it is true.
> > > 
> > > I like the first option more as it allows caller to populate the entry if
> > > it wants.
> > 
> > Yes, i like the first option.
> 
> I tried to this, but lookup_address() has to many callers. It gets beyond
> the scope of the patchset. I will add pte_none() check on unshare side for
> now.

Ah. pte_none() is not need for TDX implementation, as pte_decrypted()
check will fail for it. SEV implementation would need an additional check.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
