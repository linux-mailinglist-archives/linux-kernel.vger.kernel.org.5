Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671937ED1D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344305AbjKOUNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKOUM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:12:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCC7B9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700079177; x=1731615177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lc1jWISARgFdJYQUQcrkIWD4qhOpyFCrbPiSfmP2Hk4=;
  b=mMuO5AmIyEekpOCqjL+GyshBt4EycOZF91jM1dmzhjfFs4Atc9tO973Z
   9XDUelDSHFNmcV0+IONfXbCgF9uqA1M3L2u1YX935QsTiWcoRUz+1Pq8X
   3ocdXgPF2MIvRFCD3pDghpQw05CKGaLKXnArjevXOZj8TqSW+7Q4R6n6/
   2iRLl6jSCnbjF53Af+QUiy3oDnHYprC81NzEbW9EPtmuRBIFoiEPTAG5T
   6Z7dXUb4g0Mr5IyyqhLnmaLMAU3lLi2Qk/nJa+JpR5i2UbEeIm/XB3IfI
   dwNHmB9UCR86d+dYLmZd1tPO7CvbeB1zkybjFwypqcrMf0W0xcbOkZGes
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9587830"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="9587830"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:12:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="855756093"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="855756093"
Received: from ybradsha-mobl1.amr.corp.intel.com (HELO [10.212.204.204]) ([10.212.204.204])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:12:54 -0800
Message-ID: <09e0c289-9693-4376-9b89-0f74715f7728@linux.intel.com>
Date:   Wed, 15 Nov 2023 12:12:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 13/14] x86/acpi: Do not attempt to bring up secondary
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
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-14-kirill.shutemov@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231115120044.8034-14-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 4:00 AM, Kirill A. Shutemov wrote:
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
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/kernel/acpi/madt_wakeup.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 386adbb03094..5d92d12f1042 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -13,6 +13,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_afte
>  
>  static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
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
> +	mp_wake->mailbox_address = 0;
> +
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
>  	return 0;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
