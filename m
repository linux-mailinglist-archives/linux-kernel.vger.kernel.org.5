Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA967B6226
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbjJCHHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjJCHHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:07:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBD483
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696316824; x=1727852824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8zHW91KPgolIjQA3mxOCyT6ByFS2eRQWUt1hx9DZvRQ=;
  b=Lb7CiBqL7mXNgjho1wTBQJ7LsSuWAp6oagWG1YpXHGsU+Fd60bK/IBOl
   +1qg7MSI7ExT//17ohXU5kNYTboGIY0gpuP4kVoadu8e3m8Yi5IMqhHbK
   ud/kHoUAi3ORavas17aP5IifZXVpBI5AE/VCnloWy2YvjpN/LCGnH7akt
   RaQ9bQEsmRpBw/q+F6dyCVHt4xMhsX/gXEIk7T01S/pzkNAL80ot46rGV
   gluZaKE7DyMs+mPDayrIX+INoY7Bmh0HL9CQTTqZeoTyUNNqa//cHUmV0
   1l8qOgi49TFnndmtpATy5z7BNfIJsQcppkoTNDMsJBTTjJbmy2tJlzVab
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="449297842"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="449297842"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 00:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081903746"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081903746"
Received: from dmishura-mobl1.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.41.87])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 00:07:02 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B31A310A0D2; Tue,  3 Oct 2023 10:06:59 +0300 (+03)
Date:   Tue, 3 Oct 2023 10:06:59 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "Li, Xin3" <xin3.li@intel.com>,
        "Compostella, Jeremy" <jeremy.compostella@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] x86/cpu/intel: Fix MTRR verification for TME
 enabled platforms
Message-ID: <20231003070659.hsjvnoc53agvms6c@box.shutemov.name>
References: <87a5t6ylpc.fsf@jcompost-mobl.amr.corp.intel.com>
 <00392c722e65c8d0da40384eecf8955be4875969.camel@intel.com>
 <20231002224752.33qa2lq7q2w4nqws@box>
 <65d26d679843e26fd5e6252a08391f87243a49c9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d26d679843e26fd5e6252a08391f87243a49c9.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 02:06:52AM +0000, Huang, Kai wrote:
> On Tue, 2023-10-03 at 01:47 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Fri, Sep 29, 2023 at 09:14:00AM +0000, Huang, Kai wrote:
> > > On Thu, 2023-09-28 at 15:30 -0700, Compostella, Jeremy wrote:
> > > > On TME enabled platform, BIOS publishes MTRR taking into account Total
> > > > Memory Encryption (TME) reserved bits.
> > > > 
> > > > generic_get_mtrr() performs a sanity check of the MTRRs relying on the
> > > > `phys_hi_rsvd' variable which is set using the cpuinfo_x86 structure
> > > > `x86_phys_bits' field.  But at the time the generic_get_mtrr()
> > > > function is ran the `x86_phys_bits' has not been updated by
> > > > detect_tme() when TME is enabled.
> > > > 
> > > > Since the x86_phys_bits does not reflect yet the real maximal physical
> > > > address size yet generic_get_mtrr() complains by logging the following
> > > > messages.
> > > > 
> > > >     mtrr: your BIOS has configured an incorrect mask, fixing it.
> > > >     mtrr: your BIOS has configured an incorrect mask, fixing it.
> > > >     [...]
> > > > 
> > > > In such a situation, generic_get_mtrr() returns an incorrect size but
> > > > no side effect were observed during our testing.
> > > > 
> > > > For `x86_phys_bits' to be updated before generic_get_mtrr() runs,
> > > > move the detect_tme() call from init_intel() to early_init_intel().
> > > 
> > > Hi,
> > > 
> > > This move looks good to me, but +Kirill who is the author of detect_tme() for
> > > further comments.
> > > 
> > > Also I am not sure whether it's worth to consider to move this to
> > > get_cpu_address_sizes(), which calculates the virtual/physical address sizes. 
> > > Thus it seems anything that can impact physical address size could be put there.
> > 
> > Actually, I am not sure how this patch works. AFAICS after the patch we
> > have the following callchain:
> > 
> > early_identify_cpu()
> >   this_cpu->c_early_init() (which is early_init_init())
> >     detect_tme()
> >       c->x86_phys_bits -= keyid_bits;
> >   get_cpu_address_sizes(c);
> >     c->x86_phys_bits = eax & 0xff;
> > 
> > Looks like get_cpu_address_sizes() would override what detect_tme() does.
> 
> After this patch, early_identify_cpu() calls get_cpu_address_sizes() first and
> then calls c_early_init(), which calls detect_tme().
> 
> So looks no override.  No?

We identify CPU twice: once via early_cpu_init() and the second time via
identify_boot_cpu()/identify_secondary_cpu(). I am talking about
early_cpu_init() codepath.

It might not matter in practice as of now, because it will get straight
later, but CPU ident code is mess as it is. Let's not make it even worse.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
