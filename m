Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1308276CCA3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjHBM2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjHBM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:28:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4560E9B;
        Wed,  2 Aug 2023 05:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6B8261947;
        Wed,  2 Aug 2023 12:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6596C433C7;
        Wed,  2 Aug 2023 12:28:15 +0000 (UTC)
Message-ID: <d038360b-22a2-3869-cd64-2da827736faa@xs4all.nl>
Date:   Wed, 2 Aug 2023 14:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl>
 <87il9xu1ro.wl-tiwai@suse.de>
 <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 14:02, Shengjiu Wang wrote:
> On Wed, Aug 2, 2023 at 7:22 PM Takashi Iwai <tiwai@suse.de> wrote:
>>
>> On Wed, 02 Aug 2023 09:32:37 +0200,
>> Hans Verkuil wrote:
>>>
>>> Hi all,
>>>
>>> On 25/07/2023 08:12, Shengjiu Wang wrote:
>>>> Audio signal processing has the requirement for memory to
>>>> memory similar as Video.
>>>>
>>>> This patch is to add this support in v4l2 framework, defined
>>>> new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
>>>> V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
>>>> for audio case usage.
>>>>
>>>> The created audio device is named "/dev/audioX".
>>>>
>>>> And add memory to memory support for two kinds of i.MX ASRC
>>>> module
>>>
>>> Before I spend time on this: are the audio maintainers OK with doing
>>> this in V4L2?
>>>
>>> I do want to have a clear statement on this as it is not something I
>>> can decide.
>>
>> Well, I personally don't mind to have some audio capability in v4l2
>> layer.  But, the only uncertain thing for now is whether this is a
>> must-have or not.
>>
> 
> Thanks,  I am also not sure about this.  I am also confused that why
> there is no m2m implementation for audio in the kernel.  Audio also
> has similar decoder encoder post-processing as video.
> 
>>
>> IIRC, the implementation in the sound driver side was never done just
>> because there was no similar implementation?  If so, and if the
>> extension to the v4l2 core layer is needed, shouldn't it be more
>> considered for the possible other route?
>>
> 
> Actually I'd like someone could point me to the other route. I'd like to
> try.
> 
> The reason why I select to extend v4l2 for such audio usage is that v4l2
> looks best for this audio m2m implementation.  v4l2 is designed for m2m
> usage.  if we need implement another 'route',  I don't think it can do better
> that v4l2.
> 
> I appreciate that someone can share his ideas or doable solutions.
> And please don't ignore my request, ignore my patch.

To give a bit more background: if it is decided to use the v4l API for this
(and I have no objection to this from my side since API/framework-wise it is a
good fit for this), then there are a number of things that need to be done to
get this into the media subsystem:

- documentation for the new uAPI
- add support for this to v4l2-ctl
- add v4l2-compliance tests for the new device
- highly desirable: have a virtual driver (similar to vim2m) that supports this:
  it could be as simple as just copy input to output. This helps regression
  testing.
- it might need media controller support as well. TBD.

None of this is particularly complex, but taken all together it is a fair
amount of work that also needs a lot of review time from our side.

I want to add one more option to the mix: drivers/media/core/v4l2-mem2mem.c is
the main m2m framework, but it relies heavily on the videobuf2 framework for
the capture and output queues.

The core vb2 implementation in drivers/media/common/videobuf2/videobuf2-core.c
is independent of V4L2 and can be used by other subsystems (in our case, it is
also used by the DVB API). It is a possibility to create an alsa version of
v4l2-mem2mem.c that uses the core vb2 code with an ALSA uAPI on top.

So in drivers/media/common/videobuf2/ you would have a videobuf2-alsa.c besides
the already existing videobuf2-v4l2.c and -dvb.c.

Perhaps parts of v4l2-mem2mem.c can be reused as well in that case, but I am
not sure if it is worth the effort. I suspect copying it to an alsa-mem2mem.c
and adapting it for alsa is easiest if you want to go that way.

Regards,

	Hans
