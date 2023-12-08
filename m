Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE78C80A246
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573579AbjLHLdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjLHLdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:33:40 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC8410F7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:33:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9533FC0009;
        Fri,  8 Dec 2023 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702035224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7mhzothrEhd15CNNG5xWOdsPWcFPpUWUvzvae2RXHo=;
        b=DD66eG0RceDT1wVmrEB6tmb408s5YHB+uJffUXZ1AwNUynvv+nUSQSa2HUUlonthRtDGQW
        wUWU47XnZQc2bzbpuevIu3PagzpR2u+rK9QJy8G3ZXz6i/9MsbQ26vanqF03DDiKm6wYv4
        ZlFAlgGxVBWNNDKySXFcrs57n3EibPZxTlm8/5tu4dyx36lJREiXHnouogKxQl+8xYh8yv
        vT5yBr6NRhhdXzws+gq/1g677HV3gA6KZM4LOA7esKXTly3OR9X3Mmqj3aTURe8cBDC9Bx
        xuaHs8JdiSxTx5Zj4IWL4NSdwgg3QZ4wYR7HiU+QZoWDoxKsxbzOOvrBqajd5w==
Date:   Fri, 8 Dec 2023 12:33:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Jean Delvare <jdelvare@suse.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 19/39] mtd: rawnand: add support for ts72xx
Message-ID: <20231208123338.37f1a141@xps-13>
In-Reply-To: <6bc0cf7ea58fae2e6a3765f673a777788d465984.camel@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
        <20231122-ep93xx-v5-19-d59a76d5df29@maquefel.me>
        <ZV3y-IJ7JSD3fJeI@smile.fi.intel.com>
        <6bc0cf7ea58fae2e6a3765f673a777788d465984.camel@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < instr->ctx.addr.naddrs; i++)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iow=
rite8(instr->ctx.addr.addrs[i], data- =20
> > > >base); =20
> >=20
> > iowrite8_rep() ?
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case NAND_OP_DATA_IN_INSTR:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ioread8_rep(data->base, instr->ctx.data.buf.in,
> > > instr->ctx.data.len); =20
> >=20
> > Hehe, you are even using it...
> >=20
> > ...
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (instr->delay_ns) =20
> >=20
> > What will happen if you drop this check?
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ndelay(instr->delay_ns); =20
>=20
> No idea! I was asked to keep it by Miquel:

Your controller is very simple and just queues whatever command you
ask, precisely when you ask it to do so. But the NAND bus is a bit more
complex and there are minimum delays between certain instructions. This
delay is meant to respect that. Sometimes it will be 0, and sometimes
not. It depends what NAND op you do. You can check the value of these
delays in the core.

Thanks,
Miqu=C3=A8l
