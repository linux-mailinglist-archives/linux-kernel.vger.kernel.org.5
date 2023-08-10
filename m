Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB6777C53
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbjHJPhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbjHJPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:37:46 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 852AF2701;
        Thu, 10 Aug 2023 08:37:43 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id D5B26280C9;
        Thu, 10 Aug 2023 17:37:40 +0200 (CEST)
Message-ID: <352c4a1c-f3dd-25cd-6f5e-8b510688b991@gpxsee.org>
Date:   Thu, 10 Aug 2023 17:37:40 +0200
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
 <067ddd6c-8dc0-91bb-9991-e975c53a1947@gpxsee.org>
 <f30f6521-6854-02ce-3365-c18241e16c05@xs4all.nl>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <f30f6521-6854-02ce-3365-c18241e16c05@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 08. 23 14:43, Hans Verkuil wrote:
> On 8/10/23 13:54, Martin Tůma wrote:
>> On 26. 07. 23 12:40, Hans Verkuil wrote:
>>> On 04/07/2023 15:13, tumic@gpxsee.org wrote:
>>>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>>>
>>>> The "admin-guide" documentation for the Digiteq Automotive MGB4 driver.
>>>>
>>>> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>>> ---
>>>>    Documentation/admin-guide/media/mgb4.rst      | 369 ++++++++++++++++++
>>>>    .../admin-guide/media/pci-cardlist.rst        |   1 +
>>>>    .../admin-guide/media/v4l-drivers.rst         |   1 +
>>>>    3 files changed, 371 insertions(+)
>>>>    create mode 100644 Documentation/admin-guide/media/mgb4.rst
>>>>
>>>> diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
>>>> new file mode 100644
>>>> index 000000000000..e1bb708a2265
>>>> --- /dev/null
>>>> +++ b/Documentation/admin-guide/media/mgb4.rst
>>>> @@ -0,0 +1,369 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +====================
>>>> +mgb4 sysfs interface
>>>> +====================
>>>> +
>>>> +The mgb4 driver provides a sysfs interface, that is used to configure video
>>>> +stream related parameters (some of them must be set properly before the v4l2
>>>> +device can be opened) and obtain the video device/stream status.
>>>> +
>>>> +There are two types of parameters - global / PCI card related, found under
>>>> +``/sys/class/video4linux/videoX/device`` and module specific found under
>>>> +``/sys/class/video4linux/videoX``.
>>>> +
>>>> +
>>>> +Global (PCI card) parameters
>>>> +============================
>>>> +
>>>> +**module_type** (R):
>>>> +    Module type.
>>>> +
>>>> +    | 0 - No module present
>>>> +    | 1 - FPDL3
>>>> +    | 2 - GMSL
>>>> +
>>>> +**module_version** (R):
>>>> +    Module version number. Zero in case of a missing module.
>>>> +
>>>> +**fw_type** (R):
>>>> +    Firmware type.
>>>> +
>>>> +    | 1 - FPDL3
>>>> +    | 2 - GMSL
>>>> +
>>>> +**fw_version** (R):
>>>> +    Firmware version number.
>>>> +
>>>> +**serial_number** (R):
>>>> +    Card serial number. The format is::
>>>> +
>>>> +        PRODUCT-REVISION-SERIES-SERIAL
>>>> +
>>>> +    where each component is a 8b number.
>>>> +
>>>> +
>>>> +Common FPDL3/GMSL input parameters
>>>> +==================================
>>>> +
>>>> +**input_id** (R):
>>>> +    Input number ID, zero based.
>>>> +
>>>> +**oldi_lane_width** (RW):
>>>> +    Number of deserializer output lanes.
>>>> +
>>>> +    | 0 - single
>>>> +    | 1 - dual
>>>> +
>>>> +**color_mapping** (RW):
>>>> +    Mapping of the incoming bits in the signal to the colour bits of the pixels.
>>>> +
>>>> +    | 0 - OLDI/JEIDA
>>>> +    | 1 - SPWG/VESA
>>>> +
>>>> +**link_status** (R):
>>>> +    Video link status. If the link is locked, chips are properly connected and
>>>> +    communicating at the same speed and protocol. The link can be locked without
>>>> +    an active video stream.
>>>> +
>>>> +    A value of 0 is equivalent to the V4L2_IN_ST_NO_SYNC flag of the V4L2
>>>> +    VIDIOC_ENUMINPUT status bits.
>>>> +
>>>> +    | 0 - unlocked
>>>> +    | 1 - locked
>>>> +
>>>> +**stream_status** (R):
>>>> +    Video stream status. A stream is detected if the link is locked, the input
>>>> +    pixel clock is running and the DE signal is moving.
>>>> +
>>>> +    A value of 0 is equivalent to the V4L2_IN_ST_NO_SIGNAL flag of the V4L2
>>>> +    VIDIOC_ENUMINPUT status bits.
>>>> +
>>>> +    | 0 - not detected
>>>> +    | 1 - detected
>>>> +
>>>> +**video_width** (R):
>>>> +    Video stream width. This is the actual width as detected by the HW.
>>>> +
>>>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in the width
>>>> +    field of the v4l2_bt_timings struct.
>>>> +
>>>> +**video_height** (R):
>>>> +    Video stream height. This is the actual height as detected by the HW.
>>>> +
>>>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in the height
>>>> +    field of the v4l2_bt_timings struct.
>>>> +
>>>> +**vsync_status** (R):
>>>> +    The type of VSYNC pulses as detected by the video format detector.
>>>> +
>>>> +    The value is equivalent to the flags returned by VIDIOC_QUERY_DV_TIMINGS in
>>>> +    the polarities field of the v4l2_bt_timings struct.
>>>> +
>>>> +    | 0 - active low
>>>> +    | 1 - active high
>>>> +    | 2 - not available
>>>> +
>>>> +**hsync_status** (R):
>>>> +    The type of HSYNC pulses as detected by the video format detector.
>>>> +
>>>> +    The value is equivalent to the flags returned by VIDIOC_QUERY_DV_TIMINGS in
>>>> +    the polarities field of the v4l2_bt_timings struct.
>>>> +
>>>> +    | 0 - active low
>>>> +    | 1 - active high
>>>> +    | 2 - not available
>>>> +
>>>> +**vsync_gap_length** (RW):
>>>> +    If the incoming video signal does not contain synchronization VSYNC and
>>>> +    HSYNC pulses, these must be generated internally in the FPGA to achieve
>>>> +    the correct frame ordering. This value indicates, how many "empty" pixels
>>>
>>> Pixels or lines? This is vsync, so lines would be more logical.
>>>
>>> Even if the hardware wants pixels, perhaps the driver should use lines and
>>> translate it to pixels. It's much easier for userspace to work with lines.
>>>
>>
>> According to our HW engineers, this is properly documented. I do not
>> have the full insight to the "signal parameters" topic, so my answers
>> here will be just some kind of "free" translation of what I got. The
>> justification here was, that the vsync gap length (in our case/HW)
>> represents something slightly different than you may think.
>>
>>>> +    (pixels with deasserted Data Enable signal) are necessary to generate the
>>>> +    internal VSYNC pulse.
>>>> +
>>>> +**hsync_gap_length** (RW):
>>>> +    If the incoming video signal does not contain synchronization VSYNC and
>>>> +    HSYNC pulses, these must be generated internally in the FPGA to achieve
>>>> +    the correct frame ordering. This value indicates, how many "empty" pixels
>>>> +    (pixels with deasserted Data Enable signal) are necessary to generate the
>>>> +    internal HSYNC pulse. The value must be greater than 1 and smaller than
>>>> +    vsync_gap_length.
>>>
>>> Does this make sense? vsync_gap_length can be many video lines, which makes
>>> not sense for hsync_gap_length.
>>>
>>> I wonder if it isn't easier to just change this to v/hsync_blanking_length
>>> (lines for vsync, pixels for hsync) to indicate the length of the blanking
>>> periods, and then let the driver pick a suitable hsync/vsync position.
>>>
>>
>> Dtto.
> 
> So the problem here is that if I don't understand what is meant here, how will
> a user of this driver be able to understand it?
> 
> I think it would be better to give one or two examples of devices and their
> configuration. Or refer to freely available documentation, if that is available.
>

Those two parameters are very rare to be used and it is expected that 
users with the corresponding HW (signal source/displays) will either be 
experts on that topic or they will simply get the parameters as "magic 
numbers" from us after we test the HW and obtain the correct values. As 
far as I can decipher the info from the HW engineers, this is a quiet 
non-standard parameter that is hard to find in any documentation, but 
for some "exotic" systems it is required for the mgb4 to work with the 
corresponding HW.

> Also note that v9 doesn't mentioned default values for these two properties.
> 

I have not put the defaults here because in most cases the "default" is 
that this value is not used (the signal has VSYNC/HSYNC). And when it is 
needed, the value has to be changed to fit the HW anyway as chances to 
match any default value are almost zero. All other values are the 
defaults of a particular display/entertainment system (Škoda Octavia 
III)* but here I myself (unlike the HW people) have not even access to 
any HW to test it...

One can however always read-out the value if he desperately needs the 
default value.

M.

* Officially this is the reference system that shall be quiet accessible 
for the customers as this infotainment system is quite widespread in the 
VW concern, but the real reason is, it is the system laying on my desk ;-)
