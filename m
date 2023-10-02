Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2F7B5D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjJBWsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjJBWsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:48:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8293
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696286901; x=1727822901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dqVgn5JzV6w2S2w8I+nYvTji+uxpPqqRB+E4vUfQl/s=;
  b=nDXYYAfiJdeabtLpZ4zXdtTr3srwL6LYV+JOeMS1mJ++Kb2FHhB0hNjg
   KPGqn9VGbUFXpFTN6L86dSImC2BMddBidJxYQJAh8Uyn7SH38Mv66QMeJ
   dgCwMgiGYcjthBtXQZ0kUiclPTex6C0MZ52DULnfjmRUXB2i3cl0J2RZh
   mLKsDih3rZjTrR0MinjXFLqGynIcgV+TvOqlcB908X3JBzYZ5tSW84scU
   ZxQV/TR1Tdh8NsbdxVH1f+FZeSaLseGnvrDOwz9skeCpa7mxTX/R6ulax
   96l/+ayOH6HIqaWB29IVNSY6i9Xxwfp9eUl7Mvro0UWVSaANApU6UdX5W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362123931"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362123931"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 15:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="744286641"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="744286641"
Received: from mdmitrza-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.41.158])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 15:47:55 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E6AD010A0F8; Tue,  3 Oct 2023 01:47:52 +0300 (+03)
Date:   Tue, 3 Oct 2023 01:47:52 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "Li, Xin3" <xin3.li@intel.com>,
        "Compostella, Jeremy" <jeremy.compostella@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] x86/cpu/intel: Fix MTRR verification for TME
 enabled platforms
Message-ID: <20231002224752.33qa2lq7q2w4nqws@box>
References: <87a5t6ylpc.fsf@jcompost-mobl.amr.corp.intel.com>
 <00392c722e65c8d0da40384eecf8955be4875969.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00392c722e65c8d0da40384eecf8955be4875969.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:14:00AM +0000, Huang, Kai wrote:
> On Thu, 2023-09-28 at 15:30 -0700, Compostella, Jeremy wrote:
> > On TME enabled platform, BIOS publishes MTRR taking into account Total
> > Memory Encryption (TME) reserved bits.
> > 
> > generic_get_mtrr() performs a sanity check of the MTRRs relying on the
> > `phys_hi_rsvd' variable which is set using the cpuinfo_x86 structure
> > `x86_phys_bits' field.  But at the time the generic_get_mtrr()
> > function is ran the `x86_phys_bits' has not been updated by
> > detect_tme() when TME is enabled.
> > 
> > Since the x86_phys_bits does not reflect yet the real maximal physical
> > address size yet generic_get_mtrr() complains by logging the following
> > messages.
> > 
> >     mtrr: your BIOS has configured an incorrect mask, fixing it.
> >     mtrr: your BIOS has configured an incorrect mask, fixing it.
> >     [...]
> > 
> > In such a situation, generic_get_mtrr() returns an incorrect size but
> > no side effect were observed during our testing.
> > 
> > For `x86_phys_bits' to be updated before generic_get_mtrr() runs,
> > move the detect_tme() call from init_intel() to early_init_intel().
> 
> Hi,
> 
> This move looks good to me, but +Kirill who is the author of detect_tme() for
> further comments.
> 
> Also I am not sure whether it's worth to consider to move this to
> get_cpu_address_sizes(), which calculates the virtual/physical address sizes. 
> Thus it seems anything that can impact physical address size could be put there.

Actually, I am not sure how this patch works. AFAICS after the patch we
have the following callchain:

early_identify_cpu()
  this_cpu->c_early_init() (which is early_init_init())
    detect_tme()
      c->x86_phys_bits -= keyid_bits;
  get_cpu_address_sizes(c);
    c->x86_phys_bits = eax & 0xff;

Looks like get_cpu_address_sizes() would override what detect_tme() does.

I guess we reach the same detect_tme() again via c->c_init() (aka
init_intel()) codepath and get the value right again.

But it seems accidental.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
