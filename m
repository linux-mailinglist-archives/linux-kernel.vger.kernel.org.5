Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453737AACFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjIVIo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjIVIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:44:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C471A2;
        Fri, 22 Sep 2023 01:44:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A04C433C8;
        Fri, 22 Sep 2023 08:44:10 +0000 (UTC)
Message-ID: <3e053387-4ba6-49bc-a59a-46854e0a7c26@xs4all.nl>
Date:   Fri, 22 Sep 2023 10:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder
 driver
Content-Language: en-US, nl
To:     =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
 <20230911125936.10648-13-yunfei.dong@mediatek.com>
 <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
 <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl>
 <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
 <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
 <CA+ddPcN6EaFERC60_Z_-ZmWzqyUEwxiDCZwt_U6Y-gpaAu76tA@mail.gmail.com>
 <ff7aa575-c820-4dfa-853f-77438b8b149a@xs4all.nl>
 <b7d661637eacbda3e83d192b1126fc3970c4f50d.camel@collabora.com>
 <c3d14f64-bf04-46b9-ac7b-af7ef9014335@xs4all.nl>
 <00302ac675af858eb11d8398f100921af806bc30.camel@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <00302ac675af858eb11d8398f100921af806bc30.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 05:28, Yunfei Dong (董云飞) wrote:
> Hi Hans,
> 
> Thanks for your help to give some good advice.
> On Wed, 2023-09-20 at 09:20 +0200, Hans Verkuil wrote:
>>  	 
>>>>>> In any case, using a control to switch to secure mode and using
>> a control
>>>>>> to convert a dmabuf fd to a secure handle seems a poor choice to
>> me.
>>>>>>
>>>>>> I was wondering if it wouldn't be better to create a new
>> V4L2_MEMORY_ type,
>>>>>> e.g. V4L2_MEMORY_DMABUF_SECURE (or perhaps _DMABUF_OPTEE). That
>> ensures that
>>>>>> once you create buffers for the first time, the driver can
>> switch into secure
>>>>>> mode, and until all buffers are released again you know that the
>> driver will
>>>>>> stay in secure mode.
>>>>>
>>>>> Why do you think the control for setting secure mode is a poor
>> choice?
>>>>> There's various places in the driver code where functionality
>> changes
>>>>> based on being secure/non-secure mode, so this is very much a
>> 'global'
>>>>> setting for the driver. It could be inferred based off a new
>> memory
>>>>> type for the queues...which then sets that flag in the driver;
>> but
>>>>> that seems like it would be more fragile and would require
>> checking
>>>>> for incompatible output/capture memory types. I'm not against
>> another
>>>>> way of doing this; but didn't see why you think the proposed
>> method is
>>>>> a poor choice.
>>>>
>>>> I assume you are either decoding to secure memory all the time, or
>> not
>>>> at all. That's something you would want to select the moment you
>> allocate
>>>> the first buffer. Using the V4L2_MEMORY_ value would be the
>> natural place
>>>> for that. A control can typically be toggled at any time, and it
>> makes
>>>> no sense to do that for secure streaming.
>>>>
>>>> Related to that: if you pass a dmabuf fd you will need to check
>> somewhere
>>>> if the fd points to secure memory or not. You don't want to mix
>> the two
>>>> but you want to check that at VIDIOC_QBUF time.
>>>>
>>>> Note that the V4L2_MEMORY_ value is already checked in the v4l2
>> core,
>>>> drivers do not need to do that.
>>>
>>> Just to clarify a bit, and make sure I understand this too. You are
>> proposing to
>>> introduce something like:
>>>
>>>    V4L2_MEMORY_SECURE_DMABUF
>>>
>>> Which like V4L2_MEMORY_DMABUF is meant to import dmabuf, while
>> telling the
>>> driver that the memory is secure according to the definition of
>> "secure" for the
>>> platform its running on.
>>>
>>> This drivers also allocate secure SHM (a standard tee concept) and
>> have internal
>>> allocation for reconstruction buffer and some hw specific reference
>> metadata. So
>>> the idea would be that it would keep allocation using the dmabuf
>> heap internal
>>> APIs ? And decide which type of memory based on the memory type
>> found in the
>>> queue?
>>
>> Yes. Once you request the first buffer you basically tell the driver
>> whether it
>> will operate in secure or non-secure mode, and that stays that way
>> until all
>> buffers are freed. I think that makes sense.
>>
> 
> According to iommu's information, the dma operation for secure and non-
> secure are the same, whether just need to add one memory type in v4l2
> framework the same as V4L2_MEMORY_DMABUF? The dma operation in
> videobuf2-dma-contig.c can use the same functions.

So if I pass a non-secure dma fd to the capture queue of the codec, who
will check that it can't write the data to that fd? Since doing so would
expose the video. Presumably at some point the tee code will prevent that?
(I sincerely hope so!)

Having a separate V4L2_MEMORY_DMABUF_SECURE type is to indicate to the
driver that 1) it can expect secure dmabuf fds, 2) it can configure itself
for that (that avoids using a control to toggle between normal and secure mode),
and at VIDIOC_QBUF time it is easy for the V4L2 core to verify that the
fd that is passed in is for secure memory. This means that mistakes by
userspace are caught at QBUF time.

Of course, this will not protect you (people can disable this check by
recompiling the kernel), that still has to be done by the firmware, but
it catches userspace errors early on.

Also, while for this hardware the DMA operation is the same, that might
not be the case for other hardware.

Regards,

	Hans

> 
> Best Regards,
> Yunfei Dong
> 

