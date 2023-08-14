Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6136677BDB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjHNQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjHNQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:13:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE6F1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:13:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692029629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Qzw0IFAL4/OKUWt3YeRzFLyAERWgMbI52rWvWN3oB0=;
        b=lF/bxBHVmFO15srOv3DH8puUiVk9nwnmOrYQPljBQ8CH+V+cQiSWCL+BF9Z0wfSMlSEHi1
        X26p4s/yOL3b7ikqdfaQGC1xu99JTt+bj4PA0i/mLu9zM01A/HC4tMdJNdeLiBZaejajB4
        2ejeWfiEvb6Z6KizAjE+4Fx7Hl5zIrxFSULIdumtttv/AYKT/hXB+ySIuSnLclICQ33qA3
        HEZrzgZzWvWX6dHjqXR0hheQ7BRWCbW0kmCh6rX4rkcEGMWZMXzwv/uJ9cMfATXCH16CqW
        u6wySSsNSK3NJyEwCcNny/w6VWotvSC6vHbDgNJ+sPQ4W7CETdJH+i1a8zYWoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692029629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Qzw0IFAL4/OKUWt3YeRzFLyAERWgMbI52rWvWN3oB0=;
        b=Fd95f3b06y/yxvwl2W17o7BXpyx40T35QOa2vJG98CUR/mq9yjCMZhPmWWx+SLx48e5qa9
        iDxg/UtM5BHKLKDg==
To:     "Brown, Len" <len.brown@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
In-Reply-To: <MN0PR11MB6010CB72411BA723BEFC5565E017A@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
 <87il9hg67i.ffs@tglx>
 <MN0PR11MB6010CB72411BA723BEFC5565E017A@MN0PR11MB6010.namprd11.prod.outlook.com>
Date:   Mon, 14 Aug 2023 18:13:49 +0200
Message-ID: <877cpxioua.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len!

On Mon, Aug 14 2023 at 14:48, Len Brown wrote:
> First,  with multiple cores having the same core_id.
> A consumer of core_id must know about packages to understand core_id.
>
> This is the original sin of the current interface -- which should
> never have used the word "sibling" *anyplace*, Because to make sense
> of the word sibling, you must know what *contains* the siblings.

You're conflating things. The fact that core_id is relative to the
package has absolutely nothing to do with the concept of siblings.

Whether sibling is the right terminology or not is a problem on its own.

Fact is that CPUs are structured in different domain levels and that
structuring makes some sense as it reflects the actual hardware.

The question whether this structuring has a relevance for software or
not, is independent of that. That's something which needs to be defined
and there are certainly aspects which affect scheduling, while others
affect power or other entities and some affect all of them.

> We introduced "core_cpus" a number of years ago to address this for
> core_ids (and for other levels, Such as die_cpus).  Unfortunately, we
> can probably never actually delete threads_siblings and core_siblings
> Without breaking some program someplace...

Sorry, but "core_cpus" is just a different terminology. I'm not seeing
how this is solving anything.

> Core_id should be system-wide global, just like the cpu number is
> system wide global.  Today, it is the only level id that is not system
> wide global.

That's simply not true. cpu_info::die_id is package relative too, which
is silly to begin with and caused to add this noisy logical_die_id muck.

> This could be implemented by simply not masking off the package_id
> bits when creating the core_id,

You have to shift it right by one, if the system is SMT capable, or just
use the APIC ID if it's not (i.e. 0x1f subleaf 0 has a shift of 0). Not
more not less.

Alternatively all IDs are not shifted right at all and just the bits
below the actual level are masked off.

> Like we have done for other levels.

Which one exactly? The only level ID which is truly system wide unique
is package ID.

Die ID is not and core ID is not and there are no other levels the
current upstream code is dealing with.

> Yes, this could be awkward for some existing code that indexes arrays
> with core_id, and doesn't like them to be sparse.  But that rough edge
> is a much smaller problem than having to comprehend a level (package)
> that you may Otherwise not care about.  Besides, core_id's can already
> be sparse today.

It's not awkward. It's just a matter of auditing all the places which
care about core ID and fixing them up in case they can't deal with it.
I went through the die ID usage before making die ID unique to ensure
that it wont break anything.

I surely have mopped up more complex things than that, so where is the
problem doing the same for core ID?

> Secondly, with the obsolescence of CPUID.0b and its replacement with
> CPUID.1F, the contract between The hardware and the software is that a
> level can appear and can in between any existing levels.  (the only
> exception is that SMT is married to core).

In theory, yes. But what's the practical relevance that there might be a
new level between CORE and MODULE or MODULE and TILE etc...?

> It is not possible For an old kernel to know the name or position of a
> new level in the hierarchy, going forward.

Again, where is the practical problem? These new levels are not going to
be declared nilly willy and every other week, right?

> Today, this manifests with a (currently) latent bug that I caused.
> For I implemented die_id In the style of package_id, and I shouldn't
> have followed that example.

You did NOT. You implemented die_id relative to the package, which does
not make it unique in the same way as core_id is relative to the package
and therefore not unique.

Package ID is unique and the only reason why logical package ID exists
is because there have been systems with massive gaps between the package
IDs. That could have been handled differently, but that's again a
different story.

> Today, if CPUID.1F doesn't know anything about multiple DIE, Linux
> conjurs up A die_id 0 in sysfs.  It should not.  The reason is that
> when CPUID.1F enumerates A level that legacy code doesn't know about,
> we can't possibly tell if it is above DIE, or below DIE.  If it is
> above DIE, then our default die_id 0 is becomes bogus.

That's an implementation problem and the code I posted fixes this by
making die_id unique and taking the documented domain levels into
account.

So if 0x1f does not enumerate dies, then each package has one die and
the die ID is the same as the package ID. It's that simple.

> That said, I have voiced my objection inside Intel to the creation of
> random levels Which do not have an architectural (software)
> definition; and I'm advocating that They be *removed* from the SDM
> until a software programming definition that Spans all generation is
> documented.
>
> SMT, core, module, die and the (implicit) package may not be well
> documented, But they do have existing uses and will thus live on.  The
> others maybe not.

Why removing them? If there is no documentation for using them then
software will ignore them, but they reflect how the hardware is built
and according to conversations with various people this topology
reflects other things which are undocumented.

What do you win by removing them from the SDM?

Absolutely nothing. Actually you lose because if they get added with
information how software should use those levels then the whole problem
I discussed with Rui about imaginary new domain levels surfacing in the
future is there sooner than later. If we deal with them correctly today
and ignore them for then kernels will just work on systems which
enumerate them, they just wont make use of these levels.

The amount of extra storage to handle them is marginal and really not
worth to debate.

Thanks,

        tglx
