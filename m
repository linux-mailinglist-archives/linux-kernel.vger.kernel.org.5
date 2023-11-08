Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D97A7E5326
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbjKHKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHKOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:14:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10EA1726;
        Wed,  8 Nov 2023 02:14:36 -0800 (PST)
Received: from [100.98.136.55] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A6CAC6601F0B;
        Wed,  8 Nov 2023 10:14:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699438475;
        bh=Ilw8GxRpfkU8nyO7ThH/MgVP6lonMiPetYieJPU0Cow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hHjoK8FPqHSHyBhzaFy6eW7GzVotn5vdvoEioMcANArq7J2J1ytkv4eCc4fTT5t0X
         OlCq1uce0ltMYMgTNOASWoAVRC1qjEy3iCmmdpo/9cIKLTluL1dfBAdbLpHIdsiOgY
         CJvbGJ37rBjjrT6PWd4FH0DWvEF32FuWY+0BUkX7l4ie98OYRZv5NLnLsbEB7qe8YS
         LGQotB/uscM5F8dIMURWokA7i4k/eVrIQcmMLoZDIRefe6RPXYngQt8CTf7C6Fnxaz
         4JsOBmJJ3oFP88T+cl2l/zFCwYEiHL/lMPCKPNbvocAI5f/RgPnhMrloEOPkbI7NVy
         1mwwognoYyNrQ==
Message-ID: <ce33854a-f547-411a-a747-2d32d442b15e@collabora.com>
Date:   Wed, 8 Nov 2023 11:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/56] media: videobuf2: Rework offset 'cookie'
 encoding pattern
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-3-benjamin.gaignard@collabora.com>
 <20231108062322.l2k2n2jlpoaa4tws@chromium.org>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20231108062322.l2k2n2jlpoaa4tws@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 08/11/2023 à 07:23, Tomasz Figa a écrit :
> Hi Benjamin,
>
> On Tue, Oct 31, 2023 at 05:30:10PM +0100, Benjamin Gaignard wrote:
>> Change how offset 'cookie' field value is computed to make possible
>> to use more buffers.
>> The maximum number of buffers depends of PAGE_SHIFT value and can
>> go up to 0x7fff when PAGE_SHIFT = 12.
>> With this encoding pattern we know the maximum number that a queue
>> could store so we can check it at  queue init time.
>> It also make easier and faster to find buffer and plane from using
>> the offset field.
>> Change __find_plane_by_offset() prototype to return the video buffer
>> itself rather than it index.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../media/common/videobuf2/videobuf2-core.c   | 73 +++++++++----------
>>   1 file changed, 35 insertions(+), 38 deletions(-)
>>
> Thanks a lot for working on this series. Just one comment inline.
>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index a5e57affeb30..09be8e026044 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -31,6 +31,11 @@
>>   
>>   #include <trace/events/vb2.h>
>>   
>> +#define PLANE_INDEX_SHIFT	(PAGE_SHIFT + 3)
>> +#define PLANE_INDEX_MASK	0x7
> Could we somehow ensure that it indeed matches VIDEO_MAX_PLANES?
>
> One thing that comes to my mind would be
>
> #define PLANE_INDEX_BITS	3
> #define PLANE_INDEX_SHIFT	(PAGE_SHIFT + PLANE_INDEX_BITS)
> #define PLANE_INDEX_MASK	BIT_MASK(PLANE_INDEX_BITS)
>
> BUILD_BUG_ON(BIT(PLANE_INDEX_BITS) != VIDEO_MAX_PLANES);
>
> Alternatively we could change the videodev2.h, so that we have
>
> #define VIDEO_MAX_PLANES_BITS	3
> #define VIDEO_MAX_PLANES	(1U < VIDEO_MAX_PLANES_BITS)
>
> and then we can just VIDEO_MAX_PLANES_BITS in our definitions in this file
> and no checks would be necessary.

I would prefer this solution.
Hans should I do that in an other patch ?

Regards,
Benjamin

>
> Best regards,
> Tomasz
>
>> +#define MAX_BUFFER_INDEX	BIT_MASK(30 - PLANE_INDEX_SHIFT)
>> +#define BUFFER_INDEX_MASK	(MAX_BUFFER_INDEX - 1)
>> +
>>   static int debug;
>>   module_param(debug, int, 0644);
>>   
>> @@ -358,21 +363,27 @@ static void __setup_offsets(struct vb2_buffer *vb)
>>   	unsigned int plane;
>>   	unsigned long offset = 0;
>>   
>> -	if (vb->index) {
>> -		struct vb2_buffer *prev = q->bufs[vb->index - 1];
>> -		struct vb2_plane *p = &prev->planes[prev->num_planes - 1];
>> -
>> -		offset = PAGE_ALIGN(p->m.offset + p->length);
>> -	}
>> +	/*
>> +	 * The offset "cookie" value has the following constraints:
>> +	 * - a buffer can have up to 8 planes.
>> +	 * - v4l2 mem2mem uses bit 30 to distinguish between
>> +	 *   OUTPUT (aka "source", bit 30 is 0) and
>> +	 *   CAPTURE (aka "destination", bit 30 is 1) buffers.
>> +	 * - must be page aligned
>> +	 * That led to this bit mapping when PAGE_SHIFT = 12:
>> +	 * |30                |29        15|14       12|11 0|
>> +	 * |DST_QUEUE_OFF_BASE|buffer index|plane index| 0  |
>> +	 * where there are 15 bits to store the buffer index.
>> +	 * Depending on PAGE_SHIFT value we can have fewer bits
>> +	 * to store the buffer index.
>> +	 */
>> +	offset = vb->index << PLANE_INDEX_SHIFT;
>>   
>>   	for (plane = 0; plane < vb->num_planes; ++plane) {
>> -		vb->planes[plane].m.offset = offset;
>> +		vb->planes[plane].m.offset = offset + (plane << PAGE_SHIFT);
>>   
>>   		dprintk(q, 3, "buffer %d, plane %d offset 0x%08lx\n",
>>   				vb->index, plane, offset);
>> -
>> -		offset += vb->planes[plane].length;
>> -		offset = PAGE_ALIGN(offset);
>>   	}
>>   }
>>   
>> @@ -2188,10 +2199,9 @@ EXPORT_SYMBOL_GPL(vb2_core_streamoff);
>>    * __find_plane_by_offset() - find plane associated with the given offset
>>    */
>>   static int __find_plane_by_offset(struct vb2_queue *q, unsigned long offset,
>> -			unsigned int *_buffer, unsigned int *_plane)
>> +			struct vb2_buffer **vb, unsigned int *plane)
>>   {
>> -	struct vb2_buffer *vb;
>> -	unsigned int buffer, plane;
>> +	unsigned int buffer;
>>   
>>   	/*
>>   	 * Sanity checks to ensure the lock is held, MEMORY_MMAP is
>> @@ -2209,24 +2219,15 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long offset,
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
>> +	buffer = (offset >> PLANE_INDEX_SHIFT) & BUFFER_INDEX_MASK;
>> +	*plane = (offset >> PAGE_SHIFT) & PLANE_INDEX_MASK;
>>   
>> -		for (plane = 0; plane < vb->num_planes; ++plane) {
>> -			if (vb->planes[plane].m.offset == offset) {
>> -				*_buffer = buffer;
>> -				*_plane = plane;
>> -				return 0;
>> -			}
>> -		}
>> -	}
>> +	if (buffer >= q->num_buffers || *plane >= q->bufs[buffer]->num_planes)
>> +		return -EINVAL;
>>   
>> -	return -EINVAL;
>> +	*vb = q->bufs[buffer];
>> +	return 0;
>>   }
>>   
>>   int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
>> @@ -2306,7 +2307,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>>   {
>>   	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
>>   	struct vb2_buffer *vb;
>> -	unsigned int buffer = 0, plane = 0;
>> +	unsigned int plane = 0;
>>   	int ret;
>>   	unsigned long length;
>>   
>> @@ -2335,12 +2336,10 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>>   	 * Find the plane corresponding to the offset passed by userspace. This
>>   	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
>>   	 */
>> -	ret = __find_plane_by_offset(q, offset, &buffer, &plane);
>> +	ret = __find_plane_by_offset(q, offset, &vb, &plane);
>>   	if (ret)
>>   		goto unlock;
>>   
>> -	vb = q->bufs[buffer];
>> -
>>   	/*
>>   	 * MMAP requires page_aligned buffers.
>>   	 * The buffer length was page_aligned at __vb2_buf_mem_alloc(),
>> @@ -2368,7 +2367,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>>   	if (ret)
>>   		return ret;
>>   
>> -	dprintk(q, 3, "buffer %d, plane %d successfully mapped\n", buffer, plane);
>> +	dprintk(q, 3, "buffer %u, plane %d successfully mapped\n", vb->index, plane);
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_mmap);
>> @@ -2382,7 +2381,7 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
>>   {
>>   	unsigned long offset = pgoff << PAGE_SHIFT;
>>   	struct vb2_buffer *vb;
>> -	unsigned int buffer, plane;
>> +	unsigned int plane;
>>   	void *vaddr;
>>   	int ret;
>>   
>> @@ -2392,12 +2391,10 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
>>   	 * Find the plane corresponding to the offset passed by userspace. This
>>   	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
>>   	 */
>> -	ret = __find_plane_by_offset(q, offset, &buffer, &plane);
>> +	ret = __find_plane_by_offset(q, offset, &vb, &plane);
>>   	if (ret)
>>   		goto unlock;
>>   
>> -	vb = q->bufs[buffer];
>> -
>>   	vaddr = vb2_plane_vaddr(vb, plane);
>>   	mutex_unlock(&q->mmap_lock);
>>   	return vaddr ? (unsigned long)vaddr : -EINVAL;
>> -- 
>> 2.39.2
>>
