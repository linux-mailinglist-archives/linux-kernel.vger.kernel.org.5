Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD475AAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGTJ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGTJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:29:04 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C510135EA7;
        Thu, 20 Jul 2023 02:14:49 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9DB1A1C0A94; Thu, 20 Jul 2023 11:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1689843996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8CmyUGkYoqBMN7yQuwyjyUq79PeTXu2tHN3lGSPclOI=;
        b=P868O6Of04Gt35xLIFimGpUUpOj9Ciz+zJmAiQ2ggQdddHn6vu9APv3LSdL+pxmSsKX9mY
        bR1O3sVvjLls1xNCAjaBPV/jeixHYYrvpEHRUvMubpTiuyo1T2dothb2ZfUFHywJOB0wzO
        DoPSBQYWM27EoKTIDjJtMbLKoq/t6Ek=
Date:   Thu, 20 Jul 2023 11:06:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>, Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH net v2] net: wireless: Use kfree_sensitive instead of
 kfree
Message-ID: <ZLj5HPT2y8cRhWnC@duo.ucw.cz>
References: <20230719022041.663-1-machel@vivo.com>
 <2023071950-nervous-grub-5ee3@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oMVjCGt+mpHmJqRG"
Content-Disposition: inline
In-Reply-To: <2023071950-nervous-grub-5ee3@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oMVjCGt+mpHmJqRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drive=
rs/net/wireless/microchip/wilc1000/cfg80211.c
> > index b545d93c6e37..45bcadeba2da 100644
> > --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> > +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> > @@ -518,7 +518,7 @@ static int wilc_wfi_cfg_allocate_wpa_igtk_entry(str=
uct wilc_priv *priv, u8 idx)
> >  static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
> >  				      struct key_params *params)
> >  {
> > -	kfree(key_info->key);
> > +	kfree_sensitive(key_info->key);
> > =20
> >  	key_info->key =3D kmemdup(params->key, params->key_len, GFP_KERNEL);
> >  	if (!key_info->key)
> > @@ -656,7 +656,7 @@ static int del_key(struct wiphy *wiphy, struct net_=
device *netdev, int link_id,
> >  	if (!pairwise && (key_index =3D=3D 4 || key_index =3D=3D 5)) {
> >  		key_index -=3D 4;
> >  		if (priv->wilc_igtk[key_index]) {
> > -			kfree(priv->wilc_igtk[key_index]->key);
> > +			kfree_sensitive(priv->wilc_igtk[key_index]->key);
>=20
> Normally "kfree_sensitive()" is used at the end of a function for when
> kfree() of a local variable might not be called because the compiler
> thinks it is smarter than us and optimizes it away.
>=20
> Putting it here, in the normal operation, really doesn't do anything,
> right?  There's always going to be odd data in the heap and normal

It does memzero.

https://elixir.bootlin.com/linux/latest/source/mm/slab_common.c#L1411
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--oMVjCGt+mpHmJqRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLj5HAAKCRAw5/Bqldv6
8q9CAJwI/0+AlEP6IBPaTJ2R5lpBx4s09gCdFA9DHOso/HkKZEgWU4YwD8Hp59k=
=ZG6L
-----END PGP SIGNATURE-----

--oMVjCGt+mpHmJqRG--
