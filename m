Return-Path: <linux-kernel+bounces-36028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18259839A56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC773287056
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2114A3B;
	Tue, 23 Jan 2024 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa8QQeYw"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F220F1;
	Tue, 23 Jan 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042171; cv=none; b=OKEFa8Nlfq6VgIYLqGDMcvwKyOHgfPt3HyNUIhkY9grMugOFiDEOE8nzINWkI7bKsTmRA/QfD2/+o0aDHDBpg6cpgt0mijO8E97f3AsTpWCx5LlTUl8hFQL1CnQxHLL80PC0/JvU6r78rfAWfWrTgOIircUZ8qqRlLSLm3mYW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042171; c=relaxed/simple;
	bh=O5CIiUnbnq8G9L5gMqM8QaO+j6skLvv0R5QXDcyKMo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JE7G+ZP4Qor1FVADVk3l6Sq4DNCYHkOOpcS8Xgzy11Nh1liIT43bMDrE2hMKM0806OWCOc/bSEMMnu2oxIrCpFeIRuHyoHoSD8FTSD49V25pbluqgGQj+q+i7GmYft/8yv0/zhiCwCyuBzjFpJhQlzFmj7+lS6lQZ7gPStPLlW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa8QQeYw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a684acf92so5195116a12.0;
        Tue, 23 Jan 2024 12:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706042168; x=1706646968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+TzSvQNMpSTnBKy6zx8XfJfhzL54PAsuJ/g7mPOB4NE=;
        b=fa8QQeYwUlBeeK2kycPYgt4ixWhpoCSU7q5vlhKbH31WP1PLAvQIDlw2FdVLQsrf0o
         7Xzayr0J6CeuLgMfKwgDMBrp7T5VLi1NMt0SWyT1Zwp1SzHjt2NgNu9ctl0oWBUvU5fB
         Pd58ugy+eD44wWzS4Iyerf6ZF59W3doYCcscDZpYWQAAZPkGHwdjmxd6cmEZjx1Y+bZ4
         5/x/HBWMU7MShQJ0HDjEaNWhrF/ekBtXgGTGNFvwBbuzIw5Pbhrqh/VEEN3v1+/mCO5+
         cc45fMCR9BxYgjgMFox5dorddUXCvSQlggZKWWqBNeP8Od4WZR55mDh9ZBQdqwsZ/sBq
         krwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042168; x=1706646968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TzSvQNMpSTnBKy6zx8XfJfhzL54PAsuJ/g7mPOB4NE=;
        b=FswCUG7uArqtUPui7otdS8DvayLVzEOgxkHHuwfvLXitArUsP27VwXh2mN+1AEoBdL
         Mv95GkvAUrz1aPQimJqM1eFE6zdevb7f4HNRGiSiYUfb33sBI1Syyl8ihLosGjfB7znq
         DnJhsPPE+Cf+zJ+UyY4OWJcPbX2gmP6I9tCuUDlGeNbVsZrmXPBXOqRGxQHACCbT+Jxe
         2FR6O1Vw8Idz+jhqVUbb0iD5XHWM6CgndwLHkIBpJlez2sDCX8pWUcn1TSV5KPXgD7/E
         UOaz1diNE5Tkmk9eO1FViBCZsnnX5kJwx7/TEVGa7gADushwNofMNBKsOCW5FDQh99eM
         pWFA==
X-Gm-Message-State: AOJu0YwLjD81tW/4d3j7tgaWvxTX9Y9GOxe8HoSIggWi0Epdm1mg0Qvg
	kLy3nrYqaWsoV831rV2TvmCxSYi4Wp14geK3ie3OGw4wpB8NXkjGL5if/d94
X-Google-Smtp-Source: AGHT+IG3N1vkd41bKi/0F3hRMmaBSzTDu/lcOmO2GzrDyurJK+U1SHcV1kivigxqUIb05H5E7Nhk+A==
X-Received: by 2002:a50:cd02:0:b0:55c:2492:7294 with SMTP id z2-20020a50cd02000000b0055c24927294mr817576edi.59.1706042168058;
        Tue, 23 Jan 2024 12:36:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:aa27:2d00::d069])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c95a000000b005590dc6a4f6sm13227886edt.80.2024.01.23.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:36:07 -0800 (PST)
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
Subject: [PATCH v13 0/3] media: rockchip: Add a driver for Rockchip's camera interface
Date: Tue, 23 Jan 2024 21:36:01 +0100
Message-ID: <cover.1706041950.git.mehdi.djait.k@gmail.com>
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

media_stage, base-commit: eba5e4075505b758fb36967e83ba43d4b994a2e0

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


