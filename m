Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4B79B1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377198AbjIKWVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbjIKKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:00:08 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E4E67;
        Mon, 11 Sep 2023 03:00:02 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 161041C0004; Mon, 11 Sep 2023 12:00:01 +0200 (CEST)
Date:   Mon, 11 Sep 2023 12:00:00 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pawell@cadence.com, linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.15 10/19] usb: cdns3: Put the cdns set active
 part outside the spin lock
Message-ID: <ZP7lIKUzD68XA91j@duo.ucw.cz>
References: <20230909003903.3580394-1-sashal@kernel.org>
 <20230909003903.3580394-10-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wqD7Cph2pbmvmiU2"
Content-Disposition: inline
In-Reply-To: <20230909003903.3580394-10-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wqD7Cph2pbmvmiU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Xiaolei Wang <xiaolei.wang@windriver.com>
>=20
> [ Upstream commit 2319b9c87fe243327285f2fefd7374ffd75a65fc ]
>=20
> The device may be scheduled during the resume process,
> so this cannot appear in atomic operations. Since
> pm_runtime_set_active will resume suppliers, put set
> active outside the spin lock, which is only used to
> protect the struct cdns data structure, otherwise the
> kernel will report the following warning:

There's something wrong with this patch: cdns_set_active returns
either void or int depending on config. That can't be intentional.

Best regards,
								Pavel

> +++ b/drivers/usb/cdns3/core.c
> @@ -556,15 +555,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
=2E..
> +
> +void cdns_set_active(struct cdns *cdns, u8 set_active)
> +{
> +	struct device *dev =3D cdns->dev;
> +
>  	if (set_active) {
>  		pm_runtime_disable(dev);
>  		pm_runtime_set_active(dev);
>  		pm_runtime_enable(dev);
>  	}
> =20
> -	return 0;
> +	return;
>  }

> +++ b/drivers/usb/cdns3/core.h
> @@ -125,10 +125,13 @@ int cdns_init(struct cdns *cdns);
>  int cdns_remove(struct cdns *cdns);
> =20
>  #ifdef CONFIG_PM_SLEEP
=2E..
>  int cdns_suspend(struct cdns *cdns);
> +void cdns_set_active(struct cdns *cdns, u8 set_active);
>  #else /* CONFIG_PM_SLEEP */
=2E..
> +static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
>  { return 0; }
>  static inline int cdns_suspend(struct cdns *cdns)
>  { return 0; }

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wqD7Cph2pbmvmiU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7lIAAKCRAw5/Bqldv6
8uyWAJ40lI1lM3v257gQVvAQHRibAqeWkQCfQU6EJSPUflkZaJ2qX4r5mj5pKx0=
=R7Gr
-----END PGP SIGNATURE-----

--wqD7Cph2pbmvmiU2--
