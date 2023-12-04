Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A838035C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbjLDOAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjLDOAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:00:11 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040983;
        Mon,  4 Dec 2023 06:00:17 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DC141BF212;
        Mon,  4 Dec 2023 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701698416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+uiDE3NxOoevwqMr8SCb+nCphsDYD9LtU5l6pSFpbA=;
        b=XfpCeoyk25guxuYkM2E3TDVB4SjGyNvw5Q8qV1Q8jKT6oyWII3NI0zpolKSlocF9bUMIGS
        uXtDB4kU5EnE0GCw6m6xlPZDt77NhZUs7UOS/fhpAR16aV3/tndTM+2t5vAn71Z/3rtFA0
        OLz9YcSSv8Otr8/mR0RCbqCDLWEREfHhTB2UZIkJFD+yejdRnN0sInqYK2uiCvK5v/Kojr
        cnGAInYOzIUt/438MO9IEDa3/XguQnwb4j6jjWXc8HwAeKClomqbb6QR2FkBJEXBtnPy0g
        1tuM6SYX+Q+KqbX4yRRawlvk73dS4pSYEjY3tTj19I8U64TdMU5GweIlszj/FQ==
Date:   Mon, 4 Dec 2023 15:00:14 +0100
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
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 3/8] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <20231204150014.33ba28ed@kmaincent-XPS-13-7390>
In-Reply-To: <69292ed5-63d3-4316-9bab-630bd00ce807@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
        <20231201-feature_poe-v2-3-56d8cac607fa@bootlin.com>
        <69292ed5-63d3-4316-9bab-630bd00ce807@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review:

On Sun, 3 Dec 2023 19:38:04 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +/**
> > + * enum - Types of PSE controller.
> > + *
> > + * @PSE_UNKNOWN: Type of PSE controller is unknown
> > + * @PSE_PODL: PSE controller which support PoDL
> > + * @PSE_C33: PSE controller which support Clause 33 (PoE)
> > + */
> > +enum {
> > +	PSE_UNKNOWN =3D BIT(0),
> > +	PSE_PODL =3D BIT(1),
> > +	PSE_C33 =3D BIT(2),
> > +}; =20
>=20
> Maybe this should be in the netlink API?
>=20
> I think you can imply it by looking at what properties are in the
> netlink reply, but having it explicitly is probably better.
> ethtool(1) can default to PSE_PODL if the property is missing for an
> older kernel.

Ok, I will add it to netlink API in v3 then.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
