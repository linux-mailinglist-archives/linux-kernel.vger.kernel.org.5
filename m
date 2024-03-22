Return-Path: <linux-kernel+bounces-111291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411A4886A45
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656191C20E96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E9339860;
	Fri, 22 Mar 2024 10:29:48 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAC383B4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103387; cv=none; b=rJDigrxJNE8+9z7ADa/Tv1ymfLzkmZy2TfqmEiLGwgjgw2/ij2F9YbEuUoXkdsObN7fD/uOJLRezr/7ycuyB/TpPhm+Oy/az7Oe4068pNeWjY8t1nW7xJ+nKVGZXZATedrNKRWJCMmwQd74jxO3XFhx6U7rQBnJDEk6gpbrK6tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103387; c=relaxed/simple;
	bh=TzuZKg4wTSaypun8Dhv4hpmvRrycXdOakEwS2qR1tPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7xvMq5B2/LC8yj9dcMzf/n7jYec9LIMEYkKveWzxjc20GTffEEh4ojVLi9QV/TGBopAWzo5BKapAG8vEi3Q/UbmtmeQC0ZfOPuJ9uOk2fVwuIfPckvH+hhI5tHZc8OgF3zopx+z+3snQUX5qtG2z5aCzsWV+saPQB/K+ldD1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4V1J7q28kyz9xHdX
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:13:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 33D4E140893
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:29:36 +0800 (CST)
Received: from [10.48.131.63] (unknown [10.48.131.63])
	by APP1 (Coremail) with SMTP id LxC2BwB3bheFXf1lrYTJBA--.54462S2;
	Fri, 22 Mar 2024 11:29:35 +0100 (CET)
Message-ID: <7287376a-f2d8-4f7a-84b8-1f445ae69968@huaweicloud.com>
Date: Fri, 22 Mar 2024 11:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
To: Michael Kelley <mhklinux@outlook.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Will Deacon <will@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Petr Tesarik <petr@tesarici.cz>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
 <20240321171902.85-2-petrtesarik@huaweicloud.com>
 <SN6PR02MB4157AC19CFB8B800EA9748B3D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <SN6PR02MB4157AC19CFB8B800EA9748B3D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwB3bheFXf1lrYTJBA--.54462S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF17Jr1rXry5JFW8Aw4rGrg_yoWxCr45pr
	WfJa1rKFWkJFyxCan29a18JF1S9w1kCrW7CF43KFyY9ryDXr1rWF98A3yYga4Sqr4v9FW2
	v3WF9r4xu3W7XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

On 3/22/2024 5:29 AM, Michael Kelley wrote:
> From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Thursday, March 21, 2024 10:19 AM
>>
>> Allow a buffer pre-padding of up to alloc_align_mask. If the allocation
>> alignment is bigger than IO_TLB_SIZE and min_align_mask covers any non-zero
>> bits in the original address between IO_TLB_SIZE and alloc_align_mask,
>> these bits are not preserved in the swiotlb buffer address.
>>
>> To fix this case, increase the allocation size and use a larger offset
>> within the allocated buffer. As a result, extra padding slots may be
>> allocated before the mapping start address.
>>
>> Leave orig_addr in these padding slots initialized to INVALID_PHYS_ADDR.
>> These slots do not correspond to any CPU buffer, so attempts to sync the
>> data should be ignored.
>>
>> The padding slots should be automatically released when the buffer is
>> unmapped. However, swiotlb_tbl_unmap_single() takes only the address of the
>> DMA buffer slot, not the first padding slot. Save the number of padding
>> slots in struct io_tlb_slot and use it to adjust the slot index in
>> swiotlb_release_slots(), so all allocated slots are properly freed.
>>
>> Fixes: 2fd4fa5d3fb5 ("swiotlb: Fix alignment checks when both allocation and DMA masks are present")
>> Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshulam.tesarici.cz/
>> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>> ---
>>  kernel/dma/swiotlb.c | 35 +++++++++++++++++++++++++++++------
>>  1 file changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 86fe172b5958..3779a48eec9b 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -69,11 +69,14 @@
>>   * @alloc_size:	Size of the allocated buffer.
>>   * @list:	The free list describing the number of free entries available
>>   *		from each index.
>> + * @pad_slots:	Number of preceding padding slots. Valid only in the first
>> + *		allocated non-padding slot.
>>   */
>>  struct io_tlb_slot {
>>  	phys_addr_t orig_addr;
>>  	size_t alloc_size;
>> -	unsigned int list;
>> +	unsigned short list;
>> +	unsigned short pad_slots;
>>  };
>>
>>  static bool swiotlb_force_bounce;
>> @@ -287,6 +290,7 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
>>  					 mem->nslabs - i);
>>  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>>  		mem->slots[i].alloc_size = 0;
>> +		mem->slots[i].pad_slots = 0;
>>  	}
>>
>>  	memset(vaddr, 0, bytes);
>> @@ -1328,11 +1332,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>>  		unsigned long attrs)
>>  {
>>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>> -	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>> +	unsigned int offset;
>>  	struct io_tlb_pool *pool;
>>  	unsigned int i;
>>  	int index;
>>  	phys_addr_t tlb_addr;
>> +	unsigned short pad_slots;
>>
>>  	if (!mem || !mem->nslabs) {
>>  		dev_warn_ratelimited(dev,
>> @@ -1349,6 +1354,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>>  		return (phys_addr_t)DMA_MAPPING_ERROR;
>>  	}
>>
>> +	/*
>> +	 * Calculate buffer pre-padding within the allocated space. Use it to
>> +	 * preserve the low bits of the original address according to device's
>> +	 * min_align_mask. Limit the padding to alloc_align_mask or slot size
>> +	 * (whichever is bigger); higher bits of the original address are
>> +	 * preserved by selecting a suitable IO TLB slot.
>> +	 */
>> +	offset = orig_addr & dma_get_min_align_mask(dev) &
>> +		(alloc_align_mask | (IO_TLB_SIZE - 1));
>>  	index = swiotlb_find_slots(dev, orig_addr,
>>  				   alloc_size + offset, alloc_align_mask, &pool);
>>  	if (index == -1) {
>> @@ -1364,6 +1378,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>>  	 * This is needed when we sync the memory.  Then we sync the buffer if
>>  	 * needed.
>>  	 */
>> +	pad_slots = offset / IO_TLB_SIZE;
>> +	offset %= IO_TLB_SIZE;
>> +	index += pad_slots;
>> +	pool->slots[index].pad_slots = pad_slots;
>>  	for (i = 0; i < nr_slots(alloc_size + offset); i++)
>>  		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
>>  	tlb_addr = slot_addr(pool->start, index) + offset;
>> @@ -1385,12 +1403,16 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
>>  	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
>>  	unsigned long flags;
>>  	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
>> -	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
>> -	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
>> -	int aindex = index / mem->area_nslabs;
>> -	struct io_tlb_area *area = &mem->areas[aindex];
>> +	int index, nslots, aindex;
>> +	struct io_tlb_area *area;
>>  	int count, i;
>>
>> +	index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
>> +	index -= mem->slots[index].pad_slots;
>> +	nslots = nr_slots(mem->slots[index].alloc_size + offset);
>> +	aindex = index / mem->area_nslabs;
>> +	area = &mem->areas[aindex];
>> +
>>  	/*
>>  	 * Return the buffer to the free list by setting the corresponding
>>  	 * entries to indicate the number of contiguous entries available.
>> @@ -1413,6 +1435,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
>>  		mem->slots[i].list = ++count;
>>  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>>  		mem->slots[i].alloc_size = 0;
>> +		mem->slots[i].pad_slots = 0;
>>  	}
>>
>>  	/*
>> --
>> 2.34.1
> 
> I've tested this patch in conjunction with Will's series of 6 patches, and
> all looks good.  I tested on x86/x64 w/4K page size and on arm64
> w/64K page size and a variety of min_align_mask values, alloc_align_mask
> values, mapping size values, and orig_addr low order bits.  The tests are
> doing disk I/O through the bounce buffers, and they verify that the data
> written can be read back correctly.  So the bouncing is working correctly
> with the slots that are being set up.
> 
> I'm not able to test with min_align_mask less than 4K, because my
> synthetic disk driver doesn't work if that alignment isn't maintained.
> But min_align_mask values of 8K, 16K, and 64K work correctly.  I've
> seen up to 5 padding slots be allocated.

Thank you for this extensive testing. Just wow!

> I have not tried any 32-bit builds.

I have at least tried my KUnit test with --arch=arm, and that passes all
tests. But I agree it doesn't prove much.

Petr T

> Overall, it looks solid to me.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>


