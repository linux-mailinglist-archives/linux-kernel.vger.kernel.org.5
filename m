Return-Path: <linux-kernel+bounces-60918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5948A850AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5C01C211D4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0BE5D73B;
	Sun, 11 Feb 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFibo63T"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA45C614;
	Sun, 11 Feb 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678220; cv=none; b=GIjDtfipVcOfshW2z3H6jpct1XD9CYsRTFtiOuRXRnxI9HTwRuPmCIzh7Fag9aSoIM9ORp2vR8bqBIvXb5i93WW7JAl7Jq1zJfv8mJrvTCjvdojhVbwA0SX9qnXD7V4LaJNudDcf9xVa49ATvMhb27rsXW/Lzn3/IBTciHS1PcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678220; c=relaxed/simple;
	bh=RaMOKViQvaxJtvgQTzlSoori+uRspHW/M54NbGK1onc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTZzDfHta0N67sb1kEh67m9IgqiRW8UEAKke0y9Ail7vi4G5r9Aq7LjwW4gbgFf5jNgl5n0ddNL06vrLTnSCx7H+grUtFNKXB32eA56NMG6JUYOlgKUcmWjr38Sta7zgGt9cHVES4cCy7C0NMXy0I6e8plO6WuGOJgssxSVXv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFibo63T; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116b017503so3453039e87.1;
        Sun, 11 Feb 2024 11:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707678216; x=1708283016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hpuvQnI/8Udj+lSLZ3SiKEf5/ByRcVcriKwAxCSZqQ=;
        b=mFibo63T/QmeZlyfMQX6j3qMgVmMCCJGM7bwrHrYnav8X0ole8hMIDtm5p9wI3L4+L
         Mc29yZ30iqaudjyWlcE2N2wVNzeKVrmkB8WRBbnpVOiKeaLYtJucmrs+RZMREamHSJtN
         P6gIp/GHWW80N2A4aU8KLPjuM2XJQOUcNDI3ksdl9oRZSwixvE619svUcggUYmIglu6K
         X6Ii+sxhRHQshiymtiKmHeoTkDYyQdLY4IPKY25vQNQIWe+nkBuLa3xPsh2MxxmqVlEW
         8KryQooRAWKQ/0A6BIWWvNGJr5S8zOxECh4WY8eCAyZXlQKlF5Sqmv1rU2+cI+6zVjsi
         k6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707678216; x=1708283016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hpuvQnI/8Udj+lSLZ3SiKEf5/ByRcVcriKwAxCSZqQ=;
        b=i1J1yji8/AJ2ddXsYRTtxqLtIjRHtkM8fM7q64f1RPO9XQGfCVjhBLSYBRZ9TIgFRt
         2OEOisxqoUkc118AbEC4q3UMM65wFs1HiPe4pB5vG/1vWpf7E2AIX2grGCst8RFC73DM
         7WhF0hj9Ihc8TDpCLf50rLV/IF1qgd1FNNAJw9VkFKBgIHRIYd++61MewGX99OdlmLpV
         SuJYH7fCGErIubNxcBzVrhKDZCmunyFc1j88uJwj+XuYzCED54SLi1EY6+DXqJFrpmaG
         1COuADbolk8dVqg+dK3zuidpGLnhd6PoYA6PkEj/MSDofO8KrkkQ4sy9xrPNEiiHhs7h
         A3iA==
X-Gm-Message-State: AOJu0Yxvexp//6EbRENDBXLqghlF3ypKL2oiw1wqpHteYvB/oRusT2GQ
	GFZdpKfiqBAcm8gizjQEGPC40yYx8IO1jqsa58BZxQERSh+uUwmy
X-Google-Smtp-Source: AGHT+IH8AuAyQu9K/mPXSAgMfMgDsu33CODUNfJmHSk6MSYoV5aIZTKnl5AegbHcnIXzsl5yr2Zwaw==
X-Received: by 2002:ac2:4eca:0:b0:511:6a0b:cd3 with SMTP id p10-20020ac24eca000000b005116a0b0cd3mr2727742lfr.57.1707678216124;
        Sun, 11 Feb 2024 11:03:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5gGdj2LBWiW7m95osvu5pacmInkvYap4LODRBfqk0J+tmWaszmtpBjTmEgILx1W3vWIyuX4pgmomgBhLNBk1eHIApDKdT/NYqB72AxyeK0wEzSuc49E4jnC/Ln1PGJhmz42OArfuT/WMdYggQ6d9sUlcxhi5nKM/dnEDO/Ad+dri6BXgh5B1If+9KsEi3GVOEEOEV0yPzb4tWT5Wp/IlKIYMxWpV/1+ilqRv52CPo52yHQCAQGt32oK/TdtRl4DbyZfZLeJkMsDMKQw/nCz0+l+8pecVTbwAg0EvayJt/oqLOTBTHKf51nzXjHzt+ZDAxLot33HxUnJLBopJFhbMvuGfC4+upNfWBca7jgz5QVaxDP/UeOyyvfxuYYQcPXaMiZVe8hJUlWf1eMuU66PCeOe5sYAPUk2TzvO5h2S4yFJ2XSlSUIjhGeoniE83O6jajoGkngqWX2w6QZ9iNCSJH2QX7vOSfZT/qBAk1ZholA1JQrgsAfXO7au/rm2K3LqxMfAWh7ZTtac0aTk4M0H0u3/oN4ZKypnhsKVi2Ty8OCPKrgz6HXYkl2Mu3USZZtsf76zvCGA==
Received: from localhost.localdomain ([2a02:8109:aa27:2d00::2d2b])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a3c5fa1052csm1207400ejb.138.2024.02.11.11.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 11:03:35 -0800 (PST)
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: mchehab@kernel.org,
	heiko@sntech.de,
	hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com,
	paul.kocialkowski@bootlin.com,
	michael.riesch@wolfvision.net,
	laurent.pinchart@ideasonboard.com,
	Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [RESEND Patch v13 0/3] media: rockchip: Add a driver for Rockchip's camera interface
Date: Sun, 11 Feb 2024 20:03:29 +0100
Message-ID: <cover.1707677804.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

V13 for basic support of the Camera Interface found on the Rockchip PX30 SoC

Most of this driver was written following the BSP driver from rockchip,
removing the parts that either didn't fit correctly the guidelines, or
that couldn't be tested.

In the BSP, this driver is known as the "cif" driver, but this
controller was renamed to "vip" in the datasheet.

This version of the driver supports ONLY the parallel interface BT656
and was tested/implemented using an SDTV video decoder.

media_stage, base-commit: 8c64f4cdf4e6cc5682c52523713af8c39c94e6d5

V12 => V13:
cif/cif-capture.c
- changed the vb2_queue member min_buffer_needed to min_queued_buffers

V11 => V12:
cif/cif-capture.c cif/cif-dev.c cif/cif-common.h cif/cif-capture.h:
- changed the name of the files to add "cif-"
- made use of the reset array in the pmruntime suspend and resume
  functions
- made the subdev stop before the cif in cif_stop_streaming()
- removed pinctrl_pm_select_sleep_state()
- removed cif_soft_reset()
- changed the dt-binding filename in the MAINTAINERS file
- removed remote_info->mbus
rockchip,px30-vip.yaml:
- removed the undocumented compatible in the example

V10 => V11:
cif/capture.c cif/dev.c cif/common.h cif/capture.h:
- removed the csi_fmt_val and all the CSI reg defines
- removed the setting of buffer numbers in the queue_setup vb2_ops
  callback
- changed the v4l2_fwnode_endpoint declaration to V4L2_MBUS_UNKNOWN:
  letting the device tree decide which bus is being used
- split dev.h into common.h and capture.h

rockchip,px30-vip.yaml:
- renamed rockchip,rk3066-cif.yaml back to rockchip,px30-vip.yaml as
  suggested by Conor
- added the description of the port's endpoint bus-type property
- extended the example to include the definition of the corresponding
  video-decoder

V9 => V10:
cif/capture.c cif/dev.c cif/dev.h:
as suggested by Paul:
- ensured that the lock is still being held when accessing
  stream->buffs[0,1]
- adjusted the comment explaining why the spinlock is used

as suggested by Michael:
- made the IRQ requested SHARED: the cif shares the IRQ with the io_mmu

rockchip,rk3066-cif.yaml:
- dropped the rk3066-cif compatible but kept the name and added the
  reason for this in the commit msg: the name of the file rk3066 is the first
  Rockchip SoC generation that uses cif instead of the px30 which is just one
  of the many iterations of the unit.

V8 => V9:
cif/capture.c cif/dev.c cif/dev.h:
as suggested by Paul:
- changed the name from "vip" back to "cif"
- removed the scratch buffer and added frame dropping
- removed mplane, only single plane formats are supported anyway
- adjusted the Kconfig
- added the match_data to the stream struct
- some cosmetics, and error return codes changes

as suggested by Michael:
- changed the writel and readl helpers to be inline functions and
  changed the name
- fixed typos in the commit message
- changed the cif_device struct element "sensor" to "remote"

rockchip,rk3066-cif.yaml:
- changed the compatible rockchip,px30-vip to rockchip,rk3066-cif:
  rk3066 is the earliest Rockchip SoC that uses cif and it is the
  first model starting the RK30 lineup.
- changed the node name to video-capture
- adjusted the description

V7 => V8:
vip/capture.c:
- fixed a warning: unused variable reported by the kernel test robot

V6 => V7:
vip/capture.c vip/dev.c vip/dev.h
- renamed all struct rk_vip_dev dev => struct rk_vip_dev vip_dev
- added some error when rk_vip_get_buffer() returns NULL
- removed a WARN_ON
- made the irq NOT shared
- dropped of_match_ptr
- added the rk_vip_get_resource() function

rockchip,px30-vip.yaml:
- changed filename to match the compatible
- dropped the mention of the other rockchip SoC in the dt-binding
  description and added a more detailed description of VIP
- removed unused labels in the example

V5[1] => V6:
vip/capture.c vip/dev.c vip/dev.h
- added a video g_input_status subdev call, V4L2_IN_CAP_STD and the
  supported stds in rk_vip_enum_input callback
- added rk_vip_g_std, rk_vip_s_std and rk_vip_querystd callbacks
- added the supported video_device->tvnorms
- s_std will now update the format as this depends on the standard
  NTSC/PAL (as suggested by Hans in [1])
- removed STD_ATSC
- moved the colorimetry information to come from the subdev
- removed the core s_power subdev calls
- dropped cropping in rk_vip_stream struct

rockchip-vip.yaml:
- fixed a mistake in the name of third clock plckin -> plck
- changed the reg maxItems 2 -> 1

[1] https://lore.kernel.org/linux-media/20201229161724.511102-1-maxime.chevallier@bootlin.com/

I used v4l-utils with HEAD: commit db9478a91120dccc18d1388fe9b812567e33b6bb

# v4l2-compliance 
v4l2-compliance 1.27.0, 64 bits, 64-bit time_t

Compliance test for rockchip-cif device /dev/video0:

Driver Info:
        Driver name      : rockchip-cif
        Card type        : rockchip-cif
        Bus info         : platform:ff490000.video-capture
        Driver version   : 6.7.0
        Capabilities     : 0x84200001
                Video Capture
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04200001
                Video Capture
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : rockchip-cif
        Model            : cif
        Serial           : 
        Bus info         : platform:ff490000.video-capture
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x03000003
        Type             : V4L Video
Entity Info:
        ID               : 0x00000001 (1)
        Name             : rockchip_cif
        Function         : V4L2 I/O
        Pad 0x01000002   : 0: Sink
          Link 0x02000009: from remote pad 0x1000006 of entity 'tw9900 2-0044' (Digital Video Decoder): Data, Enabled

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 1 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls (Input 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls (Input 0):
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for rockchip-cif device /dev/video0: 47, Succeeded: 47, Failed: 0, Warnings: 0

Mehdi Djait (3):
  media: dt-bindings: media: add bindings for Rockchip CIF
  media: rockchip: Add a driver for Rockchip's camera interface
  arm64: dts: rockchip: Add the px30 camera interface

 .../bindings/media/rockchip,px30-vip.yaml     |  123 ++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/rockchip/px30.dtsi        |   12 +
 drivers/media/platform/rockchip/Kconfig       |    1 +
 drivers/media/platform/rockchip/Makefile      |    1 +
 drivers/media/platform/rockchip/cif/Kconfig   |   14 +
 drivers/media/platform/rockchip/cif/Makefile  |    3 +
 .../media/platform/rockchip/cif/cif-capture.c | 1111 +++++++++++++++++
 .../media/platform/rockchip/cif/cif-capture.h |   20 +
 .../media/platform/rockchip/cif/cif-common.h  |  128 ++
 drivers/media/platform/rockchip/cif/cif-dev.c |  308 +++++
 .../media/platform/rockchip/cif/cif-regs.h    |  127 ++
 12 files changed, 1855 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
 create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
 create mode 100644 drivers/media/platform/rockchip/cif/Makefile
 create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.c
 create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.h
 create mode 100644 drivers/media/platform/rockchip/cif/cif-common.h
 create mode 100644 drivers/media/platform/rockchip/cif/cif-dev.c
 create mode 100644 drivers/media/platform/rockchip/cif/cif-regs.h

-- 
2.43.0


