Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA27F2918
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjKUJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjKUJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:42:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B784490
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700559748; x=1732095748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKDb5RgVL1eT3zD06y02XsLI88vWKvuYieg0wRPL9PM=;
  b=IaSpGEpZFwzTQzblpjc0arK4wHT4Frw0cH7syVboMrSkyQknArEp5s5Q
   XPk5FBnoQbZVFjLHNR8J6XFCm9BszexFj2/dCQSbdCwHGU7Fcv5jraS4Z
   yN9Sontd68c5hn6yVA8s8zrMkLDqNfudyFo4Y24HETr517j7xWq7LWisk
   ywknTUis1ShZH2BrGrnBI3ZONqgEflkWT51b0fN5YbNTmVRdG0gDLKl/s
   ByskiVBigi5nZXI7UO3aTtR1e3UybkaS8uTCisFcK/rKsifl7PGdUy1Wd
   eKoqpIY+335tcLV/QQ1xFxfizSyEFL0oL+viazp7/JdePZuIj+qJGtZCX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376839376"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376839376"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766584619"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="766584619"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:42:22 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0860910A36E; Tue, 21 Nov 2023 12:42:20 +0300 (+03)
Date:   Tue, 21 Nov 2023 12:42:19 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 09/14] x86/tdx: Account shared memory
Message-ID: <20231121094219.x5ez6ohzc773viul@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-10-kirill.shutemov@linux.intel.com>
 <07e7619d098ba3579f642a97b644f256884ed0a2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07e7619d098ba3579f642a97b644f256884ed0a2.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:47:29AM +0000, Huang, Kai wrote:
> 
> > +static atomic_long_t nr_shared;
> > +
> > +static inline bool pte_decrypted(pte_t pte)
> > +{
> > +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> > +}
> > +
> >  /* Called from __tdx_hypercall() for unrecoverable failure */
> >  noinstr void __noreturn __tdx_hypercall_failed(void)
> >  {
> > @@ -820,6 +828,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> >  	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> >  		return -EIO;
> >  
> > +	if (enc)
> > +		atomic_long_sub(numpages, &nr_shared);
> > +	else
> > +		atomic_long_add(numpages, &nr_shared);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -895,3 +908,59 @@ void __init tdx_early_init(void)
> >  
> >  	pr_info("Guest detected\n");
> >  }
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static int tdx_shared_memory_show(struct seq_file *m, void *p)
> > +{
> > +	unsigned long addr, end;
> > +	unsigned long found = 0;
> > +
> > +	addr = PAGE_OFFSET;
> > +	end  = PAGE_OFFSET + get_max_mapped();
> > +
> > +	while (addr < end) {
> > +		unsigned long size;
> > +		unsigned int level;
> > +		pte_t *pte;
> > +
> > +		pte = lookup_address(addr, &level);
> > +		size = page_level_size(level);
> > +
> > +		if (pte && pte_decrypted(*pte))
> > +			found += size / PAGE_SIZE;
> > +
> > +		addr += size;
> > +
> > +		cond_resched();
> > +	}
> > +
> > +	seq_printf(m, "Number of unshared pages in kernel page tables:  %16lu\n",
> > +		   found);
> > +	seq_printf(m, "Number of pages accounted as unshared:           %16ld\n",
> > +		   atomic_long_read(&nr_shared));
> 
> unshared -> shared?

Right.

> Btw, I am not quite sure what's the purpose of reporting number of shared pages
> in both kernel page table and that the kernel is accounting?
> 
> IIUC, there might be slight chance that the former is different from the latter
> (i.e., when user reads this while the kernel is converting pages
> simultaneously), but in most of the time the user should see they are the same.
> 
> I can see it might be helpful to report @nr_shared to the user, but how can
> reporting both help the user?

It is critical to unshared *all* pages on kexec or the second kernel will
crash at some point on accessing shared page as private.

This is the sanity check: if number of shared pages in page tables is less
than what we expected, we've lost shared bit somewhere. And kexec will
likely be a disaster.

Ability to trigger the check a any point can help to correlate the leak
with activity.

> That being said, I think perhaps you can separate the /sysfs part as a separate
> patch because it's not a mandatory part of this series but a nice to have.  Then
> the /sysfs part can be reviewed separately. 

Okay, makes sense.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
