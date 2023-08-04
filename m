Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D1770BDA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjHDWTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHDWTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:19:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AA7E70
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:19:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-269304c135aso430353a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1691187574; x=1691792374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z85yAr9ygR49mY8rjDO0s+k4VK4gbZo4ggiBhhqGLBc=;
        b=exPRrngy/Xjg/0z8oKkOelqiXWNej+LTTOqlHFXzJWkLXH0y93hSwg9u30WZLWI79j
         Tlpu7V5P7ZMiSL5/OwQc0nHT195XzeF632ka4WQqLyBI9aES/Fr17LaK05Ca+dye5eN+
         Uo0zPgm8tGZZf7jWNvBH7Vj3zNA9JPftcqEvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691187574; x=1691792374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z85yAr9ygR49mY8rjDO0s+k4VK4gbZo4ggiBhhqGLBc=;
        b=kGp3XCOBkRLKiXaWvZPBBrPEoHp8KtyAQRgIGtIkiFZN+HMRqBOOBtiSGhJ0kU5v2C
         CjaR+Q9R69mWGpIb9vyQSCinOUaKwH86Q6S0roERdiRujx+v2jDHCqvDdU7QZJiLRM2u
         +wcHDNRjxY3W+GX0/x4BJTk/U+qp8OTMFJfQiIizv30J7fpq370AlQFUznvtz30X0HlZ
         kn6SoY/YnjewujcjihjBkEqVvrXcya9YoxyjrhWkwSJnStORmmIiaRBALmGf+n3UwmW3
         /9ZZWkqNd+7ldu7foIl7hio76U4gmqXQ3W8b2iOP0A7d1FWUcyokOf5DmHXrxP9rRBHl
         g2LQ==
X-Gm-Message-State: AOJu0YxeajwRDXFElsmbEGFfuNaMCVQsZ2fd8v/gDFGBBCTxAxHkrVZW
        U4mfx12+Lw72qVqTu6MjGySEbpZr+iwUKi3BxuXyww==
X-Google-Smtp-Source: AGHT+IHq75oMUwTP7tsh4zuYgxSN7ctvXDAvCHDjXLH3Lv0LvVtdMIp7bMWeA3v2s0EEm7jvwo/OmXZ1WmZEs/61/c4=
X-Received: by 2002:a17:90a:f00e:b0:262:e6d2:2d6 with SMTP id
 bt14-20020a17090af00e00b00262e6d202d6mr3027874pjb.47.1691187574564; Fri, 04
 Aug 2023 15:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACqvRUZRyXTVQyy9bUviQZ+_moLQBjPc6nin_NQC+CJ37yNnLw@mail.gmail.com>
 <36acaa5c-f41a-af88-78dd-cd3714301c12@linaro.org>
In-Reply-To: <36acaa5c-f41a-af88-78dd-cd3714301c12@linaro.org>
From:   Da Xue <da@lessconfused.com>
Date:   Fri, 4 Aug 2023 18:19:23 -0400
Message-ID: <CACdvmAgaVnUWOyQBdAVV8wJX8LYOC+kSQkJydCDmDrJ+ito7NQ@mail.gmail.com>
Subject: Re: [PATCH] net: phy: meson-gxl: implement meson_gxl_phy_resume()
To:     neil.armstrong@linaro.org
Cc:     Da Xue <da@libre.computer>, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 4:44=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> Hi Da,
>
> On 04/08/2023 05:07, Da Xue wrote:
> > After suspend and resume, the meson GXL internal PHY config needs to
> > be initialized again or the carrier cannot be found.
> >
> > Signed-off-by: Luke Lu <luke.lu@libre.computer>
> > Reviewed-by: Da Xue <da@libre.computer>
> >
> > ---
> >   drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
> >   1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> > index bb9b33b6b..c4a07e6f7 100644
> > --- a/drivers/net/phy/meson-gxl.c
> > +++ b/drivers/net/phy/meson-gxl.c
> > @@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device=
 *phydev)
> >    return 0;
> >   }
> >
> > +static int meson_gxl_phy_resume(struct phy_device *phydev)
> > +{
> > + int ret;
> > +
> > + phy_clear_bits(phydev, MII_BMCR, BMCR_PDOWN);
>
> Call genphy_resume() instead.

Sent v2.

>
> > + ret =3D meson_gxl_config_init(phydev);
> > + if (ret)
> > + return ret;
> > +
> > + return 0;
> > +}
>
> Please re-indent this function.

Ack, my apologies. I didn't read the excerpt about Gmail compose
converting tabs to spaces.

>
> > +
> >   /* This function is provided to cope with the possible failures of th=
is phy
> >    * during aneg process. When aneg fails, the PHY reports that aneg is=
 done
> >    * but the value found in MII_LPA is wrong:
> > @@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] =3D {
> >    .config_intr =3D smsc_phy_config_intr,
> >    .handle_interrupt =3D smsc_phy_handle_interrupt,
> >    .suspend        =3D genphy_suspend,
> > - .resume         =3D genphy_resume,
> > + .resume         =3D meson_gxl_phy_resume,
> >    .read_mmd =3D genphy_read_mmd_unsupported,
> >    .write_mmd =3D genphy_write_mmd_unsupported,
> >    }, {
> > --
> > 2.39.2
>
> Thanks,
> Neil
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
