Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106EC7E1A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjKFGPJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 01:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFGPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:15:07 -0500
Received: from comms.drone (in.bow.st [71.19.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A1493
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:15:01 -0800 (PST)
Received: from homebase (unknown [IPv6:fe80::2259:21a4:f292:8bfb])
        by comms.drone (Postfix) with ESMTPSA id 85F4FFCF9;
        Mon,  6 Nov 2023 06:14:58 +0000 (UTC)
From:   "Mathew\, Cherry G.*" <c@bow.st>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC+Patch] Formal models as source of truth for Software Architects.
References: <85v8axxrmo.fsf@bow.st>
        <2defe3ff-90df-2627-dd19-0442a90b20a4@huaweicloud.com>
        <857cmw2ael.fsf@bow.st>
        <b260c8f8-266f-08c5-2e87-875174042a5b@huaweicloud.com>
Date:   Mon, 06 Nov 2023 06:12:25 +0000
In-Reply-To: <b260c8f8-266f-08c5-2e87-875174042a5b@huaweicloud.com> (Jonas
        Oberhauser's message of "Sun, 5 Nov 2023 22:06:21 +0100")
Message-ID: <85lebb1kc6.fsf@bow.st>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (berkeley-unix)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

>>>>> Jonas Oberhauser <jonas.oberhauser@huaweicloud.com> writes:


[...]


    > I meant that we implemented an internal tool to transpile from C
    > to PlusCal.

I'm curious about the design/architecture here - how did you manage the
logical mappings from C->PlusCal - did you have a third language to
specify the mappings, or did you use heuristics with inherent
assumptions ?

    > It sounded like a great idea at the time. But then it quickly fell
    > out of use.

This is something I'm keen to understand why - was this because
programmers focussed on the C code, and the transpiler+constraints
became a "testing problem" which ended up in bitrot ? Or is there
something related to the software methodology/development process ? Or
perhaps the percieved ROI of formal verification wasn't as much as
initially thought ? Something else ?


[...]


    > For reuse, I think the main issue is that implementation code is
    > always a source of truth - the truth of what's really going to be
    > executed.  If we want to have a second source of truth, it should
    > be a different truth, such as "assumptions of the other parts of
    > the system".

    > Since you already have this source of truth, if you make a
    > different implementation in another kernel, you can compare what
    > the original driver was doing with what your new implementation is
    > doing.  There's no need to have yet another copy of what the
    > driver might be doing.


I understand what you're saying, but there are a few points that I'm
probably not able to express clearly.

Just to set context, and not to state the obvious - as you likely
already know, Formal languages such as pluscal or promela have an
"execution model" that is different from a programming language - in
that, when one writes code in them, one's mental model needs to pay
attention to behaviour, whereas function becomes a more abstract
problem, as you  pointed out. I wrote a very hand wavy description of
this in the context of spin:

https://mail-index.netbsd.org/tech-kern/2023/09/28/msg029203.html

I believe this kind of mental frame needs its own discipline, and is an
opportunity to divide concerns - that of design/architecture vs. that of
engineering/implementation.

So to return to your concern about code duplication, in the context of
codegen, one could make the same argument about compiled or transpiled
code - if it were manually transpiled. And yet we are comfortable as
programmers, assuming that the "higher level language" is the source of
truth, while happily stepping "down" to gcc __inline__ __asm__ {} when
needed. So, for eg: (and I believe there are tools out there that can
do this to some degree) - if the programming code could be
auto-generated/"compiled" from the formal specification, then this would
become directly analogous. 


[...]

    >> Can you give me an example of how this works/a pre-existing tool
    >> that helps with this simplification ? I'm actually currently
    >> looking at re-writing modex to do precisely this (but with the
    >> translation end-point being something close to the original
    >> model).


    > I think any higher level language, including C, goes into this
    > direction. Some are just a lot better at building abstractions and
    > describing the code more model-like than
    > tiniest-implementation-detail-like.

C is problematic because it doesn't for eg: define concurrency or
consistency models - in many cases, even the data types are not clearly
defined (eg: "integer" is machine word size dependant). So it's really
hard to specify something formal at the level of C that is not very
context (OS/CPU arch) specific. This is one of the reasons why for eg:
in spin's promela, data types are extremely limited, and very precisely
defined. I'm sure there are several other differences, I'm not expert
enough to comment - just sharing my observations so far. The point being
that programming languages such as C are probably not expressive enough
to encapsulate formal models precisely enough. 

    > (and sometimes that's not what you want).

    >> > So writing the blueprint twice - once in some modelling
    >> language > and once in a language meant for execution - doesn't
    >> really > provide a lot of benefit.  But it requires doing changes
    >> at two > levels whenever the software design changes. It just
    >> violates DRY.
    >> 
    >> IMHO, this would be true if:
    >> 
    >> a) The implementation language was expressive enough to cleanly
    >> encapsulate the model.
    >> 
    >> b) If the toolchain around it were able to do model verification
    >> (eg: by exploring LTL bounds).


    > We are building internal tools for such b) things. Not quite
    > exhaustive formal verification tools, but tools that can express
    > and check more complex properties at source level without false
    > positives.

    > (They may have false negatives, but that's not really a
    > showstopper. False positives would be.)

Fair enough - this is the level of tradeoff that only someone with a
clear industrial application would be able to make, as I imagine you
are. This is also where I believe the gap between theory (of formal
methods) and practise is, so this is insightful - I'd be curious to know
more, if you're able to share.


[...]

    >> 
    >> I'm a bit skeptical about the "doxygen" approach (i've seen this
    >> in some versions of Java iirc, as well) - basically you're
    >> bypassing all the goodness that the language parser provides by
    >> hiding from it - I'm not sure how this is useful other than to
    >> shimmy in a specific bandaid fix. Which is fine, if you're
    >> fighting fires, but I think for a more structured approach, I'm
    >> not seeing what you're seeing, I'm afraid. Open to be signposted
    >> though.


    > By executable comment I mean a comment that has a formal semantics
    > that can be executed.

    > Think more pre&post conditions + ghost code. E.g., for a tricky
    > sort algorithm like timsort the comment might be something like

    > var __ghost_array = copy(input_array);

    > .... // complicated timsort code here

    > insertion_sort(&__ghost_array); // timsort should give the same
    > output as insertion stort, note that both are stable

    > for (i in 0...array_len) {     assert (sorted_array[i] ==
    > __ghost_array[i]); }


    > This is probably not going to help you find the well-known timsort
    > bug, but it might be enough to find more trivial mistakes when
    > rolling your own timsort.  Anyways this is what I mean by
    > executable comment - a more readable, maintainable implementation
    > of the code that tells you what the code ought to be doing + some
    > checks to say that they're really doing the same thing.

This looks closer to testing to me - the assertions for eg: seems to be
atemporal ie; only concerned about "immedate" values, unlike LTL which
can check behaviour across an "execution sequence" (in the set of all
possible execution sequences). So from an FV perspective, I would write
the assertion to look more like: "eventually is_sorted(array)", where
is_sorted() has magic to check to if the array elements are sorted in
whatever required order.

    > As I understand, doxygen is just a way to link human-readable
    > documentation with code, but maybe I'm wrong about this.

Yes, I just meant that as a way to put parsable code in comments.

[...]

    >> 
    >> So in some sense, I believe we're nearing the "Deep Neural Nets"
    >> moment, when GPU computation took inference to the next level.


    > Yeah, it's pretty impressive. Actually even the power of laptops
    > is pretty impressive.  Things like GenMC or Dat3M can do bounded
    > verification of (slightly massaged) C algorithms from the linux
    > kernel by more or less exploring the full execution space (of a
    > bounded client) within a couple of minutes on a laptop.

    > But for many scenarios, we are still a factor of at least
    > trillions away from using something where exhaustive exploration
    > works - not something that we'll fix by tying a bunch of
    > supercomputers together...


I agree - but it's still quite impressive - plus there are ways to be
smart about bounding the search space - eg: using modularity and
inter-module communications interfaces, optimisation techniques such as
partial order reduction, etc. I'm sure you've made those optimisations -
and I'm curious to know what kind of "CI" performance is possible in
state of the art.

Best,

-- 
MattC/(~cherry)
