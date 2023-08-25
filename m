Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF47D788186
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbjHYIFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243372AbjHYIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:05:25 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20381FF2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:05:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id 38B715E943;
        Fri, 25 Aug 2023 11:05:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id F5H80IKDaqM0-MiP4n5N0;
        Fri, 25 Aug 2023 11:05:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1692950715;
        bh=okl4esfBnnzgq8d0K6vscEpYCEHFmM+J8GQFV0E2GSE=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=coWb/+6y/oJR5yhd5JpL5YW/VDxAkAIVZMgkeFn0SUqx0ZHJ4O2jEAHfYwZRd27wC
         eChBBQpO/erAqu7OCJ5qJnWTjM4Se+hjU45RB3shjOXS9717vAAa7xGb2rLaKdBpbn
         7JMTi/q2HUSRM6aH4o4L9O7pCO5eNOXCm83VFiWc=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <913a0bc0dfcd3ecd28f65fb52db789033097d831.camel@maquefel.me>
Subject: Re: [PATCH 1/2] ata: pata_ep93xx: fix error return code in probe
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Aug 2023 11:05:15 +0300
In-Reply-To: <00462bc7-43ee-784a-3296-8051d69575df@kernel.org>
References: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
         <20230823-ep93xx_pata_fixes-v1-1-d7e7229be148@maquefel.me>
         <00462bc7-43ee-784a-3296-8051d69575df@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien!

On Thu, 2023-08-24 at 08:07 +0900, Damien Le Moal wrote:
> On 8/23/23 18:47, Nikita Shubin via B4 Relay wrote:
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Return -ENOMEM from ep93xx_pata_probe() if devm_kzalloc() or
> > ata_host_alloc() fails.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Doesn't this need a Fixes tag and Cc: stable ?
>=20
> This is not really a bug fix, but might as well be complete with the
> fix :)

Well... This would be fix for:

```
commit 2fff27512600f9ad91335577e485a8552edb0abf
Author: Rafal Prylowski <prylowski@metasoft.pl>
Date:   Thu Apr 12 14:13:16 2012 +0200
```

v3.4-rc6-6-g2fff27512600

Are you sure we wanna tag so solid and time proven commit as Fixes: :)
?

>=20
> > ---
> > =C2=A0drivers/ata/pata_ep93xx.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> > index c6e043e05d43..4ce0f37c7a89 100644
> > --- a/drivers/ata/pata_ep93xx.c
> > +++ b/drivers/ata/pata_ep93xx.c
> > @@ -939,7 +939,7 @@ static int ep93xx_pata_probe(struct
> > platform_device *pdev)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drv_data =3D devm_kzall=
oc(&pdev->dev, sizeof(*drv_data),
> > GFP_KERNEL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!drv_data) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0err =3D -ENXIO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0err =3D -ENOMEM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_rel_gpio;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > @@ -952,7 +952,7 @@ static int ep93xx_pata_probe(struct
> > platform_device *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* allocate host */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0host =3D ata_host_alloc=
(&pdev->dev, 1);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!host) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0err =3D -ENXIO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0err =3D -ENOMEM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_rel_dma;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> >=20
>=20

