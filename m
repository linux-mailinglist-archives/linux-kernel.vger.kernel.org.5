Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110187EE386
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbjKPO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345319AbjKPO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:59:56 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A816D50;
        Thu, 16 Nov 2023 06:59:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83E6DC000D;
        Thu, 16 Nov 2023 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700146789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qy2MqCuiLBtsbwy1ckkwuas5dPsRMMlijJE5oBD56M=;
        b=MVwYQt0JYRhlqSzgnfvLCbmFCTe+TXvL4hhSXGCD8GBXuaIkrn49XazY+RWru4WJJ75Gln
        LB5BWd3yT9l1c8D87ejob7fPsZa5ka2drJbmET/GBrG9y0+UpRdh2lvsjArtr0fKrqq4lt
        Qqt9RNYre3hxjM0zgiN6c+7ph0qjgr9QQCPtCoM0KBQ3VRgaYi6pD8dHiXn0ybPPYhADhP
        8JjzXZaaLD0FlP6koaheUj5gRlr4q9JOMsVO2YpEGchiUeCqyI9TrKjHabrwPGqkkor78O
        2Iv3piuIjnMNQxz+FAc5b9vHRE1e1dS5R925npxawnT2k4F1evQ96H1IHiE8jg==
Date:   Thu, 16 Nov 2023 15:59:46 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231116155946.77441144@kmaincent-XPS-13-7390>
In-Reply-To: <faea7171-31bf-43b7-a830-62f69002b823@linaro.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
        <faea7171-31bf-43b7-a830-62f69002b823@linaro.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Krzysztof for your reviews!

On Thu, 16 Nov 2023 15:29:24 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/11/2023 15:01, Kory Maincent wrote:
> > Add a new driver for the PD692x0 I2C Power Sourcing Equipment controlle=
r.
> > This driver only support i2c communication for now.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  MAINTAINERS                  |    1 +
> >  drivers/net/pse-pd/Kconfig   |   11 +
> >  drivers/net/pse-pd/Makefile  |    1 +
> >  drivers/net/pse-pd/pd692x0.c | 1049
> > ++++++++++++++++++++++++++++++++++++++++++ 4 files changed, 1062
> > insertions(+) =20
>=20
> ....
>=20
> > +
> > +err_fw_unregister:
> > +	firmware_upload_unregister(priv->fwl);
> > +	return ret;
> > +}
> > +
> > +static void pd692x0_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct pd692x0_priv *priv =3D i2c_get_clientdata(client);
> > +
> > +	firmware_upload_unregister(priv->fwl);
> > +}
> > +
> > +static const struct i2c_device_id pd692x0_id[] =3D {
> > +	{ PD692X0_PSE_NAME, 0 },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, pd692x0_id);
> > +
> > +static const struct of_device_id pd692x0_of_match[] =3D {
> > +	{ .compatible =3D "microchip,pd69200", },
> > +	{ .compatible =3D "microchip,pd69210", },
> > +	{ .compatible =3D "microchip,pd69220", }, =20
>=20
> So they are the same from driver point of view.

Yes.
I only have the pd69200 version but the three versions are theoretically
compatible and microchip advise obviously to use the last one.
I describe the three names in case of future specific things even if I hope
there won't be and to have a clear version of which version is supported. D=
o you
prefer to use pd692x0 compatible instead?

Regards,

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
