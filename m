Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C447C809B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjJMIsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjJMIsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:48:19 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06669B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:48:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1A4160005;
        Fri, 13 Oct 2023 08:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697186894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvjTFtri6PgtKRCep/sqrGHOlkyA5KLY/eJnDh1etpo=;
        b=MKJUXBCaGS8H5+dJopPeaW9Ze2Q6SPsMi1ZsJm5aPQFEebhrZ5FVYu4HWtOG+zPFAzl2SA
        b/nqtAZxb0gfOhGgnNaGxQ58SyfSLBbYcSLngdUbTBg7PXln1QTHh1iiCS/wsnDpmQvJiu
        PjvWeyVTNsf2EsWSWOmQFESxxPNGMSePjL7BDQXx8UHnLXycmua67+ctFm2L/HgYoKQD4j
        c19FaLmZGsg79OvuxT/kan2Fw+O5Qlzf/rTITwnl/nwYxoTWOdJjcjBRoEm9AkOQ7wkEK7
        N5uo7SAjrEwv+CwfM59KYPcBfZjJ/GXmDx/Uued9L/HmDbm72dyj/XmQ2uOgKg==
Date:   Fri, 13 Oct 2023 10:48:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@mail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add destructive operation
Message-ID: <20231013104809.15821b9f@xps-13>
In-Reply-To: <trinity-902f8ae6-26e3-484b-ba2d-00946a63333a-1697132171458@3c-app-mailcom-lxa13>
References: <trinity-d4b16b4a-e223-4daf-8a3e-4aaa7fc6c9cb-1697071235519@3c-app-mailcom-lxa05>
        <20231012090638.1e093fe6@xps-13>
        <trinity-902f8ae6-26e3-484b-ba2d-00946a63333a-1697132171458@3c-app-mailcom-lxa13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

dregan@mail.com wrote on Thu, 12 Oct 2023 19:36:11 +0200:

> Hi Miquel,
>=20
> > Sent: Thursday, October 12, 2023 at 12:06 AM
> > From: "Miquel Raynal" <miquel.raynal@bootlin.com>
> > To: dregan@mail.com
> > Cc: bcm-kernel-feedback-list@broadcom.com, linux-mtd@lists.infradead.or=
g, f.fainelli@gmail.com, rafal@milecki.pl, joel.peshkin@broadcom.com, compu=
tersforpeace@gmail.com, dan.beygelman@broadcom.com, william.zhang@broadcom.=
com, frieder.schrempf@kontron.de, linux-kernel@vger.kernel.org, vigneshr@ti=
.com, richard@nod.at, bbrezillon@kernel.org, kdasu.kdev@gmail.com, "JaimeLi=
ao" <jaimeliao.tw@gmail.com>, "Arseniy Krasnov" <AVKrasnov@sberdevices.ru>,=
 "Adam Borowski" <kilobyte@angband.pl>
> > Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add destructive operation
> >
> > Hello,
> >=20
> > dregan@mail.com wrote on Thu, 12 Oct 2023 02:40:35 +0200:
> >=20
> > The author should be Boris as well (git commit --amend --author=3D...) =
=20
>=20
> I will attempt to change the author but git seems to be
> somewhat limited in what I can accomplish when it comes to
> changing emails, sending in the name of someone else etc.
>=20
> >  =20
> > > Erase and program operations need the write protect (wp) pin to be
> > > de-asserted to take effect. Add the concept of destructive
> > > operation and pass the information to exec_op() so controllers know
> > > when they should de-assert this pin without having to decode
> > > the command opcode.
> > >=20
> > > Created by Boris Brezillon. =20
> >=20
> > This can go away. =20
>=20
> Will remove.
>=20
> >  =20
> > >=20
> > > https://github.com/bbrezillon/linux/commit/e612e1f2c69a33ac5f2c91d136=
69f0f172d58717 =20
> >=20
> > This as well. =20
>=20
> Will also remove.
>=20
> >  =20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com> =20
> >=20
> > Please use Boris' kernel.org e-mail for the authorship and SoB =20
>=20
> I don't know what Boris' kernel.org email address?
> Is it @bootlin? Collabora still shows up as email when
> I do the list of maintainers. I did some searching
> but couldn't really find anything conclusive.

It's in .mailmap: bbrezillon@kernel.org

> > > Signed-off-by: David Regan <dregan@mail.com> =20
>=20
> Do I still keep this SOB or should I change it to something else?

You need both SoB: his then yours.

Thanks,
Miqu=C3=A8l
