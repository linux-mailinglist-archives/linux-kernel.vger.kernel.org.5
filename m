Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E29A7E52A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjKHJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjKHJ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:26:04 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4880092;
        Wed,  8 Nov 2023 01:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1699435561;
        bh=MHoYlRRQlIaoUMXp6XFV+fXjXSg5at/8hlArEgvyOGw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MficXfBcy/PeVIszIdkJ/wcbacN1X29Zv2MYs9r7+0eTynX3O5GqU8OuH95oV8nBQ
         x5Jdlj66FywhaQsrHPfvm8zVjdgySZ7zoqxFXM5/D8twIMpHfDsUvmVpTdZ5HwYF9V
         ssCVf4Q9x3oNOYRrJVEMFWWtsFt11BFVj8vfrK7U=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id CCAA466A03;
        Wed,  8 Nov 2023 04:25:58 -0500 (EST)
Message-ID: <4075b4dad9bedbc3def5dfe75f66f3e5d49ce6d5.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Disable module from accessing external data
 directly
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Rui <wangrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Fangrui Song <maskray@google.com>
Date:   Wed, 08 Nov 2023 17:25:56 +0800
In-Reply-To: <CAHirt9jQHTRGdv4rShgvWHEbG1vzuLkNDbxLP7x4eMtuB3BB5g@mail.gmail.com>
References: <20231108040447.288870-1-wangrui@loongson.cn>
         <d32d8a26dcd75a840727cdb50546b621d34d326b.camel@xry111.site>
         <CAHirt9jQHTRGdv4rShgvWHEbG1vzuLkNDbxLP7x4eMtuB3BB5g@mail.gmail.com>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 17:20 +0800, WANG Rui wrote:
> > then the linked binary triggers a SIGBUS.=C2=A0 Ideally this should be
> > detected by the linker at link time, but currently the BFD linker
> > fails
> > to detect this error (FWIW this flaw is caused by a really nasty
> > method
> > for the medium code model implementation).=C2=A0 So to me -fno-direct-
> > access-
> > external-data is the default.=C2=A0 I also grepped for -fdirect-access-
> > external-data in the kernel building system but I've not found any
> > match.
> >=20
> > Are you using a different version of Clang, or maybe Clang has some
> > configuration-time option to make -fdirect-access-external-data the
> > default?
>=20
> The clang enables `direct-access-external-data` by default in PIC and
> disables it by default in no-PIC. This also applies to PIE. [1]

Oh sh*t:

xry111@nanmen2 ~ $ clang t1.c -O2 -fno-pie -no-pie
xry111@nanmen2 ~ $ ./a.out
Bus error (core dumped)

I'll consider it a Clang bug then.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
