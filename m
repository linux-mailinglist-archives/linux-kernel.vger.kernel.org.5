Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8AE7CF37C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbjJSJFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJSJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:05:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D9FA;
        Thu, 19 Oct 2023 02:05:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E7F3821861;
        Thu, 19 Oct 2023 09:05:12 +0000 (UTC)
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 283F82C4CD;
        Thu, 19 Oct 2023 09:05:12 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 30EBB2016B; Thu, 19 Oct 2023 11:05:10 +0200 (CEST)
Date:   Thu, 19 Oct 2023 11:05:10 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rxorobu3bnor6cuj"
Content-Disposition: inline
In-Reply-To: <20231019070904.521718-1-o.rempel@pengutronix.de>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         TAGGED_RCPT(0.00)[];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: E7F3821861
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rxorobu3bnor6cuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 09:09:04AM +0200, Oleksij Rempel wrote:
> With current kernel it is possible to set flags, but not possible to remo=
ve
> existing WoL flags. For example:
> ~$ ethtool lan2
> ...
>         Supports Wake-on: pg
>         Wake-on: d
> ...
> ~$ ethtool -s lan2 wol gp
> ~$ ethtool lan2
> ...
>         Wake-on: pg
> ...
> ~$ ethtool -s lan2 wol d
> ~$ ethtool lan2
> ...
>         Wake-on: pg
> ...
>=20
> This patch makes it work as expected
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  net/ethtool/wol.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
> index 0ed56c9ac1bc..fcefc1bbfa2e 100644
> --- a/net/ethtool/wol.c
> +++ b/net/ethtool/wol.c
> @@ -108,15 +108,16 @@ ethnl_set_wol(struct ethnl_req_info *req_info, stru=
ct genl_info *info)
>  	struct net_device *dev =3D req_info->dev;
>  	struct nlattr **tb =3D info->attrs;
>  	bool mod =3D false;
> +	u32 wolopts =3D 0;
>  	int ret;
> =20
>  	dev->ethtool_ops->get_wol(dev, &wol);
> -	ret =3D ethnl_update_bitset32(&wol.wolopts, WOL_MODE_COUNT,
> +	ret =3D ethnl_update_bitset32(&wolopts, WOL_MODE_COUNT,
>  				    tb[ETHTOOL_A_WOL_MODES], wol_mode_names,
>  				    info->extack, &mod);
>  	if (ret < 0)
>  		return ret;
> -	if (wol.wolopts & ~wol.supported) {
> +	if (wolopts & ~wol.supported) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, tb[ETHTOOL_A_WOL_MODES],
>  				    "cannot enable unsupported WoL mode");
>  		return -EINVAL;
> @@ -132,8 +133,9 @@ ethnl_set_wol(struct ethnl_req_info *req_info, struct=
 genl_info *info)
>  				    tb[ETHTOOL_A_WOL_SOPASS], &mod);
>  	}
> =20
> -	if (!mod)
> +	if (!mod && wolopts =3D=3D wol.wolopts)
>  		return 0;
> +	wol.wolopts =3D wolopts;
>  	ret =3D dev->ethtool_ops->set_wol(dev, &wol);
>  	if (ret)
>  		return ret;
> --=20
> 2.39.2

This doesn't look right, AFAICS with this patch, the resulting WoL flags
would not depend on current values at all, i.e. it would certainly break
non-absolute commands like

  ethtool -s eth0 wol +g
  ethtool -s eth0 wol -u+g
  ethtool -s etho wol 32/34

How recent was the kernel where you encountered the issue? I suspect the
issue might be related to recent 108a36d07c01 ("ethtool: Fix mod state
of verbose no_mask bitset"), I'll look into it closer.

Michal

--rxorobu3bnor6cuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmUw8UIACgkQ538sG/LR
dpWtggf+Lk2CxYPUS9ik4oz2X5eoDAAvN9rI80fF2DckMVDfGF6mK7n0KOpBN+6o
Ag8CxEt1FyVKp96fYts93EjYPwByvqFpeNkQnhNHOpVPo9HUNAZl2eiGZtyZabU9
FbM04TlORojQbS+4h7qrv4bYW3Tg1w9EzQbtXvfF8gve/fqbYWqVYGSrEY3QO7z9
tWD6YuOpmeZog8dkLljA7bjV2kocDpYa5+pW8eUSfdut+VF8e13WK9PsMcYCNdk+
mpgo7RURmd8pYTYSO5GySbTSxf4V9PBWUUBYtGT0VwdigHLk/XATArmywppjMvSW
PAQOzhgZlIUEs1aUXjiJyBH47oNdMw==
=Np2f
-----END PGP SIGNATURE-----

--rxorobu3bnor6cuj--
