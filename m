Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59C7AD691
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjIYLBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIYLBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:01:19 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77232B8;
        Mon, 25 Sep 2023 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=lNLzo2Moa5E1lbjDwwwttLBQfhfja1CkCFWipbVAPig=; b=dismB98yfyGH9gQakyJykR2aIS
        W9GyrH9umb+155iQuAvM0YpffT1+rJe3/JUT5s4Fz8cuUzjDsBLRhoiDHH8V24oOowdOZJDB1MIbi
        k1jlojnKhYIldbHDVswwLSBesbkqbZ/oLvYIKIMKeHyTqk4MtwJJ49+fG9CvEzsNBz/XV0kNLJW3W
        t2NSPGuHPl1IV7G4MZFoNGGoVghrkSq2QIb1p/ajffgJUF4yHWjhrSm2f3AR7FBDU1n0TLqjoUyaH
        Dq0IpubBujjuRyuazrODreGsm3TYl/1oUcUwDg4XMt+epZw/u/IOocle8nMk9RR/cR3HskS1G8dXB
        GeR2GJFw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qkjKt-000DkX-MB; Mon, 25 Sep 2023 13:01:07 +0200
Received: from [85.184.138.13] (helo=[192.168.8.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qkjKt-000UZg-0K; Mon, 25 Sep 2023 13:01:07 +0200
Message-ID: <e911f5d9c7def8c80904a17ad3924ecba6625998.camel@geanix.com>
Subject: Re: [PATCH v2] mtd: rawnand: Ensure the nand chip supports cached
 reads
From:   Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Alexander Shiyan <eagle.alexander923@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>
Cc:     kernel@pengutronix.de, stable@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean =?ISO-8859-1?Q?Nyekj=E6r?= <sean@geanix.com>
Date:   Mon, 25 Sep 2023 13:01:06 +0200
In-Reply-To: <20230922141717.35977-1-r.czerwinski@pengutronix.de>
References: <20230922141717.35977-1-r.czerwinski@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27042/Mon Sep 25 09:37:53 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rouven,

On Fri, 2023-09-22 at 16:17 +0200, Rouven Czerwinski wrote:
> Both the JEDEC and ONFI specification say that read cache sequential
> support is an optional command. This means that we not only need to
> check whether the individual controller supports the command, we also
> need to check the parameter pages for both ONFI and JEDEC NAND
> flashes
> before enabling sequential cache reads.
>=20
> This fixes support for NAND flashes which don't support enabling
> cache
> reads, i.e. Samsung K9F4G08U0F or Toshiba TC58NVG0S3HTA00.
>=20
> Sequential cache reads are now only available for ONFI and JEDEC
> devices, if individual vendors implement this, it needs to be enabled
> per vendor.
>=20
> Tested on i.MX6Q with a Samsung NAND flash chip that doesn't support
> sequential reads.
>=20
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache
> reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Thanks for this. It works as expected for my Toshiba chip, obviously
because it doesn't use ONFI or JEDEC.

Unfortunately, my Micron chip does use ONFI, and it sets the cached-
read-supported bit. It then fails when reading afterwords:

kernel: ONFI_OPT_CMD_READ_CACHE # debug added by me
kernel: nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
kernel: nand: Micron MT29F4G08ABAFAWP
kernel: nand: 512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB
size: 256
kernel: nand: continued read supported # debug added by me
kernel: Bad block table found at page 131008, version 0x01
kernel: Bad block table found at page 130944, version 0x01
kernel: 2 fixed-partitions partitions found on MTD device gpmi-nand
kernel: Creating 2 MTD partitions on "gpmi-nand":
kernel: 0x000000000000-0x000000800000 : "boot"
kernel: 0x000000800000-0x000020000000 : "ubi"
kernel: gpmi-nand 1806000.nand-controller: driver registered.

...

kernel: ubi0: default fastmap pool size: 100
kernel: ubi0: default fastmap WL pool size: 50
kernel: ubi0: attaching mtd1
kernel: ubi0: scanning is finished
kernel: ubi0: attached mtd1 (name "ubi", size 504 MiB)
kernel: ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 bytes
kernel: ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
kernel: ubi0: VID header offset: 4096 (aligned 4096), data offset: 8192
kernel: ubi0: good PEBs: 2012, bad PEBs: 4, corrupted PEBs: 0
kernel: ubi0: user volume: 9, internal volumes: 1, max. volumes count:
128
kernel: ubi0: max/mean erase counter: 4/2, WL threshold: 4096, image
sequence number: 1431497221
kernel: ubi0: available PEBs: 12, total reserved PEBs: 2000, PEBs
reserved for bad PEB handling: 36
kernel: block ubiblock0_4: created from ubi0:4(rootfs.a)
kernel: ubi0: background thread "ubi_bgt0d" started, PID 36
kernel: block ubiblock0_6: created from ubi0:6(appfs.a)
kernel: block ubiblock0_7: created from ubi0:7(appfs.b)

...

kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
kernel: SQUASHFS error: Unable to read directory block [4b6f15e:125]
kernel: SQUASHFS error: Unable to read directory block [4b6d15c:1dae]
kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
(d-sysctl)[55]: systemd-sysctl.service: Failed to set up credentials:
Protocol error
kernel: SQUASHFS error: Unable to read directory block [4b73162:14f0]
kernel: SQUASHFS error: Unable to read directory block [4b6f15e:838]
systemd[1]: Starting Create Static Device Nodes in /dev...
kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
kernel: SQUASHFS error: Unable to read directory block [4b6d15c:ed1]
kernel: SQUASHFS error: Unable to read directory block [4b6f15e:838]
kernel: SQUASHFS error: Unable to read directory block [4b6d15c:1dae]
kernel: SQUASHFS error: Unable to read directory block [4b6f15e:125]

I've briefly tried adding some error info the the squashfs error
messages, but it looks like it's getting bad data. I.e. one failure a
sanity check of `dir_count`:

if (dir_count > SQUASHFS_DIR_COUNT)
	goto data_error;

It fails with `dir_count` being 1952803684 ...

So is this a case of wrong/bad timings?

Miquel:
I can tell from the code, that the READCACHESEQ operations are followed
by NAND_OP_WAIT_RDY(tR_max, tRR_min). From the Micron datasheet[0], it
should be NAND_OP_WAIT_RDY(tRCBSY_max, tRR_min), where tRCBSY is
defined to be between 3 and 25 =C2=B5s.

Not sure if this is related though.

[0]=C2=A0(login required)
https://www.micron.com/products/nand-flash/slc-nand/part-catalog/mt29f4g08a=
badawp

// Martin

> ---
> v2:
> - change title as suggested by Miquel
> - adjust controller sentence from implement to support
> - fix missing true assignement for flashes
> - add CC stable instead of empty line
> - add documentation comment for new supports_read_cache bool inside
> =C2=A0 nand parameter struct
>=20
> =C2=A0drivers/mtd/nand/raw/nand_base.c=C2=A0 | 3 +++
> =C2=A0drivers/mtd/nand/raw/nand_jedec.c | 3 +++
> =C2=A0drivers/mtd/nand/raw/nand_onfi.c=C2=A0 | 3 +++
> =C2=A0include/linux/mtd/jedec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 3 +++
> =C2=A0include/linux/mtd/onfi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 +
> =C2=A0include/linux/mtd/rawnand.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2=
 ++
> =C2=A06 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_base.c
> b/drivers/mtd/nand/raw/nand_base.c
> index d4b55155aeae..1fcac403cee6 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5110,6 +5110,9 @@ static void
> rawnand_check_cont_read_support(struct nand_chip *chip)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mtd_info *mtd =3D =
nand_to_mtd(chip);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip->parameters.supports=
_read_cache)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->read_retries)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0
> diff --git a/drivers/mtd/nand/raw/nand_jedec.c
> b/drivers/mtd/nand/raw/nand_jedec.c
> index 836757717660..b3cc8f360529 100644
> --- a/drivers/mtd/nand/raw/nand_jedec.c
> +++ b/drivers/mtd/nand/raw/nand_jedec.c
> @@ -94,6 +94,9 @@ int nand_jedec_detect(struct nand_chip *chip)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto free_jedec_param_page;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (p->opt_cmd[0] & JEDEC_OPT_=
CMD_READ_CACHE)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0chip->parameters.supports_read_cache =3D true;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memorg->pagesize =3D le32=
_to_cpu(p->byte_per_page);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtd->writesize =3D memorg=
->pagesize;
> =C2=A0
> diff --git a/drivers/mtd/nand/raw/nand_onfi.c
> b/drivers/mtd/nand/raw/nand_onfi.c
> index f15ef90aec8c..861975e44b55 100644
> --- a/drivers/mtd/nand/raw/nand_onfi.c
> +++ b/drivers/mtd/nand/raw/nand_onfi.c
> @@ -303,6 +303,9 @@ int nand_onfi_detect(struct nand_chip *chip)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ONFI_FEATURE_ADDR_TIMING_MODE, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (le16_to_cpu(p->opt_cmd) & =
ONFI_OPT_CMD_READ_CACHE)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0chip->parameters.supports_read_cache =3D true;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0onfi =3D kzalloc(sizeof(*=
onfi), GFP_KERNEL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!onfi) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -ENOMEM;
> diff --git a/include/linux/mtd/jedec.h b/include/linux/mtd/jedec.h
> index 0b6b59f7cfbd..56047a4e54c9 100644
> --- a/include/linux/mtd/jedec.h
> +++ b/include/linux/mtd/jedec.h
> @@ -21,6 +21,9 @@ struct jedec_ecc_info {
> =C2=A0/* JEDEC features */
> =C2=A0#define JEDEC_FEATURE_16_BIT_BUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0(1 << 0)
> =C2=A0
> +/* JEDEC Optional Commands */
> +#define JEDEC_OPT_CMD_READ_CACHE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0BIT(1)
> +
> =C2=A0struct nand_jedec_params {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* rev info and features =
block */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* 'J' 'E' 'S' 'D'=C2=A0 =
*/
> diff --git a/include/linux/mtd/onfi.h b/include/linux/mtd/onfi.h
> index a7376f9beddf..55ab2e4d62f9 100644
> --- a/include/linux/mtd/onfi.h
> +++ b/include/linux/mtd/onfi.h
> @@ -55,6 +55,7 @@
> =C2=A0#define ONFI_SUBFEATURE_PARAM_LEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A04
> =C2=A0
> =C2=A0/* ONFI optional commands SET/GET FEATURES supported? */
> +#define ONFI_OPT_CMD_READ_CACHE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(1)
> =C2=A0#define ONFI_OPT_CMD_SET_GET_FEATURES=C2=A0=C2=A0BIT(2)
> =C2=A0
> =C2=A0struct nand_onfi_params {
> diff --git a/include/linux/mtd/rawnand.h
> b/include/linux/mtd/rawnand.h
> index 90a141ba2a5a..c29ace15a053 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -225,6 +225,7 @@ struct gpio_desc;
> =C2=A0 * struct nand_parameters - NAND generic parameters from the
> parameter page
> =C2=A0 * @model: Model name
> =C2=A0 * @supports_set_get_features: The NAND chip supports
> setting/getting features
> + * @supports_read_cache: The NAND chip supports read cache
> operations
> =C2=A0 * @set_feature_list: Bitmap of features that can be set
> =C2=A0 * @get_feature_list: Bitmap of features that can be get
> =C2=A0 * @onfi: ONFI specific parameters
> @@ -233,6 +234,7 @@ struct nand_parameters {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Generic parameters */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *model;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool supports_set_get_fea=
tures;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool supports_read_cache;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DECLARE_BITMAP(set_featur=
e_list, ONFI_FEATURE_NUMBER);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DECLARE_BITMAP(get_featur=
e_list, ONFI_FEATURE_NUMBER);
> =C2=A0
>=20
> base-commit: 42dc814987c1feb6410904e58cfd4c36c4146150

