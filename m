Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACAB7BD157
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 01:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbjJHXuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 19:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbjJHXub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94047A6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696808985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/FSsorDmZKU+/zY1HOQ2lNG7L371+F5BVushkgG18HA=;
        b=Kt5cxSxJhsoQK6ZSmPMLoUmtv7Kx6kUqmpq7zO4IT731V2lXapqhOR6lyqTwlUdRli2xPW
        L6XJHHQkQh5n5cVNozJs10kIpTk/NIx4BoiHEIGki9hula9bQXVAU2XRmYz0W7jK9X+TVa
        0Rx+ZW+4qDU9J0wBYL398QIULXKQyvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-5H4jcVNROd2KF-WL1XMDcA-1; Sun, 08 Oct 2023 19:49:40 -0400
X-MC-Unique: 5H4jcVNROd2KF-WL1XMDcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D05C9802C1A;
        Sun,  8 Oct 2023 23:49:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14558140E953;
        Sun,  8 Oct 2023 23:49:38 +0000 (UTC)
Date:   Mon, 9 Oct 2023 07:49:35 +0800
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
Subject: Re: [PATCH 00/13] x86/tdx: Add kexec support
Message-ID: <ZSNADxBZEDyxEnZ4@MiWiFi-R3L-srv>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/23 at 04:13pm, Kirill A. Shutemov wrote:
> The patchset adds bits and pieces to get kexec (and crashkernel) work on
> TDX guest.
> 
> They bring kexec support to the point when we can start the new kernel,
> but it will only be able to use single CPU. It should be enough to cover
> the most common case: crashkernel.

Not sure if this question has been raised and answered in the past. Please
forgive my bad memory if it has. The one cpu is fine to kdump kernel most
of time, while we enable all CPUs by default when kexec rebooting. And kdump
kernel with multiple cpu is allowed too. Wondering if there's plan to
support the multiple cpu on TDX in the future.

Thanks
Baoquan

> 
> The last patch implements CPU offlining according to the approved ACPI
> spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> kernel.
> 
> Please review. I would be glad for any feedback.
> 
> [1] https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher
> 
> Kirill A. Shutemov (13):
>   x86/acpi: Extract ACPI MADT wakeup code into a separate file
>   kernel/cpu: Add support for declaring CPU hotplug not supported
>   cpu/hotplug, x86/acpi: Disable CPU hotplug for ACPI MADT wakeup
>   x86/kvm: Do not try to disable kvmclock if it was not enabled
>   x86/kexec: Keep CR4.MCE set during kexec for TDX guest
>   x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
>   x86/mm: Return correct level from lookup_address() if pte is none
>   KVM: x86: Add config option to gate emergency virt callback support
>   x86/tdx: Account shared memory
>   x86/tdx: Convert shared memory back to private on kexec
>   x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
>   x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
>   x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method
> 
>  arch/x86/Kconfig                     |   8 +
>  arch/x86/coco/core.c                 |   1 -
>  arch/x86/coco/tdx/kexec.c            |   0
>  arch/x86/coco/tdx/tdx.c              | 220 +++++++++++++++++++++-
>  arch/x86/hyperv/ivm.c                |   9 +-
>  arch/x86/include/asm/acpi.h          |   5 +
>  arch/x86/include/asm/pgtable_types.h |   1 +
>  arch/x86/include/asm/reboot.h        |   4 +-
>  arch/x86/include/asm/x86_init.h      |   4 +-
>  arch/x86/kernel/acpi/Makefile        |  11 +-
>  arch/x86/kernel/acpi/boot.c          |  88 +--------
>  arch/x86/kernel/acpi/madt.S          |  28 +++
>  arch/x86/kernel/acpi/madt_wakeup.c   | 262 +++++++++++++++++++++++++++
>  arch/x86/kernel/e820.c               |   9 +-
>  arch/x86/kernel/kvmclock.c           |   9 +-
>  arch/x86/kernel/reboot.c             |   4 +-
>  arch/x86/kernel/relocate_kernel_64.S |   5 +
>  arch/x86/kernel/x86_init.c           |   4 +-
>  arch/x86/kvm/Kconfig                 |   5 +
>  arch/x86/mm/mem_encrypt_amd.c        |   8 +-
>  arch/x86/mm/pat/set_memory.c         |  17 +-
>  include/acpi/actbl2.h                |  19 +-
>  include/linux/cc_platform.h          |  10 -
>  include/linux/cpu.h                  |   2 +
>  kernel/cpu.c                         |  17 +-
>  25 files changed, 604 insertions(+), 146 deletions(-)
>  create mode 100644 arch/x86/coco/tdx/kexec.c
>  create mode 100644 arch/x86/kernel/acpi/madt.S
>  create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c
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

