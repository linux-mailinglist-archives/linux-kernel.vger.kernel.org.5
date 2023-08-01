Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F01E76B9EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjHAQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjHAQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:50:28 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B89210E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:50:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 514D860005;
        Tue,  1 Aug 2023 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690908624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fngJDTlQm55UuzieJxHzhuoFqug03dAdiNzE2dkdzJs=;
        b=U5tp6+G/Z2p2wVrE/fgugGwfU6d0zMOWy1Y4jcr5cjLSuSAMiCr0sQ3HTnfleU5k6y/+y2
        VD3eyXDBiGKTT/sWIvLylo7PvSdIVLUkzndmFhSzWkOoqDoISkyC8g2WwLKMHdgWhQxxsc
        BAMqSlivLCWFPUwog9gPg5m3uDwQKNNOGI4lPKR0wArQ9adF3HA8snceofxboNOkbnlY7Y
        SE4h5dEr+QvBZp6hMQeUEqCAsqkwHa+xOg5cjVc9HbibshihdRAPLhJ+7+BHmWIoU6rM8H
        3sTJva+pjyKj4vc0ZoY792XvjQu+N8OERsHUWphnUlZnC58fv85YMjBI7H96sQ==
Date:   Tue, 1 Aug 2023 18:50:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     John Thomson <lists@johnthomson.fastmail.com.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 1/3] ABI: sysfs-nvmem-cells: Expose cells through
 sysfs
Message-ID: <20230801185022.03e5aa03@xps-13>
In-Reply-To: <44a87823-1bde-7bba-4a38-d768d2754dec@linaro.org>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
        <20230717075147.43326-2-miquel.raynal@bootlin.com>
        <925d1b35-3e70-4b5d-9533-f730a652d242@app.fastmail.com>
        <20230731175152.5c2adbae@xps-13>
        <44a87823-1bde-7bba-4a38-d768d2754dec@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

srinivas.kandagatla@linaro.org wrote on Tue, 1 Aug 2023 10:06:14 +0100:

> On 31/07/2023 16:51, Miquel Raynal wrote:
> > Hi John,
> >=20
> > Srinivas, a question for you below.
> >=20
> > lists@johnthomson.fastmail.com.au wrote on Sun, 23 Jul 2023 19:39:50
> > +0000:
> >  =20
> >> Hi Miquel,
> >>
> >> On Mon, 17 Jul 2023, at 07:51, Miquel Raynal wrote: =20
> >>> The binary content of nvmem devices is available to the user so in the
> >>> easiest cases, finding the content of a cell is rather easy as it is
> >>> just a matter of looking at a known and fixed offset. However, nvmem
> >>> layouts have been recently introduced to cope with more advanced
> >>> situations, where the offset and size of the cells is not known in
> >>> advance or is dynamic. When using layouts, more advanced parsers are
> >>> used by the kernel in order to give direct access to the content of e=
ach
> >>> cell regardless of their position/size in the underlying device, but
> >>> these information were not accessible to the user.
> >>>
> >>> By exposing the nvmem cells to the user through a dedicated cell/ fol=
der
> >>> containing one file per cell, we provide a straightforward access to
> >>> useful user information without the need for re-writing a userland
> >>> parser. Content of nvmem cells is usually: product names, manufacturi=
ng
> >>> date, MAC addresses, etc,
> >>>
> >>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> ---
> >>>   Documentation/ABI/testing/sysfs-nvmem-cells | 19 +++++++++++++++++++
> >>>   1 file changed, 19 insertions(+)
> >>>   create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells
> >>> b/Documentation/ABI/testing/sysfs-nvmem-cells
> >>> new file mode 100644
> >>> index 000000000000..b2d15a8d36e5
> >>> --- /dev/null
> >>> +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
> >>> @@ -0,0 +1,19 @@
> >>> +What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
> >>> +Date:		May 2023
> >>> +KernelVersion:	6.5
> >>> +Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
> >>> +Description:
> >>> +		The "cells" folder contains one file per cell exposed by
> >>> +		the nvmem device. The name of the file is the cell name. =20
> >>
> >> Could we consider using a file within a folder (name defined by cell p=
ropertys) to access the cell bytes?
> >> Example (pick the best path and filename):
> >> /sys/bus/nvmem/devices/.../cells/<cell-name>/bytes
> >>
> >> That way, it is much easier to expand this at a later stage,
> >> like adding an of_node link at
> >> /sys/bus/nvmem/devices/.../cells/<cell-name>/of_node
> >> or exposing other nvmem cell properties. =20
> >=20
> > I have no strong opinion. Srinivas what do you prefer? I'm fine either
> > ways. I like the simplicity of the current approach more, but it's true
> > that it is more easy to make it grow if we follow John idea. =20
>=20
> Sounds sensible to me.

I've looked a bit more in depth how to do that and to be honest I did
not find an easy way. Attributes and attribute groups are meant to be
used with only one indirection level and making an additional one seems
terribly more complex. Maybe I'm wrong, if you have a piece of code
doing that please share it and I'll make my best to integrate it,
otherwise I think I'll keep the simplest approach.

> >> This is particularly relevant given the cell-name alone does not always
> >> uniquely represent a cell on an nvmem device.
> >> https://lore.kernel.org/lkml/ZLaZ7fzUSsa0Igx1@makrotopia.org/ =20
> >=20
> > It seems like this is gonna be fixed by suffixing @<offset> to the
> > name, as anyway whatever solution we choose, it is gonna be needed. =20
>=20
> we have to be careful here not to break the nvmem_cell_get() users.

I believe this only applies to sysfs names, so nvmem_cell_get() which
uses real cells names should not be affected.

Thanks,
Miqu=C3=A8l
