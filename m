Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC36380AD69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjLHT5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHT5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:57:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2810F1;
        Fri,  8 Dec 2023 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702065475; x=1733601475;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzztr2vL6DpeporjOTsxI9y9kBcB6HDvx6vV8t2DZhw=;
  b=JTIJ8rcin+vCpsCi9ijnVaceF05GihHY6WqENT1YS/Mql+IwqrvcOsUW
   DCGylcBqCwNMlmGy3X1eCfUTygBKp72RBH6/FZlbsL8yaF+X9jxX9fh89
   eKC7b5/uznYJ/BMbBDGzBZdru3Ijhnx8q9cE/5ocTxpwbWRUBvlUViUxI
   bf8vksUmdJLzvUG3+Yh2wE++vyf0O83rGnpPucC9M2yYsLmdGf/l5kl7V
   jtkqzI5aur6CeOacBJ83h5bFN6/ILgB+6bfq4+Jp2pLzh9/Wfeo3uPXxZ
   vSXgZ24lmvRY77Kse0cKPYjkvbUCxPsWBHpI6bl1xglmFE5IF50LVEWR4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="398320434"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="398320434"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 11:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="842723679"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="842723679"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 11:57:44 -0800
Date:   Fri, 8 Dec 2023 12:02:36 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        seanjc@google.com, Robin Murphy <robin.murphy@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 09/13] x86/irq: Install posted MSI notification
 handler
Message-ID: <20231208120236.0f3b287d@jacob-builder>
In-Reply-To: <87zfyksyge.ffs@tglx>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
        <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
        <20231115125624.GF3818@noisy.programming.kicks-ass.net>
        <87cyvjun3z.ffs@tglx>
        <20231207204607.2d2a3b72@jacob-builder>
        <87zfyksyge.ffs@tglx>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, 08 Dec 2023 12:52:49 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> On Thu, Dec 07 2023 at 20:46, Jacob Pan wrote:
> > On Wed, 06 Dec 2023 20:50:24 +0100, Thomas Gleixner <tglx@linutronix.de>
> > wrote:  
> >> I don't understand what the whole copy business is about. It's
> >> absolutely not required.  
> >
> > My thinking is the following:
> > The PIR cache line is contended by between CPU and IOMMU, where CPU can
> > access PIR much faster. Nevertheless, when IOMMU does atomic swap of the
> > PID (PIR included), L1 cache gets evicted. Subsequent CPU read or xchg
> > will deal with invalid cold cache.
> >
> > By making a copy of PIR as quickly as possible and clearing PIR with
> > xchg, we minimized the chance that IOMMU does atomic swap in the middle.
> > Therefore, having less L1D misses.
> >
> > In the code above, it does read, xchg, and call_irq_handler() in a loop
> > to handle the 4 64bit PIR bits at a time. IOMMU has a greater chance to
> > do atomic xchg on the PIR cache line while doing call_irq_handler().
> > Therefore, it causes more L1D misses.  
> 
> That makes sense and if we go there it wants to be documented.
will do. How about this explanation:
"
Posted interrupt descriptor (PID) fits in a cache line that is frequently
accessed by both CPU and IOMMU.

During posted MSI processing, the CPU needs to do 64-bit read and xchg for
checking and clearing posted interrupt request (PIR), a 256 bit field
within the PID. On the other side, IOMMU do atomic swaps of the entire
PID cache line when posting interrupts. The CPU can access the cache line
much faster than the IOMMU.

The cache line states after each operation are as follows:

CPU		IOMMU			PID Cache line state
-------------------------------------------------------------
read64					exclusive
lock xchg64				modified
		post/atomic swap	invalid
-------------------------------------------------------------
Note that PID cache line is evicted after each IOMMU interrupt posting.

The posted MSI demuxing loop is written to optimize the cache performance
based on the two considerations around the PID cache line:

1. Reduce L1 data cache miss by avoiding contention with IOMMU's interrupt
posting/atomic swap, a copy of PIR is used to dispatch interrupt handlers.

2. Keep the cache line state consistent as much as possible. e.g. when
making a copy and clearing the PIR (assuming non-zero PIR bits are present
in the entire PIR), do:
read, read, read, read, xchg, xchg, xchg, xchg
instead of:
read, xchg, read, xchg, read, xchg, read, xchg
"

> 
> > Without PIR copy:
> >
> > DMA memfill bandwidth: 4.944 Gbps
> > Performance counter stats for './run_intr.sh 512 30':
> > 
> >     77,313,298,506      L1-dcache-loads
> >               (79.98%) 8,279,458      L1-dcache-load-misses     #
> > 0.01% of all L1-dcache accesses  (80.03%) 41,654,221,245
> > L1-dcache-stores                                              (80.01%)
> > 10,476      LLC-load-misses           #    0.31% of all LL-cache
> > accesses  (79.99%) 3,332,748      LLC-loads
> >                         (80.00%) 30.212055434 seconds time elapsed
> > 
> >        0.002149000 seconds user
> > 30.183292000 seconds sys
> >                         
> >
> > With PIR copy:
> > DMA memfill bandwidth: 5.029 Gbps
> > Performance counter stats for './run_intr.sh 512 30':
> >
> >     78,327,247,423      L1-dcache-loads
> >               (80.01%) 7,762,311      L1-dcache-load-misses     #
> > 0.01% of all L1-dcache accesses  (80.01%) 42,203,221,466
> > L1-dcache-stores                                              (79.99%)
> > 23,691      LLC-load-misses           #    0.67% of all LL-cache
> > accesses  (80.01%) 3,561,890      LLC-loads
> >                         (80.00%)
> >
> >       30.201065706 seconds time elapsed
> >
> >        0.005950000 seconds user
> >       30.167885000 seconds sys  
> 
> Interesting, though I'm not really convinced that this DMA memfill
> microbenchmark resembles real work loads.
> 
It is just a tool to get some quick experiments done, not realistic. Though
I am adding various knobs to make it more useful. e.g. adjustable interrupt
rate, delays in idxd hardirq handler.

> Did you test with something realistic, e.g. storage or networking, too?
> 
Not yet for this particular code, working on testing with FIO on Samsung
Gen5 NVMe disks. I am getting help from the people with the set up.


Thanks,

Jacob
