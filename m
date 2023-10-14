Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3EC7C966D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 23:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjJNVBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 17:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJNVBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 17:01:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BCDCE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697317290; x=1728853290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ax2zHy8ndn5Yyhlz3vOC4Kc4pFvoQmXFAPWyJvKxs4=;
  b=ACFtOrHP3hsiylHwPLf1Tu9vX3cXe3w/HjEwS8CBQpiJJ5Ea51v7fPXo
   EjcYwwsM5TaOpwfL3DfwJp+KUrXueUxyKQokBE5s7lm8AJw0WHEq7J19U
   X+l/Zof6EQEZrXYv292yfQY1PhMXMIvDhClZwINXgRM+cjh6SDoVexA4c
   CGhNMXWDHkI21QfZoIqWsMJ5t/4L7qMPeQsEUAn22MQq84IqPuEjevhRG
   ejXMnPa+AqJDZslx86+nUtX67CP0uDN9Hyr+fi6hFf9YmQBmZj6+egI8l
   Kkn0b0Z+V962otY5jtk3E6oszMK1sCkCfXZyBF1c3njIaAwzQHb6x7nh0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="388205407"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="388205407"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 14:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="755122801"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="755122801"
Received: from asamachi-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.223.207])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 14:01:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5508F10A1C3; Sun, 15 Oct 2023 00:01:25 +0300 (+03)
Date:   Sun, 15 Oct 2023 00:01:25 +0300
From:   kirill.shutemov@linux.intel.com
To:     "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "Li, Xin3" <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] x86/cpu/intel: Fix MTRR verification for TME
 enabled platforms
Message-ID: <20231014210125.iexeacn6p4naw5qz@box.shutemov.name>
References: <87a5t6ylpc.fsf@jcompost-mobl.amr.corp.intel.com>
 <00392c722e65c8d0da40384eecf8955be4875969.camel@intel.com>
 <20231002224752.33qa2lq7q2w4nqws@box>
 <65d26d679843e26fd5e6252a08391f87243a49c9.camel@intel.com>
 <20231003070659.hsjvnoc53agvms6c@box.shutemov.name>
 <87edhyyvkp.fsf@jcompost-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edhyyvkp.fsf@jcompost-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 04:03:02PM -0700, Compostella, Jeremy wrote:
> "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com> writes:
> > On Tue, Oct 03, 2023 at 02:06:52AM +0000, Huang, Kai wrote:
> >> On Tue, 2023-10-03 at 01:47 +0300, kirill.shutemov@linux.intel.com wrote:
> >> > On Fri, Sep 29, 2023 at 09:14:00AM +0000, Huang, Kai wrote:
> >> > > On Thu, 2023-09-28 at 15:30 -0700, Compostella, Jeremy wrote:
> >> > > > On TME enabled platform, BIOS publishes MTRR taking into account Total
> >> > > > Memory Encryption (TME) reserved bits.
> >> > > > 
> >> > > > generic_get_mtrr() performs a sanity check of the MTRRs relying on the
> >> > > > `phys_hi_rsvd' variable which is set using the cpuinfo_x86 structure
> >> > > > `x86_phys_bits' field.  But at the time the generic_get_mtrr()
> >> > > > function is ran the `x86_phys_bits' has not been updated by
> >> > > > detect_tme() when TME is enabled.
> >> > > > 
> >> > > > Since the x86_phys_bits does not reflect yet the real maximal physical
> >> > > > address size yet generic_get_mtrr() complains by logging the following
> >> > > > messages.
> >> > > > 
> >> > > >     mtrr: your BIOS has configured an incorrect mask, fixing it.
> >> > > >     mtrr: your BIOS has configured an incorrect mask, fixing it.
> >> > > >     [...]
> >> > > > 
> >> > > > In such a situation, generic_get_mtrr() returns an incorrect size but
> >> > > > no side effect were observed during our testing.
> >> > > > 
> >> > > > For `x86_phys_bits' to be updated before generic_get_mtrr() runs,
> >> > > > move the detect_tme() call from init_intel() to early_init_intel().
> >> > > 
> >> > > Hi,
> >> > > 
> >> > > This move looks good to me, but +Kirill who is the author of detect_tme() for
> >> > > further comments.
> >> > > 
> >> > > Also I am not sure whether it's worth to consider to move this to
> >> > > get_cpu_address_sizes(), which calculates the virtual/physical address sizes. 
> >> > > Thus it seems anything that can impact physical address size could be put there.
> >> > 
> >> > Actually, I am not sure how this patch works. AFAICS after the patch we
> >> > have the following callchain:
> >> > 
> >> > early_identify_cpu()
> >> >   this_cpu->c_early_init() (which is early_init_init())
> >> >     detect_tme()
> >> >       c->x86_phys_bits -= keyid_bits;
> >> >   get_cpu_address_sizes(c);
> >> >     c->x86_phys_bits = eax & 0xff;
> >> > 
> >> > Looks like get_cpu_address_sizes() would override what detect_tme() does.
> >> 
> >> After this patch, early_identify_cpu() calls get_cpu_address_sizes() first and
> >> then calls c_early_init(), which calls detect_tme().
> >> 
> >> So looks no override.  No?
> 
> No override indeed as get_cpu_address_sizes() is always called before
> early_init_intel or init_intel().
> 
> - init/main.c::start_kernel()
>   - arch/x86/kernel/setup.c::setup_arch()
>     - arch/x86/kernel/cpu/common.c::early_cpu_init()
>       - early_identify_cpu()
>         - get_cpu_address_sizes(c)
>           c->x86_phys_bits = eax & 0xff;
>         - arch/x86/kernel/cpu/intel.c::early_init_intel()
>           - detect_tme()
>             c->x86_phys_bits -= keyid_bits;

Hmm.. Do I read it wrong:

	static void __init early_identify_cpu(struct cpuinfo_x86 *c)
	{
	...
		/* cyrix could have cpuid enabled via c_identify()*/
		if (have_cpuid_p()) {
		...
		        // Here we call early_intel_init()
			if (this_cpu->c_early_init)
				this_cpu->c_early_init(c);
			...
		}

		get_cpu_address_sizes(c);
	...
	}

?

As far as I see get_cpu_address_sizes() called after early_intel_init().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
