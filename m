Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43158108C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378411AbjLMDhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjLMDhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:37:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D60FB7;
        Tue, 12 Dec 2023 19:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702438639; x=1733974639;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/TTYLl6m3nDoZ6t2LsN549k9K+o9cYhBy102gdNwk1c=;
  b=Vi6NzdT6kd3JMjVYms06tVD4Gdpqt3D2xROK79nOy7Pti5Wt4pKrP306
   gVGdQ5XhEfrmssw9i/Ugz0sW/HMnTij6/C6UejRKJcEjU42xNHvLKn8A2
   zcUsoGbkDr7/pGWRq89JnC8vciWZRIFYq3dTZhMvwmFxxF1URDv4TWnKg
   UA3i3C98NkVRv09OclxzdiMSmA9YyeMjH18F3GhcNiOxdQT05LnwiUilz
   oUxC5oAxxJX06QmMoZT6cq5vPu9l/IB3tuhRrFxo2KMwZc+XfMvN0xseb
   Xr67EZgChn0pWZOSI/gSbDKKV5w/A6XWfPz9MdqNORjTE/zAnA+9AADmK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2081089"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="2081089"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 19:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="917520199"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="917520199"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 19:37:18 -0800
Date:   Tue, 12 Dec 2023 19:42:13 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        peterz@infradead.org, seanjc@google.com,
        Robin Murphy <robin.murphy@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 11/13] iommu/vt-d: Add an irq_chip for posted MSIs
Message-ID: <20231212194213.1ad94584@jacob-builder>
In-Reply-To: <87wmtrt625.ffs@tglx>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
        <20231112041643.2868316-12-jacob.jun.pan@linux.intel.com>
        <87wmtrt625.ffs@tglx>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, 06 Dec 2023 21:44:02 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> >  static void fill_msi_msg(struct msi_msg *msg, u32 index, u32 subhandle)
> >  {
> >  	memset(msg, 0, sizeof(*msg));
> > @@ -1361,7 +1397,7 @@ static int intel_irq_remapping_alloc(struct
> > irq_domain *domain, 
> >  		irq_data->hwirq = (index << 16) + i;
> >  		irq_data->chip_data = ird;
> > -		irq_data->chip = &intel_ir_chip;
> > +		irq_data->chip = posted_msi_supported() ?
> > &intel_ir_chip_post_msi : &intel_ir_chip;  
> 
> This is just wrong because you change the chip to posted for _ALL_
> domains unconditionally.
> 
> The only domains which want this chip are the PCI/MSI domains. And those
> are distinct from the domains which serve IO/APIC, HPET, no?
> 
> So you can set that chip only for PCI/MSI and just let IO/APIC, HPET
> domains keep the original chip, which spares any modification of the
> IO/APIC domain.
> 
> 
make sense.
-               irq_data->chip = posted_msi_supported() ? &intel_ir_chip_post_msi : &intel_ir_chip;
+               if ((info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI) && posted_msi_supported())
+                       irq_data->chip = &intel_ir_chip_post_msi;
+               else
+                       irq_data->chip = &intel_ir_chip;

Now in IRQ debugfs, I can see the correct IR chips for IOAPIC IRQs and
MSIs.

e.g


domain:  IO-APIC-8
 hwirq:   0x9
 chip:    IR-IO-APIC
  flags:   0x410
             IRQCHIP_SKIP_SET_WAKE
 parent:
    domain:  INTEL-IR-9-13
     hwirq:   0x80000
     chip:    INTEL-IR
      flags:   0x0
     parent:
        domain:  VECTOR


domain:  IR-PCI-MSI-0000:3d:00.4-11
 hwirq:   0x0
 chip:    IR-PCI-MSI-0000:3d:00.4
  flags:   0x430
             IRQCHIP_SKIP_SET_WAKE
             IRQCHIP_ONESHOT_SAFE
 parent:
    domain:  INTEL-IR-4-13
     hwirq:   0x0
     chip:    INTEL-IR-POST
      flags:   0x0
     parent:
        domain:  VECTOR


Thanks,

Jacob
