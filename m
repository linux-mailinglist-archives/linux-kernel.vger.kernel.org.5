Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703BE7EF17F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjKQLPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjKQLPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:15:52 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5CEC2;
        Fri, 17 Nov 2023 03:15:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71B84FF80A;
        Fri, 17 Nov 2023 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700219747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEnAPhotGrymqx9LWYvphkRnK4e8fFIFQk+XIJhM+Ew=;
        b=bv2DM1K8sfN7my6DGyXah1OW8f8ligLTQQbv2oeWPGfbH3pLz1fHL6HIMNb++VwFLFUVVA
        FE1nA3josktfusczdxPl+/rQoN0T4Ts/w9mObdtiQ3g+qXqd/2nOanonmA9tPh1TFCGkZy
        vgD1OEXfv9yMX3wPMJBwJ1L7Fioj7+jPPTa2tP2+0VOLLGbavTY4V6X7mdLdLX74HTOCqa
        Uym+ZBpydJjuw0j3sGy+LIobi0T+MVrTtbNfVQjq1lvXM7AcZSlCvVEPZTOEYdFSrGkwC5
        I35VqoXtIL/pbJ6TDyFwSYqTOdtcYWRmlpXFo3EoXpFl4VHg/WpGxLAOmMmI4Q==
Date:   Fri, 17 Nov 2023 12:15:45 +0100
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
Message-ID: <20231117121545.2f950d43@kmaincent-XPS-13-7390>
In-Reply-To: <47d42d52-943c-467d-bcc0-fcb274f69841@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
        <47d42d52-943c-467d-bcc0-fcb274f69841@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 23:38:08 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static int pd692x0_send_msg(struct pd692x0_priv *priv, struct pd692x0_=
msg
> > *msg) +{
> > +	const struct i2c_client *client =3D priv->client;
> > +	int ret;
> > +
> > +	if (msg->content.key =3D=3D PD692X0_KEY_CMD && priv->last_cmd_key) {
> > +		while (time_is_after_jiffies(msecs_to_jiffies(30) +
> > priv->last_cmd_key_time))
> > +			usleep_range(1000, 2000); =20
>=20
> That is a bit odd. Could you not just calculate how long a sleep is
> needed, rather than loop?

Oh, right indeed! Don't know why my brain wanted a loop here.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
