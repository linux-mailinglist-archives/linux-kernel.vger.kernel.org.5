Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C60754A13
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGOQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGOQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:16:05 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD4AE52;
        Sat, 15 Jul 2023 09:16:03 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD7BAC000A;
        Sat, 15 Jul 2023 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689437762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLvZjvyKtYjdqlbWdTcVIvaH5ulaFg7tfDn1cNGzLjk=;
        b=duVRSGeKTPFmrl+NBpnM0ULc8COFL8Tq5toYfJ/mkhRQb9/blw/BI+uTD6n0/Aaqif4tOd
        dVf2jhP+Gv5PbFyfFHhXUwcKlIyc5LUN2mqTcLOH3HYup9YQD8h2v3Eo3eceyV7UupedDO
        8mnwyxoGv0KTGKx47VnrrEvKfNHUsVDO/zwUlbJzU+mG4sXPLjAwK7V9/6Q3neo8RuIEQA
        Pd0Jn6rKYAq9hYWODN/bn1oMcmzJt8eZNeQvSwcF72iAHTffAZ58tQr+DtGbDTUjObtJnY
        Vs4PC5+fHKlPZzXiHxp5e6rjPJiDQSg0pY1qPh5FuzTuHTx/ExQBIYAsB1YCLQ==
Date:   Sat, 15 Jul 2023 18:15:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
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
Message-ID: <20230715181553.1d2b5637@xps-13>
In-Reply-To: <20230711122129.2635558-1-AVKrasnov@sberdevices.ru>
References: <20230711122129.2635558-1-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Tue, 11 Jul 2023 15:21:26 +0300:

> Hello,
>=20
> this patchset adds support for 512B ECC step size for Meson NAND. Current
> implementation only supports 1024B. There are three patches:
>=20
> 1) Update for device tree bindings to replace 'const' type of field
>    'nand-ecc-step-size' with 'enum' which contains 512 and 1024.
>=20
> 2) Update for device tree bindings to add dependency between properties
>    'nand-ecc-strength' and 'nand-ecc-step-size'.
>=20
> 3) Update for Meson driver - new enum value for 512B ECC and reworked
>    ECC capabilities structure to support both 512B and 1024B ECC. By
>    default this driver uses 1024B ECC, 512B could be enabled in device
>    tree.

This series does not apply correctly on nand/next, would you mind
rebasing (nand/next on linux-mtd) and sending it again?

BTW the "rfc" prefix is only needed for the "first" submission, when
you try something "new", otherwise it is no longer required.

Thanks,
Miqu=C3=A8l
