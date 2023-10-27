Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97987DA146
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjJ0T3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0T3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:29:22 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD517E5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 12:29:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 205A740E018F;
        Fri, 27 Oct 2023 19:29:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FeXw8_sEkfdh; Fri, 27 Oct 2023 19:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698434956; bh=xbxovbWtvS5eUVU7qTa2e3X1XxpP9O0TH7iacPYNpeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqFjx8cwjFdeZKQXtZlqXtDA+1oLEoIhAt0zNaDVoYGFbWWgaKaA1X/TyI/teERfy
         Nu4zziBp8DwkjLOWSHQtltFppG0zKCWcvUgfY4ztsADPxDC9kFTXSsdRpDOG2a1yyI
         UuVYsS9R+37+fUxt8IqimJpsdy3/85j1kx3MPc5hZ3xu+VfX2UwDknCoZrBEjpTLOK
         rROXF0kiH9XPkRytUlTxJ8zCGVgbmevLoujDZqr8CWgj3NHFP3Xn/n9fhYiw7cGYcS
         K8f0fiVj4+jIIaB5mzBz3I5cW6TrNnYVDoZK27VwsMFnPrLvXp1K1XJKUoR9rC+xC/
         ARf0P99Ic/aQDNDG+drt/h4U+xTQOgH5fWfrczAqUeuqOeujj6wRRklxNbrGX2Sd1i
         d8239NLo3w8mZzo/kcbjrjHvVDFF2mRQSUDw0gPff+RfXSYKtlXHBOE/NboAMGzcj4
         d+kSxJTHHCVvVlIpDJl34QaHSHi1pVweuf536cAV8BdGudR9UPksW1m8NaEjNnyCq9
         vJIK04IpN8IEDWa+9T0gFhUeurMXVQiikQEyqnb+1Q2A+EZSPcWzWGvRBcznHckscf
         c2/x10CSiMHVWFbUyaRF/ryuD6vdTweo50Q9LNMYxmCaygxgdCruGd5mZHh+SkytFb
         OTtTSpWUtMiiSUQqGo18t8ig=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 959E540E0173;
        Fri, 27 Oct 2023 19:29:12 +0000 (UTC)
Date:   Fri, 27 Oct 2023 21:29:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20231027192907.GSZTwPg8v7NF6+Zn0w@fat_crate.local>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
 <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
 <20231027153458.GMZTvYou1tlK6HD8/Y@fat_crate.local>
 <20231027185641.GE26550@noisy.programming.kicks-ass.net>
 <20231027191633.GRZTwMkaiW1nyvnzzO@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027191633.GRZTwMkaiW1nyvnzzO@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 09:16:33PM +0200, Borislav Petkov wrote:
> Thus the more conservative approach here.

And on a second thought, I don't need any of that new stuff - I simply
need a synthetic flag which says "MSRs need fencing" and set it on
everything but AMD and Hygon. And we've solved this type of issue
gazillion times already - why am I reinventing the wheel?!

:-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
