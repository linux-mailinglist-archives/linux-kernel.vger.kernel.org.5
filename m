Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E57852F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHWIqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjHWIpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:45:41 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8101D10EF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:41:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4DC21C000A;
        Wed, 23 Aug 2023 08:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692780106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RNJLYcePSzkI7fEgI2jMjFA/0rGYxuU3e2TyRTVFSFE=;
        b=A7tOKQWIcGPOvT0j6jF7kbdbQOsovtM5aYdAKKsO+/2RM63fT0iP6lbAhetSbowi2FY+8P
        1OQ6au4sgjpITbGhbEKMtT0QV0GB5SC6/OdmpV9sZwsoP7MrCa4Z6LRciccJkJnHsS0ouG
        3Z1aBETaNQoY6NR22CfxFI8kLjeNe3ywSavHFHKt1qDV7wtHA3hg8TlZSS1sPGCsFgt19t
        6fTB4JdfvmyApx+UD7YEPsWnWeLz65xhz3zTFWkw1klWPchhiiF61zj80GBRIdGP9OhExZ
        /o/zcOFZsxdsfDwKQNKTkOnoM4yG05UWrgNd2jRe5qSqXGW68tLARD1W/x8EfQ==
Date:   Wed, 23 Aug 2023 10:41:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
Subject: Re: [PATCH v2 2/2] mtd: spinand: micron: fixing the offset for OOB
Message-ID: <20230823104143.760cc5bc@xps-13>
In-Reply-To: <01925ff8-1d19-a729-429a-89866fad319f@sberdevices.ru>
References: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
        <20230822122534.872646-3-mmkurbanov@sberdevices.ru>
        <20230822153556.630e65b9@xps-13>
        <01925ff8-1d19-a729-429a-89866fad319f@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

mmkurbanov@sberdevices.ru wrote on Tue, 22 Aug 2023 19:57:11 +0300:

> Hi Miquel,
>=20
> On 22.08.2023 16:35, Miquel Raynal wrote:
> > Hi Martin,
> >=20
> > mmkurbanov@sberdevices.ru wrote on Tue, 22 Aug 2023 15:25:34 +0300:
> >  =20
> >> The first 4 bytes are reserved for bad block data. =20
> >=20
> > Are you sure about that? I've never seen 4-bytes BBM. =20
>=20
> Yes, I'm sure. I have checked in all the relevant datasheets:
> -------------------------------------------------------------------------=
---------
> |        Name        | Max Byte | Min Byte |  Area   |        Description=
        |
> |                    | Address  | Address  |         |                   =
        |
> |--------------------+----------+----------+---------+-------------------=
--------|
> | MT29F2G01ABAGD [1] |          |          |         |                   =
        |
> |--------------------|          |          |         |                   =
        |
> | MT29F2G01ABBGD [2] |          |          |         |                   =
        |
> |--------------------|   803h   |   800h   |         |                   =
        |
> | MT29F1G01ABAFD [3] |          |          |         |                   =
        |
> |--------------------|          |          |         |                   =
        |
> | MT29F4G01ADAGD [4] |          |          |         |                   =
        |
> |--------------------+----------+----------| Spare 0 | Reserved (bad bloc=
k data) |
> | MT29F4G01ABAFD [5] |          |          |         |                   =
        |
> |--------------------|          |          |         |                   =
        |
> | MT29F4G01ABBFD [6] |          |          |         |                   =
        |
> |--------------------|  1003h   |  1000h   |         |                   =
        |
> | MT29F8G01ADAFD [7] |          |          |         |                   =
        |
> |--------------------|          |          |         |                   =
        |
> | MT29F8G01ADBFD [8] |          |          |         |                   =
        |
> -------------------------------------------------------------------------=
---------
>=20
> Note: to view the datasheet on the Micron (https://www.micron.com/) websi=
te, you need
> to register.

I don't think the four bytes have any "bad block specific" meaning. In
practice, the datasheet states:

	Value programmed for bad block at the first byte of spare
	area: 00h

So only the first byte is used to mark the block bad, the rest is
probably marked "reserved" for simplicity. I believe we should keep the
current layout because it would otherwise break users for no real
reason.

> Links:
>   [1] https://datasheet.lcsc.com/lcsc/1912111437_Micron-Tech-MT29F2G01ABA=
GDWB-IT-G_C410863.pdf - page 45
>   [2] https://www.micron.com/-/media/client/global/documents/products/dat=
a-sheet/nand-flash/70-series/m79a_2gb_1_8v_nand_spi.pdf - page 46
>   [3] https://datasheet.lcsc.com/lcsc/2209201030_Micron-Tech-MT29F1G01ABA=
FDWB-IT-F_C2905686.pdf - page 46
>   [4] https://www.micron.com/-/media/client/global/documents/products/dat=
a-sheet/nand-flash/70-series/m79a_ddp_4gb_3v_nand_spi.pdf - page 46
>   [5] https://www.micron.com/-/media/client/global/documents/products/dat=
a-sheet/nand-flash/70-series/m70a_4gb_3v_nand_spi.pdf - page 47
>   [6] https://www.micron.com/-/media/client/global/documents/products/dat=
a-sheet/nand-flash/70-series/m70a_4gb_1_8v_nand_spi.pdf - page 49
>   [7] https://www.micron.com/-/media/client/global/documents/products/dat=
a-sheet/nand-flash/70-series/m70a_ddp_8gb_3v_nand_spi.pdf - page 48
>   [8] https://www.micron.com/-/media/client/global/documents/products/dat=
a-sheet/nand-flash/70-series/m70a_ddp_8gb_1_8v_nand_spi.pdf - page 48
>=20

Thanks,
Miqu=C3=A8l
