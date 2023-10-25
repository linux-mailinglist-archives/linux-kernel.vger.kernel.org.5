Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E27D6067
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjJYDPI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 23:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjJYDOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:14:38 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84772137;
        Tue, 24 Oct 2023 20:14:32 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DDB3324E025;
        Wed, 25 Oct 2023 11:14:24 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 25 Oct
 2023 11:14:24 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 25 Oct
 2023 11:14:24 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <jack.zhu@starfivetech.com>, <changhuang.liang@starfivetech.com>
Subject: [PATCH v11 0/9] Add StarFive Camera Subsystem driver
Date:   Wed, 25 Oct 2023 11:14:13 +0800
Message-ID: <20231025031422.3695-1-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FILL_THIS_FORM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is the v11 series that attempts to support the Camera Subsystem
found on StarFive JH7110 SoC.

This series is based on top of the master branch of media_stage repository,
which is tested with a v4l2-compliance compiled from the git repo
(git://linuxtv.org/v4l-utils.git).

The following are the media graph for the device and the v4l2-compliance
output.

===========================================================================
[the media graph]:

digraph board {
	rankdir=TB
	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
	n00000001:port1 -> n00000008 [style=dashed]
	n00000004 [label="capture_raw\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
	n00000008 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
	n0000000e [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n/dev/v4l-subdev1 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
	n0000000e:port1 -> n00000001:port0 [style=dashed]
	n0000000e:port1 -> n00000004 [style=dashed]
	n00000018 [label="{{} | imx219 6-0010\n/dev/v4l-subdev2 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
	n00000018:port0 -> n0000000e:port0 [style=bold]
}

[the device topology]:

Media controller API version 6.6.0

Media device information
------------------------
driver          starfive-camss
model           Starfive Camera Subsystem
serial          
bus info        platform:19840000.camss
hw revision     0x0
driver version  6.6.0

Device topology
- entity 1: stf_isp (2 pads, 2 links, 0 routes)
            type V4L2 subdev subtype Unknown flags 0
            device node name /dev/v4l-subdev0
	pad0: Sink
		[stream:0 fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb
		 crop.bounds:(0,0)/1920x1080
		 crop:(0,0)/1920x1080]
		<- "cdns_csi2rx.19800000.csi-bridge":1 []
	pad1: Source
		[stream:0 fmt:YUYV8_1_5X8/1920x1080 field:none colorspace:srgb
		 crop.bounds:(0,0)/1920x1080
		 crop:(0,0)/1920x1080]
		-> "capture_yuv":0 []

- entity 4: capture_raw (1 pad, 1 link)
            type Node subtype V4L flags 0
            device node name /dev/video0
	pad0: Sink
		<- "cdns_csi2rx.19800000.csi-bridge":1 []

- entity 8: capture_yuv (1 pad, 1 link)
            type Node subtype V4L flags 0
            device node name /dev/video1
	pad0: Sink
		<- "stf_isp":1 []

- entity 14: cdns_csi2rx.19800000.csi-bridge (5 pads, 3 links, 0 routes)
             type V4L2 subdev subtype Unknown flags 0
             device node name /dev/v4l-subdev1
	pad0: Sink
		[stream:0 fmt:UYVY8_1X16/640x480 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:lim-range]
		<- "imx219 6-0010":0 [ENABLED,IMMUTABLE]
	pad1: Source
		[stream:0 fmt:UYVY8_1X16/640x480 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:lim-range]
		-> "stf_isp":0 []
		-> "capture_raw":0 []
	pad2: Source
		[stream:0 fmt:UYVY8_1X16/640x480 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:lim-range]
	pad3: Source
		[stream:0 fmt:UYVY8_1X16/640x480 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:lim-range]
	pad4: Source
		[stream:0 fmt:UYVY8_1X16/640x480 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:lim-range]

- entity 24: imx219 6-0010 (1 pad, 1 link, 0 routes)
             type V4L2 subdev subtype Sensor flags 0
             device node name /dev/v4l-subdev2
	pad0: Source
		[stream:0 fmt:SRGGB10_1X10/3280x2464 field:none colorspace:raw xfer:none ycbcr:601 quantization:full-range
		 crop.bounds:(8,8)/3280x2464
		 crop:(8,8)/3280x2464]
		-> "cdns_csi2rx.19800000.csi-bridge":0 [ENABLED,IMMUTABLE]

===========================================================================
[the v4l2-compliance output]:

------------
Test part 1:

v4l2-compliance 1.25.0, 64 bits, 64-bit time_t

Compliance test for starfive-camss device /dev/video1:

Driver Info:
	Driver name      : starfive-camss
	Card type        : Starfive Camera Subsystem
	Bus info         : platform:19840000.camss
	Driver version   : 6.6.0
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
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.6.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.6.0
Interface Info:
	ID               : 0x0300000a
	Type             : V4L Video
Entity Info:
	ID               : 0x00000008 (8)
	Name             : capture_yuv
	Function         : V4L2 I/O
	Pad 0x01000009   : 0: Sink
	  Link 0x0200000c: from remote pad 0x1000003 of entity 'stf_isp' (Image Signal Processor): Data, Enabled

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

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
	test VIDIOC_QUERYCTRL: OK (Not Supported)
	test VIDIOC_G/S_CTRL: OK (Not Supported)
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 0 Private Controls: 0

Format ioctls:
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

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Test input 0:

Streaming ioctls:
	test read/write: OK (Not Supported)
	test blocking wait: OK

	Video Capture: Frame #000
	Video Capture: Frame #001
	Video Capture: Frame #002
	Video Capture: Frame #003
	Video Capture: Frame #004
	Video Capture: Frame #005
	Video Capture: Frame #006
	Video Capture: Frame #007
	Video Capture: Frame #008
	Video Capture: Frame #009
	Video Capture: Frame #010
	Video Capture: Frame #011
	Video Capture: Frame #012
	Video Capture: Frame #013
	Video Capture: Frame #014
	Video Capture: Frame #015
	Video Capture: Frame #016
	Video Capture: Frame #017
	Video Capture: Frame #018
	Video Capture: Frame #019
	Video Capture: Frame #020
	Video Capture: Frame #021
	Video Capture: Frame #022
	Video Capture: Frame #023
	Video Capture: Frame #024
	Video Capture: Frame #025
	Video Capture: Frame #026
	Video Capture: Frame #027
	Video Capture: Frame #028
	Video Capture: Frame #029
	Video Capture: Frame #030
	Video Capture: Frame #031
	Video Capture: Frame #032
	Video Capture: Frame #033
	Video Capture: Frame #034
	Video Capture: Frame #035
	Video Capture: Frame #036
	Video Capture: Frame #037
	Video Capture: Frame #038
	Video Capture: Frame #039
	Video Capture: Frame #040
	Video Capture: Frame #041
	Video Capture: Frame #042
	Video Capture: Frame #043
	Video Capture: Frame #044
	Video Capture: Frame #045
	Video Capture: Frame #046
	Video Capture: Frame #047
	Video Capture: Frame #048
	Video Capture: Frame #049
	Video Capture: Frame #050
	Video Capture: Frame #051
	Video Capture: Frame #052
	Video Capture: Frame #053
	Video Capture: Frame #054
	Video Capture: Frame #055
	Video Capture: Frame #056
	Video Capture: Frame #057
	Video Capture: Frame #058
	Video Capture: Frame #059
	                                                  
	test MMAP (no poll): OK

	Video Capture: Frame #000 (select)
	Video Capture: Frame #001 (select)
	Video Capture: Frame #002 (select)
	Video Capture: Frame #003 (select)
	Video Capture: Frame #004 (select)
	Video Capture: Frame #005 (select)
	Video Capture: Frame #006 (select)
	Video Capture: Frame #007 (select)
	Video Capture: Frame #008 (select)
	Video Capture: Frame #009 (select)
	Video Capture: Frame #010 (select)
	Video Capture: Frame #011 (select)
	Video Capture: Frame #012 (select)
	Video Capture: Frame #013 (select)
	Video Capture: Frame #014 (select)
	Video Capture: Frame #015 (select)
	Video Capture: Frame #016 (select)
	Video Capture: Frame #017 (select)
	Video Capture: Frame #018 (select)
	Video Capture: Frame #019 (select)
	Video Capture: Frame #020 (select)
	Video Capture: Frame #021 (select)
	Video Capture: Frame #022 (select)
	Video Capture: Frame #023 (select)
	Video Capture: Frame #024 (select)
	Video Capture: Frame #025 (select)
	Video Capture: Frame #026 (select)
	Video Capture: Frame #027 (select)
	Video Capture: Frame #028 (select)
	Video Capture: Frame #029 (select)
	Video Capture: Frame #030 (select)
	Video Capture: Frame #031 (select)
	Video Capture: Frame #032 (select)
	Video Capture: Frame #033 (select)
	Video Capture: Frame #034 (select)
	Video Capture: Frame #035 (select)
	Video Capture: Frame #036 (select)
	Video Capture: Frame #037 (select)
	Video Capture: Frame #038 (select)
	Video Capture: Frame #039 (select)
	Video Capture: Frame #040 (select)
	Video Capture: Frame #041 (select)
	Video Capture: Frame #042 (select)
	Video Capture: Frame #043 (select)
	Video Capture: Frame #044 (select)
	Video Capture: Frame #045 (select)
	Video Capture: Frame #046 (select)
	Video Capture: Frame #047 (select)
	Video Capture: Frame #048 (select)
	Video Capture: Frame #049 (select)
	Video Capture: Frame #050 (select)
	Video Capture: Frame #051 (select)
	Video Capture: Frame #052 (select)
	Video Capture: Frame #053 (select)
	Video Capture: Frame #054 (select)
	Video Capture: Frame #055 (select)
	Video Capture: Frame #056 (select)
	Video Capture: Frame #057 (select)
	Video Capture: Frame #058 (select)
	Video Capture: Frame #059 (select)
	                                                  
	test MMAP (select): OK

	Video Capture: Frame #000 (epoll)
	Video Capture: Frame #001 (epoll)
	Video Capture: Frame #002 (epoll)
	Video Capture: Frame #003 (epoll)
	Video Capture: Frame #004 (epoll)
	Video Capture: Frame #005 (epoll)
	Video Capture: Frame #006 (epoll)
	Video Capture: Frame #007 (epoll)
	Video Capture: Frame #008 (epoll)
	Video Capture: Frame #009 (epoll)
	Video Capture: Frame #010 (epoll)
	Video Capture: Frame #011 (epoll)
	Video Capture: Frame #012 (epoll)
	Video Capture: Frame #013 (epoll)
	Video Capture: Frame #014 (epoll)
	Video Capture: Frame #015 (epoll)
	Video Capture: Frame #016 (epoll)
	Video Capture: Frame #017 (epoll)
	Video Capture: Frame #018 (epoll)
	Video Capture: Frame #019 (epoll)
	Video Capture: Frame #020 (epoll)
	Video Capture: Frame #021 (epoll)
	Video Capture: Frame #022 (epoll)
	Video Capture: Frame #023 (epoll)
	Video Capture: Frame #024 (epoll)
	Video Capture: Frame #025 (epoll)
	Video Capture: Frame #026 (epoll)
	Video Capture: Frame #027 (epoll)
	Video Capture: Frame #028 (epoll)
	Video Capture: Frame #029 (epoll)
	Video Capture: Frame #030 (epoll)
	Video Capture: Frame #031 (epoll)
	Video Capture: Frame #032 (epoll)
	Video Capture: Frame #033 (epoll)
	Video Capture: Frame #034 (epoll)
	Video Capture: Frame #035 (epoll)
	Video Capture: Frame #036 (epoll)
	Video Capture: Frame #037 (epoll)
	Video Capture: Frame #038 (epoll)
	Video Capture: Frame #039 (epoll)
	Video Capture: Frame #040 (epoll)
	Video Capture: Frame #041 (epoll)
	Video Capture: Frame #042 (epoll)
	Video Capture: Frame #043 (epoll)
	Video Capture: Frame #044 (epoll)
	Video Capture: Frame #045 (epoll)
	Video Capture: Frame #046 (epoll)
	Video Capture: Frame #047 (epoll)
	Video Capture: Frame #048 (epoll)
	Video Capture: Frame #049 (epoll)
	Video Capture: Frame #050 (epoll)
	Video Capture: Frame #051 (epoll)
	Video Capture: Frame #052 (epoll)
	Video Capture: Frame #053 (epoll)
	Video Capture: Frame #054 (epoll)
	Video Capture: Frame #055 (epoll)
	Video Capture: Frame #056 (epoll)
	Video Capture: Frame #057 (epoll)
	Video Capture: Frame #058 (epoll)
	Video Capture: Frame #059 (epoll)
	                                                  
	test MMAP (epoll): OK
	test USERPTR (no poll): OK (Not Supported)
	test USERPTR (select): OK (Not Supported)
	test DMABUF: Cannot test, specify --expbuf-device

Total for starfive-camss device /dev/video1: 53, Succeeded: 53, Failed: 0, Warnings: 0

------------
Please note that it has 2 warnings from imx219, which is not a submission
for this series.

Test part 2:

v4l2-compliance 1.25.0, 64 bits, 64-bit time_t

Compliance test for starfive-camss device /dev/media0:

Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.6.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.6.0

Required ioctls:
	test MEDIA_IOC_DEVICE_INFO: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/media0 open: OK
	test MEDIA_IOC_DEVICE_INFO: OK
	test for unlimited opens: OK

Media Controller ioctls:
	test MEDIA_IOC_G_TOPOLOGY: OK
	Entities: 5 Interfaces: 5 Pads: 10 Links: 9
	test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
	test MEDIA_IOC_SETUP_LINK: OK

Total for starfive-camss device /dev/media0: 8, Succeeded: 8, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video0:

Driver Info:
	Driver name      : starfive-camss
	Card type        : Starfive Camera Subsystem
	Bus info         : platform:19840000.camss
	Driver version   : 6.6.0
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
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.6.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.6.0
Interface Info:
	ID               : 0x03000006
	Type             : V4L Video
Entity Info:
	ID               : 0x00000004 (4)
	Name             : capture_raw
	Function         : V4L2 I/O
	Pad 0x01000005   : 0: Sink
	  Link 0x02000016: from remote pad 0x1000010 of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data

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

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
	test VIDIOC_QUERYCTRL: OK (Not Supported)
	test VIDIOC_G/S_CTRL: OK (Not Supported)
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 0 Private Controls: 0

Format ioctls:
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

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video0: 46, Succeeded: 46, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video1:

Driver Info:
	Driver name      : starfive-camss
	Card type        : Starfive Camera Subsystem
	Bus info         : platform:19840000.camss
	Driver version   : 6.6.0
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
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.6.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.6.0
Interface Info:
	ID               : 0x0300000a
	Type             : V4L Video
Entity Info:
	ID               : 0x00000008 (8)
	Name             : capture_yuv
	Function         : V4L2 I/O
	Pad 0x01000009   : 0: Sink
	  Link 0x0200000c: from remote pad 0x1000003 of entity 'stf_isp' (Image Signal Processor): Data

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

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
	test VIDIOC_QUERYCTRL: OK (Not Supported)
	test VIDIOC_G/S_CTRL: OK (Not Supported)
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 0 Private Controls: 0

Format ioctls:
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

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev0:

Driver Info:
	Driver version   : 6.6.0
	Capabilities     : 0x00000000
Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.6.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.6.0
Interface Info:
	ID               : 0x0300001c
	Type             : V4L Sub-Device
Entity Info:
	ID               : 0x00000001 (1)
	Name             : stf_isp
	Function         : Image Signal Processor
	Pad 0x01000002   : 0: Sink
	  Link 0x02000014: from remote pad 0x1000010 of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data
	Pad 0x01000003   : 1: Source
	  Link 0x0200000c: to remote pad 0x1000009 of entity 'capture_yuv' (V4L2 I/O): Data

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
	test VIDIOC_EXPBUF: OK (Not Supported)
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev0: 58, Succeeded: 58, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev1:

Driver Info:
	Driver version   : 6.6.0
	Capabilities     : 0x00000000
Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.6.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.6.0
Interface Info:
	ID               : 0x0300001e
	Type             : V4L Sub-Device
Entity Info:
	ID               : 0x0000000e (14)
	Name             : cdns_csi2rx.19800000.csi-bridge
	Function         : Video Interface Bridge
	Pad 0x0100000f   : 0: Sink
	  Link 0x0200001a: from remote pad 0x1000019 of entity 'imx219 6-0010' (Camera Sensor): Data, Enabled, Immutable
	Pad 0x01000010   : 1: Source
	  Link 0x02000014: to remote pad 0x1000002 of entity 'stf_isp' (Image Signal Processor): Data
	  Link 0x02000016: to remote pad 0x1000005 of entity 'capture_raw' (V4L2 I/O): Data
	Pad 0x01000011   : 2: Source
	Pad 0x01000012   : 3: Source
	Pad 0x01000013   : 4: Source

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
	test VIDIOC_EXPBUF: OK (Not Supported)
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev1: 79, Succeeded: 79, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev2:

Driver Info:
	Driver version   : 6.6.0
	Capabilities     : 0x00000000
Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.6.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.6.0
Interface Info:
	ID               : 0x03000020
	Type             : V4L Sub-Device
Entity Info:
	ID               : 0x00000018 (24)
	Name             : imx219 6-0010
	Function         : Camera Sensor
	Pad 0x01000019   : 0: Source
	  Link 0x0200001a: to remote pad 0x100000f of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data, Enabled, Immutable

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
		warn: ../utils/v4l2-compliance/v4l2-test-subdevs.cpp(541): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
		warn: ../utils/v4l2-compliance/v4l2-test-subdevs.cpp(541): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
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
	test VIDIOC_EXPBUF: OK (Not Supported)
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev2: 51, Succeeded: 51, Failed: 0, Warnings: 2

Grand Total for starfive-camss device /dev/media0: 288, Succeeded: 288, Failed: 0, Warnings: 2

===========================================================================
Changes in v11:
- Tested the driver with a v4l2-compliance compiled from the git repo
  (git://linuxtv.org/v4l-utils.git).
- Rebased on top of the master branch of media_stage repository.
- Fixed a smatch warning.

v10 link: https://lore.kernel.org/all/20231008085154.6757-1-jack.zhu@starfivetech.com/

Changes in v10:
- Tested the driver with a v4l2-compliance compiled from the git repo
  (git://linuxtv.org/v4l-utils.git).
- Rebased on top of the master branch of media_stage repository.

v9 link: https://lore.kernel.org/all/20230914031607.34877-1-jack.zhu@starfivetech.com/

Changes in v9:
- Rebased on top of the master branch of media_stage repository.
- Renamed file name.
- Added of_node_put(node) in the error handling path of
  stfcamss_of_parse_ports().

v8 link: https://lore.kernel.org/all/20230824080109.89613-1-jack.zhu@starfivetech.com/

Changes in v8:
- Rebased on v6.5-rc7.
- Dropped VIN subdev.
- Created two new video devices: capture_raw and capture_yuv, to replace
  the previous video devices.
- Dropped VB2_READ io methods.
- Recursively called .s_stream() on subdevs.

v7 link: https://lore.kernel.org/all/20230619112838.19797-1-jack.zhu@starfivetech.com/

Changes in v7:
- HAS_DMA is used instead of DMA_CMA in Kconfig.
- Dropped some non-essential member variables.
- Used v4l2_async_nf_add_fwnode_remote() to simplify the relevant code.
- Modified some Local variable types in the function.
- Used v4l2_create_fwnode_links_to_pad() to simplify the relevant code.
- Added error handling for clk_prepare_enable().
- Simplified stfcamss_format_info struct and modified the relevant code.
- Dropped enum_input, g_input and s_input.
- Unified v4l2_ioctl_ops struct.
- Used v4l2_fh_open()/vb2_fop_release to replace deprecated APIs.
- Added a camss directory under the starfive directory and modified the
  patch title.

v6 link: https://lore.kernel.org/all/20230525083202.67933-1-jack.zhu@starfivetech.com/

Changes in v6:
- Added 'bus-type' in bindings example.
- Corrected spelling errors.
- As reviewed by Bryan, used 'nclks' and 'nrsts' variables.
- Added lccf config for ISP.

v5 link: https://lore.kernel.org/all/20230512102844.51084-1-jack.zhu@starfivetech.com/

Changes in v5:
- Rebased on v6.4-rc1.
- Added new patch.
- Modified ISP driver.

v4 link: https://lore.kernel.org/all/20230413035541.62129-1-jack.zhu@starfivetech.com/

Previous cover letter from v4:

This patch series adds support for the StarFive Camera Subsystem
found on StarFive JH7110 SoC.

The driver implements V4L2, Media controller and V4L2 subdev interfaces.
Camera sensor using V4L2 subdev interface in the kernel is supported.

The driver is tested on VisionFive V2 board with IMX219 camera sensor.
GStreamer 1.18.5 with v4l2src plugin is supported.

Previous version link, missing v1 version:

  v3: https://lore.kernel.org/all/20230331121826.96973-1-jack.zhu@starfivetech.com/
  v2: https://lore.kernel.org/all/20230310120553.60586-1-jack.zhu@starfivetech.com/

Jack Zhu (9):
  media: dt-bindings: Add JH7110 Camera Subsystem
  media: admin-guide: Add starfive_camss.rst for Starfive Camera
    Subsystem
  media: staging: media: starfive: camss: Add core driver
  media: staging: media: starfive: camss: Add video driver
  media: staging: media: starfive: camss: Add ISP driver
  media: staging: media: starfive: camss: Add capture driver
  media: staging: media: starfive: camss: Add interrupt handling
  media: staging: media: starfive: camss: Register devices
  media: staging: media: starfive: camss: Add TODO file

 .../admin-guide/media/starfive_camss.rst      |  72 +++
 .../media/starfive_camss_graph.dot            |  12 +
 .../admin-guide/media/v4l-drivers.rst         |   1 +
 .../bindings/media/starfive,jh7110-camss.yaml | 180 ++++++
 MAINTAINERS                                   |   9 +
 drivers/staging/media/Kconfig                 |   2 +
 drivers/staging/media/Makefile                |   1 +
 drivers/staging/media/starfive/Kconfig        |   5 +
 drivers/staging/media/starfive/Makefile       |   2 +
 drivers/staging/media/starfive/camss/Kconfig  |  17 +
 drivers/staging/media/starfive/camss/Makefile |  13 +
 drivers/staging/media/starfive/camss/TODO.txt |   4 +
 .../staging/media/starfive/camss/stf-camss.c  | 436 +++++++++++++
 .../staging/media/starfive/camss/stf-camss.h  | 134 ++++
 .../media/starfive/camss/stf-capture.c        | 603 ++++++++++++++++++
 .../media/starfive/camss/stf-capture.h        |  87 +++
 .../media/starfive/camss/stf-isp-hw-ops.c     | 445 +++++++++++++
 .../staging/media/starfive/camss/stf-isp.c    | 382 +++++++++++
 .../staging/media/starfive/camss/stf-isp.h    | 428 +++++++++++++
 .../staging/media/starfive/camss/stf-video.c  | 572 +++++++++++++++++
 .../staging/media/starfive/camss/stf-video.h  | 100 +++
 21 files changed, 3505 insertions(+)
 create mode 100644 Documentation/admin-guide/media/starfive_camss.rst
 create mode 100644 Documentation/admin-guide/media/starfive_camss_graph.dot
 create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
 create mode 100644 drivers/staging/media/starfive/Kconfig
 create mode 100644 drivers/staging/media/starfive/Makefile
 create mode 100644 drivers/staging/media/starfive/camss/Kconfig
 create mode 100644 drivers/staging/media/starfive/camss/Makefile
 create mode 100644 drivers/staging/media/starfive/camss/TODO.txt
 create mode 100644 drivers/staging/media/starfive/camss/stf-camss.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-camss.h
 create mode 100644 drivers/staging/media/starfive/camss/stf-capture.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-capture.h
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp.h
 create mode 100644 drivers/staging/media/starfive/camss/stf-video.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-video.h

-- 
2.34.1

