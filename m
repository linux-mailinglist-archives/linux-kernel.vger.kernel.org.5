Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0B78270C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjHUK1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjHUK1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:27:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F0CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:27:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692613649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PEGrpL17h86clc4G/BzRA1o+ZeM6sg1+SQw+wMEtwig=;
        b=CDr50921G14KncyEPnv3ojer9xbVu2RALIJLatHm0gOevIOAdlydXNx99CFx117065fdq6
        v7Q+U2fzkkLikJFdP158K1R406sfC+YUVTZWUlkQvZDJcjgckBpNCwds0WVKNxP35ZqJxc
        3c/P39VkYC/wZLzbMFInh9XE19Eots6t0RtAcE4WzKhH4igGGDECsxNT7ZrqSM/jX7+ojq
        LG+RNSg/cZbcdFD67iqHF56jzUB9V+2qPS0M5nWIXryaewAb1ajC12JmgOQVazgh8bGzTU
        nZrKjTqRQAb44iGRryDhXcR1OSbKbKotpDRkEsNbVEH6YI4/XckWEAyN/fAxDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692613649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PEGrpL17h86clc4G/BzRA1o+ZeM6sg1+SQw+wMEtwig=;
        b=N+aU9srlEikl2kOQTRSpcj1g6xwqBCvzjBSIKAPD9adhwIhSxeYad965MDj0ZtmB+VhgXS
        VNGdl2bmeJe99VAA==
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
In-Reply-To: <MN0PR11MB6010D09FF7C20779B70A3B83E01BA@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
 <87il9hg67i.ffs@tglx>
 <MN0PR11MB6010CB72411BA723BEFC5565E017A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <877cpxioua.ffs@tglx>
 <MN0PR11MB601007E7DAE4C5FC86E58DB0E014A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <87fs4ighln.ffs@tglx>
 <MN0PR11MB6010D09FF7C20779B70A3B83E01BA@MN0PR11MB6010.namprd11.prod.outlook.com>
Date:   Mon, 21 Aug 2023 12:27:28 +0200
Message-ID: <874jksher3.ffs@tglx>
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

On Fri, Aug 18 2023 at 05:01, Len Brown wrote:
> Discussing further w/ Rui, we realized that is it not possible to
> future-proof the CPUID.1F code against the insertion of a new Domain
> at an unknown level in the hierarchy.  Further, CPUID.1F explicitly
> documents that we can not count on any numeric relationship between
> the Domain Type IDs to tell us between what levels of the hierarchy a
> future Domain may reside.

I realized that long before and explained it to Rui already quite some
time ago, no?

> For this reason, I recommend that we proceed with implementing
> internal kernel parsing of Domain Type ID 6 (DieGrp).  Even if DieGrp
> is a temporary name that changes to something else, we can assert that
> Domain Type ID 6 contains Die.  Thus, on a system with both DieGrp and
> Die, we know that multiple DieGrp produce multiple Die, rather than
> the reverse.
>
> If I understand your description correctly, you propose that if a
> level is not enumerated, that we assume its id is always 0.  I agree
> this is the right thing to do with Package, and we should continue
> doing it, because we always have a package.
>
> However, I don't think this is the right direction for the
> intermediate levels -- for their existence should be able to be used
> to enumerate the existence of level-specific features, and 0 suggests
> that those features exist when they may not.
>
> Take for example, module-scope MSRs and counters that do not exist on
> systems that do not have modules.
>
> We should only have a valid module_id if CPUID.1F has a non-zero shift
> width for Domain Type ID 3 (module).  Otherwise, we should probably be
> setting module_id to -1, so that code looking for those module
> features knows that they don't exist.  If we don't do this, that code
> will have to check model # (as it historically has) to determine if
> module-only features exist -- and we've thrown away the value of
> architectural level enumeration.
>
> The situation for die_id is similar, except that there are no die
> features that don't already exist as package features when there is
> just 1 die/package.  Ie. The die-aware code can simply revert to the
> package code when die_id= -1.
>
> This, of course, raises the question of the sysfs interface for
> die_id, and whether it should return -1 when there is no Die
> enumerated, or make that attribute simply not exist when there is no
> die_id.  Either would probably be an improvement over conjuring up a
> phony die_id=0 when no Die is actually enumerated.

You are still conflating things at different levels and the above is a
mixture of implementation details, historical anecdotes, user space
interface issues and whatever.

But you are still failing to look at it from a ground up conceptual
level.

1.) Parsing and storing enumeration

    The way how 0x1F is designed and how the APIC ID space is
    partitioned, makes it entirely clear that all domain levels must be
    evaluated no matter what and it's more than obvious that
    non-enumerated domain levels occupy _zero_ bits in the APIC ID
    partitioning and therefore end up being size _one_.

2.) IDs

    As a logical consequence of #1 each level - whether enumerated or
    not - has an ID. Obviously non-enumerated levels share the ID with
    the levels up the hierarchy.

    Overloading ID with some "it's not enumerated" value is conceptually
    completely wrong.

3.) Evaluation

    Runtime evaluation of the stored information can and in most cases
    has to take the (non-)enumeration into account. But that's a
    conceptually separate issue from #1 and #2.

    #1 is providing a trivial mechanism for that as it's obvious that a
    domain level is only enumerated when it occupies more than 0 bits.

4.) User space exposure

    That's an orthogonal problem, which obviously has to be addressed,
    but #1 - #3 provide _all_ required mechanisms to preserve the
    existing (bogus) semantics and to provide a new set of sensible
    interfaces which are more than just a new name and paint for the
    already existing bogosities.

The whole problem of the existing mechanims and the resulting nonsense
at the usage sites of topology information is that there is no concept
behind any of this. It's a mess of ad-hoc mechanisms which have been
glued on over time, which completely lacks consistency.

As a consequence the kernel has grown warts at all ends to deal with
this and the two series I'm working on are laying the groundwork to
clean this up on top of a consistent and understandable topology
mechanism, which also allows to grow into a central storage of such
information instead of having home brewn solutions in every other
subsystem.

I'm happy to listen to your ideas and thoughts as long as we are
debating things at the proper conceptual design levels. But I'm not
interested at all in random recommendations which just address the
symptoms and therefore are proliferating the lack of consistent design.

Thanks,

        tglx


