Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81FD81287C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443262AbjLNGuj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 01:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjLNGug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:50:36 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A15B7;
        Wed, 13 Dec 2023 22:50:37 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 26F88810C;
        Thu, 14 Dec 2023 14:50:30 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 14:50:30 +0800
Received: from ubuntu.mshome.net (113.72.145.168) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 14:50:27 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Marvin Lin" <milkfafa@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Ming Qian" <ming.qian@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>
Subject: [PATCH v1 0/9] Add ISP 3A support for StarFive
Date:   Wed, 13 Dec 2023 22:50:18 -0800
Message-ID: <20231214065027.28564-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.168]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FILL_THIS_FORM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements the ISP 3A function to the Camera Subsystem on StarFive
JH7110 SoC. The series has been tested on the VisionFive 2 board.

This series is based on top of the master branch of media_stage repository,
which is tested with a v4l2-compliance compiled from the git repo
(git://linuxtv.org/v4l-utils.git).

The following are the media graph for the device and the v4l2-compliance
output.

===========================================================================

[the media graph]:

digraph board {
        rankdir=TB
        n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1 | <port2> 2}}", shape=Mrecord, style=filled, fillcolor=green]
        n00000001:port1 -> n00000009
        n00000001:port2 -> n0000000d
        n00000005 [label="capture_raw\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
        n00000009 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
        n0000000d [label="capture_scd\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
        n00000015 [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n/dev/v4l-subdev1 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
        n00000015:port1 -> n00000001:port0
        n00000015:port1 -> n00000005 [style=dashed]
        n0000001f [label="{{} | imx219 6-0010\n/dev/v4l-subdev2 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
        n0000001f:port0 -> n00000015:port0 [style=bold]
}

[v4l2-compliance test]:

# v4l2-compliance -m /dev/media0
v4l2-compliance 1.27.0, 64 bits, 64-bit time_t

Compliance test for starfive-camss device /dev/media0:

Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0

Required ioctls:
        test MEDIA_IOC_DEVICE_INFO: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/media0 open: OK
        test MEDIA_IOC_DEVICE_INFO: OK
        test for unlimited opens: OK

Media Controller ioctls:
        test MEDIA_IOC_G_TOPOLOGY: OK
        Entities: 6 Interfaces: 6 Pads: 12 Links: 11
        test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
        test MEDIA_IOC_SETUP_LINK: OK

Total for starfive-camss device /dev/media0: 8, Succeeded: 8, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video0:

Driver Info:
        Driver name      : starfive-camss
        Card type        : Starfive Camera Subsystem
        Bus info         : platform:19840000.camss
        Driver version   : 6.7.0
        Capabilities     : 0xa4200001
                Video Capture
                I/O MC
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x24200001
                Video Capture
                I/O MC
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x03000007
        Type             : V4L Video
Entity Info:
        ID               : 0x00000005 (5)
        Name             : capture_raw
        Function         : V4L2 I/O
        Pad 0x01000006   : 0: Sink
          Link 0x0200001d: from remote pad 0x1000017 of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data

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
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
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
        test Scaling: OK

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video0: 47, Succeeded: 47, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video1:

Driver Info:
        Driver name      : starfive-camss
        Card type        : Starfive Camera Subsystem
        Bus info         : platform:19840000.camss
        Driver version   : 6.7.0
        Capabilities     : 0xa4200001
                Video Capture
                I/O MC
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x24200001
                Video Capture
                I/O MC
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x0300000b
        Type             : V4L Video
Entity Info:
        ID               : 0x00000009 (9)
        Name             : capture_yuv
        Function         : V4L2 I/O
        Pad 0x0100000a   : 0: Sink
          Link 0x02000011: from remote pad 0x1000003 of entity 'stf_isp' (Image Signal Processor): Data

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video1 open: OK
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
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
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
        test Scaling: OK

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video1: 47, Succeeded: 47, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video2:

Driver Info:
        Driver name      : starfive-camss
        Card type        : Starfive Camera Subsystem
        Bus info         : platform:19840000.camss
        Driver version   : 6.7.0
        Capabilities     : 0xa4a00000
                Metadata Capture
                I/O MC
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x24a00000
                Metadata Capture
                I/O MC
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x0300000f
        Type             : V4L Video
Entity Info:
        ID               : 0x0000000d (13)
        Name             : capture_scd
        Function         : V4L2 I/O
        Pad 0x0100000e   : 0: Sink
          Link 0x02000013: from remote pad 0x1000004 of entity 'stf_isp' (Image Signal Processor): Data

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video2 open: OK
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
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
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

Total for starfive-camss device /dev/video2: 47, Succeeded: 47, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev0:

Driver Info:
        Driver version   : 6.7.0
        Capabilities     : 0x00000000
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x03000023
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x00000001 (1)
        Name             : stf_isp
        Function         : Image Signal Processor
        Pad 0x0stf_isp: =================  START STATUS  =================
1000002   : 0: Sstf_isp: ==================  END STATUS  ==================
ink
          Link 0x0200001b: from remote pad 0x1000017 of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data
        Pad 0x01000003   : 1: Source
          Link 0x02000011: to remote pad 0x100000a of entity 'capture_yuv' (V4L2 I/O): Data
        Pad 0x01000004   : 2: Source
          Link 0x02000013: to remote pad 0x100000e of entity 'capture_scd' (V4L2 I/O): Data

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_SUDBEV_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/v4l-subdev0 open: OK
        test VIDIOC_SUBDEV_QUERYCAP: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Sub-Device ioctls (Sink Pad 0):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 1):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 2):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0
        Standard Compound Controls: 0 Private Compound Controls: 16

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK (Not Supported)
        test VIDIOC_TRY_FMT: OK (Not Supported)
        test VIDIOC_S_FMT: OK (Not Supported)
        test VIDIOC_G_SLICED_VBI_CAPcdns_csi2rx.19800000.csi-bridge: =================  START STATUS  =================
: OK (Ncdns_csi2rx.19800000.csi-bridge: ==================  END STATUS  ==================
ot Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK (Not Supported)
        test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev0: 66, Succeeded: 66, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev1:

Driver Info:
        Driver version   : 6.7.0
        Capabilities     : 0x00000000
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x03000025
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x00000015 (21)
        Name             : cdns_csi2rx.19800000.csi-bridge
        Function         : Video Interface Bridge
        Pad 0x01000016   : 0: Sink
          Link 0x02000021: from remote pad 0x1000020 of entity 'imx219 6-0010' (Camera Sensor): Data, Enabled, Immutable
        Pad 0x01000017   : 1: Source
          Link 0x0200001b: to remote pad 0x1000002 of entity 'stf_isp' (Image Signal Processor): Data
          Link 0x0200001d: to remote pad 0x1000006 of entity 'capture_raw' (V4L2 I/O): Data
        Pad 0x01000018   : 2: Source
        Pad 0x01000019   : 3: Source
        Pad 0x0100001a   : 4: Source

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_SUDBEV_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/v4l-subdev1 open: OK
        test VIDIOC_SUBDEV_QUERYCAP: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Sub-Device ioctls (Sink Pad 0):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 1):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 2):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 3):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 4):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK (Not Supported)
        test VIDIOC_TRY_FMT: OK (Not Supported)
        test VIDIOC_S_FMT: OK (Not Supported)
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK (Not Supported)
        test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev1: 80, Succeeded: 80, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev2:

Driver Info:
        Driver version   : 6.7.0
        Capabilities     : 0x00000000
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsysteimx219 6-0010: =================  START STATUS  =================
m
        Serial      imx219 6-0010: ==================  END STATUS  ==================
     :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x03000027
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x0000001f (31)
        Name             : imx219 6-0010
        Function         : Camera Sensor
        Pad 0x01000020   : 0: Source
          Link 0x02000021: to remote pad 0x1000016 of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data, Enabled, Immutable

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_SUDBEV_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/v4l-subdev2 open: OK
        test VIDIOC_SUBDEV_QUERYCAP: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Sub-Device ioctls (Source Pad 0):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
                warn: v4l2-test-subdevs.cpp(541): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
                warn: v4l2-test-subdevs.cpp(541): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 20 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK (Not Supported)
        test VIDIOC_TRY_FMT: OK (Not Supported)
        test VIDIOC_S_FMT: OK (Not Supported)
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK (Not Supported)
        test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev2: 52, Succeeded: 52, Failed: 0, Warnings: 2

Grand Total for starfive-camss device /dev/media0: 347, Succeeded: 347, Failed: 0, Warnings: 2

Two warnings are from the imx219, can ignore them.

Changhuang Liang (9):
  media: v4l2-ctrls: Add user controls for StarFive JH7110 ISP
  staging: media: starfive: camss: Add ISP controls
  media: videodev2.h, v4l2-ioctl: Add StarFive ISP meta buffer format
  staging: media: starfive: camss: Replace format index with pad
  staging: media: starfive: camss: Add for StarFive ISP 3A
  staging: media: starfive: camss: Update ISP initialise config for 3A
  staging: media: starfive: camss: Add V4L2_CAP_IO_MC capability
  staging: media: starfive: Add frame sync event for video capture
    device
  admin-guide: media: Update documents for StarFive Camera Subsystem

 .../admin-guide/media/starfive_camss.rst      |   9 +-
 .../media/starfive_camss_graph.dot            |  20 +-
 MAINTAINERS                                   |   1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
 .../staging/media/starfive/camss/stf-camss.c  |   8 +
 .../staging/media/starfive/camss/stf-camss.h  |   8 +
 .../media/starfive/camss/stf-capture.c        |  98 +++-
 .../media/starfive/camss/stf-isp-hw-ops.c     | 550 ++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.c    | 366 +++++++++++-
 .../staging/media/starfive/camss/stf-isp.h    | 179 ++++++
 .../staging/media/starfive/camss/stf-video.c  | 158 ++++-
 .../staging/media/starfive/camss/stf-video.h  |   2 +
 include/uapi/linux/jh7110-isp.h               | 342 +++++++++++
 include/uapi/linux/v4l2-controls.h            |   6 +
 include/uapi/linux/videodev2.h                |   3 +
 15 files changed, 1711 insertions(+), 40 deletions(-)
 create mode 100644 include/uapi/linux/jh7110-isp.h

--
2.25.1
