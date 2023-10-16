Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3387CAB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjJPOVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJPOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:20:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA95F0;
        Mon, 16 Oct 2023 07:20:55 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:e07f:e79d:cb73:481b] (unknown [IPv6:2a01:e0a:120:3210:e07f:e79d:cb73:481b])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B8AB66071C7;
        Mon, 16 Oct 2023 15:20:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697466053;
        bh=c/L8dFl388l4YQCDz27EHWC74G2f0t+CGWGDGeHXxIA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TAuSs6sYKBn1pNWDBY8a/rjZSeEKDhnhW0jJDLB5hhIl4bEgokQoe/H7qHSkEuHnZ
         d11Ftw1Icbpqx3LmTZTNS73YUWg3Ut4+nZz0laSrd/sfMHp8qRtRXBXax8TxNnnX8D
         s0fvJ40lAvvX9ub9o70tTXBmnQdrOkaamT5vyScngNztRGde7fWfO1X5aGMEWc9ezA
         JX8WWyQ0yXffPc8mhrO8+XDrruoNVMw6MUn7Ms13ZfVnj99mPu+1U7bxBhezz5vn96
         vd7ucQAnxX17sG4Jzkxe1TAr6T66A4JUEtf3Pz5oVG83gpWUgWvVkJAL5IYUz0W0Vt
         DLPOJJK9DhrAw==
Message-ID: <b689e7d2-ff87-499e-a165-d227b1865488@collabora.com>
Date:   Mon, 16 Oct 2023 16:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 45/56] media: test-drivers: vivid: Increase max
 supported buffers for capture queues
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
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
 <20231012114642.19040-46-benjamin.gaignard@collabora.com>
 <0ca82921-b71a-4d87-a1f1-6a6158f07c8c@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <0ca82921-b71a-4d87-a1f1-6a6158f07c8c@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 16/10/2023 à 12:32, Hans Verkuil a écrit :
> On 12/10/2023 13:46, Benjamin Gaignard wrote:
>> Change the maximum number of buffers of some capture queues in order
>> to test max_num_buffers field.
>>
>> Allow to allocate up to:
>> - 64 buffers for video capture queue.
>> - 1024 buffers for sdr capture queue.
>> - 32768 buffers for vbi capture queue.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/test-drivers/vivid/vivid-core.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
>> index 394c9f81ea72..b5656330578d 100644
>> --- a/drivers/media/test-drivers/vivid/vivid-core.c
>> +++ b/drivers/media/test-drivers/vivid/vivid-core.c
>> @@ -876,6 +876,13 @@ static int vivid_create_queue(struct vivid_dev *dev,
>>   	q->type = buf_type;
>>   	q->io_modes = VB2_MMAP | VB2_DMABUF;
>>   	q->io_modes |= V4L2_TYPE_IS_OUTPUT(buf_type) ?  VB2_WRITE : VB2_READ;
>> +	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> +		q->max_num_buffers = 64;
>> +	if (buf_type == V4L2_BUF_TYPE_SDR_CAPTURE)
>> +		q->max_num_buffers = 1024;
>> +	if (buf_type == V4L2_BUF_TYPE_VBI_CAPTURE)
>> +		q->max_num_buffers = 32768;
> This should use the same calculation as MAX_BUFFER_INDEX.
>
> I wonder if those defines should move to videobuf2-core.h instead.

I'm not sure about what you want here, q->max_num_buffers is clamped in vb2_core_queue_init():

/* The maximum is limited by offset cookie encoding pattern */
q->max_num_buffers = min_t(unsigned int, q->max_num_buffers, MAX_BUFFER_INDEX);

Do you want to reuse MAX_BUFFER_INDEX for these drivers ?

Regards,
Benjamin

>
> Regards,
>
> 	Hans
>
>> +
>>   	if (allocators[dev->inst] != 1)
>>   		q->io_modes |= VB2_USERPTR;
>>   	q->drv_priv = dev;
>
