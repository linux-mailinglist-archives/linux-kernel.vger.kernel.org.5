Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16507AA07E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjIUUjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjIUUiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:38:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600CC85D21;
        Thu, 21 Sep 2023 10:37:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA9C4E67C;
        Thu, 21 Sep 2023 12:13:19 +0000 (UTC)
Message-ID: <a6a6da68-d9f2-44d3-9741-aa2cf83fac6d@xs4all.nl>
Date:   Thu, 21 Sep 2023 14:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 45/49] media: core: Add bitmap manage bufs array
 entries
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
 <20230914133323.198857-46-benjamin.gaignard@collabora.com>
 <1142bbb4-b8f1-44ec-962e-9347a231782f@xs4all.nl>
 <20b6b93e-eef8-3d7b-a3c2-795f220059d4@collabora.com>
 <470682b4-c14b-4237-bc46-fddfdd085026@xs4all.nl>
 <31f298ec-6280-d21b-3d8a-c7bf1c9c0c30@collabora.com>
 <b10a7414-b710-4fb9-a72d-e2d7eff2616d@xs4all.nl>
 <aa649adf-8faf-801b-f6bd-d4a4760e040f@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <aa649adf-8faf-801b-f6bd-d4a4760e040f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 14:05, Benjamin Gaignard wrote:
> 
> Le 21/09/2023 à 12:24, Hans Verkuil a écrit :
>> On 21/09/2023 11:28, Benjamin Gaignard wrote:
>>> Le 20/09/2023 à 16:56, Hans Verkuil a écrit :
>>>> On 20/09/2023 16:30, Benjamin Gaignard wrote:
>>>> <snip>
>>>>
>>>>>>>         num_buffers = min_t(unsigned int, num_buffers,
>>>>>>>                     q->max_allowed_buffers - vb2_get_num_buffers(q));
>>>>>>>     -    first_index = vb2_get_num_buffers(q);
>>>>>>> +    first_index = bitmap_find_next_zero_area(q->bufs_map, q->max_allowed_buffers,
>>>>>>> +                         0, num_buffers, 0);
>>>>>>>           if (first_index >= q->max_allowed_buffers)
>>>>>>>             return 0;
>>>>>>> @@ -675,7 +678,13 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>>>>>>       struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q, unsigned int index)
>>>>>>>     {
>>>>>>> -    if (index < q->num_buffers)
>>>>>>> +    if (!q->bufs_map || !q->bufs)
>>>>>>> +        return NULL;
>>>>>> I don't think this can ever happen.
>>>>> I got kernel crash without them.
>>>>> I will keep them.
>>>> What is the backtrace? How can this happen? It feels wrong that this can be
>>>> called with a vb2_queue that apparently is not properly initialized.
>>> I have this log when adding dump_stack() in vb2_get_buffer() if !q->bufs_bitmap:
>>>
>>> [   18.924627] Call trace:
>>> [   18.927090]  dump_backtrace+0x94/0xec
>>> [   18.930787]  show_stack+0x18/0x24
>>> [   18.934137]  dump_stack_lvl+0x48/0x60
>>> [   18.937833]  dump_stack+0x18/0x24
>>> [   18.941166]  __vb2_queue_cancel+0x23c/0x2f0
>>> [   18.945365]  vb2_core_queue_release+0x24/0x6c
>>> [   18.949740]  vb2_queue_release+0x10/0x1c
>>> [   18.953677]  v4l2_m2m_ctx_release+0x20/0x40
>>> [   18.957892]  hantro_release+0x20/0x54
>>> [   18.961584]  v4l2_release+0x74/0xec
>>> [   18.965110]  __fput+0xb4/0x274
>>> [   18.968205]  __fput_sync+0x50/0x5c
>>> [   18.971626]  __arm64_sys_close+0x38/0x7c
>>> [   18.975562]  invoke_syscall+0x48/0x114
>>> [   18.979329]  el0_svc_common.constprop.0+0xc0/0xe0
>>> [   18.984068]  do_el0_svc+0x1c/0x28
>>> [   18.987402]  el0_svc+0x40/0xe8
>>> [   18.990470]  el0t_64_sync_handler+0x100/0x12c
>>> [   18.994842]  el0t_64_sync+0x190/0x194
>>>
>>> This happen at boot time when hantro driver is open and close without other actions.
>> Ah, now I see the problem. q->bufs and q->bufs_map are allocated in
>> vb2_core_create_bufs and vb2_core_reqbufs, but they should be allocated
>> in vb2_queue_init: that's the counterpart of vb2_core_queue_release.
>>
>> With that change you shouldn't have to check for q->bufs/bufs_map anymore.
> 
> It is a better solution but even like this vb2_core_queue_release() is called
> at least 2 times on the same vivid queue and without testing q->bufs_bitmap
> makes kernel crash.

Do you have a stacktrace for that? Perhaps vb2_core_queue_release should check
for q->bufs/q->bufs_map and return if those are NULL. But it could also be a
bug that it is called twice, it just was never noticed because it was harmless
before.

Regards,

	Hans

> 
>>
>> Regards,
>>
>>     Hans
>>
>>>    
>>>>>>> +
>>>>>>> +    return (bitmap_weight(q->bufs_map, q->max_allowed_buffers) > 0);
>>>>>> How about:
>>>>>>
>>>>>>       return vb2_get_num_buffers(q) > 0;
>>>>> vb2_get_num_buffers is defined in videobuf2-core.c, I'm not sure that
>>>>> an inline function could depend of a module function.
>>>> Not a problem. E.g. v4l2-ctrls.h is full of such static inlines.
>>>>
>>>> Regards,
>>>>
>>>>      Hans
>>>>
>>

