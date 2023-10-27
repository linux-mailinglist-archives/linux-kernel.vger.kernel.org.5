Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484CB7D9716
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJ0L6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0L6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:58:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE303C4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698407900; x=1729943900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FMgGs7keUPnSe1O0ZLkjvny+7wogrNAYRVjIflUV0NE=;
  b=NdYlF1bLXGTH5yhd0r6nbLo1bPyJF49sCJN6vBYBdPiXiw8yQJ7ZeFx2
   tifSu5qwM+Cb2LdWlPkbskueumMXlMyUL9LD0w3Na++RnpKlDNJ6YbZ1x
   AfpK/ys3ZdQtHiLbW+q1Dvc0ArJpR/ecssWsQdxPOA4kJJgfpGNwbn8vt
   v6skck+Hcxdr4fbyl4kuxAmIS7Z6POC2Hv6D1z5pZcKxdLC0f5XXyq43t
   gaEYOgwTKR7gmoM2yd11J/yQR97q70PenzUeD3oqjeDrcRYniq1xszDY9
   nePLBS9dWzwwu2QOjcLEQLhPCemM/eIP8pIZc1INBVcJSU1AWKqHcFKdl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="474001326"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="474001326"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="7634420"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:58:04 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 98EBE10A210; Fri, 27 Oct 2023 14:58:13 +0300 (+03)
Date:   Fri, 27 Oct 2023 14:58:13 +0300
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231027115813.imxsyq2ehl664nnw@box.shutemov.name>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
 <d86dbb81338d3473f24b3c479cf985a70bfc1118.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d86dbb81338d3473f24b3c479cf985a70bfc1118.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:11:58AM +0000, Huang, Kai wrote:
> 
> > --- /dev/null
> > +++ b/arch/x86/kernel/acpi/madt.S
> 
> I think the name 'madt.S' is too generic.  How about something be more specific
> such as madt_reset.S, or madt_playdead.S, etc? 

Okay, madt_playdead.S sounds good.

> > @@ -11,6 +16,150 @@ static u64 acpi_mp_wake_mailbox_paddr;
> >  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> >  static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> >  
> > +u64 acpi_mp_pgd;
> > +u64 acpi_mp_reset_vector_paddr;
> > +
> > +void asm_acpi_mp_play_dead(void);
> > +
> > +static void __init *alloc_pgt_page(void *context)
> > +{
> > +	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +}
> > +
> > +/*
> > + * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
> > + * the same place as in the kernel page tables. The function switches to
> > + * the identity mapping 
> > 
> 
> This function itself doesn't switch to the identity mapping.  It just creates
> the kernel mapping for asm_acpi_mp_play_dead() in the identify mapping page
> table.

By "The function" I meant asm_acpi_mp_play_dead(). Yeah, it is not clear.

Will so s/The function/asm_acpi_mp_play_dead()/

> > -	cpu_hotplug_disable_offlining();
> > +	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
> > +	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
> > +		acpi_mp_setup_reset(mp_wake->reset_vector);
> 
> It's better to fallback to "disable offline" if this function fails.
> 

Okay, will warn to disable offlining.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
