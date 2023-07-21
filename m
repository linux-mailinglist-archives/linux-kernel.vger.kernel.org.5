Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74E575C7A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGUNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGUNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:22:17 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2E83A87
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:21:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L5i7DV017256;
        Fri, 21 Jul 2023 08:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=S
        ras6w/5Pr5D4kJH/bAiUrfrDmtF07M5UZBHB6Cobro=; b=TCui+azW+AqYraJY4
        j6d1ZwkdaM7PMgxz4NsPuXxg7KQfmgSk71q4MC3cU3bo9SefvZxCL0b+mBfNmOb7
        Ff9O4Wy0qiIXTxiB9WflHEK7Q97YehrL/0BItUl3bPKx6GmPZpLX+HUrzErHEyxH
        vK3pVogaSuw3PvJGy8IGh6p0mRz3YBIe16r7WK21MT9oWz/GdP39oET6YhBTzonS
        kXE2rXoWc9Bqs9yiYl+5VcQMD0OTmTwRpLYMulk9onLr602wNm3Tb4ZjIVZwJeMm
        xKBBAcs2XCMkr9Kkx9mB2IZTWWp6ZIztHGhdE9W+XcemGduYsXJSdKNUOhti9ye8
        cWNPA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gyj2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:21:24 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 14:21:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 21 Jul 2023 14:21:23 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.172])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0CF2146B;
        Fri, 21 Jul 2023 13:21:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v5 00/11] ALSA: hda: Adding support for CS35L56 on HDA systems
Date:   Fri, 21 Jul 2023 14:21:09 +0100
Message-ID: <20230721132120.5523-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HXrFS9q7grFIGNA6t1h9R1RCJh0569vT
X-Proofpoint-GUID: HXrFS9q7grFIGNA6t1h9R1RCJh0569vT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches adds support for using the CS35L56 boosted smart
amplifier on HDA systems. In these systems the CS35L56 audio is
routed through a HDA-to-I2S bridge codec.

This doesn't include the changes to the Realtek driver to actually hook
up the CS35L56 driver, because we don't yet have the QUIRK IDs to
associate it with. But we want to publish the driver now so that it is
available for bringing up hardware with the CS35L56.

The first 9 patches are moving code out of the ASoC driver and into the
shared library so that it can be shared with the HDA driver.

Patch #10 fixes missing #includes in the HDA headers so that the CS35L56
driver doesn't have to #include headers that it doesn't use.

CHANGES SINCE V5
The series has been rebased onto commit df4167d658d4
("ASoC: cs35l56: Patch soft registers to defaults"), which removes
cs35l56_reread_firmware_registers() and adds cs35l56_set_patch().

Changes are trivial so I have carried forward Mark's and Takashi's acks.

Patch 01:
- Also changes cs35l56_set_patch() argument to new struct cs35l56_base.

Patch 11:
- Remove call to cs35l56_reread_firmware_registers()
- Add call to cs35l56_set_patch() in cs35l56_hda_common_probe()
- Do not add mute_hook to struct hda_component. This was for use with
  CS8409 as an HDA bridge, but production systems will use Realtek,
  which has its own mute control.
- Use strscpy() instead of strcpy() in cs35l56_hda_mixer_info()
- Fix missing word in Kconfig option title

Richard Fitzgerald (4):
  ASoC: cs35l56: Move runtime suspend/resume to shared library
  ASoC: cs35l56: Move cs_dsp init into shared library
  ASoC: cs35l56: Move part of cs35l56_init() to shared library
  ALSA: hda: Fix missing header dependencies

Simon Trimmer (7):
  ASoC: cs35l56: Move shared data into a common data structure
  ASoC: cs35l56: Make cs35l56_system_reset() code more generic
  ASoC: cs35l56: Convert utility functions to use common data structure
  ASoC: cs35l56: Move utility functions to shared file
  ASoC: cs35l56: Make common function for control port wait
  ASoC: cs35l56: Make a common function to shutdown the DSP
  ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier

 include/sound/cs35l56.h           |  29 +-
 sound/pci/hda/Kconfig             |  31 +
 sound/pci/hda/Makefile            |   6 +
 sound/pci/hda/cs35l56_hda.c       | 995 ++++++++++++++++++++++++++++++
 sound/pci/hda/cs35l56_hda.h       |  48 ++
 sound/pci/hda/cs35l56_hda_i2c.c   |  69 +++
 sound/pci/hda/cs35l56_hda_spi.c   |  68 ++
 sound/pci/hda/hda_auto_parser.h   |   2 +
 sound/pci/hda/hda_generic.h       |   3 +
 sound/soc/codecs/cs35l56-i2c.c    |  14 +-
 sound/soc/codecs/cs35l56-sdw.c    |  72 +--
 sound/soc/codecs/cs35l56-shared.c | 458 +++++++++++++-
 sound/soc/codecs/cs35l56-spi.c    |  10 +-
 sound/soc/codecs/cs35l56.c        | 648 ++++---------------
 sound/soc/codecs/cs35l56.h        |  15 +-
 15 files changed, 1877 insertions(+), 591 deletions(-)
 create mode 100644 sound/pci/hda/cs35l56_hda.c
 create mode 100644 sound/pci/hda/cs35l56_hda.h
 create mode 100644 sound/pci/hda/cs35l56_hda_i2c.c
 create mode 100644 sound/pci/hda/cs35l56_hda_spi.c

-- 
2.30.2

