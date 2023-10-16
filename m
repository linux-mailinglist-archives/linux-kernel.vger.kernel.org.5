Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6055B7CB54B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjJPVaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjJPVaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:30:04 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E167E1;
        Mon, 16 Oct 2023 14:30:03 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 157B840E01AA;
        Mon, 16 Oct 2023 21:30:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JSpJBMDPt_aK; Mon, 16 Oct 2023 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697491799; bh=S8Vd38o9HbunYA/2a9M5acr0sRPqT1bux7SnTWZ2pLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dc98afUWsuzI92wBlBM99irPrfDFRKziq5Z+a+IdeXOwFg1QxNbxnS8MHBqdFWqFD
         sB6b3g+hnAegNGuNTuq1pULqaOpudJL41qQiS2DJ1aKwRzSIh94RbKyp4yieBFSJZb
         Uec5ZMtKe6tXdAbxgY2GXNSJNjtLhd7PM/nixBgeuVNsvV1M6VEMzuHcf3jR8Ya+Q3
         ypiqnu8Laht3u5/+5S4sJN4FpNtfFuqZBvtCdK/Ky2d3qj9LiSNuCJVan2ArWORV6e
         IzauhoFxuxExgn7IJ0fp/S9JHBpSQeQjPJedTcoq8A48L41XfR7tLmKk2GkedfnMsy
         8EmoLi/IQv71UvW3nlRilKZg8jR5SF30Er9kz4q2eCdxH1Xd3d6rHRekzx7uxHxssb
         c79Ayfg7qAYHrgczmKYx7eKyyh729jKFEGL7UHmoO9kemqR+aAsqNmsrtBEzzhTj+v
         +58IOPXJMcB+R2EyzTpOstrTWE0ZLvEymN/2D6MnvXv4QfTbbsdwchv8gXUBprNrNU
         6F6Il/QIfmS6gam1gzKXOZSGEA6BgqZLgKBRTLDr4czZoyjTPL3QbrIT7N/5Y8eZRZ
         lS8gYRvTodMP1By9eLXMHpTdoK1CUiX6EbZMBru/DbrSgb7085RSeQ/KXG0Jc/kbQ4
         XaOvpzHkBmghGOgBB2M1s9ow=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E877440E014B;
        Mon, 16 Oct 2023 21:29:49 +0000 (UTC)
Date:   Mon, 16 Oct 2023 23:29:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        llvm@lists.linux.dev
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231016212944.GGZS2rSCbIsViqZBDe@fat_crate.local>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231016211040.GA3789555@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231016211040.GA3789555@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:10:40PM -0700, Nathan Chancellor wrote:
> I just bisected a boot failure that our continuous integration sees [1]
> with x86_64_defconfig + CONFIG_KCSAN=y to this change in -tip/-next. It
> does not appear to be clang specific, as I can reproduce it with GCC
> 13.2.0 from kernel.org [2] (the rootfs is available at [3], if it is
> necessary for reproducing).
> 
> $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- defconfig
> $ scripts/config -e KCSAN
> $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- olddefconfig bzImage
> $ qemu-system-x86_64 \
>     -display none \
>     -nodefaults \
>     -d unimp,guest_errors \
>     -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
>     -kernel arch/x86/boot/bzImage \
>     -initrd x86_64-rootfs.cpio \
>     -cpu host \

What's the host?

> If there is any other information I can provide or patches I can test, I
> am more than happy to do so.

Yes, pls send your .config too because depending on the compiler, KCSAN
does get disabled with older ones. So I guess it has to be gcc 13 or so.

And full guest dmesg so that I can compare.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
