Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02057A62D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjISM1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:27:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD07F2;
        Tue, 19 Sep 2023 05:27:10 -0700 (PDT)
Received: from mercury (dyndsl-091-248-212-118.ewe-ip-backbone.de [91.248.212.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8480A66030BF;
        Tue, 19 Sep 2023 13:27:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695126429;
        bh=bJOhqJ1O0bfD7eY915QEmApQ+GKZkfCj19YUaLhrwt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGu86XrO19aQccHVyuuWqpp9anuL/AhblpvkTX8JcViuh4Mfsrn++HsF/tvfvhpEN
         NLAhLx6/rJ8ocTTZEvEWX25IXU9KqNierS6FHpiOKR/tLJyAfCnWCQVsMkQf2ID/uL
         7FLKYDPP2lmIljEFm0n2qHLvjfylePQqn6jlEhBku0tdTdpjHiqj27iqHb9dWJ/Sau
         QF/7qs5e27F51fQWJL5rQxEBNDVCR8IhllTECv87AZ21L/uuQWpbs6hPvWXmQ3hWO4
         zyRy+agmvAw1b1yGR9H1OLQweqZNVCB4FDr/WxXqWwAGd5Y4OZ3qZjWr7vbM7pUAno
         MeI2GsaqkNwcw==
Received: by mercury (Postfix, from userid 1000)
        id CE0CB10604FC; Tue, 19 Sep 2023 14:27:06 +0200 (CEST)
Date:   Tue, 19 Sep 2023 14:27:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH] power: supply: Fix info use-after-free
Message-ID: <20230919122706.anj3kfvlnxm5vboo@mercury.elektranox.org>
References: <20230918-power-uaf-v1-1-73c397178c42@axis.com>
 <20230918150438.4pliix4fhbpjld3l@mercury.elektranox.org>
 <11d30081b64935c2c3d45e5197cabbc25082a3fe.camel@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ybrmbrkllwbyxvc2"
Content-Disposition: inline
In-Reply-To: <11d30081b64935c2c3d45e5197cabbc25082a3fe.camel@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ybrmbrkllwbyxvc2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 19, 2023 at 07:33:01AM +0000, Vincent Whitchurch wrote:
> On Mon, 2023-09-18 at 17:04 +0200, Sebastian Reichel wrote:
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/=
supply/power_supply_sysfs.c
> > index 06e5b6b0e255..d483a81560ab 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -482,6 +482,13 @@ int power_supply_uevent(const struct device *dev, =
struct kobj_uevent_env *env)
> > =A0=A0=A0=A0=A0=A0=A0=A0if (ret)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > =A0
> >=20
> > +       /*
> > +        * Kernel generates KOBJ_REMOVE uevent in device removal path, =
after
> > +        * resources have been freed. Exit early to avoid use-after-fre=
e.
> > +        */
> > +       if (psy->removing)
> > +               return 0;
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0prop_buf =3D (char *)get_zeroed_page(GFP_KERNEL=
);
> > =A0=A0=A0=A0=A0=A0=A0=A0if (!prop_buf)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> >=20
> > That would also cover the no-parent-device part and avoid the
> > device(s) being queried for data at device removal time, which
> > wouldn't work if the device removal happens due to a hot-unplug.
>=20
> Works for me.
>=20
> Tested-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Ok, I added it to power-supply's fixes branch as 3dc0bab23dba53f315c9a7b4a6=
79e0a6d46f7c6e.

-- Sebastian

--ybrmbrkllwbyxvc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUJk48ACgkQ2O7X88g7
+pqkxxAAmY5ILQKR4KtnWjDpdm4nPt+Pu/GxgZBzIgM2SPLmcgzO9eAYPqo0NCsM
S2jAFlYHLuoKSkqr/3VsUz5dneM/mlcFim1KlMb52bz16biof9IlNPyDnM+6Xqrf
4qPKa+hp2drfFjS7ho1sXEi3BwNuY81OTSW/qGAy195ZX9Emn5WPXuRX6JXtpO62
GxUNFO/d9jS5IUGgtzCo+At+gdR41MhHe8IsyNnPtUUrO63MGYHoA8vc7JgiRlu1
kEks2AE04WkO78wJZ36W72mKAt0uO4qj5HNtuS/Lb90i+Pkt7eNaxHBudQekJWCt
BqWS+tE92Kc7iynsFRoMONiAXZ037csWfXutoVaZ5vnSczGa1SecqyIlLfRa+n+N
pTWRnJtl/jUOYYjmP4+4pa1PaX+8/GmkqlBSJxx77JGmtccRJDghVbEU/Q6TpRoZ
vBhGFHzExK/8rtw5kX0Wl4Qf2pqT5DqCs4jknSKbqM/zsoAfaAVsrXTQj+T7U4r1
uKK4Z/6ValKPnUmCWTf1ZcKgbbs4gp2RlL2pCFDz0hCx76+BH+ZnKS2ZfcDy17yu
SOh86G/Y09LUnkVqK/v5xymPtuh+qWrZzIrxDYoCwT96ER5I3xZ1PrpSdmpFYdgc
ZrghsuCqPWeCafJvzW2uJKcg2tYmhpVE05SwoPHrfVWd+tbU2t8=
=2YSV
-----END PGP SIGNATURE-----

--ybrmbrkllwbyxvc2--
