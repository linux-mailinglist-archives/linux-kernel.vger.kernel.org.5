Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC16B7B4882
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjJAP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAP7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:59:53 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76973D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 08:59:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A70160003;
        Sun,  1 Oct 2023 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696175987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRzqWCTxRUztaMZlK8v6aOumJ51TcHdPHCtL5+sT2OE=;
        b=bRjfPi7aEyDDSoacSwXVKW1HXj2fQ9UHKQqyb7QZZacM1McD+hOp7J6Cs/4Dc/twEsyw/L
        SinCXoFu+pbpbJAmwEOh8wiWKbJG0HsSRrnZUQN66SkmIPYvt2GoLzchT1PoMQJ+DV+kgJ
        wPs+S5DeM7O0axqr+mn+KqLxmOQpexhomGptAT5DJzVdF++mGo892xN/YZxQBrT/RaxwGY
        HwWrwDOyoeCanBYi/1/UgXIGgG5WR228ic5wTD6qSp7zMknJKHlGemjAbnznrZz3g2gzGd
        BJAg0qiyz2tjT0bbT3q2zldOuYUVi4/aVYPwzbyXCYbFya/aDY6sD0mSjiNqsg==
Date:   Sun, 1 Oct 2023 17:59:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v10 3/3] nvmem: core: Expose cells through sysfs
Message-ID: <20231001175942.749d9bb3@xps-13>
In-Reply-To: <5f1221613fb71b87c01c82add9fe5097@milecki.pl>
References: <20230922174854.611975-1-miquel.raynal@bootlin.com>
        <20230922174854.611975-4-miquel.raynal@bootlin.com>
        <1a27a3341379b9679174f7c5143bbeb3@milecki.pl>
        <5f1221613fb71b87c01c82add9fe5097@milecki.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

rafal@milecki.pl wrote on Fri, 29 Sep 2023 07:18:32 +0200:

> On 2023-09-28 17:31, Rafa=C5=82 Mi=C5=82ecki wrote:
> > On 2023-09-22 19:48, Miquel Raynal wrote: =20
> >> The binary content of nvmem devices is available to the user so in the
> >> easiest cases, finding the content of a cell is rather easy as it is
> >> just a matter of looking at a known and fixed offset. However, nvmem
> >> layouts have been recently introduced to cope with more advanced
> >> situations, where the offset and size of the cells is not known in
> >> advance or is dynamic. When using layouts, more advanced parsers are
> >> used by the kernel in order to give direct access to the content of >>=
 each
> >> cell, regardless of its position/size in the underlying
> >> device. Unfortunately, these information are not accessible by users,
> >> unless by fully re-implementing the parser logic in userland. =20
> >> >> Let's expose the cells and their content through sysfs to avoid the=
se =20
> >> situations. Of course the relevant NVMEM sysfs Kconfig option must be
> >> enabled for this support to be available. =20
> >> >> Not all nvmem devices expose cells. Indeed, the .bin_attrs attribut=
e =20
> >> group member will be filled at runtime only when relevant and will
> >> remain empty otherwise. In this case, as the cells attribute group >> =
will
> >> be empty, it will not lead to any additional folder/file creation. =20
> >> >> Exposed cells are read-only. There is, in practice, everything in t=
he =20
> >> core to support a write path, but as I don't see any need for that, I
> >> prefer to keep the interface simple (and probably safer). The >> inter=
face
> >> is documented as being in the "testing" state which means we can later
> >> add a write attribute if though relevant. =20
> >> >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
> >=20
> > Tested-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >=20
> > # hexdump -C /sys/bus/nvmem/devices/u-boot-env0/cells/ipaddr@15c
> > 00000000  31 39 32 2e 31 36 38 2e  31 2e 31                 > |192.168.=
1.1|
> > 0000000b =20
>=20
> The same test after converting U-Boot env into layout driver:
>=20
> # hexdump -C /sys/bus/nvmem/devices/mtd1/cells/ipaddr@15c
> 00000000  31 39 32 2e 31 36 38 2e  31 2e 31                 |192.168.1.1|
> 0000000b
>=20
> Looks good!
>=20

Great! Thanks a lot for testing!

Miqu=C3=A8l
