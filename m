Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F56805C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442390AbjLEPVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346070AbjLEPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:21:22 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28618B2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:21:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 4239840006;
        Tue,  5 Dec 2023 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701789686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EQzemCGjTKgaOFfggHrbLZ6TF0LQrH4UISYJFYtdjhE=;
        b=ZLTYCOXnb1VxUvJE0efVr+7U4KVX+H7XmeidTTaEu3Ym5K05fvFZW+FCckTZhrBaYBWxgu
        OoOhfyHDT0nc6C/FmbPR/69hBqAZU+peuWmt11XRZfvbc1zmr0FQj0IrqH+TS9SA5+p2eq
        OpcaIEDq3Rj3gOxwxWZeLFGrKzk0cKUW1M2w1yMDmE6BAoXXKYvspl5tRZFaIRqgQ96DYn
        Jxgp4qxZHDlE/bl0WGfbki46dBNVCkSqIZkCyCKkYwXXLyPdybDeWTuyMiQGSSgZCCRnHV
        SuGm2J7v8McKbtLm/hYzEX+4Jmsf3Hxd3duvIAELZIKjDaXLD8alOZh4RnqpUw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 00/17] Prepare the PowerQUICC QMC and TSA for the HDLC QMC driver
Date:   Tue,  5 Dec 2023 16:20:57 +0100
Message-ID: <20231205152116.122512-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series updates PowerQUICC QMC and TSA drivers to prepare the
support for the QMC HDLC driver.

Patches were previously sent as part of a full feature series:
"Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]

The full feature series reached the v9 iteration.
The v1 was sent the 07/25/2023 followed by the other iterations
(07/26/2023, 08/09/2023, 08/18/2023, 09/12/2023, 09/22/2023, 09/28/2023,
10/11/23, 11/15/2023) and was ready to be merged in its v8.
  https://lore.kernel.org/linux-kernel/20231025123215.5caca7d4@kernel.org/

The lack of feedback from the Freescale SoC and the Quicc Engine
maintainers (i.e. drivers/soc/fsl/qe/ to which the QMC and TSA drivers
belong) blocks the entire full feature series.
These patches are fixes and improvements to TSA and QMC drivers.
These drivers were previously acked by Li Yang but without any feedback
from Li Yang nor Qiang Zhao the series cannot move forward.

In order to ease the review/merge, the full feature series has been
split and this series contains patches related to the PowerQUICC SoC
part (QMC and TSA).
 - Perform some fixes (patches 1 to 5)
 - Add support for child devices (patch 6)
 - Add QMC dynamic timeslot support (patches 7 to 17)

Compare to the previous iteration:
  https://lore.kernel.org/linux-kernel/20231128140818.261541-1-herve.codina@bootlin.com/
this v2 series:
- Removes a forward declaration in the driver.
- Adds kernel test robot tags as the issue was detected.
- Adds some missing Cc: stable.

Best regards,
Hervé

[1]: https://lore.kernel.org/linux-kernel/20231115144007.478111-1-herve.codina@bootlin.com/

Changes v1 -> v2:
  - Patch 1
    Add 'Reported-by: kernel test robot <lkp@intel.com>'
    Add 'Closes: https://lore.kernel.org/oe-kbuild-all/202312051959.9YdRIYbg-lkp@intel.com/'
    Add 'Cc: stable@vger.kernel.org'

  - Patch 2, 3
    Add 'Cc: stable@vger.kernel.org

  - Patch 15
    Move qmc_setup_chan_trnsync() to avoid a forward declaration.

Patches extracted:
  - Patch 1..6 : full feature series patch 1..6
  - Patch 7..17 : full feature series patch 9..19

Herve Codina (17):
  soc: fsl: cpm1: tsa: Fix __iomem addresses declaration
  soc: fsl: cpm1: qmc: Fix __iomem addresses declaration
  soc: fsl: cpm1: qmc: Fix rx channel reset
  soc: fsl: cpm1: qmc: Extend the API to provide Rx status
  soc: fsl: cpm1: qmc: Remove inline function specifiers
  soc: fsl: cpm1: qmc: Add support for child devices
  soc: fsl: cpm1: qmc: Introduce available timeslots masks
  soc: fsl: cpm1: qmc: Rename qmc_setup_tsa* to qmc_init_tsa*
  soc: fsl: cpm1: qmc: Introduce qmc_chan_setup_tsa*
  soc: fsl: cpm1: qmc: Remove no more needed checks from
    qmc_check_chans()
  soc: fsl: cpm1: qmc: Check available timeslots in qmc_check_chans()
  soc: fsl: cpm1: qmc: Add support for disabling channel TSA entries
  soc: fsl: cpm1: qmc: Split Tx and Rx TSA entries setup
  soc: fsl: cpm1: qmc: Introduce is_tsa_64rxtx flag
  soc: fsl: cpm1: qmc: Handle timeslot entries at channel start() and
    stop()
  soc: fsl: cpm1: qmc: Remove timeslots handling from setup_chan()
  soc: fsl: cpm1: qmc: Introduce functions to change timeslots at
    runtime

 drivers/soc/fsl/qe/qmc.c      | 658 ++++++++++++++++++++++++++--------
 drivers/soc/fsl/qe/tsa.c      |  22 +-
 include/soc/fsl/qe/qmc.h      |  27 +-
 sound/soc/fsl/fsl_qmc_audio.c |   2 +-
 4 files changed, 538 insertions(+), 171 deletions(-)

-- 
2.43.0

