Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA87A9743
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjIURMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIURKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D09F46B5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:06:10 -0700 (PDT)
Received: from letrec.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38LDUd3N002197
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 09:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1695303042; bh=+fubNItGMi3oNUPA7yH/IACt2nk/RkasGX86cZmJsJg=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=YyZ1ZhLgEOUZxK6QlhDrqHdh84oveJlq+86w5zpiCsCKuDaVztlQM9apfRvVa/rnu
         St0dYrJWO8wpt3Zx9d2Wth7vYbcOVIUpA6KznBvzWx4OW7pi0iD6OvZ2q9rVd9HNs2
         UgptpPOfLzcjDMNX7myTklC/qr9LrgC2L7U2Uuw5ANaf81pL1la09HzKe5QvczYi8V
         y9fmTzAKu04qfSQLNBHrURNpExaNew9U7HoU2Blt1IpI2CmfrLnSuEAvxvbLZoA4c1
         tfp3EzPd17QDVry4+sy4uZe//4dr1voWcuF5Hmb6gKS3i/1KuIZAfR1z76vmXoLeuN
         b4X7CdL7gClAA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 6C9A08C02C7; Thu, 21 Sep 2023 09:30:39 -0400 (EDT)
Date:   Thu, 21 Sep 2023 09:30:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC] Should writes to /dev/urandom immediately affect reads?
Message-ID: <ZQxFfwsr726KlHP6@mit.edu>
References: <20230920060615.GA2739@sol.localdomain>
 <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
 <20230920193203.GA914@sol.localdomain>
 <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
 <20230920202126.GC914@sol.localdomain>
 <CAHk-=wgu4a=ckih8+JgfwYPZcp-uvc1Nh2LTGBSzSVKMYRk+-w@mail.gmail.com>
 <20230920204524.GD914@sol.localdomain>
 <CAHk-=wjx__9L2Ej0DBWGgyjxEKkdKJW=zDvjEhLTBsBgd8MdOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjx__9L2Ej0DBWGgyjxEKkdKJW=zDvjEhLTBsBgd8MdOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:48:55PM -0700, Linus Torvalds wrote:
> On Wed, 20 Sept 2023 at 13:45, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > See my first email where I explained the problems with the current behavior.
> > Especially the third paragraph.
> 
> I really don't think that's the obvious way at all. Anybody who treats
> a seed file that way just doesn't care, and whipped up a (bad) shell
> script randomly.

The shell script (and documentation in the kernel man pages suggesting
the shell script) is basically historical, and obsolete.  It was
needed back when we weren't as aggressively seeding the RNG at boot
time, before we unified /dev/urandom and /dev/random.  These days, I
really don't think it matters all that much.

The main threat we've historically been concerned is badly designed
IOT devices (remember, the 'S' in IOT stands for security) which
generates a long-term cryptographic key within milliseconds of the
initial power-on, which led to such hillarious results as all HP
Printers publically on the Internet having one of 256 possible private
keys.  In those sorts of situations, there *was* no seed file, and
even if there were, it would be identical across all of the IOT's
initially imaged root file system.

I do have one slight concern about unconditionally reseeding whenever
there is a write to /dev/[u]random, whih is in the purely hypothetical
scenario mostly of interest to academics writing crypto papers, where
we assume the attacker has stolen the full internal state of the RNG,
if the attacker is constantly writing a small amount of known data to
/dev/random, and monitoring its output, it would be disabling the
"catastrophic reseed" part of the design, and so it might make it
easier for the attacker to maintain accurate knowledge of the internal
state of the RNG over long period of time.  So a perfectionist would
probably put a timeout where writing to /dev/urandom would result in a
reseed every N minutes or some such.

But honestly?  I'm not convinced it's worth it; devices/systems where
this matter are probably not getting security updates *anyway*, so the
much simpler way the NSA/KGB/MSS would attack the device is paying a
few thousand dollars for a zero-day, and breaking kernel security
that way.

Cheers,

						- Ted
