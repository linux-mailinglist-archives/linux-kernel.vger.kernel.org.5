Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3687CE608
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbjJRSOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjJRSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:14:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E8398;
        Wed, 18 Oct 2023 11:14:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6025FC433C7;
        Wed, 18 Oct 2023 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697652873;
        bh=ZYef+7UVk//Io/17K/jvCLvU3OYncakab+PQGBwHhaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeyBt/4h5mvBRKhFoyLn4i25lnqkHlWvPB1KWMicFTd7b+h9Q7WZdcZYjcdBq3gny
         JBvdK5NS825xnzH+OYWoLnunyL3RFf1mSpKPGkZJNjvVczK7XPTN2ThcnVLY2MPe82
         fNGWmY696eszTJk+v11QEEVNbNzeg+gWZDZcefHVdNU6xYAbpsVcyDdrHrWUTZTap/
         s36aQRdUS1rexmuTSA6AanGkupg9CHAc1EIpqmSmJvYMuFlsUBeh0uTn9Inl65riSN
         efvwNIedAsiE2jfqsRnEf63j2sKE6EjFssmNdDHdQJiwjLyPQVL8XJl6p3cmJdPXMe
         +EHNgDWqBDkyQ==
Date:   Wed, 18 Oct 2023 11:14:31 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018181431.skre6i6vzrxsprck@treble>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 07:55:31PM +0200, Borislav Petkov wrote:
> On Wed, Oct 18, 2023 at 08:54:33AM -0700, Josh Poimboeuf wrote:
> > On Wed, Oct 18, 2023 at 05:12:45PM +0200, Borislav Petkov wrote:
> > > On Wed, Oct 18, 2023 at 03:38:56PM +0200, Ingo Molnar wrote:
> > > > If then WARN_ONCE().
> > > 
> > > WARN_ONCE() is not enough considering that if this fires, it means we're
> > > not really properly protected against one of those RET-speculation
> > > things.
> > > 
> > > It needs to be warning constantly but then still allow booting. I.e,
> > > a ratelimited warn of sorts but I don't think we have that... yet.
> > 
> > I'm not sure a rate-limited WARN() would be a good thing.  Either the
> > user is regularly checking dmesg (most likely in some automated fashion)
> > or they're not.  If the latter, a rate-limited WARN() would wrap dmesg
> > pretty quickly.
> 
> Well, freezing the box without any mention about why it happens is not
> viable either. So for lack of a better solution, overflowing dmesg is
> all we could do.

Why not just WARN_ONCE() then?

> And, on a related note, I'm thinking I should revert:
> 
>   e92626af3234 ("x86/retpoline: Remove .text..__x86.return_thunk section")
> 
> after all because I'm debugging another similar issue reported by
> dhowells.
> 
> And I can reproduce it on linux-next with his config and gcc-13. The
> splat looks like this below - and mind you, that's in a VM. On baremetal
> you get to see only the first warning and output stops.
> 
> And that happens because for whatever reason apply_returns() can't find
> that last jmp __x86_return_thunk for %r15 and it barfs.
> 
> When I revert e92626af3234, it is fixed. It fixes dhowells' box too.
> 
> Which means, IMHO, objtool is missing to add a return return call site
> at the end of that __x86_indirect_thunk_r15.
> 
> And considering how close we are to the merge window, I'd let that
> .text..__x86.return_thunk section exist so that objtool can find the
> return sites more reliably that what we currently have.
> 
> We can always do e92626af3234 later, when it has seen more testing.

Ok.  A revert is fine for now, but either way we do need to get to the
bottom of why objtool is messing up.  Can you share the config?

-- 
Josh
