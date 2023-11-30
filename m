Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545FB7FF856
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346302AbjK3Rbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjK3Rbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:31:45 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2CE10E4;
        Thu, 30 Nov 2023 09:31:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB54EE0007;
        Thu, 30 Nov 2023 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701365508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KR5nShstfQxSJuUb0FunRbFP+7crGVsxiHun0Bpfis4=;
        b=M7zYogQY/TMRTXapWM7ThUU4xq/iacM+eVH7fEuafMl2RtAnjdEbX2fFgEnvPK1jOQK7cO
        0kS0BoqNWCV6X9DIS8Fho89ygn2k0qoYjn9hN2kcEO7Yh6t3QCo/ztBilTzwc55J7nIBNE
        NzNX02MR89pK3/oCwVXie7Etw2oa1tzvg4eyuUMK4qNQKyH1MZmUrZEIezXrcBoWjBfQTV
        dGbLNFvx+sbHNvV60ODV/IxPZ/wh7uZGx1jbsxqe+d9zhH4VqmIrGrEJ/aQCAL3pXPwNto
        8a7g0I5RRLjIdF8XQ9gN1KTX5hKZauMEBuyn3gAN/hwYz2apdSH3mRRpbEtcgw==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com, michael.riesch@wolfvision.net,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH V12 0/3] media: rockchip: Add a driver for Rockchip's camera interface
Date:   Thu, 30 Nov 2023 18:31:43 +0100
Message-ID: <cover.1701364052.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

V12 for basic support of the Camera Interface found on the Rockchip PX30 SoC

Most of this driver was written following the BSP driver from rockchip,
removing the parts that either didn't fit correctly the guidelines, or
that couldn't be tested.

In the BSP, this driver is known as the "cif" driver, but this
controller was renamed to "vip" in the datasheet.

This version of the driver supports ONLY the parallel interface BT656
and was tested/implemented using an SDTV video decoder.

media_tree, base-commit: a00b3f296eac3d43328615c3113e1a74143fc67a

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
2.41.0

