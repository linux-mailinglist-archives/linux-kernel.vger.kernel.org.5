Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF397CE719
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjJRSov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJRSot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:44:49 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D70114;
        Wed, 18 Oct 2023 11:44:48 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8A26240E0196;
        Wed, 18 Oct 2023 18:44:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BMzHbYTppe5t; Wed, 18 Oct 2023 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697654685; bh=jidAkdbyTEZ11MBABdZHXPFtekr+jAVIl/G5OAqljNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDLdHQ6mdCqyCYkong5swbmK760wsYBLk4zC7fFk8SplsjCPAlUdLP4jeVnDR+3N2
         GkyqT2evDEgMqtiHsSdhLLJsLHFH6neU/o6jFUZb7IStx7Oj0ziD56gFUsmfj0a0ub
         rqBjXpO6LBaO/dvfFZqMJXxAiOGqoqsrRwXKlumq/dEjr8iXqLb28JapU09wTLu2ib
         OTuIGsrjI0bYSq9sH2I73stZU2KW2JUIcgNuGQXctOqOIeAINY74bDlYYzKIhOsHKg
         nGcowJMtkhAafYi1ZKwjWuegdmy8MbiAmbODDQjBNqh/JbhkMPhAJMwpzKGNIcEItn
         mAKGCg4YzONCh68ld0EURgwJMpj+PXJCoF9aEkvOQm+oeKxf0YaUf4nicmH/i+LJQO
         IH6Q4TUknBcL0Wcw04DQoSOM1awJ52bpRzFHFeYbf/nxfDBnT6NbgXuddcdiXNnk2l
         VJWIyb+iQv3w165U9E+5gVFBa+6e2M6Mv4xo29aM5v2uZiPv0F1+vYtUJrKlWXo36w
         2eq9tCRSEl2O8tbG/QDglLBGdM4lQtpg0ZQNRzQIuds17RoMkkPsK3BgRKn7lKR5M3
         vYyAci2qHCZ1FS1XPKW4nMPevaPux0GtQtiBoadsqnaNYdiRn5RgNf0y+aFD7ZZzFr
         g6Wf5MU9zZccA0hMC9qVMbaw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D310A40E0193;
        Wed, 18 Oct 2023 18:44:36 +0000 (UTC)
Date:   Wed, 18 Oct 2023 20:44:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018184431.GGZTAnj8V/R54S5KK9@fat_crate.local>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018181431.skre6i6vzrxsprck@treble>
 <20231018182223.GFZTAiX4BJ6FT8bHzz@fat_crate.local>
 <20231018183915.xwamzzqjf6gehaou@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018183915.xwamzzqjf6gehaou@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:39:15AM -0700, Josh Poimboeuf wrote:
> And see my reply to that?  Not trying to be daft, I just didn't see how
> your reply was responsive.
> 
> A single WARN_ONCE() has the benefit of not overflowing dmesg, while
> also making the warning available to those looking at dmesg (or the
> taint flag), as those who care should be.

A single WARN once is not enough as this is security-sensitive. Warns do
get ignored.

> A rate-limited WARN() is problematic, as it overflows dmesg (and
> possibly wrapping other logs), potentially obscuring other important
> data.

This will hopefully make people look by screaming louder. But no
guarantee. Not saying it is the right thing.

UDing without any output is not the right thing either.

All I'm saying is, there's no good solution for how to catch this and
make people report it.

Make more sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
