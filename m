Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587AE7D9931
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjJ0NBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0NBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:01:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDD810E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698411708; x=1729947708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jySUg5BBj2x92b+aCarRimTae0InN/QCh5etMPoVNIM=;
  b=g+qB4383mhSo7FfuWR97q+PZQwHvmzp2ro9m9dHGqrjImuauOkuryg1i
   K9yL9YKsMm7SVSiuuXPxAY8r4YNTU2PO2F6jMuwlcsQ/X731pQEqc9qZO
   RQRDHyIJaCm6DMZu66wQcPkeZvvP4zTDnfMt35ReGckQKlsEyG9DKkLLM
   ZfbOihc5a3V4ctkGCI/FafnyYVAlRUeiKm3mHY9NK6kvCCH2oMK7Bvtl3
   8UpZD6fH9/V0ff1r0hR3nd99tV5YrOTk3tWuIdXB5XPdOK6ZsdjhBEflE
   5yU98WG7iTmPmyB4wbegbNXW0+avQJBSSbtrcsvZnAppvt9+QcXxbB2oe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="9309468"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="9309468"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 06:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="736080004"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="736080004"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 06:01:42 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5FA5210A210; Fri, 27 Oct 2023 16:01:39 +0300 (+03)
Date:   Fri, 27 Oct 2023 16:01:39 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCHv2 11/13] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
Message-ID: <20231027130139.iqvjpu2rizmsxxz7@box.shutemov.name>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-12-kirill.shutemov@linux.intel.com>
 <ebd7c9e8-8bed-423a-a23b-fb93c173cd1b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd7c9e8-8bed-423a-a23b-fb93c173cd1b@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 06:59:58AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 10/20/2023 8:12 AM, Kirill A. Shutemov wrote:
> > ACPI MADT doesn't allow to offline CPU after it got woke up. It limits
> > kexec: the second kernel won't be able to use more than one CPU.
> > 
> > Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> > The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> > 
> > Zero out mailbox address in the ACPI MADT wakeup structure to indicate
> > that the mailbox is not usable.  This prevents the kexec()-ed kernel
> > from reading a vaild mailbox, which in turn makes the kexec()-ed kernel
> > only be able to use the boot CPU.
> > 
> > This is Linux-specific protocol and not reflected in ACPI spec.
> > 
> > Booting the second kernel with signle CPU is enough to cover the most
> > common case for kexec -- kdump.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/acpi/madt_wakeup.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> > index 4bc1d5106afd..9bbe829737e7 100644
> > --- a/arch/x86/kernel/acpi/madt_wakeup.c
> > +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> > @@ -13,6 +13,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
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
> > @@ -78,6 +83,23 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> >  
> >  	cpu_hotplug_disable_offlining();
> >  
> > +	/*
> > +	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> > +	 * It limits kexec: the second kernel won't be able to use more than
> > +	 * one CPU.
> > +	 *
> > +	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> > +	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> > +	 *
> > +	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> > +	 * indicate that the mailbox is not usable.  This prevents the
> > +	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
> > +	 * makes the kexec()-ed kernel only be able to use the boot CPU.
> > +	 *
> > +	 * This is Linux-specific protocol and not reflected in ACPI spec.
> > +	 */
> > +	mp_wake->base_address = 0;
> 
> Is there any way to skip secondary CPU bring-up for kexec case instead of
> returning error in ->wakeup_secondary_cpu_64()?

I have not found a cleaner way. Do you have ideas?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
