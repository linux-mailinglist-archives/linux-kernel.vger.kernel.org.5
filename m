Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A17A87B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjITO4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjITO4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:56:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A10A9;
        Wed, 20 Sep 2023 07:56:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E83CC433C9;
        Wed, 20 Sep 2023 14:56:29 +0000 (UTC)
Message-ID: <470682b4-c14b-4237-bc46-fddfdd085026@xs4all.nl>
Date:   Wed, 20 Sep 2023 16:56:27 +0200
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
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20b6b93e-eef8-3d7b-a3c2-795f220059d4@collabora.com>
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

On 20/09/2023 16:30, Benjamin Gaignard wrote:
> 

<snip>

>>>       num_buffers = min_t(unsigned int, num_buffers,
>>>                   q->max_allowed_buffers - vb2_get_num_buffers(q));
>>>   -    first_index = vb2_get_num_buffers(q);
>>> +    first_index = bitmap_find_next_zero_area(q->bufs_map, q->max_allowed_buffers,
>>> +                         0, num_buffers, 0);
>>>         if (first_index >= q->max_allowed_buffers)
>>>           return 0;
>>> @@ -675,7 +678,13 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>>     struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q, unsigned int index)
>>>   {
>>> -    if (index < q->num_buffers)
>>> +    if (!q->bufs_map || !q->bufs)
>>> +        return NULL;
>> I don't think this can ever happen.
> 
> I got kernel crash without them.
> I will keep them.

What is the backtrace? How can this happen? It feels wrong that this can be
called with a vb2_queue that apparently is not properly initialized.

>>> +
>>> +    return (bitmap_weight(q->bufs_map, q->max_allowed_buffers) > 0);
>> How about:
>>
>>     return vb2_get_num_buffers(q) > 0;
> 
> vb2_get_num_buffers is defined in videobuf2-core.c, I'm not sure that
> an inline function could depend of a module function.

Not a problem. E.g. v4l2-ctrls.h is full of such static inlines.

Regards,

	Hans
