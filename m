Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297AE78EF40
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbjHaOG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345110AbjHaOG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F20ECC;
        Thu, 31 Aug 2023 07:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B993263F83;
        Thu, 31 Aug 2023 14:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BEBC433C7;
        Thu, 31 Aug 2023 14:06:19 +0000 (UTC)
Message-ID: <ecc13f10-82b9-f99b-8ebf-ff505d65fe2e@xs4all.nl>
Date:   Thu, 31 Aug 2023 16:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v14 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
Content-Language: en-US, nl
To:     Kun-Fa Lin <milkfafa@gmail.com>
Cc:     mchehab@kernel.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrzej.p@collabora.com,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
References: <20230828091859.3889817-1-milkfafa@gmail.com>
 <20230828091859.3889817-8-milkfafa@gmail.com>
 <0c91f68d-d172-bd14-9115-b6977ad2d01f@xs4all.nl>
 <CADnNmFqVbRWs5Uf_tJdrM0AopF_CmSHYwBK8-+1go_K6Hefkcw@mail.gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CADnNmFqVbRWs5Uf_tJdrM0AopF_CmSHYwBK8-+1go_K6Hefkcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2023 14:42, Kun-Fa Lin wrote:
> Hi Hans,
> 
> Thanks for the review.
> 
>>> +     snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s", DEVICE_NAME);
>>
>> You can drop this last line, it is already filled in by the V4L2 core for
>> platform devices.
> 
>>> +static const char * const npcm_ctrl_capture_mode_menu[] = {
>>> +     "COMPLETE mode",
>>> +     "DIFF mode",
>>
>> Hmm, I would drop the 'mode' bit, since it is already obvious that
>> these are the modes.
> 
> OK. Will drop them in the next version.
> 
>>> +static const struct v4l2_ctrl_config npcm_ctrl_rect_count = {
>>> +     .ops = &npcm_video_ctrl_ops,
>>> +     .id = V4L2_CID_NPCM_RECT_COUNT,
>>> +     .name = "NPCM Compressed Hextile Rectangle Count",
>>> +     .type = V4L2_CTRL_TYPE_INTEGER,
>>> +     .flags = V4L2_CTRL_FLAG_VOLATILE,
>>> +     .min = 0,
>>> +     .max = (MAX_WIDTH / RECT_W) * (MAX_HEIGHT / RECT_H),
>>> +     .step = 1,
>>> +     .def = 0,
>>> +};
>>
>> Just to confirm: you decided against using an integer array control?
>>
>> There is a real danger that if userspace isn't reading this control
>> quickly enough (i.e. before the next frame arrives at the driver), then
>> the control's value is that of that next frame instead of the current
>> frame.
>>
>> It doesn't feel robust to me.
> 
> Actually the driver will store the frames and counts for each buffer
> index till userspace dequeues them.
> 
> Ex. assume that driver has captured 3 frames:
> - 1st capture (buffer index = 0):
>      video->list[0] => store the list of HEXTILE rects for the 1st frame
>      video->rect[0] => store the rect count of video->list[0]
> - 2nd capture (buffer index = 1):
>      video->list[1] => store the list of HEXTILE rects for the 2nd frame
>      video->rect[1] => store the rect count of video->list[1]
> - 3rd capture (buffer index = 2):
>      video->list[2] => store the list of HEXTILE rects for the 3rd frame
>      video->rect[2] => store the rect count of video->list[2]
> 
> When userspace dequeues the 1st buffer (video->list[0]), it needs to
> know the count of HEXTILE rectangles in the buffer,
> so after dequeuing the buffer it will call this control to get the
> rect count (video->rect[0]). And when a buffer is dequeued,
> npcm_video_buf_finish() will be called, in which the buffer index (in
> this example, buffer index = 0) will be stored to video->vb_index.
> Then when userspace calls this control, npcm_video_get_volatile_ctrl()
> will return the rect count of vb_index = 0.
> In this way, I think userspace is always reading the correct control's
> value even if userspace is slow.
> Does it make sense to you or is there anything I missed?

Ah, I don't think I have ever seen anyone use buf_finish in that way!

Very inventive, and perfectly legal. Actually a very nice idea!

So, with that in mind there are still some things that need to change.

First of all, you can drop the 'VOLATILE' flag from the control, instead
just call v4l2_ctrl_s_ctrl() from buf_finish() to update the control.
And in stop_streaming the control value should probably be set to 0.

The use of volatile for a control is a last resort, and in this case it
is not volatile at all.

Secondly, this behavior has to be documented: in buf_finish add a comment
along the lines of: "This callback is called when the buffer is dequeued,
so update this control with the number of rectangles."

And where the control is defined, refer to buf_finish to explain where it
is set.

Finally the user-facing documentation has to be updated (npcm-video.rst)
to explain this behavior.

Regards,

	Hans
