Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AFB7F4D29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjKVQsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKVQsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:48:37 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2EA18E;
        Wed, 22 Nov 2023 08:48:31 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86218C0009;
        Wed, 22 Nov 2023 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700671710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajeauEZR8WppxNQT8eguJ25565qc08+DI61fuQmDdSw=;
        b=PiPnagN9iA4MhaTLDc0PKQQxX7jexlIsRjYcnOgbXCiZ7lFZmSs3HYvO1oqFGQJNZ+OZtc
        7llzyBJuhiaS6KK78ftrDv3r6SUHB+Cb7eL/SRe1WSpYsI746ct/ELMbb7X/t1hBFCJS4h
        8Q/VGXKUbAqU1/IdEIJikgPyCUlltf9FXg23vlqMd7siaiPgxhNOapiSaYzyTEoM+ZfSrU
        m7f+xt4301mwwpAuvl9VjrUQLXtVCFret7cQUG4iVqSRHzZHDUR1zADrUePzM5uy+uFULJ
        2EMPOxfr0ZFkRdDNxnMJxeFQcJ13BCARG28OJjWx8VERkRno1n0o/PCou4C47Q==
Date:   Wed, 22 Nov 2023 17:48:28 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20231122174828.7625d7f4@kmaincent-XPS-13-7390>
In-Reply-To: <45694d77-bcf8-4377-9aa0-046796de8d74@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
        <45694d77-bcf8-4377-9aa0-046796de8d74@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2023 19:54:30 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>=20
> > +	unsigned long last_cmd_key_time;
> > +
> > +	enum ethtool_pse_admin_state
> > admin_state[PD692X0_MAX_LOGICAL_PORTS]; +};
> > +
> > +/* Template list of the fixed bytes of the communication messages */
> > +static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_=
CNT]
> > =3D {
> > +	[PD692X0_MSG_RESET] =3D {
> > +		.content =3D {
> > +			.key =3D PD692X0_KEY_CMD,
> > +			.sub =3D {0x07, 0x55, 0x00},
> > +			.data =3D {0x55, 0x00, 0x55, 0x4e,
> > +				 0x4e, 0x4e, 0x4e, 0x4e},
> > +		},
> > +	}, =20
>=20
> Is there any documentation about what all these magic number mean?
>=20
> > +/* Implementation of the i2c communication in particular when there is
> > + * a communication loss. See the "Synchronization During Communication
> > Loss"
> > + * paragraph of the Communication Protocol document.
> > + */ =20
>=20
> Is this document public?

Yes:
https://www.microchip.com/en-us/software-library/p3-55-firmware-for-pd69200=
-for-ieee802-3bt

>=20
> > +static int pd692x0_recv_msg(struct pd692x0_priv *priv,
> > +			    struct pd692x0_msg *msg,
> > +			    struct pd692x0_msg_content *buf)
> > +{
> > +	const struct i2c_client *client =3D priv->client;
> > +	int ret;
> > +
> > +	memset(buf, 0, sizeof(*buf));
> > +	if (msg->delay_recv)
> > +		msleep(msg->delay_recv);
> > +	else
> > +		msleep(30);
> > +
> > +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
> > +	if (buf->key)
> > +		goto out; =20
>=20
> This is the first attempt to receive the message. I assume buf->key
> not being 0 indicates something has been received?

Yes,=20

>=20
> > +
> > +	msleep(100);
> > +
> > +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
> > +	if (buf->key)
> > +		goto out; =20
>=20
> So this is a second attempt. Should there be another memset? Could the
> first failed transfer fill the buffer with random junk in the higher
> bytes, and a successful read here could be a partial read and the end
> of the buffer still contains the junk.

Not sure. The message read should have the right size.
I will maybe add the memset to prevent any weird behavior.

> Another resend and two more attempts to receive.
>=20
> Is there a reason to not uses for loops here? And maybe put
> send/receive/receive into a helper? And maybe make the first send part
> of this, rather then separate? I think the code will be more readable
> when restructured.

I have written it like that to describe literally the communication loss
procedure. I may restructured it for better understanding.

> > +static int pd692x0_ethtool_set_config(struct pse_controller_dev *pcdev,
> > +				      unsigned long id,
> > +				      struct netlink_ext_ack *extack,
> > +				      const struct pse_control_config
> > *config) +{
> > +	struct pd692x0_priv *priv =3D to_pd692x0_priv(pcdev);
> > +	struct pd692x0_msg_content buf =3D {0};
> > +	struct pd692x0_msg msg;
> > +	int ret;
> > +
> > +	ret =3D pd692x0_fw_unavailable(priv);
> > +	if (ret)
> > +		return ret; =20
>=20
> It seems a bit late to check if the device has any firmware. I would
> of expected probe to check that, and maybe attempt to download
> firmware. If that fails, fail the probe, since the PSE is a brick.

The PSE can still be flashed it never become an unusable brick.
We can flash the wrong Firmware, or having issue in the flashing process. T=
his
way we could reflash the controller firmware several times.=20

> > +static struct pd692x0_msg_ver pd692x0_get_sw_version(struct pd692x0_pr=
iv
> > *priv) +{
> > +	struct pd692x0_msg msg =3D
> > pd692x0_msg_template_list[PD692X0_MSG_GET_SW_VER];
> > +	struct device *dev =3D &priv->client->dev;
> > +	struct pd692x0_msg_content buf =3D {0};
> > +	struct pd692x0_msg_ver ver =3D {0};
> > +	int ret;
> > +
> > +	ret =3D pd692x0_sendrecv_msg(priv, &msg, &buf);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to get PSE version (%pe)\n",
> > ERR_PTR(ret));
> > +		return ver; =20
>=20
> I _think_ that return is wrong ???

No, this return will return an empty struct pd692x0_msg_ver.
Which means the firmware has not any version.

> Is the firmware in Motorola SREC format? I thought the kernel had a
> helper for that, but a quick search did not find it. So maybe i'm
> remembering wrongly. But it seems silly for every driver to implement
> an SREC parser.

Oh, I didn't know this format. The firmware seems indeed to match this form=
at
specification.
I found two reference of this Firmware format in the kernel:
https://elixir.bootlin.com/linux/v6.5.7/source/sound/soc/codecs/zl38060.c#L=
178
https://elixir.bootlin.com/linux/v6.5.7/source/drivers/staging/wlan-ng/pris=
m2fw.c

Any preference in the choice? The zl38060 fw usage is maybe the easiest.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
