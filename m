Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93727771B64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjHGHU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:20:54 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40006A7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:20:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9476460002;
        Mon,  7 Aug 2023 07:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691392849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lN+F26YYEeoRtEr454n7rUo+u7fYWChu8iHItg+7Ueg=;
        b=Uwa0CvgWrIchh3SmriR3bgQqGjhskQWepch5nWkJMZOCSHz0e0kA1bZrcBUs0OPMrTUfB3
        3FmGDzczYmE7e/yTLT+JUWs7YC5Qx/YEkARe4/kbqo5bxQASgATXibvMbNYNw/586/ce0n
        nR9I1OZs6NXvrWs8xCOakKMRd9eP5ex/92k0ltrWXL3VqMRfsJ7docviLegPV0quCZJywz
        fnQc+dKGx7B9RQgdKgfpbsv9r42/s4UOJU5ZpgmlVUet/DgpEjvJCvzYOaOhmDpNguJoR9
        qg1pMHzJ7vp4OMjVtAW3wFqYCLkdX4ws8skEesFA6m3QTY0+vIVdBLFL8e4OvA==
Date:   Mon, 7 Aug 2023 09:20:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v7 6/7] ABI: sysfs-nvmem-cells: Expose cells through
 sysfs
Message-ID: <20230807092047.1525e6a5@xps-13>
In-Reply-To: <ZM5hwcuxKIE0N_iJ@makrotopia.org>
References: <20230801182132.1058707-1-miquel.raynal@bootlin.com>
        <20230801182132.1058707-7-miquel.raynal@bootlin.com>
        <ZM5hwcuxKIE0N_iJ@makrotopia.org>
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

Hi Daniel,

daniel@makrotopia.org wrote on Sat, 5 Aug 2023 15:50:41 +0100:

> On Tue, Aug 01, 2023 at 08:21:31PM +0200, Miquel Raynal wrote:
> > The binary content of nvmem devices is available to the user so in the
> > easiest cases, finding the content of a cell is rather easy as it is
> > just a matter of looking at a known and fixed offset. However, nvmem
> > layouts have been recently introduced to cope with more advanced
> > situations, where the offset and size of the cells is not known in
> > advance or is dynamic. When using layouts, more advanced parsers are
> > used by the kernel in order to give direct access to the content of each
> > cell regardless of their position/size in the underlying device, but
> > these information were not accessible to the user.
> >=20
> > By exposing the nvmem cells to the user through a dedicated cell/ folder
> > containing one file per cell, we provide a straightforward access to
> > useful user information without the need for re-writing a userland
> > parser. Content of nvmem cells is usually: product names, manufacturing
> > date, MAC addresses, etc,
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  Documentation/ABI/testing/sysfs-nvmem-cells | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentatio=
n/ABI/testing/sysfs-nvmem-cells
> > new file mode 100644
> > index 000000000000..a1d140dcbd5d
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
> > @@ -0,0 +1,21 @@
> > +What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
> > +Date:		May 2023
> > +KernelVersion:	6.5
> > +Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
> > +Description:
> > +		The "cells" folder contains one file per cell exposed by the
> > +		NVMEM device. The name of the file is: <name>@<where>, with
> > +		<name> being the cell name and <where> its location in the NVMEM
> > +		device, in hexadecimal (without the '0x' prefix, to mimic device
> > +		tree node names). The length of the file is the size of the cell
> > +		(when known). The content of the file is the binary content of
> > +		the cell (may sometimes be ASCII, likely without trailing
> > +		character).
> > +		Note: This file is only present if CONFIG_NVMEM_SYSFS
> > +		is enabled.
> > +
> > +		Example::
> > +
> > +		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name =20
>=20
> Location is missing here, should be something like
>   hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name@f00

Yes. I forgot to update the cover letter as well. I will do it in next
version.

Thanks,
Miqu=C3=A8l
