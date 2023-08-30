Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBCC78DF25
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbjH3TLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244283AbjH3Mvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:51:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70950132;
        Wed, 30 Aug 2023 05:51:34 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:3c80:2375:ed1d:19ee] (unknown [IPv6:2a01:e0a:120:3210:3c80:2375:ed1d:19ee])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 78F0A660722B;
        Wed, 30 Aug 2023 13:51:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693399892;
        bh=ATFNlFErqZ0DT6q6oV6nUkS2hS/qdeMG0yqOrN3MSgk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=grBQL/Me/AQSKnGXDsM+f85KJNzEEFJDfQbBeuzCklPS0k9B0cmtilehE5zKRYu/t
         TtV/dyQfppH74lB05sAV/VsXWgaDexMHs1RPCOCcCNZ+wkVPBEIymWDEX96+OSBOvZ
         hcvl4UYaMfBYhNM1TzhmuweEvku6Ox/K8F+a+Y/mmO6tvueqjLpjoq+aE2OcT1m9Nh
         qeR4oxhg+yIrXzde+Z+KiMuxBZaSgAZ4XQRFzOzuntRs5PJ/DpzBObPWs1gTGFe/i5
         GqNZhQWD0fukRTvVQKnmo3zaxLeESSifUnsZr63gW6bt1RPa2UNzAUrnR3pwaYDVEi
         BQwFKwll1kpHw==
Message-ID: <643a7811-60ff-6ac9-be3d-edcd9a0b95cc@collabora.com>
Date:   Wed, 30 Aug 2023 14:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 01/10] media: videobuf2: Rework offset 'cookie'
 encoding pattern
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230824092133.39510-1-benjamin.gaignard@collabora.com>
 <20230824092133.39510-2-benjamin.gaignard@collabora.com>
 <01c299f2-8118-5d86-e9b6-a459c1b6c467@xs4all.nl>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <01c299f2-8118-5d86-e9b6-a459c1b6c467@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 30/08/2023 à 14:25, Hans Verkuil a écrit :
> On 24/08/2023 11:21, Benjamin Gaignard wrote:
>> Change how offset 'cookie' field value is computed to make possible
>> to use more buffers (up to 0xffff).
>> With this encoding pattern we know the maximum number that a queue
>> could store so we can check ing at queue init time.
>> It also make easier and faster to find buffer and plane from using
>> the offset field.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>> v5:
>> - I haven't change DST_QUEUE_OFF_BASE definition because it used in
>>    v4l2-mem2mem and s5p_mfc driver with a shift.
>>
>>   .../media/common/videobuf2/videobuf2-core.c   | 48 +++++++++----------
>>   1 file changed, 24 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index cf6727d9c81f..e06905533ef4 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -31,6 +31,10 @@
>>   
>>   #include <trace/events/vb2.h>
>>   
>> +#define PLANE_INDEX_SHIFT	3
>> +#define PLANE_INDEX_MASK	0x7
>> +#define MAX_BUFFERS		0xffff
> Very poor name, see below.
>
>> +
>>   static int debug;
>>   module_param(debug, int, 0644);
>>   
>> @@ -358,21 +362,23 @@ static void __setup_offsets(struct vb2_buffer *vb)
>>   	unsigned int plane;
>>   	unsigned long off = 0;
>>   
>> -	if (vb->index) {
>> -		struct vb2_buffer *prev = q->bufs[vb->index - 1];
>> -		struct vb2_plane *p = &prev->planes[prev->num_planes - 1];
>> -
>> -		off = PAGE_ALIGN(p->m.offset + p->length);
>> -	}
>> +	/*
>> +	 * Offsets cookies value have the following constraints:
>> +	 * - a buffer could have up to 8 planes.
>> +	 * - v4l2 mem2mem use bit 30 to distinguish between source and destination buffers.
>> +	 * - must be page aligned
>> +	 * That led to this bit mapping:
>> +	 * |30                |29        15|14       12|11 0|
>> +	 * |DST_QUEUE_OFF_BASE|buffer index|plane index| 0  |
>> +	 * where there is 16 bits to store buffer index.
> 16 -> 15: there are 15 (not 16!) bits available for buffer indices. So the maximum
> number of buffers is 32768, given that the indices start at 0.
>
>> +	 */
>> +	off = vb->index << (PLANE_INDEX_SHIFT + PAGE_SHIFT);
>>   
>>   	for (plane = 0; plane < vb->num_planes; ++plane) {
>> -		vb->planes[plane].m.offset = off;
>> +		vb->planes[plane].m.offset = off + (plane << PAGE_SHIFT);
>>   
>>   		dprintk(q, 3, "buffer %d, plane %d offset 0x%08lx\n",
>>   				vb->index, plane, off);
>> -
>> -		off += vb->planes[plane].length;
>> -		off = PAGE_ALIGN(off);
>>   	}
>>   }
>>   
>> @@ -2209,21 +2215,15 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
>>   		return -EBUSY;
>>   	}
>>   
>> -	/*
>> -	 * Go over all buffers and their planes, comparing the given offset
>> -	 * with an offset assigned to each plane. If a match is found,
>> -	 * return its buffer and plane numbers.
>> -	 */
>> -	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
>> -		vb = q->bufs[buffer];
>> +	/* Get buffer and plane from the offset */
>> +	buffer = (off >> (PLANE_INDEX_SHIFT + PAGE_SHIFT)) & MAX_BUFFERS;
> Hmm, you use it as a mask. The name MAX_BUFFERS is really confusing.
> How about BUFFER_INDEX_MASK? That is consistent with PLANE_INDEX_MASK.

I will follow your advice and fix that in next version.
I will until you have finish your review in this series before send it.

Regards,
Benjamin

>
>> +	plane = (off >> PAGE_SHIFT) & PLANE_INDEX_MASK;
>>   
>> -		for (plane = 0; plane < vb->num_planes; ++plane) {
>> -			if (vb->planes[plane].m.offset == off) {
>> -				*_buffer = buffer;
>> -				*_plane = plane;
>> -				return 0;
>> -			}
>> -		}
>> +	vb = q->bufs[buffer];
>> +	if (vb->planes[plane].m.offset == off) {
>> +		*_buffer = buffer;
>> +		*_plane = plane;
>> +		return 0;
>>   	}
>>   
>>   	return -EINVAL;
> Regards,
>
> 	Hans
>
