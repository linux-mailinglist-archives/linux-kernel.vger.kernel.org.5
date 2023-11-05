Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162A47E1812
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjKEX4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEX4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:56:46 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F457C6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 15:56:42 -0800 (PST)
Received: from [192.168.68.112] (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EEADE20075;
        Mon,  6 Nov 2023 07:56:39 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1699228600;
        bh=QFNVMP6dED+kPw+11hk5uky5JXNxNuLL67bKcqe7dkE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=JM1hi779FDp/H7CCa8PanzJEXg14a9Ih5wIprldlHEc0w5UI1xseI8qlypTuIh6Qq
         AS0XCUdifw4EeBqhBcpPoteGUDxapoagwwB50E4QH6ksDPYgzzLcK47pHpdQzwjr+2
         QxQbKavAlwUvv5x0jfQLl+d9YXv9Yj0DykbV38h2za3H/QDUVwFjPDNOxIwxhvlFY1
         8SFEBqm8hkTzbjGGi0QOA2DfFoTzDckHwiKDkR7PH7NHA0wRBc0KcaoSoJCkrJW2c1
         zJ1ZJOBqrrCDe1rvsrLtK+IP0MgtVq3ylBjzieUhyX8FZdsq/OJHWmlEwQTxMmArpX
         j2VS3dp1vFsAA==
Message-ID: <a015924b542fd35fe84357eebddd14cfae83dace.camel@codeconstruct.com.au>
Subject: Re: [PATCH 08/10] ipmi: kcs_bmc: Track clients in core
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, aladyshev22@gmail.com,
        jk@codeconstruct.com.au
Date:   Mon, 06 Nov 2023 10:26:38 +1030
In-Reply-To: <20231103150522.00004539@Huawei.com>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
         <20231103061522.1268637-9-andrew@codeconstruct.com.au>
         <20231103150522.00004539@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-03 at 15:05 +0000, Jonathan Cameron wrote:
> On Fri,  3 Nov 2023 16:45:20 +1030
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>=20
> > I ran out of spoons before I could come up with a better client trackin=
g
> > scheme back in the original refactoring series:
> >=20
> > https://lore.kernel.org/all/20210608104757.582199-1-andrew@aj.id.au/
> >=20
> > Jonathan prodded Konstantin about the issue in a review of Konstantin's
> > MCTP patches[1], prompting an attempt to clean it up.
> >=20
> > [1]: https://lore.kernel.org/all/20230929120835.0000108e@Huawei.com/
> >=20
> > Prevent client modules from having to track their own instances by
> > requiring they return a pointer to a client object from their
> > add_device() implementation. We can then track this in the core, and
> > provide it as the argument to the remove_device() implementation to sav=
e
> > the client module from further work. The usual container_of() pattern
> > gets the client module access to its private data.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
> Hi Andrew,
>=20
> A few comments inline.
> More generally, whilst this is definitely an improvement I'd have been te=
mpted
> to make more use of the linux device model for this with the clients adde=
d
> as devices with a parent of the kcs_bmc_device.  That would then allow fo=
r
> simple dependency tracking, binding of individual drivers and all that.
>=20
> What you have here feels fine though and is a much less invasive change.

Yeah, I had this debate with myself before posting the patches. My
reasoning for the current approach is that the clients don't typically
represent a device, rather a protocol implementation that is
communicated over a KCS device (maybe more like pairing a line
discipline with a UART). It was unclear to me whether associating a
`struct device` with a protocol implementation was stretching the
abstraction a bit, or whether I haven't considered some other
perspective hard enough - maybe we treat the client as the remote
device, similar to e.g. a `struct i2c_client`?

>=20
> Jonathan
>=20
>=20
> > diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/=
kcs_bmc_cdev_ipmi.c
> > index 98f231f24c26..9fca31f8c7c2 100644
> > --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> > +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> > @@ -71,8 +71,6 @@ enum kcs_ipmi_errors {
>=20
>=20
>=20
> > +static struct kcs_bmc_client *
> > +kcs_bmc_ipmi_add_device(struct kcs_bmc_driver *drv, struct kcs_bmc_dev=
ice *dev)
> >  {
> >  	struct kcs_bmc_ipmi *priv;
> >  	int rc;
> > =20
> >  	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> >  	if (!priv)
> > -		return -ENOMEM;
> > +		return ERR_PTR(ENOMEM);
> As below. I thought it took negatives..

I should have double checked that. It requires negatives. Thanks.

> > =20
> >  	spin_lock_init(&priv->lock);
> >  	mutex_init(&priv->mutex);
> >  	init_waitqueue_head(&priv->queue);
> > =20
> > -	priv->client.dev =3D kcs_bmc;
> > -	priv->client.ops =3D &kcs_bmc_ipmi_client_ops;
> > +	kcs_bmc_client_init(&priv->client, &kcs_bmc_ipmi_client_ops, drv, dev=
);
> > =20
> >  	priv->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> > -	priv->miscdev.name =3D kasprintf(GFP_KERNEL, "%s%u", DEVICE_NAME, kcs=
_bmc->channel);
> > +	priv->miscdev.name =3D kasprintf(GFP_KERNEL, "%s%u", DEVICE_NAME, dev=
->channel);
> >  	if (!priv->miscdev.name) {
> >  		rc =3D -ENOMEM;
> ERR_PTR

I converted it to an ERR_PTR in the return after the cleanup_priv
label. Maybe it's preferable I do the conversion immediately? Easy
enough to change if you think so.

> >  		goto cleanup_priv;
>=20
>=20
>=20
> ...
>=20
> > diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_=
bmc_serio.c
> > index 0a68c76da955..3cfda39506f6 100644
> > --- a/drivers/char/ipmi/kcs_bmc_serio.c
> > +++ b/drivers/char/ipmi/kcs_bmc_serio.c
>=20
> ...
>=20
>=20
> > +static struct kcs_bmc_client *
> > +kcs_bmc_serio_add_device(struct kcs_bmc_driver *drv, struct kcs_bmc_de=
vice *dev)
> >  {
> >  	struct kcs_bmc_serio *priv;
> >  	struct serio *port;
> > @@ -75,12 +71,12 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_=
device *kcs_bmc)
> > =20
> >  	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> >  	if (!priv)
> > -		return -ENOMEM;
> > +		return ERR_PTR(ENOMEM);
> > =20
> >  	/* Use kzalloc() as the allocation is cleaned up with kfree() via ser=
io_unregister_port() */
> >  	port =3D kzalloc(sizeof(*port), GFP_KERNEL);
> >  	if (!port) {
> > -		rc =3D -ENOMEM;
> > +		rc =3D ENOMEM;
> Why positive?
> Doesn't ERR_PTR() typically get passed negatives?=20

Ack, as above.

Thanks for the review,

Andrew
