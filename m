Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD85578F950
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjIAHpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjIAHpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:45:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3ADE7F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:45:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693554330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=731aG89XBsqiLQAPbh3YxjNjhCdeTaBXPgPL1wszlac=;
        b=4fGcIEvdPkyS+AiFMWYyw3+vVxn14wzPxEJtFs+WwI9sf3Iom7x3D1+TeCVY8ib8x9Beb4
        KiQnTcaY5bV8XrAXZLkxPKgMXlT82/c0GM56ONn1H3HGDZFCBv8QZD9C1WPuK6UceFTDTr
        KKAfPYpVRu+h7+kQYzyPbMdB2DrmAFewKaRZ1JnRLYnmwWEpnKFKY2GfoO4XV73lhL/YT1
        714Sb68FMmFwK6Qegs+mWcvWrNI1EhghjOKu3OTBlDcKAGqlD4WqgMdcXKzqqmMbJ6p3+V
        7q5ohuwhUaQdXFCW9bhViyYvWwBKVgxG1s4aPG77w7bsFXJvhxZERL4vYEhSUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693554330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=731aG89XBsqiLQAPbh3YxjNjhCdeTaBXPgPL1wszlac=;
        b=E0bAMynasb1IYDa0YKOCgzFlbr/KE11LYItZ4SFVVrjVESeMCivBB71SzouHwREYEG5uxB
        i03dv8CsBlfgvlCQ==
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
In-Reply-To: <MN0PR11MB6010E31577416B56B708A3AFE0E4A@MN0PR11MB6010.namprd11.prod.outlook.com>
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
 <874jksher3.ffs@tglx>
 <MN0PR11MB6010F1D501B9A2C0B7B3D1F6E0E6A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <87r0nk66xl.ffs@tglx>
 <MN0PR11MB6010E31577416B56B708A3AFE0E4A@MN0PR11MB6010.namprd11.prod.outlook.com>
Date:   Fri, 01 Sep 2023 09:45:29 +0200
Message-ID: <87ledq49ra.ffs@tglx>
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

On Fri, Sep 01 2023 at 03:09, Len Brown wrote:
>> Conceptually _all_ levels exist, but the ones which occupy zero bits
>> have no meaning. Neither have the unknown levels if they should
>> surface at some point.
>>
>> So as they _all_ exist the logical consequence is that even those which occupy zero bits have an ID.
>>
>> Code which is interested in information which depends on the enumeration of the level must obviously do:
>>
>>    if (level_exists(X))
>>    	analyse_level(X)
>>
>> Whether you express that via an invalid level ID or via an explicit
>> check for the level is an implementation detail.
>
> Thank you for acknowledging that a level with a shift-width of 0 does
> not exist, and thus an id for that level has no meaning.

Even if the level is enumerated then there is no implicit meaning
attached per se. It's only relevant when there is a documented
relationship between the enumeration and secondary information attached
to it. Making implicit general assumptions about the meaning of an
enumeration is just not possible,

> One could argue that except for package_id and core_id, which always
> exist, maintainable code would *always* check that a level exists
> before doing *anything* with its level_id.  Color me skeptical of an
> implementation that does otherwise...

We have that today, no?

> So what are you proposing with the statement that "conceptually _all_
> levels exist"?

We need a consistent view on the topology and the only consistent view
is mathematical. Which means that a shift 0 element obviously has size
one because of size = 1 << SHIFT.

As a consequence these non-enumerated levels have an ID too, which in
turn makes the view on the topology consistent and independent of the
actually enumerated levels.

>> The problem of the current implementation is not that the die ID is
>> automatically assigned. The problem is at the usage sites which
>> blindly assume that there must be a meaning. That's a completely
>> different issue and has absolutely nothing to do with purely
>> mathematical deduced ID information at any given level.
>
> I agree that the code that exports the die_id attributes in topology
> sysfs should not do so when the die_id is meaningless.

The problem is not the fact that die_id is exposed. The problem is that
the meta information which allows to deduce meaning is not exposed along
with it. The fact that the exposure was half thought out makes is
slightly harder to correct that mistake, but I'm not yet convinced that
non-exposure is the correct answer in general.

> Ps. It is a safe bet that new levels will "surface at some point".
> For example, DieGrp surfaced this summer w/o any prior consultation
> with the Linux team.  But even if they did consult us and gave us the
> ideal 1-year before-hardware advance notice, and even if we
> miraculously added support in 0 time, we would still be 2-years late
> to prescriptively recognize this new level -- as our enterprise
> customers routinely run 3-year-old kernels.

That's a strawman as the enterprise people backport the world and some
more. So if there is timely upstream support then it will turn up in the
frankenkernels in time too. Arguably we could even backport the new
magic level ID to stable kernels as well as we do with other important
hardware related minimal addons.

> This is why it is mandatory that our code be resilient to the
> insertion of additional future levels.  I think it can be -- as long
> as we continue to use globally unique id's for all levels (IIR, only
> core_id is not globally unique today) and do _nothing_ with levels
> that have a 0 shift-width.

Die ID is relative too for no real good reason. Inside the kernel core
ID is not really required to be relative either.

Implementation wise it's just wrong to store this information in
cpu_info instead of doing a runtime evaluation of the topology
information, which allows to chose between global and relative IDs
depending on the requirements of the particular usage site.

The primary usage of these IDs is for initialization and everything
which needs this for hotpath usage converts it into a use case specific
cached representation anyway because accessing per cpu variables in a
hotpath is suboptimal at best.

Thanks,

        tglx
