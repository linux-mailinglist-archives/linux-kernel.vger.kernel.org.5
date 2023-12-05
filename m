Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D833804DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjLEJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:33:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A689A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701768786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmV5PIM8N+YASBRCp2k/i8/vJmd/O3Z/jDrIpMhsQ7o=;
        b=RpvA8g8YRk0eTT/3oMmxaZBMnIzImlcSAKBOpDaeTJYs4h3yhnOFmbBEBEjHsjxanPoOAS
        9GjftroAnm9Hufg7cj9OL3aHrqZnsq0QTtBko3/iXXTb65GMN/lU5qJQyYFzg/dzOCGViM
        dD+5guyA6s2Oqtf0El2PiarjPd0i2MU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-zfT3zElzNQWd7bNUV2CA7Q-1; Tue, 05 Dec 2023 04:32:58 -0500
X-MC-Unique: zfT3zElzNQWd7bNUV2CA7Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1ae30a04ffso47295666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768777; x=1702373577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KmV5PIM8N+YASBRCp2k/i8/vJmd/O3Z/jDrIpMhsQ7o=;
        b=QlznUELXTnOZmYYIvOCh7UffTwohpox98egWyHpn53DOL+cAtwL3ClPKqMBAHtdjrR
         at5+jLfduqAjD8nF13cg5sKGx+79jhplEMy7gl0tbDRiFI0xdDRCFdubo/WHduLiQVur
         IRvZdCdPBHuMw5gSPGdsXigbgKFcUqnZF2YvFsZDjaVWhYgDJw+0TpMGVBzvxeLwh9u0
         CvTnATJIFL78Muvzc8qdiT29niTLyakhdrDzzPBhkG/YoV6cu5JH00ZZDoNEQ2fiqeLG
         XzNT6WWan5eFAZFhUAhsk0uzPkxhF8CswPZIW/qBua2H9UEmCwbB+Ildygum7vDTdUjr
         67zw==
X-Gm-Message-State: AOJu0YySSQhNY2PhgyJGHgclkQkpMJgKKi6u0o7pg5bZ+EiMFeLi1onr
        Sn+pB5+njYJ4mzPDS8tXW61sIGx4TNhXuelLk4eyLTVgu84YwwK9eWVepyj7XMdEWqKGV5A744P
        IbG3qa1Yi/OUzuk1Zqk1WDZFRQKtoAYmK
X-Received: by 2002:a05:6402:11cd:b0:54c:6fc0:483a with SMTP id j13-20020a05640211cd00b0054c6fc0483amr7715358edw.2.1701768777008;
        Tue, 05 Dec 2023 01:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrOiNCUmKVi/iGgzgG60YpzCBmx46bRetO9rs0qZVvKYqL4pzT2RAwtddwNEmm+Bl9ygdisQ==
X-Received: by 2002:a05:6402:11cd:b0:54c:6fc0:483a with SMTP id j13-20020a05640211cd00b0054c6fc0483amr7715346edw.2.1701768776687;
        Tue, 05 Dec 2023 01:32:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id z20-20020aa7d414000000b0054c49f1f207sm822636edq.39.2023.12.05.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:32:56 -0800 (PST)
Message-ID: <bdbe618d4fd38469e4e139ce4ebd161766f2e4d5.camel@redhat.com>
Subject: Re: [net-next PATCH v2 08/12] net: phy: at803x: move specific
 at8031 WOL bits to dedicated function
From:   Paolo Abeni <pabeni@redhat.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Dec 2023 10:32:55 +0100
In-Reply-To: <20231201001423.20989-9-ansuelsmth@gmail.com>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
         <20231201001423.20989-9-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 01:14 +0100, Christian Marangi wrote:
> Move specific at8031 WOL enable/disable to dedicated function to make
> at803x_set_wol more generic.
>=20
> This is needed in preparation for PHY driver split as qca8081 share the
> same function to toggle WOL settings.
>=20
> In this new implementation WOL module in at8031 is enabled after the
> generic interrupt is setup. This should not cause any problem as the
> WOL_INT has a separate implementation and only relay on MAC bits.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/at803x.c | 42 ++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 02ac71f98466..2de7a59c0faa 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -466,27 +466,11 @@ static int at803x_set_wol(struct phy_device *phydev=
,
>  			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
>  				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
> =20
> -		/* Enable WOL function for 1588 */
> -		if (phydev->drv->phy_id =3D=3D ATH8031_PHY_ID) {
> -			ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> -					     AT803X_PHY_MMD3_WOL_CTRL,
> -					     0, AT803X_WOL_EN);
> -			if (ret)
> -				return ret;
> -		}
>  		/* Enable WOL interrupt */
>  		ret =3D phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_W=
OL);
>  		if (ret)
>  			return ret;
>  	} else {
> -		/* Disable WoL function for 1588 */
> -		if (phydev->drv->phy_id =3D=3D ATH8031_PHY_ID) {
> -			ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> -					     AT803X_PHY_MMD3_WOL_CTRL,
> -					     AT803X_WOL_EN, 0);
> -			if (ret)
> -				return ret;
> -		}
>  		/* Disable WOL interrupt */
>  		ret =3D phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL,=
 0);
>  		if (ret)
> @@ -1611,6 +1595,30 @@ static int at8031_config_init(struct phy_device *p=
hydev)
>  	return at803x_config_init(phydev);
>  }
> =20
> +static int at8031_set_wol(struct phy_device *phydev,
> +			  struct ethtool_wolinfo *wol)
> +{
> +	int ret;
> +
> +	/* First setup MAC address and enable WOL interrupt */
> +	ret =3D at803x_set_wol(phydev, wol);
> +	if (ret)
> +		return ret;
> +
> +	if (wol->wolopts & WAKE_MAGIC)
> +		/* Enable WOL function for 1588 */
> +		ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +				     AT803X_PHY_MMD3_WOL_CTRL,
> +				     0, AT803X_WOL_EN);
> +	else
> +		/* Disable WoL function for 1588 */
> +		ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +				     AT803X_PHY_MMD3_WOL_CTRL,
> +				     AT803X_WOL_EN, 0);
> +
> +	return ret;

If I read correctly, the above changes the order of some WoL
initialization steps: now WOL_CTRL is touched after
AT803X_INTR_ENABLE_WOL. Is that correct?

Thanks,

Paolo

