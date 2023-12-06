Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B504807CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441859AbjLGAAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjLFX77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:59:59 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735861A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:00:05 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000716BB.0000000065710B01.00118FFE; Thu, 07 Dec 2023 01:00:01 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 00/16] ALSA: hda/tas2781: Add tas2563 support
Date:   Thu,  7 Dec 2023 00:59:41 +0100
Message-ID: <cover.1701903015.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tas2781-hda driver can be modified to support tas2563 as well.
Before knowing this information, I created another series for a
new driver.
https://lore.kernel.org/lkml/cover.1701733441.git.soyer@irl.hu/

This series now extends tas2781-hda, addresses differences and
fixes various bugs.

The tas2563 is a smart amplifier. Similar to tas2562 but with DSP. Some
Lenovo laptops have it to drive the bass speakers. By default, it is in
software shutdown state.

To make the DSP work it needs a firmware and some calibration data.
The latter can be read from the EFI in Lenovo laptops.

For the correct configuration it needs additional register data.
It captured after running the Windows driver.

The firmware can be extracted as TAS2563Firmware.bin from the Windows
driver with innoextract.
https://download.lenovo.com/consumer/mobiles/h5yd037fbfyy7kd0.exe

The driver will search for it as TAS2XXX3870.bin with the 14ARB7.
The captured registers extracted with TI's regtool:
https://github.com/soyersoyer/tas2563rca/raw/main/INT8866RCA2.bin


Gergo Koteles (16):
  ASoC: tas2781: add support for fw version 0x0503
  ALSA: hda/tas2781: leave hda_component in usable state
  ASoC: tas2781: disable regmap regcache
  ALSA: hda/tas2781: handle missing calibration data
  ALSA: hda/tas2781: fix typos in comment
  ASoC: tas2781: add ptrs to calibration functions
  ALSA: hda/tas2781: load_calibration just load
  ASoC: tas2781: add configurable global_addr
  ALSA: hda/tas2781: add TAS2563 support for 14ARB7
  ASoC: tas2781: check negative indexes
  ASoC: tas2781: use 0 as default prog/conf index
  ASoC: tas2781: move set_drv_data outside tasdevice_init
  ALSA: hda/tas2781: remove sound controls in unbind
  ALSA: hda/tas2781: call cleaner functions only once
  ALSA: hda/tas2781: reset the amp before component_add
  ALSA: hda/tas2781: configure the amp after firmware load

 include/sound/tas2781.h           |   8 +
 sound/pci/hda/tas2781_hda_i2c.c   | 364 +++++++++++++++++++-----------
 sound/soc/codecs/tas2781-comlib.c |  23 +-
 sound/soc/codecs/tas2781-fmwlib.c |  11 +-
 sound/soc/codecs/tas2781-i2c.c    |   2 +
 5 files changed, 270 insertions(+), 138 deletions(-)


base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.43.0

