Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBCC78B535
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjH1QQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjH1QPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29984123;
        Mon, 28 Aug 2023 09:15:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8CC62297;
        Mon, 28 Aug 2023 16:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D33CC433C7;
        Mon, 28 Aug 2023 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239347;
        bh=EXag5HMY6SlOvR4DazyxL95o7MXc5ZXzhpW8NYQZm0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UgHpqvXmxHlpbaD1JE2Fd9hEGfXfDjEB1abZD8W1PiapXHm3RTvlOxsU7sYNq88fT
         xOCfZhGDiImMGdV8yXf2sHh5KEMQaaypsQSj7rR2BinSqetWg9dpJAwCp4ZrjgugHd
         T1jrrtS695dtBZM+HV7yv669bqndee8qf7sfnOH4eEPX1rfJijNGvTpvC+tqeTMc+J
         QCqYjIvOdCPTP8qc0K+kHYEEsW6IeTSbwPQBL2Hm9Zu4nQ1+CS6LZknnh7tIQgrytn
         CLqKv3HfxjNZTpVV7hce17Tt4P1ydsqRC76JS4flLbQWXvyZ8S1VJLNyjMfXP9hAb/
         0geEwc+kyNqiA==
Date:   Mon, 28 Aug 2023 17:16:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io: adc: stm32-adc: fix potential NULL pointer
 dereference in stm32_adc_probe()
Message-ID: <20230828171605.15c51c28@jic23-huawei>
In-Reply-To: <tencent_CF6E986A75B63EC09E3D98143650B5241809@qq.com>
References: <tencent_994DA85912C937E3B5405BA960B31ED90A08@qq.com>
        <20230716170821.3305e3fa@jic23-huawei>
        <tencent_CF6E986A75B63EC09E3D98143650B5241809@qq.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 23:02:07 +0800
Zhang Shurong <zhang_shurong@foxmail.com> wrote:

> =E5=9C=A8 2023=E5=B9=B47=E6=9C=8817=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80 C=
ST =E4=B8=8A=E5=8D=8812:08:21=EF=BC=8CJonathan Cameron =E5=86=99=E9=81=93=
=EF=BC=9A
> > On Sat, 15 Jul 2023 23:55:50 +0800
> >=20
> > Zhang Shurong <zhang_shurong@foxmail.com> wrote: =20
> > > of_match_device() may fail and returns a NULL pointer.
> > >=20
> > > Fix this by checking the return value of of_match_device().
> > >=20
> > > Fixes: 64ad7f6438f3 ("iio: adc: stm32: introduce compatible data cfg")
> > > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com> =20
> >=20
> > Hi Zhang,
> >=20
> > I'm not sure we can actually make this bug happen. Do you have
> > a way of triggering it?  The driver is only probed on devices where
> > that match will work.
> >=20
> > Also, assuming the match table is the same one associated with this pro=
be
> > function, then us priv->cfg =3D of_device_get_match_data() and check the
> > output of that which is what we really care about.
> >=20
> > Jonathan
> >  =20
> > > ---
> > >=20
> > >  drivers/iio/adc/stm32-adc-core.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/stm32-adc-core.c
> > > b/drivers/iio/adc/stm32-adc-core.c index 48f02dcc81c1..70011fdbf5f6
> > > 100644
> > > --- a/drivers/iio/adc/stm32-adc-core.c
> > > +++ b/drivers/iio/adc/stm32-adc-core.c
> > > @@ -706,6 +706,8 @@ static int stm32_adc_probe(struct platform_device=
 =20
> > > *pdev)>  =20
> > >  	struct stm32_adc_priv *priv;
> > >  	struct device *dev =3D &pdev->dev;
> > >  	struct device_node *np =3D pdev->dev.of_node;
> > >=20
> > > +	const struct of_device_id *of_id;
> > > +
> > >=20
> > >  	struct resource *res;
> > >  	u32 max_rate;
> > >  	int ret;
> > >=20
> > > @@ -718,8 +720,11 @@ static int stm32_adc_probe(struct platform_devic=
e =20
> > > *pdev)>  =20
> > >  		return -ENOMEM;
> > >  =09
> > >  	platform_set_drvdata(pdev, &priv->common);
> > >=20
> > > -	priv->cfg =3D (const struct stm32_adc_priv_cfg *)
> > > -		of_match_device(dev->driver->of_match_table, dev)->data;
> > > +	of_id =3D of_match_device(dev->driver->of_match_table, dev);
> > > +	if (!of_id)
> > > +		return -ENODEV;
> > > +
> > > +	priv->cfg =3D (const struct stm32_adc_priv_cfg *)of_id->data;
> > >=20
> > >  	priv->nb_adc_max =3D priv->cfg->num_adcs;
> > >  	spin_lock_init(&priv->common.lock); =20
> Hello Jonathan,
>=20
> I think we can make it happen by designing the platform device in a way t=
hat=20
> its name aligns with that of the driver. In such a scenario, when the dri=
ver=20
> is probed, the of_match_device function will return null. You can verify =
this=20
> functionality by reviewing the following function:
>=20
> static int platform_match(struct device *dev, struct device_driver *drv)

I don't think we care about that case.  If there is a real example of
why someone would do this then that would be a different matter.

Jonathan

>=20
> Best regards,
> Shurong
>=20
>=20
>=20

