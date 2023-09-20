Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C317A8DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjITUpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITUpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:45:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF453BB;
        Wed, 20 Sep 2023 13:45:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45759C433C8;
        Wed, 20 Sep 2023 20:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695242726;
        bh=Hx+q61jajuliDCZJUgYhvKUrGKzfegjn/TP0h2Ov1Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVm4FjIYgfM/qdkOdiTv2g5lm/WKMcQuw5C3HLtZS00D9g3EOUPRKRyPkIc1rmvPA
         qp1Hu5NYlj+VLN5u1PfY2OEUQOgL/cH5OCvtoQS+WPN2Z1hmWqfWD8lbhL+WhyLUrk
         I1fDWgDvk2z8qte6fXLOxCG/P6B0CxwmHVY9jWx5X8YpYFuHaG99xq2A25zq8aX1Gv
         /stmkEk4S0kyJDlQQqZfmE4D0qcWj4yzXuuxRO2o7hQECrxkrq+exmliMXugVGRrLz
         pkioCuqclAZ1tgjCV9u4/lyNaEjYI8FYZba8Wz/HEfCeWqnQjmerRJCOXZOLOP65fR
         +0nwx1zJqZh7Q==
Date:   Wed, 20 Sep 2023 13:45:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC] Should writes to /dev/urandom immediately affect reads?
Message-ID: <20230920204524.GD914@sol.localdomain>
References: <20230920060615.GA2739@sol.localdomain>
 <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
 <20230920193203.GA914@sol.localdomain>
 <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
 <20230920202126.GC914@sol.localdomain>
 <CAHk-=wgu4a=ckih8+JgfwYPZcp-uvc1Nh2LTGBSzSVKMYRk+-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgu4a=ckih8+JgfwYPZcp-uvc1Nh2LTGBSzSVKMYRk+-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:32:29PM -0700, Linus Torvalds wrote:
> On Wed, 20 Sept 2023 at 13:21, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > It seems that what you're claiming (in addition to the RNG always being
> > initialized quickly on platforms that are "relevant", whatever that means) is
> > that once the RNG is "initialized", there's no need to reseed it anymore.
> 
> No. You are literally putting words in my mouth that I at no point
> even implied. You're making up an argument.
> 
> I *LITERALLY* am asking a very simple question: WHO DO YOU EVEN CARE
> ABOUT THIS "IMMEDIATE" EFFECT.
> 
> Give me a real reason. Give me *any* reason.
> 
> Don't try to turn this into some other discussion. I'm asking WHY DOES
> ANY OF THIS MATTER?
> 
> The immediacy has changed several times, as you yourself lined up. And
> as far as I can tell, none of this matter in the least.
> 
> > The question is, given that, shouldn't the RNG also reseed right
> > away when userspace explicitly adds something to it
> 
> I don't see that there is any "given" at all.
> 
> We do re-seed regularly. I'm not arguing against that.
> 
> I'm literally arguing against applying random changes without giving
> any actual reason for them.
> 
> Which is why I'm asking "why do you care"? Give em a *reason*. Why
> would a user space write matter at all?
> 
> It was why I also asked about entropy. Because *if* you argue that the
> user-space write contains entropy, then that would be a reason.
> 
> You didn't.
> 
> You argue that the current behavior hasn't been the universal behavior. I agree.
> 
> But considering that we've switched behaviors apparently at least
> three times, and at no point did it make any difference, my argument
> is really that without a *REASON*, why would we switch behavior *four*
> times?
> 
> Is it just "four changes is better than three"?

See my first email where I explained the problems with the current behavior.
Especially the third paragraph.

I'll just wait until Jason has a chance to reply.  This discussion clearly isn't
achieving anything with just us two.

- Eric
