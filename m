Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCDD7D845F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjJZOSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZOSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:18:51 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEAE1A2;
        Thu, 26 Oct 2023 07:18:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19B2A60011;
        Thu, 26 Oct 2023 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698329926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpvjpaWtzMB/CtrOWZk8LM8Ct/Hhoy84K2WxkxvwHDU=;
        b=jcu6Btyg2XCxUpJBhXuU0SAC8lWpnX1XFst/tYghkn92ma3+5y+Z3uQ/rwtlbO5eaK16pO
        RGYm9rwsuLJww8ic7v9RY5m0O7AQN7P350ZFEt5dStb1RR+nxVhISF+0/eh7+2oa/d6/W0
        yT3/p9lddwAnkniLBHjOP5HPkNw6yW4gccZORnZO5xedxrqCguUneK1dTvu2rLpIMrzZuj
        1DXCkwmfw7n8VxVe53EL1a4dT/yC2EdfHywPMvDTGWwKc7CC8pJM+v/eNPZ8mcS4PiPvZ7
        /dLGtzPtAQ7Dr0qZpPVmvDoY1U/EWQQNAp4d/lACmeHuJ/fLNUx7munpfFdB6Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 26 Oct 2023 16:18:45 +0200
Message-Id: <CWIFPP04TD0A.G0Q3H51W9E9S@tleb-bootlin-xps13-01>
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>
To:     "Linus Walleij" <linus.walleij@linaro.org>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
X-Mailer: aerc 0.15.2
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
 <CACRpkdYkgg91HXuZ6LVymwHvLTRGzb5ubU-7k3wUm3DDRwkmww@mail.gmail.com>
In-Reply-To: <CACRpkdYkgg91HXuZ6LVymwHvLTRGzb5ubU-7k3wUm3DDRwkmww@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu Oct 26, 2023 at 3:48 PM CEST, Linus Walleij wrote:
> On Thu, Oct 26, 2023 at 12:41=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bo=
otlin.com> wrote:
>
> > pl011_console_get_options() gets called to retrieve currently configure=
d
> > options from the registers. Previously, LCRH_TX.WLEN was being parsed
> > as either 7 or 8 (fallback). Hardware supports values from 5 to 8
> > inclusive, which pl011_set_termios() exploits for example.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> With Ilpo's comment fixed:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It's been fixed locally. Thank you for your review Linus!

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
