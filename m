Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D756D7DA130
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjJ0TQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJ0TQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:16:49 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A31E186
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 12:16:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3DEA940E01A4;
        Fri, 27 Oct 2023 19:16:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nvavM3pzjMvK; Fri, 27 Oct 2023 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698434203; bh=UnIge0ffhkOTRMdWX6K4/KwMZhRuw1YbXABtEkjEz7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIbJbgjKPWbSwwkBOpUacSdHK+O6d9Qp45vCknNYxjCkYrDmTWAoJv8npmzBvozol
         8yMlWxSRYYGxYOFIDxuaXcLOrMf+E8V9+akHmL53ZEyzPECyPNx9tI95vcXq9uugmx
         QPBvKaTqDNmfmwsQMJJsfkvjPgFDPp/6pmf+aUDGHJRHl7EMDIiz41YlBfJjl7KZ1+
         NuAQyW2k7xq/6A5NOq9du/409ypEbnaAOKA9nmysS+sBDmU7NUIGj1KG2UCoCZIxDa
         cEbXUnx8wamHDWgUGRY9ksau5Nkf1D1pXyZ075r93xF5MAu2hoAbE4pvl4xQgfZrTj
         9e1fwc5tcASMO2J4LwaqeAWqntgndrMqq74qoqrfgE5bi5VwHVDNSEx7hn2iRjurJq
         QQ0jYUcoyEQ8TsRTMA6HTO4MDtkI2SORAfNImAlEqVUL5JXgYVtP1Y5H2ua1Oyl1pq
         xXiexJ2/KTFIqzb3nVn/K/gB1R7lyjWUAkbXMJxkntjuJHbM8duCJijk1e2JPrZfj3
         g4O4wJ/vlyD9nXfRc5t+3khUDbAwDIXbreqWWJw3cE48p7DKgrwcPCjv86Oi/fjvyk
         EVxCgUS9AcNl3FkBsiUbasYjDr0NwVGW/U+HnFtTCwMmHSx2TM0BnWghliytUShnxb
         83PWK1rKFXEaH1AtUdVYIhSo=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB15640E018F;
        Fri, 27 Oct 2023 19:16:38 +0000 (UTC)
Date:   Fri, 27 Oct 2023 21:16:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20231027191633.GRZTwMkaiW1nyvnzzO@fat_crate.local>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
 <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
 <20231027153458.GMZTvYou1tlK6HD8/Y@fat_crate.local>
 <20231027185641.GE26550@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027185641.GE26550@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 08:56:41PM +0200, Peter Zijlstra wrote:
> Well, you see, AFAICT the non-serializing MSRs thing is an Intel thing,
> so everything !Intel wants this gone, no?
> 
> Definitely the Hygon thing wants this right along with AMD, because
> that's basically AMD, no?

Because of

ce4e240c279a ("x86: add x2apic_wrmsr_fence() to x2apic flush tlb paths")

and it being there since 2009 and getting called unconditionally.

Hygon sure, but the other vendors? I can't even test on some.

Thus the more conservative approach here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
