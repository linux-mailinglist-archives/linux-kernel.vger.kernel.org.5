Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ECE754ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 15:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGPNYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 09:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 09:24:13 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7AFE6B;
        Sun, 16 Jul 2023 06:24:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 395481C0005;
        Sun, 16 Jul 2023 13:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689513849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlAJuoojWBheC8JWE/2d5ZWEyMAatM5WLPn8urq2pfs=;
        b=pxlpXq30z8NQhVbblNWq1AJDPI30WimwJl1hF8f6qibGV5xcoD05V90VqdTf841xQE9pX8
        navcvSLTkpk3oYJkRjoCJM697aaFOkRsFlge77hLR1gr8UkgdbdOlRvjHsKOBmrB6+C35h
        tlT7+2v6o2Hwvw67jotDSktY0H5h/Gbtiv41Ld8T4fLjcZLtEqhtp9BiHFxNF6YjM3Qpsy
        XgiK8+9sGlyZqfNJHXF+blxpC8obu9KL391CUHCfrgfiOVEh+0jNBvb8BCRQv7ZNz9wKBJ
        79M+ecl7Bm03bS84Pkby9io5YgZ8ZMWa7htwxwwtha5AqeLQwKqbyJLGmNIOIw==
Date:   Sun, 16 Jul 2023 15:24:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 0/3] support 512B ECC step size for Meson NAND
Message-ID: <20230716152405.729e0922@xps-13>
In-Reply-To: <672e6a2f-21b3-77cd-fe83-04d4aa79f68e@sberdevices.ru>
References: <20230711122129.2635558-1-AVKrasnov@sberdevices.ru>
        <20230715181553.1d2b5637@xps-13>
        <672e6a2f-21b3-77cd-fe83-04d4aa79f68e@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Sat, 15 Jul 2023 20:48:34 +0300:

> Hello Miquel!
>=20
> On 15.07.2023 19:15, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > AVKrasnov@sberdevices.ru wrote on Tue, 11 Jul 2023 15:21:26 +0300:
> >  =20
> >> Hello,
> >>
> >> this patchset adds support for 512B ECC step size for Meson NAND. Curr=
ent
> >> implementation only supports 1024B. There are three patches:
> >>
> >> 1) Update for device tree bindings to replace 'const' type of field
> >>    'nand-ecc-step-size' with 'enum' which contains 512 and 1024.
> >>
> >> 2) Update for device tree bindings to add dependency between properties
> >>    'nand-ecc-strength' and 'nand-ecc-step-size'.
> >>
> >> 3) Update for Meson driver - new enum value for 512B ECC and reworked
> >>    ECC capabilities structure to support both 512B and 1024B ECC. By
> >>    default this driver uses 1024B ECC, 512B could be enabled in device
> >>    tree. =20
> >=20
> > This series does not apply correctly on nand/next, would you mind
> > rebasing (nand/next on linux-mtd) and sending it again? =20
>=20
> Sure, as I see 0001 was applied to nand/next, so I can resend only 0002 a=
nd 0003,
> as 0002 is the first patch which fails to apply?

Yes indeed.

>=20
> >=20
> > BTW the "rfc" prefix is only needed for the "first" submission, when
> > you try something "new", otherwise it is no longer required. =20
>=20
> Ok, got it
>=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> Thanks, Arseniy


Thanks,
Miqu=C3=A8l
