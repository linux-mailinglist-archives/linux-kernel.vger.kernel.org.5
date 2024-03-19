Return-Path: <linux-kernel+bounces-107209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D639787F92E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5181D1F24CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9454776;
	Tue, 19 Mar 2024 08:13:46 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3051C5F;
	Tue, 19 Mar 2024 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836025; cv=none; b=M/rsJPYpMOoYrA0fCXG+R9G1XFHesDCSyfKfpyAwvr3kS/Zdxelo9LX+5r3WCHI4krXQ9HH9YJO6dyErgu/1G7hfFOkssWS7zR6FOhFQMOTgQgW8wq5aVQZETr9CqHCXR7+hD0sxL1B+AGXf4cuGHUoQCLIawkRmY2qu9D5DvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836025; c=relaxed/simple;
	bh=Cfg2fyUpoz34fNpISMfbVM2+GwP0T6kAJZRDqAkkd8Q=;
	h=From:To:Subject:Date:Message-Id; b=Bp7vXQK3va6s+wom870/HuS1/cGX+hSQcZewVMWdRhn0Ayosp/L2T6MoWgpDdhppymKwY+Yn0nJFJS+WiPVHC1WtLJmnuQ79csF18rMZ7+zpWX9nk74W1M1HD1kooc/lWUD+Cx5QRdJ04FLg8O6p5qDjzYob78CPDLWDoeqhw3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F18F200292;
	Tue, 19 Mar 2024 09:07:49 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B9DB720136F;
	Tue, 19 Mar 2024 09:07:48 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AD5171820F76;
	Tue, 19 Mar 2024 16:07:46 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 00/16] Add audio support in v4l2 framework
Date: Tue, 19 Mar 2024 15:50:58 +0800
Message-Id: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

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

changes in v15:
- update MAINTAINERS for imx-asrc.c and vim2m-audio.c

changes in v14:
- document the reservation of 'AUXX' fourcc format.
- add v4l2_audfmt_to_fourcc() definition.

changes in v13
- change 'pixelformat' to 'audioformat' in dev-audio-mem2mem.rst
- add more description for clock drift in ext-ctrls-audio-m2m.rst
- Add "media: v4l2-ctrls: add support for fraction_bits" from Hans
  to avoid build issue for kernel test robot

changes in v12
- minor changes according to comments
- drop min_buffers_needed = 1 and V4L2_CTRL_FLAG_UPDATE flag
- drop bus_info

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

Hans Verkuil (1):
  media: v4l2-ctrls: add support for fraction_bits

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
 .../media/v4l/ext-ctrls-audio-m2m.rst         |   59 +
 .../userspace-api/media/v4l/pixfmt-audio.rst  |  100 ++
 .../userspace-api/media/v4l/pixfmt.rst        |    1 +
 .../media/v4l/vidioc-enum-fmt.rst             |    2 +
 .../media/v4l/vidioc-g-ext-ctrls.rst          |    4 +
 .../userspace-api/media/v4l/vidioc-g-fmt.rst  |    4 +
 .../media/v4l/vidioc-querycap.rst             |    3 +
 .../media/v4l/vidioc-queryctrl.rst            |   11 +-
 .../media/videodev2.h.rst.exceptions          |    3 +
 MAINTAINERS                                   |   17 +
 .../media/common/videobuf2/videobuf2-v4l2.c   |    4 +
 drivers/media/platform/nxp/Kconfig            |   13 +
 drivers/media/platform/nxp/Makefile           |    1 +
 drivers/media/platform/nxp/imx-asrc.c         | 1256 +++++++++++++++++
 drivers/media/test-drivers/Kconfig            |   10 +
 drivers/media/test-drivers/Makefile           |    1 +
 drivers/media/test-drivers/vim2m-audio.c      |  793 +++++++++++
 drivers/media/test-drivers/vivid/vivid-core.h |    2 +
 .../media/test-drivers/vivid/vivid-ctrls.c    |   26 +
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    9 +
 drivers/media/v4l2-core/v4l2-ctrls-api.c      |    1 +
 drivers/media/v4l2-core/v4l2-ctrls-core.c     |   93 +-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   10 +
 drivers/media/v4l2-core/v4l2-dev.c            |   21 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   66 +
 drivers/media/v4l2-core/v4l2-mem2mem.c        |   13 +-
 include/media/v4l2-ctrls.h                    |   13 +-
 include/media/v4l2-dev.h                      |    2 +
 include/media/v4l2-ioctl.h                    |   34 +
 .../fsl => include/sound}/fsl_asrc_common.h   |   60 +
 include/uapi/linux/media.h                    |    2 +
 include/uapi/linux/v4l2-controls.h            |    9 +
 include/uapi/linux/videodev2.h                |   50 +-
 sound/soc/fsl/fsl_asrc.c                      |  144 ++
 sound/soc/fsl/fsl_asrc.h                      |    4 +-
 sound/soc/fsl/fsl_asrc_dma.c                  |    2 +-
 sound/soc/fsl/fsl_easrc.c                     |  233 +++
 sound/soc/fsl/fsl_easrc.h                     |    6 +-
 43 files changed, 3145 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/dev-audio-mem2mem.rst
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.rst
 create mode 100644 drivers/media/platform/nxp/imx-asrc.c
 create mode 100644 drivers/media/test-drivers/vim2m-audio.c
 rename {sound/soc/fsl => include/sound}/fsl_asrc_common.h (60%)

-- 
2.34.1


