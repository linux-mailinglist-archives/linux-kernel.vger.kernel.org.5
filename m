Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E932774ABF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjHHUeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjHHUed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:34:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94D51F402
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691524881; x=1723060881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=u8vJmlLxjcWBeg1tEpWJSCR97H61L5sN6qPegFM1vlc=;
  b=Gv+9e7LvZE4CEpSf0YVxhRLyGWEmEE3EwnFyQ8AQOO7PEEDZ2f2wrYrL
   PC6WIoyQ3BA0NJA389Led4sVf56jEUpL8HzyJsweQAfS7DPQ5bA4S1bMB
   Ib9LV92bomhGfG4Ik8/IFnW+BJD+F0cu4tU7mFLt03H376r/c6MALABCS
   1FPBCNk5zDNH5A9tw+uF5lp3+6uH3XaY2O+etZ8bldvGNzJ/SasfYVnlM
   4j04K/cKhEjaKfqgMC0Ord9PnEDVbROXEaGf96BWFBdM2KFzZ12ethoas
   AH61PKGYSIEreee48dm5yCZIF9/4WyGnJve6xgG3Z7ybh3jlo201sV9dd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401902300"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="401902300"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 13:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855232391"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="855232391"
Received: from vevladis-mobl.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.49.245])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 13:01:16 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id AA4F410A12B; Tue,  8 Aug 2023 23:01:11 +0300 (+03)
Date:   Tue, 8 Aug 2023 23:01:11 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Mark TSC reliable
Message-ID: <20230808200111.nz74tmschph435ri@box>
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:13:05AM -0700, Dave Hansen wrote:
> On 8/8/23 09:23, Kirill A. Shutemov wrote:
> ...
> > On the other hand, other clock sources (such as HPET, ACPI timer,
> > APIC, etc.) necessitate VM exits to implement, resulting in more 
> > fluctuating measurements compared to TSC. Thus, those clock sources
> > are not effective for calibrating TSC.
> 
> Do we need to do anything to _those_ to mark them as slightly stinky?

I don't know what the rules here. As far as I can see, all other clock
sources relevant for TDX guest have lower rating. I guess we are fine?

There's notable exception to the rating order is kvmclock which is higher
than tsc. It has to be disabled, but it is not clear to me how. This topic
is related to how we are going to filter allowed devices/drivers, so I
would postpone the decision until we settle on wider filtering schema.

> > In TD guests, TSC is virtualized by the TDX module, which ensures:
> > 
> >   - Virtual TSC values are consistent among all the TD’s VCPUs;
> >   - Monotonously incrementing for any single VCPU;
> >   - The frequency is determined by TD configuration. The host TSC is
> >     invariant on platforms where TDX is available.
> 
> I take it this is carved in stone in the TDX specs somewhere.  A
> reference would be nice.

TDX Module 1.0 spec:

	5.3.5. Time Stamp Counter (TSC)

	TDX provides a trusted virtual TSC to the guest TDs. TSC value is
	monotonously incrementing, starting from 0 on TD initialization by the
	host VMM. The deviation between virtual TSC values read by each VCPU is
	small.

	A guest TD should disable mechanisms that are used in non-trusted
	environment, which attempt to synchronize TSC between VCPUs, and should
	not revert to using untrusted time mechanisms.

...

	13.13.1. TSC Virtualization

	For virtual time stamp counter (TSC) values read by guest TDs, the Intel
	TDX module is designed to achieve the following:

	• Virtual TSC values are consistent among all the TD’s VCPUs at
	  the level supported by the CPU, see below.
	• The virtual TSC value for any single VCPU is monotonously
	  incrementing (except roll over from 264-1 to 0).
	• The virtual TSC frequency is determined by TD configuration.

...

> We've got VMWare and Hyper-V code basically doing the same thing today.
> So TDX is in kinda good company.  But this still makes me rather
> nervous.  Do you have any encouraging words about how unlikely future
> hardware is to screw this up, especially as TDX-supporting hardware gets
> more diverse?

Wording in the spec looks okay to me. We can only hope that implementation
going to be sane.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
