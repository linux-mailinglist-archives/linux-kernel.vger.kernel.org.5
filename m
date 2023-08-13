Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C977A61E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjHMLOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMLOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:14:35 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3BBE71
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 04:14:37 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F0BCC40E0196;
        Sun, 13 Aug 2023 11:14:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qgoqKbgSWCC3; Sun, 13 Aug 2023 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691925274; bh=5CRlsy9FF1U4PvckXDamFZlMazHMXA1B1t7NN87koQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFy8X9rQdUbARHRT5yGmtkQQnKq9SiGIuNjiWJtSxZyDZ4u9Ffzi/HD3MTha28FEL
         O8U3VMh4ix/r8gkC9V8losvMhn+IyK1km+uxV8fGX5zCjQZAE3fdfsLNSduYaccdFX
         x6M5PscwpqNERq2f3BUmEz0FiKucos72k75cyu4I9qWcKGFyl3JZjn42CcKG+kUKVX
         JOdZ8BvEbnK+FXJUgrKXroiQRGtLlY6LRfcGPfeHMxE3g0WuRrQcNQX+mLaHT2HtBI
         ljNJFnFw3rvf6ylTwciCOqQxfIpVz1U2ZxfzpeFsqcRvGMcpfNB9He1BVCn8vS69zI
         G6P5JBgNi/MxuoC/CtMTbYqIsYprLINxG6w69UCy4E7F00yIEQTRn4/mofCYv3yBhv
         aBEVCxnIZuzkEUMkSUtR1pr9ADiRDeCJGMO4/2HexJvlboF07/SFWUfOpyhe2vDFEZ
         VoPbGjBiXtbOz30Nw3Fyj8UV5E6I0O22OaRYc4KOc9WDxrxtt8DXPGMTbu2+73Qglj
         mmJvgwZjpMN5tyAwqJNDZGXVVCUwqAiYDIojUpiExGf2ijHzhNFjSQ3wrIAOAw0EwC
         NqRLFg7QW3tse1iKAt2c8Q8zLyUWwI43WCp7xsc6UiLekPudD4d9a5AXR4UDH4feU8
         nJNvhv3LSzYbV6ICZ5oKR6io=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E39A740E00B0;
        Sun, 13 Aug 2023 11:14:30 +0000 (UTC)
Date:   Sun, 13 Aug 2023 13:14:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [regression/bisected] Add IBPB decreases performance in two times
Message-ID: <20230813111425.GEZNi7EXyHOLQTNzFg@fat_crate.local>
References: <CABXGCsNTaNw3q1OciYq111vdr+-ouaRVmwVqVJH4iT0NqxFAcQ@mail.gmail.com>
 <20230813082413.GAZNiTLaOxUNUHPvlf@fat_crate.local>
 <CABXGCsNoNaGLsuvHLRA7aG9FCckQpnXaXWoUGvRwzfRKNB4xzA@mail.gmail.com>
 <20230813093502.GBZNijxgueFxBTxWwG@fat_crate.local>
 <CABXGCsMrNz2SPYN=zLZTT7jU4axSi-XLm4bTm7K3NuWnc=yr9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXGCsMrNz2SPYN=zLZTT7jU4axSi-XLm4bTm7K3NuWnc=yr9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 03:57:03PM +0500, Mikhail Gavrilov wrote:
> Sure, I checked and got the same results as on the kernel with reverted commits.
> I suppose when new BIOS update will release the kernel would use
> automatically path `spec_rstack_overflow=microcode` and all users who
> faced with this issue not needed add `spec_rstack_overflow=microcode`
> to their kernel command line, right?

No, you have to specify it explicitly. The default mitigation is still
safe RET.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
