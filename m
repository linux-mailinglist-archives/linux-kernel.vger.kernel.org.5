Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C461A76FF4D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjHDLOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHDLOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:14:42 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC517EA;
        Fri,  4 Aug 2023 04:14:31 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9F8A77FF9;
        Fri,  4 Aug 2023 19:14:24 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 4 Aug
 2023 19:14:24 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 4 Aug
 2023 19:14:23 +0800
Message-ID: <69c1800e-714e-372d-c894-fd060f26b306@starfivetech.com>
Date:   Fri, 4 Aug 2023 19:14:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 6/6] media: starfive: camss: Add VIN driver
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-7-jack.zhu@starfivetech.com>
 <20230727204911.GA7136@pendragon.ideasonboard.com>
 <696e3fd0-7c89-812b-5cda-c5c46b594bf7@starfivetech.com>
 <20230802103809.GB5269@pendragon.ideasonboard.com>
 <73222603-445e-fdb0-e831-219bac1d5865@starfivetech.com>
 <20230803221833.GF9722@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230803221833.GF9722@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for your comment.

On 2023/8/4 6:18, Laurent Pinchart wrote:
> Hi Jack,
> 
> On Thu, Aug 03, 2023 at 10:44:50AM +0800, Jack Zhu wrote:
>> On 2023/8/2 18:38, Laurent Pinchart wrote:
>> > On Wed, Aug 02, 2023 at 05:58:26PM +0800, Jack Zhu wrote:
>> >> On 2023/7/28 4:49, Laurent Pinchart wrote:
>> >> > On Mon, Jun 19, 2023 at 07:28:38PM +0800, Jack Zhu wrote:
>> >> >> Add Video In Controller driver for StarFive Camera Subsystem.
>> >> > 
>> >> > I haven't reviewed this patch in details, as I have a high-level
>> >> > question: why do you need VIN subdevs ? They don't seem to represent any
>> >> > particular piece of hardware, their input and output formats are always
>> >> > identical, and they're not used to configure registers. The contents of
>> >> > this patch seems to belong to the video device, I think you can drop the
>> >> > VIN subdevs.
>> >> 
>> >> The VIN module corresponds to a hardware module, which is mainly responsible
>> >> for data routing and partial interrupt management (when the image data does
>> >> not pass through the isp but directly goes to the ddr), the relevant registers
>> >> need to be configured.
>> > 
>> > That's fine, but I don't think you need a subdev for it. As far as I
>> > understand, the VIn modules are (more or less) DMA engines. You can just
>> > model them as video devices, connected directly to the CSI-2 RX and ISP
>> > source pads.
>> 
>> The VIN hardware can also route input data, it can decide whether DVP sensor
>> or MIPI sensor is used as input data.
>> 
>> > Does the "vin0_wr" have the ability to capture raw data from the DVP
>> > interface as well, or only from the CSI-2 RX ?
>> 
>> Yes, the "vin0_wr" has the ability to capture raw data from the DVP
>> interface.
> 
> Then I would recommend something similar to the following media graph:
> 
> digraph board {
>         rankdir=TB
>         imx219 [label="{{} | imx219 6-0010\n/dev/v4l-subdev0 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
>         imx219:port0 -> csi2rx:port0 [style=bold]
>         csi2rx [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
>         csi2rx:port1 -> vin:port0 [style=bold]
>         ov5640 [label="{{} | ov5640 6-0020\n/dev/v4l-subdev1 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
>         ov5640:port0 -> vin:port1 [style=bold]
>         vin [label="{{<port0> 0 | <port1> 1} | stf_vin0\n/dev/v4l-subdev2 | {<port2> 2}}", shape=Mrecord, style=filled, fillcolor=green]
>         vin:port2 -> raw_capture [style=dashed]
>         vin:port2 -> isp:port0 [style=dashed]
>         raw_capture [label="stf_vin0_wr_video0\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
>         isp [label="{{<port0> 0} | stf_isp0\n/dev/v4l-subdev3 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
>         isp:port1 -> yuv_capture [style=bold]
>         yuv_capture [label="stf_vin0_isp0_video1\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
> }
> 
> Here, the stf_vin0 subdev is used to route either the CSI-2 input or the
> DVP input to the raw capture video device and the ISP.
> 
> Does this match the hardware architecture ?
> 

Yes, but I have a question to ask, is there any way for stf_vin0 subdev
to distinguish whether the current scene is 'raw_capture' or 'yuv_capture'?

> What are ports 2, 3 and 4 for in the CSI-2 RX ?
>

port2-4 are useless, they should be created by 'cdns-csi2rx.c' by default.
 
>> >> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> >> >> ---
>> >> >>  .../media/platform/starfive/camss/Makefile    |    4 +-
>> >> >>  .../media/platform/starfive/camss/stf_camss.c |   42 +-
>> >> >>  .../media/platform/starfive/camss/stf_camss.h |    2 +
>> >> >>  .../media/platform/starfive/camss/stf_vin.c   | 1069 +++++++++++++++++
>> >> >>  .../media/platform/starfive/camss/stf_vin.h   |  173 +++
>> >> >>  .../platform/starfive/camss/stf_vin_hw_ops.c  |  192 +++
>> >> >>  6 files changed, 1478 insertions(+), 4 deletions(-)
>> >> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_vin.c
>> >> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_vin.h
>> >> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_vin_hw_ops.c
>> >> >> 
>> >> >> diff --git a/drivers/media/platform/starfive/camss/Makefile b/drivers/media/platform/starfive/camss/Makefile
>> >> >> index cdf57e8c9546..ef574e01ca47 100644
>> >> >> --- a/drivers/media/platform/starfive/camss/Makefile
>> >> >> +++ b/drivers/media/platform/starfive/camss/Makefile
>> >> >> @@ -7,6 +7,8 @@ starfive-camss-objs += \
>> >> >>  		stf_camss.o \
>> >> >>  		stf_isp.o \
>> >> >>  		stf_isp_hw_ops.o \
>> >> >> -		stf_video.o
>> >> >> +		stf_video.o \
>> >> >> +		stf_vin.o \
>> >> >> +		stf_vin_hw_ops.o
>> >> >>  
>> >> >>  obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o
>> >> >> diff --git a/drivers/media/platform/starfive/camss/stf_camss.c b/drivers/media/platform/starfive/camss/stf_camss.c
>> >> >> index 6f56b45f57db..834ea63eb833 100644
>> >> >> --- a/drivers/media/platform/starfive/camss/stf_camss.c
>> >> >> +++ b/drivers/media/platform/starfive/camss/stf_camss.c
>> >> >> @@ -131,27 +131,61 @@ static int stfcamss_init_subdevices(struct stfcamss *stfcamss)
>> >> >>  		return ret;
>> >> >>  	}
>> >> >>  
> 

Regards,

Jack Zhu
