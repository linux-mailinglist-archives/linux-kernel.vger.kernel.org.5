Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD37BBEC7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjJFSdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjJFSdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:33:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D4BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696617227; x=1728153227;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LLZX7zRwrS6v1TQS+z2JHoWVTzAPsFpDcoMbYNf7c0Y=;
  b=VkvbEjPBMg6bSpQGAZoAVA6nB1nq7d7YG60nUOIZWxnOzmbs3+NPC3ge
   XyE9hLkp4BTFY3XJgOoKx/sVKM1O+tgztQLUrqsxE0ihD/qTXkppGCp+h
   oW4LHbJVmkBg9RDOo6ASCEMjVVXKkUPPI2b3nP4Y4iXQi3FSeEiFjnHn1
   zY5oHGacHPZ7jLRFjrUiaFlMwTyqolDmdTQWO7yToB5KBeDVXvAGEdtbW
   dxc/TpyC6auwOFXYCJUULJ07Y7RYN8OeXeAbcpD0LAkOv27WaLdBPclJQ
   aHcz48GA1lf1fuTs9AHtTgVtKLFBrK9iveHu3lR5USYqpVA4F4Xitm2X1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387688600"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387688600"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 11:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745950981"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745950981"
Received: from wangz2-mobl.amr.corp.intel.com (HELO [10.209.88.26]) ([10.209.88.26])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 11:33:46 -0700
Message-ID: <2be8a356-79c8-49a0-ba93-2a92df119af3@linux.intel.com>
Date:   Fri, 6 Oct 2023 11:33:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-2-kirill.shutemov@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231005131402.14611-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
> In order to prepare for the expansion of support for the ACPI MADT
> wakeup method, the relevant code has been moved into a separate file.
> A new configuration option has been introduced to clearly indicate
> dependencies without the use of ifdefs.
> 
> There have been no functional changes.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/Kconfig                   |  7 +++
>  arch/x86/include/asm/acpi.h        |  5 ++
>  arch/x86/kernel/acpi/Makefile      | 11 ++--
>  arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
>  arch/x86/kernel/acpi/madt_wakeup.c | 80 +++++++++++++++++++++++++++
>  5 files changed, 99 insertions(+), 90 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3154dbc49cf5..7368d254d01f 100644
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
> index c8a7fc23f63c..b536b5a6a57b 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -73,6 +73,11 @@ static inline bool acpi_skip_set_wakeup_address(void)
>  
>  #define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
>  
> +union acpi_subtable_headers;
> +
> +int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +			      const unsigned long end);
> +

IMO, you don't need to declare acpi_parse_mp_wake() in asm/acpi.h. Since the
only user of this function is in arch/x86/kernel/acpi, you can either create
a header file there or re-use sleep.h.

If you want to leave it here, do you want to protect it with
CONFIG_X86_ACPI_MADT_WAKEUP?


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
