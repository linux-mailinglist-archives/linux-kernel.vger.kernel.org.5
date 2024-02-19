Return-Path: <linux-kernel+bounces-70713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C19859B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041122817C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53511CF91;
	Mon, 19 Feb 2024 04:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQNB8gi2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1F1C2BC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708317943; cv=none; b=baGuG8bCbXuT5M9L5sU9FfkMlCz0sBCovoYQ6WhcAiu/0mrbQlwoBvSrYb58qzIbDawXnEmFdMi3cz/lxXeqI2+p9F59RQHqhW9E4azaF0JiTCUfdKccngryJOK5O4nPjV6uKJRP0Wv6xQbrP2og8I1xakJ9hoNG1iLVsZZjZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708317943; c=relaxed/simple;
	bh=48Mm4NCP4+SYNvsqwlHZD2dNY1yaOq5BSi4q0cWrrec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSQACvqDrl8Xy9poaQUx+z2lddvZWPPvGXCMDRAv4xVMHUiOJhnh+Am0VzVK7j2kI0F/sXyCStfLux8Sj0GH5oLB7oP5xCCIvY028PXqhdG6Fx9RLuaAtDy7DFHagLcbSaRFaa9tzIo1cwcMB1DKi6jMYKpn21BBGcvwZnn/8PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQNB8gi2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708317940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+CSJZ7Mf24H9r788Q3To198U/mbP/oA5rZIZAQSTkg=;
	b=XQNB8gi2QrWkiagQiNb9J8Adoaoqv/OxDjCsUMbvELT+EoQf09IBjeAyT98WIBm/eH+W87
	bz63upJJp/WoOQi3XXZuJvPztOxwRyojH4SbjFtr5hP919S8A7uSsN3MhFcVGiyqPXejBU
	/s1FtnC8574+kbF7j1aSpW4o2KIWTM8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-qOtQD3RqPTO_wxKt9r_inQ-1; Sun,
 18 Feb 2024 23:45:37 -0500
X-MC-Unique: qOtQD3RqPTO_wxKt9r_inQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E1833C025C3;
	Mon, 19 Feb 2024 04:45:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B45A2022AAC;
	Mon, 19 Feb 2024 04:45:34 +0000 (UTC)
Date: Mon, 19 Feb 2024 12:45:31 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 01/16] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <ZdLc61QMLu3L0Eqv@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/12/24 at 12:44pm, Kirill A. Shutemov wrote:
> In order to prepare for the expansion of support for the ACPI MADT
> wakeup method, move the relevant code into a separate file.
> 
> Introduce a new configuration option to clearly indicate dependencies
> without the use of ifdefs.
> 
> There have been no functional changes.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> ---
>  arch/x86/Kconfig                   |  7 +++
>  arch/x86/include/asm/acpi.h        |  5 ++
>  arch/x86/kernel/acpi/Makefile      | 11 ++--
>  arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
>  arch/x86/kernel/acpi/madt_wakeup.c | 82 ++++++++++++++++++++++++++++
>  5 files changed, 101 insertions(+), 90 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b9bf..1c1c06f6c0f1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1108,6 +1108,13 @@ config X86_LOCAL_APIC
>  	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
>  	select IRQ_DOMAIN_HIERARCHY
>  
> +config X86_ACPI_MADT_WAKEUP
> +	def_bool y
> +	depends on X86_64
> +	depends on ACPI
> +	depends on SMP
> +	depends on X86_LOCAL_APIC
> +
>  config X86_IO_APIC
>  	def_bool y
>  	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index f896eed4516c..2625b915ae7f 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -76,6 +76,11 @@ static inline bool acpi_skip_set_wakeup_address(void)
>  
>  #define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
>  
> +union acpi_subtable_headers;
> +
> +int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +			      const unsigned long end);
> +
>  /*
>   * Check if the CPU can handle C2 and deeper
>   */
> diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
> index fc17b3f136fe..8c7329c88a75 100644
> --- a/arch/x86/kernel/acpi/Makefile
> +++ b/arch/x86/kernel/acpi/Makefile
> @@ -1,11 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-$(CONFIG_ACPI)		+= boot.o
> -obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
> -obj-$(CONFIG_ACPI_APEI)		+= apei.o
> -obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc.o
> +obj-$(CONFIG_ACPI)			+= boot.o
> +obj-$(CONFIG_ACPI_SLEEP)		+= sleep.o wakeup_$(BITS).o
> +obj-$(CONFIG_ACPI_APEI)			+= apei.o
> +obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
> +obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
>  
>  ifneq ($(CONFIG_ACPI_PROCESSOR),)
> -obj-y				+= cstate.o
> +obj-y					+= cstate.o
>  endif
>  
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 85a3ce2a3666..df3384dc42c7 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -67,13 +67,6 @@ static bool has_lapic_cpus __initdata;
>  static bool acpi_support_online_capable;
>  #endif
>  
> -#ifdef CONFIG_X86_64
> -/* Physical address of the Multiprocessor Wakeup Structure mailbox */
> -static u64 acpi_mp_wake_mailbox_paddr;
> -/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> -static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> -#endif
> -
>  #ifdef CONFIG_X86_IO_APIC
>  /*
>   * Locks related to IOAPIC hotplug
> @@ -370,60 +363,6 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
>  
>  	return 0;
>  }
> -
> -#ifdef CONFIG_X86_64
> -static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> -{
> -	/*
> -	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
> -	 *
> -	 * Wakeup of secondary CPUs is fully serialized in the core code.
> -	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
> -	 */
> -	if (!acpi_mp_wake_mailbox) {
> -		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> -						sizeof(*acpi_mp_wake_mailbox),
> -						MEMREMAP_WB);
> -	}
> -
> -	/*
> -	 * Mailbox memory is shared between the firmware and OS. Firmware will
> -	 * listen on mailbox command address, and once it receives the wakeup
> -	 * command, the CPU associated with the given apicid will be booted.
> -	 *
> -	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
> -	 * firmware before the wakeup command is visible.  smp_store_release()
> -	 * ensures ordering and visibility.
> -	 */
> -	acpi_mp_wake_mailbox->apic_id	    = apicid;
> -	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
> -	smp_store_release(&acpi_mp_wake_mailbox->command,
> -			  ACPI_MP_WAKE_COMMAND_WAKEUP);
> -
> -	/*
> -	 * Wait for the CPU to wake up.
> -	 *
> -	 * The CPU being woken up is essentially in a spin loop waiting to be
> -	 * woken up. It should not take long for it wake up and acknowledge by
> -	 * zeroing out ->command.
> -	 *
> -	 * ACPI specification doesn't provide any guidance on how long kernel
> -	 * has to wait for a wake up acknowledgement. It also doesn't provide
> -	 * a way to cancel a wake up request if it takes too long.
> -	 *
> -	 * In TDX environment, the VMM has control over how long it takes to
> -	 * wake up secondary. It can postpone scheduling secondary vCPU
> -	 * indefinitely. Giving up on wake up request and reporting error opens
> -	 * possible attack vector for VMM: it can wake up a secondary CPU when
> -	 * kernel doesn't expect it. Wait until positive result of the wake up
> -	 * request.
> -	 */
> -	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> -		cpu_relax();
> -
> -	return 0;
> -}
> -#endif /* CONFIG_X86_64 */
>  #endif /* CONFIG_X86_LOCAL_APIC */
>  
>  #ifdef CONFIG_X86_IO_APIC
> @@ -1159,29 +1098,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
>  	}
>  	return 0;
>  }
> -
> -#ifdef CONFIG_X86_64
> -static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> -				     const unsigned long end)
> -{
> -	struct acpi_madt_multiproc_wakeup *mp_wake;
> -
> -	if (!IS_ENABLED(CONFIG_SMP))
> -		return -ENODEV;
> -
> -	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> -	if (BAD_MADT_ENTRY(mp_wake, end))
> -		return -EINVAL;
> -
> -	acpi_table_print_madt_entry(&header->common);
> -
> -	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> -
> -	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> -
> -	return 0;
> -}
> -#endif				/* CONFIG_X86_64 */
>  #endif				/* CONFIG_X86_LOCAL_APIC */
>  
>  #ifdef	CONFIG_X86_IO_APIC
> @@ -1378,7 +1294,7 @@ static void __init acpi_process_madt(void)
>  				smp_found_config = 1;
>  			}
>  
> -#ifdef CONFIG_X86_64
> +#ifdef CONFIG_X86_ACPI_MADT_WAKEUP
>  			/*
>  			 * Parse MADT MP Wake entry.
>  			 */
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> new file mode 100644
> index 000000000000..7f164d38bd0b
> --- /dev/null
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/acpi.h>
> +#include <linux/io.h>
> +#include <asm/apic.h>
> +#include <asm/barrier.h>
> +#include <asm/processor.h>
> +
> +/* Physical address of the Multiprocessor Wakeup Structure mailbox */
> +static u64 acpi_mp_wake_mailbox_paddr;
> +
> +/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +
> +static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> +{
> +	/*
> +	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
> +	 *
> +	 * Wakeup of secondary CPUs is fully serialized in the core code.
> +	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
> +	 */
> +	if (!acpi_mp_wake_mailbox) {
> +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> +						sizeof(*acpi_mp_wake_mailbox),
> +						MEMREMAP_WB);
> +	}
> +
> +	/*
> +	 * Mailbox memory is shared between the firmware and OS. Firmware will
> +	 * listen on mailbox command address, and once it receives the wakeup
> +	 * command, the CPU associated with the given apicid will be booted.
> +	 *
> +	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
> +	 * firmware before the wakeup command is visible.  smp_store_release()
> +	 * ensures ordering and visibility.
> +	 */
> +	acpi_mp_wake_mailbox->apic_id	    = apicid;
> +	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
> +	smp_store_release(&acpi_mp_wake_mailbox->command,
> +			  ACPI_MP_WAKE_COMMAND_WAKEUP);
> +
> +	/*
> +	 * Wait for the CPU to wake up.
> +	 *
> +	 * The CPU being woken up is essentially in a spin loop waiting to be
> +	 * woken up. It should not take long for it wake up and acknowledge by
> +	 * zeroing out ->command.
> +	 *
> +	 * ACPI specification doesn't provide any guidance on how long kernel
> +	 * has to wait for a wake up acknowledgment. It also doesn't provide
> +	 * a way to cancel a wake up request if it takes too long.
> +	 *
> +	 * In TDX environment, the VMM has control over how long it takes to
> +	 * wake up secondary. It can postpone scheduling secondary vCPU
> +	 * indefinitely. Giving up on wake up request and reporting error opens
> +	 * possible attack vector for VMM: it can wake up a secondary CPU when
> +	 * kernel doesn't expect it. Wait until positive result of the wake up
> +	 * request.
> +	 */
> +	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> +		cpu_relax();
> +
> +	return 0;
> +}
> +
> +int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +			      const unsigned long end)
> +{
> +	struct acpi_madt_multiproc_wakeup *mp_wake;
> +
> +	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> +	if (BAD_MADT_ENTRY(mp_wake, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(&header->common);

Do we need add the entry printing for ACPI_MADT_TYPE_MULTIPROC_WAKEUP
now in acpi_table_print_madt_entry()? Surely it's not related to this
patch.

FWIW, 

Reviewed-by: Baoquan He <bhe@redhat.com>

> +
> +	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> +
> +	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> +
> +	return 0;
> +}
> -- 
> 2.43.0
> 


