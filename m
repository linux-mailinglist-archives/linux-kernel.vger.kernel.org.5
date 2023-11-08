Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC37E52D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjKHJqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:46:53 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE8199;
        Wed,  8 Nov 2023 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1699436811;
        bh=JsqArwf7i++16JZaeUV8Vxl01WJB/F/dSilTsgJ3HE4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FYh3YR16sty+E4UnANyNklB7fjB7TwklI07azkSD7QGZzMtxCpPcJj0bUYQM/y2Ad
         lb2ns8kIn6SVUJWG6nKWoE8YIaLdZw65c4Fmg37yGlAX1vCmd1a4rzDNyJmjQe+xj4
         KCqLM5+EbiWxESWRx5Z2ejAW57z6AB7bp16rFtEs=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 446CA66A03;
        Wed,  8 Nov 2023 04:46:48 -0500 (EST)
Message-ID: <de7c80a1e297fb1cddbca3972fe8c09a3b551b7a.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Disable module from accessing external data
 directly
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Rui <wangrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Fangrui Song <maskray@google.com>
Date:   Wed, 08 Nov 2023 17:46:46 +0800
In-Reply-To: <CAHirt9jRH1CKE=BUWpML_jNgTBvMfJiYoAYPnVS3E=89oBUVyw@mail.gmail.com>
References: <20231108040447.288870-1-wangrui@loongson.cn>
         <d32d8a26dcd75a840727cdb50546b621d34d326b.camel@xry111.site>
         <CAHirt9jQHTRGdv4rShgvWHEbG1vzuLkNDbxLP7x4eMtuB3BB5g@mail.gmail.com>
         <4075b4dad9bedbc3def5dfe75f66f3e5d49ce6d5.camel@xry111.site>
         <CAHirt9jRH1CKE=BUWpML_jNgTBvMfJiYoAYPnVS3E=89oBUVyw@mail.gmail.com>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 17:36 +0800, WANG Rui wrote:
> > xry111@nanmen2 ~ $ clang t1.c -O2 -fno-pie -no-pie
> > xry111@nanmen2 ~ $ ./a.out
> > Bus error (core dumped)
> >=20
> > I'll consider it a Clang bug then.

https://github.com/llvm/llvm-project/issues/71645

> That's it, no copy relocations. As far as I know, copying relocations
> has some issues and is not recommended by Fangrui.
>=20
> For modules, if distance is not a problem, `no-pic` and
> `direct-access-external-data` can be together because the code is
> writable. Does it seem reasonable to exist?

It may be usable, but the result is generally worse than relying on GOT.

For example, consider a module referring two data symbols in vmlinux,
foo and bar.  The symbol foo is referred 10 times and bar is referred 8
times.

With the current GOT-based approach, the total space usage is (2 GOT
entry * (8 bytes / GOT entry)) + ((10 + 8) * 2 instruction * 4 (bytes /
instruction)) =3D 160 bytes.

With -fdirect-access-external-data, we must add -mcmodel=3Dextreme too
because the modules are too far away from vmlinux in the kernel address
space, then the total space usage will be (10 + 8) * 5 instruction * 4
(bytes / instruction) =3D 360 bytes.

One possible approach to resolve the issue is relocating vmlinux from
XKPRANGE to XKVRANGE and fit vmlinux + all modules into a 2GiB range.=20
Then the total space usage will be (10 + 8) * 2 instruction * 4 (bytes /
instruction) =3D 144 bytes.  But I don't know how to implement this, and
running vmlinux in XKVRANGE may have a performance penalty.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
