Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052F87AFBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjI0HUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0HUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:20:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883D12A;
        Wed, 27 Sep 2023 00:20:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47F3440004;
        Wed, 27 Sep 2023 07:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695799243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LcK6dI4OVh5Gzyit6uVMZ8fakHesIzRAd0wZI3BRtU=;
        b=XMbLRSjILomfFUq/MjK4Th5sCQUTetyE6HeauprCGjmQJYi8gDHM0o6OO1I7dMc6O4Dw0q
        P9f4uMb/v3qpgZ+hqpgBkrxqH5msSr0YScHzFG+jqkXee9ROfrOjRhrGf/do2w37bQkRb1
        JQOfgxtUUHZPcNSawtYm5Vx6Vg+i8BkVURqUczGlLyE8JmMaEBhF9fFUnR2d+837UG8R52
        B657LhcNRgZOUGLX4gLGUxXh6K4QaCZwx8rx16UdkvPYK8XWpPIt6O1AqAJPFrZuHBhx/L
        7Y2SL4PbtnOonUyykSBaUYC4h8Z+2gakdzq3DyyGKjtn6S/EGr97PbHByfT4FA==
Date:   Wed, 27 Sep 2023 09:20:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Domenico Punzo <dpunzo@micron.com>
Cc:     Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Alexander Shiyan <eagle.alexander923@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean =?UTF-8?B?Tnlla2rDpnI=?= <sean@geanix.com>,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [EXT] Re: [PATCH v2] mtd: rawnand: Ensure the nand chip
 supports cached reads
Message-ID: <20230927092041.1ba97701@xps-13>
In-Reply-To: <BYAPR08MB4437C4365962602735E7810CBBC2A@BYAPR08MB4437.namprd08.prod.outlook.com>
References: <20230922141717.35977-1-r.czerwinski@pengutronix.de>
        <e911f5d9c7def8c80904a17ad3924ecba6625998.camel@geanix.com>
        <20230926132725.5d570e1b@xps-13>
        <BYAPR08MB4437C4365962602735E7810CBBC2A@BYAPR08MB4437.namprd08.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

dpunzo@micron.com wrote on Wed, 27 Sep 2023 06:28:04 +0000:

> Micron Confidential
>=20
> Hello Miquel,
>=20
> The MPN mt29f4g08abadawp is a single LUN device and it is supposed to sup=
port cache read with the limitation reported into the datasheet.

Yes, but this limitation is not covered by the ONFI specification.

> Can you clarify about the IDs list you need?

In the NAND core, we need to know which devices do/do not support
sequential cache reads *with* ECC enabled.

We can look at the parameter page and know whether sequential cache
reads are supported or not, but there is no way (as far as I know) to
detect whether a chip supports sequential cache reads with ECC enabled
other than looking at the datasheet.

Can you help by either telling how we can dynamically discover whether
ECC can be enabled during cache operations on Micron NAND chips or, if
that is not possible, provide a list of devices which support it?

Thanks,
Miqu=C3=A8l

>=20
> Thanks.
> Regards,
> Domenico P.
>=20
>=20
>=20
>=20
> Micron Confidential
> -----Original Message-----
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> Sent: Tuesday, September 26, 2023 1:27 PM
> To: Martin Hundeb=C3=B8ll <martin@geanix.com>
> Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>; M=C3=A5ns Rullg=C3=
=A5rd <mans@mansr.com>; Alexander Shiyan <eagle.alexander923@gmail.com>; Ri=
chard Weinberger <richard@nod.at>; Vignesh Raghavendra <vigneshr@ti.com>; J=
aimeLiao <jaimeliao.tw@gmail.com>; kernel@pengutronix.de; stable@vger.kerne=
l.org; linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Sean Ny=
ekj=C3=A6r <sean@geanix.com>; Domenico Punzo <dpunzo@micron.com>; Bean Huo =
<beanhuo@micron.com>
> Subject: [EXT] Re: [PATCH v2] mtd: rawnand: Ensure the nand chip supports=
 cached reads
>=20
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless yo=
u recognize the sender and were expecting this message.
>=20
>=20
> Hi Martin,
>=20
> + Bean and Domenico, there is a question for you below.
>=20
> martin@geanix.com wrote on Mon, 25 Sep 2023 13:01:06 +0200:
>=20
> > Hi Rouven,
> >
> > On Fri, 2023-09-22 at 16:17 +0200, Rouven Czerwinski wrote: =20
> > > Both the JEDEC and ONFI specification say that read cache sequential
> > > support is an optional command. This means that we not only need to
> > > check whether the individual controller supports the command, we
> > > also need to check the parameter pages for both ONFI and JEDEC NAND
> > > flashes before enabling sequential cache reads.
> > >
> > > This fixes support for NAND flashes which don't support enabling
> > > cache reads, i.e. Samsung K9F4G08U0F or Toshiba TC58NVG0S3HTA00.
> > >
> > > Sequential cache reads are now only available for ONFI and JEDEC
> > > devices, if individual vendors implement this, it needs to be
> > > enabled per vendor.
> > >
> > > Tested on i.MX6Q with a Samsung NAND flash chip that doesn't support
> > > sequential reads.
> > >
> > > Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache
> > > reads")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de> =20
> >
> > Thanks for this. It works as expected for my Toshiba chip, obviously
> > because it doesn't use ONFI or JEDEC.
> >
> > Unfortunately, my Micron chip does use ONFI, and it sets the cached-
> > read-supported bit. It then fails when reading afterwords:
> >
> > kernel: ONFI_OPT_CMD_READ_CACHE # debug added by me
> > kernel: nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
> > kernel: nand: Micron MT29F4G08ABAFAWP
> > kernel: nand: 512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB
> > size: 256
> > kernel: nand: continued read supported # debug added by me
> > kernel: Bad block table found at page 131008, version 0x01
> > kernel: Bad block table found at page 130944, version 0x01
> > kernel: 2 fixed-partitions partitions found on MTD device gpmi-nand
> > kernel: Creating 2 MTD partitions on "gpmi-nand":
> > kernel: 0x000000000000-0x000000800000 : "boot"
> > kernel: 0x000000800000-0x000020000000 : "ubi"
> > kernel: gpmi-nand 1806000.nand-controller: driver registered.
> >
> > ...
> >
> > kernel: ubi0: default fastmap pool size: 100
> > kernel: ubi0: default fastmap WL pool size: 50
> > kernel: ubi0: attaching mtd1
> > kernel: ubi0: scanning is finished
> > kernel: ubi0: attached mtd1 (name "ubi", size 504 MiB)
> > kernel: ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 bytes
> > kernel: ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
> > kernel: ubi0: VID header offset: 4096 (aligned 4096), data offset:
> > 8192
> > kernel: ubi0: good PEBs: 2012, bad PEBs: 4, corrupted PEBs: 0
> > kernel: ubi0: user volume: 9, internal volumes: 1, max. volumes count:
> > 128
> > kernel: ubi0: max/mean erase counter: 4/2, WL threshold: 4096, image
> > sequence number: 1431497221
> > kernel: ubi0: available PEBs: 12, total reserved PEBs: 2000, PEBs
> > reserved for bad PEB handling: 36
> > kernel: block ubiblock0_4: created from ubi0:4(rootfs.a)
> > kernel: ubi0: background thread "ubi_bgt0d" started, PID 36
> > kernel: block ubiblock0_6: created from ubi0:6(appfs.a)
> > kernel: block ubiblock0_7: created from ubi0:7(appfs.b)
> >
> > ...
> >
> > kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
> > kernel: SQUASHFS error: Unable to read directory block [4b6f15e:125]
> > kernel: SQUASHFS error: Unable to read directory block [4b6d15c:1dae]
> > kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
> > (d-sysctl)[55]: systemd-sysctl.service: Failed to set up credentials:
> > Protocol error
> > kernel: SQUASHFS error: Unable to read directory block [4b73162:14f0]
> > kernel: SQUASHFS error: Unable to read directory block [4b6f15e:838]
> > systemd[1]: Starting Create Static Device Nodes in /dev...
> > kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
> > kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
> > kernel: SQUASHFS error: Unable to read directory block [4b6f15e:838]
> > kernel: SQUASHFS error: Unable to read directory block [4b6d15c:1dae]
> > kernel: SQUASHFS error: Unable to read directory block [4b6f15e:125]
> >
> > I've briefly tried adding some error info the the squashfs error
> > messages, but it looks like it's getting bad data. I.e. one failure a
> > sanity check of `dir_count`:
> >
> > if (dir_count > SQUASHFS_DIR_COUNT)
> >       goto data_error;
> >
> > It fails with `dir_count` being 1952803684 ...
> >
> > So is this a case of wrong/bad timings?
> >
> > Miquel:
> > I can tell from the code, that the READCACHESEQ operations are
> > followed by NAND_OP_WAIT_RDY(tR_max, tRR_min). From the Micron
> > datasheet[0], it should be NAND_OP_WAIT_RDY(tRCBSY_max, tRR_min),
> > where tRCBSY is defined to be between 3 and 25 =C2=B5s. =20
>=20
> I found a place in the ONFI spec states taht tRCBSY_max should be between=
 3 and tR_max, so indeed we should be fine on that regard.
>=20
> However, I asked myself whether we could have issues when crossing bounda=
ries. Block boundaries should be fine, however your device does not support=
 crossing plane boundaries, as bit 4 ("read cache
> supported") of byte 114 ("Multi-plane operation attributes") in the memor=
y organization block of the parameter page is not set (the value of the byt=
e should be 0x0E if I get it right.
>=20
> Anyway, our main issue here does not seem related to the boundaries. It d=
oes not seem to be explicitly marked anywhere else but on the front
> page:
>         Advanced command set
>         =E2=80=93 Program page cache mode (4)
>         =E2=80=93 Read page cache mode (4)
>         =E2=80=93 Two-plane commands (4)
>=20
>         (4) These commands supported only with ECC disabled.
>=20
> Read page cache mode without ECC makes the feature pretty useless IMHO.
>=20
> Bean, Domenico, how do we know which devices allow ECC correction during =
sequential page reads and which don't? Is there a (vendor?) bit somewhere i=
n the parameter page for that? Do we have any way to know besides a list of=
 devices allowing that? If so, can you provide one with a few IDs?
>=20
> Thanks,
> Miqu=C3=A8l

