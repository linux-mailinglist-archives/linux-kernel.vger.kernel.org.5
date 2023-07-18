Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42C675854C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGRTDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGRTDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:03:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0FEF0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E87B61549
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843E6C433CB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689706997;
        bh=R8QJXFnQbLJybVy/WRm+yC3t7Ld2l0V2RXkTonYfxa0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G5TCIPcW8BcvC5jbNzcPO6QKQt7WsxbnuYncE97G3IJwIOubmwZ8rqMYTBrY6NcgX
         a7BqGpPIfw58yii+50qQJ8cADhJjx+OcwzywWJCds+mc7Egnpi98ncewsHmoIjY/SG
         jWMz2QnW/PJ28Z5D6eHdRkzKE+PfMDB3RIsD0JmKd7SDGH1eL1KFh7jjArU0TftVkM
         +2lhfULd3UDW1oyiNi+vgaePQyQhKkWgyyf/Dq7EoFpfJcWuaI5qTh352HgrXStMVo
         TRL6Obe/bZEb6L6gWU0KZM9juuc1tspeYLW9HteSfgmAzDcYBYnqrItLvutSN7K6gM
         7cwbI2n74jLVg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b708e49059so95313291fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:03:17 -0700 (PDT)
X-Gm-Message-State: ABy/qLb3Ez8RKToeEZGmevA/b2Kz4LAqIkM0Hdm+xKGch7WJsvJ1BLjA
        bnbwXC9+OLYkInFPQWSpUFIc8RWy2TUzUIeM/Q==
X-Google-Smtp-Source: APBJJlF6qwLdMOlHzoChTNfNvOVkECtMUu95cucOarCwIF/EJZ+FdXxptw1FJFLeEm6bNlQ3EAoJ43Rm/qMS3Uk8+pM=
X-Received: by 2002:a2e:a410:0:b0:2b6:e13f:cfd7 with SMTP id
 p16-20020a2ea410000000b002b6e13fcfd7mr11445466ljn.4.1689706995524; Tue, 18
 Jul 2023 12:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230609183056.1765183-1-robh@kernel.org> <CAL_JsqLTc_9Yujp=wJjjn7P5YwAFZ9fn2SU6ey1q_gY3MFp9TA@mail.gmail.com>
In-Reply-To: <CAL_JsqLTc_9Yujp=wJjjn7P5YwAFZ9fn2SU6ey1q_gY3MFp9TA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jul 2023 13:03:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLNg00Z81cpSAOtwVWnfuQMoy2veBcHUHNby1Qh35mLTw@mail.gmail.com>
Message-ID: <CAL_JsqLNg00Z81cpSAOtwVWnfuQMoy2veBcHUHNby1Qh35mLTw@mail.gmail.com>
Subject: Re: [PATCH] fsi: Use of_property_read_reg() to parse "reg"
To:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 30, 2023 at 3:02=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Jun 9, 2023 at 12:31=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > Use the recently added of_property_read_reg() helper to get the
> > untranslated "reg" address value.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/fsi/fsi-core.c | 39 +++++++++------------------------------
> >  1 file changed, 9 insertions(+), 30 deletions(-)
>
> Ping!

Is FSI still maintained or should we just remove it?

>
> >
> > diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> > index 0b927c9f4267..19c4d5b3bde9 100644
> > --- a/drivers/fsi/fsi-core.c
> > +++ b/drivers/fsi/fsi-core.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/slab.h>
> >  #include <linux/bitops.h>
> >  #include <linux/cdev.h>
> > @@ -415,28 +416,18 @@ EXPORT_SYMBOL_GPL(fsi_slave_release_range);
> >  static bool fsi_device_node_matches(struct device *dev, struct device_=
node *np,
> >                 uint32_t addr, uint32_t size)
> >  {
> > -       unsigned int len, na, ns;
> > -       const __be32 *prop;
> > -       uint32_t psize;
> > +       u64 paddr, psize;
> >
> > -       na =3D of_n_addr_cells(np);
> > -       ns =3D of_n_size_cells(np);
> > -
> > -       if (na !=3D 1 || ns !=3D 1)
> > -               return false;
> > -
> > -       prop =3D of_get_property(np, "reg", &len);
> > -       if (!prop || len !=3D 8)
> > +       if (of_property_read_reg(np, 0, &paddr, &psize))
> >                 return false;
> >
> > -       if (of_read_number(prop, 1) !=3D addr)
> > +       if (paddr !=3D addr)
> >                 return false;
> >
> > -       psize =3D of_read_number(prop + 1, 1);
> >         if (psize !=3D size) {
> >                 dev_warn(dev,
> > -                       "node %s matches probed address, but not size (=
got 0x%x, expected 0x%x)",
> > -                       of_node_full_name(np), psize, size);
> > +                       "node %pOF matches probed address, but not size=
 (got 0x%llx, expected 0x%x)",
> > +                       np, psize, size);
> >         }
> >
> >         return true;
> > @@ -653,24 +644,12 @@ static void fsi_slave_release(struct device *dev)
> >  static bool fsi_slave_node_matches(struct device_node *np,
> >                 int link, uint8_t id)
> >  {
> > -       unsigned int len, na, ns;
> > -       const __be32 *prop;
> > -
> > -       na =3D of_n_addr_cells(np);
> > -       ns =3D of_n_size_cells(np);
> > -
> > -       /* Ensure we have the correct format for addresses and sizes in
> > -        * reg properties
> > -        */
> > -       if (na !=3D 2 || ns !=3D 0)
> > -               return false;
> > +       u64 addr;
> >
> > -       prop =3D of_get_property(np, "reg", &len);
> > -       if (!prop || len !=3D 8)
> > +       if (of_property_read_reg(np, 0, &addr, NULL))
> >                 return false;
> >
> > -       return (of_read_number(prop, 1) =3D=3D link) &&
> > -               (of_read_number(prop + 1, 1) =3D=3D id);
> > +       return addr =3D=3D (((u64)link << 32) | id);
> >  }
> >
> >  /* Find a matching node for the slave at (link, id). Returns NULL if n=
one
> > --
> > 2.39.2
> >
