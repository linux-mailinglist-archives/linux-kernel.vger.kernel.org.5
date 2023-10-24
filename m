Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579467D538A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjJXOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343620AbjJXOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:00:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7BB10F1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698155999; x=1729691999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=19Oy+bqmRf+yUClsGgCA+JN8HHBfT2UMLSdlx7KWkc8=;
  b=eDuolphD5r61SBn2TmMP0DB1GCYOsirZR6aRlf7K7Q3LX9NJRFEry/ID
   UyPOStihIoHZFN2tSvps74FFuJ4XyXJysfWZgtKPS6fxegW6Eh9K6P5Fj
   KvZWI0/3ohIA+vshS2p15JRsvhEOa9MKW1sxNUih2icEYuWlPshXj509u
   P3JT1MbdOf+D88/G2WYO+IyGRNuONxpKGu8fbrxJ4EoY1ts4Ebfmv1lFo
   pA6lnsj2iL79uF5V8C8RjfdmN8q2rpX7v6Kxiz1If5FUsadG26+AT8YiX
   D1Zr3GRYYX1SzZfIjHQaF3DD8txFgMjpaukD8GGLGdpqYGTFq2zqBNiyo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="367285669"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="367285669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 06:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="735037520"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="735037520"
Received: from marynguy-mobl1.amr.corp.intel.com (HELO [10.209.14.133]) ([10.209.14.133])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 06:59:57 -0700
Message-ID: <ebd7c9e8-8bed-423a-a23b-fb93c173cd1b@linux.intel.com>
Date:   Tue, 24 Oct 2023 06:59:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 11/13] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
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
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-12-kirill.shutemov@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231020151242.1814-12-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 8:12 AM, Kirill A. Shutemov wrote:
> ACPI MADT doesn't allow to offline CPU after it got woke up. It limits
> kexec: the second kernel won't be able to use more than one CPU.
> 
> Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> 
> Zero out mailbox address in the ACPI MADT wakeup structure to indicate
> that the mailbox is not usable.  This prevents the kexec()-ed kernel
> from reading a vaild mailbox, which in turn makes the kexec()-ed kernel
> only be able to use the boot CPU.
> 
> This is Linux-specific protocol and not reflected in ACPI spec.
> 
> Booting the second kernel with signle CPU is enough to cover the most
> common case for kexec -- kdump.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 4bc1d5106afd..9bbe829737e7 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -13,6 +13,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
>  
>  static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
>  {
> +	if (!acpi_mp_wake_mailbox_paddr) {
> +		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/*
>  	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
>  	 *
> @@ -78,6 +83,23 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  
>  	cpu_hotplug_disable_offlining();
>  
> +	/*
> +	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> +	 * It limits kexec: the second kernel won't be able to use more than
> +	 * one CPU.
> +	 *
> +	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> +	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> +	 *
> +	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> +	 * indicate that the mailbox is not usable.  This prevents the
> +	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
> +	 * makes the kexec()-ed kernel only be able to use the boot CPU.
> +	 *
> +	 * This is Linux-specific protocol and not reflected in ACPI spec.
> +	 */
> +	mp_wake->base_address = 0;

Is there any way to skip secondary CPU bring-up for kexec case instead of
returning error in ->wakeup_secondary_cpu_64()?

> +
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
>  	return 0;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
