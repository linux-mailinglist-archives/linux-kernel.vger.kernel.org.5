Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84417F319A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjKUOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjKUOvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:51:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D0690
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:51:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF260C433D9;
        Tue, 21 Nov 2023 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700578267;
        bh=0Hzbhezg3LEYvk3jV45ChdxYUsSKEP9VDFl59KpQ+cU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fZao+fKCi30D2OU8mkp2CSBObry/17OOuVNUgwlfsTKUlut1qgNQY0AzOoujvrPE+
         OpfDJuhCJMtkMquBMoNPtcugiX2F2MbHjrxXPsHUsF/Q+HJRUDfGj6Icj8cBR81Owf
         i14mUHT+faWDLif9ZnKlpe0Ov1VZQpGWG+0dBbk1d6tTylKII4TwX4Ckw+0JpGV/JP
         HW4Gxe2YCDjZduQmG4nl7UsiDWS1rQRsSBRV8Crt3qEPfRIeRoz89HoIwE54fwi1k2
         sS17uQEWs3lmSd4xCWaQMVKn+4mxnSBtWm4B8znU5Nm/PMRy3o8z2FcsbZyvO21EVB
         a51o0Ev8BST+Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-507a5f2193bso5831580e87.1;
        Tue, 21 Nov 2023 06:51:06 -0800 (PST)
X-Gm-Message-State: AOJu0Yx6w5wNfrxxNuYEul6zhV0vv1rdECmR4HuagY2PULVBBqa156cs
        wqeY4HTBHW65jrxY5rqdk5MDB4nbtEwOSyJLCQ==
X-Google-Smtp-Source: AGHT+IHAgECyxRGZoAUk3nMcJ8/f2p6QZjyOKysSbNWX5YzA0p6881GhJQrwodpOCv5t41nc17DnYHwCQ59f76jZIn8=
X-Received: by 2002:a05:6512:1106:b0:50a:7648:349f with SMTP id
 l6-20020a056512110600b0050a7648349fmr1142319lfg.10.1700578265105; Tue, 21 Nov
 2023 06:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20231115210129.3739377-1-robh@kernel.org> <20231116182923.GH109951@vergenet.net>
In-Reply-To: <20231116182923.GH109951@vergenet.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Nov 2023 07:50:52 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJp=H-O=nkL=f_G=stYOL=1FP=u8w8W+hNor5Zvt+6OrA@mail.gmail.com>
Message-ID: <CAL_JsqJp=H-O=nkL=f_G=stYOL=1FP=u8w8W+hNor5Zvt+6OrA@mail.gmail.com>
Subject: Re: [RESEND PATCH] net: can: Use device_get_match_data()
To:     Simon Horman <horms@kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@amd.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:29=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Wed, Nov 15, 2023 at 03:01:28PM -0600, Rob Herring wrote:
> > Use preferred device_get_match_data() instead of of_match_device() to
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> ...
>
> > diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.=
c
> > index abe58f103043..f17fd43d03c0 100644
> > --- a/drivers/net/can/xilinx_can.c
> > +++ b/drivers/net/can/xilinx_can.c
> > @@ -20,8 +20,8 @@
> >  #include <linux/module.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/of.h>
> > -#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/string.h>
> > @@ -1726,7 +1726,6 @@ static int xcan_probe(struct platform_device *pde=
v)
> >       struct net_device *ndev;
> >       struct xcan_priv *priv;
> >       struct phy *transceiver;
> > -     const struct of_device_id *of_id;
> >       const struct xcan_devtype_data *devtype =3D &xcan_axi_data;
>
> Hi Rob,
>
> Here devtype is initialised.
>
> >       void __iomem *addr;
> >       int ret;
> > @@ -1741,9 +1740,7 @@ static int xcan_probe(struct platform_device *pde=
v)
> >               goto err;
> >       }
> >
> > -     of_id =3D of_match_device(xcan_of_match, &pdev->dev);
> > -     if (of_id && of_id->data)
> > -             devtype =3D of_id->data;
>
> And in the old code devtype was conditionally re-initialised here,
> if a match with data was found.
>
> But in the new code devtype is re-initialised unconditionally.
>
> Possibly I am missing something obvious, but it seems that either this
> should somehow be made conditional, or the initialisation to &xcan_axi_da=
ta
> should be dropped.

of_match_device() would never fail because we only match with DT for
this driver and if we didn't match, we wouldn't be in probe. So I'll
drop the initialization.

Rob
