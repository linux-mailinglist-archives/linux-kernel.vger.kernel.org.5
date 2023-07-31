Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F679769B47
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjGaPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGaPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:51:58 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11920E57
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:51:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2050FF80E;
        Mon, 31 Jul 2023 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690818715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHXtXcIF8yoLKtyFFJoKXL+jgRrVtDE/FSZYSiXVhQk=;
        b=BicRcU0GIYR+KeqsnOpBvSkWQypVzZOcyeFNm0UIovcVTdMCfOr7jQmC+59TIdt6IVCYAy
        3VWpbxdSdtgv7b4hkEjUnHO1p9RVal8J9EzJ4qhL5ImcR3nxX7MPsz0o+czTtDD06gn3Li
        mgWIVVLsX63IMJU1bgoso3a0Dw3PIS5UaA+Kt89udcnPXlCw28+rPL+AcarXGEO1K1jndU
        DTnHKoVB6+pvdEEXJEAMYOV2lLnPoodFnKxlE59xpuKCUm0WYX4reMHY6nwmLag8ac42k0
        7zc2Oj5YtROOT1Dx2TPyw2fvQG6MIYhX2CrYdzWAbH0TxdHJoNwwqYIDH4ebeQ==
Date:   Mon, 31 Jul 2023 17:51:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "John Thomson" <lists@johnthomson.fastmail.com.au>
Cc:     "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Robert Marko" <robert.marko@sartura.hr>,
        "Luka Perkov" <luka.perkov@sartura.hr>,
        "Michael Walle" <michael@walle.cc>,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: [PATCH v6 1/3] ABI: sysfs-nvmem-cells: Expose cells through
 sysfs
Message-ID: <20230731175152.5c2adbae@xps-13>
In-Reply-To: <925d1b35-3e70-4b5d-9533-f730a652d242@app.fastmail.com>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
        <20230717075147.43326-2-miquel.raynal@bootlin.com>
        <925d1b35-3e70-4b5d-9533-f730a652d242@app.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Srinivas, a question for you below.

lists@johnthomson.fastmail.com.au wrote on Sun, 23 Jul 2023 19:39:50
+0000:

> Hi Miquel,
>=20
> On Mon, 17 Jul 2023, at 07:51, Miquel Raynal wrote:
> > The binary content of nvmem devices is available to the user so in the
> > easiest cases, finding the content of a cell is rather easy as it is
> > just a matter of looking at a known and fixed offset. However, nvmem
> > layouts have been recently introduced to cope with more advanced
> > situations, where the offset and size of the cells is not known in
> > advance or is dynamic. When using layouts, more advanced parsers are
> > used by the kernel in order to give direct access to the content of each
> > cell regardless of their position/size in the underlying device, but
> > these information were not accessible to the user.
> >
> > By exposing the nvmem cells to the user through a dedicated cell/ folder
> > containing one file per cell, we provide a straightforward access to
> > useful user information without the need for re-writing a userland
> > parser. Content of nvmem cells is usually: product names, manufacturing
> > date, MAC addresses, etc,
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  Documentation/ABI/testing/sysfs-nvmem-cells | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
> >
> > diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells=20
> > b/Documentation/ABI/testing/sysfs-nvmem-cells
> > new file mode 100644
> > index 000000000000..b2d15a8d36e5
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
> > @@ -0,0 +1,19 @@
> > +What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
> > +Date:		May 2023
> > +KernelVersion:	6.5
> > +Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
> > +Description:
> > +		The "cells" folder contains one file per cell exposed by
> > +		the nvmem device. The name of the file is the cell name. =20
>=20
> Could we consider using a file within a folder (name defined by cell prop=
ertys) to access the cell bytes?
> Example (pick the best path and filename):
> /sys/bus/nvmem/devices/.../cells/<cell-name>/bytes
>=20
> That way, it is much easier to expand this at a later stage,
> like adding an of_node link at
> /sys/bus/nvmem/devices/.../cells/<cell-name>/of_node
> or exposing other nvmem cell properties.

I have no strong opinion. Srinivas what do you prefer? I'm fine either
ways. I like the simplicity of the current approach more, but it's true
that it is more easy to make it grow if we follow John idea.

> This is particularly relevant given the cell-name alone does not always
> uniquely represent a cell on an nvmem device.
> https://lore.kernel.org/lkml/ZLaZ7fzUSsa0Igx1@makrotopia.org/

It seems like this is gonna be fixed by suffixing @<offset> to the
name, as anyway whatever solution we choose, it is gonna be needed.

> https://lore.kernel.org/lkml/e7173ab2-d3b2-4f75-beb8-32593b868774@www.fas=
tmail.com/
>=20
> > +		The length of the file is the size of the cell (when
> > +		known). The content of the file is the binary content of
> > +		the cell (may sometimes be ASCII, likely without
> > +		trailing character).
> > +		Note: This file is only present if CONFIG_NVMEM_SYSFS
> > +		is enabled.
> > +
> > +		Example::
> > +
> > +		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name
> > +		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
> > +		  0000000a
> > --=20
> > 2.34.1 =20
>=20
> Cheers,
>=20


Thanks,
Miqu=C3=A8l
