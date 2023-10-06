Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06497BB71D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjJFMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjJFMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:00:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F14CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696593635; x=1728129635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yh5MuiZGQXQ6liK7/Tt2HXhGriUga9iujO4PJpKEKQU=;
  b=S8Ewy1qif1xLB61TmBLQiNJ/1BaUVkLTu98fOb179NRi2ZdsDW8NhbTF
   gmPZxoHUBTdaPOdzSNVHVhUGTNy92g5D68tCRemZOu1NLgLkKNdmuwb/c
   AzB9QSQMEZB7rquh0Eg/p6jkVY4rmeCfeXa/MtT92/xfZMXWxFeBDMbVC
   UvYElE5XfzM9+Z90MdX01AiMCNqZevolB/v/VGj8baPBtjkXNmMyNgyiF
   vW/l47k62SvWzRqn0cRsIq5JQjMsN2dCUNbyE4wMX5qjgv4cdZtN8vzN+
   dJUqy20Uy4/LNTJGOzgY9va1yPqj4zA/fxBeI8ssrYv5WJUYpbxfW7UhK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="414732558"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="414732558"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 04:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083426786"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="1083426786"
Received: from kvsudesh-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.251.222.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 04:59:39 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2368510A12D; Fri,  6 Oct 2023 14:59:37 +0300 (+03)
Date:   Fri, 6 Oct 2023 14:59:37 +0300
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
Subject: Re: [PATCH 01/13] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <20231006115937.js5zkqlbqyv3venr@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-2-kirill.shutemov@linux.intel.com>
 <e11888bc9775a8083b72cce8c58ee71b39d0e17f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e11888bc9775a8083b72cce8c58ee71b39d0e17f.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:22:54AM +0000, Huang, Kai wrote:
> On Thu, 2023-10-05 at 16:13 +0300, Kirill A. Shutemov wrote:
> > In order to prepare for the expansion of support for the ACPI MADT
> > wakeup method, the relevant code has been moved into a separate file.
> > A new configuration option has been introduced to clearly indicate
> > dependencies without the use of ifdefs.
> 
> Use imperative mood? �
> 
> - Move the relevant code into ...
> - Introduce a new configuration option to ...

Okay.

> > There have been no functional changes.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/Kconfig                   |  7 +++
> >  arch/x86/include/asm/acpi.h        |  5 ++
> >  arch/x86/kernel/acpi/Makefile      | 11 ++--
> >  arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
> >  arch/x86/kernel/acpi/madt_wakeup.c | 80 +++++++++++++++++++++++++++
> >  5 files changed, 99 insertions(+), 90 deletions(-)
> >  create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 3154dbc49cf5..7368d254d01f 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1108,6 +1108,13 @@ config X86_LOCAL_APIC
> >  	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
> >  	select IRQ_DOMAIN_HIERARCHY
> >  
> > +config X86_ACPI_MADT_WAKEUP
> > +	def_bool y
> > +	depends on X86_64
> > +	depends on ACPI
> > +	depends on SMP
> > +	depends on X86_LOCAL_APIC
> > +
> >  config X86_IO_APIC
> >  	def_bool y
> >  	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
> > diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> > index c8a7fc23f63c..b536b5a6a57b 100644
> > --- a/arch/x86/include/asm/acpi.h
> > +++ b/arch/x86/include/asm/acpi.h
> > @@ -73,6 +73,11 @@ static inline bool acpi_skip_set_wakeup_address(void)
> >  
> >  #define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
> >  
> > +union acpi_subtable_headers;
> > +
> > +int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> > +			      const unsigned long end);
> > +
> >  /*
> >   * Check if the CPU can handle C2 and deeper
> >   */
> > diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
> > index fc17b3f136fe..8c7329c88a75 100644
> > --- a/arch/x86/kernel/acpi/Makefile
> > +++ b/arch/x86/kernel/acpi/Makefile
> > @@ -1,11 +1,12 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > -obj-$(CONFIG_ACPI)		+= boot.o
> > -obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
> > -obj-$(CONFIG_ACPI_APEI)		+= apei.o
> > -obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc.o
> > +obj-$(CONFIG_ACPI)			+= boot.o
> > +obj-$(CONFIG_ACPI_SLEEP)		+= sleep.o wakeup_$(BITS).o
> > +obj-$(CONFIG_ACPI_APEI)			+= apei.o
> > +obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
> > +obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
> >  
> >  ifneq ($(CONFIG_ACPI_PROCESSOR),)
> > -obj-y				+= cstate.o
> > +obj-y					+= cstate.o
> >  endif
> 
> unintended code change?

No. It keeps += aligned as they are before the patch.
> 
> [...]
> 
> > 
> > diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> > new file mode 100644
> > index 000000000000..1b9747bfd5b9
> > --- /dev/null
> > +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> > @@ -0,0 +1,80 @@
> > +#include <linux/acpi.h>
> > +#include <asm/apic.h>
> 
> Functions like memremap(), smp_store_release() and cpu_relax() are used in this
> file.  Should we explicitly include the relevant headers?

Okay, will do.

> > +
> > +/* Physical address of the Multiprocessor Wakeup Structure mailbox */
> > +static u64 acpi_mp_wake_mailbox_paddr;
> > +/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> > +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> > +
> > +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> > +{
> > +	/*
> > +	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
> > +	 *
> > +	 * Wakeup of secondary CPUs is fully serialized in the core code.
> > +	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
> > +	 */
> > +	if (!acpi_mp_wake_mailbox) {
> > +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> > +						sizeof(*acpi_mp_wake_mailbox),
> > +						MEMREMAP_WB);
> > +	}
> > +
> > +	/*
> > +	 * Mailbox memory is shared between the firmware and OS. Firmware will
> > +	 * listen on mailbox command address, and once it receives the wakeup
> > +	 * command, the CPU associated with the given apicid will be booted.
> > +	 *
> > +	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
> > +	 * firmware before the wakeup command is visible.  smp_store_release()
> > +	 * ensures ordering and visibility.
> > +	 */
> > +	acpi_mp_wake_mailbox->apic_id	    = apicid;
> > +	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
> > +	smp_store_release(&acpi_mp_wake_mailbox->command,
> > +			  ACPI_MP_WAKE_COMMAND_WAKEUP);
> > +
> > +	/*
> > +	 * Wait for the CPU to wake up.
> > +	 *
> > +	 * The CPU being woken up is essentially in a spin loop waiting to be
> > +	 * woken up. It should not take long for it wake up and acknowledge by
> > +	 * zeroing out ->command.
> > +	 *
> > +	 * ACPI specification doesn't provide any guidance on how long kernel
> > +	 * has to wait for a wake up acknowledgement. It also doesn't provide
> > +	 * a way to cancel a wake up request if it takes too long.
> > +	 *
> > +	 * In TDX environment, the VMM has control over how long it takes to
> > +	 * wake up secondary. It can postpone scheduling secondary vCPU
> > +	 * indefinitely. Giving up on wake up request and reporting error opens
> > +	 * possible attack vector for VMM: it can wake up a secondary CPU when
> > +	 * kernel doesn't expect it. Wait until positive result of the wake up
> > +	 * request.
> > +	 */
> > +	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> > +		cpu_relax();
> > +
> > +	return 0;
> > +}
> > +
> > +int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> > +			      const unsigned long end)
> > +{
> > +	struct acpi_madt_multiproc_wakeup *mp_wake;
> > +
> > +	if (!IS_ENABLED(CONFIG_SMP))
> > +		return -ENODEV;
> 
> Now you have made X86_ACPI_MADT_WAKEUP depend on SMP, and this file will only be
> compiled when  X86_ACPI_MADT_WAKEUP is turned on.  IIUC this essentially means
> IS_ENABLED(CONFIG_SMP) will always report true?

Good catch. I didn't have 'depends SMP' initially, but it triggered build
issue, so I added it, but forgot to drop IS_ENABLED().

> > +
> > +	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> > +	if (BAD_MADT_ENTRY(mp_wake, end))
> > +		return -EINVAL;
> > +
> > +	acpi_table_print_madt_entry(&header->common);
> > +
> > +	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> > +
> > +	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> > +
> > +	return 0;
> > +}
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
