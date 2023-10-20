Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16847D0BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376636AbjJTJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376593AbjJTJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:29:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB390D49
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794176; x=1729330176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jcyR0AHrPRoptorbJ7sUPfnYiRZ/f0uNOPZCGqeL0M=;
  b=Gq54QSBHKnLde/XUHaMNgHMzsVgEPKRnFQAgIGUyGJwbMD3bGpePTZzB
   uqFhOf64kqprt34jmZr01vwjW9dYaftR/69OSejzv8/y3OmkErDYOAcnh
   hFRrTkwH3cTb+UKlF9vvPR1KokfkSSLRj6GnWbxWzvZflb72uELuSsSoZ
   AIcjfhs5mCdToguNTCF48em3QbqXeqOW9iFwlzCYo/sIIgfK+FiSkc/5j
   8slOxtLXFWJJJFVNujy0PmpU+0U8mQc5wUyYPQaF+58S+YtNIgKbmTCQr
   2FRaX9mqa/NApRlYG6OYzTYxN8whBjrtjPRFJDS5CeqX6BT+tYBaQVn16
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="452943109"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="452943109"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873848717"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873848717"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:29:32 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9E13B109D0A; Fri, 20 Oct 2023 12:29:29 +0300 (+03)
Date:   Fri, 20 Oct 2023 12:29:29 +0300
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
Subject: Re: [PATCH 12/13] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
Message-ID: <20231020092929.ieig5xbhtwgrkqrl@box>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-13-kirill.shutemov@linux.intel.com>
 <100c567d4ba2e6f25dd6c51ceaf2995049d12c78.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100c567d4ba2e6f25dd6c51ceaf2995049d12c78.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:29:24AM +0000, Huang, Kai wrote:
> On Thu, 2023-10-05 at 16:14 +0300, Kirill A. Shutemov wrote:
> > ACPI MADT doesn't allow to offline CPU after it got woke up. It limits
> > kexec: target kernel won't be able to use more than one CPU.
> > 
> > Zero out mailbox address in the ACPI MADT wakeup structure to indicate
> > that the mailbox is not usable.
> > 
> > This is Linux-specific protocol and not reflected in ACPI spec.
> > 
> > Booting the target kernel with signle CPU is enough to cover the most
> > common case for kexec -- kdump.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/acpi/madt_wakeup.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> > index 15bdf10b1393..4e92d1d4a5fa 100644
> > --- a/arch/x86/kernel/acpi/madt_wakeup.c
> > +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> > @@ -9,6 +9,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> >  
> >  static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> >  {
> > +	if (!acpi_mp_wake_mailbox_paddr) {
> > +		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> >  	/*
> >  	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
> >  	 *
> > @@ -78,6 +83,18 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> >  	/* Disable CPU onlining/offlining */
> >  	cpu_hotplug_not_supported();
> >  
> > +	/*
> > +	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> > +	 * It limits kexec: target kernel won't be able to use more than
> > +	 * one CPU.
> > +	 *
> > +	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> > +	 * indicate that the mailbox is not usable.
> 
> Nit:
> 
> It is better to explicitly say that this will only impact the second kernel
> because the current kernel has already detected the  mailbox address?
> 
> 	Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> 	The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> 
> 	Zero out mailbox address in the ACPI MADT wakeup structure to
> 	indicate that the mailbox is not usable.  This prevents the
> 	kexec()-ed kernel from reading a vaild mailbox, which in turn
> 	makes the kexec()-ed kernel only be able to use the boot CPU. 

Okay. Looks good.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
