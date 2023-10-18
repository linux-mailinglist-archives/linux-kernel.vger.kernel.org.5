Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7057CE874
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjJRUEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRUEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:04:33 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3E7A4;
        Wed, 18 Oct 2023 13:04:31 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9758E40E01AA;
        Wed, 18 Oct 2023 20:04:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gwCJkFbKXrzr; Wed, 18 Oct 2023 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697659467; bh=t53snlM/FS4FjefjycEZq7XirObB48/d4Bvth4n8Fng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnsFtV4+lHloRtYmDjnHOKoekKLGeEfLvkZ7YBHa4h1tl4N2cnIwZHU7A37I3kShS
         5uIeOUQyu4YTUzcmS+qb2EmRPxGgnVBc6RQSzD7640EsQgAituALRTP9u1vXc+5sKN
         ilAyWncKwYRqMZPr1g0KenNZbPnCoq5K/bD0H2DBY4pLFwCK1Q0yyJ1x1+o1ZYlhon
         DXzDX4JrXCAkYHwtXIQ4FdwTerMT+f2MGQ5YhXMDIxgSKqJdOFvTIqtMy54S0xv+MH
         uSob638OlDlBsvGXRx2owHeXUKLettnv2tXbR0SiACaFa/k1Mmw9TdEdy2UNA27cNB
         dMSXj9YTU9zLiKwx4IpyUhX2+nhICRL4Z6ZQQ5McFAh1Yussp1drd8okaYhlc5Xjc8
         Lvl6Dlh0x2KY5Y+ajMx8IXR4JN9fnzC5rW1q3oWZ5CFwIY2h1zdbz4Jk3j67YboUhv
         yk3/3cFnaoLSE9HpyE3mq7msLy/uGBnXYquX/0QppMasD/rxzSMvupqfCVQwpKzuPm
         kWc4BoJojZzkdOItbvwau4WjxXoa6Ea0LVVxLMNgMuaqKIQXHaN8gQZs//7kcTLEgP
         lj2g0lRHZmOP+Ghs29x/YNg3P8qM4JGtRQMzo+Od89R+56pWC9z+LOEIiFhCPWElO7
         pFpDBKBya6qmSjYtfzwL3NKE=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87D7640E0193;
        Wed, 18 Oct 2023 20:04:19 +0000 (UTC)
Date:   Wed, 18 Oct 2023 22:04:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018200414.GHZTA6Pq8UE4rK0Yk5@fat_crate.local>
References: <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018181431.skre6i6vzrxsprck@treble>
 <20231018182223.GFZTAiX4BJ6FT8bHzz@fat_crate.local>
 <20231018183915.xwamzzqjf6gehaou@treble>
 <20231018184431.GGZTAnj8V/R54S5KK9@fat_crate.local>
 <20231018191407.n4ys6vefbio7z3sn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018191407.n4ys6vefbio7z3sn@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:14:07PM -0700, Josh Poimboeuf wrote:
> There are a lot of warnings which could become security concerns.

Not "could become" - this one *is* a security issue because it means we're
not mitigating with the RET thunks properly.

> By definition, a warning means something is seriously wrong.  If it's
> ignored, all bets are off.  That's why we taint the kernel.

If I could, I'd cripple the kernel just enough so that it issues the
warning and then stops so that the users are not exposed, but show why
it stopped. And we know that panicking doesn't provide that.

David suggested earlier that perhaps we should warn and then mark the
kernel as vulnerable to those mitigations. That could be a more
realistic thing to do...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
