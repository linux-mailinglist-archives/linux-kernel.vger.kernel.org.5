Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8542178DE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbjH3TB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343809AbjH3RBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:01:13 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E21FB19A;
        Wed, 30 Aug 2023 10:01:05 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 396A392009C; Wed, 30 Aug 2023 19:01:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2A5C692009B;
        Wed, 30 Aug 2023 18:01:04 +0100 (BST)
Date:   Wed, 30 Aug 2023 18:01:04 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Huacai Chen <chenhuacai@kernel.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v4 0/4] Modify die() for MIPS
In-Reply-To: <CAAhV-H4XDRGkFaqyOnTyDQo8M=nEUYf4B8kSiEWQpq6QB-yz5g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2308301619300.43104@angie.orcam.me.uk>
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn> <ZOxkt/6EkQIy+Jkt@alpha.franken.de> <ZO4Mdr9/XUkXDK9j@alpha.franken.de> <CAAhV-H4XDRGkFaqyOnTyDQo8M=nEUYf4B8kSiEWQpq6QB-yz5g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023, Huacai Chen wrote:

> > > series applied to mips-next.
> >
> > I've dropped the series again after feedback from Maciej, that this
> > still needs more changes.
> I feel a little surprised. This series has appeared for more than ten
> days and received some R-b, and we haven't seen any objections from
> Maciej. If there are really some bugs that need to be fixed, I think
> the normal operation is making additional patches...

 You haven't received any ack from me either, and I stopped reviewing the 
series as it was taking too much of my time and mental effort and yet 
changes were going in the wrong direction.  Silence never means an ack.

 It's up to the submitter to get things right and not to expect from the
reviewer to get issues pointed at by finger one by one, effectively 
demanding someone else's effort to get their own objectives complete even 
with the most obvious things.

 And then for a hypothetical case only that the submitter is not able to 
verify.  For such cases the usual approach is to do nothing until an 
actual real case is found.

 Very simple such a change that one can verify to an acceptable degree
that it is correct by just proofreading might be accepted anyway, but it 
cannot be guaranteed.

 The missed NMI case only proved the submitter didn't do their homework 
and didn't track down all the call sites as expected with such a change, 
and instead relied on reviewer's vigilance.

 As to the changes, specifically:

- 1/4 is bogus, the kernel must not BUG on user activities.  Most simply
  die() should be told by the NMI caller that it must not return in this 
  case and then it should ignore the NOTIFY_STOP condition.

  I realise we may not be able to just return from the NMI handler to the 
  location at CP0.ErrorEPC and continue, because owing to the privileged 
  ISA design we won't be able to make such an NMI handler reentrant, let 
  alone SMP-safe.  But it should have been given in the change description 
  as rationale for not handling the NOTIFY_STOP condition for the NMI.

  I leave it as an exercise to the reader to figure out why a returning 
  NMI handler cannot be made reentrant.

- 2/4 should be a one-liner to handle the NOTIFY_STOP condition just as 
  with the x86 port, which I already (!) communicated, and which was (!!!) 
  ignored.  There is no need to rewrite the rest of die() and make it more 
  complex too just because it can be done.

- 3/4 is not needed if 2/4 was done properly.  And as it stands it should 
  have been folded into 2/4, because fixes to an own pending submission 
  mustn't be made with a separate patch: the original change has to be 
  corrected instead.

- 4/4 is OK (and I believe the only one that actually got a Reviewed-by: 
  tag).

Most of these issues would have been avoided if the submitter made 
themselves familiar with Documentation/process/submitting-patches.rst and 
followed the rules specified there.

 Otherwise this takes valuable reviewer resources that would best be used 
elsewhere and it puts submitters of quality changes at a disadvantage, 
which is not fair.

 It is not our policy to accept known-broken changes and then fix them up 
afterwards.  Changes are expected to be technically sound to the best of 
everyone's involved knowledge and it's up to the submitter to prove that 
it is the case and that a change is worth including.  You would have 
learnt it from the document referred.  Nobody's perfect and issues may 
slip through, but we need to make every effort so as to avoid it.

 Mind that we're doing reviews as volunteers entirely in our free time we 
might instead want to spend with friends or in another enjoyable way.  It 
is not my day job to review random MIPS/Linux patches posted to a mailing 
list.  Even composing this reply took a considerable amount of time and 
effort, which would best be spent elsewhere, because I am talking obvious 
things here and repeating Documentation/process/submitting-patches.rst 
stuff.

  Maciej
