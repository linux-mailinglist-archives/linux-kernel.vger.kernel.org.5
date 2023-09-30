Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDD7B423A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjI3QjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3QjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:39:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A05DAB;
        Sat, 30 Sep 2023 09:39:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B001C433C7;
        Sat, 30 Sep 2023 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696091954;
        bh=5Rso+ZSnc5OcCyyuD3mBmZDa4c7Bh6j3+cSFPCMfCUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TDYxRJaGGZ7zEGwfJuPt645qmtLUp5vVT8yHQRf+CDfQCDhKpkyHQ41Hx16E+OhG3
         KI6o+unOr95bUAw0pVbacQ++NFP2XsMXLeWlxkAoIpkxrfDJ2rWvrtipol6LrX0OSU
         Wd1PBtS6hrzPipsk0znjeL+z4JvBLErJZu8mOwWeO3v8zxlbI/3TMKU6Rz+Ky2P+fF
         oBCQ+u7sIiR8XocyoaTtJ6et+P9wZTiDpg116hU4qcGLpE1jxXPVmFLPaYzPuSlgLj
         obzUpBwsioYUL8UMIZOfuzAYuygPBAqVniv48RN53YJPHNKmBbXZOjGMI0o3ITAaPd
         bJbCRPK6MHKtQ==
Date:   Sat, 30 Sep 2023 17:39:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Ramona Gradinariu <ramona.gradinariu@analog.com>,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: imu: adis16475.c: Add buffer padding after
 temp channel
Message-ID: <20230930173916.7bed020c@jic23-huawei>
In-Reply-To: <d1c7ce3085ad30e568181852df07fed3a0427d8c.camel@gmail.com>
References: <20230926085721.645687-1-ramona.gradinariu@analog.com>
        <20230926085721.645687-2-ramona.gradinariu@analog.com>
        <d1c7ce3085ad30e568181852df07fed3a0427d8c.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 12:50:38 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2023-09-26 at 11:57 +0300, Ramona Gradinariu wrote:
> > The temperature channel has 16-bit storage size. We need to perform
> > the padding to have the buffer elements naturally aligned in case
> > the temperature channel is enabled and there are any 32-bit storage
> > size channels enabled which have a scan index higher than the
> > temperature channel scan index.
> >=20
> > Fixes: 8f6bc87d67c0 ("iio: imu: adis16475.c: Add delta angle and delta
> > velocity channels")
> > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the togreg branch of iio.git.

Jonathan

>=20
> > =C2=A0drivers/iio/imu/adis16475.c | 10 ++++++++++
> > =C2=A01 file changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > index 00e4e09cdafb..9af07fec0d89 100644
> > --- a/drivers/iio/imu/adis16475.c
> > +++ b/drivers/iio/imu/adis16475.c
> > @@ -1197,6 +1197,16 @@ static irqreturn_t adis16475_trigger_handler(int=
 irq,
> > void *p)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (bit) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0case ADIS16475_SCAN_TEMP:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
st->data[i++] =3D buffer[offset];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The=
 temperature channel has 16-bit storage size.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We =
need to perform the padding to have the buffer
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ele=
ments naturally aligned in case there are any
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 32-=
bit storage size channels enabled which have a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sca=
n index higher than the temperature channel scan
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ind=
ex.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (*i=
ndio_dev->active_scan_mask &
> > GENMASK(ADIS16475_SCAN_DELTVEL_Z, ADIS16475_SCAN_DELTANG_X))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->data[i++] =3D 0; =20
>=20
> You could use ADIS16500_BURST_DATA_SEL_1_CHN_MASK but I kind of agree lik=
e this
> is more obvious what's going on...
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
break;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0case ADIS16475_SCAN_DELTANG_X ... ADIS16475_SCAN=
_DELTVEL_Z:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
buff_offset =3D ADIS16475_SCAN_DELTANG_X; =20
>=20

