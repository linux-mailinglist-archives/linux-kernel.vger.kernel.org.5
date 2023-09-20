Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939EC7A8803
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjITPRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjITPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:17:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05197A3;
        Wed, 20 Sep 2023 08:17:45 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:def9:8f6c:3807:7d89] (unknown [IPv6:2a01:e0a:120:3210:def9:8f6c:3807:7d89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 365C366071DC;
        Wed, 20 Sep 2023 16:17:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695223063;
        bh=sVWbeVvViH+sanbxD7UOCdPMVWb4cp4MCMV6I8qEHqU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fgjOVRxHl8kCiwY7Hcd8T0jWmApbiH0ed+OZ+JjHsOgnk81FeqgeM2NfWKpSyo393
         tWZdmT/mZxwtvLVhu2lpoxiO3Gj9JGJYBJJVnuDIqefxCVQ6rcdllneEzVEKrRB1/e
         jNKWiKjocDbGPpaDX3JAMzrBqU0vTo9NCdtaHu1pRNRyWgE8CBjekFaQzyyXhqKEHj
         jBcC12vTx/Ho6DbjY7Ow4kmQyy53rsA/NxZIfylqsR4qcHvHDrOLELIuaUyr6j0GF6
         gPylEuqd7wDouKvgZ05UYjO9coGCA0zBwD+8tGXMt3joh1WfqVi77e0AtVidQsYYAl
         6LF8/U/HCyRCA==
Message-ID: <10a9a265-6910-807a-57c5-62ee41c731a5@collabora.com>
Date:   Wed, 20 Sep 2023 17:17:40 +0200
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
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <470682b4-c14b-4237-bc46-fddfdd085026@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

I will add backtrace when doing test on v8

>
>
>>>> +
>>>> +    return (bitmap_weight(q->bufs_map, q->max_allowed_buffers) > 0);
>>> How about:
>>>
>>>      return vb2_get_num_buffers(q) > 0;
>> vb2_get_num_buffers is defined in videobuf2-core.c, I'm not sure that
>> an inline function could depend of a module function.
> Not a problem. E.g. v4l2-ctrls.h is full of such static inlines.

I will change vb2_get_num_buffers() to inline function that solve the problem too.

>
> Regards,
>
> 	Hans
>
