Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CDB7A8DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjITUVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjITUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:21:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27BAB;
        Wed, 20 Sep 2023 13:21:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED67CC433C7;
        Wed, 20 Sep 2023 20:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695241288;
        bh=Gag9EM56cHN4uK8bLEG3WEm3CD6ulwu+TylJlo4JB34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJxNJmclC6kgI9k20UnJ/nUqL0XBWK9Pt1ltup0VREciq/2qb8KELskfiVOdC7lQ3
         V1PY2Ke0Y1nLleAkfFHGVJr/dPbSiJN5kRslY2/Wzi7OdMNLNdRIsj9MDTty3IQirn
         OWrJp22KQSc69JJzsqMgpTbEenqHX+C0d3WRfWOkEgPL0sB6UuaWZDBnXQcsCKo2NL
         62XbMkS1sa+1YXqKFVlFz4gtbcCRkZIyuu/Y2ZmbynxlGVLNiNKjq0+rdXQp1sGVq6
         VFLa/+31kzvTNypLLvGlEX4OJKZFScsdFaYk/8VfsRwZ6IchMg/SYkCMw4+Z/K7unP
         ih1g1WRUZv4yg==
Date:   Wed, 20 Sep 2023 13:21:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC] Should writes to /dev/urandom immediately affect reads?
Message-ID: <20230920202126.GC914@sol.localdomain>
References: <20230920060615.GA2739@sol.localdomain>
 <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
 <20230920193203.GA914@sol.localdomain>
 <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:42:54PM -0700, Linus Torvalds wrote:
> On Wed, 20 Sept 2023 at 12:32, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > >
> > > Also, are there any relevant architectures where
> > > "try_to_generate_entropy()" doesn't work? IOW, why do you even care?
> > >
> >
> > There are, as shown by the fact that the full unification of /dev/urandom and
> > /dev/random failed yet again.
> 
> No, no. That only showed that such architectures exist. It didn't show
> that any *relevant* architectures exist.
> 
> The ones reported on were 32-bit arm, m68k, microblaze, sparc32,
> xtensa.. Maybe others.
> 
> > But similarly, that's unrelated.
> 
> They are related in the sense fo "why do you actually *care*?"
> 
> Because I don't see why any of this actually matters.
> 

It seems that what you're claiming (in addition to the RNG always being
initialized quickly on platforms that are "relevant", whatever that means) is
that once the RNG is "initialized", there's no need to reseed it anymore.  This
was covered extensively in previous discussions.  It's true in a theoretical
sense, but in practice the "initialized" state is just an approximation.  In
practice, the RNG might have collected either more *or less* entropy than the
needed 256 bits.  *Probably* more, since many of the entropy sources are
estimated conservatively, but it never knows for sure.  That's why the RNG still
reseeds itself periodically.  The question is, given that, shouldn't the RNG
also reseed right away when userspace explicitly adds something to it.  After
all, regardless of which of the mythical Two Big States (initialized or
uninitialized) the kernel considers the RNG to be in, userspace almost certianly
wants the data it wrote to /dev/{u,}random to actually be used.

It's true that the earlier in the boot it is, the more important reseeding is in
general, and the RNG's reseeding schedule already reflects that by doing faster
reseeds for the first 5 minutes of uptime.  We *could* do something similar and
only do the immediate reseed for the first 5 minutes of uptime.  I expect it's
not worth the complexity vs. unconditionally doing it, but it's an option.

BTW, previously you were supportive of using new entropy immediately:
https://lore.kernel.org/linux-crypto/CAHk-=wiq3bKDdt7noWOaMnDL-yYfFHb1CEsNkk8huq4O7ByetA@mail.gmail.com
So it seems that you've changed your opinion?

- Eric
