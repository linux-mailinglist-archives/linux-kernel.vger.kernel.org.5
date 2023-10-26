Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C347D84EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbjJZOhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345180AbjJZOho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:37:44 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4BB91;
        Thu, 26 Oct 2023 07:37:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EEF31BF212;
        Thu, 26 Oct 2023 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698331060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzSuZl465f+Jw66lZVHayZUu0n4I8LWguWFqGsE/18w=;
        b=DbDoxLgbqro29XdM0gY29MtYs4ooiF4qgT22KXvka2hhLiMVQ+xQ6ULB0R7LvOQ4hmZ3zs
        mxea+1SLXuVzs6Fa3+JaKb1QxexFrmfdQIoUg6Zdtg8vhTivKsxTLHdhdpcAAS3ojjzWbR
        IMkeLWrlLREm+bvTYa5dOnaaQ/oM2bvdQWMljFsAO7JlLXLoJZQoQ+SRyqkZJv22AR/A8y
        zhnTC+fN6abIHKo1BAO0m9II2/+RdiXwN2caWR7oTSkQsKEo3zqw7kHfyJ7lnbHF2Yh+4z
        uVeZFlY6ovF0wYb4gHEgUij/5/NQ1j8uEL8L0LWrNfmfJd/mq59yuVbqdq7UMg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 26 Oct 2023 16:37:39 +0200
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
To:     "Hugo Villeneuve" <hugo@hugovil.com>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 4/6] tty: serial: amba-pl011: replace TIOCMBIT macros by
 static functions
Message-Id: <CWIG462JY229.13125CHGHKGX0@tleb-bootlin-xps13-01>
X-Mailer: aerc 0.15.2
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-4-9258eea297d3@bootlin.com>
 <20231026102424.81c0f7487df505d2ed92cf13@hugovil.com>
In-Reply-To: <20231026102424.81c0f7487df505d2ed92cf13@hugovil.com>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu Oct 26, 2023 at 4:24 PM CEST, Hugo Villeneuve wrote:
> On Thu, 26 Oct 2023 12:41:21 +0200
> Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> wrote:
> > The driver uses two TIOCMBIT macros inside pl011_{get,set}_mctrl to
> > simplify the logic. Those look scary to checkpatch because they contain
> > ifs without do-while loops.
> >=20
> > Avoid the macros by creating small equivalent static functions; that
> > lets the compiler do its type checking & avoids checkpatch errors.
> >=20
> > For the second instance __assign_bit is not usable because it deals wit=
h
> > unsigned long pointers whereas we have an unsigned int in
> > pl011_set_mctrl.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/tty/serial/amba-pl011.c | 46 +++++++++++++++++++++------------=
--------
> >  1 file changed, 24 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
> > index 0d53973374de..bb3082c4d35c 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -1087,7 +1087,6 @@ static void pl011_dma_rx_poll(struct timer_list *=
t)
> >  	 */
> >  	if (jiffies_to_msecs(jiffies - dmarx->last_jiffies)
> >  			> uap->dmarx.poll_timeout) {
> > -
>
> This should go into a separate patch, or simply be merged with one
> of your other coding style/whitespace cleanup patches.

Indeed, added to "tty: serial: amba-pl011: cleanup driver". Thanks.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
