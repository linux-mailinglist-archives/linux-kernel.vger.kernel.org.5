Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56193760ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjGYGqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGYGqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:46:19 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A221B3;
        Mon, 24 Jul 2023 23:46:18 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 14BF31A161D;
        Tue, 25 Jul 2023 08:46:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CEC341A1614;
        Tue, 25 Jul 2023 08:46:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D18501800319;
        Tue, 25 Jul 2023 14:46:14 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
Date:   Tue, 25 Jul 2023 14:12:13 +0800
Message-Id: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio signal processing has the requirement for memory to
memory similar as Video.

This patch is to add this support in v4l2 framework, defined
new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
for audio case usage.

The created audio device is named "/dev/audioX".

And add memory to memory support for two kinds of i.MX ASRC
module

changes in v2:
- decouple the implementation in v4l2 and ALSA
- implement the memory to memory driver as a platfrom driver
  and move it to driver/media
- move fsl_asrc_common.h to include/sound folder

Shengjiu Wang (7):
  ASoC: fsl_asrc: define functions for memory to memory usage
  ASoC: fsl_easrc: define functions for memory to memory usage
  ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
  media: v4l2: Add audio capture and output support
  media: imx: fsl_asrc: Add memory to memory driver
  ASoC: fsl_asrc: register m2m platform device
  ASoC: fsl_easrc: register m2m platform device

 .../media/common/videobuf2/videobuf2-v4l2.c   |   4 +
 drivers/media/platform/nxp/Kconfig            |  12 +
 drivers/media/platform/nxp/Makefile           |   1 +
 drivers/media/platform/nxp/fsl_asrc_m2m.c     | 962 ++++++++++++++++++
 drivers/media/v4l2-core/v4l2-dev.c            |  17 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  52 +
 include/media/v4l2-dev.h                      |   2 +
 include/media/v4l2-ioctl.h                    |  34 +
 .../fsl => include/sound}/fsl_asrc_common.h   |  48 +
 include/uapi/linux/videodev2.h                |  19 +
 sound/soc/fsl/fsl_asrc.c                      | 150 +++
 sound/soc/fsl/fsl_asrc.h                      |   4 +-
 sound/soc/fsl/fsl_asrc_dma.c                  |   2 +-
 sound/soc/fsl/fsl_easrc.c                     | 227 +++++
 sound/soc/fsl/fsl_easrc.h                     |   8 +-
 15 files changed, 1539 insertions(+), 3 deletions(-)
 create mode 100644 drivers/media/platform/nxp/fsl_asrc_m2m.c
 rename {sound/soc/fsl => include/sound}/fsl_asrc_common.h (63%)

-- 
2.34.1

