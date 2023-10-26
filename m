Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5383D7D8330
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbjJZMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJZMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:54:41 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92204AC;
        Thu, 26 Oct 2023 05:54:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6644E0004;
        Thu, 26 Oct 2023 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698324877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKDMaMA6DJ6jxyYN9y6LAy5+6UvY7wLuwkWrrVpSUho=;
        b=c71eHCpAcB3T7/F/wyL6wgjUTI1vQcj4c3ysetN9C3h8oQnRs9OpFkPHWhzyn4MeSeuXde
        xr+f1ZT/3bboP47crOxldDlzmNcATU4HjZ3BFWzIH8+fBnNNChBD557Jal/yGF+/dO02bt
        ALJ8rUBqxguV+/s0jgWff3vO6LxdNAhAiZ34/dtxsCAPkLXctmgscgo7ui9O+U0hUOsAho
        r34hyawGQYj6PJ5DQAh5kOYJjlAgyhMtf35ck0Mihd9LpCrx++v5wDqPzQB4JRkfkVTXDJ
        bJPdeAStxafvralilsHzhvkAhYQ9QrSm2jbDc4XyCIdZjBEmYTGqkZBuVLyMqQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 26 Oct 2023 14:54:35 +0200
Message-Id: <CWIDX8TT14N7.2UR5AIDDY37MX@tleb-bootlin-xps13-01>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>
To:     =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.15.2
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
 <3cc1f559-468-8a58-a919-bdfb45ecc90@linux.intel.com>
In-Reply-To: <3cc1f559-468-8a58-a919-bdfb45ecc90@linux.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu Oct 26, 2023 at 1:13 PM CEST, Ilpo J=C3=A4rvinen wrote:
> On Thu, 26 Oct 2023, Th=C3=A9o Lebrun wrote:
> >=20
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
> > index 5774d48c7f16..b2062e4cbbab 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -2384,10 +2384,7 @@ static void pl011_console_get_options(struct uar=
t_amba_port *uap, int *baud,
> >  			*parity =3D 'o';
> >  	}
> > =20
> > -	if ((lcr_h & 0x60) =3D=3D UART01x_LCRH_WLEN_7)
> > -		*bits =3D 7;
> > -	else
> > -		*bits =3D 8;
> > +	*bits =3D FIELD_GET(0x60, lcr_h) + 5; /* from 5 to 8 inclusive */
>
> 0x60 needs to be replaced with a named define!

Fixed locally for the next revision, thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
