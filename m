Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F212E7CE6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjJRSjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRSjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:39:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A883F114;
        Wed, 18 Oct 2023 11:39:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0570BC433C7;
        Wed, 18 Oct 2023 18:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697654357;
        bh=x8dFuwyGInKhNBiscjehEKYq44BwgNqs2OP/+pasWyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wpav0P83xp5UY6Dim6d/k9nvOyb+bwCRgPLpEQaFv/T5XQsbsmcf5N7g7AGZwFvwz
         WCPitWFl84XF4z5tI3AcNr3lP7xxzpgRZkDejvKhEdENzVOQ9wGk+WvI8FjwTY5QLl
         OXToAr81DhhIAhtHhh2PnaZWMTuFRqV0FwnSqfcppdR84GA3e9p9vsWJNZ19v+0wyf
         2AD1L956lISicl273ibBqnXZK9klsSts79KOFuWkD4IWWiq2wCMJlE3k/r7xgKLfFi
         VWVwgxTYGuOG4ZMSaYK0lTBLaSOTzxHVIMkry08q6ZH7b9mo2/BVCrHkLsmNlCigLX
         NWjbYSMLJQlOA==
Date:   Wed, 18 Oct 2023 11:39:15 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018183915.xwamzzqjf6gehaou@treble>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018181431.skre6i6vzrxsprck@treble>
 <20231018182223.GFZTAiX4BJ6FT8bHzz@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018182223.GFZTAiX4BJ6FT8bHzz@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:22:23PM +0200, Borislav Petkov wrote:
> On Wed, Oct 18, 2023 at 11:14:31AM -0700, Josh Poimboeuf wrote:
> > > > > WARN_ONCE() is not enough considering that if this fires, it means we're
> > > > > not really properly protected against one of those RET-speculation
> > > > > things.
> > > > > 
> > > > > It needs to be warning constantly but then still allow booting. I.e,
> > > > > a ratelimited warn of sorts but I don't think we have that... yet.
> 
> 
>      ^
> -----|		this here.
> 
> 
> > > > I'm not sure a rate-limited WARN() would be a good thing.  Either the
> > > > user is regularly checking dmesg (most likely in some automated fashion)
> > > > or they're not.  If the latter, a rate-limited WARN() would wrap dmesg
> > > > pretty quickly.
> > > 
> > > Well, freezing the box without any mention about why it happens is not
> > > viable either. So for lack of a better solution, overflowing dmesg is
> > > all we could do.
> > 
> > Why not just WARN_ONCE() then?
> 
> See above....^

And see my reply to that?  Not trying to be daft, I just didn't see how
your reply was responsive.

A single WARN_ONCE() has the benefit of not overflowing dmesg, while
also making the warning available to those looking at dmesg (or the
taint flag), as those who care should be.

A rate-limited WARN() is problematic, as it overflows dmesg (and
possibly wrapping other logs), potentially obscuring other important
data.

> > Ok.  A revert is fine for now, but either way we do need to get to the
> > bottom of why objtool is messing up.  Can you share the config?
> 
> Attached.
> 
> And as said, you need gcc 13.

Thanks, I'll see if I can recreate.

-- 
Josh
