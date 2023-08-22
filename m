Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4B783A59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjHVHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjHVHJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63B0132
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57DB0649D9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F380EC433C7;
        Tue, 22 Aug 2023 07:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688176;
        bh=xFC1pAi43qSbnlKxyjmDKu0UxQ/ta4szdGQ4+NRgF3M=;
        h=From:Subject:Date:To:Cc:From;
        b=LqCSin7ejdz7lzFBKk0gATKKGZW6XPXko7eJEziKeQK8PiCz36yZEGQ2dPvnsUuhl
         T/LXbauLyIrK8/m7YDK7JCQ4xOcpCopCzIk7/NQ83qNpBUhOGKuuVwYbwf/JdyU4L6
         0c/qf/WvNuwRA2d7FtmrxN0qCc/ikyk9mKr7xx2wuqjYIxAXzK9jE6Ffefyess9xaZ
         bl1pfNdP1yeWs5vMUmDArDNExl2iYqK1rNYg4JSIRL6Ljfsdwn/nuzszwwykHiZIG5
         jm2Wx+afguh2h0EG3lHjWxNYB3N5Hll4Quisb2TWARbZ9/ywEXTfnMuEMVOtoX9iyh
         kxCP8/Uq7QKhg==
From:   Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 00/41] mtd: spi-nor: clean the flash_info database up
Date:   Tue, 22 Aug 2023 09:09:16 +0200
Message-Id: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1f5GQC/42OTQ6CMBCFr2K6dkwpoMSV9zAsWjqlE7A1U4Iaw
 t0t7E1cfi/vbxEJmTCJ62ERjDMliiGDOh5E53XoEchmFkqqUjbyAo/Jght18kDBRbAGGF+RB2h
 0rexZOpmdIseNTgiGdej8VvArt1mfjI7e+4t7m9lTmiJ/9lNzsal/7M8FSChtaWuDrjK6ug3IA
 cdT5F6067p+AWBy6FfsAAAA
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal is to have slim entries for *new* entries and to have a
flexible macro to specify the flash ID and get rid of the former
INFOx() macros with the hardcoded ID length.

Here is are some examples how an entry of flash_info will look like
after the conversion:
  {
    .id = SNOR_ID(0xef, 0x80, 0x20),
    .name = "w25q512nwm",
    .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
  }

  {
    .id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x00, 0x80),
    .name = "s25fl256s0",
    .size = SZ_32M,
    .sector_size = SZ_256K,
    .no_sfdp_flags = SPI_NOR_SKIP_SFDP | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
    .mfr_flags = USE_CLSR,
  }

Please note that the second entry might even be slimmed down if the
flash supports SFDP, which is very likely. But apart from one
exception, this patchset shouldn't change any information in the
flash_info database.

The exception is the removal of very old SPI EEPROMs and a Fujitsu MRAM.
Both should use the at25 EEPROM driver. The latter even has device tree
bindings for the at25 driver.

To make the entries as slim as possible, we introduce sane default
values so the actual flash_info entries, doesn't need to specify them.
This mostly applies to old non-SFDP flashes anyway.

Patches 01-02 remove the old catalyst EEPROMs and the Fujitsu MRAM.

Patches 03-16 are preparation patches to either convert properties
(like .n_sectors) or to make properties optional. These patches will
also modify the old INFOx() macros. This is important because with this
we can actually make sure, the conversion doesn't have any unwanted
changes. We can compare the .rodata segment before and after the
conversion to make sure, there are no mistakes in the patches, because
they are impossible to review.

To make sure there are no changes you can compare the output of
  objdump -j.rodata -s drivers/mtd/spi-nor/built-in.a

(or individual objects like drivers/mtd/spi-nor/winbond.o) before and
after the conversion, that is before patch 17 and after patch 30.

FWIW, before the conversion it was impossible to use coccinelle, eg.
"spatch --parse-c winbond.c" flagged almost all lines in the flash_info
structure as bad.

Now after the conversion is completed, patches 31-39 sort the
entries by their IDs.

Patch 40 removes a duplicate entry in atmel which surfaced during the
sorting.

Patch 41 then finally removes the old INFOx() macros.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Changes in v1:
- rebase to latest next, esp. include the sst26vf032b changes
- fixed the makefiles found by the kernel test robot
- fixed small typos and nitpicks noticed by Miquel
- collected Rb tags
- Link to v1: https://lore.kernel.org/r/20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org

---
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

 drivers/mtd/spi-nor/Makefile     |   2 -
 drivers/mtd/spi-nor/atmel.c      | 116 +++++++----
 drivers/mtd/spi-nor/catalyst.c   |  24 ---
 drivers/mtd/spi-nor/core.c       |  63 +++---
 drivers/mtd/spi-nor/core.h       | 136 ++++++-------
 drivers/mtd/spi-nor/eon.c        |  74 +++++--
 drivers/mtd/spi-nor/esmt.c       |  29 ++-
 drivers/mtd/spi-nor/everspin.c   |  34 +++-
 drivers/mtd/spi-nor/fujitsu.c    |  21 --
 drivers/mtd/spi-nor/gigadevice.c |  82 ++++----
 drivers/mtd/spi-nor/intel.c      |  23 ++-
 drivers/mtd/spi-nor/issi.c       | 118 +++++++----
 drivers/mtd/spi-nor/macronix.c   | 220 ++++++++++++++-------
 drivers/mtd/spi-nor/micron-st.c  | 411 ++++++++++++++++++++++++++-------------
 drivers/mtd/spi-nor/spansion.c   | 389 ++++++++++++++++++++++--------------
 drivers/mtd/spi-nor/sst.c        | 164 ++++++++++------
 drivers/mtd/spi-nor/swp.c        |  13 +-
 drivers/mtd/spi-nor/sysfs.c      |   6 +-
 drivers/mtd/spi-nor/winbond.c    | 286 +++++++++++++++++----------
 drivers/mtd/spi-nor/xilinx.c     |  32 ++-
 drivers/mtd/spi-nor/xmc.c        |  19 +-
 21 files changed, 1391 insertions(+), 871 deletions(-)
---
base-commit: 47d9bb711707d15b19fad18c8e2b4b027a264a3a
change-id: 20230807-mtd-flash-info-db-rework-8a52d60f0023

