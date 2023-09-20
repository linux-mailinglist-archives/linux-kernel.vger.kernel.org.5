Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECD7A7282
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjITGG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITGGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:06:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82F94;
        Tue, 19 Sep 2023 23:06:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A8EC433C7;
        Wed, 20 Sep 2023 06:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695189977;
        bh=tTlfYGAx09JNAjYmfXZ1xk9TOMzK1WNeYE6tiUL4Jks=;
        h=Date:From:To:Cc:Subject:From;
        b=JMAv1BgkiuA62QhS5yn23grp+/zYNi34M4E84vNc2yJpYBqxrFnI0TGtVdWGnQnm2
         krYkgLkt+C9geRZZFz9SpWgNPFMY/8icBs886cZs7b1d1QkNQxR8akzXKvEcUHm9fM
         iaWKB56FDnZsBHaU0aUIwKjzS2pBtGirCsqUM9MpsGLydnla5UHLNHcf56QLcV9ApG
         x8+SZj0Vp2+D8IEVrfR/tbay42SRS5cCBIp+PCvWCpTs9SHREGWKRPmEPZkbGl/bQA
         /D2W1fzkArDmeECGtArx5RFirOrmoksp6VMu83Rpl4AA2iixQU+Gqvqw+d1avTtGNf
         nXFzOfrJ8Mtrg==
Date:   Tue, 19 Sep 2023 23:06:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: [RFC] Should writes to /dev/urandom immediately affect reads?
Message-ID: <20230920060615.GA2739@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason!

I'd like to revive the topic of whether writes to /dev/urandom and /dev/random
should immediately reseed the CRNG, as I'm not sure that the past discussions on
this really resolved the issue.  Currently, writes to /dev/{u,}random do *not*
reseed the CRNG, and thus the RNG's output isn't affected by preceding writes
until a reseed happens for an unrelated reason such as the periodic timer.
(Exception: if the state is CRNG_EMPTY, writes do immediately take effect.)

(Note, I'm *not* talking about whether entropy should be credited for writes to
/dev/{u,}random.  It shouldn't be credited, and it isn't.  That's a separate
topic, though it got somewhat conflated with this one in past discussions.)

As you know, the current behavior means that the "obvious" way of managing a
seed file, i.e. 'cat seed_file > /dev/urandom; cat /dev/urandom > seed_file',
may reduce the entropy of the seed file.  Your suggested approach, SeedRNG
(https://git.zx2c4.com/seedrng) works around this by using hashing.  Still, the
current behavior makes things difficult and surprising for users.  The random(4)
man page still recommends the "wrong" way.  Also, IIUC, even if you run SeedRNG,
if you then do something that uses the RNG like generating a cryptographic key,
it's possible that the seed file contributed nothing to it.  The faster
reseeding schedule in v5.18+ does make this less likely, but it can happen.

This topic was discussed in early 2022 in the thread
"random: allow writes to /dev/urandom to influence fast init"
(https://lore.kernel.org/lkml/20220322191436.110963-1-Jason@zx2c4.com/T/#u).
Ultimately, it was decided not to change the current behavior.

I'm wondering if this should be revisited, for a couple reasons.

First, two months after that discussion, commit e85c0fc1d94c ("random: do not
pretend to handle premature next security model") was merged.  I *think* that
eliminated the security reason to delay reseeding on writes to /dev/{u,}random,
as now "premature next" attacks are no longer under consideration.

Second, AFAICT, the current behavior actually hasn't always been the behavior,
contrary to previous statements/discussions which claimed that it's been the
behavior "forever".  I did a bit of research, and whether writes to
/dev/{u,}random take effect immediately actually has a bit of history:

Starting in 1995 (v1.3.30, random.c created): writes take effect immediately
Starting in 1999 (v2.3.16, secondary pool added): writes don't take effect immediately
Starting in 2007 (v2.6.22, commit 7f397dcdb78d): writes take effect immediately
Starting in 2016 (v4.8, ChaCha20 CRNG added): writes don't take effect immediately

So the current "era" of behavior started in 2016, with 1999-2007 matching
current behavior too.  However, the 1999-2007 era ended with commit 7f397dcdb78d
("random: fix seeding with zero entropy") that intentionally changed this
behavior.  Interestingly, discussion of this patch does not appear in any
mailing list archive, though a bug report "Seeding /dev/random not working"
(https://lore.kernel.org/lkml/de6d2b4f0705290453kec2b050pb4d0bebc256b87a5@mail.gmail.com/T/#u)
can be found earlier in the same day the commit was made.  Also, CVE-2007-2453
was allocated for this fix (though the CVE also covers a different RNG bug too).
This suggests that at the time, writes not taking effect immediately was
considered a security vulnerability that needed to be fixed immediately.

commit e192be9d9a30 ("random: replace non-blocking pool with a Chacha20-based
CRNG") then started the current "era" in 2016, returning to the behavior that
had been considered a vulnerability and fixed in 2007.  In contrast to the 2007
change, it's not clear that the 2016 change in behavior was intentional.  It
happened in the big commit that introduced ChaCha20 to the RNG.  (And yes, even
2016 is still a long time ago in kernel terms, but it's not *that* long ago.)

Anyway, I'm wondering if the current behavior is really what we want, especially
considering that the "premature next" security model is no longer targetted.
Should we make writes to /dev/{u,}random immediately reseed the CRNG so that
users don't need to do the dance with hashing the old and new seeds together?

Anything I'm just completely missing?  Performance concerns about reseeding?
Some attack that we're still trying to prevent by delaying the reseed?

This would be the potential change, BTW:

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cb37760dfec2..97ea2938c715c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1420,6 +1420,7 @@ static ssize_t write_pool_user(struct iov_iter *iter)
 			cond_resched();
 		}
 	}
+	crng_reseed(NULL);
 
 	memzero_explicit(block, sizeof(block));
 	return ret ? ret : -EFAULT;
