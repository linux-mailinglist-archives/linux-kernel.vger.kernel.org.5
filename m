Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7067E16BC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjKEVB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEVB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:01:57 -0500
X-Greylist: delayed 596 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 13:01:53 PST
Received: from comms.drone (in.bow.st [71.19.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA397
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 13:01:52 -0800 (PST)
Received: from homebase (unknown [IPv6:fe80::2259:21a4:f292:8bfb])
        by comms.drone (Postfix) with ESMTPSA id AC187FDA7;
        Sun,  5 Nov 2023 20:51:52 +0000 (UTC)
From:   "Mathew\, Cherry G.*" <c@bow.st>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC+Patch] Formal models as source of truth for Software Architects.
In-Reply-To: <2defe3ff-90df-2627-dd19-0442a90b20a4@huaweicloud.com> (Jonas
        Oberhauser's message of "Mon, 30 Oct 2023 11:47:12 +0100")
References: <85v8axxrmo.fsf@bow.st>
        <2defe3ff-90df-2627-dd19-0442a90b20a4@huaweicloud.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (berkeley-unix)
Date:   Sun, 05 Nov 2023 20:49:22 +0000
Message-ID: <857cmw2ael.fsf@bow.st>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

First of all, sorry for my late reply - I note with thanks, that you
spent some time and attention on your email, so I wanted to spend some
time composing a thoughtful reply. I'm replying in context below:


>>>>> Jonas Oberhauser <jonas.oberhauser@huaweicloud.com> writes:


[...]


    > A few years ago we also built systems to extract models from C
    > code (for TLA+ back then), but those systems are now totally
    > unused (and unmaintained) due to poor scalability of exploratory
    > state-based model checking.

    > And then there's the issue that many engineers don't know how to
    > write reasonable temporal assertions, especially not ones that can
    > give sufficient guarantees to be worth the extra effort and
    > maintenance.

So my arrival at "D3" and spin was a progression of looking at what's
available (in the open domain), current consensus around development
methodology, and progress in hardware capacity.

I've used TLA+ for protocol verification, and while it's great for that,
I didn't see it translate to and from implementation code. The best I
was able to do was to use a functional language to mirror the lambda
calculus - see: https://github.com/byisystems/byihive for eg:

One of the main motivations for my current "D3" path is to provide a
cleaner separation between design and implementation - where the
"Architect" role does design, and the "Engineer" role does
implementation. This allows for each role to focus on what they do best,
while the machine is tasked with maintaining functional equivalence. 

I suspect that your experience was due to the fact that engineers had to
get involved in design, without understanding or consenting to this.

    > If we use a simplified model of what the system should be doing to
    > specify, then usually we are not looking for equivalence but only
    > for uni-directional simulation: the spec usually needs to have
    > more degrees of freedom than the implementation, which is just a
    > single implementation.

So spin has two approaches - one uses the inline "C" to glue the spec as
a sort of "test driver" for implementation code if required. The other
uses a separate source level model extractor, to rebuild the implicit
model in the implementation C code. I am leaning towards the latter,
because it seems to help with streamlining the  software development
process as an iteration - which helps especially in early nascent stages
of design & development. What I'm beginning to see is that once design
"settles down", then the iterations become less disruptive. But
initially, the Architect/Engineer hats need very good interaction.


    > What has worked well for us is anything that works

    > - directly on the code

    > - doesn't require learning any kind of math to find bugs with

    > - is scalable enough to find bugs on real code

    > - doesn't require a lot of extra effort from the engineers
    > (compared to the extra assurance you get)

    > - doesn't need to be adapted whenever the code changes

Have you seen spoq ?

https://www.usenix.org/conference/osdi23/presentation/li-xupeng

They use this approach - one of the reasons I'm not fully convinced by
this approach is because, I believe that the source of truth being in
implementation code limits flexibility, for eg: reuse. If you notice my
original patch, the model is a reference for both the NetBSD and Linux
drivers - nothing stops it from further OSs (as long as the codeflow
logic doesn't vary too much - and even then, the model could itself be
made modular to accommodate different FSMs)

    > I find in software, usually blueprint and skyscraper are in some
    > sense the same thing.  Or in some sense, the skyscraper is
    > extracted automatically by a compiler/interpreter and installation
    > system - we never actually dig anything ourselves, but have the
    > ability to experiment directly on the blueprint as we build it.

    > That's because languages already try to provide us reasonable
    > abstraction mechanisms by which we can simplify the code and make
    > it more "model-like".

Can you give me an example of how this works/a pre-existing tool that
helps with this simplification ? I'm actually currently looking at
re-writing modex to do precisely this (but with the translation
end-point being something close to the original model).

    > So writing the blueprint twice - once in some modelling language
    > and once in a language meant for execution - doesn't really
    > provide a lot of benefit.  But it requires doing changes at two
    > levels whenever the software design changes. It just violates DRY.

IMHO, this would be true if:

a) The implementation language was expressive enough to cleanly
   encapsulate the model.

b) If the toolchain around it were able to do model verification (eg: by
exploring LTL bounds).

I've heard good things about rustlang wrt. a), but not b) - would be
keen to know more.

    > What makes sense in our experience is identifying properties you
    > would like the system to have and devising a specific checking
    > mechanism for that.  For example, you might specify the protocol
    > of how the device communicates with the system and what
    > assumptions it has (like "don't start a second command while the
    > first one hasn't finished"), and then check that the driver code
    > obeys this policy.  Then you can change the software code without
    > touching the protocol specification, and just re-verify.

    > In the easiest case, the protocol can be a mock device process
    > that is inserted via a form of dependency injection to talk to the
    > real driver code during verification, and if the code isn't too
    > complex you can exhaustively check several test cases.


Ok, from what I understand, this is a "system model" - when I talk about
D3, I'm purely talking about the software model. This model may be part
of a larger scope "system model".

Event-B
http://www.event-b.org/index.html
https://web-archive.southampton.ac.uk/deploy-eprints.ecs.soton.ac.uk/111/1/sld.ch1.intro.pdf

is an interesting (closed) industry take on what you seem to be
describing - and they seem to have taken a more "D3" like approach -
I don't have much insight into their experiences though, although I'm
speaking to one of their practitioners.


    > Only if the code is highly unreadable for specific reasons like
    > performance or talking to legacy ABIs, it can make sense to have
    > an "executable comment" that implements the same functional
    > behavior in a very concise, readable way (with crud
    > performance/mock APIs replacing the actual behavior), and check
    > that the real code and the "executable comment" do "the same
    > thing".

I'm a bit skeptical about the "doxygen" approach (i've seen this in some
versions of Java iirc, as well) - basically you're bypassing all the
goodness that the language parser provides by hiding from it - I'm not
sure how this is useful other than to shimmy in a specific bandaid
fix. Which is fine, if you're fighting fires, but I think for a more
structured approach, I'm not seeing what you're seeing, I'm afraid. Open
to be signposted though.


    > The main issues I see when we look at it through the skyscraper
    > analogy is that usually people in other engineering disciplines
    > have CAD tools - backed by very powerful computers - to really
    > systematically and thoroughly check the design.  What we usually
    > have is stress testing and some test suites built by hand that
    > miss many cases.

Interestingly, I was surprised at the amount of compute available "off
the shelf" - the other day I sent a model for help, saying with a bit of
trepidation that that it might take about 25G of RAM and thrash the
machine, so please be careful - the volunteer came back to me and said
he has 128G RAM  available, and 1TB RAM on a pinch! What takes an hour
to run on my i5 + 16GB laptop, took him 3minutes!

So in some sense, I believe we're nearing the "Deep Neural Nets" moment,
when GPU computation took inference to the next level.


    > Anyways, that's my (limited) experience.

    > Hope it helps,

Yes - thank you so much for your interest! I look forward to further
comments - and also, if there are industry applications that benefit
from the broad intersect, any signposts will be much appreciated!

Best,
-- 
MattC
