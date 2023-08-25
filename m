Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23578824B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbjHYIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243781AbjHYIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:39:23 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA86EE7D;
        Fri, 25 Aug 2023 01:39:20 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id DB2FC8640E;
        Fri, 25 Aug 2023 10:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1692952759;
        bh=i17KcZi6sMv69Y8xEii5b5JThMFIT9ZeP6SHcy5yWtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gUOf3bp0rGBQBv862scEPntYJQ+mUe9HKHmPT2IRXiTrPsX8dsLMG1qu0sOrrRK1P
         eSWknXSTwuCgvQJLne6DRO+UPr/zLF2oTFxOL1gVRQ/1F9NywPwlsl0rwcDTWAHg0N
         Rv5Meiy28In+TOaNz0yFPlcIim251ZS/XU3Fh0PhB/kI4Y7Entyv2hBRRFlTR3GxQD
         61DWraad3ZC7mD1OfGsQ01XvjAhFtbTdOp1g9lReQIyzv0lnoFYv/egBml4yiUpg2u
         H71jKQR+QvJ6uDDBepo3yjyna3c6nvg+uEseQGys/7vKr1dx94SoYpZPpmTPcE9LvG
         I02H97yfQH7Vg==
Date:   Fri, 25 Aug 2023 10:39:11 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     <Tristram.Ha@microchip.com>
Cc:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <Woojung.Huh@microchip.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477
 errata (DS80000754C)
Message-ID: <20230825103911.682b3d70@wsk>
In-Reply-To: <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20230824154827.166274-1-lukma@denx.de>
        <20230824154827.166274-2-lukma@denx.de>
        <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/plYHyeasmSVUInH5yiK2.a2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/plYHyeasmSVUInH5yiK2.a2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tristram,

> > +static int ksz9477_errata(struct dsa_switch *ds)
> > +{
> > +       struct ksz_device *dev =3D ds->priv;
> > +       u16 val;
> > +       int p;
> > +
> > +       /* KSZ9477 Errata DS80000754C
> > +        *
> > +        * Module 4: Energy Efficient Ethernet (EEE) feature select
> > must be
> > +        * manually disabled
> > +        *   The EEE feature is enabled by default, but it is not
> > fully
> > +        *   operational. It must be manually disabled through
> > register
> > +        *   controls. If not disabled, the PHY ports can
> > auto-negotiate
> > +        *   to enable EEE, and this feature can cause link drops
> > when linked
> > +        *   to another device supporting EEE.
> > +        *
> > +        *   Only PHY ports (dsa user) [0-4] need to have the EEE
> > advertisement
> > +        *   bits cleared.
> > +        */
> > +
> > +       for (p =3D 0; p < ds->num_ports; p++) {
> > +               if (!dsa_is_user_port(ds, p))
> > +                       continue;
> > +
> > +               ksz9477_port_mmd_read(dev, p, MMD_DEVICE_ID_EEE_ADV,
> > +                                     MMD_EEE_ADV, &val, 1);
> > +
> > +               pr_err("%s: PORT: %d val: 0x%x pc: %d\n", __func__,
> > p, val,
> > +                      ds->num_ports);
> > +
> > +               val &=3D ~(EEE_ADV_100MBIT | EEE_ADV_1GBIT);
> > +               ksz9477_port_mmd_write(dev, p,
> > MMD_DEVICE_ID_EEE_ADV,
> > +                                      MMD_EEE_ADV, &val, 1);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  int ksz9477_setup(struct dsa_switch *ds)
> >  {
> >         struct ksz_device *dev =3D ds->priv;
> > @@ -1157,7 +1195,7 @@ int ksz9477_setup(struct dsa_switch *ds)
> >         /* enable global MIB counter freeze function */
> >         ksz_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE,
> > true);
> >=20
> > -       return 0;
> > +       return ksz9477_errata(ds);
> >  } =20
>=20
> I would prefer to execute the code in ksz9477_config_cpu_port(), as at
> the end there is already a loop to do something to each port.=20

Just some explanation of the taken approach:

1. I've followed already in-mainline code for ksz8795.c
(ksz8_handle_global_errata(ds)) which is executed in ksz8_setup
function.=20

2. I do believe, that separate "errata" function would be more
readable, as KSZ9477 has many more erratas to be added.

> The
> check to disable EEE or not should be dev->info->internal_phy[port],
> as one of the user ports can be RGMII or SGMII, which does not have a
> PHY that can be accessed inside the switch.

Yes, this would be better solution. Thanks for the suggestion.

>=20
> As the EEE register value is simply 6 it should be enough to just set
> the register to zero.  If so we do not need to add back those
> ksz9477_port_mmd_setup functions and just use ksz_pwrite16() to write
> to the MMD register.
>=20

IMHO adding functions to MMD modification would facilitate further
development (for example LED setup).

However, if we only plan to fix this errata, then the MMD access
functions are not required.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/plYHyeasmSVUInH5yiK2.a2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmToaK8ACgkQAR8vZIA0
zr3ekwgAgFwxNjmx9Lc+4ZA3T6NhiEupyQSonzxehCc/tHBmKcZNllwhfxEqUZeE
ok2RXVwTR+HNqVyMrge5K9TPbnCjlDLWGPyAMcaPcEtc9tsFeDyEbWRljhZYkjaQ
nYmcc2S5LalhdCCRdJGhwEiwZl3bNrHoslLxj+lgRMsCoog1A3lM4NiMqFGpkgmI
O0b6SlifRT+7ewXee8ps1nJDeI9SHKDDwH9iI1ievjavHx4p8JHQildSQZWiKkbm
lUHahWDljtNSIukjDAwqQTG8pIaU4iCFVIsKU85LrVqBI9Fs+vWsqsgTeeQZ6XSJ
eJtWa8Ol65WZ/Cf1R0v/IdkUb+SZiA==
=o7y0
-----END PGP SIGNATURE-----

--Sig_/plYHyeasmSVUInH5yiK2.a2--
