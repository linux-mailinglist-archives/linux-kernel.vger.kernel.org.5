Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C594A7B4F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjJBJa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjJBJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:30:27 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B625A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:30:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A66AB1BF204;
        Mon,  2 Oct 2023 09:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696239021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nvcBaLCmY8mO5vCFGklzXqpSCLTGt+OF1cfRa4tU1I=;
        b=Gcu7m0Pp90GHp77BmLulIh3lxJ0ZsmBaZP25G4W3qzZoxP5zDxpwxd9xrPi9jXYNVEHQHl
        gs5ksdF8QBLn0dDh7DneFcTXW7sWyJgEvjsDusTLTZLpdY2bIbfiJ/qCO69QGqCnPEnM1X
        5v4Zjj2T2t2a1urSFGseCBBWjFk/9JiBLRvr6FC8HksUeu2Fxuj7Xu9eGJD+KVSmqShlqx
        9mAy6i19fqNtvGZ/y9RLOKrO2s07JQtVmjQjfUM7c9cTLYzzrVj/wCMHeVcmoAfYh/VF2X
        O2NlsZbI442Ie1NYSl6+Cnptn2zDykeaCUokAp6Gmm1dSL8uIWXqTWtwZnMH1A==
Date:   Mon, 2 Oct 2023 11:30:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
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
Message-ID: <20231002113017.481aae31@xps-13>
In-Reply-To: <8bbe66a23eb5c8a2404b72d754b1bcb6f4d23867.camel@maquefel.me>
References: <20230927141532.25525-1-nikita.shubin@maquefel.me>
        <20230927172947.33106fe2@xps-13>
        <8bbe66a23eb5c8a2404b72d754b1bcb6f4d23867.camel@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

> ```
> # modprobe technologic-nand-controller
> nand: device found, Manufacturer ID: 0xec, Chip ID: 0xf1
> nand: Samsung NAND 128MiB 3,3V 8-bit
> nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> Scanning device for bad blocks
> Bad eraseblock 137 at 0x000001120000
> Bad eraseblock 310 at 0x0000026c0000
> 3 fixed-partitions partitions found on MTD device 60000000.nand-
> controller
> Creating 3 MTD partitions on "60000000.nand-controller":
> 0x000000000000-0x000000020000 : "TS-BOOTROM"
> 0x000000020000-0x000007d20000 : "Linux"
> 0x000007d20000-0x000008000000 : "RedBoot"
> ```
>=20
> This looks like Samsung K9F1G08U0D or K9F1G08U0B.
>=20
> And the patch above totally solves my issues with READCACHE - thank
> you!
>=20

Great!

> > If you are using a Micron chip that specifies not supporting ECC
> > correction together with sequential cache reads, then it's a problem
> > that we will solve soon (you can hardcode
> > chip->controller->supported_op.cont_read to 0);
> >=20
> > Otherwise we can discuss it.
> >  =20
> > > - legacy wait implementation had no delays - only timeout and if i
> > > set=20
> > > =C2=A0 readb_poll_timeout() to something reasonable i experience speed
> > > degradation=20
> > > =C2=A0 on mtd_speedtest, can it be left as 0 ? =20
> >=20
> > Looks like the legacy implementation used cond_resched(). The delay
> > needs to be observed before first checking for the status, it's a
> > delay
> > that is described in the spec, if you get the status before you might
> > just not see a consistent value. I believe that is worth taking into
> > account in your implementation below (don't wait then delay, it's
> > not relevant). Can you share the values you've tried and the
> > performances you've got? =20
>=20
> The numbers are pretty stable, so indeed legacy is a bit faster,
> followed up by new one with zero interval.

...

> Legacy speedtest (old version of nand controller):

> mtd_speedtest: eraseblock write speed is 3793 KiB/s
> mtd_speedtest: eraseblock read speed is 3567 KiB/s
> mtd_speedtest: page write speed is 3682 KiB/s
> mtd_speedtest: page read speed is 3488 KiB/s
> mtd_speedtest: 2 page write speed is 3724 KiB/s
> mtd_speedtest: 2 page read speed is 3521 KiB/s
> mtd_speedtest: erase speed is 198709 KiB/s

...
=20
> New version with interval zero:

> mtd_speedtest: eraseblock write speed is 3685 KiB/s
> mtd_speedtest: eraseblock read speed is 3517 KiB/s
> mtd_speedtest: page write speed is 3592 KiB/s
> mtd_speedtest: page read speed is 3444 KiB/s
> mtd_speedtest: 2 page write speed is 3608 KiB/s
> mtd_speedtest: 2 page read speed is 3475 KiB/s
> mtd_speedtest: erase speed is 194499 KiB/s

Looks almost the same as above, I believe the difference is just noise
between measurements.

...

> New version with interval 100:

> mtd_speedtest: eraseblock write speed is 2722 KiB/s
> mtd_speedtest: eraseblock read speed is 2175 KiB/s
> mtd_speedtest: page write speed is 2598 KiB/s
> mtd_speedtest: page read speed is 2070 KiB/s
> mtd_speedtest: 2 page write speed is 2627 KiB/s
> mtd_speedtest: 2 page read speed is 2106 KiB/s
> mtd_speedtest: erase speed is 175851 KiB/s

...

> Also providing version with zero interval and "if (instr->delay_ns)"
> dropped - it's optional as far i understood:

It's not optional, sorry for the wrong comment, please keep it as it
is, knowing that it will be null after a wait_rdy.

> mtd_speedtest: eraseblock write speed is 3695 KiB/s
> mtd_speedtest: eraseblock read speed is 3532 KiB/s
> mtd_speedtest: page write speed is 3593 KiB/s
> mtd_speedtest: page read speed is 3457 KiB/s
> mtd_speedtest: 2 page write speed is 3640 KiB/s
> mtd_speedtest: 2 page read speed is 3488 KiB/s
> mtd_speedtest: erase speed is 195451 KiB/s

Thanks,
Miqu=C3=A8l
