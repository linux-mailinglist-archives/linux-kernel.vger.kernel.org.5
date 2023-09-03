Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9EE790B7A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 12:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbjICKlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 06:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICKlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 06:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA8A123;
        Sun,  3 Sep 2023 03:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 696A761118;
        Sun,  3 Sep 2023 10:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091F9C433C7;
        Sun,  3 Sep 2023 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693737659;
        bh=zU/syJkqVXrCaKtAJvjb3McyZip5Q8QhWuhY8Smkpio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bbt287BifbGZW7Fy7egymUk6EKGDR7K+bPbW4j1eo4EP3EteJ6H+EjlIrBIM/R5Kg
         ahl5vGYlIgBT0lOrQjyI7LzCD2VmPIpYclTAzZDUYdTl3rYLxl95ftrpm/YbaoymXC
         aATDcrEx5Zm51w+ffq/Ao3hgSHV6JbqKmCIap9gKHAOcFkBb/YqDzI6XpJXkUryxbk
         b70ysikUW1h5ANXWFBxXSO2Ruc3i//FP7cBPWMDubvO2ggNGr36pUqIltamEQXGoM4
         9txR8m+V6nnt+EIhjuCW9S489tcaAjb7K7eV3ONXq3WeWKDHujLoXU+uruOQhcvzRT
         mFDwgk7dWYqpw==
Date:   Sun, 3 Sep 2023 11:41:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io: adc: stm32-adc: fix potential NULL pointer
 dereference in stm32_adc_probe()
Message-ID: <20230903114126.30ed4159@jic23-huawei>
In-Reply-To: <tencent_273D6814AA50AF24126F966A3DB684C0FE09@qq.com>
References: <tencent_994DA85912C937E3B5405BA960B31ED90A08@qq.com>
        <tencent_CF6E986A75B63EC09E3D98143650B5241809@qq.com>
        <20230828171605.15c51c28@jic23-huawei>
        <tencent_273D6814AA50AF24126F966A3DB684C0FE09@qq.com>
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

On Tue, 29 Aug 2023 00:35:36 +0800
Zhang Shurong <zhang_shurong@foxmail.com> wrote:

> =E5=9C=A8 2023=E5=B9=B48=E6=9C=8829=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C C=
ST =E4=B8=8A=E5=8D=8812:16:05=EF=BC=8CJonathan Cameron =E5=86=99=E9=81=93=
=EF=BC=9A
> > On Mon, 28 Aug 2023 23:02:07 +0800
> >=20
> > Zhang Shurong <zhang_shurong@foxmail.com> wrote: =20
> > > =E5=9C=A8 2023=E5=B9=B47=E6=9C=8817=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=
=80 CST =E4=B8=8A=E5=8D=8812:08:21=EF=BC=8CJonathan Cameron =E5=86=99=E9=81=
=93=EF=BC=9A
> > >  =20
> > > > On Sat, 15 Jul 2023 23:55:50 +0800
> > > >=20
> > > > Zhang Shurong <zhang_shurong@foxmail.com> wrote: =20
> > > > > of_match_device() may fail and returns a NULL pointer.
> > > > >=20
> > > > > Fix this by checking the return value of of_match_device().
> > > > >=20
> > > > > Fixes: 64ad7f6438f3 ("iio: adc: stm32: introduce compatible data =
cfg")
> > > > > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com> =20
> > > >=20
> > > > Hi Zhang,
> > > >=20
> > > > I'm not sure we can actually make this bug happen. Do you have
> > > > a way of triggering it?  The driver is only probed on devices where
> > > > that match will work.
> > > >=20
> > > > Also, assuming the match table is the same one associated with this
> > > > probe
> > > > function, then us priv->cfg =3D of_device_get_match_data() and chec=
k the
> > > > output of that which is what we really care about.
> > > >=20
> > > > Jonathan
> > > >  =20
> > > > > ---
> > > > >=20
> > > > >  drivers/iio/adc/stm32-adc-core.c | 9 +++++++--
> > > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/adc/stm32-adc-core.c
> > > > > b/drivers/iio/adc/stm32-adc-core.c index 48f02dcc81c1..70011fdbf5=
f6
> > > > > 100644
> > > > > --- a/drivers/iio/adc/stm32-adc-core.c
> > > > > +++ b/drivers/iio/adc/stm32-adc-core.c
> > > > > @@ -706,6 +706,8 @@ static int stm32_adc_probe(struct platform_de=
vice =20
> > > > > *pdev)> =20
> > > > >=20
> > > > >  	struct stm32_adc_priv *priv;
> > > > >  	struct device *dev =3D &pdev->dev;
> > > > >  	struct device_node *np =3D pdev->dev.of_node;
> > > > >=20
> > > > > +	const struct of_device_id *of_id;
> > > > > +
> > > > >=20
> > > > >  	struct resource *res;
> > > > >  	u32 max_rate;
> > > > >  	int ret;
> > > > >=20
> > > > > @@ -718,8 +720,11 @@ static int stm32_adc_probe(struct platform_d=
evice =20
> > > > > *pdev)> =20
> > > > >=20
> > > > >  		return -ENOMEM;
> > > > >  =09
> > > > >  	platform_set_drvdata(pdev, &priv->common);
> > > > >=20
> > > > > -	priv->cfg =3D (const struct stm32_adc_priv_cfg *)
> > > > > -		of_match_device(dev->driver->of_match_table, dev)->data;
> > > > > +	of_id =3D of_match_device(dev->driver->of_match_table, dev);
> > > > > +	if (!of_id)
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	priv->cfg =3D (const struct stm32_adc_priv_cfg *)of_id->data;
> > > > >=20
> > > > >  	priv->nb_adc_max =3D priv->cfg->num_adcs;
> > > > >  	spin_lock_init(&priv->common.lock); =20
> > >=20
> > > Hello Jonathan,
> > >=20
> > > I think we can make it happen by designing the platform device in a w=
ay
> > > that its name aligns with that of the driver. In such a scenario, when
> > > the driver is probed, the of_match_device function will return null. =
You
> > > can verify this functionality by reviewing the following function:
> > >=20
> > > static int platform_match(struct device *dev, struct device_driver *d=
rv) =20
> >=20
> > I don't think we care about that case.  If there is a real example of
> > why someone would do this then that would be a different matter.
> >=20
> > Jonathan
> >  =20
> > > Best regards,
> > > Shurong =20
> I just think it might be more appropriate to return the correct error cod=
e in=20
> this situation. I agree with your assessment that it is an abnormal case.=
=20
> Therefore, it is perfectly fine if you decide not to select this patch.
>=20
> Thanks for your kind reply.
>=20
Applied but with a modified commit message to describe this as hardening ra=
ther
than a fix.  Also dropped the fixes tag as I don't really want this to be
picked up for stable.

Thanks,

Jonathan

> Shurong
>=20
>=20
>=20

