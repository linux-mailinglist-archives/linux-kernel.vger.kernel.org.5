Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78E7CE0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbjJRPNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbjJRPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:13:03 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC967109;
        Wed, 18 Oct 2023 08:13:00 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3114840E01B1;
        Wed, 18 Oct 2023 15:12:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w5pvRjryP5Rh; Wed, 18 Oct 2023 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697641977; bh=EbtU4bQMd+SyYpD5u3uz+hfYsMOiiZYCWw2lQLB04mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cU4g+kNqdKE0MIQFRGKd4h8zzOaeguhBa82OzmBaOvpjLGvZl0/TAVrCD2B7RRWo3
         8yhN7yJGW7A4BLWCx31WFG54VxA9SC+bf39gSBcDfhwKzxZNaHpaydBWX9M4iyLSD/
         0ZzzMAodf12WAiM6wQYIa+4Ms/Hng+z/jVuPiVvCMxvji3twGX/T+GhV/q03scH0Bu
         ombylMRUvy5lKii5pV8zbvsQ6fnRFgd86sgSbUdFEvf2M+YAs7miQovFHMUoLp6D8y
         iYe2IJrBo0nOyDkFgq/PFq9X+A5YHiLIqRfx21yW3jJJ+9aDd1yZ/EIo6ib2t9NGZ3
         uqCf2O17eks3O/koCkWdmh5gQxfjwFxVkMroLzSst550gxf2M/3xLZRhaxKJrUhy1R
         GWFyyCigJqVNCupq8pZIA56Cy0PxjEiRAZClPcDmXKgxZ42iMOi9iO8S+f8cy2rd7l
         qfYCBM0+YKtnytcvOKmEUz0V1D5GZVaeS81mrvy+FzgQiNfBO/SPONPtyRmnoZKySY
         1R7To8Jg4N8WvxSI4HtKbMJguFt2lDqAxWsVHCYExk84UMOgKEVp68Ivlqh6SO/Mst
         V71bdfDljPgggr1H0U6s9NrtJLrgL/SAKtg/tSeCKAJWFVZ2+6GYqqqbJDtyWKZ5Jj
         ZmOrzgd5R0RyVJuyd0/ClU1Q=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F47740E0177;
        Wed, 18 Oct 2023 15:12:50 +0000 (UTC)
Date:   Wed, 18 Oct 2023 17:12:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZS/f8DeEIWhBtBeb@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:38:56PM +0200, Ingo Molnar wrote:
> If then WARN_ONCE().

WARN_ONCE() is not enough considering that if this fires, it means we're
not really properly protected against one of those RET-speculation
things.

It needs to be warning constantly but then still allow booting. I.e,
a ratelimited warn of sorts but I don't think we have that... yet.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
