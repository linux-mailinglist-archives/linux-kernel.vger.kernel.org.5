Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9415D7F5D02
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbjKWKzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344883AbjKWKy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E10D5A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700736902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CjFVbEkEc3cCGzg7BPQSnbWJhLULm7Z08rp1xpQQ9kM=;
        b=BzgYlMpDFpQGO21gavQAk5K/VqyC9q7VXuy93LF/2fqu9B+nvDVdPWvycy4yzTwZlnxot4
        mIlhshgFYF+5VRH6kjETozw5zR8zw5Ct46KbQ5UbEWHbxm5PjhtW+Z8Bw0q+J2b/EwGPhH
        3lAf2u6emLkEbmcqDaDP1yh/JTSdjw0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-OctS9rEFMUy6J3p1M42inA-1; Thu, 23 Nov 2023 05:55:00 -0500
X-MC-Unique: OctS9rEFMUy6J3p1M42inA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a02225ee165so14184666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736899; x=1701341699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjFVbEkEc3cCGzg7BPQSnbWJhLULm7Z08rp1xpQQ9kM=;
        b=Z4A70HVKAmEMoRGrHGV5EQxL6uq/wNFidmowsi4FqqU78eb42+TTjCSKl1Avw2nHb4
         AcyhCCzvP4Gam0o83JKRVuDwxrh7FU2men7hd8P6Nb5Ukp7pGbd8/GFiV+mLaBar0Ssw
         xlVL9BJX9NcN6Ec8dP1P076COfoiTRZ0BvqqimRnRDaK27An7n+PoQWR6v3l008PcZcZ
         B5zPf+kUuQ+9F+SeSgZAs5Vj9GsK/OSEWcAWMIAIpJpoh6E5rlPZSgLDSE+vOjGoRpds
         I4daaDALy2OSCOEa9H+a/TLYf8RiN9DSorhrpuRtBziGSXR8uY9yzvtcTWxO/IRp0ONU
         ezOw==
X-Gm-Message-State: AOJu0Yy8/I+Jq37XgkhPG2d5Gr/6pZgIT7AnAWw2wQXbruO62oZmNAWr
        PDzl/USG6SQQhs1a6lvNvn7uuzEupTnJpEs7/oQp3R1PlZm+M/AVk5KnXZyen9pIYuUYA/l0jwr
        mf44mF6uKk38VK3kJwmfRHXol
X-Received: by 2002:a05:6402:2903:b0:546:efd8:7f05 with SMTP id ee3-20020a056402290300b00546efd87f05mr3451049edb.1.1700736899221;
        Thu, 23 Nov 2023 02:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM8b9TjCgTESKuR7rtfFpkDoJyxon/Vyb9MUnZls74BW7+4SWlLeWtNcgC/KOD5JJZCV1nyQ==
X-Received: by 2002:a05:6402:2903:b0:546:efd8:7f05 with SMTP id ee3-20020a056402290300b00546efd87f05mr3451020edb.1.1700736898906;
        Thu, 23 Nov 2023 02:54:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id f18-20020a05640214d200b005486228190dsm514274edx.42.2023.11.23.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:54:58 -0800 (PST)
Message-ID: <b3735179804cb941bbdd17cbdee5efd9a25a72df.camel@redhat.com>
Subject: Re: [PATCH net-next v1 2/3] net: dsa: microchip: Remove redundant
 optimization in ksz8_w_phy_bmcr
From:   Paolo Abeni <pabeni@redhat.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Date:   Thu, 23 Nov 2023 11:54:57 +0100
In-Reply-To: <20231121152426.4188456-2-o.rempel@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
         <20231121152426.4188456-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-21 at 16:24 +0100, Oleksij Rempel wrote:
> Remove the manual checks for register value changes in the
> ksz8_w_phy_bmcr function. Instead, rely on regmap_update_bits() for
> optimizing register updates.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/ksz8795.c | 95 +++++++++--------------------
>  1 file changed, 28 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microc=
hip/ksz8795.c
> index 835157815937..4c1e21fd87da 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -951,107 +951,68 @@ static int ksz8_w_phy_ctrl(struct ksz_device *dev,=
 int port, u16 val)
>  static int ksz8_w_phy_bmcr(struct ksz_device *dev, int port, u16 val)
>  {
>  	const u16 *regs =3D dev->info->regs;
> -	u8 restart, ctrl, speed, data;
> +	u8 restart, speed, ctrl, restart_mask;

Very minor nit and only if you have to repost for some other reason,
please respect the reverse x-mas tree above.

Thanks,

Paolo

