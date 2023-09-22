Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F009F7AB341
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjIVOES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjIVOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:04:16 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E38F7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:04:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C79AD24000A;
        Fri, 22 Sep 2023 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695391445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pExq5EY/86tUqekvDpJYB6m3SynqP56IDF4E/AB4Z5k=;
        b=CStiiwB68UhFaWNyJvW23wdDSD3ddwH74WFVgCG8U6545bJhHiRYjRaS4ZcEqiDpvQPYIH
        tMrGKNyuwQ8Xx+2UbGKbJUnn0wbXn/KylVZzA9nXKFW4/4AjzqDJ38ccV4/agKr4NNPBRF
        /LsM+yKlMcGtAU7+nrXZfUbEfdd+HqnDMlyLvex/uEw1bb+V1WCPlSfvmxJrH5AcVYyxOa
        +MiK5TE1w+uMP1GTp+A7Hmss0wDLYiMb3f6sQ1Zbi28zQkXidzbls8tZnliF73aYRQ31IA
        qaUP8cNWZlvj0TzysxwcUVKXgZUO/nFKSg9S61fFAuAB0hWZweEWKz4yFZhqzA==
Date:   Fri, 22 Sep 2023 16:04:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>, kernel@pengutronix.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shiyan <eagle.alexander923@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: check nand support for cache reads
Message-ID: <20230922160400.034ee828@xps-13>
In-Reply-To: <20230922100116.145090-1-r.czerwinski@pengutronix.de>
References: <20230922100116.145090-1-r.czerwinski@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rouven,

Thanks a lot for the investigation and the patch!

r.czerwinski@pengutronix.de wrote on Fri, 22 Sep 2023 12:01:13 +0200:

Would you mind changing the title to
"mtd: rawnand: Ensure the nand chip supports cached reads"

> Both the JEDEC and ONFI specification say that read cache sequential
> support is an optional command.

I clearly overlooked that part, just checking the set/get_features()
entries as usual, good catch.

> This means that we not only need to
> check whether the individual controller implements the command, we also

The controller itself does not implement the command, but may or may
not support it (can you please update the sentence?).

> need to check the parameter pages for both ONFI and JEDEC NAND flashes
> before enabling sequential cache reads.
>=20
> This fixes support for NAND flashes which don't support enabling cache
> reads, i.e. Samsung K9F4G08U0F or Toshiba TC58NVG0S3HTA00.
>=20
> Sequential cache reads are no only available for ONFI and JEDEC devices,
> if individual vendors implement this, it needs to be enabled per vendor.

Agreed.

> Tested on i.MX6Q with a Samsung NAND flash chip that doesn't support
> sequential reads.
>=20
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
>=20

Please remove this empty line and instead add:

Cc: stable@vger.kernel.org

> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
> @Martin, M=C3=A5ns:
> I would appreciate if you could test this on your hardware.

That would me much appreciated!

I also added Alexander who also had troubles with this patchset, could
you check on your setup if that solves the issue?

> @Miguel:
> I didn't have the time to test this on ONFI/JEDEC devices with support
> yet, I'd be fine if you hold off merging this.

Of course. I was about to send a revert but that looks a promising fix,
let's see how it goes.

>=20
>  drivers/mtd/nand/raw/nand_base.c  | 3 +++
>  drivers/mtd/nand/raw/nand_jedec.c | 3 +++
>  drivers/mtd/nand/raw/nand_onfi.c  | 3 +++
>  include/linux/mtd/jedec.h         | 3 +++
>  include/linux/mtd/onfi.h          | 1 +
>  include/linux/mtd/rawnand.h       | 1 +
>  6 files changed, 14 insertions(+)
>=20

Thanks,
Miqu=C3=A8l
