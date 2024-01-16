Return-Path: <linux-kernel+bounces-27075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2B82EA07
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C9628351D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D496711181;
	Tue, 16 Jan 2024 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I85/NEr4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2310A24
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705390111; x=1736926111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TSolB+oyi3C9hkuFFHhBMz7/4wt57eHKe4pzmzp1U0k=;
  b=I85/NEr4UHIzjK/2d2WRHMQHNaD9o8jsRdqoxMmtHaSNYSelkYUuakfa
   CjlG73n8eg6ij8FNeLLdJdBAFB4n+Eo7y2HCrybBfPepiOsYLZvA2BGiv
   rF+1TkAfVhIoa1Y/FYYeA+BNR0btQDvOt5jHUjCyAi/nrqP0qsk4/tyUO
   Nof0Taemr8MVVKCuNi+8AHlZmWpGB0C3eRYAhfEwlrN30LhApUO2TrvHj
   7Z6dlDt3xlQnk5v2s1o0mt9rLHwfZuctBdn3jluxLYxo6ZDEeYd5MEjn2
   orVIo6YlPnJLFyxW5f8kCxrl6eovsVN/j447MkAOoLt1ChQm2t+c/TILa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="7145604"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="7145604"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 23:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="957056194"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="957056194"
Received: from uschumac-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.254])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 23:28:25 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id A587210A17B; Tue, 16 Jan 2024 10:28:22 +0300 (+03)
Date: Tue, 16 Jan 2024 10:28:22 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
 <89e8722b-661b-4319-8018-06705b366c62@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89e8722b-661b-4319-8018-06705b366c62@suse.com>

On Mon, Jan 15, 2024 at 12:53:42PM +0200, Nikolay Borisov wrote:
> 
> 
> On 23.12.23 г. 1:52 ч., Kirill A. Shutemov wrote:
> > TDX guests allocate shared buffers to perform I/O. It is done by
> > allocating pages normally from the buddy allocator and converting them
> > to shared with set_memory_decrypted().
> > 
> > The second kernel has no idea what memory is converted this way. It only
> > sees E820_TYPE_RAM.
> > 
> > Accessing shared memory via private mapping is fatal. It leads to
> > unrecoverable TD exit.
> > 
> > On kexec walk direct mapping and convert all shared memory back to
> > private. It makes all RAM private again and second kernel may use it
> > normally.
> > 
> > The conversion occurs in two steps: stopping new conversions and
> > unsharing all memory. In the case of normal kexec, the stopping of
> > conversions takes place while scheduling is still functioning. This
> > allows for waiting until any ongoing conversions are finished. The
> > second step is carried out when all CPUs except one are inactive and
> > interrupts are disabled. This prevents any conflicts with code that may
> > access shared memory.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > ---
> >   arch/x86/coco/tdx/tdx.c         | 119 +++++++++++++++++++++++++++++++-
> >   arch/x86/include/asm/x86_init.h |   2 +
> >   arch/x86/kernel/crash.c         |   6 ++
> >   arch/x86/kernel/reboot.c        |  13 ++++
> >   4 files changed, 138 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 8a49484a2917..5c64db168edd 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -6,8 +6,10 @@
> >   #include <linux/cpufeature.h>
> >   #include <linux/debugfs.h>
> > +#include <linux/delay.h>
> >   #include <linux/export.h>
> >   #include <linux/io.h>
> > +#include <linux/kexec.h>
> >   #include <asm/coco.h>
> >   #include <asm/tdx.h>
> >   #include <asm/vmx.h>
> > @@ -15,6 +17,7 @@
> >   #include <asm/insn.h>
> >   #include <asm/insn-eval.h>
> >   #include <asm/pgtable.h>
> > +#include <asm/set_memory.h>
> >   /* MMIO direction */
> >   #define EPT_READ	0
> > @@ -41,6 +44,9 @@
> >   static atomic_long_t nr_shared;
> > +static atomic_t conversions_in_progress;
> > +static bool conversion_allowed = true;
> 
> Given the usage model of this variable, shouldn't it be simply accessed via
> READ/WRITE_ONCE macros?

What do you see it changing?

> > +
> >   static inline bool pte_decrypted(pte_t pte)
> >   {
> >   	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> > @@ -726,6 +732,14 @@ static bool tdx_tlb_flush_required(bool private)
> >   static bool tdx_cache_flush_required(void)
> >   {
> > +	/*
> > +	 * Avoid issuing CLFLUSH on set_memory_decrypted() if conversions
> > +	 * stopped. Otherwise it can race with unshare_all_memory() and trigger
> > +	 * implicit conversion to shared.
> > +	 */
> > +	if (!conversion_allowed)
> > +		return false;
> > +
> >   	/*
> >   	 * AMD SME/SEV can avoid cache flushing if HW enforces cache coherence.
> >   	 * TDX doesn't have such capability.
> > @@ -809,12 +823,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> >   static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
> >   					 bool enc)
> >   {
> > +	atomic_inc(&conversions_in_progress);
> > +
> > +	/*
> > +	 * Check after bumping conversions_in_progress to serialize
> > +	 * against tdx_shutdown().
> > +	 */
> > +	if (!conversion_allowed) {
> > +		atomic_dec(&conversions_in_progress);
> > +		return -EBUSY;
> > +	}
> 
> nit: Can you make the inc of conversions_in_progress be done here, this
> eliminated the atomic_dec in case they aren't. Somewhat simplifies the
> logic.

Okay, fair enough. Will change.

> > +
> >   	/*
> >   	 * Only handle shared->private conversion here.
> >   	 * See the comment in tdx_early_init().
> >   	 */
> > -	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> > +	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
> > +		atomic_dec(&conversions_in_progress);
> >   		return -EIO;
> > +	}
> >   	return 0;
> >   }
> > @@ -826,17 +853,102 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> >   	 * Only handle private->shared conversion here.
> >   	 * See the comment in tdx_early_init().
> >   	 */
> > -	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> > +	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
> > +		atomic_dec(&conversions_in_progress);
> >   		return -EIO;
> > +	}
> >   	if (enc)
> >   		atomic_long_sub(numpages, &nr_shared);
> >   	else
> >   		atomic_long_add(numpages, &nr_shared);
> > +	atomic_dec(&conversions_in_progress);
> > +
> >   	return 0;
> >   }
> > +static void tdx_kexec_stop_conversion(bool crash)
> > +{
> > +	/* Stop new private<->shared conversions */
> > +	conversion_allowed = false;
> 
> What's the logic behind this compiler barrier?

Disallow compiler to push the assignment past atomic_read() loop below.
Not sure if anything else prevents such reorder without the barrier.

And I don't think WRITE_ONCE() will do the trick. It only prevents
multiple writes, but doesn't prevent reorders agains accesses
non-READ_ONCE()/WRITE_ONCE() accesses.

> > +	barrier();
> > +
> > +	/*
> > +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> > +	 * conversions to finish.
> > +	 *
> > +	 * If race happened, just report and proceed.
> > +	 */
> > +	if (!crash) {
> > +		unsigned long timeout;
> > +
> > +		/*
> > +		 * Wait for in-flight conversions to complete.
> > +		 *
> > +		 * Do not wait more than 30 seconds.
> > +		 */
> > +		timeout = 30 * USEC_PER_SEC;
> > +		while (atomic_read(&conversions_in_progress) && timeout--)
> > +			udelay(1);
> > +	}
> > +
> > +	if (atomic_read(&conversions_in_progress))
> > +		pr_warn("Failed to finish shared<->private conversions\n");
> > +}
> > +
> 
> <snip>
> 
> > diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> > index c9503fe2d13a..3196ff20a29e 100644
> > --- a/arch/x86/include/asm/x86_init.h
> > +++ b/arch/x86/include/asm/x86_init.h
> > @@ -154,6 +154,8 @@ struct x86_guest {
> >   	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
> >   	bool (*enc_tlb_flush_required)(bool enc);
> >   	bool (*enc_cache_flush_required)(void);
> > +	void (*enc_kexec_stop_conversion)(bool crash);
> > +	void (*enc_kexec_unshare_mem)(void);
> 
> These are only being initialized in the TDX case, but called in all cases
> when CC_ATTR_GUEST_MEM_ENCRYPT is true, which includes AMD. So it would
> cause a crash, no ? Shouldn't you also introduce noop handlers initialized
> in the default x86_platform struct in arch/x86/kernel/x86_init.c ?

kexec on AMD will not work without them, I think. But noops makes sense
anyway. Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

