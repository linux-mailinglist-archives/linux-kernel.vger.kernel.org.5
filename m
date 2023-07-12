Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC175107A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjGLS0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjGLS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:26:51 -0400
Received: from dnyon.com (dnyon.com [142.132.167.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708A19A7;
        Wed, 12 Jul 2023 11:26:50 -0700 (PDT)
From:   Alejandro Tafalla <atafalla@dnyon.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1689186407; bh=Cd6yq1pU1C12fymMiRQBdR5VsyxWAnsOWQLmupXPnrA=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=kQ8T5yBxLIe0wWmovMdQSBJsMmu55cJWq1h7rFwWhdvCpuOPLXh7FIEys1OYXZqvA
         HLKZAsk7Cp8jdPhbKSU14vdMALi4B1+kKo+CbW6ubNe8L2Iv0k6LLS+yUaYVmVzJtR
         /pK0DCHunetUH7TX18xofBqO2WLzT9M0k6kDY+OG6lmu+ce3jxWKwYnL9ZefpEjA7w
         dnOa1lvX/LiuKx1OOfvAsQsQTnX2nK1ZtXxW9dHpn0/OISuLE47DBKjD4BYy5CT3x/
         hR6HFVNVt/OBk3+YRs6GhMzDW1NVpEqpcz12gmgbnH09tHFA+6+5sO5AEWDAcLz8ni
         LPvlvwwN/oU2/jncAcIx/7tysFoOTT8WvEnFOZbjN8l+BBRTdcjxtdCUIYxcpBMORj
         w4rpA8cWNSvJSnbmNXBamjdVUxB85/AOiHhfI+VWsEIjRk2EtLAjpXcAG489sihYG1
         dfSKrSpwEXSz7TKbgtErnpMo7m8ViRSWYcarY7GHRFxKbYAE483QsGTKgV3nh7QB+D
         altv5Jx+HcvpxOem8YFsCb1wQ8SXlTJu4FWU0pKBTh3Bka9eJDoIJEZEOc2QPw3JLT
         dHI8io1zxbpm0+U++WW1NXGYAwGV/gVvLuzsa596A6rBArDHK6xDuCM4UtdU4m2e9p
         Xy7hHDX+zYLf6xS15rj9xmqs=
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] iio: imu: lsm6dsx: Fix mount matrix retrieval
Date:   Wed, 12 Jul 2023 20:24:47 +0200
Message-ID: <13064186.O9o76ZdvQC@alexpc>
In-Reply-To: <ZK6IpZvG47zsKZFk@lore-rh-laptop>
References: <12960181.O9o76ZdvQC@alexpc> <ZK6IpZvG47zsKZFk@lore-rh-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mi=C3=A9rcoles, 12 de julio de 2023 13:04:05 (CEST) Lorenzo Bianconi wro=
te:
> > The function lsm6dsx_get_acpi_mount_matrix should return true when ACPI
> > support is not enabled to allow executing iio_read_mount_matrix in the
> > probe function.
> >=20
> > Fixes: dc3d25f22b88 ("iio: imu: lsm6dsx: Add ACPI mount matrix retrieva=
l")
> >=20
> > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > ---
> >=20
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > b/drivers/iio/imu/ st_lsm6dsx/st_lsm6dsx_core.c
> > index 6a18b363cf73..62bc3ee783fb 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(struct
> > device *dev,
> >=20
> >  static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
> > =20
> >  					  struct
> >=20
> > iio_mount_matrix *orientation)
> >=20
> >  {
> >=20
> > -	return false;
> > +	return true;
>=20
> I would say it should return something like -EOPNOTSUPP.
>=20
> Regards,
> Lorenzo
>=20
> >  }
> > =20
> >  #endif

Hi, thank you for the review. I'll send a v2 with a better solution that us=
es=20
error codes.

Alejandro.



