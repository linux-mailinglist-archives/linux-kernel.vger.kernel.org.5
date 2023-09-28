Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823D67B15C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjI1IMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1IMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:12:36 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F295;
        Thu, 28 Sep 2023 01:12:30 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 472597FFE;
        Thu, 28 Sep 2023 16:12:29 +0800 (CST)
Received: from EXMBX173.cuchost.com (172.16.6.93) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Sep
 2023 16:12:29 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX173.cuchost.com
 (172.16.6.93) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Sep
 2023 16:12:28 +0800
Message-ID: <705f6143-169d-907e-9453-a5b384f921cd@starfivetech.com>
Date:   Thu, 28 Sep 2023 16:12:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 0/8] Add StarFive Camera Subsystem driver
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        "bryan.odonoghue@linaro.org" <bryan.odonoghue@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "Changhuang Liang" <changhuang.liang@starfivetech.com>
References: <20230914031607.34877-1-jack.zhu@starfivetech.com>
 <11735008-1adf-4b84-9023-d295371caed5@xs4all.nl>
Content-Language: en-US
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <11735008-1adf-4b84-9023-d295371caed5@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX173.cuchost.com
 (172.16.6.93)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/15 17:26, Hans Verkuil wrote:
> On 14/09/2023 05:15, Jack Zhu wrote:
>> Hi,
>> 
>> This series is the v9 series that attempts to support the Camera Subsystem
>> found on StarFive JH7110 SoC.
>> 
>> This series is based on top of the master branch of media_stage repository.
>> 
>> The following are the media graph for the device and the v4l2-compliance
>> output.
>> 
>> ===========================================================================
>> [the media graph]:
>> 
>> digraph board {
>> 	rankdir=TB
>> 	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
>> 	n00000001:port1 -> n00000008 [style=dashed]
>> 	n00000004 [label="capture_raw\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
>> 	n00000008 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
>> 	n0000000e [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
>> 	n0000000e:port1 -> n00000001:port0 [style=dashed]
>> 	n0000000e:port1 -> n00000004 [style=dashed]
>> 	n00000018 [label="{{} | imx219 6-0010\n/dev/v4l-subdev1 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
>> 	n00000018:port0 -> n0000000e:port0 [style=bold]
>> }
>> 
>> [the device topology]:
>> 
>> Media controller API version 6.5.0
>> 
>> Media device information
>> ------------------------
>> driver          starfive-camss
>> model           Starfive Camera Subsystem
>> serial          
>> bus info        platform:19840000.camss
>> hw revision     0x0
>> driver version  6.5.0
>> 
>> Device topology
>> - entity 1: stf_isp (2 pads, 2 links)
>>             type V4L2 subdev subtype Unknown flags 0
>>             device node name /dev/v4l-subdev0
>> 	pad0: Sink
>> 		[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb
>> 		 crop.bounds:(0,0)/1920x1080
>> 		 crop:(0,0)/1920x1080]
>> 		<- "cdns_csi2rx.19800000.csi-bridge":1 []
>> 	pad1: Source
>> 		[fmt:YUYV8_1_5X8/1920x1080 field:none colorspace:srgb
>> 		 crop.bounds:(0,0)/1920x1080
>> 		 crop:(0,0)/1920x1080]
>> 		-> "capture_yuv":0 []
>> 
>> - entity 4: capture_raw (1 pad, 1 link)
>>             type Node subtype V4L flags 0
>>             device node name /dev/video0
>> 	pad0: Sink
>> 		<- "cdns_csi2rx.19800000.csi-bridge":1 []
>> 
>> - entity 8: capture_yuv (1 pad, 1 link)
>>             type Node subtype V4L flags 0
>>             device node name /dev/video1
>> 	pad0: Sink
>> 		<- "stf_isp":1 []
>> 
>> - entity 14: cdns_csi2rx.19800000.csi-bridge (5 pads, 3 links)
>>              type V4L2 subdev subtype Unknown flags 0
>> 	pad0: Sink
>> 		<- "imx219 6-0010":0 [ENABLED,IMMUTABLE]
>> 	pad1: Source
>> 		-> "stf_isp":0 []
>> 		-> "capture_raw":0 []
>> 	pad2: Source
>> 	pad3: Source
>> 	pad4: Source
>> 
>> - entity 24: imx219 6-0010 (1 pad, 1 link)
>>              type V4L2 subdev subtype Sensor flags 0
>>              device node name /dev/v4l-subdev1
>> 	pad0: Source
>> 		[fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:full-range
>> 		 crop.bounds:(8,8)/3280x2464
>> 		 crop:(8,8)/3280x2464]
>> 		-> "cdns_csi2rx.19800000.csi-bridge":0 [ENABLED,IMMUTABLE]
>> 
>> ===========================================================================
>> [the v4l2-compliance output]:
>> 
>> v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
> 
> This v4l2-compliance version is from a distro. For driver acceptance you
> must test with a v4l2-compliance compiled from the git repo (git://linuxtv.org/v4l-utils.git).
> 
> Also, since this driver uses the media controller, you must run v4l2-compliance
> with the -m /dev/mediaX option. This will test the compliance of all devices
> reported by the media controller.
> 
>> 
>> Compliance test for stf camss device /dev/video1:
>> 
>> Driver Info:
>> 	Driver name      : stf camss
> 
> The module is called starfive-camss, so shouldn't the driver name reported here
> be the same?
> 
>> 	Card type        : Starfive Camera Subsystem
>> 	Bus info         : platform:19840000.camss
>> 	Driver version   : 6.5.0
>> 	Capabilities     : 0x84200001
>> 		Video Capture
>> 		Streaming
>> 		Extended Pix Format
>> 		Device Capabilities
>> 	Device Caps      : 0x04200001
>> 		Video Capture
>> 		Streaming
>> 		Extended Pix Format
>> Media Driver Info:
>> 	Driver name      : starfive-camss
> 
> It's correct in the media controller information.
> 
>> 	Model            : Starfive Camera Subsystem
>> 	Serial           : 
>> 	Bus info         : platform:19840000.camss
>> 	Media version    : 6.5.0
>> 	Hardware revision: 0x00000000 (0)
>> 	Driver version   : 6.5.0
>> Interface Info:
>> 	ID               : 0x0300000a
>> 	Type             : V4L Video
>> Entity Info:
>> 	ID               : 0x00000008 (8)
>> 	Name             : capture_yuv
>> 	Function         : V4L2 I/O
>> 	Pad 0x01000009   : 0: Sink
>> 	  Link 0x0200000c: from remote pad 0x1000003 of entity 'stf_isp' (Unknown Function (00004009)): Data, Enabled
> 
> Hmm, this reports "Unknown Function". I bet that when you run v4l2-compliance
> with the -m option it will fail on this. If not, then that's likely a bug in
> the compliance test, please let me know if that's the case.
> 

Hi Hans,

The following is the latest test log, which does not report a failure, but
also reports "Unknown Function".

I make the following settings in the stf-isp.c file:
v4l2_subdev.entity.function = MEDIA_ENT_F_PROC_VIDEO_ISP;

# 
# v4l2-compliance -m /dev/media0
v4l2-compliance 1.25.0, 64 bits, 64-bit time_t

Compliance test for starfive-camss device /dev/media0:

Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.5.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.5.0

Required ioctls:
	test MEDIA_IOC_DEVICE_INFO: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/media0 open: OK
	test MEDIA_IOC_DEVICE_INFO: OK
	test for unlimited opens: OK

Media Controller ioctls:
	test MEDIA_IOC_G_TOPOLOGY: OK
	Entities: 5 Interfaces: 4 Pads: 10 Links: 8
	test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
	test MEDIA_IOC_SETUP_LINK: OK

Total for starfive-camss device /dev/media0: 8, Succeeded: 8, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video0:

Driver Info:
	Driver name      : starfive-camss
	Card type        : Starfive Camera Subsystem
	Bus info         : platform:19840000.camss
	Driver version   : 6.5.0
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
	Media version    : 6.5.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.5.0
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
	Driver version   : 6.5.0
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
	Media version    : 6.5.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.5.0
Interface Info:
	ID               : 0x0300000a
	Type             : V4L Video
Entity Info:
	ID               : 0x00000008 (8)
	Name             : capture_yuv
	Function         : V4L2 I/O
	Pad 0x01000009   : 0: Sink
	  Link 0x0200000c: from remote pad 0x1000003 of entity 'stf_isp' (Unknown Function (00004009)): Data, Enabled

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
	test VIDIOC_EXstf_isp: =================  START STATUS  =================
PBUF: OKtf_isp: ==================  END STATUS  ==================
m
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev0:

Driver Info:
	Driver version   : 6.5.0
	Capabilities     : 0x00000000
Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.5.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.5.0
Interface Info:
	ID               : 0x0300001c
	Type             : V4L Sub-Device
Entity Info:
	ID               : 0x00000001 (1)
	Name             : stf_isp
	Function         : WARNING: Unknown Function (00004009), is v4l2-compliance out-of-date?
	Pad 0x01000002   : 0: Sink
	  Link 0x02000014: from remote pad 0x1000010 of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data, Enabled
	Pad 0x01000003   : 1: Source
	  Link 0x0200000c: to remote pad 0x1000009 of entity 'capture_yuv' (V4L2 I/O): Data, Enabled

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
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEimx219 6-0010: =================  START STATUS  =================
VENT: OKmx219 6-0010: ==================  END STATUS  ==================
m (Not Supported)
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
Compliance test for device /dev/v4l-subdev1:

Driver Info:
	Driver version   : 6.5.0
	Capabilities     : 0x00000000

Required ioctls:
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

Total for device /dev/v4l-subdev1: 43, Succeeded: 43, Failed: 0, Warnings: 0

Grand Total for starfive-camss device /dev/media0: 201, Succeeded: 201, Failed: 0, Warnings: 0
# 

--
Regards,

Jack Zhu
