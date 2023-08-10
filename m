Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F60777797
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjHJLyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjHJLyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:54:14 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8038A91;
        Thu, 10 Aug 2023 04:54:12 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id AEE752A083;
        Thu, 10 Aug 2023 13:54:11 +0200 (CEST)
Message-ID: <067ddd6c-8dc0-91bb-9991-e975c53a1947@gpxsee.org>
Date:   Thu, 10 Aug 2023 13:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v8 2/2] Added Digiteq Automotive MGB4 driver documentation
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=c5=afma?= <martin.tuma@digiteqautomotive.com>
References: <20230704131339.2177-1-tumic@gpxsee.org>
 <20230704131339.2177-3-tumic@gpxsee.org>
 <bf859616-601e-1dc3-2696-803a8edbd8ab@xs4all.nl>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <bf859616-601e-1dc3-2696-803a8edbd8ab@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 07. 23 12:40, Hans Verkuil wrote:
> On 04/07/2023 15:13, tumic@gpxsee.org wrote:
>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>
>> The "admin-guide" documentation for the Digiteq Automotive MGB4 driver.
>>
>> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
>> ---
>>   Documentation/admin-guide/media/mgb4.rst      | 369 ++++++++++++++++++
>>   .../admin-guide/media/pci-cardlist.rst        |   1 +
>>   .../admin-guide/media/v4l-drivers.rst         |   1 +
>>   3 files changed, 371 insertions(+)
>>   create mode 100644 Documentation/admin-guide/media/mgb4.rst
>>
>> diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
>> new file mode 100644
>> index 000000000000..e1bb708a2265
>> --- /dev/null
>> +++ b/Documentation/admin-guide/media/mgb4.rst
>> @@ -0,0 +1,369 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +====================
>> +mgb4 sysfs interface
>> +====================
>> +
>> +The mgb4 driver provides a sysfs interface, that is used to configure video
>> +stream related parameters (some of them must be set properly before the v4l2
>> +device can be opened) and obtain the video device/stream status.
>> +
>> +There are two types of parameters - global / PCI card related, found under
>> +``/sys/class/video4linux/videoX/device`` and module specific found under
>> +``/sys/class/video4linux/videoX``.
>> +
>> +
>> +Global (PCI card) parameters
>> +============================
>> +
>> +**module_type** (R):
>> +    Module type.
>> +
>> +    | 0 - No module present
>> +    | 1 - FPDL3
>> +    | 2 - GMSL
>> +
>> +**module_version** (R):
>> +    Module version number. Zero in case of a missing module.
>> +
>> +**fw_type** (R):
>> +    Firmware type.
>> +
>> +    | 1 - FPDL3
>> +    | 2 - GMSL
>> +
>> +**fw_version** (R):
>> +    Firmware version number.
>> +
>> +**serial_number** (R):
>> +    Card serial number. The format is::
>> +
>> +        PRODUCT-REVISION-SERIES-SERIAL
>> +
>> +    where each component is a 8b number.
>> +
>> +
>> +Common FPDL3/GMSL input parameters
>> +==================================
>> +
>> +**input_id** (R):
>> +    Input number ID, zero based.
>> +
>> +**oldi_lane_width** (RW):
>> +    Number of deserializer output lanes.
>> +
>> +    | 0 - single
>> +    | 1 - dual
>> +
>> +**color_mapping** (RW):
>> +    Mapping of the incoming bits in the signal to the colour bits of the pixels.
>> +
>> +    | 0 - OLDI/JEIDA
>> +    | 1 - SPWG/VESA
>> +
>> +**link_status** (R):
>> +    Video link status. If the link is locked, chips are properly connected and
>> +    communicating at the same speed and protocol. The link can be locked without
>> +    an active video stream.
>> +
>> +    A value of 0 is equivalent to the V4L2_IN_ST_NO_SYNC flag of the V4L2
>> +    VIDIOC_ENUMINPUT status bits.
>> +
>> +    | 0 - unlocked
>> +    | 1 - locked
>> +
>> +**stream_status** (R):
>> +    Video stream status. A stream is detected if the link is locked, the input
>> +    pixel clock is running and the DE signal is moving.
>> +
>> +    A value of 0 is equivalent to the V4L2_IN_ST_NO_SIGNAL flag of the V4L2
>> +    VIDIOC_ENUMINPUT status bits.
>> +
>> +    | 0 - not detected
>> +    | 1 - detected
>> +
>> +**video_width** (R):
>> +    Video stream width. This is the actual width as detected by the HW.
>> +
>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in the width
>> +    field of the v4l2_bt_timings struct.
>> +
>> +**video_height** (R):
>> +    Video stream height. This is the actual height as detected by the HW.
>> +
>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in the height
>> +    field of the v4l2_bt_timings struct.
>> +
>> +**vsync_status** (R):
>> +    The type of VSYNC pulses as detected by the video format detector.
>> +
>> +    The value is equivalent to the flags returned by VIDIOC_QUERY_DV_TIMINGS in
>> +    the polarities field of the v4l2_bt_timings struct.
>> +
>> +    | 0 - active low
>> +    | 1 - active high
>> +    | 2 - not available
>> +
>> +**hsync_status** (R):
>> +    The type of HSYNC pulses as detected by the video format detector.
>> +
>> +    The value is equivalent to the flags returned by VIDIOC_QUERY_DV_TIMINGS in
>> +    the polarities field of the v4l2_bt_timings struct.
>> +
>> +    | 0 - active low
>> +    | 1 - active high
>> +    | 2 - not available
>> +
>> +**vsync_gap_length** (RW):
>> +    If the incoming video signal does not contain synchronization VSYNC and
>> +    HSYNC pulses, these must be generated internally in the FPGA to achieve
>> +    the correct frame ordering. This value indicates, how many "empty" pixels
> 
> Pixels or lines? This is vsync, so lines would be more logical.
> 
> Even if the hardware wants pixels, perhaps the driver should use lines and
> translate it to pixels. It's much easier for userspace to work with lines.
>

According to our HW engineers, this is properly documented. I do not 
have the full insight to the "signal parameters" topic, so my answers 
here will be just some kind of "free" translation of what I got. The 
justification here was, that the vsync gap length (in our case/HW) 
represents something slightly different than you may think.

>> +    (pixels with deasserted Data Enable signal) are necessary to generate the
>> +    internal VSYNC pulse.
>> +
>> +**hsync_gap_length** (RW):
>> +    If the incoming video signal does not contain synchronization VSYNC and
>> +    HSYNC pulses, these must be generated internally in the FPGA to achieve
>> +    the correct frame ordering. This value indicates, how many "empty" pixels
>> +    (pixels with deasserted Data Enable signal) are necessary to generate the
>> +    internal HSYNC pulse. The value must be greater than 1 and smaller than
>> +    vsync_gap_length.
> 
> Does this make sense? vsync_gap_length can be many video lines, which makes
> not sense for hsync_gap_length.
> 
> I wonder if it isn't easier to just change this to v/hsync_blanking_length
> (lines for vsync, pixels for hsync) to indicate the length of the blanking
> periods, and then let the driver pick a suitable hsync/vsync position.
> 

Dtto.

>> +
>> +**pclk_frequency** (R):
>> +    Input pixel clock frequency in kHz.
>> +
>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in
>> +    the pixelclock field of the v4l2_bt_timings struct.
>> +
>> +    *Note: The frequency_range parameter must be set properly first to get
>> +    a valid frequency here.*
>> +
>> +**hsync_width** (R):
>> +    Width of the HSYNC signal in PCLK clock ticks.
>> +
>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in
>> +    the hsync field of the v4l2_bt_timings struct.
>> +
>> +**vsync_width** (R):
>> +    Width of the VSYNC signal in PCLK clock ticks.
>> +
>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in
>> +    the vsync field of the v4l2_bt_timings struct.
>> +
>> +**hback_porch** (R):
>> +    Number of PCLK pulses between deassertion of the HSYNC signal and the first
>> +    valid pixel in the video line (marked by DE=1).
>> +
>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in
>> +    the hbackporch field of the v4l2_bt_timings struct.
>> +
>> +**hfront_porch** (R):
>> +    Number of PCLK pulses between the end of the last valid pixel in the video
>> +    line (marked by DE=1) and assertion of the HSYNC signal.
>> +
>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in
>> +    the hfrontporch field of the v4l2_bt_timings struct.
>> +
>> +**vback_porch** (R):
>> +    Number of video lines between deassertion of the VSYNC signal and the video
>> +    line with the first valid pixel (marked by DE=1).
>> +
>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in
>> +    the vbackporch field of the v4l2_bt_timings struct.
>> +
>> +**vfront_porch** (R):
>> +    Number of video lines between the end of the last valid pixel line (marked
>> +    by DE=1) and assertion of the VSYNC signal.
>> +
>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in
>> +    the vfrontporch field of the v4l2_bt_timings struct.
> 
> Does setting v/hsync_gap_length also update these fields accordingly?
> 

According to our HW engineers, those values are independent.

>> +
>> +**frequency_range** (RW)
>> +    PLL frequency range of the OLDI input clock generator. The PLL frequency is
>> +    derived from the Pixel Clock Frequency (PCLK) and is equal to PCLK if
>> +    oldi_lane_width is set to "single" and PCLK/2 if oldi_lane_width is set to
>> +    "dual".
>> +
>> +    | 0 - PLL < 50MHz
>> +    | 1 - PLL >= 50MHz
>> +
>> +    *Note: This parameter can not be changed while the input v4l2 device is
>> +    open.*
>> +
>> +
>> +Common FPDL3/GMSL output parameters
>> +===================================
>> +
>> +**output_id** (R):
>> +    Output number ID, zero based.
>> +
>> +**video_source** (RW):
>> +    Output video source. If set to 0 or 1, the source is the corresponding card
>> +    input and the v4l2 output devices are disabled. If set to 2 or 3, the source
>> +    is the corresponding v4l2 video output device.
>> +
>> +    | 0 - input 0
>> +    | 1 - input 1
>> +    | 2 - v4l2 output 0
>> +    | 3 - v4l2 output 1
>> +
>> +    *Note: This parameter can not be changed while ANY of the input/output v4l2
>> +    devices is open.*
>> +
>> +**display_width** (RW):
>> +    Display width. There is no autodetection of the connected display, so the
>> +    proper value must be set before the start of streaming.
>> +
>> +    *Note: This parameter can not be changed while the output v4l2 device is
>> +    open.*
>> +
>> +**display_height** (RW):
>> +    Display height. There is no autodetection of the connected display, so the
>> +    proper value must be set before the start of streaming.
>> +
>> +    *Note: This parameter can not be changed while the output v4l2 device is
>> +    open.*
>> +
>> +**frame_rate** (RW):
>> +    Output video frame rate in frames per second.
>> +
>> +**hsync_polarity** (RW):
>> +    HSYNC signal polarity.
>> +
>> +    | 0 - active low
>> +    | 1 - active high
>> +
>> +**vsync_polarity** (RW):
>> +    VSYNC signal polarity.
>> +
>> +    | 0 - active low
>> +    | 1 - active high
>> +
>> +**de_polarity** (RW):
>> +    DE signal polarity.
>> +
>> +    | 0 - active low
>> +    | 1 - active high
>> +
>> +**pclk_frequency** (RW):
>> +    Output pixel clock frequency. Allowed values are between 25000-190000(kHz)
>> +    and there is a non-linear stepping between two consecutive allowed
>> +    frequencies. The driver finds the nearest allowed frequency to the given
>> +    value and sets it. When reading this property, you get the exact
>> +    frequency set by the driver.
>> +
>> +    *Note: This parameter can not be changed while the output v4l2 device is
>> +    open.*
>> +
>> +**hsync_width** (RW):
>> +    Width of the HSYNC signal in PCLK clock ticks.
> 
> Isn't "PCLK clock ticks" the equivalent of "pixels"? That's a much more natural
> way of describing this.
> 

Should really have been pixels, fixed in v9.

>> +
>> +**vsync_width** (RW):
>> +    Width of the VSYNC signal in PCLK clock ticks.
> 
> VSYNC is usually described in lines and 'height'.
> 

That was a bug too. Fixed to "lines".

>> +
>> +**hback_porch** (RW):
>> +    Number of PCLK pulses between deassertion of the HSYNC signal and the first
>> +    valid pixel in the video line (marked by DE=1).
>> +
>> +**hfront_porch** (RW):
>> +    Number of PCLK pulses between the end of the last valid pixel in the video
>> +    line (marked by DE=1) and assertion of the HSYNC signal.
>> +
>> +**vback_porch** (RW):
>> +    Number of video lines between deassertion of the VSYNC signal and the video
>> +    line with the first valid pixel (marked by DE=1).
> 
> As is done here.

According to our HW engineers, this is properly documented.

> 
>> +
>> +**vfront_porch** (RW):
>> +    Number of video lines between the end of the last valid pixel line (marked
>> +    by DE=1) and assertion of the VSYNC signal.
>> +
>> +
>> +FPDL3 specific input parameters
>> +===============================
>> +
>> +**fpdl3_input_width** (RW):
>> +    Number of deserializer input lines.
>> +
>> +    | 0 - auto
>> +    | 1 - single
>> +    | 2 - dual
>> +
>> +FPDL3 specific output parameters
>> +================================
>> +
>> +**fpdl3_output_width** (RW):
>> +    Number of serializer output lines.
>> +
>> +    | 0 - auto
>> +    | 1 - single
>> +    | 2 - dual
>> +
>> +GMSL specific input parameters
>> +==============================
>> +
>> +**gmsl_mode** (RW):
>> +    GMSL speed mode.
>> +
>> +    | 0 - 12Gb/s
>> +    | 1 - 6Gb/s
>> +    | 2 - 3Gb/s
>> +    | 3 - 1.5Gb/s
>> +
>> +**gmsl_stream_id** (RW):
>> +    The GMSL multi-stream contains up to four video streams. This parameter
>> +    selects which stream is captured by the video input. The value is the
>> +    zero-based index of the stream.
>> +
>> +    *Note: This parameter can not be changed while the input v4l2 device is
>> +    open.*
>> +
>> +**gmsl_fec** (RW):
>> +    GMSL Forward Error Correction (FEC).
>> +
>> +    | 0 - disabled
>> +    | 1 - enabled
>> +
>> +
>> +====================
>> +mgb4 mtd partitions
>> +====================
>> +
>> +The mgb4 driver creates a MTD device with two partitions:
>> + - mgb4-fw.X - FPGA firmware.
>> + - mgb4-data.X - Factory settings, e.g. card serial number.
>> +
>> +The *mgb4-fw* partition is writable and is used for FW updates, *mgb4-data* is
>> +read-only. The *X* attached to the partition name represents the card number.
>> +Depending on the CONFIG_MTD_PARTITIONED_MASTER kernel configuration, you may
>> +also have a third partition named *mgb4-flash* available in the system. This
>> +partition represents the whole, unpartitioned, card's FLASH memory and one should
>> +not fiddle with it...
>> +
>> +====================
>> +mgb4 iio (triggers)
>> +====================
>> +
>> +The mgb4 driver creates an Industrial I/O (IIO) device that provides trigger and
>> +signal level status capability. The following scan elements are available:
>> +
>> +**activity**:
>> +	The trigger levels and pending status.
>> +
>> +	| bit 1 - trigger 1 pending
>> +	| bit 2 - trigger 2 pending
>> +	| bit 5 - trigger 1 level
>> +	| bit 6 - trigger 2 level
>> +
>> +**timestamp**:
>> +	The trigger event timestamp.
>> +
>> +The iio device can operate either in "raw" mode where you can fetch the signal
>> +levels (activity bits 5 and 6) using sysfs access or in triggered buffer mode.
>> +In the triggered buffer mode you can follow the signal level changes (activity
>> +bits 1 and 2) using the iio device in /dev. If you enable the timestamps, you
>> +will also get the exact trigger event time that can be matched to a video frame
>> +(every mgb4 video frame has a timestamp with the same clock source).
>> +
>> +*Note: although the activity sample always contains all the status bits, it makes
>> +no sense to get the pending bits in raw mode or the level bits in the triggered
>> +buffer mode - the values do not represent valid data in such case.*
>> diff --git a/Documentation/admin-guide/media/pci-cardlist.rst b/Documentation/admin-guide/media/pci-cardlist.rst
>> index 42528795d4da..7d8e3c8987db 100644
>> --- a/Documentation/admin-guide/media/pci-cardlist.rst
>> +++ b/Documentation/admin-guide/media/pci-cardlist.rst
>> @@ -77,6 +77,7 @@ ipu3-cio2         Intel ipu3-cio2 driver
>>   ivtv              Conexant cx23416/cx23415 MPEG encoder/decoder
>>   ivtvfb            Conexant cx23415 framebuffer
>>   mantis            MANTIS based cards
>> +mgb4              Digiteq Automotive MGB4 frame grabber
>>   mxb               Siemens-Nixdorf 'Multimedia eXtension Board'
>>   netup-unidvb      NetUP Universal DVB card
>>   ngene             Micronas nGene
>> diff --git a/Documentation/admin-guide/media/v4l-drivers.rst b/Documentation/admin-guide/media/v4l-drivers.rst
>> index 1c41f87c3917..61283d67ceef 100644
>> --- a/Documentation/admin-guide/media/v4l-drivers.rst
>> +++ b/Documentation/admin-guide/media/v4l-drivers.rst
>> @@ -17,6 +17,7 @@ Video4Linux (V4L) driver-specific documentation
>>   	imx7
>>   	ipu3
>>   	ivtv
>> +	mgb4
>>   	omap3isp
>>   	omap4_camera
>>   	philips
> 
> General note regarding the RW attributes: are there default values set by the driver?
> Should those be documented? What happens if you just start streaming without setting
> any of the RW attrs?
> 
> The standard V4L2 model is that there is no such thing as an uninitialized value, i.e.
> there always are reasonable defaults created at probe time. Streaming might not actually
> work if the defaults do not match the incoming signal, but you won't have to deal with
> e.g. zero values or anything like that.
> 
> The same should be done here: there do have to be sane documented initial values.

There are everywhere default values, i.e. no uninitialized values exist 
in the mgb4 driver like in v4l2. I have extended the documentation and 
added the defaults where applicable in v9.

M.

