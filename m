Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EA678BC63
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjH2B24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjH2B2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D095D194
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A15461210
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B53FC433C7;
        Tue, 29 Aug 2023 01:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693272509;
        bh=BXZut80g16acQtWOZCLVNW7/u/V4Q7rPw46Ke9BlyIQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=AGvQf/Uhf1bOgwEo9LC3O8d6RgvWd8qfHjQv2n2dX/uOnGXyUzCshEVOCbnD4jKp3
         FhUnsEJlg2h26bMFDtgAFn52dHRvOXVDDkZKL8C/QUiC4F/xft1NjxV4HaUMck/bjh
         dR0VSayfYZp60vGuihT6UsOc1uho/6OpzqY+CGPnlVrGwbQn9Hkh/D5eRafoQ2dAij
         vwiCNtBv3bwqUeNrRyz59GgxzPpfDgUnmnuPv5YI95qskovWoGYS0k9fbizar74l8B
         OaxxXylsAvcfmI1oIB2e8FWxwGJ1h2UQRbpeclVHNws3BP/4b6X5xz7g8xg3HxeaPs
         M6njB538Mgdtg==
Date:   Mon, 28 Aug 2023 18:28:25 -0700
From:   Kees Cook <kees@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
CC:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Enlin Mu <enlin.mu@unisoc.com>,
        Eric Biggers <ebiggers@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
References: <202308281119.10472FC7@keescook> <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
Message-ID: <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 28, 2023 4:56:00 PM PDT, Linus Torvalds <torvalds@linux-foundatio=
n=2Eorg> wrote:
>On Mon, 28 Aug 2023 at 11:21, Kees Cook <keescook@chromium=2Eorg> wrote:
>>
>> Please pull these pstore updates for v6=2E6-rc1=2E This contains a fair=
 bit
>> of code _removal_ which is always nice=2E
>
>Hmm=2E The diffstat certainly looks good, but the end result isn't great=
=2E=2E
>
>I now get 124 lines of
>
>   pstore: zlib_inflate() failed, ret =3D -5!
>
>in my bootup dmesg=2E
>
>Considering that there's no reason for pstore to even be active on
>this machine, I think it's because pstore now goes and tries to
>uncompress something entirely invalid=2E
>
>The message itself does not seem to be new, but with the switch from
>the crypto code, it apparently used to be
>
>    crypto_comp_decompress failed, ret =3D %d!
>
>but the key word here is *apparently*=2E I never got that message
>before=2E So something else has changed, and I'm thinking that the old
>code probably didn't even try to decompress the bogus data it found?
>
>I dunno=2E But 124 lines of insane garbage in the kernel messages is not
>a good thing=2E

Oh dear! That's obviously unexpected=2E I have so many questions=2E :P

- does this happen at every boot? (I assume yes=2E)
- what CONFIG are you built with?
- what was the prior CONFIG?
- what backend is in use? (Or better yet, what does "dmesg | grep pstore" =
report?)
- are you using systemd?

Decompression is only attempted if it's a valid record=2E If the records a=
ren't being removed after boot (i=2Ee=2E unlinked from /sys/fs/pstore) they=
 won't get cleared=2E Normally systemd-pstore moves everything to /var/lib/=
systemd/pstore=2E But that must not be happening since you keep seeing the =
warnings=2E

That you have 124 of these makes me think you've got the EFI backend (CONF=
IG_EFI_VARS_PSTORE) built and it's default enabled (CONFIG_EFI_VARS_PSTORE_=
DEFAULT_DISABLE=3Dn)=2E The latter config was created to keep the EFI backe=
nd from filling the EFI variable space=2E I think distros started setting i=
t to "n" once systemd-pstore was added, which keeps the EFI variables from =
piling up=2E=2E=2E

So, I assume either systemd-pstore isn't running for you or something has =
gone sideways with it=2E And since I did testing of "changed compression ty=
pe" without systemd-pstore, I bet systemd-pstore ignores the failed records=
=2E=2E=2E
https://github=2Ecom/systemd/systemd/blob/599a3124849819ba5af0a71b7572e872=
56814881/src/pstore/pstore=2Ec#L225
Yup=2E Ugh=2E (Though I still find it odd that you have 124 records=2E=2E=
=2E)

Let me think about the best way to deal with this=2E I expect I'll have ps=
tore wipe the failed records as it is expressly not expected to work across=
 differing configs/kernel versions=2E And permanently spewing errors is not=
 ok=2E

In the meantime, you can make the warnings go away with:

rm /sys/fs/pstore/*enc=2Ez


--=20
Kees Cook
