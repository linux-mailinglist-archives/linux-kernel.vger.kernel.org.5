Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917947C9122
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjJMXDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjJMXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:03:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADCCB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697238184; x=1728774184;
  h=from:to:cc:subject:references:date:message-id:
   mime-version;
  bh=4tg2hRkVnC558rPe0omEPqwmSytOElR8PBs/m6fdwIs=;
  b=ZrpCuh+E+cS+kc1pQyZKE2D80rlTrD4oc8UeCiQSvqInEUgxFYKGod4S
   ZDvIpI/ByizyUOqcnybqeRTMrpTgnNMYRNd0paOwBkxyjr3EwL7FiPknj
   2Hra+3kPbT6d+OPU09MnhkhDY5olA3/dJrAvofTBb86n76SffifVrL5V3
   0V/8kBa8XIe53++WPGh84KEFkqQoeKws3jsjDl3T7o4Jk6Zq6w2OWYxBS
   9SATqCYcYrP3gOsHjnXwwWRqDrBvEVebiNEjsWSnn8sk1hdmTGFCwQiH0
   yDM/TlJEwHZ/2MZtO3AtNHIGxO256XTXJQIEb5sCwgEUpo86Kf9I1aZ+n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389142664"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389142664"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 16:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="704828913"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="704828913"
Received: from sridharg-mobl2.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.212.73.167])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 16:03:03 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     kirill.shutemov@linux.intel.com, "Huang, Kai" <kai.huang@intel.com>
Cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "Li, Xin3" <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] x86/cpu/intel: Fix MTRR verification for TME
 enabled platforms
References: <87a5t6ylpc.fsf@jcompost-mobl.amr.corp.intel.com>
        <00392c722e65c8d0da40384eecf8955be4875969.camel@intel.com>
        <20231002224752.33qa2lq7q2w4nqws@box>
        <65d26d679843e26fd5e6252a08391f87243a49c9.camel@intel.com>
        <20231003070659.hsjvnoc53agvms6c@box.shutemov.name>
Date:   Fri, 13 Oct 2023 16:03:02 -0700
Message-ID: <87edhyyvkp.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara,
        CA 95052. USA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com> writes:
> On Tue, Oct 03, 2023 at 02:06:52AM +0000, Huang, Kai wrote:
>> On Tue, 2023-10-03 at 01:47 +0300, kirill.shutemov@linux.intel.com wrote:
>> > On Fri, Sep 29, 2023 at 09:14:00AM +0000, Huang, Kai wrote:
>> > > On Thu, 2023-09-28 at 15:30 -0700, Compostella, Jeremy wrote:
>> > > > On TME enabled platform, BIOS publishes MTRR taking into account Total
>> > > > Memory Encryption (TME) reserved bits.
>> > > > 
>> > > > generic_get_mtrr() performs a sanity check of the MTRRs relying on the
>> > > > `phys_hi_rsvd' variable which is set using the cpuinfo_x86 structure
>> > > > `x86_phys_bits' field.  But at the time the generic_get_mtrr()
>> > > > function is ran the `x86_phys_bits' has not been updated by
>> > > > detect_tme() when TME is enabled.
>> > > > 
>> > > > Since the x86_phys_bits does not reflect yet the real maximal physical
>> > > > address size yet generic_get_mtrr() complains by logging the following
>> > > > messages.
>> > > > 
>> > > >     mtrr: your BIOS has configured an incorrect mask, fixing it.
>> > > >     mtrr: your BIOS has configured an incorrect mask, fixing it.
>> > > >     [...]
>> > > > 
>> > > > In such a situation, generic_get_mtrr() returns an incorrect size but
>> > > > no side effect were observed during our testing.
>> > > > 
>> > > > For `x86_phys_bits' to be updated before generic_get_mtrr() runs,
>> > > > move the detect_tme() call from init_intel() to early_init_intel().
>> > > 
>> > > Hi,
>> > > 
>> > > This move looks good to me, but +Kirill who is the author of detect_tme() for
>> > > further comments.
>> > > 
>> > > Also I am not sure whether it's worth to consider to move this to
>> > > get_cpu_address_sizes(), which calculates the virtual/physical address sizes. 
>> > > Thus it seems anything that can impact physical address size could be put there.
>> > 
>> > Actually, I am not sure how this patch works. AFAICS after the patch we
>> > have the following callchain:
>> > 
>> > early_identify_cpu()
>> >   this_cpu->c_early_init() (which is early_init_init())
>> >     detect_tme()
>> >       c->x86_phys_bits -= keyid_bits;
>> >   get_cpu_address_sizes(c);
>> >     c->x86_phys_bits = eax & 0xff;
>> > 
>> > Looks like get_cpu_address_sizes() would override what detect_tme() does.
>> 
>> After this patch, early_identify_cpu() calls get_cpu_address_sizes() first and
>> then calls c_early_init(), which calls detect_tme().
>> 
>> So looks no override.  No?

No override indeed as get_cpu_address_sizes() is always called before
early_init_intel or init_intel().

- init/main.c::start_kernel()
  - arch/x86/kernel/setup.c::setup_arch()
    - arch/x86/kernel/cpu/common.c::early_cpu_init()
      - early_identify_cpu()
        - get_cpu_address_sizes(c)
          c->x86_phys_bits = eax & 0xff;
        - arch/x86/kernel/cpu/intel.c::early_init_intel()
          - detect_tme()
            c->x86_phys_bits -= keyid_bits;
  - arch/x86/kernel/cpu/common.c::arch_cpu_finalize_init()
    - identify_boot_cpu()
      - identify_cpu()
        - get_cpu_address_sizes(c)
          c->x86_phys_bits = eax & 0xff;
        - arch/x86/kernel/cpu/intel.c::init_intel()
          - early_init_intel()
            - detect_tme()
              c->x86_phys_bits -= keyid_bits;

> We identify CPU twice: once via early_cpu_init() and the second time via
> identify_boot_cpu()/identify_secondary_cpu(). I am talking about
> early_cpu_init() codepath.
>
> It might not matter in practice as of now, because it will get straight
> later, but CPU ident code is mess as it is. Let's not make it even worse.

This change is not modifying the CPU indent code, this is just
re-ordering detect_tme() call in the intel specifics hook so that the
information is available earlier as it is needed by
generic_get_mtrr(). This is similar to what is done in
arch/x86/kernel/cpu/amd.c.

--=-=-=--
