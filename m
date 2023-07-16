Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92802754EEA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjGPN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 09:59:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E766E71
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 06:59:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC48CFF803;
        Sun, 16 Jul 2023 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689515984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Hef0Ea3jScxa9mAWZi2hW9ZLkrXNakcNrcs5gODCx4=;
        b=OqnfAmfHmKtAzauyd78pwZLsaHocNuBtptztVxsiVQTLcCGM3VbFBgDXZppdOuAZD76cYP
        HU76CG9R1aR9Gm1pJ+Q5rkiHTWs3eRq1jxRzLneWHWlSbSyqfSFZJj9+YTY8KeQyaMalqv
        +tOH/2zYL3EQFCco/+SUAvIKP1FlY1tq32i1IWf9Mw9MYi0RVj76Q0gDYVueiDh7wYsEyj
        cUS3iWqJZVFp2RA933jM1Q99uS57KXXUy3IsfFr5W1rniF9BVFdjNQo4bBRGrGW7BPfPva
        Rsp6XRzUApH1QfQSJvbAVhJ44pVH7iBp+NBHTMFP0nl6tF537819t1ll6Aichg==
Date:   Sun, 16 Jul 2023 15:59:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH RESEND v5 1/3] ABI: sysfs-nvmem-cells: Expose cells
 through sysfs
Message-ID: <20230716155942.6ad57689@xps-13>
In-Reply-To: <153c8781-a83a-d7d9-92b2-b82ca9ab06aa@infradead.org>
References: <20230713075508.485072-1-miquel.raynal@bootlin.com>
        <20230713075508.485072-2-miquel.raynal@bootlin.com>
        <153c8781-a83a-d7d9-92b2-b82ca9ab06aa@infradead.org>
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

Hi Randy,

rdunlap@infradead.org wrote on Thu, 13 Jul 2023 08:56:48 -0700:

> Hi,
>=20
> On 7/13/23 00:55, Miquel Raynal wrote:
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
> >  Documentation/ABI/testing/sysfs-nvmem-cells | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentatio=
n/ABI/testing/sysfs-nvmem-cells
> > new file mode 100644
> > index 000000000000..641a7d7dad76
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
> > @@ -0,0 +1,19 @@
> > +What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
> > +Date:		May 2023
> > +KernelVersion:	6.5
> > +Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
> > +Description:
> > +		The cells/ folder contains one file per cell exposed by =20
>=20
> (My shell doesn't show "folders". ;)

What do you mean? Is it your shell that needs fixing? Or is it
something that I need to fix?

> > +		the nvmem device. The name of the file is the cell name.
> > +		The length of the file is the size of the cell (when
> > +		known). The content of the file is the binary content of
> > +		the cell (may sometimes be ASCII, likely without
> > +		trailing character).
> > +		Note: This file is only present if CONFIG_NVMEM_SYSFS
> > +		is enabled =20
>=20
> add ending '.':    enabled.
>=20
> > +
> > +		ex:: =20
>=20
> 		Example::

Yup, I'll fix it in v6.

> or
> 		E.g.::
>=20
> > +
> > +		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name
> > +		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
> > +		  0000000a =20
>=20


Thanks,
Miqu=C3=A8l
