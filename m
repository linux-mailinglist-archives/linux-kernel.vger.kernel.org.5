Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFC7A9FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjIUU1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIUU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E567356B;
        Thu, 21 Sep 2023 10:33:16 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:9fdf:789a:7434:5a59] (unknown [IPv6:2a01:e0a:120:3210:9fdf:789a:7434:5a59])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33A2566072EA;
        Thu, 21 Sep 2023 13:46:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695300403;
        bh=LVEZ1RsG9zACgcHPee3WTOL671cvZoROVfJ92IP6s4Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z7acJaSzlHDcCiwLMiECWrrw5UijdlQ+DYiCsWekWoNpZ3tWGx6RqitZQ5cmt7bpf
         r8MU3UuFwvDJzNYe1xL5Y/b3xLsQy0Phe/0FacTfJDAd76T/xFvJsFSKXzdi7cqygT
         nnR/uVG3c5M9+pdpeUljAGo+Ro7bh3NzUCc7J3/ZVMKPQmZV5Ar34/V7nSYyhf7xVi
         RjGOqVm5mGQxUBr22OlVpTmp3jupc+1vblk/eBLz/A9XDq3XaZ2d0hvxOepERS1ZdT
         9mjN13gH3bQTbVtxurYBzMHh5jfHpAcMC56+t7Ip6d0FjST8TjTAN+DXWqnN9PFxMc
         NU4rD8cbt2+6g==
Message-ID: <c8b7db47-3875-a10b-8d81-a0b3dcbc564a@collabora.com>
Date:   Thu, 21 Sep 2023 14:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 45/49] media: core: Add bitmap manage bufs array
 entries
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
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
 <a6a6da68-d9f2-44d3-9741-aa2cf83fac6d@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <a6a6da68-d9f2-44d3-9741-aa2cf83fac6d@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 21/09/2023 à 14:13, Hans Verkuil a écrit :
> On 21/09/2023 14:05, Benjamin Gaignard wrote:
>> Le 21/09/2023 à 12:24, Hans Verkuil a écrit :
>>> On 21/09/2023 11:28, Benjamin Gaignard wrote:
>>>> Le 20/09/2023 à 16:56, Hans Verkuil a écrit :
>>>>> On 20/09/2023 16:30, Benjamin Gaignard wrote:
>>>>> <snip>
>>>>>
>>>>>>>>          num_buffers = min_t(unsigned int, num_buffers,
>>>>>>>>                      q->max_allowed_buffers - vb2_get_num_buffers(q));
>>>>>>>>      -    first_index = vb2_get_num_buffers(q);
>>>>>>>> +    first_index = bitmap_find_next_zero_area(q->bufs_map, q->max_allowed_buffers,
>>>>>>>> +                         0, num_buffers, 0);
>>>>>>>>            if (first_index >= q->max_allowed_buffers)
>>>>>>>>              return 0;
>>>>>>>> @@ -675,7 +678,13 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>>>>>>>        struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q, unsigned int index)
>>>>>>>>      {
>>>>>>>> -    if (index < q->num_buffers)
>>>>>>>> +    if (!q->bufs_map || !q->bufs)
>>>>>>>> +        return NULL;
>>>>>>> I don't think this can ever happen.
>>>>>> I got kernel crash without them.
>>>>>> I will keep them.
>>>>> What is the backtrace? How can this happen? It feels wrong that this can be
>>>>> called with a vb2_queue that apparently is not properly initialized.
>>>> I have this log when adding dump_stack() in vb2_get_buffer() if !q->bufs_bitmap:
>>>>
>>>> [   18.924627] Call trace:
>>>> [   18.927090]  dump_backtrace+0x94/0xec
>>>> [   18.930787]  show_stack+0x18/0x24
>>>> [   18.934137]  dump_stack_lvl+0x48/0x60
>>>> [   18.937833]  dump_stack+0x18/0x24
>>>> [   18.941166]  __vb2_queue_cancel+0x23c/0x2f0
>>>> [   18.945365]  vb2_core_queue_release+0x24/0x6c
>>>> [   18.949740]  vb2_queue_release+0x10/0x1c
>>>> [   18.953677]  v4l2_m2m_ctx_release+0x20/0x40
>>>> [   18.957892]  hantro_release+0x20/0x54
>>>> [   18.961584]  v4l2_release+0x74/0xec
>>>> [   18.965110]  __fput+0xb4/0x274
>>>> [   18.968205]  __fput_sync+0x50/0x5c
>>>> [   18.971626]  __arm64_sys_close+0x38/0x7c
>>>> [   18.975562]  invoke_syscall+0x48/0x114
>>>> [   18.979329]  el0_svc_common.constprop.0+0xc0/0xe0
>>>> [   18.984068]  do_el0_svc+0x1c/0x28
>>>> [   18.987402]  el0_svc+0x40/0xe8
>>>> [   18.990470]  el0t_64_sync_handler+0x100/0x12c
>>>> [   18.994842]  el0t_64_sync+0x190/0x194
>>>>
>>>> This happen at boot time when hantro driver is open and close without other actions.
>>> Ah, now I see the problem. q->bufs and q->bufs_map are allocated in
>>> vb2_core_create_bufs and vb2_core_reqbufs, but they should be allocated
>>> in vb2_queue_init: that's the counterpart of vb2_core_queue_release.
>>>
>>> With that change you shouldn't have to check for q->bufs/bufs_map anymore.
>> It is a better solution but even like this vb2_core_queue_release() is called
>> at least 2 times on the same vivid queue and without testing q->bufs_bitmap
>> makes kernel crash.
> Do you have a stacktrace for that? Perhaps vb2_core_queue_release should check
> for q->bufs/q->bufs_map and return if those are NULL. But it could also be a
> bug that it is called twice, it just was never noticed because it was harmless
> before.

I have added some printk to log that when running test-media on vivid:

[  130.497426] vb2_core_queue_init queue cap-0000000050d195ab allocate q->bufs 00000000dc2c15ed and q->bufs_bitmap 000000008173fc5a
...
[  130.733967] vb2_core_queue_release queue cap-0000000050d195ab release q->bufs and q->bufs_bitmap
[  133.866345] vb2_get_buffer queue cap-0000000050d195ab q->bufs_bitmap is NULL
[  133.873454] CPU: 1 PID: 321 Comm: v4l2-ctl Not tainted 6.6.0-rc1+ #542
[  133.879997] Hardware name: NXP i.MX8MQ EVK (DT)
[  133.884536] Call trace:
[  133.886988]  dump_backtrace+0x94/0xec
[  133.890673]  show_stack+0x18/0x24
[  133.894002]  dump_stack_lvl+0x48/0x60
[  133.897681]  dump_stack+0x18/0x24
[  133.901009]  __vb2_queue_cancel+0x250/0x31c
[  133.905209]  vb2_core_queue_release+0x24/0x88
[  133.909580]  _vb2_fop_release+0xb0/0xbc
[  133.913428]  vb2_fop_release+0x2c/0x58
[  133.917187]  vivid_fop_release+0x80/0x388 [vivid]
[  133.921948]  v4l2_release+0x74/0xec
[  133.925452]  __fput+0xb4/0x274
[  133.928520]  __fput_sync+0x50/0x5c
[  133.931934]  __arm64_sys_close+0x38/0x7c
[  133.935868]  invoke_syscall+0x48/0x114
[  133.939630]  el0_svc_common.constprop.0+0x40/0xe0
[  133.944349]  do_el0_svc+0x1c/0x28
[  133.947677]  el0_svc+0x40/0xe8
[  133.950741]  el0t_64_sync_handler+0x100/0x12c
[  133.955109]  el0t_64_sync+0x190/0x194

and later I have a call to reqbufs on the same queue without call to vb2_core_queue_init before

[   58.696812] __vb2_queue_alloc queue cap- 0000000050d195abq->bufs_bitmap is NULL
[   58.704148] CPU: 1 PID: 319 Comm: v4l2-compliance Not tainted 6.6.0-rc1+ #544
[   58.711291] Hardware name: NXP i.MX8MQ EVK (DT)
[   58.715826] Call trace:
[   58.718274]  dump_backtrace+0x94/0xec
[   58.721951]  show_stack+0x18/0x24
[   58.725274]  dump_stack_lvl+0x48/0x60
[   58.728946]  dump_stack+0x18/0x24
[   58.732268]  __vb2_queue_alloc+0x4a8/0x50c
[   58.736374]  vb2_core_reqbufs+0x274/0x46c
[   58.740391]  vb2_ioctl_reqbufs+0xb0/0xe8
[   58.744320]  vidioc_reqbufs+0x50/0x64 [vivid]
[   58.748717]  v4l_reqbufs+0x50/0x64
[   58.752125]  __video_do_ioctl+0x164/0x3c8
[   58.756140]  video_usercopy+0x200/0x668
[   58.759982]  video_ioctl2+0x18/0x28
[   58.763475]  v4l2_ioctl+0x40/0x60
[   58.766798]  __arm64_sys_ioctl+0xac/0xf0
[   58.770730]  invoke_syscall+0x48/0x114
[   58.774487]  el0_svc_common.constprop.0+0x40/0xe0
[   58.779199]  do_el0_svc+0x1c/0x28
[   58.782520]  el0_svc+0x40/0xe8
[   58.785580]  el0t_64_sync_handler+0x100/0x12c
[   58.789942]  el0t_64_sync+0x190/0x194

>
> Regards,
>
> 	Hans
>
>>> Regards,
>>>
>>>      Hans
>>>
>>>>     
>>>>>>>> +
>>>>>>>> +    return (bitmap_weight(q->bufs_map, q->max_allowed_buffers) > 0);
>>>>>>> How about:
>>>>>>>
>>>>>>>        return vb2_get_num_buffers(q) > 0;
>>>>>> vb2_get_num_buffers is defined in videobuf2-core.c, I'm not sure that
>>>>>> an inline function could depend of a module function.
>>>>> Not a problem. E.g. v4l2-ctrls.h is full of such static inlines.
>>>>>
>>>>> Regards,
>>>>>
>>>>>       Hans
>>>>>
>
