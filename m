Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCBC7F3F77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjKVIEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjKVIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:04:00 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE72D77;
        Wed, 22 Nov 2023 00:03:55 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EBDC1A1662;
        Wed, 22 Nov 2023 09:03:54 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A1DE1A1672;
        Wed, 22 Nov 2023 09:03:54 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2149B181D0E2;
        Wed, 22 Nov 2023 16:03:52 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v11 00/15] Add audio support in v4l2 framework
Date:   Wed, 22 Nov 2023 15:23:43 +0800
Message-Id: <1700637838-6743-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio signal processing also has the requirement for memory to
memory similar as Video.

This asrc memory to memory (memory ->asrc->memory) case is a non
real time use case.

User fills the input buffer to the asrc module, after conversion, then asrc
sends back the output buffer to user. So it is not a traditional ALSA playback
and capture case.

It is a specific use case,  there is no reference in current kernel.
v4l2 memory to memory is the closed implementation,  v4l2 current
support video, image, radio, tuner, touch devices, so it is not
complicated to add support for this specific audio case.

Because we had implemented the "memory -> asrc ->i2s device-> codec"
use case in ALSA.  Now the "memory->asrc->memory" needs
to reuse the code in asrc driver, so the first 3 patches is for refining
the code to make it can be shared by the "memory->asrc->memory"
driver.

The main change is in the v4l2 side, A /dev/vl4-audioX will be created,
user applications only use the ioctl of v4l2 framework.

Other change is to add memory to memory support for two kinds of i.MX ASRC
module.

changes in v11
- add add-fixed-point-test-controls in vivid.
- add v4l2_ctrl_fp_compose() helper function for min and max

changes in v10
- remove FIXED_POINT type
- change code base on media: v4l2-ctrls: add support for fraction_bits
- fix issue reported by kernel test robot
- remove module_alias

changes in v9:
- add MEDIA_ENT_F_PROC_AUDIO_RESAMPLER.
- add MEDIA_INTF_T_V4L_AUDIO
- add media controller support
- refine the vim2m-audio to support 8k<->16k conversion.

changes in v8:
- refine V4L2_CAP_AUDIO_M2M to be 0x00000008
- update doc for FIXED_POINT
- address comments for imx-asrc

changes in v7:
- add acked-by from Mark
- separate commit for fixed point, m2m audio class, audio rate controls
- use INTEGER_MENU for rate,  FIXED_POINT for rate offset
- remove used fmts
- address other comments for Hans

changes in v6:
- use m2m_prepare/m2m_unprepare/m2m_start/m2m_stop to replace
  m2m_start_part_one/m2m_stop_part_one, m2m_start_part_two/m2m_stop_part_two.
- change V4L2_CTRL_TYPE_ASRC_RATE to V4L2_CTRL_TYPE_FIXED_POINT
- fix warning by kernel test rebot
- remove some unused format V4L2_AUDIO_FMT_XX
- Get SNDRV_PCM_FORMAT from V4L2_AUDIO_FMT in driver.
- rename audm2m to viaudm2m.

changes in v5:
- remove V4L2_AUDIO_FMT_LPCM
- define audio pixel format like V4L2_AUDIO_FMT_S8...
- remove rate and format in struct v4l2_audio_format.
- Add V4L2_CID_ASRC_SOURCE_RATE and V4L2_CID_ASRC_DEST_RATE controls
- updata document accordingly.

changes in v4:
- update document style
- separate V4L2_AUDIO_FMT_LPCM and V4L2_CAP_AUDIO_M2M in separate commit

changes in v3:
- Modify documents for adding audio m2m support
- Add audio virtual m2m driver
- Defined V4L2_AUDIO_FMT_LPCM format type for audio.
- Defined V4L2_CAP_AUDIO_M2M capability type for audio m2m case.
- with modification in v4l-utils, pass v4l2-compliance test.

changes in v2:
- decouple the implementation in v4l2 and ALSA
- implement the memory to memory driver as a platfrom driver
  and move it to driver/media
- move fsl_asrc_common.h to include/sound folder

Shengjiu Wang (15):
  ASoC: fsl_asrc: define functions for memory to memory usage
  ASoC: fsl_easrc: define functions for memory to memory usage
  ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
  ASoC: fsl_asrc: register m2m platform device
  ASoC: fsl_easrc: register m2m platform device
  media: uapi: Add V4L2_CAP_AUDIO_M2M capability flag
  media: v4l2: Add audio capture and output support
  media: uapi: Define audio sample format fourcc type
  media: uapi: Add V4L2_CTRL_CLASS_M2M_AUDIO
  media: uapi: Add audio rate controls support
  media: uapi: Declare interface types for Audio
  media: uapi: Add an entity type for audio resampler
  media: vivid: add fixed point test controls
  media: imx-asrc: Add memory to memory driver
  media: vim2m-audio: add virtual driver for audio memory to memory

 .../media/mediactl/media-types.rst            |   11 +
 .../userspace-api/media/v4l/buffer.rst        |    6 +
 .../userspace-api/media/v4l/common.rst        |    1 +
 .../media/v4l/dev-audio-mem2mem.rst           |   71 +
 .../userspace-api/media/v4l/devices.rst       |    1 +
 .../media/v4l/ext-ctrls-audio-m2m.rst         |   41 +
 .../userspace-api/media/v4l/pixfmt-audio.rst  |   87 ++
 .../userspace-api/media/v4l/pixfmt.rst        |    1 +
 .../media/v4l/vidioc-enum-fmt.rst             |    2 +
 .../media/v4l/vidioc-g-ext-ctrls.rst          |    4 +
 .../userspace-api/media/v4l/vidioc-g-fmt.rst  |    4 +
 .../media/v4l/vidioc-querycap.rst             |    3 +
 .../media/videodev2.h.rst.exceptions          |    3 +
 .../media/common/videobuf2/videobuf2-v4l2.c   |    4 +
 drivers/media/platform/nxp/Kconfig            |   13 +
 drivers/media/platform/nxp/Makefile           |    1 +
 drivers/media/platform/nxp/imx-asrc.c         | 1264 +++++++++++++++++
 drivers/media/test-drivers/Kconfig            |   11 +
 drivers/media/test-drivers/Makefile           |    1 +
 drivers/media/test-drivers/vim2m-audio.c      |  799 +++++++++++
 drivers/media/test-drivers/vivid/vivid-core.h |    2 +
 .../media/test-drivers/vivid/vivid-ctrls.c    |   26 +
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    9 +
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   10 +
 drivers/media/v4l2-core/v4l2-dev.c            |   21 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   66 +
 drivers/media/v4l2-core/v4l2-mem2mem.c        |   13 +-
 include/media/v4l2-ctrls.h                    |    3 +
 include/media/v4l2-dev.h                      |    2 +
 include/media/v4l2-ioctl.h                    |   34 +
 .../fsl => include/sound}/fsl_asrc_common.h   |   60 +
 include/uapi/linux/media.h                    |    2 +
 include/uapi/linux/v4l2-controls.h            |    9 +
 include/uapi/linux/videodev2.h                |   41 +
 sound/soc/fsl/fsl_asrc.c                      |  144 ++
 sound/soc/fsl/fsl_asrc.h                      |    4 +-
 sound/soc/fsl/fsl_asrc_dma.c                  |    2 +-
 sound/soc/fsl/fsl_easrc.c                     |  233 +++
 sound/soc/fsl/fsl_easrc.h                     |    6 +-
 39 files changed, 3008 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/dev-audio-mem2mem.rst
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.rst
 create mode 100644 drivers/media/platform/nxp/imx-asrc.c
 create mode 100644 drivers/media/test-drivers/vim2m-audio.c
 rename {sound/soc/fsl => include/sound}/fsl_asrc_common.h (60%)

-- 
2.34.1

