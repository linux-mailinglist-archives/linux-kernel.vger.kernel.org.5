Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00E27A1A88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjIOJ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjIOJ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:27:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA97E3580;
        Fri, 15 Sep 2023 02:26:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DE1C433C8;
        Fri, 15 Sep 2023 09:26:28 +0000 (UTC)
Message-ID: <11735008-1adf-4b84-9023-d295371caed5@xs4all.nl>
Date:   Fri, 15 Sep 2023 11:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/8] Add StarFive Camera Subsystem driver
Content-Language: en-US, nl
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
References: <20230914031607.34877-1-jack.zhu@starfivetech.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230914031607.34877-1-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 05:15, Jack Zhu wrote:
> Hi,
> 
> This series is the v9 series that attempts to support the Camera Subsystem
> found on StarFive JH7110 SoC.
> 
> This series is based on top of the master branch of media_stage repository.
> 
> The following are the media graph for the device and the v4l2-compliance
> output.
> 
> ===========================================================================
> [the media graph]:
> 
> digraph board {
> 	rankdir=TB
> 	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
> 	n00000001:port1 -> n00000008 [style=dashed]
> 	n00000004 [label="capture_raw\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
> 	n00000008 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
> 	n0000000e [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
> 	n0000000e:port1 -> n00000001:port0 [style=dashed]
> 	n0000000e:port1 -> n00000004 [style=dashed]
> 	n00000018 [label="{{} | imx219 6-0010\n/dev/v4l-subdev1 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
> 	n00000018:port0 -> n0000000e:port0 [style=bold]
> }
> 
> [the device topology]:
> 
> Media controller API version 6.5.0
> 
> Media device information
> ------------------------
> driver          starfive-camss
> model           Starfive Camera Subsystem
> serial          
> bus info        platform:19840000.camss
> hw revision     0x0
> driver version  6.5.0
> 
> Device topology
> - entity 1: stf_isp (2 pads, 2 links)
>             type V4L2 subdev subtype Unknown flags 0
>             device node name /dev/v4l-subdev0
> 	pad0: Sink
> 		[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb
> 		 crop.bounds:(0,0)/1920x1080
> 		 crop:(0,0)/1920x1080]
> 		<- "cdns_csi2rx.19800000.csi-bridge":1 []
> 	pad1: Source
> 		[fmt:YUYV8_1_5X8/1920x1080 field:none colorspace:srgb
> 		 crop.bounds:(0,0)/1920x1080
> 		 crop:(0,0)/1920x1080]
> 		-> "capture_yuv":0 []
> 
> - entity 4: capture_raw (1 pad, 1 link)
>             type Node subtype V4L flags 0
>             device node name /dev/video0
> 	pad0: Sink
> 		<- "cdns_csi2rx.19800000.csi-bridge":1 []
> 
> - entity 8: capture_yuv (1 pad, 1 link)
>             type Node subtype V4L flags 0
>             device node name /dev/video1
> 	pad0: Sink
> 		<- "stf_isp":1 []
> 
> - entity 14: cdns_csi2rx.19800000.csi-bridge (5 pads, 3 links)
>              type V4L2 subdev subtype Unknown flags 0
> 	pad0: Sink
> 		<- "imx219 6-0010":0 [ENABLED,IMMUTABLE]
> 	pad1: Source
> 		-> "stf_isp":0 []
> 		-> "capture_raw":0 []
> 	pad2: Source
> 	pad3: Source
> 	pad4: Source
> 
> - entity 24: imx219 6-0010 (1 pad, 1 link)
>              type V4L2 subdev subtype Sensor flags 0
>              device node name /dev/v4l-subdev1
> 	pad0: Source
> 		[fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:full-range
> 		 crop.bounds:(8,8)/3280x2464
> 		 crop:(8,8)/3280x2464]
> 		-> "cdns_csi2rx.19800000.csi-bridge":0 [ENABLED,IMMUTABLE]
> 
> ===========================================================================
> [the v4l2-compliance output]:
> 
> v4l2-compliance 1.24.1, 64 bits, 64-bit time_t

This v4l2-compliance version is from a distro. For driver acceptance you
must test with a v4l2-compliance compiled from the git repo (git://linuxtv.org/v4l-utils.git).

Also, since this driver uses the media controller, you must run v4l2-compliance
with the -m /dev/mediaX option. This will test the compliance of all devices
reported by the media controller.

> 
> Compliance test for stf camss device /dev/video1:
> 
> Driver Info:
> 	Driver name      : stf camss

The module is called starfive-camss, so shouldn't the driver name reported here
be the same?

> 	Card type        : Starfive Camera Subsystem
> 	Bus info         : platform:19840000.camss
> 	Driver version   : 6.5.0
> 	Capabilities     : 0x84200001
> 		Video Capture
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04200001
> 		Video Capture
> 		Streaming
> 		Extended Pix Format
> Media Driver Info:
> 	Driver name      : starfive-camss

It's correct in the media controller information.

> 	Model            : Starfive Camera Subsystem
> 	Serial           : 
> 	Bus info         : platform:19840000.camss
> 	Media version    : 6.5.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 6.5.0
> Interface Info:
> 	ID               : 0x0300000a
> 	Type             : V4L Video
> Entity Info:
> 	ID               : 0x00000008 (8)
> 	Name             : capture_yuv
> 	Function         : V4L2 I/O
> 	Pad 0x01000009   : 0: Sink
> 	  Link 0x0200000c: from remote pad 0x1000003 of entity 'stf_isp' (Unknown Function (00004009)): Data, Enabled

Hmm, this reports "Unknown Function". I bet that when you run v4l2-compliance
with the -m option it will fail on this. If not, then that's likely a bug in
the compliance test, please let me know if that's the case.

Regards,

	Hans

> 
> Required ioctls:
> 	test MC information (see 'Media Driver Info' above): OK
> 	test VIDIOC_QUERYCAP: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/video1 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
> 	test VIDIOC_QUERYCTRL: OK (Not Supported)
> 	test VIDIOC_G/S_CTRL: OK (Not Supported)
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 0 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK (Not Supported)
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 
> Test input 0:
> 
> Streaming ioctls:
> 	test read/write: OK (Not Supported)
> 	test blocking wait: OK
> 	test MMAP (no poll): OK                           
> 	test MMAP (select): OK                            
> 	test MMAP (epoll): OK                             
> 	test USERPTR (no poll): OK (Not Supported)
> 	test USERPTR (select): OK (Not Supported)
> 	test DMABUF: Cannot test, specify --expbuf-device
> 
> Total for stf camss device /dev/video1: 53, Succeeded: 53, Failed: 0, Warnings: 0
> 
> ===========================================================================
> Changes in v9:
> - Rebased on top of the master branch of media_stage repository.
> - Renamed file name.
> - Added of_node_put(node) in the error handling path of
>   stfcamss_of_parse_ports().
> 
> v8 link: https://lore.kernel.org/all/20230824080109.89613-1-jack.zhu@starfivetech.com/
> 
> Changes in v8:
> - Rebased on v6.5-rc7.
> - Dropped VIN subdev.
> - Created two new video devices: capture_raw and capture_yuv, to replace
>   the previous video devices.
> - Dropped VB2_READ io methods.
> - Recursively called .s_stream() on subdevs.
> 
> v7 link: https://lore.kernel.org/all/20230619112838.19797-1-jack.zhu@starfivetech.com/
> 
> Changes in v7:
> - HAS_DMA is used instead of DMA_CMA in Kconfig.
> - Dropped some non-essential member variables.
> - Used v4l2_async_nf_add_fwnode_remote() to simplify the relevant code.
> - Modified some Local variable types in the function.
> - Used v4l2_create_fwnode_links_to_pad() to simplify the relevant code.
> - Added error handling for clk_prepare_enable().
> - Simplified stfcamss_format_info struct and modified the relevant code.
> - Dropped enum_input, g_input and s_input.
> - Unified v4l2_ioctl_ops struct.
> - Used v4l2_fh_open()/vb2_fop_release to replace deprecated APIs.
> - Added a camss directory under the starfive directory and modified the
>   patch title.
> 
> v6 link: https://lore.kernel.org/all/20230525083202.67933-1-jack.zhu@starfivetech.com/
> 
> Changes in v6:
> - Added 'bus-type' in bindings example.
> - Corrected spelling errors.
> - As reviewed by Bryan, used 'nclks' and 'nrsts' variables.
> - Added lccf config for ISP.
> 
> v5 link: https://lore.kernel.org/all/20230512102844.51084-1-jack.zhu@starfivetech.com/
> 
> Changes in v5:
> - Rebased on v6.4-rc1.
> - Added new patch.
> - Modified ISP driver.
> 
> v4 link: https://lore.kernel.org/all/20230413035541.62129-1-jack.zhu@starfivetech.com/
> 
> Previous cover letter from v4:
> 
> This patch series adds support for the StarFive Camera Subsystem
> found on StarFive JH7110 SoC.
> 
> The driver implements V4L2, Media controller and V4L2 subdev interfaces.
> Camera sensor using V4L2 subdev interface in the kernel is supported.
> 
> The driver is tested on VisionFive V2 board with IMX219 camera sensor.
> GStreamer 1.18.5 with v4l2src plugin is supported.
> 
> Previous version link, missing v1 version:
> 
>   v3: https://lore.kernel.org/all/20230331121826.96973-1-jack.zhu@starfivetech.com/
>   v2: https://lore.kernel.org/all/20230310120553.60586-1-jack.zhu@starfivetech.com/
> 
> Jack Zhu (8):
>   media: dt-bindings: Add JH7110 Camera Subsystem
>   media: admin-guide: Add starfive_camss.rst for Starfive Camera
>     Subsystem
>   media: staging: media: starfive: camss: Add core driver
>   media: staging: media: starfive: camss: Add video driver
>   media: staging: media: starfive: camss: Add ISP driver
>   media: staging: media: starfive: camss: Add capture driver
>   media: staging: media: starfive: camss: Add interrupt handling
>   media: staging: media: starfive: camss: Register devices
> 
>  .../admin-guide/media/starfive_camss.rst      |  72 +++
>  .../media/starfive_camss_graph.dot            |  12 +
>  .../admin-guide/media/v4l-drivers.rst         |   1 +
>  .../bindings/media/starfive,jh7110-camss.yaml | 180 ++++++
>  MAINTAINERS                                   |   9 +
>  drivers/staging/media/Kconfig                 |   2 +
>  drivers/staging/media/Makefile                |   1 +
>  drivers/staging/media/starfive/Kconfig        |   5 +
>  drivers/staging/media/starfive/Makefile       |   2 +
>  drivers/staging/media/starfive/camss/Kconfig  |  17 +
>  drivers/staging/media/starfive/camss/Makefile |  13 +
>  .../staging/media/starfive/camss/stf-camss.c  | 436 +++++++++++++
>  .../staging/media/starfive/camss/stf-camss.h  | 134 ++++
>  .../media/starfive/camss/stf-capture.c        | 603 ++++++++++++++++++
>  .../media/starfive/camss/stf-capture.h        |  87 +++
>  .../media/starfive/camss/stf-isp-hw-ops.c     | 445 +++++++++++++
>  .../staging/media/starfive/camss/stf-isp.c    | 407 ++++++++++++
>  .../staging/media/starfive/camss/stf-isp.h    | 428 +++++++++++++
>  .../staging/media/starfive/camss/stf-video.c  | 571 +++++++++++++++++
>  .../staging/media/starfive/camss/stf-video.h  | 100 +++
>  20 files changed, 3525 insertions(+)
>  create mode 100644 Documentation/admin-guide/media/starfive_camss.rst
>  create mode 100644 Documentation/admin-guide/media/starfive_camss_graph.dot
>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>  create mode 100644 drivers/staging/media/starfive/Kconfig
>  create mode 100644 drivers/staging/media/starfive/Makefile
>  create mode 100644 drivers/staging/media/starfive/camss/Kconfig
>  create mode 100644 drivers/staging/media/starfive/camss/Makefile
>  create mode 100644 drivers/staging/media/starfive/camss/stf-camss.c
>  create mode 100644 drivers/staging/media/starfive/camss/stf-camss.h
>  create mode 100644 drivers/staging/media/starfive/camss/stf-capture.c
>  create mode 100644 drivers/staging/media/starfive/camss/stf-capture.h
>  create mode 100644 drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
>  create mode 100644 drivers/staging/media/starfive/camss/stf-isp.c
>  create mode 100644 drivers/staging/media/starfive/camss/stf-isp.h
>  create mode 100644 drivers/staging/media/starfive/camss/stf-video.c
>  create mode 100644 drivers/staging/media/starfive/camss/stf-video.h
> 

