Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974C97D1554
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjJTSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjJTSAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:00:48 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD8D70
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:00:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20ACEC0005;
        Fri, 20 Oct 2023 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697824842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=W3OOOWAmN8Ll41vLduGQ5zOvtpZilXlonF/UUtX3oS0=;
        b=lJswlx/366St25SOuRqY0hGsopmMN4RRNIykJfN0SXXtG792xL2Q9i3rz1bXnyzJYB2e31
        8qAFxpNUlq1pOBobzt1fZ1kZFIUt83ljipnP+80CzLvQoaSeQ+LmjgxSfESYGXbrwob/+E
        zryUV4fsOp2IXw1uVWv/7hnzefcR6kOsZlU90p6L7L54eVA4U5rt9bP8eH3ejR3BNtk1lN
        g43H683Safk5tiILDPhhzPuoHO/dL5VVOoL5x/0l7cOTHCwky9I4flCNL6S2+m2N8/Dan7
        tfhyS0ZThdqMmylnFUErTsBgw9S952dOkcI0ttiS2YDYWWEM7Ss8Stsuzgp3rg==
Date:   Fri, 20 Oct 2023 20:00:39 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for 6.6-rc7
Message-ID: <20231020200039.09ff7f18@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is an MTD fixes PR for the next -rc. As discussed during the
previous cycles, I've changed my way of writing the PR text. Let me
know if you want something different.

Thanks,
Miqu=C3=A8l

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.6-rc7

for you to fetch changes up to f6ca3fb6978f94d95ee79f95085fc22e71ca17cc:

  mtd: rawnand: Ensure the nand chip supports cached reads (2023-10-16 10:4=
7:22 +0200)

----------------------------------------------------------------
In the raw NAND subsystem, the major fix prevents using cached reads
with devices not supporting it. There was two bug reports about
this. Aside, 3 drivers (pl353, arasan and marvell) could sometimes hide
page program failures due to their their own program page helper not
being fully compliant with the specification (many drivers use the
default helpers shared by the core). Adding a missing check prevents
these situation. Finally, the Qualcomm driver had a broken error path.

In the SPI-NAND subsystem one Micron device used a wrong bitmak
reporting possibly corrupted ECC status.

Finally, the physmap-core got stripped from its map_rom fallback by
mistake, this feature is added back.

----------------------------------------------------------------
Bibek Kumar Patro (1):
      mtd: rawnand: qcom: Unmap the right resource upon probe failure

Geert Uytterhoeven (1):
      mtd: physmap-core: Restore map_rom fallback

Martin Kurbanov (1):
      mtd: spinand: micron: correct bitmask for ecc status

Miquel Raynal (3):
      mtd: rawnand: marvell: Ensure program page operations are successful
      mtd: rawnand: arasan: Ensure program page operations are successful
      mtd: rawnand: pl353: Ensure program page operations are successful

Rouven Czerwinski (1):
      mtd: rawnand: Ensure the nand chip supports cached reads

 drivers/mtd/maps/physmap-core.c               | 11 +++++++++++
 drivers/mtd/nand/raw/arasan-nand-controller.c | 16 ++++++++++++++--
 drivers/mtd/nand/raw/marvell_nand.c           | 23 ++++++++++++++++++++++-
 drivers/mtd/nand/raw/nand_base.c              |  3 +++
 drivers/mtd/nand/raw/nand_jedec.c             |  3 +++
 drivers/mtd/nand/raw/nand_onfi.c              |  3 +++
 drivers/mtd/nand/raw/pl35x-nand-controller.c  |  9 +++++++++
 drivers/mtd/nand/raw/qcom_nandc.c             |  2 +-
 drivers/mtd/nand/spi/micron.c                 |  2 +-
 include/linux/mtd/jedec.h                     |  3 +++
 include/linux/mtd/onfi.h                      |  1 +
 include/linux/mtd/rawnand.h                   |  2 ++
 12 files changed, 73 insertions(+), 5 deletions(-)
