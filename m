Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D521756EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGQVT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:19:26 -0400
Received: from dnyon.com (dnyon.com [142.132.167.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F88E3;
        Mon, 17 Jul 2023 14:19:24 -0700 (PDT)
From:   Alejandro Tafalla <atafalla@dnyon.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1689628761; bh=D5lRmwj08kxjSeThI7LittGWh8EcM6iGmTNPXI0zWms=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=MnAFCq+GR9BlRoqb7gmG3MSQxPRQTNZZ5E+roiOAoI7uEheYL3RS7R+xmyNilxQ/r
         pin1W7/7RywX5fQzbV10KtdKYuZsieheh31mGhXsq21Jd0brDQ+q7YK9s5kaYOJLrS
         EfXvCEpX19U74d8JMgEUGZknaqElsV8Mxyn9EXSJ2rYPJXS5p0xgsjkONeg/BeKf41
         KZMg33dhhAot3EjuvAunHiuKS7kGmQ+bIRT8TZrCjC2P5ErGypDbys/3/JyGq9ZngT
         N84ULbzsEMqOYdiEdEsxXP7ZB7Oo8rPsA9F3KHjqbzeVO7iYUr2ul5HlUmE44ON7im
         esBd+qGPPpEldiE/eVTg0UQYWY8T9KDGmN3BWgU7RsWTx6NSmy4jL9qBQyWyBxKM2q
         EMehHYs+PNboVqi6sCsyii3unSjmE1zYMm1pzGsFukRWt1r+hRu7eRnnqJC5vkgscX
         7i5PDLQYiOWGotFfvQocaK/kPceUYys+fc5WJ9e136rcJVyrmsJMqEJyLfFvHARs++
         SkDaW318hL/f0HZxFm4jkGOJIKwxjDVudJPBuaTXoa6S8xgcXpDgm28GXUiRBRLbOd
         HuYbDJh7V7opidloCdbaIDnrtcSIEpce0JkH42CaGmOpjPWT/0mp8Jaqq1z6csmBQU
         Vd/XNcTc7SV7XjZt9tnQzuiA=
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: lsm6dsx: Fix mount matrix retrieval
Date:   Mon, 17 Jul 2023 23:17:10 +0200
Message-ID: <3017278.mvXUDI8C0e@alexpc>
In-Reply-To: <20230715183515.56deaa1d@jic23-huawei>
References: <20230714153132.27265-1-atafalla@dnyon.com>
 <20230715183515.56deaa1d@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s=C3=A1bado, 15 de julio de 2023 19:35:15 (CEST) Jonathan Cameron wrote:
> On Fri, 14 Jul 2023 17:31:26 +0200
>=20
> Alejandro Tafalla <atafalla@dnyon.com> wrote:
> > The function lsm6dsx_get_acpi_mount_matrix should return an error when
> > ACPI
> > support is not enabled to allow executing iio_read_mount_matrix in the
> > probe function.
> >=20
> > Fixes: dc3d25f22b88 ("iio: imu: lsm6dsx: Add ACPI mount matrix retrieva=
l")
>=20
> I can fix it up whilst applying if no other issues, but there must not be
> a blank line here.  All tags need to be in a single block for some tooling
> that is used with the kernel tree (and some of the checking scripts warn
> about this so it won't get applied with the blank line here).

Okay, i'll keep it in mind for new patches. Thank you.
>=20
> > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > ---
> > Changes in v3:
> > - Removed unneeded check for err =3D=3D -EOPNOTSUPP.
> >=20
> > Changes in v2:
> > - Use of error codes instead of true/false
> >=20
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c index
> > 6a18b363cf73..b6e6b1df8a61 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(struct
> > device *dev,>=20
> >  static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
> > =20
> >  					  struct=20
iio_mount_matrix *orientation)
> > =20
> >  {
> >=20
> > -	return false;
> > +	return -EOPNOTSUPP;
> >=20
> >  }
> > =20
> >  #endif




