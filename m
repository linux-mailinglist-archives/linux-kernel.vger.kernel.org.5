Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46D7AEB78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjIZL1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIZL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:27:40 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45DE5;
        Tue, 26 Sep 2023 04:27:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D04D11BF207;
        Tue, 26 Sep 2023 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695727651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOl6fnlKF+niRG0ZCtakx0gehGFGsJ9KF6QsiqviyXo=;
        b=f/QRq7u+ltuV+v6rOPfpQRvbA0UwQNJ1Q68Rwar/CptGcq09366A1iGb/5Qw/ZWOhLHTtr
        tWHV/v+1q3rlV9Xiw53kP7jaR4eLs2b4KGxVzeFetbh6wqU6HN8v2+HepV9iU5lNCvl1KB
        iwJvOaH29e5uikgMNMcbSxO5DCCpDePFFTlsy+Y+1sVsGV/mpxwArKVheLdoz24dbLNa+e
        fkL/loOK3lQFr3PAHocepNzdRAlLssMBV22lCmNnnWS110GFr2Iq8HRngCE+lbQUCoinCB
        TqtkQelxzkXY7jM3SaqsrloFjPo/LmxzyiRImJJEkuPw22DoL4LF+e3sWeFWFg==
Date:   Tue, 26 Sep 2023 13:27:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        =?UTF-8?B?TcOlbnMg?= =?UTF-8?B?UnVsbGfDpXJk?= <mans@mansr.com>,
        Alexander Shiyan <eagle.alexander923@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>, kernel@pengutronix.de,
        stable@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sean =?UTF-8?B?Tnlla2rDpnI=?= <sean@geanix.com>,
        Domenico Punzo <dpunzo@micron.com>,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH v2] mtd: rawnand: Ensure the nand chip supports cached
 reads
Message-ID: <20230926132725.5d570e1b@xps-13>
In-Reply-To: <e911f5d9c7def8c80904a17ad3924ecba6625998.camel@geanix.com>
References: <20230922141717.35977-1-r.czerwinski@pengutronix.de>
        <e911f5d9c7def8c80904a17ad3924ecba6625998.camel@geanix.com>
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

Hi Martin,

+ Bean and Domenico, there is a question for you below.

martin@geanix.com wrote on Mon, 25 Sep 2023 13:01:06 +0200:

> Hi Rouven,
>=20
> On Fri, 2023-09-22 at 16:17 +0200, Rouven Czerwinski wrote:
> > Both the JEDEC and ONFI specification say that read cache sequential
> > support is an optional command. This means that we not only need to
> > check whether the individual controller supports the command, we also
> > need to check the parameter pages for both ONFI and JEDEC NAND
> > flashes
> > before enabling sequential cache reads.
> >=20
> > This fixes support for NAND flashes which don't support enabling
> > cache
> > reads, i.e. Samsung K9F4G08U0F or Toshiba TC58NVG0S3HTA00.
> >=20
> > Sequential cache reads are now only available for ONFI and JEDEC
> > devices, if individual vendors implement this, it needs to be enabled
> > per vendor.
> >=20
> > Tested on i.MX6Q with a Samsung NAND flash chip that doesn't support
> > sequential reads.
> >=20
> > Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache
> > reads")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de> =20
>=20
> Thanks for this. It works as expected for my Toshiba chip, obviously
> because it doesn't use ONFI or JEDEC.
>=20
> Unfortunately, my Micron chip does use ONFI, and it sets the cached-
> read-supported bit. It then fails when reading afterwords:
>=20
> kernel: ONFI_OPT_CMD_READ_CACHE # debug added by me
> kernel: nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
> kernel: nand: Micron MT29F4G08ABAFAWP
> kernel: nand: 512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB
> size: 256
> kernel: nand: continued read supported # debug added by me
> kernel: Bad block table found at page 131008, version 0x01
> kernel: Bad block table found at page 130944, version 0x01
> kernel: 2 fixed-partitions partitions found on MTD device gpmi-nand
> kernel: Creating 2 MTD partitions on "gpmi-nand":
> kernel: 0x000000000000-0x000000800000 : "boot"
> kernel: 0x000000800000-0x000020000000 : "ubi"
> kernel: gpmi-nand 1806000.nand-controller: driver registered.
>=20
> ...
>=20
> kernel: ubi0: default fastmap pool size: 100
> kernel: ubi0: default fastmap WL pool size: 50
> kernel: ubi0: attaching mtd1
> kernel: ubi0: scanning is finished
> kernel: ubi0: attached mtd1 (name "ubi", size 504 MiB)
> kernel: ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 bytes
> kernel: ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
> kernel: ubi0: VID header offset: 4096 (aligned 4096), data offset: 8192
> kernel: ubi0: good PEBs: 2012, bad PEBs: 4, corrupted PEBs: 0
> kernel: ubi0: user volume: 9, internal volumes: 1, max. volumes count:
> 128
> kernel: ubi0: max/mean erase counter: 4/2, WL threshold: 4096, image
> sequence number: 1431497221
> kernel: ubi0: available PEBs: 12, total reserved PEBs: 2000, PEBs
> reserved for bad PEB handling: 36
> kernel: block ubiblock0_4: created from ubi0:4(rootfs.a)
> kernel: ubi0: background thread "ubi_bgt0d" started, PID 36
> kernel: block ubiblock0_6: created from ubi0:6(appfs.a)
> kernel: block ubiblock0_7: created from ubi0:7(appfs.b)
>=20
> ...
>=20
> kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
> kernel: SQUASHFS error: Unable to read directory block [4b6f15e:125]
> kernel: SQUASHFS error: Unable to read directory block [4b6d15c:1dae]
> kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
> (d-sysctl)[55]: systemd-sysctl.service: Failed to set up credentials:
> Protocol error
> kernel: SQUASHFS error: Unable to read directory block [4b73162:14f0]
> kernel: SQUASHFS error: Unable to read directory block [4b6f15e:838]
> systemd[1]: Starting Create Static Device Nodes in /dev...
> kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
> kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
> kernel: SQUASHFS error: Unable to read directory block [4b6f15e:838]
> kernel: SQUASHFS error: Unable to read directory block [4b6d15c:1dae]
> kernel: SQUASHFS error: Unable to read directory block [4b6f15e:125]
>=20
> I've briefly tried adding some error info the the squashfs error
> messages, but it looks like it's getting bad data. I.e. one failure a
> sanity check of `dir_count`:
>=20
> if (dir_count > SQUASHFS_DIR_COUNT)
> 	goto data_error;
>=20
> It fails with `dir_count` being 1952803684 ...
>=20
> So is this a case of wrong/bad timings?
>=20
> Miquel:
> I can tell from the code, that the READCACHESEQ operations are followed
> by NAND_OP_WAIT_RDY(tR_max, tRR_min). From the Micron datasheet[0], it
> should be NAND_OP_WAIT_RDY(tRCBSY_max, tRR_min), where tRCBSY is
> defined to be between 3 and 25 =C2=B5s.

I found a place in the ONFI spec states taht tRCBSY_max should be
between 3 and tR_max, so indeed we should be fine on that regard.

However, I asked myself whether we could have issues when crossing
boundaries. Block boundaries should be fine, however your device does
not support crossing plane boundaries, as bit 4 ("read cache
supported") of byte 114 ("Multi-plane operation attributes") in the
memory organization block of the parameter page is not set (the value
of the byte should be 0x0E if I get it right.

Anyway, our main issue here does not seem related to the boundaries. It
does not seem to be explicitly marked anywhere else but on the front
page:
	Advanced command set
	=E2=80=93 Program page cache mode (4)
	=E2=80=93 Read page cache mode (4)
	=E2=80=93 Two-plane commands (4)

	(4) These commands supported only with ECC disabled.

Read page cache mode without ECC makes the feature pretty useless IMHO.

Bean, Domenico, how do we know which devices allow ECC correction
during sequential page reads and which don't? Is there a (vendor?) bit
somewhere in the parameter page for that? Do we have any way to know
besides a list of devices allowing that? If so, can you provide one
with a few IDs?=20

Thanks,
Miqu=C3=A8l
