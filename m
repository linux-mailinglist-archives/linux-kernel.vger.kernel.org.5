Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738FE76CC7A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjHBMTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjHBMTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:19:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCDD269D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1690978783;
        bh=hx293ly0ztTmbWHyDE9+yBFWdbMzXc86QGVk6E13LeQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=T4tXubGeRV4uyhwNbNMEMUyP8RuTy9mqvwAZND3SiLeHhlNby08bNIXToLZ2Szv5C
         YoxtqE5VLcMVvaoTRXZEkacOL3UfXl1Yd7jcOldgq0TKdx1wPGMM5Y9g4cCrVr7faV
         yQjFI9vHUVlnX0yIoi3udL65YoCgZZWpb9vRdeBfrc0zCrbkvmgmKSUsK/XuGoo8o2
         QI9HsdF1JIyAPTxyIzM0khvr9CQBtcyv3LSLCqSDhRG+Glbhwxh0vSan8MTrCY/HT1
         yZcfk+auGp2zTeI4O+aKo0hzu4zH6aj4YVcBvt2YQVq+4UUEybOkfJDAOg85rRvNOB
         ARVa6QjhLnpNA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RG9yk3ZJlz4xJx;
        Wed,  2 Aug 2023 22:19:42 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu, sam@ravnborg.org,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use shared font data
In-Reply-To: <ZMOaz9EqqeaPGokA@gallifrey>
References: <20230725000141.165985-1-linux@treblig.org>
 <878rb0em3s.fsf@mail.lhotse> <ZMOaz9EqqeaPGokA@gallifrey>
Date:   Wed, 02 Aug 2023 22:19:41 +1000
Message-ID: <871qgl1vs2.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. David Alan Gilbert" <linux@treblig.org> writes:
> * Michael Ellerman (mpe@ellerman.id.au) wrote:
>> linux@treblig.org writes:
>> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
>> >
>> > PowerPC has a 'btext' font used for the console which is almost identical
>> > to the shared font_sun8x16, so use it rather than duplicating the data.
>> >
>> > They were actually identical until about a decade ago when
>> >    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
>> >                         "broken bar" to "vertical line"")
>> >
>> > which changed the | in the shared font to be a solid
>> > bar rather than a broken bar.  That's the only difference.
>> >
>> > This was originally spotted by PMD which noticed that sparc does
>> 
>> PMD means "Page Middle Directory" to most Linux folks, I assume that's
>> not what you meant :)
>
> Ah, any good TLA is ripe for reuse:
>    https://pmd.github.io/pmd/pmd_userdocs_cpd.html

Thanks.

Unfortunately this patch causes a warning:

  WARNING: unmet direct dependencies detected for FONT_SUN8x16
    Depends on [n]: FONT_SUPPORT [=y] && FRAMEBUFFER_CONSOLE [=y] && (!SPARC && FONTS [=n] || SPARC)
    Selected by [y]:
    - BOOTX_TEXT [=y] && PPC_BOOK3S [=y]

And breaks allmodconfig with:

  ld: arch/powerpc/kernel/btext.o:(.toc+0x0): undefined reference to `font_sun_8x16'
  make[3]: *** [../scripts/Makefile.vmlinux:36: vmlinux] Error 1

I guess the Kconfig logic needs some more work.

cheers
