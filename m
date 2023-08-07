Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5573B772561
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjHGNV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHGNVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E6AB3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5589961AB6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024BAC433C9;
        Mon,  7 Aug 2023 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414512;
        bh=rbmo5I2tDUsLjeKD40Z/ExhML3leRpbSRwptZ1DUgtA=;
        h=From:Subject:Date:To:Cc:From;
        b=lwpuGOKhajIWnHytK/aCjJbcnGguD3nE5eyuVgqnrP6Zc5+xrubWAWvnmVmHDbD8I
         qm5zLpTl712YaIjQh6/zybdSBja2E7dJTSNzjoYvf8wuCubrF74C4tP1FSXM1v1SKj
         J992tYyWxP23giU3LFPRTJbrjS+U7H3MfpZbrbdnFMeuwt2GarLJ+0c6y3c2s/767C
         zhAe0RjcKvU3XK4hBJalOhJ5UYgLzC37UoqSgWTKdnxemdpcyQr7jcIvEn51SW0O/L
         MqPmOCJk6oix4WM3FTXY+mU2oBWfuf7pkDk+uQ75mIOwqYBH27fjgIBB607n3deAWr
         u3MoNl/bmmmXw==
From:   Michael Walle <mwalle@kernel.org>
Subject: [PATCH 00/41] mtd: spi-nor: clean the flash_info database up
Date:   Mon, 07 Aug 2023 15:20:54 +0200
Message-Id: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALfv0GQC/3WOQQrCMBBFr1Jm7cCYohavIi4mzcQMaiKTooXSu
 5u6d/ngvc9foIqpVDh3C5i8tWrJDfa7DsbE+SaooTE4cj0NdMLnFDA+uCbUHAsGjyafYncc+OD
 CkSI1E1ruuQp64zymbeBft6kvk6jz78Xluq5f6X2ngZUAAAA=
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/mtd/spi-nor/sst.c        | 156 +++++++++------
 drivers/mtd/spi-nor/swp.c        |  13 +-
 drivers/mtd/spi-nor/sysfs.c      |   6 +-
 drivers/mtd/spi-nor/winbond.c    | 286 +++++++++++++++++----------
 drivers/mtd/spi-nor/xilinx.c     |  32 ++-
 drivers/mtd/spi-nor/xmc.c        |  19 +-
 20 files changed, 1387 insertions(+), 865 deletions(-)
---
base-commit: f7dc24b3413851109c4047b22997bd0d95ed52a2
change-id: 20230807-mtd-flash-info-db-rework-8a52d60f0023

