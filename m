Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C357CB0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjJPRDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjJPRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:02:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9BD9012
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697475614; x=1729011614;
  h=from:to:cc:subject:references:date:message-id:
   mime-version;
  bh=GSCllav7zlVB78jVwtda17zbFKcw/Gth8ucV76qqtSg=;
  b=eEyT4yNWdFNjCQfStHzWYLsoqzmzBX6S/qgVo81nf/rIOMpfTSLvPtYj
   fbt2QyTMj9mewfNMS+yjrc97BFZRn+QB3wbEMDNayZqFk3FTfRCFpqlEK
   CZ29AwgapWMhyi+kcBTnVJxGycfau8knKYAD5WXtp2zIFk9aCHWPCcu4i
   M6kP6bBP0iNXTiUJjmrCQNcZp0MB1pH1OL1XNeBaU7LS2JwLcpTLM13uc
   FxAGxrhL6ygtxZQjVdotP7A3++KAfCr3cQm77k7Zu7NPiqpggzBgxuWAI
   28842EYqU/E8X9pebGmDPNQHVEAWN8udPV32nb1+4m6WwtqJG83/a2DBL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="471808824"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="471808824"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="879490926"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="879490926"
Received: from kmwinsor-mobl1.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.213.181.210])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:00:12 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     <kirill.shutemov@linux.intel.com>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
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
        <87edhyyvkp.fsf@jcompost-mobl.amr.corp.intel.com>
        <20231014210125.iexeacn6p4naw5qz@box.shutemov.name>
        <87a5sizgr8.fsf@jcompost-mobl.amr.corp.intel.com>
        <20231016162609.wfkfsams23exesvs@box.shutemov.name>
Date:   Mon, 16 Oct 2023 10:00:06 -0700
Message-ID: <875y36zend.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara,
        CA 95052. USA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

#+begin_signature
-- 
Jeremy
One Emacs to rule them all
#+end_signature<kirill.shutemov@linux.intel.com> writes:

> On Mon, Oct 16, 2023 at 09:14:35AM -0700, Compostella, Jeremy wrote:
>> <kirill.shutemov@linux.intel.com> writes:
>> 
>> > On Fri, Oct 13, 2023 at 04:03:02PM -0700, Compostella, Jeremy wrote:
>> >> "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com> writes:
>> >> > On Tue, Oct 03, 2023 at 02:06:52AM +0000, Huang, Kai wrote:
>> >> >> On Tue, 2023-10-03 at 01:47 +0300, kirill.shutemov@linux.intel.com wrote:
>> >> >> > On Fri, Sep 29, 2023 at 09:14:00AM +0000, Huang, Kai wrote:
>> >> >> > > On Thu, 2023-09-28 at 15:30 -0700, Compostella, Jeremy wrote:
>> >> >> > > > On TME enabled platform, BIOS publishes MTRR taking into account Total
>> >> >> > > > Memory Encryption (TME) reserved bits.
>> >> >> > > > 
>> >> >> > > > generic_get_mtrr() performs a sanity check of the MTRRs relying on the
>> >> >> > > > `phys_hi_rsvd' variable which is set using the cpuinfo_x86 structure
>> >> >> > > > `x86_phys_bits' field.  But at the time the generic_get_mtrr()
>> >> >> > > > function is ran the `x86_phys_bits' has not been updated by
>> >> >> > > > detect_tme() when TME is enabled.
>> >> >> > > > 
>> >> >> > > > Since the x86_phys_bits does not reflect yet the real maximal physical
>> >> >> > > > address size yet generic_get_mtrr() complains by logging the following
>> >> >> > > > messages.
>> >> >> > > > 
>> >> >> > > >     mtrr: your BIOS has configured an incorrect mask, fixing it.
>> >> >> > > >     mtrr: your BIOS has configured an incorrect mask, fixing it.
>> >> >> > > >     [...]
>> >> >> > > > 
>> >> >> > > > In such a situation, generic_get_mtrr() returns an incorrect size but
>> >> >> > > > no side effect were observed during our testing.
>> >> >> > > > 
>> >> >> > > > For `x86_phys_bits' to be updated before generic_get_mtrr() runs,
>> >> >> > > > move the detect_tme() call from init_intel() to early_init_intel().
>> >> >> > > 
>> >> >> > > Hi,
>> >> >> > > 
>> >> >> > > This move looks good to me, but +Kirill who is the author of detect_tme() for
>> >> >> > > further comments.
>> >> >> > > 
>> >> >> > > Also I am not sure whether it's worth to consider to move this to
>> >> >> > > get_cpu_address_sizes(), which calculates the
>> >> >> > > virtual/physical address sizes.
>> >> >> > > Thus it seems anything that can impact physical address size
>> >> >> > > could be put there.
>> >> >> > 
>> >> >> > Actually, I am not sure how this patch works. AFAICS after the patch we
>> >> >> > have the following callchain:
>> >> >> > 
>> >> >> > early_identify_cpu()
>> >> >> >   this_cpu->c_early_init() (which is early_init_init())
>> >> >> >     detect_tme()
>> >> >> >       c->x86_phys_bits -= keyid_bits;
>> >> >> >   get_cpu_address_sizes(c);
>> >> >> >     c->x86_phys_bits = eax & 0xff;
>> >> >> > 
>> >> >> > Looks like get_cpu_address_sizes() would override what detect_tme() does.
>> >> >> 
>> >> >> After this patch, early_identify_cpu() calls get_cpu_address_sizes() first and
>> >> >> then calls c_early_init(), which calls detect_tme().
>> >> >> 
>> >> >> So looks no override.  No?
>> >> 
>> >> No override indeed as get_cpu_address_sizes() is always called before
>> >> early_init_intel or init_intel().
>> >> 
>> >> - init/main.c::start_kernel()
>> >>   - arch/x86/kernel/setup.c::setup_arch()
>> >>     - arch/x86/kernel/cpu/common.c::early_cpu_init()
>> >>       - early_identify_cpu()
>> >>         - get_cpu_address_sizes(c)
>> >>           c->x86_phys_bits = eax & 0xff;
>> >>         - arch/x86/kernel/cpu/intel.c::early_init_intel()
>> >>           - detect_tme()
>> >>             c->x86_phys_bits -= keyid_bits;
>> >
>> > Hmm.. Do I read it wrong:
>> >
>> > 	static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>> > 	{
>> > 	...
>> > 		/* cyrix could have cpuid enabled via c_identify()*/
>> > 		if (have_cpuid_p()) {
>> > 		...
>> > 		        // Here we call early_intel_init()
>> > 			if (this_cpu->c_early_init)
>> > 				this_cpu->c_early_init(c);
>> > 			...
>> > 		}
>> >
>> > 		get_cpu_address_sizes(c);
>> > 	...
>> > 	}
>> >
>> > ?
>> >
>> > As far as I see get_cpu_address_sizes() called after early_intel_init().
>> 
>> On `58720809f527 v6.6-rc6 6.6-rc6 2de3c93ef41b' is what I have:
>> 
>> ,----
>> | 1599  /* cyrix could have cpuid enabled via c_identify()*/
>> | 1600  if (have_cpuid_p()) {
>> | 1601  	cpu_detect(c);
>> | 1602  	get_cpu_vendor(c);
>> | 1603  	get_cpu_cap(c);
>> | 1604  	get_cpu_address_sizes(c);                   <= called first
>> | 1605  	setup_force_cpu_cap(X86_FEATURE_CPUID);
>> | 1606  	cpu_parse_early_param();
>> | 1607  
>> | 1608  	if (this_cpu->c_early_init)
>> | 1609  		this_cpu->c_early_init(c);
>> | 1610  
>> | 1611  	c->cpu_index = 0;
>> | 1612  	filter_cpuid_features(c, false);
>> | 1613  
>> | 1614  	if (this_cpu->c_bsp_init)
>> | 1615  		this_cpu->c_bsp_init(c);
>> | 1616  } else {
>> | 1617  	setup_clear_cpu_cap(X86_FEATURE_CPUID);
>> | 1618  }
>> `----
>> Listing 1: arch/x86/kernel/cpu/common.c
>> 
>> => get_cpu_address_sizes() is called first which is also conform to my
>>    experiments and instrumentation.
>
> Ah. It got patched in tip tree. See commit fbf6449f84bf.

This commit breaks AMD code as early_init_amd() calls
early_detect_mem_encrypt() to adjust x86_phys_bits which is not
initialized properly and then overwritten after.

--=-=-=--
