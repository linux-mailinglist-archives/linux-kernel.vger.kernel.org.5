Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A175FDB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjGXRaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGXRaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:30:07 -0400
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5400:ff:fe00:d7d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F36171B;
        Mon, 24 Jul 2023 10:29:59 -0700 (PDT)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id C5A0730662E;
        Tue, 25 Jul 2023 02:29:36 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info C5A0730662E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1690219780; bh=4juxKN/hgl1WmyDbpdvCcLvHrtYFW8/zR2S/ezNP+V8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rMyLfzLZa2BpbsW02CuD6pqvTUlVSlcfKz7FNJHPA9wxQmnBpszRiPNfqK4D2slp6
         kfHQeONxFIFlmkiDEI/6JN+jVdyH0KJDaYawnKnqN+4adAgkqo15BMKqPFk3QsmClK
         RxN1JhqmMo/3HaMXXWnYPPt8/w5Fiifp4WLhQTu0=
Message-ID: <cff4411d-4a19-547f-0930-9fcfa6522ac2@soulik.info>
Date:   Tue, 25 Jul 2023 01:29:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] [RESEND] media: v4l2-mem2mem: allow device run
 without buf
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Hsia-Jun Li <Randy.Li@synaptics.com>, hans.verkuil@cisco.com,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        hiroh@chromium.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-2-randy.li@synaptics.com>
 <20452e233a9a4b39b58139081d818d3b1454105a.camel@ndufresne.ca>
 <20230712093129.pdcbvlxd5zphwr5m@chromium.org>
 <17ca8c5ee31ac8e48bb2ac7f89f6bae84816c893.camel@ndufresne.ca>
 <452a4d48-fd73-d539-25f6-ded6bc6212bc@synaptics.com>
 <801aaaaaa77f28c6fc8f1bcb46b4410f663ec97e.camel@ndufresne.ca>
Content-Language: en-US
From:   Randy Li <ayaka@soulik.info>
In-Reply-To: <801aaaaaa77f28c6fc8f1bcb46b4410f663ec97e.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/22 00:22, Nicolas Dufresne wrote:
> Le vendredi 21 juillet 2023 à 16:56 +0800, Hsia-Jun Li a écrit :
>> On 7/17/23 22:00, Nicolas Dufresne wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> Le mercredi 12 juillet 2023 à 09:31 +0000, Tomasz Figa a écrit :
>>>> On Fri, Jul 07, 2023 at 03:14:23PM -0400, Nicolas Dufresne wrote:
>>>>> Hi Randy,
>>>>>
>>>>> Le mardi 04 juillet 2023 à 12:00 +0800, Hsia-Jun Li a écrit :
>>>>>> From: Randy Li <ayaka@soulik.info>
>>>>>>
>>>>>> For the decoder supports Dynamic Resolution Change,
>>>>>> we don't need to allocate any CAPTURE or graphics buffer
>>>>>> for them at inital CAPTURE setup step.
>>>>>>
>>>>>> We need to make the device run or we can't get those
>>>>>> metadata.
>>>>>>
>>>>>> Signed-off-by: Randy Li <ayaka@soulik.info>
>>>>>> ---
>>>>>>    drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>> index 0cc30397fbad..c771aba42015 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>> @@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>>>>>>
>>>>>>     dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
>>>>>>
>>>>>> - if (!m2m_ctx->out_q_ctx.q.streaming
>>>>>> -     || !m2m_ctx->cap_q_ctx.q.streaming) {
>>>>>> + if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered)
>>>>>> +     || !(m2m_ctx->cap_q_ctx.q.streaming
>>>>>> +          || m2m_ctx->cap_q_ctx.buffered)) {
>>>>> I have a two atches with similar goals in my wave5 tree. It will be easier to
>>>>> upstream with an actual user, though, I'm probably a month or two away from
>>>>> submitting this driver again.
>>>>>
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.collabora.com_chipsnmedia_kernel_-2D_commit_ac59eafd5076c4deb3bfe1fb85b3b776586ef3eb&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=9eWwqueFnh1yZHTW11j-syNVQvema7iBzNQeX1GKUQwXZ9pm6V4HDL_R2tIYKoOw&s=Ez5AyEYFIAJmC_k00IPO_ImzVdLZjr_veRq1bN4RSNg&e=
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.collabora.com_chipsnmedia_kernel_-2D_commit_5de4fbe0abb20b8e8d862b654f93e3efeb1ef251&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=9eWwqueFnh1yZHTW11j-syNVQvema7iBzNQeX1GKUQwXZ9pm6V4HDL_R2tIYKoOw&s=tM81gjNe-bTjpjmidZ1sAhiodMh6npcVJNOhMCi1mPo&e=
>>>>>
>>>> While I'm not going to NAK this series or those 2 patches if you send
>>>> them, I'm not really convinced that adding more and more complexity to
>>>> the mem2mem helpers is a good idea, especially since all of those seem
>>>> to be only needed by stateful video decoders.
>>>>
>>>> The mem2mem framework started as a set of helpers to eliminate boiler
>>>> plate from simple drivers that always get 1 CAPTURE and 1 OUTPUT buffer,
>>>> run 1 processing job on them and then return both of the to the userspace
>>>> and I think it should stay like this.
>>> Its a bit late to try and bring that argument. It should have been raised couple
>>> of years ago (before I even started helping with these CODEC). Now that all the
>>> newly written stately decoders uses this framework, it is logical to keep
>>> reducing the boiler plate for these too. In my opinion, the job_ready()
>>> callback, should have been a lot more flexible from the start. And allowing
>>> driver to make it more powerful does not really add that much complexity.
>>>
>>> Speaking of complexity, driving the output manually (outside of the job
>>> workqueue) during sequence initialization is a way more complex and risky then
>>> this. Finally, sticking with 1:1 pattern means encoder, detilers, image
>>> enhancement reducing framerate, etc. would all be unwelcome to use this. Which
>>> in short, means no one should even use this.
>>>
>> I think those things are m2m, but it would be hard to present in current
>> m2m framework:
>> 1. N:1 compositor(It may be implemented as a loop running 2:1 compositor).
> Correct, only SRC/DST/BG type of blitters can be supported for compositing,
> which is quite limiting. Currently there is no way to make an N:1 M2M, as M2M
> instances are implemented at the video node layer, and not at the MC layer. This
> is a entirely new subject and API design space to tackle (same goes for 1:N,
> like multi scalers, svc decoders etc.).
SVC case is the one I mention in the talk, although the major problem 
may only happens to SVC-S.
>
>> 2. AV1 film gain
> For AV1/HEVC film grain, it is handle similar to inline converters and scalers.

I know a few decoders in the market didn't implement such feature in the 
its hardware, they rely on the other hardware.

Actually, it would be better to let NPU do such job.

> The driver secretly allocate the reference frames, and post process into the
> user visible buffers.
Hiding internal buffer is the worst case, frame buffer could be large.
> It breaks some assumption made by most protected memory
> setup though, as not all allocation is user driven, meaning the decoder needs to
> know if its secure or not. Secure memory is a also another API design space to
> tackle.
>
>> 3. HDR with dynamic meta data to SDR
> True, but easy to design around the stateless model. I'm not worried for these.
The current stateless API won't support DMA buffer for the metadata.
>
>> The video things fix for m2m model could be just a little less complex
>> than ISP or camera pipeline. The only difference is just ISP won't have
>> multiple contexts running at the same time.
> I thought that having the kernel schedule ISP reprocessing jobs (which requires
> instances) would be nice. But this can only be solved after we have solved the
> N:N use cases of m2m (with multiple instances).
>
>> If we could design a model for the video encoder I think we could solve
>> the most of problems.
>> A video encoder would have:
>> 1. input graphics buffer
>> 2. reconstruction graphics buffer
>> 3. motion vector cache buffer(optional)
>> 4. coded bitstream output
>> 5. encoding statistic report
>>>> I think we're strongly in need of a stateful video decoder framework that
>>>> would actually address the exact problems that those have rather than
>>>> bending something that wasn't designed with them in mind to work around the
>>>> differences.
>>> The bend is already there, of course I'd be happy to help with any new
>>> framework. Specially on modern stateless, were there is a need to do better
>>> scheduling.
>> I didn't know the schedule problem about stateless codec, are they
>> supposed to be in the job queue when the buffers that DPB requests are
>> own by the driver and its registers are prepared except the trigger bit?
> On RK3588 at least, decoder scheduling is going to be complex. There is an even
> number of cores, but when you need to decode 8K, you have to pair two cores
> (there is a specific set of cores that are to be paired with). We need a decent

How do two cores work parallel? Tiles ?

But AV1 could do intra block copy.

> scheduling logic to ensure we don't starve 8K decoding session when there is
> multiple smaller resolution session on-going.
>
> On MTK, the entropy decoding (LAT) and the reconstruction (CORE) is split. MTK
> vcodec is using multiple workqueues to move jobs around, which is clearly
> expensive. Also, the life time of a job is not exactly easy to manage.

This model sounds easy,

LAT produces partial frame buffer with intra blocks and its motion 
vector buffer

CORE complete the frame from the motion vector buffer and its reference 
buffers

We just separately two hardware devices here.

>
> On RPi HEVC (not upstream yet, but being worked on), the entropy decoding and
> reconstruction is done one the same core, but remains 2 concurrent operation.
> Does not impose a complex scheduling issue, but it raised the need for a way to
> fully utilize such HW.

This sounds be more complex than MTK's case. It would be hard to measure 
the job length with entropy part and inter construction part.

Although usually the later one would consume more memory bandwidth or 
hardware time.

>
> This is just some examples of complexity for which the current framework is not
> that helpful (even though, its not impossible either).
>
>>    Just ping me if you have some effort starting, I don't currently
>>> have a budget or bandwidth to write new drivers or port existing drivers them on
>>> a newly written framework.
>>>
>>> Nicolas
>>>
>>>
>>> [...]
