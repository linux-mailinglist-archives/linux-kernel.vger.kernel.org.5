Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B870A77F2CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349317AbjHQJKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349318AbjHQJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:10:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21719198E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:09:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692263397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gdd6en48U+LDOcM3KZoEr2Q34+pgyB8St54PrBtO7Dw=;
        b=zg27N+PdpWwQniuQtONRZ5lDYk9hicVEAaxWvBmo7/cJLTmn18vSi92RofTa939ykOtafE
        19ktxJikTtoC8yFy3b7VO7fTxiD3LwE2tYJNMYMkvSwFHSEc7NgwI+lb1CDh+tMHjGEQ+S
        Unh+ZOafuJY7zRqUWlX9SykvOs9W6xI/T8kgZkpwZ6/TYBh25pc0HyEagAC+S95cJ+INEx
        9K8F5PcHCfcnoHNGeoulSjtNVGCZ9NDTV/YquR9BU1excq8IviApfSdIj2gE4iIMiUJ+6q
        C9HWvmFt+EcyK7jjhA16ICUaTIWiPSBgZZ2foXPbBjk1UFSpj+Cp8Tb1qiNg+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692263397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gdd6en48U+LDOcM3KZoEr2Q34+pgyB8St54PrBtO7Dw=;
        b=/obUQhrlLcBgHpNOaoBhC/EmkALC4BMVs3cZvEjJabv2jT+evK/sQ15VpGMQYQw9JL6usA
        bVkE1ZKev1z5LLBw==
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
In-Reply-To: <MN0PR11MB601007E7DAE4C5FC86E58DB0E014A@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
 <87il9hg67i.ffs@tglx>
 <MN0PR11MB6010CB72411BA723BEFC5565E017A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <877cpxioua.ffs@tglx>
 <MN0PR11MB601007E7DAE4C5FC86E58DB0E014A@MN0PR11MB6010.namprd11.prod.outlook.com>
Date:   Thu, 17 Aug 2023 11:09:56 +0200
Message-ID: <87fs4ighln.ffs@tglx>
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

On Tue, Aug 15 2023 at 19:30, Len Brown wrote:
> In retrospect, we under-specified what it means to enumerate a
> CPUID.1F die, because it has been a constant battle to get the HW
> people to *not* enumerate hidden die that software does not see.
>
> Indeed, we were equally guilty in not codifying an architectural
> definition of "module" and "tile", which were placed into the CPUID.1F
> definition mostly as place-holders with awareness of hardware
> structures that were already in common use.  For example, there were
> already module-scoped counters that were hard-coded, and enumerating
> modules seems to be an to give architectural (re-usable) enumeration
> to model-specific code.

Sure 0x1f is underspecified in terms of meaning of the intermediate
levels, but it's perfectly parseable. Once there is information how to
actually utilize MODULE or TILE for software decisions, then it can be
implemented. Until then we still have to can parse it and otherwise just
ignore it. Where is the problem?

> Second, failings of the Linux topology code...
>
> I agree with you that "thread_siblings" and "core_cpus" are the
> different words for the same thing.  This will always be true because
> the hardware architecture guarantees that SMT siblings are the next
> level down from core.

Right. So you "fix" was pure cosmetic.

> But no such definition exists for "core_siblings".  It is impossible
> to write correct software that reads "core_siblings" and takes any
> action on it.  Those could be the CPUs inside a module, or inside a
> die, or inside some other level that today's software can't possibly
> know by name.
>
> On the other hand, die_cpus is clear -- the CPUs within a die.
> Package_cpus -- the CPUs within a package.
> Core_cpus -- the cpus within a core....
> Words matter.

Of course does terminology matter, but that's not the real problem.

> Re: globally unique core_id
>
> I have 100% confidence that you can make the Linux kernel handle a
> sparce globally unique core_id name space.  My concern is unknown
> exposure to joe-random-user-space program that consumes the sysfs
> representation.

You simply can keep the current representation for proc and sysfs with
the relative IDs and just make the kernel use unique core IDs. The
kernel needs to be sane before you can even think about user space
exposure.

>>> Secondly, with the obsolescence of CPUID.0b and its replacement with 
>>> CPUID.1F, the contract between The hardware and the software is that a 
>>> level can appear and can in between any existing levels.  (the only 
>>> exception is that SMT is married to core).
>
>> In theory, yes. But what's the practical relevance that there might
>> be a new level between CORE and MODULE or MODULE and TILE etc...?
>
>>> It is not possible For an old kernel to know the name or position of a 
>>> new level in the hierarchy, going forward.
>
>> Again, where is the practical problem? These new levels are not going
>> to be declared nilly willy and every other week, right?
>
> It is irrelevant if a new level is of any practical use to Linux.
>
> What is important is that Linux be able to parse and use the levels it
> finds useful, while gracefully ignoring any that it doesn't care about
> (or doesn't yet know about).
>
> Yes, hardware folks can drop something into the ucode and the SDM w/o
> us knowing ahead of time (see DieGrp in the June 2023 SDM).  Certainly
> they can do it in well under the 4-year's notice we'd need if we were
> to simply track the named levels in the SDM.

That's a matter of education of the hardware people. Sure they can do
whatever they want, but if they want us to provide primary support for
the stuff they dream up, then they better go and tell us early enough.

>>> Today, this manifests with a (currently) latent bug that I caused.
>>> For I implemented die_id In the style of package_id, and I shouldn't 
>>> have followed that example.
>
>> You did NOT. You implemented die_id relative to the package, which
>> does not make it unique in the same way as core_id is relative to the
>> package and therefore not unique.
>
> The point is that like package_id=0 on a single package system, I put
> a die_id=0 attribute in sysfs even when NO "die" level is enumerated
> in CPUID.1F.
>
> That was a mistake.

No. It's not a mistake. Conceptually the DIE level exists even if not
enumerated. It consumes zero bits and therefore has size 1.

>>> Today, if CPUID.1F doesn't know anything about multiple DIE, Linux 
>>> conjurs up A die_id 0 in sysfs.  It should not.  The reason is that 
>>> when CPUID.1F enumerates A level that legacy code doesn't know about, 
>>> we can't possibly tell if it is above DIE, or below DIE.  If it is 
>>> above DIE, then our default die_id 0 is becomes bogus.
>
>>That's an implementation problem and the code I posted fixes this by
>>making die_id unique and taking the documented domain levels into
>>account.
>
> Your code change does not fix the problem above.

Why are all of you so fixated on domain levels which are not documented
today? Either you know something which I don't know or you are just
debating an academic problem to death.

>> So if 0x1f does not enumerate dies, then each package has one die and
>> the die ID is the same as the package ID. It's that simple.
>
> Unfortunately, no.
>
> Your code will be written and ship before level-X is defined.
>
> A couple of years later, level-X is defined above die.  Your code runs
> on new hardware that defines no packages, level-X, and no die.  How
> many die-id's does this system have?
>
> If you could see into the future, you'd answer that there are 2-die,
> because There is one inside each level-X.
>
> But since die isn't enumerated, and you don't know if a level-X is
> defined to be above or below die, then you can't tell if level-X is
> something containing die, or something contained-by die...
>
> The proper solution is to not expose a die_id attribute in sysfs if
> there is no die level enumerated in CPUID.1F.  When it is enumerated,
> we get it right.  When it is not enumerated, we don't guess.

The main problem is the kernel side itself. /proc/ /sys/ are things
which can do conditinal exposure, but you can't do so in the kernel.

Fact is that the APIC ID space is segmented to reflect the today
decribed topology domains:

     [PKG] [DIE] [TILE] [MODULE] [CORE] [THREAD]

Each of them can occupy 0 or more bits. So using an internal
representation for them which treats them as size one if not specified
is the obvious and right thing to do.

You cannot create a software monstrosity which makes everything
conditional. It's neither workable nor maintainable. You need a
consistent view independent of the enumerated levels in 0x1F and as a
consequence you have to assume that the non-enumerated levels consume
zero bits in the APIC ID space and have size one.

If the hardware people fail to understand that software needs a
consistent representation of these things, then we can give up and just
refuse to parse 0x1f at all.

Now lets look at your imaginary future systems enumeration:

     [LEVELX] [CORE] [THREAD]

You have to take LEVELX - even if unknown to the kernel - into account
to evaluate the APID ID range which defines the package space.

Otherwise you obviously just have to ignore it because yes, it's unknown
between which domain levels this is going to sit.

But this assumes that LEVELX is going to appear out of the blue just
because the hardware people took the wrong pills. So it's our internal
problem to educate them so this won't happen.

>> What do you win by removing them from the SDM?
>
> When you give HW people enough rope to hang themselves, they will.

You are not preventing this by removing the MODULE/TILE domains
from the SDM.

> Give them something vague in the SDM, and you've created a monster
> that is interpreted differently by different hardware teams and no
> validation team on the planet can figure out if the hardware is
> correct or not.  Then the definition becomes how the OS (possibly not
> Linux) happened to use that interface on some past chip -- and that
> use is not documented in the SDM -- and down the rabbit hole you go...
>
> When the SDM precisely documents the software/hardware interface, then
> proper tests can be written, independent hardware teams are forced to
> follow the same definition, and correct software can be written once
> and never break.

I agree with that sentiment in principle, but you lost this battle
already because there is hardware which enumerates MODULE.

[    0.212535] CPU topo: Thread    :     8
[    0.212537] CPU topo: Core      :     8
[    0.212539] CPU topo: Module    :     2

So what are we going to do about that? Just pretend that it does not
exist?

Sure, we can do that. But I'm also 100% sure, that there is a meaning
which goes beyond the pure physical description of the CPU.

Yes, this description is not there today, but we still have to utilize
the enumeration level for evaluating the APIC ID bit range which defines
the package ID space.

That does not mean that we have to put a meaning on that level by doing
wild guesses. That'd be completely wrong and would cause the problems
you are so worried about.

Why has this even still to be debated? 0x1F support was merged more than
four years ago and we are now indulging in debating academic problems of
unknown levels appearing out of the blue in systems which ship today.

There is a meaning to the existing levels, so time is better spent to
get that documented.

Thanks,

        tglx
