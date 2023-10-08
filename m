Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C257BCD38
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjJHIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjJHIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D25CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696754135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=352kDl40f80i/CQnejiJXg2d98aXFfeMUDSAJFRyzsU=;
        b=iO3NaSGxomMtMUtgsOoA6xy9ldzvy5UDkAWDKOGDliBey4/tLbcQIWcyhoSouAWdiRbL/b
        /dW7oO3Uzd9sUpDauG5THO21tRUjHQBq9N4WlUV1mB2LpuFIBHYP8ak7EEeMS6777hAIg/
        OjTwp3PlAfhiDM/580Uwm+JB/GD5coU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-Tf4rPfv6NUG0JBlzajMs1w-1; Sun, 08 Oct 2023 04:35:32 -0400
X-MC-Unique: Tf4rPfv6NUG0JBlzajMs1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC5AF3800E97;
        Sun,  8 Oct 2023 08:35:31 +0000 (UTC)
Received: from localhost (unknown [10.72.112.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D54440C6EA8;
        Sun,  8 Oct 2023 08:35:29 +0000 (UTC)
Date:   Sun, 8 Oct 2023 16:35:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
Message-ID: <ZSJpzw2e7KgtJAZy@MiWiFi-R3L-srv>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/23 at 04:13pm, Kirill A. Shutemov wrote:
> TDX guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
> 
> The target kernel has no idea what memory is converted this way. It only
      ~~~~~~~~~~~~~
> sees E820_TYPE_RAM.

I finally realized it means the 2nd kernel of kexec rebooting. Maybe we
can call it 2nd kernel always, it works for both kexec and kdump
jumping. 

> 
> Accessing shared memory via private mapping is fatal. It leads to
> unrecoverable TD exit.
> 
> On TD shutdown (also covers kexec), walk direct mapping and convert all
> shared memory back to private. It makes all RAM private again and target
> kernel may use it normally.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/Kconfig          |   1 +
>  arch/x86/coco/tdx/kexec.c |   0
>  arch/x86/coco/tdx/tdx.c   | 137 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 136 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/coco/tdx/kexec.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7368d254d01f..b5acf9fb4c70 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
>  	select X86_MEM_ENCRYPT
>  	select X86_MCE
>  	select UNACCEPTED_MEMORY
> +	select EMERGENCY_VIRT_CALLBACK
>  	help
>  	  Support running as a guest under Intel TDX.  Without this support,
>  	  the guest kernel can not boot or run under TDX.
> diff --git a/arch/x86/coco/tdx/kexec.c b/arch/x86/coco/tdx/kexec.c
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 56e152126f20..ac0745303983 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/cpufeature.h>
>  #include <linux/debugfs.h>
> +#include <linux/delay.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <asm/coco.h>
> @@ -14,6 +15,8 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/pgtable.h>
> +#include <asm/reboot.h>
> +#include <asm/set_memory.h>
>  
>  /* MMIO direction */
>  #define EPT_READ	0
> @@ -40,6 +43,9 @@
>  
>  static atomic_long_t nr_shared;
>  
> +static atomic_t conversions_in_progress;
> +static bool conversion_allowed = true;
> +
>  static inline bool pte_decrypted(pte_t pte)
>  {
>  	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> @@ -704,6 +710,14 @@ static bool tdx_tlb_flush_required(bool private)
>  
>  static bool tdx_cache_flush_required(void)
>  {
> +	/*
> +	 * Avoid issuing CLFLUSH on set_memory_decrypted() if conversions
> +	 * stopped. Otherwise it can race with unshare_all_memory() and trigger
> +	 * implicit conversion to shared.
> +	 */
> +	if (!conversion_allowed)
> +		return false;
> +
>  	/*
>  	 * AMD SME/SEV can avoid cache flushing if HW enforces cache coherence.
>  	 * TDX doesn't have such capability.
> @@ -787,12 +801,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
>  					 bool enc)
>  {
> +	atomic_inc(&conversions_in_progress);
> +
> +	/*
> +	 * Check after bumping conversions_in_progress to serialize
> +	 * against tdx_shutdown().
> +	 */
> +	if (!conversion_allowed) {
> +		atomic_dec(&conversions_in_progress);
> +		return -EBUSY;
> +	}
> +
>  	/*
>  	 * Only handle shared->private conversion here.
>  	 * See the comment in tdx_early_init().
>  	 */
> -	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> +	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
> +		atomic_dec(&conversions_in_progress);
>  		return -EIO;
> +	}
>  
>  	return 0;
>  }
> @@ -804,17 +831,115 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>  	 * Only handle private->shared conversion here.
>  	 * See the comment in tdx_early_init().
>  	 */
> -	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> +	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
> +		atomic_dec(&conversions_in_progress);
>  		return -EIO;
> +	}
>  
>  	if (enc)
>  		atomic_long_sub(numpages, &nr_shared);
>  	else
>  		atomic_long_add(numpages, &nr_shared);
>  
> +	atomic_dec(&conversions_in_progress);
> +
>  	return 0;
>  }
>  
> +static void unshare_all_memory(bool unmap)
> +{
> +	unsigned long addr, end;
> +	long found = 0, shared;
> +
> +	/*
> +	 * Walk direct mapping and convert all shared memory back to private,
> +	 */
> +
> +	addr = PAGE_OFFSET;
> +	end  = PAGE_OFFSET + get_max_mapped();
> +
> +	while (addr < end) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		pte = lookup_address(addr, &level);
> +		size = page_level_size(level);
> +
> +		if (pte && pte_decrypted(*pte)) {
> +			int pages = size / PAGE_SIZE;
> +
> +			/*
> +			 * Touching memory with shared bit set triggers implicit
> +			 * conversion to shared.
> +			 *
> +			 * Make sure nobody touches the shared range from
> +			 * now on.
> +			 *
> +			 * Bypass unmapping for crash scenario. Unmapping
> +			 * requires sleepable context, but in crash case kernel
> +			 * hits the code path with interrupts disabled.
> +			 * It shouldn't be a problem as all secondary CPUs are
> +			 * down and kernel runs with interrupts disabled, so
> +			 * there is no room for race.
> +			 */
> +			if (unmap)
> +				set_memory_np(addr, pages);
> +
> +			if (!tdx_enc_status_changed(addr, pages, true)) {
> +				pr_err("Failed to unshare range %#lx-%#lx\n",
> +				       addr, addr + size);
> +			}
> +
> +			found += pages;
> +		}
> +
> +		addr += size;
> +	}
> +
> +	shared = atomic_long_read(&nr_shared);
> +	if (shared != found) {
> +		pr_err("shared page accounting is off\n");
> +		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
> +	}
> +}
> +
> +static void tdx_shutdown(void)
> +{
> +	unsigned long timeout;
> +
> +	/*
> +	 * Stop new private<->shared conversions and wait for in-flight
> +	 * conversions to complete.
> +	 *
> +	 * Do not wait more than 30 seconds.
> +	 */
> +	timeout = 30 * USEC_PER_SEC;
> +	conversion_allowed = false;
> +	while (atomic_read(&conversions_in_progress) && timeout--)
> +		udelay(1);
> +
> +	if (!timeout)
> +		pr_warn("Failed to finish shared<->private conversions\n");
> +
> +	unshare_all_memory(true);
> +
> +	native_machine_shutdown();
> +}
> +
> +static void tdx_crash_shutdown(void)
> +{
> +	/*
> +	 * Crash can race with private<->shared conversion.
> +	 *
> +	 * There's no clean way out: report and proceed.
> +	 */
> +	if (atomic_read(&conversions_in_progress))
> +		pr_warn("Failed to finish shared<->private conversions\n");
> +
> +	unshare_all_memory(false);
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	struct tdx_module_args args = {
> @@ -882,6 +1007,14 @@ void __init tdx_early_init(void)
>  	 */
>  	x86_cpuinit.parallel_bringup = false;
>  
> +	machine_ops.shutdown = tdx_shutdown;
> +
> +	/*
> +	 * KVM overrides machine_ops.crash_shutdown, use emergency
> +	 * virt callback instead.
> +	 */
> +	cpu_emergency_register_virt_callback(tdx_crash_shutdown);
> +
>  	pr_info("Guest detected\n");
>  }
>  
> -- 
> 2.41.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

