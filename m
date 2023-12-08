Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9680A1FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573489AbjLHLR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjLHLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:17:23 -0500
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 03:17:24 PST
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C5710CF;
        Fri,  8 Dec 2023 03:17:24 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:440b:0:640:fa3a:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 798A36123F;
        Fri,  8 Dec 2023 14:10:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id TAcpGPeKn8c0-2U9xMJpD;
        Fri, 08 Dec 2023 14:10:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
        t=1702033830; bh=QmfAlJThz823b12lB5pGa5H06RW2Ph9k8H5H7/pZ/aM=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=qI8mD2DOT3f6+7kzz3VWGRxsU/pcVCkruaIbYecQqa2oBJU30UuHceB61nk45Mhmo
         YM9uD2TL86SGNiqkfaWPBo5W8oVa2XUviKvr7RIlzgd7azgko6QY+4k8Z06pzannXK
         8ExQrG8N4xfUQGcP0QwTugajP97+IL0rR9gfhbO0=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <2b646678611c3ed7546d880f8875d57a6800c281.camel@maquefel.me>
Subject: Re: [PATCH v5 17/39] net: cirrus: add DT support for Cirrus EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Date:   Fri, 08 Dec 2023 14:10:29 +0300
In-Reply-To: <ZV3xFjmU56hwBfLc@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
         <20231122-ep93xx-v5-17-d59a76d5df29@maquefel.me>
         <ZV3xFjmU56hwBfLc@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy!

Thanks for review (i am counting all review not only this patch), only
this comment below raised a question:

On Wed, 2023-11-22 at 14:16 +0200, Andy Shevchenko wrote:
> On Wed, Nov 22, 2023 at 11:59:55AM +0300, Nikita Shubin wrote:
> > - add OF ID match table
> > - get phy_id from the device tree, as part of mdio
> > - copy_addr is now always used, as there is no SoC/board that
> > aren't
> > - dropped platform header
>=20
> ...
>=20
> > =C2=A0#include <linux/interrupt.h>
> > =C2=A0#include <linux/moduleparam.h>
> > =C2=A0#include <linux/platform_device.h>
> > +#include <linux/of.h>
>=20
> Perhaps more ordering?
>=20
> > =C2=A0#include <linux/delay.h>
> > =C2=A0#include <linux/io.h>
> > =C2=A0#include <linux/slab.h>
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D of_property_read_u32=
(np, "reg", &phy_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of_node_put(np);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return dev_err_probe(&pdev->dev, -ENOENT, "Failed
> > to locate \"phy_id\"\n");
>=20
> Why shadowing the actual error code?

of_property_read_u32 returns NULL on error.

>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev =3D alloc_etherdev(sizeo=
f(struct ep93xx_priv));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev =3D=3D NULL) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D -ENOMEM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_out;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20

