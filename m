Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2155B77A037
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjHLNq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHLNqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 09:46:53 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F4198B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 06:46:56 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A008840E019C;
        Sat, 12 Aug 2023 13:46:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FtWfINdBjqMX; Sat, 12 Aug 2023 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691848012; bh=KKJmPDhFaDUed9OkAVAyosuXrrOmKC/WxDhHEMXXWQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtFXAh/elVWXuq9gmEYUU7nZ8IjYnqxVnMVbYS8Rg/h6GtMblDWhHgdDSAmn5/f0z
         6r3rMNvEYQxiy8rpbTbMt+BjRsCLASMaQ8hkRS4aHTNmMkZ/RxMFWmUmXWgg/81ZuV
         SbSKTOPZBe/DR/vQA6ruDRMN6bQ9XA7WHwf6HqjLiH7sOmkieX6AxHZcFmx90Hih0E
         PMrv3pMLsUaIyS2KYP5ceD/qunMMDbk+XWMMc8WlUsBPfRNDimGFFwyyPpy+sNqDVK
         rsmgZEML9VKM7i8Tb4Nq/St6V/h2R5EfhcgANcSbXozMvveTCrFp8gh95XMadjxH9H
         DHzo4JaW2MlS4uAgwPxq1evbPo9TzXW6+jAZlospC+Q/OK5Di0WoVEOqF2GrLHXynr
         sMvlbpT5L9vjGjqI4Al3UZ4u6ti+AX1jLsquw+BtD3gW6+Zy14jq9Rp6dmykTb05FB
         +buIUUX7kKrRgma0LTuQIuUtnWLBQmFyUv+lagbwZn8ZzLwUMInPWGKKzjDBI5i6Sk
         4Oga2uJxYpdDv7Ng9TPQ34IzvLOcBwCf/AT2kfY0p2yZ3CdC1zDhMgOd5x44okgLtk
         Prxj2qxTLl8HvA4oAuCSlRvAt5KMaZywj6zMWHxhsOYxx08tMoJ6ET2Ii2vokjOtSg
         75JEaVWw0hqfLL0RY6bSrO2M=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8AF3940E0185;
        Sat, 12 Aug 2023 13:46:46 +0000 (UTC)
Date:   Sat, 12 Aug 2023 15:46:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230812134642.GGZNeNQpebzu3H3NDh@fat_crate.local>
References: <20230810144344.GLZNT3oM6MLVdzGlyd@fat_crate.local>
 <20230810150706.GA42856@dev-arch.thelio-3990X>
 <20230810151410.GNZNT+wn/cLBWiU6dO@fat_crate.local>
 <20230810154831.GA38495@dev-arch.thelio-3990X>
 <20230810161414.GA4000@dev-arch.thelio-3990X>
 <20230811101456.GDZNYKIHs1k7ri8hrI@fat_crate.local>
 <20230811140941.GB193223@dev-arch.thelio-3990X>
 <ZNZbxhL5ZJD1Sd9P@google.com>
 <20230811161225.GIZNZd6QfLUoZv9TLO@fat_crate.local>
 <CAKwvOdmejxO=_KBuw1WZGgh=MXNNbfWH03TpEFO47vkKWq04Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmejxO=_KBuw1WZGgh=MXNNbfWH03TpEFO47vkKWq04Cg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 05:42:04PM -0700, Nick Desaulniers wrote:
> So far it looks like it's working for folks. Fixing that issue is the
> lowest priority issue of the three we found; I'll send it formally
> next week.

Ok. Also, it might not be needed as some of PeterZ's stuff do simplify
that code more so I'm thinking of taking them and will make your fix not
needed. But we'll talk.

> I literally just had my hard drive fail on my main dev box (that's two
> machines fail in one week; laptop wont power on anymore; down to one
> machine left).

Sounds like Murphy came to visit. I hate that.

> Going to see if fsck can help at all; worst case I may
> need Nathan to formally send it for me next week.  Let's see if I can
> recover this machine first...what a way to end the week. SMH

Yeah, I can scrape it off some gitgub issue page too - that's not
a problem.

Btw, this:

https://github.com/ClangBuiltLinux/linux/commit/150c42407f87463c27a2459e06845965291d9973

Is this fixing a current issue and so it needs to go to Linus now?

If so, I'll expedite it too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
