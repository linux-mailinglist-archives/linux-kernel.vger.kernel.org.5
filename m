Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFF47888FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245264AbjHYNtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245257AbjHYNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:49:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72592134
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692971338; x=1724507338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1WrrVuaq3qOLP+4Fh4Oo1laXCwKcfJBSq+CqkNCWoQU=;
  b=Sse6R4BIBzyomc7IZv3HIlUj4AaaWXppXOJUC7miHuK5WKA9C9ivnuy9
   k6M93fx8Gk7xgUnEBz0bmJsMceCUKw1ehy6YjrUHV0Re/0zslbg7eXdL2
   +6ds0kdMCS/rh7uKp0CdhskbsS8EeXgGGto0RUcFyUnau4oS4kBV4supt
   XJvMEm0EalNFaAIz3UdWuALDe9xTzsvUcr91J5daEewcsXIwoBcXONmPw
   18u/gxYCmkKmulqa+mZKYDZHNaimVXGnvI3t7yHBBsgy2SiE25B9iFCco
   Dp7wJ9mmHTsfGvfBPDRqN9aJk7dp35Muzx7Erhl0ZKGduOxfjTM7xogjQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359715028"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359715028"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 06:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="766959646"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="766959646"
Received: from naikshri-mobl7.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.41.113])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 06:47:49 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 62118109FED; Fri, 25 Aug 2023 16:47:46 +0300 (+03)
Date:   Fri, 25 Aug 2023 16:47:46 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/tdx: Mark TSC reliable
Message-ID: <20230825134746.k7hkpa3e7wnsuq7m@box.shutemov.name>
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
 <20230808200111.nz74tmschph435ri@box>
 <878ra0ck4k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878ra0ck4k.ffs@tglx>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:31:39PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 08 2023 at 23:01, Kirill A. Shutemov wrote:
> > On Tue, Aug 08, 2023 at 10:13:05AM -0700, Dave Hansen wrote:
> >> On 8/8/23 09:23, Kirill A. Shutemov wrote:
> >> ...
> >> > On the other hand, other clock sources (such as HPET, ACPI timer,
> >> > APIC, etc.) necessitate VM exits to implement, resulting in more 
> >> > fluctuating measurements compared to TSC. Thus, those clock sources
> >> > are not effective for calibrating TSC.
> >> 
> >> Do we need to do anything to _those_ to mark them as slightly stinky?
> >
> > I don't know what the rules here. As far as I can see, all other clock
> > sources relevant for TDX guest have lower rating. I guess we are fine?
> 
> Ideally they are not enumerated in the first place, which prevents the
> kernel from trying.

We can ask QEMU/KVM not to advertise them to TDX guest, but guest has to
protect itself as the VMM is not trusted. And we are back to device
filtering...

> > There's notable exception to the rating order is kvmclock which is higher
> > than tsc.
> 
> Which is silly aside of TDX.
> 
> > It has to be disabled, but it is not clear to me how. This topic
> > is related to how we are going to filter allowed devices/drivers, so I
> > would postpone the decision until we settle on wider filtering schema.
> 
> TDX aside it might be useful to have a mechanism to select TSC over KVM
> clock in general.

Sean, Paolo, any comment on this?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
