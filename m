Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047F6762DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGZHbq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 03:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGZHbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:31:11 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC49422C;
        Wed, 26 Jul 2023 00:29:10 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0D2E881BB;
        Wed, 26 Jul 2023 15:28:55 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Jul
 2023 15:28:55 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Jul
 2023 15:28:55 +0800
Message-ID: <1e38f176-4dcd-83d5-0865-f6ad65e3751d@starfivetech.com>
Date:   Wed, 26 Jul 2023 15:28:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 0/6] Add StarFive Camera Subsystem driver
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
Content-Language: en-US
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230619112838.19797-1-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent, Bryan,

Could you please help to review? Thank you for your time!

On 2023/6/19 19:28, Jack Zhu wrote:
> Hi,
> 
> This series is the v7 series that attempts to support the Camera Subsystem
> found on StarFive JH7110 SoC.
> 
> The following are the media graph for the device and the v4l2-compliance
> output.
> 
> ===========================================================================
> [the media graph]:
> 
> digraph board {
> 	rankdir=TB
> 	n00000001 [label="{{<port0> 0} | stf_isp0\n/dev/v4l-subdev0 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
> 	n00000001:port1 -> n0000000d:port0 [style=dashed]
> 	n00000004 [label="{{<port0> 0} | stf_vin0_wr\n/dev/v4l-subdev1 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
> 	n00000004:port1 -> n00000007 [style=bold]
> 	n00000007 [label="stf_vin0_wr_video0\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
> 	n0000000d [label="{{<port0> 0} | stf_vin0_isp0\n/dev/v4l-subdev2 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
> 	n0000000d:port1 -> n00000010 [style=bold]
> 	n00000010 [label="stf_vin0_isp0_video1\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
> 	n00000018 [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
> 	n00000018:port1 -> n00000004:port0 [style=dashed]
> 	n00000018:port1 -> n00000001:port0 [style=dashed]
> 	n00000022 [label="{{} | imx219 6-0010\n/dev/v4l-subdev3 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
> 	n00000022:port0 -> n00000018:port0 [style=bold]
> }
> 
> [the device topology]:
> 
> Media controller API version 6.4.0
> 
> Media device information
> ------------------------
> driver          starfive-camss
> model           Starfive Camera Subsystem
> serial          
> bus info        platform:19840000.camss
> hw revision     0x0
> driver version  6.4.0
> 
> Device topology
> - entity 1: stf_isp0 (2 pads, 2 links)
>             type V4L2 subdev subtype Unknown flags 0
>             device node name /dev/v4l-subdev0
> 	pad0: Sink
> 		[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb
> 		 crop.bounds:(0,0)/1920x1080
> 		 crop:(0,0)/1920x1080]
> 		<- "cdns_csi2rx.19800000.csi-bridge":1 []
> 	pad1: Source
> 		[fmt:Y12_1X12/1920x1080 field:none colorspace:srgb
> 		 crop.bounds:(0,0)/1920x1080
> 		 crop:(0,0)/1920x1080]
> 		-> "stf_vin0_isp0":0 []
> 
> - entity 4: stf_vin0_wr (2 pads, 2 links)
>             type V4L2 subdev subtype Unknown flags 0
>             device node name /dev/v4l-subdev1
> 	pad0: Sink
> 		[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb]
> 		<- "cdns_csi2rx.19800000.csi-bridge":1 []
> 	pad1: Source
> 		[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb]
> 		-> "stf_vin0_wr_video0":0 [ENABLED,IMMUTABLE]
> 
> - entity 7: stf_vin0_wr_video0 (1 pad, 1 link)
>             type Node subtype V4L flags 0
>             device node name /dev/video0
> 	pad0: Sink
> 		<- "stf_vin0_wr":1 [ENABLED,IMMUTABLE]
> 
> - entity 13: stf_vin0_isp0 (2 pads, 2 links)
>              type V4L2 subdev subtype Unknown flags 0
>              device node name /dev/v4l-subdev2
> 	pad0: Sink
> 		[fmt:Y12_1X12/1920x1080 field:none colorspace:srgb]
> 		<- "stf_isp0":1 []
> 	pad1: Source
> 		[fmt:Y12_1X12/1920x1080 field:none colorspace:srgb]
> 		-> "stf_vin0_isp0_video1":0 [ENABLED,IMMUTABLE]
> 
> - entity 16: stf_vin0_isp0_video1 (1 pad, 1 link)
>              type Node subtype V4L flags 0
>              device node name /dev/video1
> 	pad0: Sink
> 		<- "stf_vin0_isp0":1 [ENABLED,IMMUTABLE]
> 
> - entity 24: cdns_csi2rx.19800000.csi-bridge (5 pads, 3 links)
>              type V4L2 subdev subtype Unknown flags 0
> 	pad0: Sink
> 		<- "imx219 6-0010":0 [ENABLED,IMMUTABLE]
> 	pad1: Source
> 		-> "stf_vin0_wr":0 []
> 		-> "stf_isp0":0 []
> 	pad2: Source
> 	pad3: Source
> 	pad4: Source
> 
> - entity 34: imx219 6-0010 (1 pad, 1 link)
>              type V4L2 subdev subtype Sensor flags 0
>              device node name /dev/v4l-subdev3
> 	pad0: Source
> 		[fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:full-range
> 		 crop.bounds:(8,8)/3280x2464
> 		 crop:(8,8)/3280x2464]
> 		-> "cdns_csi2rx.19800000.csi-bridge":0 [ENABLED,IMMUTABLE]
> 
> ===========================================================================
> [the v4l2-compliance output]:
> 
> v4l2-compliance -s -d /dev/video1
> v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
> 
> Compliance test for stf camss device /dev/video1:
> 
> Driver Info:
> 	Driver name      : stf camss
> 	Card type        : Starfive Camera Subsystem
> 	Bus info         : platform:19840000.camss
> 	Driver version   : 6.4.0
> 	Capabilities     : 0x85200001
> 		Video Capture
> 		Read/Write
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x05200001
> 		Video Capture
> 		Read/Write
> 		Streaming
> 		Extended Pix Format
> Media Driver Info:
> 	Driver name      : starfive-camss
> 	Model            : Starfive Camera Subsystem
> 	Serial           : 
> 	Bus info         : platform:19840000.camss
> 	Media version    : 6.4.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 6.4.0
> Interface Info:
> 	ID               : 0x03000012
> 	Type             : V4L Video
> Entity Info:
> 	ID               : 0x00000010 (16)
> 	Name             : stf_vin0_isp0_video1
> 	Function         : V4L2 I/O
> 	Pad 0x01000011   : 0: Sink
> 	  Link 0x02000014: from remote pad 0x100000f of entity 'stf_vin0_isp0' (Video Pixel Formatter): Data, Enabled, Immutable
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
> 	test read/write: OK
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
> Changes since v3:
> Patch 1:
> - Modified port@0 and port@1 properties.
> - Extended the port@0 example with appropriate properties.
> - Added 'port@0' for 'required'
> Patch 2:
> - Modified spelling errors.
> Patch 3:
> - Merged patch 5 into the patch with an explanation for compatible in
>   commit msg.
> Patch 6:
> - Asserted pixel_rst[i] reset in the loop after the err_disable_pixclk
>   label.
> - Modified Code Style for getting sys_rst and p_rst.
> - Renamed clk_name to name and modified the relevant code.
> Patch 9:
> - Added static for stfcamss_get_mem_res function.
> - Added static for isp_close function.
> - Fixed implicit conversion warning for stf_vin_map_isp_pad function.
> - Dropped unused variables.
> 
>   v3: https://lore.kernel.org/all/20230331121826.96973-1-jack.zhu@starfivetech.com/
> 
> Changes since v2:
> - Rebased on v6.3-rc1.
> Patch 1:
> - Modified spelling errors.
> - Added port@0.
> - Modified '$ref' of port.
> - Added 'ports' to 'required'.
> - Dropped 'stfcamss' label in example.
> - Added port@0 in example.
> - Added MAINTAINERS file.
> Patch 2:
> - Split this patch into three new patches.
> - Modified compatible property.
> - Replaced clock names with the existing names.
> - Modified 'bus-type' and 'clock-lanes'
> - Added port@2 - port@4
> - Dropped 'csi2rx' label in example.
> Patch 3:
> - Updated rst and dot file as three pipelines were deleted.
> Patch 4:
> - Split this patch into three new patches.
> - Dropped .s_power() and .get_fmt().
> - Dropped CSI-2 DT support.
> - Dropped v4l2_device_register_subdev_nodes().
> - Used assigned-clock-rates in DT to set clk value.
> - Modified 'compatible' field.
> Patch 5:
> - Deleted three pipelines. 
> - Modified 'stfcamss_clocks'/'stfcamss_resets' struct.
> - Dropped stfcamss_find_sensor() function.
> - Removed redundant code from stfcamss_of_parse_endpoint_node().
> - Modified spelling errors.
> - Rewrote stfcamss_reg_media_subdev_node() function.
> - Modified stfcamss_subdev_notifier_bound().
> - Modified stfcamss_probe() function.
> - Dropped stfcamss_suspend() and stfcamss_resume().
> - Dropped dev_info() in stfcamss_remove() function.
> - Added 'stf_' prefix for enum subdev_type.
> - Moved all includes to the top in stf_camss.h file.
> - Dropped unused fields in stfcamss struct.
> - Replaced Custom logging macros with regular macros.
> - Rewrote register read and write functions.
> - Used lowercase for all hex constants.
> - Used macro to name registers.
> - Dropped unused ioctl and stf_isp_ioctl.h file.
> 
>   v2: https://lore.kernel.org/all/20230310120553.60586-1-jack.zhu@starfivetech.com/
> 
> Changes since v1:
> - Deleted starfive,jh7110-mipi-csi2.yaml.
> - Converted cdns,csi2rx.txt to cdns,csi2rx.yaml and added ‘resets’
>   properties.
> - Added ‘cdns,csi2rx.yaml’ in ‘CADENCE MIPI-CSI2 BRIDGES’ entry.
> - The following contents were modified in starfive,jh7110-camss.yaml:
>   dropped quotes from ’id’ and ‘schema’; dropped ‘|’ for ‘description’;
>   corrected the wrong or redundant words: ‘a ISP’, ‘PD ISP’;
>   dropped ‘minItems’ for ‘reg’, ‘clocks’, ‘resets’ and ‘interrupts’;
>   dropped the '_clk' and 'rst_' prefix about the 'clock-names' and
>   'reset-names';
>   changed ‘endpoint@1’ to ‘endpoint’; updated examples;
> - Updated Subject for some patches.
> - Merged patch 6, 7, 8, 9, 10, 11 into one patch.
> 
> Jack Zhu (6):
>   media: dt-bindings: Add JH7110 Camera Subsystem
>   media: admin-guide: Add starfive_camss.rst for Starfive Camera
>     Subsystem
>   media: starfive: camss: Add basic driver
>   media: starfive: camss: Add video driver
>   media: starfive: camss: Add ISP driver
>   media: starfive: camss: Add VIN driver
> 
>  .../admin-guide/media/starfive_camss.rst      |   57 +
>  .../media/starfive_camss_graph.dot            |   16 +
>  .../admin-guide/media/v4l-drivers.rst         |    1 +
>  .../bindings/media/starfive,jh7110-camss.yaml |  180 +++
>  MAINTAINERS                                   |    9 +
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/starfive/Kconfig       |    5 +
>  drivers/media/platform/starfive/Makefile      |    2 +
>  drivers/media/platform/starfive/camss/Kconfig |   16 +
>  .../media/platform/starfive/camss/Makefile    |   14 +
>  .../media/platform/starfive/camss/stf_camss.c |  444 +++++++
>  .../media/platform/starfive/camss/stf_camss.h |  151 +++
>  .../media/platform/starfive/camss/stf_isp.c   |  519 ++++++++
>  .../media/platform/starfive/camss/stf_isp.h   |  479 ++++++++
>  .../platform/starfive/camss/stf_isp_hw_ops.c  |  468 ++++++++
>  .../media/platform/starfive/camss/stf_video.c |  724 +++++++++++
>  .../media/platform/starfive/camss/stf_video.h |   92 ++
>  .../media/platform/starfive/camss/stf_vin.c   | 1069 +++++++++++++++++
>  .../media/platform/starfive/camss/stf_vin.h   |  173 +++
>  .../platform/starfive/camss/stf_vin_hw_ops.c  |  192 +++
>  21 files changed, 4613 insertions(+)
>  create mode 100644 Documentation/admin-guide/media/starfive_camss.rst
>  create mode 100644 Documentation/admin-guide/media/starfive_camss_graph.dot
>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>  create mode 100644 drivers/media/platform/starfive/Kconfig
>  create mode 100644 drivers/media/platform/starfive/Makefile
>  create mode 100644 drivers/media/platform/starfive/camss/Kconfig
>  create mode 100644 drivers/media/platform/starfive/camss/Makefile
>  create mode 100644 drivers/media/platform/starfive/camss/stf_camss.c
>  create mode 100644 drivers/media/platform/starfive/camss/stf_camss.h
>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp.c
>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp.h
>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp_hw_ops.c
>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.c
>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.h
>  create mode 100644 drivers/media/platform/starfive/camss/stf_vin.c
>  create mode 100644 drivers/media/platform/starfive/camss/stf_vin.h
>  create mode 100644 drivers/media/platform/starfive/camss/stf_vin_hw_ops.c
> 

-- 
Regards,

Jack Zhu
