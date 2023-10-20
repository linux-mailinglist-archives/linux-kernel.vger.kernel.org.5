Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67397D0FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377308AbjJTMe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377079AbjJTMe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:34:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DB193
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697805265; x=1729341265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KbNvs0px0D1QU2CACqrpgox2LilZmVWe6/Qr9SDWOLU=;
  b=kSML7rlSrK4lEcL+LDwonLwZ6CHHeAcmIvY46FLwgHUA0xh1SEBn73Gu
   O/mOoW110rWjeLkb7CkOQGuja9OZVj0hhHxJTodSSCoI/yFnP6Hxxbfow
   NWQUImN4xbd91bUBv88Zi8h94dtgGBLRv2rM5Yu8FT9XxcfJo0wypBoGn
   cKZdmV+DwDIbyzTPY7xeI/TK+ri90KXrIF7NA14ksl0CiiWDOZlr4YgMx
   mddnkKDNGKN/kpXOxpfeuhstPzV/1mIUXqkCJz3wi9x7wbCpWhKarl0Mh
   vFuD/fMJoxKVLpHzA1y7QxRBL/hLnUqtS5qNz+Ky2gasxlaQR/NME31Md
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="371559980"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="371559980"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="873891358"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873891358"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:34:20 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0249010A1C7; Fri, 20 Oct 2023 15:34:17 +0300 (+03)
Date:   Fri, 20 Oct 2023 15:34:17 +0300
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
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231020123417.2577fm526juwggkf@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-14-kirill.shutemov@linux.intel.com>
 <e4cf5fbf384a14b06034667d62bb6cb85ec64305.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4cf5fbf384a14b06034667d62bb6cb85ec64305.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:21:34AM +0000, Huang, Kai wrote:
> 
> > --- /dev/null
> > +++ b/arch/x86/kernel/acpi/madt.S
> > @@ -0,0 +1,28 @@
> > +#include <linux/linkage.h>
> > +#include <asm/nospec-branch.h>
> > +#include <asm/page_types.h>
> > +#include <asm/processor-flags.h>
> > +
> > +	.text
> > +	.align PAGE_SIZE
> > +SYM_FUNC_START(asm_acpi_mp_play_dead)
> > +	/* Load address of reset vector into RCX to jump when kernel is ready */
> > +	movq	acpi_mp_reset_vector_paddr(%rip), %rcx
> > +
> > +	/* zero out flags, and disable interrupts */
> > +	pushq	$0
> > +	popfq
> > +
> > +	/* Turn off global entries. Following CR3 write will flush them. */
> > +	movq	%cr4, %rdx
> > +	andq	$~(X86_CR4_PGE), %rdx
> > +	movq	%rdx, %cr4
> > +
> > +	/* Switch to identity mapping */
> > +	movq	acpi_mp_pgd(%rip), %rax
> > +	movq	%rax, %cr3
> > +
> > +	/* Jump to reset vector */
> > +	ANNOTATE_RETPOLINE_SAFE
> > +	jmp	*%rcx
> > +SYM_FUNC_END(asm_acpi_mp_play_dead)
> > diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> > index 4e92d1d4a5fa..2cc8590ec7a5 100644
> > --- a/arch/x86/kernel/acpi/madt_wakeup.c
> > +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> > @@ -1,12 +1,162 @@
> >  #include <linux/acpi.h>
> >  #include <linux/cpu.h>
> > +#include <linux/delay.h>
> > +#include <linux/memblock.h>
> > +#include <linux/pgtable.h>
> > +#include <linux/sched/hotplug.h>
> >  #include <asm/apic.h>
> > +#include <asm/init.h>
> >  
> >  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> >  static u64 acpi_mp_wake_mailbox_paddr;
> >  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> >  static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> >  
> > +unsigned long acpi_mp_pgd;
> > +u64 acpi_mp_reset_vector_paddr;
> 
> Nit: 
> 
> They are both physical address.  It's a little bit odd for one to use 'unsigned
> long' and the other to use 'u64'.

Okay, I will make them both u64.

> > +
> > +void asm_acpi_mp_play_dead(void);
> > +
> > +static void __init *alloc_pgt_page(void *context)
> > +{
> > +	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +}
> 
> If I am reading correclty, @context is never used.  It's not used inside this
> function, and all the callers call this with @context = NULL.

Yes. We need the argument to conform to x86_mapping_info::alloc_pgt_page
interface.

> > +
> > +static void acpi_mp_play_dead(void)
> > +{
> > +	idle_task_exit();
> > +	cpuhp_ap_report_dead();
> > +	asm_acpi_mp_play_dead();
> > +}
> > +
> 
> Looks you can use play_dead_common() here, if you take IRQ disable part out from
> the assembly, because play_dead_common() does:
> 
> void play_dead_common(void)
> {               
>         idle_task_exit();
>                 
>         cpuhp_ap_report_dead();                                                
>         
>         local_irq_disable();                                                   
> }

Okay, fair enough.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
