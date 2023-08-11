Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0D77940A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjHKQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjHKQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:12:41 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D12712
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:12:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 77E3640E01A2;
        Fri, 11 Aug 2023 16:12:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EIC00tw8V5eQ; Fri, 11 Aug 2023 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691770352; bh=ZWCswt3p1t2FvPWcU+CW0VBcDZIt5mj/ZBsforpyaIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAyPNa3cHGvngGF+lVn2/cbLxOpOFftRCG2Ca07nrLvSdmwDEPDar1/GH/k5tLCZM
         gtU/num0/D7I2ld6RfuvFR5wdnmV+LgFQz8fCq+oDRsgBuePOu0fNcoW4bzntxntko
         PN1p7TZHvi6r5IXpAQGWEMBe8kWUGcVkFRhPjnOcC76rPxRFJ2HUWW0a2x1S2hkEVD
         lKvwWAmIn4EqWzEs8IBnRqK03MQaxkeUWsnuIrNP+XkStetjOXeYgcOF3vckdslBqz
         bYOoRxwLvT4ifGUtDiUHJDlVJYPTdl+aL4cBEe6vRatxcPfRKRbh4N5MZ2BZB1tKqY
         Z87opq4uuiwEZ/iJYqIXDem9/qRZxGIx8Ngo8R9yulm06JWpsuHgGVy8UJ9Ke70MPy
         Yg+NESJovLJ1BWJuySJ9KK8NvjhN9IP89AMvVJ8JXKshrzKvA+yBoCW7p5vU6FBWFQ
         MOybolvlq00Ky1zs5xgsYyLth7k09bPEeM/SlNYovWSlX3xCxTQCRSMbx0n5H1EGO2
         liSeGoFF0dcUBInDnuNL/Kalzic5szd1Uhh3ySjgrKXSWrPCBYBK+Xsc0NQwKACS6j
         bM+SnxDfqBOA7G0Pdp6OiFKHhW1aEcJyZTVnsJlhLUs8XvBIjtGJatQAzS1RYRe8r4
         nvVOVUc66E43mrERdJRZRLXw=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E71040E0194;
        Fri, 11 Aug 2023 16:12:26 +0000 (UTC)
Date:   Fri, 11 Aug 2023 18:12:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230811161225.GIZNZd6QfLUoZv9TLO@fat_crate.local>
References: <20230810133216.GKZNTm4KpohRR4gVsT@fat_crate.local>
 <20230810134056.GA130730@dev-arch.thelio-3990X>
 <20230810144344.GLZNT3oM6MLVdzGlyd@fat_crate.local>
 <20230810150706.GA42856@dev-arch.thelio-3990X>
 <20230810151410.GNZNT+wn/cLBWiU6dO@fat_crate.local>
 <20230810154831.GA38495@dev-arch.thelio-3990X>
 <20230810161414.GA4000@dev-arch.thelio-3990X>
 <20230811101456.GDZNYKIHs1k7ri8hrI@fat_crate.local>
 <20230811140941.GB193223@dev-arch.thelio-3990X>
 <ZNZbxhL5ZJD1Sd9P@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNZbxhL5ZJD1Sd9P@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 09:03:18AM -0700, Sean Christopherson wrote:
> Might be the flags bug that borks KVM's fastop() emulation.  If that fixes things,
> my guess is that bringing APs out of WFS somehow triggers emulation.

I was just about to connect you two guys, thanks Sean!

> https://lore.kernel.org/all/20230811155255.250835-1-seanjc@google.com

Nathan, if you could test, that would be cool.

Also, Nick has another patch for -mno-shared, it probably isn't fixing
yours but it would be good to test it too, just in case:

https://github.com/ClangBuiltLinux/linux/issues/1911#issuecomment-1674993796

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
