Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A797B0845
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjI0PaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjI0PaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:30:00 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF7180
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:29:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41B03FF809;
        Wed, 27 Sep 2023 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695828595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYzHJ3e6WJyAtZxmrr4126joB+o93g0JOzJdO55X0do=;
        b=pygfUECqVNDPsy+CSPTm3cLY/cdZS+cYhqFCZaUhqXfEVnJkkttvgOP7MWvVyG4FVdSnSa
        E63g7hMHxSqg0pVGmbECqPDYmtsZxnYKo4+6jlqUTyOMKkY1LFKNNl2E6kG4IucdhUIXw8
        PGazdn8trK1EUxPx3WQLILqPhnLcqolccGcW4h0OXGfZAdtNfeLFh6nVYQ2Z95uN5wNjT+
        yzeYwURoh88SqR3igmC1F0xqhCc0ynaEyBsnD1nhPvjN/pRH3UhD8iCwVaMeCm68OUHReD
        TnkF4+Tp/L6TUaiwSxO0oBTwmenjSz1OzFO5CeiZnfmLZw7+/sUwSos1rpozwA==
Date:   Wed, 27 Sep 2023 17:29:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean Delvare <jdelvare@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Johan Jonker <jbx6244@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH] mtd: nand: add support for ts72xx
Message-ID: <20230927172947.33106fe2@xps-13>
In-Reply-To: <20230927141532.25525-1-nikita.shubin@maquefel.me>
References: <20230927141532.25525-1-nikita.shubin@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

nikita.shubin@maquefel.me wrote on Wed, 27 Sep 2023 17:15:25 +0300:

> Technologic Systems has it's own nand controller implementation in CPLD.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> Hello Miqu=C3=A8l.
>=20
> Can you please take a look on it as RFC, so no need for the whole series =
spinning ?
>=20
> I've got rid of all legacy stuff i think, however:

I am glad you did, thanks a lot!

> - look's like i me ts7250 is missing READCACHE and i couldn't find any do=
cs=20
>   for this controller, so as legacy had no READCACHE, i mark it as non-su=
pported

What NAND device do you use?

The controller clearly supports it, as it just forwards whatever
addrs/cmd/data cycle you input. However we are trying to fix the cache
reads support which is unstable. If you use a NAND that is non-JEDEC
and non-ONFI then please apply this and you will no longer be bothered
by it:
https://lore.kernel.org/linux-mtd/20230926132725.5d570e1b@xps-13/T/#md7e5e9=
44a6a08e24f4f1e20068a49f94794ab945

If you are using a Micron chip that specifies not supporting ECC
correction together with sequential cache reads, then it's a problem
that we will solve soon (you can hardcode
chip->controller->supported_op.cont_read to 0);

Otherwise we can discuss it.

> - legacy wait implementation had no delays - only timeout and if i set=20
>   readb_poll_timeout() to something reasonable i experience speed degrada=
tion=20
>   on mtd_speedtest, can it be left as 0 ?

Looks like the legacy implementation used cond_resched(). The delay
needs to be observed before first checking for the status, it's a delay
that is described in the spec, if you get the status before you might
just not see a consistent value. I believe that is worth taking into
account in your implementation below (don't wait then delay, it's
not relevant). Can you share the values you've tried and the
performances you've got?

Thanks,
Miqu=C3=A8l

