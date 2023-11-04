Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAB27E0F09
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjKDLH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjKDLH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:07:28 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D32125
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:07:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18797FF803;
        Sat,  4 Nov 2023 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699096041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pyuxwhUflVOQARKQM8fo6PDO/EnIPtVmyZLXSmyhTq8=;
        b=NdW8gMxjcIgGUTRP4egrPpvyHIXuPQP2ZWWWLNEA2kyvp7kfcXhnomQ/jdiw+/+JNM5Wb/
        xFT/9yC36Z0/v454wiQ7BEIJJEsCy5Vq3FEazU9CXzpDequzchhcLHFKmjAq2lFGY/OtPG
        GgTDq3dSEKbJRSbr2ODbFc0pgcfx9211Fem/8cDHONbuppsWpbYlXpVhQn4v4bMtwi0LSY
        EIEvbpS1xchMKPxfNuap2j6a5hohP/kO4vGvUYrE3u/jW9kG+ZAq20PpVV4E80rMMoCBdB
        OfhBOhk2QyHn6yoTVqkBF1LQrzPO0Vw+cWrA7dnZjABZRcKyQHwBgVrSSJhKMw==
Date:   Sat, 4 Nov 2023 12:07:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for v6.7
Message-ID: <20231104120719.185834dc@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for v6.7-rc1.

Thanks,
Miqu=C3=A8l

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.7

for you to fetch changes up to 6d55d31e927eec68ba6db344688044ed253223e9:

  Merge tag 'nand/for-6.7' into mtd/next (2023-11-04 11:50:34 +0100)

----------------------------------------------------------------
The main load of changes is related to Uwe's work converting platform
remove callbacks to return void. Comes next (in number of changes) Kees'
additional structures annotations to improve the sanitizers. The usual
amount of cleanups apply.

About the more substancial contribution, one main function of the
partitions core could return an error which was not checked, this is now
fixed. On the bindings side, fixed partitions can now have a compression
property. Finally, an erroneous situation is now always avoided in the
MAP RAM driver.

* CFI

A several years old byte swap has been fixed.

* NAND

The subsystem has, as usual, seen a bit of cleanup being done this
cycle, typically return values of platform_get_irq() and
devm_kasprintf(). There is also a better ECC check in the Arasan
driver. This comes with smaller misc changes.

In the SPI-NAND world there is now support for Foresee F35SQA002G,
Winbond W25N and XTX XT26 chips.

* SPI NOR

For SPI NOR we cleaned the flash info entries in order to have
them slimmer and self explanatory. In order to make the entries
as slim as possible, we introduced sane default values so that
the actual flash entries don't need to specify them. We now use
a flexible macro to specify the flash ID instead of the previous
INFOx() macros that had hardcoded ID lengths.

Instead of:
-       { "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 0)
-               OTP_INFO(256, 3, 0x1000, 0x1000) },

We now use:
+               .id =3D SNOR_ID(0xef, 0x80, 0x20),
+               .name =3D "w25q512nwm",
+               .otp =3D SNOR_OTP(256, 3, 0x1000, 0x1000),

We also removed some flash entries: the very old Catalyst
SPI EEPROMs that were introduced once with the SPI-NOR subsystem,
and a Fujitsu MRAM. Both should use the at25 EEPROM driver.
The latter even has device tree bindings for the at25 driver.

We made sure that the conversion didn't introduce any unwanted
changes by comparing the .rodata segment before and after the
conversion. The patches landed in linux-next immediately after
v6.6-rc2, we haven't seen any regressions yet.

Apart of the autumn cleaning we introduced a new flash entry,
at25ff321a, and added block protection support for mt25qu512a.

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      mtd: rawnand: arasan: Include ECC syndrome along with in-band data wh=
ile checking for ECC failure

Andy Shevchenko (1):
      mtd: rawnand: Remove unused of_gpio.h inclusion

Arseniy Krasnov (1):
      mtd: rawnand: remove 'nand_exit_status_op()' prototype

Bruce Suen (1):
      mtd: spinand: Add support for XTX XT26xxxDxxxxx

Christophe JAILLET (1):
      mtd: rawnand: rockchip: Use struct_size()

Denis Arefev (1):
      mtd: lpddr_cmds: Add literal suffix

Kees Cook (11):
      mtd: Annotate struct lpddr_private with __counted_by
      mtd: cfi: Annotate struct cfi_private with __counted_by
      mtd: rawnand: atmel: Annotate struct atmel_nand with __counted_by
      mtd: rawnand: denali: Annotate struct denali_chip with __counted_by
      mtd: rawnand: ingenic: Annotate struct ingenic_nfc with __counted_by
      mtd: rawnand: marvell: Annotate struct marvell_nand_chip with __count=
ed_by
      mtd: rawnand: meson: Annotate struct meson_nfc_nand_chip with __count=
ed_by
      mtd: rawnand: renesas: Annotate struct rnand_chip with __counted_by
      mtd: rawnand: sunxi: Annotate struct sunxi_nand_chip with __counted_by
      mtd: rawnand: Annotate struct mtk_nfc_nand_chip with __counted_by
      mtd: rawnand: cadence: Annotate struct cdns_nand_chip with __counted_=
by

Linus Walleij (1):
      mtd: cfi_cmdset_0001: Byte swap OTP info

Mamta Shukla (2):
      mtd: spi-nor: micron-st: enable lock/unlock for mt25qu512a
      mtd: spi-nor: micron-st: use SFDP table for mt25qu512a

Martin Kurbanov (1):
      mtd: spinand: add support for FORESEE F35SQA002G

Michael Walle (41):
      mtd: spi-nor: remove catalyst 'flashes'
      mtd: spi-nor: remove Fujitsu MB85RS1MT support
      mtd: spi-nor: xilinx: use SPI_NOR_ID() in S3AN_INFO()
      mtd: spi-nor: xilinx: remove addr_nbytes from S3AN_INFO()
      mtd: spi-nor: convert .n_sectors to .size
      mtd: spi-nor: default page_size to 256 bytes
      mtd: spi-nor: store .n_banks in struct spi_nor_flash_parameter
      mtd: spi-nor: default .n_banks to 1
      mtd: spi-nor: push 4k SE handling into spi_nor_select_uniform_erase()
      mtd: spi-nor: make sector_size optional
      mtd: spi-nor: drop .parse_sfdp
      mtd: spi-nor: introduce (temporary) INFO0()
      mtd: spi-nor: move the .id and .id_len into an own structure
      mtd: spi-nor: rename .otp_org to .otp and make it a pointer
      mtd: spi-nor: add SNOR_ID() and SNOR_OTP()
      mtd: spi-nor: remove or move flash_info comments
      mtd: spi-nor: atmel: convert flash_info to new format
      mtd: spi-nor: eon: convert flash_info to new format
      mtd: spi-nor: esmt: convert flash_info to new format
      mtd: spi-nor: everspin: convert flash_info to new format
      mtd: spi-nor: gigadevice: convert flash_info to new format
      mtd: spi-nor: intel: convert flash_info to new format
      mtd: spi-nor: issi: convert flash_info to new format
      mtd: spi-nor: macronix: convert flash_info to new format
      mtd: spi-nor: micron-st: convert flash_info to new format
      mtd: spi-nor: spansion: convert flash_info to new format
      mtd: spi-nor: sst: convert flash_info to new format
      mtd: spi-nor: winbond: convert flash_info to new format
      mtd: spi-nor: xilinx: use new macros in S3AN_INFO()
      mtd: spi-nor: xmc: convert flash_info to new format
      mtd: spi-nor: atmel: sort flash_info database
      mtd: spi-nor: eon: sort flash_info database
      mtd: spi-nor: gigadevice: sort flash_info database
      mtd: spi-nor: issi: sort flash_info database
      mtd: spi-nor: macronix: sort flash_info database
      mtd: spi-nor: micron-st: sort flash_info database
      mtd: spi-nor: spansion: sort flash_info database
      mtd: spi-nor: sst: sort flash_info database
      mtd: spi-nor: winbond: sort flash_info entries
      mtd: spi-nor: atmel: drop duplicate entry
      mtd: spi-nor: core: get rid of the INFOx() macros

Miquel Raynal (2):
      Merge tag 'spi-nor/for-6.7' into mtd/next
      Merge tag 'nand/for-6.7' into mtd/next

Nicolas Ferre (1):
      mtd: spi-nor: atmel: add at25ff321a entry

Rafa=C5=82 Mi=C5=82ecki (1):
      mtd: mtdpart: check for subpartitions parsing result

Rob Herring (1):
      mtd: Use device_get_match_data()

Shivamurthy Shastri (1):
      mtd: map_ram: prevent use of point and unpoint when NO_XIP is set

Simon Glass (1):
      dt-bindings: mtd: fixed-partitions: Add compression property

Sridharan S N (1):
      mtd: spinand: winbond: add support for serial NAND flash

Uwe Kleine-K=C3=B6nig (18):
      mtd: bcm47xxsflash: Convert to platform remove callback returning void
      mtd: docg3: Convert to platform remove callback returning void
      mtd: phram: Convert to platform remove callback returning void
      mtd: powernv_flash: Convert to platform remove callback returning void
      mtd: spear_smi: Convert to platform remove callback returning void
      mtd: st_spi_fsm: Convert to platform remove callback returning void
      mtd: hyperbus: hbmc-am654: Convert to platform remove callback return=
ing void
      mtd: hyperbus: rpc-if: Convert to platform remove callback returning =
void
      mtd: lpddr2_nvm: Convert to platform remove callback returning void
      mtd: maps: lantiq-flash: Convert to platform remove callback returnin=
g void
      mtd: maps: physmap-core: Convert to platform remove callback returnin=
g void
      mtd: maps: plat-ram: Convert to platform remove callback returning vo=
id
      mtd: maps: pxa2xx-flash: Convert to platform remove callback returnin=
g void
      mtd: maps: sa1100-flash: Convert to platform remove callback returnin=
g void
      mtd: maps: sun_uflash: Convert to platform remove callback returning =
void
      mtd: spi-nor: hisi-sfc: Convert to platform remove callback returning=
 void
      mtd: spi-nor: nxp-spifi: Convert to platform remove callback returnin=
g void
      mtd: rawnand: sh_flctl: Convert to module_platform_driver()

Yi Yang (4):
      mtd: rawnand: tegra: add missing check for platform_get_irq()
      mtd: rawnand: omap2: Fix check 0 for platform_get_irq()
      mtd: rawnand: intel: check return value of devm_kasprintf()
      mtd: rawnand: meson: check return value of devm_kasprintf()

ZhaoLong Wang (1):
      mtd: Add WARN_ON_ONCE() to mtd_read() to check the return value

 Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml |  =
19 +++++
 drivers/mtd/chips/cfi_cmdset_0001.c                                    |  =
20 ++++-
 drivers/mtd/chips/map_ram.c                                            |  =
 8 +-
 drivers/mtd/devices/bcm47xxsflash.c                                    |  =
 6 +-
 drivers/mtd/devices/docg3.c                                            |  =
 5 +-
 drivers/mtd/devices/phram.c                                            |  =
 6 +-
 drivers/mtd/devices/powernv_flash.c                                    |  =
 6 +-
 drivers/mtd/devices/spear_smi.c                                        |  =
 6 +-
 drivers/mtd/devices/st_spi_fsm.c                                       |  =
 6 +-
 drivers/mtd/hyperbus/hbmc-am654.c                                      |  =
 6 +-
 drivers/mtd/hyperbus/rpc-if.c                                          |  =
 6 +-
 drivers/mtd/lpddr/lpddr2_nvm.c                                         |  =
 6 +-
 drivers/mtd/lpddr/lpddr_cmds.c                                         |  =
 2 +-
 drivers/mtd/maps/lantiq-flash.c                                        |  =
 6 +-
 drivers/mtd/maps/physmap-core.c                                        |  =
15 ++--
 drivers/mtd/maps/plat-ram.c                                            |  =
 8 +-
 drivers/mtd/maps/pxa2xx-flash.c                                        |  =
 5 +-
 drivers/mtd/maps/sa1100-flash.c                                        |  =
 6 +-
 drivers/mtd/maps/sun_uflash.c                                          |  =
 6 +-
 drivers/mtd/mtdcore.c                                                  |  =
 2 +
 drivers/mtd/mtdpart.c                                                  |  =
 6 +-
 drivers/mtd/nand/raw/arasan-nand-controller.c                          |  =
 2 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c                           |  =
 2 +-
 drivers/mtd/nand/raw/cadence-nand-controller.c                         |  =
14 ++--
 drivers/mtd/nand/raw/denali.h                                          |  =
 2 +-
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c                        |  =
 2 +-
 drivers/mtd/nand/raw/intel-nand-controller.c                           |  =
10 +++
 drivers/mtd/nand/raw/internals.h                                       |  =
 1 -
 drivers/mtd/nand/raw/marvell_nand.c                                    |  =
 2 +-
 drivers/mtd/nand/raw/meson_nand.c                                      |  =
 5 +-
 drivers/mtd/nand/raw/mtk_nand.c                                        |  =
 2 +-
 drivers/mtd/nand/raw/nand_base.c                                       |  =
 1 -
 drivers/mtd/nand/raw/omap2.c                                           |  =
 8 +-
 drivers/mtd/nand/raw/renesas-nand-controller.c                         |  =
 2 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c                        |  =
 5 +-
 drivers/mtd/nand/raw/sh_flctl.c                                        |  =
 3 +-
 drivers/mtd/nand/raw/sunxi_nand.c                                      |  =
 2 +-
 drivers/mtd/nand/raw/tegra_nand.c                                      |  =
 4 +
 drivers/mtd/nand/raw/vf610_nfc.c                                       |  =
10 +--
 drivers/mtd/nand/raw/xway_nand.c                                       |  =
 1 -
 drivers/mtd/nand/spi/Makefile                                          |  =
 2 +-
 drivers/mtd/nand/spi/core.c                                            |  =
 1 +
 drivers/mtd/nand/spi/foresee.c                                         |  =
95 ++++++++++++++++++++++
 drivers/mtd/nand/spi/winbond.c                                         |  =
45 +++++++++++
 drivers/mtd/nand/spi/xtx.c                                             | 1=
34 +++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/Makefile                                           |  =
 2 -
 drivers/mtd/spi-nor/atmel.c                                            | 1=
21 ++++++++++++++++++----------
 drivers/mtd/spi-nor/catalyst.c                                         |  =
24 ------
 drivers/mtd/spi-nor/controllers/hisi-sfc.c                             |  =
 5 +-
 drivers/mtd/spi-nor/controllers/nxp-spifi.c                            |  =
 6 +-
 drivers/mtd/spi-nor/core.c                                             |  =
63 ++++++---------
 drivers/mtd/spi-nor/core.h                                             | 1=
40 +++++++++++++++-----------------
 drivers/mtd/spi-nor/eon.c                                              |  =
74 ++++++++++++-----
 drivers/mtd/spi-nor/esmt.c                                             |  =
29 ++++---
 drivers/mtd/spi-nor/everspin.c                                         |  =
28 +++++--
 drivers/mtd/spi-nor/fujitsu.c                                          |  =
21 -----
 drivers/mtd/spi-nor/gigadevice.c                                       |  =
82 +++++++++++--------
 drivers/mtd/spi-nor/intel.c                                            |  =
23 ++++--
 drivers/mtd/spi-nor/issi.c                                             | 1=
18 +++++++++++++++++----------
 drivers/mtd/spi-nor/macronix.c                                         | 2=
20 ++++++++++++++++++++++++++++++++++----------------
 drivers/mtd/spi-nor/micron-st.c                                        | 4=
23 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------=
-------------------------
 drivers/mtd/spi-nor/spansion.c                                         | 3=
92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------=
-----------------
 drivers/mtd/spi-nor/sst.c                                              | 1=
64 ++++++++++++++++++++++++--------------
 drivers/mtd/spi-nor/swp.c                                              |  =
13 ++-
 drivers/mtd/spi-nor/sysfs.c                                            |  =
 6 +-
 drivers/mtd/spi-nor/winbond.c                                          | 2=
88 ++++++++++++++++++++++++++++++++++++++++++------------------------
 drivers/mtd/spi-nor/xilinx.c                                           |  =
32 +++-----
 drivers/mtd/spi-nor/xmc.c                                              |  =
19 +++--
 include/linux/mtd/cfi.h                                                |  =
 2 +-
 include/linux/mtd/qinfo.h                                              |  =
 2 +-
 include/linux/mtd/spinand.h                                            |  =
 1 +
 71 files changed, 1820 insertions(+), 989 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/foresee.c
 delete mode 100644 drivers/mtd/spi-nor/catalyst.c
 delete mode 100644 drivers/mtd/spi-nor/fujitsu.c
