Return-Path: <linux-kernel+bounces-80109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93B862ADC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5FD1C20927
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3912614016;
	Sun, 25 Feb 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heZI4v8B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971E13AC5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873135; cv=none; b=JtwCE3j9Xq1D7pWHcMxRLN/srIphDYE01YdPV+JFmp/0lOP7aSbC2pXzoNbsUL4XPeCGDGhrvSmMKmj5/w+LwL+Xm94S/gCkg6MQoD9t1CYJEKCc7QEN2pUA19G7nFOhKlewC1rAKCqZ2r/Otz7tmd6dePRK7uB0o14FIYz64aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873135; c=relaxed/simple;
	bh=jePslZk9gVVhTBiw8BU4nyJ2SOGn6xWwNg6KJ2+6rgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8tHMnLvtpSSohprGatzt7PL4/IvhZfkF3ERs4l3YWv/Zq69ukLzOt/Uj/CYLMuktMqndP2EB9/C8pS3mVpqxzuvVDHRdeNNIUG5xwEpG1kahzqZJDXwSbpJ3VcwJuf2XLttLdmW95xM7JDA+wrXLFnLd6wNX/npxyc2h9PtSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heZI4v8B; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708873133; x=1740409133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jePslZk9gVVhTBiw8BU4nyJ2SOGn6xWwNg6KJ2+6rgk=;
  b=heZI4v8Bh4yz2E47FLKfX4snvsQWy28FwBuoAyY8yg11XIUBLu2suIA9
   ogARLpmjtrHIstRtYPwbhmvknEkpdrECRFXWLtHOFp7weHyKlDz96RQxE
   4MxB0ezaCQF6IF9yKbyEDceXHdbUMxJdmcEuW2hEsAatQiSkpdak5fat0
   2TXQmmy3/QSR4J83CfZDYz99AzT8cR2VDkxEnI3Lfu/aP87FZ1k853RsF
   GFs1rYD8AMpCwfHbpOTLM+Y/b3GdTCjKag8nLIKZ79CHx+aUGEhBdlp75
   oDFW86KALQVjH6N0MWTRuWO887jb5hvZ0X+cXZ4PPnlyUYKXfGsgv/I6x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13854512"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="13854512"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 06:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937028098"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937028098"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2024 06:58:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AACA838F; Sun, 25 Feb 2024 16:58:46 +0200 (EET)
Date: Sun, 25 Feb 2024 16:58:46 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <3nqc34o54ydpdvo6j7a5hltyjs6kkw5jy5i6dgvivg7f4hzec2@l6jetcopnm6k>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-11-kirill.shutemov@linux.intel.com>
 <a14bda4a-15ad-4d20-8b60-0ab92b608f2f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a14bda4a-15ad-4d20-8b60-0ab92b608f2f@intel.com>

On Fri, Feb 23, 2024 at 11:39:07AM -0800, Dave Hansen wrote:
> On 2/12/24 02:44, Kirill A. Shutemov wrote:
> > +static void tdx_kexec_stop_conversion(bool crash)
> > +{
> > +	/* Stop new private<->shared conversions */
> > +	conversion_allowed = false;
> > +
> > +	/*
> > +	 * Make sure conversion_allowed is cleared before checking
> > +	 * conversions_in_progress.
> > +	 */
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
> 
> I'd really prefer we find a way to do this with actual locks, especially
> 'conversion_allowed'.
> 
> This is _awfully_ close to being able to be handled by a rwsem where the
> readers are the converters and tdx_kexec_stop_conversion() takes a write.

Okay, here's what I come up with. It needs more testing.

Any comments?

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index fd212c9bad89..5eb0dac33f37 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -6,8 +6,10 @@
 
 #include <linux/cpufeature.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/kexec.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -15,6 +17,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/set_memory.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -837,6 +840,65 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return 0;
 }
 
+static void tdx_kexec_stop_conversion(bool crash)
+{
+	/* Stop new private<->shared conversions */
+	if (!stop_memory_enc_conversion(!crash))
+		pr_warn("Failed to finish shared<->private conversions\n");
+}
+
+static void tdx_kexec_unshare_mem(void)
+{
+	unsigned long addr, end;
+	long found = 0, shared;
+
+	/*
+	 * Walk direct mapping and convert all shared memory back to private,
+	 */
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		if (pte && pte_decrypted(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			/*
+			 * Touching memory with shared bit set triggers implicit
+			 * conversion to shared.
+			 *
+			 * Make sure nobody touches the shared range from
+			 * now on.
+			 */
+			set_pte(pte, __pte(0));
+
+			if (!tdx_enc_status_changed(addr, pages, true)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+			found += pages;
+		}
+
+		addr += size;
+	}
+
+	__flush_tlb_all();
+
+	shared = atomic_long_read(&nr_shared);
+	if (shared != found) {
+		pr_err("shared page accounting is off\n");
+		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
+	}
+}
+
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -896,6 +958,9 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
+	x86_platform.guest.enc_kexec_stop_conversion = tdx_kexec_stop_conversion;
+	x86_platform.guest.enc_kexec_unshare_mem     = tdx_kexec_unshare_mem;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index a5e89641bd2d..9d4a8e548820 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -48,8 +48,11 @@ int set_memory_wc(unsigned long addr, int numpages);
 int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
+
+bool stop_memory_enc_conversion(bool wait);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 0d2267ad4e0e..e074b2aca970 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2176,12 +2176,32 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	return ret;
 }
 
+static DECLARE_RWSEM(mem_enc_lock);
+
+bool stop_memory_enc_conversion(bool wait)
+{
+	if (!wait)
+		return down_write_trylock(&mem_enc_lock);
+
+	down_write(&mem_enc_lock);
+
+	return true;
+}
+
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return __set_memory_enc_pgtable(addr, numpages, enc);
+	int ret = 0;
 
-	return 0;
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+		if (!down_read_trylock(&mem_enc_lock))
+			return -EBUSY;
+
+		ret =__set_memory_enc_pgtable(addr, numpages, enc);
+
+		up_read(&mem_enc_lock);
+	}
+
+	return ret;
 }
 
 int set_memory_encrypted(unsigned long addr, int numpages)
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

