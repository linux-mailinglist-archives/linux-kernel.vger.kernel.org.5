Return-Path: <linux-kernel+bounces-163530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACDC8B6CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47C5284051
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690707D414;
	Tue, 30 Apr 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oGO4Jd4S"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C157302;
	Tue, 30 Apr 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465277; cv=none; b=PlynkSoIBZPowaecMaOjjXfkBPgW5KIp5L92Y6dvRnUr0BN6A2SRo9jlCvqhikIS5bL+igLERcLkgWyNAycVm/2Ka98HkAlAzkjOwmNNpRfZphpIl9cwJAOaBdX+AQ6fQjkuDm69s+6wUMDRHprsaD+vh5DBMn/IybPtL9wBw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465277; c=relaxed/simple;
	bh=8b4Gnndyad1mrZWfMetavaSAHiPqy+zPx9M7fgKKgek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNf5ocBTuGygHF+xT7+PN12fx8p8e0mu0+sknEMUOOKXQqt4x0SfjiV+anDq/wO5dsvOCz0M3NHRRDXM1Wx9SI2byQx8lqhpz3IbEpAiuIneiphkQr7HM51NKhhDLKVuofFjR23lknGn9CQlE0ZNLRUeRdQcII6lu1HmEtTAwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oGO4Jd4S; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714465273;
	bh=8b4Gnndyad1mrZWfMetavaSAHiPqy+zPx9M7fgKKgek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGO4Jd4SOKQiaoB8atG3rgvkDKLRGwZB6mMWzBylCM3oG+VkatSVLj+F2kOCRzdQN
	 URC2FyKbjdfMA3OyF1emR79RqnHlQJymnEXC40eMBqrhQ5rVcEGWg6Iu/I3w0d8Q8X
	 9gkMiOH81JqNAxUOBfNtWODd7kN4/MKr7Mg581cDmqEFGsMjbdJ4MV5cLzVK9wwkRS
	 VAs5lAy7DtX6QhM/i8yw8ox2E2LU4im+wjMZz3oNPykOn1oeJv62Mp82og8wRbIZLd
	 sFyMYJE0nq4pXhzDGEBaSHhirTZEzDif9ktGKos7JBotVF2r0mUIXjx1+O3pBXEdHi
	 qfoYhRxctGICg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A2E54378134F;
	Tue, 30 Apr 2024 08:21:13 +0000 (UTC)
Date: Tue, 30 Apr 2024 10:21:12 +0200
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
	m.szyprowski@samsung.com, mchehab@kernel.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
Message-ID: <20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>

Hey Shengjiu,

first of all thanks for all of this work and I am very sorry for only
emerging this late into the series, I sadly didn't notice it earlier.

I would like to voice a few concerns about the general idea of adding
Audio support to the Media subsystem.

1. The biggest objection is, that the Linux Kernel has a subsystem
specifically targeted for audio devices, adding support for these
devices in another subsystem are counterproductive as they work around
the shortcomings of the audio subsystem while forcing support for a
device into a subsystem that was never designed for such devices.
Instead, the audio subsystem has to be adjusted to be able to support
all of the required workflows, otherwise, the next audio driver with
similar requirements will have to move to the media subsystem as well,
the audio subsystem would then never experience the required change and
soon we would have two audio subsystems.

2. Closely connected to the previous objection, the media subsystem with
its current staff of maintainers is overworked and barely capable of
handling the workload, which includes an abundance of different devices
from DVB, codecs, cameras, PCI devices, radio tuners, HDMI CEC, IR
receivers, etc. Adding more device types to this matrix will make the
situation worse and should only be done with a plan for how first to
improve the current maintainer situation.

3. By using the same framework and APIs as the video codecs, the audio
codecs are going to cause extra work for the video codec developers and
maintainers simply by occupying the same space that was orginally
designed for the purpose of video only. Even if you try to not cause any
extra stress the simple presence of the audio code in the codebase is
going to cause restrictions.

The main issue here is that the audio subsystem doesn't provide a
mem2mem framework and I would say you are in luck because the media
subsystem has gathered a lot of shortcomings with its current
implementation of the mem2mem framework over time, which is why a new
implementation will be necessary anyway.

So instead of hammering a driver into the wrong destination, I would
suggest bundling our forces and implementing a general memory-to-memory
framework that both the media and the audio subsystem can use, that
addresses the current shortcomings of the implementation and allows you
to upload the driver where it is supposed to be.
This is going to cause restrictions as well, like mentioned in the
concern number 3, but with the difference that we can make a general
plan for such a framework that accomodates lots of use cases and each
subsystem can add their routines on top of the general framework.

Another possible alternative is to try and make the DRM scheduler more
generally available, this scheduler is the most mature and in fact is
very similar to what you and what the media devices need.
Which again just shows how common your usecase actually is and how a
general solution is the best long term solution.

Please notice that Daniel Almeida is currently working on something
related to this:
https://lore.kernel.org/linux-media/3F80AC0D-DCAA-4EDE-BF58-BB1369C7EDCA@collabora.com/T/#u

If the toplevel maintainers decide to add the patchset so be it, but I
wanted to voice my concerns and also highlight that this is likely going
to cause extra stress for the video codecs maintainers and the
maintainers in general. We cannot spend a lot of time on audio codecs,
as video codecs already fill up our available time sufficiently,
so the use of the framework needs to be conservative and cause as little
extra work as possible for the original use case of the framework.

Regards,
Sebastian

On 19.03.2024 15:50, Shengjiu Wang wrote:
>Audio signal processing also has the requirement for memory to
>memory similar as Video.
>
>This asrc memory to memory (memory ->asrc->memory) case is a non
>real time use case.
>
>User fills the input buffer to the asrc module, after conversion, then asrc
>sends back the output buffer to user. So it is not a traditional ALSA playback
>and capture case.
>
>It is a specific use case,  there is no reference in current kernel.
>v4l2 memory to memory is the closed implementation,  v4l2 current
>support video, image, radio, tuner, touch devices, so it is not
>complicated to add support for this specific audio case.
>
>Because we had implemented the "memory -> asrc ->i2s device-> codec"
>use case in ALSA.  Now the "memory->asrc->memory" needs
>to reuse the code in asrc driver, so the first 3 patches is for refining
>the code to make it can be shared by the "memory->asrc->memory"
>driver.
>
>The main change is in the v4l2 side, A /dev/vl4-audioX will be created,
>user applications only use the ioctl of v4l2 framework.
>
>Other change is to add memory to memory support for two kinds of i.MX ASRC
>module.
>
>changes in v15:
>- update MAINTAINERS for imx-asrc.c and vim2m-audio.c
>
>changes in v14:
>- document the reservation of 'AUXX' fourcc format.
>- add v4l2_audfmt_to_fourcc() definition.
>
>changes in v13
>- change 'pixelformat' to 'audioformat' in dev-audio-mem2mem.rst
>- add more description for clock drift in ext-ctrls-audio-m2m.rst
>- Add "media: v4l2-ctrls: add support for fraction_bits" from Hans
>  to avoid build issue for kernel test robot
>
>changes in v12
>- minor changes according to comments
>- drop min_buffers_needed = 1 and V4L2_CTRL_FLAG_UPDATE flag
>- drop bus_info
>
>changes in v11
>- add add-fixed-point-test-controls in vivid.
>- add v4l2_ctrl_fp_compose() helper function for min and max
>
>changes in v10
>- remove FIXED_POINT type
>- change code base on media: v4l2-ctrls: add support for fraction_bits
>- fix issue reported by kernel test robot
>- remove module_alias
>
>changes in v9:
>- add MEDIA_ENT_F_PROC_AUDIO_RESAMPLER.
>- add MEDIA_INTF_T_V4L_AUDIO
>- add media controller support
>- refine the vim2m-audio to support 8k<->16k conversion.
>
>changes in v8:
>- refine V4L2_CAP_AUDIO_M2M to be 0x00000008
>- update doc for FIXED_POINT
>- address comments for imx-asrc
>
>changes in v7:
>- add acked-by from Mark
>- separate commit for fixed point, m2m audio class, audio rate controls
>- use INTEGER_MENU for rate,  FIXED_POINT for rate offset
>- remove used fmts
>- address other comments for Hans
>
>changes in v6:
>- use m2m_prepare/m2m_unprepare/m2m_start/m2m_stop to replace
>  m2m_start_part_one/m2m_stop_part_one, m2m_start_part_two/m2m_stop_part_two.
>- change V4L2_CTRL_TYPE_ASRC_RATE to V4L2_CTRL_TYPE_FIXED_POINT
>- fix warning by kernel test rebot
>- remove some unused format V4L2_AUDIO_FMT_XX
>- Get SNDRV_PCM_FORMAT from V4L2_AUDIO_FMT in driver.
>- rename audm2m to viaudm2m.
>
>changes in v5:
>- remove V4L2_AUDIO_FMT_LPCM
>- define audio pixel format like V4L2_AUDIO_FMT_S8...
>- remove rate and format in struct v4l2_audio_format.
>- Add V4L2_CID_ASRC_SOURCE_RATE and V4L2_CID_ASRC_DEST_RATE controls
>- updata document accordingly.
>
>changes in v4:
>- update document style
>- separate V4L2_AUDIO_FMT_LPCM and V4L2_CAP_AUDIO_M2M in separate commit
>
>changes in v3:
>- Modify documents for adding audio m2m support
>- Add audio virtual m2m driver
>- Defined V4L2_AUDIO_FMT_LPCM format type for audio.
>- Defined V4L2_CAP_AUDIO_M2M capability type for audio m2m case.
>- with modification in v4l-utils, pass v4l2-compliance test.
>
>changes in v2:
>- decouple the implementation in v4l2 and ALSA
>- implement the memory to memory driver as a platfrom driver
>  and move it to driver/media
>- move fsl_asrc_common.h to include/sound folder
>
>Hans Verkuil (1):
>  media: v4l2-ctrls: add support for fraction_bits
>
>Shengjiu Wang (15):
>  ASoC: fsl_asrc: define functions for memory to memory usage
>  ASoC: fsl_easrc: define functions for memory to memory usage
>  ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
>  ASoC: fsl_asrc: register m2m platform device
>  ASoC: fsl_easrc: register m2m platform device
>  media: uapi: Add V4L2_CAP_AUDIO_M2M capability flag
>  media: v4l2: Add audio capture and output support
>  media: uapi: Define audio sample format fourcc type
>  media: uapi: Add V4L2_CTRL_CLASS_M2M_AUDIO
>  media: uapi: Add audio rate controls support
>  media: uapi: Declare interface types for Audio
>  media: uapi: Add an entity type for audio resampler
>  media: vivid: add fixed point test controls
>  media: imx-asrc: Add memory to memory driver
>  media: vim2m-audio: add virtual driver for audio memory to memory
>
> .../media/mediactl/media-types.rst            |   11 +
> .../userspace-api/media/v4l/buffer.rst        |    6 +
> .../userspace-api/media/v4l/common.rst        |    1 +
> .../media/v4l/dev-audio-mem2mem.rst           |   71 +
> .../userspace-api/media/v4l/devices.rst       |    1 +
> .../media/v4l/ext-ctrls-audio-m2m.rst         |   59 +
> .../userspace-api/media/v4l/pixfmt-audio.rst  |  100 ++
> .../userspace-api/media/v4l/pixfmt.rst        |    1 +
> .../media/v4l/vidioc-enum-fmt.rst             |    2 +
> .../media/v4l/vidioc-g-ext-ctrls.rst          |    4 +
> .../userspace-api/media/v4l/vidioc-g-fmt.rst  |    4 +
> .../media/v4l/vidioc-querycap.rst             |    3 +
> .../media/v4l/vidioc-queryctrl.rst            |   11 +-
> .../media/videodev2.h.rst.exceptions          |    3 +
> MAINTAINERS                                   |   17 +
> .../media/common/videobuf2/videobuf2-v4l2.c   |    4 +
> drivers/media/platform/nxp/Kconfig            |   13 +
> drivers/media/platform/nxp/Makefile           |    1 +
> drivers/media/platform/nxp/imx-asrc.c         | 1256 +++++++++++++++++
> drivers/media/test-drivers/Kconfig            |   10 +
> drivers/media/test-drivers/Makefile           |    1 +
> drivers/media/test-drivers/vim2m-audio.c      |  793 +++++++++++
> drivers/media/test-drivers/vivid/vivid-core.h |    2 +
> .../media/test-drivers/vivid/vivid-ctrls.c    |   26 +
> drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    9 +
> drivers/media/v4l2-core/v4l2-ctrls-api.c      |    1 +
> drivers/media/v4l2-core/v4l2-ctrls-core.c     |   93 +-
> drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   10 +
> drivers/media/v4l2-core/v4l2-dev.c            |   21 +
> drivers/media/v4l2-core/v4l2-ioctl.c          |   66 +
> drivers/media/v4l2-core/v4l2-mem2mem.c        |   13 +-
> include/media/v4l2-ctrls.h                    |   13 +-
> include/media/v4l2-dev.h                      |    2 +
> include/media/v4l2-ioctl.h                    |   34 +
> .../fsl => include/sound}/fsl_asrc_common.h   |   60 +
> include/uapi/linux/media.h                    |    2 +
> include/uapi/linux/v4l2-controls.h            |    9 +
> include/uapi/linux/videodev2.h                |   50 +-
> sound/soc/fsl/fsl_asrc.c                      |  144 ++
> sound/soc/fsl/fsl_asrc.h                      |    4 +-
> sound/soc/fsl/fsl_asrc_dma.c                  |    2 +-
> sound/soc/fsl/fsl_easrc.c                     |  233 +++
> sound/soc/fsl/fsl_easrc.h                     |    6 +-
> 43 files changed, 3145 insertions(+), 27 deletions(-)
> create mode 100644 Documentation/userspace-api/media/v4l/dev-audio-mem2mem.rst
> create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> create mode 100644 drivers/media/platform/nxp/imx-asrc.c
> create mode 100644 drivers/media/test-drivers/vim2m-audio.c
> rename {sound/soc/fsl => include/sound}/fsl_asrc_common.h (60%)
>
>-- 
>2.34.1
>
>

