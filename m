Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA8F7D2CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjJWIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:37:51 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B97FC;
        Mon, 23 Oct 2023 01:37:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09C1CC0004;
        Mon, 23 Oct 2023 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698050266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2qWqEWwWxgzTB5vBK4eUVGzwwb4KGMgVk1+rMugYSY=;
        b=I+qXGtKjWACc+95J3bxM740AW7ZhuwMsitmdSpakULn3nkAShIyZmAK/lJnq1wlUd7qNKp
        ToHV1Zz1KfIOmy74YTi2yd0Dm5UQ7Y7NApLfo2z48EbNSxuJKEA0Sh7wT5FBvI1DIByCaz
        IUgnve6EG+gsLFmHDpsuHgWC2YSFPnRBvBejHvqykWy0XjriEmjVqoZiYoIdR3ePVH0MF1
        shAKlro8Chqv6dCsMXzdTXJTIpqDc7Z+Vt0M3HLIN5tDbXJm8j3s45WdvqyN9eJzwk+94m
        H8cKtVya75rHIMRlfJU2ZKdKLm3yUiPq1aHPGSTh+5FIF0SocS1LqmCQOlmkLA==
Date:   Mon, 23 Oct 2023 10:37:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v4] mtd: cfi_cmdset_0001: Byte swap OTP info
Message-ID: <20231023103745.054bc2d3@xps-13>
In-Reply-To: <CACRpkdYaq=RxgLJhRanfgw1+280N1K-aRvpy_BTM3SYY9Xtokw@mail.gmail.com>
References: <20231020-mtd-otp-byteswap-v4-1-0d132c06aa9d@linaro.org>
        <20231023102552.4b053b17@xps-13>
        <CACRpkdYaq=RxgLJhRanfgw1+280N1K-aRvpy_BTM3SYY9Xtokw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

linus.walleij@linaro.org wrote on Mon, 23 Oct 2023 10:35:24 +0200:

> On Mon, Oct 23, 2023 at 10:25=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>=20
> > linus.walleij@linaro.org wrote on Fri, 20 Oct 2023 22:30:29 +0200:
> > =20
> > > Currently the offset into the device when looking for OTP
> > > bits can go outside of the address of the MTD NOR devices,
> > > and if that memory isn't readable, bad things happen
> > > on the IXP4xx (added prints that illustrate the problem before
> > > the crash):
> > >
> > > cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x0=
0000100
> > > ixp4xx_copy_from copy from 0x00000100 to 0xc880dd78
> > > cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x1=
2000000
> > > ixp4xx_copy_from copy from 0x12000000 to 0xc880dd78
> > > 8<--- cut here ---
> > > Unable to handle kernel paging request at virtual address db000000
> > > [db000000] *pgd=3D00000000
> > > (...)
> > >
> > > This happens in this case because the IXP4xx is big endian and
> > > the 32- and 16-bit fields in the struct cfi_intelext_otpinfo are not
> > > properly byteswapped. Compare to how the code in read_pri_intelext()
> > > byteswaps the fields in struct cfi_pri_intelext.
> > >
> > > Adding a small byte swapping loop for the OTP in read_pri_intelext()
> > > and the crash goes away.
> > >
> > > The problem went unnoticed for many years until I enabled
> > > CONFIG_MTD_OTP on the IXP4xx as well, triggering the bug.
> > >
> > > Cc: stable@vger.kernel.org =20
> >
> > Would you like to add a Fixes tag as well? Or is this skipped on
> > purpose? =20
>=20
> Yes the actual commit predates existing git history... :/
>=20
> Git blame looks like that:
>=20
> ^1da177e4c3f4 (Linus Torvalds         2005-04-16 15:20:36 -0700  423)
> ^1da177e4c3f4 (Linus Torvalds         2005-04-16 15:20:36 -0700  424)
>          /* Protection Register info */
> b359ed5184aeb (Jean-Philippe Brucker  2020-04-17 16:23:26 +0200  425)
>          if (extp->NumProtectionFields)
> b359ed5184aeb (Jean-Philippe Brucker  2020-04-17 16:23:26 +0200  426)
>                  extra_size +=3D (extp->NumProtectionFields - 1) *
> b359ed5184aeb (Jean-Philippe Brucker  2020-04-17 16:23:26 +0200  427)
>                                sizeof(struct cfi_intelext_otpinfo);
>=20
> Jean-Philippe's patch is not the root cause AFAICT, but something
> predating it, and predating git history.
>=20
> The fix easily applies to all maintained stable kernels.

Ack.

> > > Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > > ChangeLog v3->v4:
> > > - Collected Nico's ACK.
> > > - Stalled since june! Has this been missed? =20
> >
> > Our current organization relies on Vignesh to pick-up (or tell me to
> > pick-up) cfi patches. But he is slightly less active these days, so if I
> > don't get any feedback from him soon I will take it for the next merge
> > window.
> >
> > Sorry for the delay anyway. =20
>=20
> No worries it's not like the patch is urgent.

Haha, well, yes :)

Thanks,
Miqu=C3=A8l
