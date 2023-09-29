Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420EE7B2FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjI2KIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjI2KId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:08:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C67C0;
        Fri, 29 Sep 2023 03:08:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 618121BF20E;
        Fri, 29 Sep 2023 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695982108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AjPO62EH//YFUWvJKiXxAinthCQFtLyrypziXtQJIf0=;
        b=NEUpMGd70slgCjICACDBbtzJqKg9v0nZd0XxFJ429Al5VXejRamwAwdvayubwz74fpjuIO
        YFsBuqa07xOTRU8Z1tNtWHqPv9l8g1+BBv5+yfLwP2CXZ7b2gnCohWRNztnzdF8EV1zRZC
        0NvxMt8wYNvlTwKQPZuFK+oHKIchXDkT7LC4S0HZHzE/jtPsO6CM8OJfd7CX1lRBnPWao5
        lgGLdatYv3V46kUnfxb+wpQ9TrZDHJjyr6SaYkmgwy/spSmUS7Hh15UUgH/wpevWha8sJY
        Y9vYSNSE3yonAcrISVmsZ0JUufw0TcTjeDKlx7HJ9gFQ4DauZqCn/LkEOod7eQ==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, ezequiel@vanguardiasur.com.ar,
        hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     paul.kocialkowski@bootlin.com, miquel.raynal@bootlin.com,
        maxime.chevallier@bootlin.com, luca.ceresoli@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v6 0/3] media: rockchip: Add a driver for Rockchip's camera interface
Date:   Fri, 29 Sep 2023 12:07:59 +0200
Message-ID: <cover.1695981374.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URI_HEX autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This series is based on the fifth iteration of the series introducing the
rockchip vip driver for the PX30 camera interface: sent 29 Dec 2020 [1]

Most of this driver was written following the BSP driver from rockchip,
removing the parts that either didn't fit correctly the guidelines, or
that couldn't be tested.

In the BSP, this driver is known as the "cif" driver, but this was
renamed to "vip" to better fit the controller denomination in the
datasheet.

This version of the driver supports ONLY the parallel interface BT656
and was tested/implemented using an SDTV video decoder

base-commit: 2c1bae27df787c9535e48cc27bbd11c3c3e0a235

Changes since fifth iteration in [1]:

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

I used v4l-utils with HEAD: commit 1ee258e5bb91a12df378e19eb255c5219d6bc36b

# v4l2-compliance  
v4l2-compliance 1.25.0, 64 bits, 64-bit time_t

Compliance test for rk_vip device /dev/video0:

Driver Info:
        Driver name      : rk_vip
        Card type        : rk_vip
        Bus info         : platform:ff490000.vip
        Driver version   : 6.6.0
        Capabilities     : 0x84201000
                Video Capture Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04201000
                Video Capture Multiplanar
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : rk_vip
        Model            : rk_vip
        Serial           : 
        Bus info         : platform:ff490000.vip
        Media version    : 6.6.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.6.0
Interface Info:
        ID               : 0x03000002
        Type             : V4L Video
Entity Info:
        ID               : 0x00000001 (1)
        Name             : video_rkvip
        Function         : V4L2 I/O
        Pad 0x01000004   : 0: Sink
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
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for rk_vip device /dev/video0: 46, Succeeded: 46, Failed: 0, Warnings: 0

Mehdi Djait (3):
  media: dt-bindings: media: add rockchip-vip
  media: rockchip: Add a driver for Rockhip's camera interface
  arm64: dts: rockchip: Add the camera interface

Mehdi Djait (3):
  media: dt-bindings: media: add rockchip-vip
  media: rockchip: Add a driver for Rockhip's camera interface
  arm64: dts: rockchip: Add the camera interface

 .../bindings/media/rockchip-vip.yaml          |   91 ++
 arch/arm64/boot/dts/rockchip/px30.dtsi        |   12 +
 drivers/media/platform/rockchip/Kconfig       |    1 +
 drivers/media/platform/rockchip/Makefile      |    1 +
 drivers/media/platform/rockchip/vip/Kconfig   |   14 +
 drivers/media/platform/rockchip/vip/Makefile  |    3 +
 drivers/media/platform/rockchip/vip/capture.c | 1197 +++++++++++++++++
 drivers/media/platform/rockchip/vip/dev.c     |  332 +++++
 drivers/media/platform/rockchip/vip/dev.h     |  163 +++
 drivers/media/platform/rockchip/vip/regs.h    |  260 ++++
 10 files changed, 2074 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-vip.yaml
 create mode 100644 drivers/media/platform/rockchip/vip/Kconfig
 create mode 100644 drivers/media/platform/rockchip/vip/Makefile
 create mode 100644 drivers/media/platform/rockchip/vip/capture.c
 create mode 100644 drivers/media/platform/rockchip/vip/dev.c
 create mode 100644 drivers/media/platform/rockchip/vip/dev.h
 create mode 100644 drivers/media/platform/rockchip/vip/regs.h

-- 
2.41.0

