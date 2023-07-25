Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D9760DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjGYI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjGYI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0281999
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690275391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjRd2nXHnXpUTy8R/0ufiPmbuZDhKs4iFIHNNr41mVY=;
        b=YCiIwDEC2TdXyPmC64vI2CP5+SVv/DePMdRrUXMuuurPg2PDrk70m/efkd9GHC76aRkF0p
        UrlrVSvuta9qSJwahbwOy/5XisDYdQbkO39dvdiNUtNThZCz+3OueO1w37PqekSjE4P3r2
        8S5z5bzbUUq38IYcBnEY+GnG/DPDlF4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-ScUp7Bg_PQWxGsc3NXfn-w-1; Tue, 25 Jul 2023 04:56:30 -0400
X-MC-Unique: ScUp7Bg_PQWxGsc3NXfn-w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63d05a56b4dso4131686d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275389; x=1690880189;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjRd2nXHnXpUTy8R/0ufiPmbuZDhKs4iFIHNNr41mVY=;
        b=UOjNShUu4fNzpzWbV9p/MyaPwiBl+DyHvIc2NwerfnfxZYRSMB03Byz1aftJ3It1CL
         vZSZVXofg4dkTRbux87whngVoeY1CAELX8Tb8hr96PEcISzG2o1jqchE2hmedjqexysT
         uk3bYn/XM74e4W4t7Qm5oWnuyic1/8GM+BSrUO3pE6YsTpCqmbaqlbtgQNWNvisHWdgM
         qCjvyLFgK3Y77+YkKJYvLNIb+XfRGHIJ7ZJ5CtfBGNR7tjSASHCx/vcBj7jBHU/g0gJ6
         Th9ez/Wpapzwv5P3okIQBHGN3pObSXG+WWrjhhjKPXc/cemMMmxOELivrO0H74wMyIwu
         4Y8A==
X-Gm-Message-State: ABy/qLaxUR12ugA9aZwHixc+Iwyy7OwEd5zMX930EN616ec2r6u+MxZa
        7UFwJ6VaTREaeLfrrnOKv/aD5GPygJ36gSRfhquRPuu5Zb7Z6oDS4BZfDEabFJzrRyVhs/2jbLF
        GwfG2ADLEK8bFVQorU1eFePIY
X-Received: by 2002:a05:6214:29cb:b0:635:fa38:5216 with SMTP id gh11-20020a05621429cb00b00635fa385216mr15071856qvb.0.1690275389736;
        Tue, 25 Jul 2023 01:56:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+nOjJOePunrQn7mkCSkHunCPbip77FXQTvq7evnjfLoJQF3TxUHbxETMJrfEnmyfzEWwCgA==
X-Received: by 2002:a05:6214:29cb:b0:635:fa38:5216 with SMTP id gh11-20020a05621429cb00b00635fa385216mr15071848qvb.0.1690275389443;
        Tue, 25 Jul 2023 01:56:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id x14-20020a0ce0ce000000b00623813aa1d5sm4210585qvk.89.2023.07.25.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:56:29 -0700 (PDT)
Message-ID: <30e262679bfdfd975c2880b990fe8375b9860aab.camel@redhat.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ante Knezic <ante.knezic@helmholz.de>, netdev@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Jul 2023 10:56:25 +0200
In-Reply-To: <20230721102618.13408-1-ante.knezic@helmholz.de>
References: <20230721102618.13408-1-ante.knezic@helmholz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-21 at 12:26 +0200, Ante Knezic wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.
>=20
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
> V3 : Rework to fit the new phylink_pcs infrastructure
> V2 : Rework as suggested by Andrew Lunn <andrew@lun.ch>=20
>  * make int lanes[] const=20
>  * reorder prod_nums
>  * update commit message to indicate we are dealing with
>    undocumented Marvell registers and magic values
> ---
>  drivers/net/dsa/mv88e6xxx/pcs-639x.c | 42 ++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e=
6xxx/pcs-639x.c
> index 98dd49dac421..50b14804c360 100644
> --- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> +++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> @@ -20,6 +20,7 @@ struct mv88e639x_pcs {
>  	struct mdio_device mdio;
>  	struct phylink_pcs sgmii_pcs;
>  	struct phylink_pcs xg_pcs;
> +	struct mv88e6xxx_chip *chip;
>  	bool supports_5g;
>  	phy_interface_t interface;
>  	unsigned int irq;
> @@ -205,13 +206,52 @@ static void mv88e639x_sgmii_pcs_pre_config(struct p=
hylink_pcs *pcs,
>  	mv88e639x_sgmii_pcs_control_pwr(mpcs, false);
>  }
> =20
> +static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
> +{
> +	const int lanes[] =3D { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
> +		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
> +		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
> +		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };
> +	struct mdio_device mdio;
> +	int err, i;
> +
> +	/* 88e6190x and 88e6390x errata 3.14:
> +	 * After chip reset, SERDES reconfiguration or SERDES core
> +	 * Software Reset, the SERDES lanes may not be properly aligned
> +	 * resulting in CRC errors
> +	 */
> +
> +	mdio.bus =3D mpcs->mdio.bus;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(lanes); i++) {
> +		mdio.addr =3D lanes[i];
> +
> +		err =3D mdiodev_c45_write(&mdio, MDIO_MMD_PHYXS,
> +					0xf054, 0x400C);
> +		if (err)
> +			return err;
> +
> +		err =3D mdiodev_c45_write(&mdio, MDIO_MMD_PHYXS,
> +					0xf054, 0x4000);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
>  					   phy_interface_t interface)
>  {
>  	struct mv88e639x_pcs *mpcs =3D sgmii_pcs_to_mv88e639x_pcs(pcs);
> +	struct mv88e6xxx_chip *chip =3D mpcs->chip;
> =20
>  	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
> =20
> +	if (chip->info->prod_num =3D=3D MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
> +	    chip->info->prod_num =3D=3D MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
> +		mv88e6390_erratum_3_14(mpcs);

It looks like you are ignoring the errors reported by
mv88e6390_erratum_3_14(). Should the above be:

		return mv88e6390_erratum_3_14(mpcs);

instead?

Thanks!

Paolo

