Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452FC7B1866
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjI1Kle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjI1Kld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:41:33 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281C6180;
        Thu, 28 Sep 2023 03:41:31 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E16EB86D43;
        Thu, 28 Sep 2023 12:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695897688;
        bh=Wzpgjs6mWySEfmbSXZD6sOrG7h49v7bxeVjk8kZzqGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mKR0v25+bRdbnxePhZmeHROTBjUZiGC89+Y2i1KpUUfuShJeglR+U6+FXZ9I1f4RO
         0pLvxoBLpBgk7Se8Wfem+QQcLDxgZJVX/xGLqBrHGQP20NaheMFDpLwrwHRtfpAYFx
         EF1CZJMOghZs7d1/amzE1O/diQgo9tvq+WIGA6x6nFI8Qh7aZwMaktqHE6vBo+qVlQ
         pQC2LItK5iTFSwTXoqw+apiH6DZlbSYE3TSF+GaYAsVjjqObcMKxvY0+So4eKC8BvI
         O7TZq/42kTCWgofpvaW3zEB+wmnkv7UwhssfED5BHGkTdeKahXeYZIaFuaSxot1Wz8
         dZCj6YcPuiiOQ==
Date:   Thu, 28 Sep 2023 12:41:27 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20230928124127.379115e6@wsk>
In-Reply-To: <20230926225401.bganxwmtrgkiz2di@skbuf>
References: <20230922133108.2090612-1-lukma@denx.de>
        <20230926225401.bganxwmtrgkiz2di@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8+0qi8Itm=oCcSvVygFjJaM";
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

--Sig_/8+0qi8Itm=oCcSvVygFjJaM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Fri, Sep 22, 2023 at 03:31:03PM +0200, Lukasz Majewski wrote:
> > This patch series provides support for HSR HW offloading in KSZ9477
> > switch IC.
> >=20
> > To test this feature:
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > 45 version 1 ip link set dev lan1 up
> > ip link set dev lan2 up
> > ip a add 192.168.0.1/24 dev hsr0
> > ip link set dev hsr0 up
> >=20
> > To remove HSR network device:
> > ip link del hsr0
> >=20
> > To test if one can adjust MAC address:
> > ip link set lan2 address 00:01:02:AA:BB:CC
> >=20
> > It is also possible to create another HSR interface, but it will
> > only support HSR is software - e.g.
> > ip link add name hsr1 type hsr slave1 lan3 slave2 lan4 supervision
> > 45 version 1
> >=20
> > Test HW:
> > Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".
> >=20
> > Performance SW used:
> > nuttcp -S --nofork
> > nuttcp -vv -T 60 -r 192.168.0.2
> > nuttcp -vv -T 60 -t 192.168.0.2
> >=20
> > Code: v6.6.0-rc2+ Linux net-next repository
> > SHA1: 5a1b322cb0b7d0d33a2d13462294dc0f46911172
> >=20
> > Tested HSR v0 and v1
> > Results:
> > With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
> > With no offloading 		       RX: 63 Mbps  TX: 63 Mbps =20
>=20
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>=20
> Thanks!

I hope, that it will find its way to net-next soon :-).

Thanks for your help and patience.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/8+0qi8Itm=oCcSvVygFjJaM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUVWFcACgkQAR8vZIA0
zr2NSwf/VvubbhJELqnloer/WmmgIWY280zyWl1b2FxcakpfoJbDOHWJrLJ5+FIC
lWyDUoih8OUL3bSxE1kkeDmjxm+XDm5qeNynmow18uKUl34ebgs1xBlO8iV0jjC7
ICW3GmV3DApcs3fo7P+kHSd3p3HkZpo+mppLskNVYVg1AoRkvPZxi84tkjQKPMBn
8+ZjelJcCmoDIvyu7Ik/2+vo/CROhqTYWekJdzR0OBzelPw117soOB9gVypGBzcB
nd67sJ3nHACYsMn8IKMIQKgj8EwgR14XGLrbenbQLpb7S3mtDo4OquO8S44tpdnG
SWBhMwV6DfBKcHYo5HDj41bovvjxXQ==
=ATx/
-----END PGP SIGNATURE-----

--Sig_/8+0qi8Itm=oCcSvVygFjJaM--
