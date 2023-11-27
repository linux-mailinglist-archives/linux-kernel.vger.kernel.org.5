Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC77FA7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjK0R2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK0R2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:28:17 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA085;
        Mon, 27 Nov 2023 09:28:22 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4FC14000B;
        Mon, 27 Nov 2023 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701106101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgRUTwLXcNd58EG84hnaXaWLqxXMccudnE3zQ48EYVQ=;
        b=nF/gRJ8xfx+oSU3Q8tKHoRZUEPdMORtKkZXe1y9wvSBw1LzUXyhzdMd5avFCzZ6iaSZTzh
        ygc0xDl00VLDGTbWbG1KcXy06Iutu8rta3w9rAU+rXz4piOf8BXP0hGyEHjgjOyjmhA1GF
        6O8IJKtjly+NQEmAwu3BpvxS2eqbh68CSdriYdPRAh7aEuj2pG4NUbv44RtfAZAt/qBzPj
        oQ1Ml6uEn44cMzzyEIWj2acon53DwEflAJU7sKnLoBnZAPg7L3SHUmXyrzKu5PM3sSzGa9
        7GXGLwAoxlF+Z62ykJgSjmfRN23UTP/cRg8QvZgN0HMNZusvH6N617R1QRttWQ==
Date:   Mon, 27 Nov 2023 18:28:19 +0100
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
Message-ID: <20231127182819.11ee98d2@kmaincent-XPS-13-7390>
In-Reply-To: <cde6c19f-01ba-4f6c-9e73-00e4789fb69c@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
        <45694d77-bcf8-4377-9aa0-046796de8d74@lunn.ch>
        <20231122174828.7625d7f4@kmaincent-XPS-13-7390>
        <cde6c19f-01ba-4f6c-9e73-00e4789fb69c@lunn.ch>
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

On Wed, 22 Nov 2023 18:11:25 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > Is the firmware in Motorola SREC format? I thought the kernel had a
> > > helper for that, but a quick search did not find it. So maybe i'm
> > > remembering wrongly. But it seems silly for every driver to implement
> > > an SREC parser. =20
> >=20
> > Oh, I didn't know this format. =20
>=20
> Its often used in small deeply embedded systems. Microcontrollers,
> rather than something which can run Linux.
>=20
> > The firmware seems indeed to match this format
> > specification.
> > I found two reference of this Firmware format in the kernel:
> > https://elixir.bootlin.com/linux/v6.5.7/source/sound/soc/codecs/zl38060=
.c#L178
> > https://elixir.bootlin.com/linux/v6.5.7/source/drivers/staging/wlan-ng/=
prism2fw.c
> > =20
>=20
> Ah, all inside a header file. Probably why i missed it. But ihex is
> not SREC. ihex came from Intel. SREC from Motorola.
>=20
> So i would follow the basic flow in include/linux/ihex.h, add an
> include/linux/srec.h but adapt it for SREC.

In fact the ihex.h header is only adding the ihex_validate_fw and the
request_ihex_firmware functions. In my case I do not use request firmware b=
ut
sysfs firmware loader. I could add srec_validate_fw but I am already
checking the firmware during the flashing process due to its special flashi=
ng
process.
I could not treat the firmware to one blob to be send. Each byte need to be
send in one i2c messages and at the end of eaxch line we need to wait a "\r=
\n"
(within 30ms) before sending next line. Yes, it takes time to be flashed!

Do you see generic helper that I could add?=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
