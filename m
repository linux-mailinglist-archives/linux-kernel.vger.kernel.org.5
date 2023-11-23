Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0637F5E43
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbjKWLwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345141AbjKWLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:52:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A31D53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700740360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AooG8xN58HCuuL3jxOniLdSeQfR0UM774bPAV7td7nU=;
        b=IJr7cVJin6CJyb+iFn+gh8TWjhLcfnaok91T8SG/Q/IIxjqI3cWKUoMljVIiZVym8IdWmT
        oJ2msaYsRZLdM+4zmIwVudHUlgFdOpPSbBYhxOXW75WujxWN0iy5VdZUzsmZcEuwrECw2C
        vQoKNZUf+G0CC3xQTp+n1+VmxeACD18=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-8KK_iQ9RN5qqhS-CySYG4g-1; Thu, 23 Nov 2023 06:52:38 -0500
X-MC-Unique: 8KK_iQ9RN5qqhS-CySYG4g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a0627211f11so11002066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700740284; x=1701345084;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AooG8xN58HCuuL3jxOniLdSeQfR0UM774bPAV7td7nU=;
        b=jJh7iS8J2IKj2TfnAjn5B287noDWY1r92XkH7LECAh+TlzZMolHgoxyfYKb7VJCPSs
         4dS+EBELI0Z2FyMrC9gQFkZXwQAxrjuxYTra+dbwCIg5KVsVNKlAGhevtXdpQztUT9ZO
         Pzvt9uRf+QMSOA5xWwnnys8ier4Vo/PAOB1MGP8dfpy6D4kJ7lVeg+YBVTbJw0rgZI4a
         ovycr7/3KdqVrB7kC7+sfbeX7JzHXpgAoMA+rTzsG+qPZg37Vaned0sm7bDYienUwmq1
         up2ST9bgvGQa5ESV83sWo2aEeBOtLfjaPNjc2sBmHjpBCFdf/44/MNL8J9vAMWbFk0/2
         NypQ==
X-Gm-Message-State: AOJu0YwzfgimjUrg42JjEAYMoncyW3FLaNfJ9nDcF5KQmI+Uw9MSPQ0D
        s2z/j1o+isW/WQPcO6jv6TG916GcZgQgwPN/UqNgAs9inLQzW/o+i6YRGI4mxcrsWBIcMwESR12
        G++zkb9N714xpOkQ4ksH48UeBaV/kVKzd
X-Received: by 2002:a17:906:7398:b0:a00:1acf:6fe6 with SMTP id f24-20020a170906739800b00a001acf6fe6mr3795157ejl.1.1700740283887;
        Thu, 23 Nov 2023 03:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKoHgojVkghYhaLFpuj4mSg8DTd3sbqe347RC+/YIfpkMmjH4/qZi6WhOW8SHPau4YhBZfEw==
X-Received: by 2002:a17:906:7398:b0:a00:1acf:6fe6 with SMTP id f24-20020a170906739800b00a001acf6fe6mr3795142ejl.1.1700740283470;
        Thu, 23 Nov 2023 03:51:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906288b00b009ffba6f1aafsm693555ejd.109.2023.11.23.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 03:51:23 -0800 (PST)
Message-ID: <ea0087881f20dc154ca08a5b748b853246e2b86f.camel@redhat.com>
Subject: Re: [PATCH 3/4 net] qca_spi: Fix ethtool -G iface tx behavior
From:   Paolo Abeni <pabeni@redhat.com>
To:     Stefan Wahren <wahrenst@gmx.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 Nov 2023 12:51:21 +0100
In-Reply-To: <20231121163004.21232-4-wahrenst@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
         <20231121163004.21232-4-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
> After calling ethtool -g it was not possible to adjust the TX ring size
> again.=C2=A0

Could you please report the exact command sequence that will fail?


> The reason for this is that the readonly setting rx_pending get
> initialized and after that the range check in qcaspi_set_ringparam()
> fails regardless of the provided parameter. Since there is no adjustable
> RX ring at all, drop it from qcaspi_get_ringparam().

>=20
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA=
7000")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/net/ethernet/qualcomm/qca_debug.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethe=
rnet/qualcomm/qca_debug.c
> index 6f2fa2a42770..613eb688cba2 100644
> --- a/drivers/net/ethernet/qualcomm/qca_debug.c
> +++ b/drivers/net/ethernet/qualcomm/qca_debug.c
> @@ -252,9 +252,7 @@ qcaspi_get_ringparam(struct net_device *dev, struct e=
thtool_ringparam *ring,
>  {
>  	struct qcaspi *qca =3D netdev_priv(dev);
>=20
> -	ring->rx_max_pending =3D 4;
>  	ring->tx_max_pending =3D TX_RING_MAX_LEN;
> -	ring->rx_pending =3D 4;
>  	ring->tx_pending =3D qca->txr.count;
>  }

I think it's preferable update qcaspi_set_ringparam() to complete
successfully when the provided arguments don't change the rx_pending
default (4)

Cheers,

Paolo

