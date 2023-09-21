Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC117A9792
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjIURZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjIURZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:25:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5F40679;
        Thu, 21 Sep 2023 10:13:16 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:9fdf:789a:7434:5a59] (unknown [IPv6:2a01:e0a:120:3210:9fdf:789a:7434:5a59])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 46F3066072F2;
        Thu, 21 Sep 2023 10:28:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695288491;
        bh=7cWF6ZvU+KANva5DnNTVmLHFyd+/y6UpOK+LTrLjt9s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=curIueGoPYgbnIIMKMzX4FKdIZrLZSskm/tPQ1MrKWGQ1y93tb3M5jSjUnbPsahHM
         U2MdyjWSjFAT/VV6QCT0uXyxh1FJZOlinGEUWNWWbwSq/b1Sz8Zasa/bhKG4UXkGf5
         Jn4/dpOqEC1tA1ZKkipKdribhQE9T948aKP00yFARr3Stt8We21FW338M4ECtwpOZO
         OCNOzd/0r3xoCDgbZEgNz6R8AWtr0c+PyGy2odrqzeUMf0IkbEBqXmOOyJ+p1eZHFK
         +b/95Y4J6RkWiD6+9BM/2SBEYq3UiewhDMw0o9UuvqFCtw/XsLzZY1UO4HbuxYuE0r
         QlzoXtwI8IZ6w==
Message-ID: <31f298ec-6280-d21b-3d8a-c7bf1c9c0c30@collabora.com>
Date:   Thu, 21 Sep 2023 11:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 45/49] media: core: Add bitmap manage bufs array
 entries
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
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <470682b4-c14b-4237-bc46-fddfdd085026@xs4all.nl>
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


Le 20/09/2023 à 16:56, Hans Verkuil a écrit :
> On 20/09/2023 16:30, Benjamin Gaignard wrote:
> <snip>
>
>>>>        num_buffers = min_t(unsigned int, num_buffers,
>>>>                    q->max_allowed_buffers - vb2_get_num_buffers(q));
>>>>    -    first_index = vb2_get_num_buffers(q);
>>>> +    first_index = bitmap_find_next_zero_area(q->bufs_map, q->max_allowed_buffers,
>>>> +                         0, num_buffers, 0);
>>>>          if (first_index >= q->max_allowed_buffers)
>>>>            return 0;
>>>> @@ -675,7 +678,13 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>>>      struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q, unsigned int index)
>>>>    {
>>>> -    if (index < q->num_buffers)
>>>> +    if (!q->bufs_map || !q->bufs)
>>>> +        return NULL;
>>> I don't think this can ever happen.
>> I got kernel crash without them.
>> I will keep them.
> What is the backtrace? How can this happen? It feels wrong that this can be
> called with a vb2_queue that apparently is not properly initialized.

I have this log when adding dump_stack() in vb2_get_buffer() if !q->bufs_bitmap:

[   18.924627] Call trace:
[   18.927090]  dump_backtrace+0x94/0xec
[   18.930787]  show_stack+0x18/0x24
[   18.934137]  dump_stack_lvl+0x48/0x60
[   18.937833]  dump_stack+0x18/0x24
[   18.941166]  __vb2_queue_cancel+0x23c/0x2f0
[   18.945365]  vb2_core_queue_release+0x24/0x6c
[   18.949740]  vb2_queue_release+0x10/0x1c
[   18.953677]  v4l2_m2m_ctx_release+0x20/0x40
[   18.957892]  hantro_release+0x20/0x54
[   18.961584]  v4l2_release+0x74/0xec
[   18.965110]  __fput+0xb4/0x274
[   18.968205]  __fput_sync+0x50/0x5c
[   18.971626]  __arm64_sys_close+0x38/0x7c
[   18.975562]  invoke_syscall+0x48/0x114
[   18.979329]  el0_svc_common.constprop.0+0xc0/0xe0
[   18.984068]  do_el0_svc+0x1c/0x28
[   18.987402]  el0_svc+0x40/0xe8
[   18.990470]  el0t_64_sync_handler+0x100/0x12c
[   18.994842]  el0t_64_sync+0x190/0x194

This happen at boot time when hantro driver is open and close without other actions.
     

>
>>>> +
>>>> +    return (bitmap_weight(q->bufs_map, q->max_allowed_buffers) > 0);
>>> How about:
>>>
>>>      return vb2_get_num_buffers(q) > 0;
>> vb2_get_num_buffers is defined in videobuf2-core.c, I'm not sure that
>> an inline function could depend of a module function.
> Not a problem. E.g. v4l2-ctrls.h is full of such static inlines.
>
> Regards,
>
> 	Hans
>
