Return-Path: <linux-kernel+bounces-38841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F16783C722
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B824FB22C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272474E2D;
	Thu, 25 Jan 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lSiZzWYQ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393C7317A;
	Thu, 25 Jan 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197552; cv=none; b=q+BpVTTcQLxWkUqJchbQFyir414KryNE4T3p/Cwh1iPW2ZglSntV3M208Si2h/9zK1LDnQMaSVyNlxUcwZe5jfJMPDvnlzzoyxAQCQTuwMLp3idiFT/pk9Yvc355ALUm2PVlXLvGNTMvBbBbpvTiVUCy9OCPolL8Ng6PZdKpBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197552; c=relaxed/simple;
	bh=McB6NIE61BwGjTvv9ED9Vb50EqOQdx98eH1ZoiQXBpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RbfTe+BSUyPVJgIBibC2SiY1u2Fak+lnS5//kdgiJrMvTopZFPpRfNsFgCxovW+Z6cgWnic1QRhRzQPllkYIQsDZM8M7CjsRJq30uhcRYxuXphAJvz4WHjHoiwgVuw3bu5ftmXGOOo/DqDEZetX+p4p7WbzJzP4/yXO/MjBPRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lSiZzWYQ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PFjeiO037894;
	Thu, 25 Jan 2024 09:45:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706197540;
	bh=swdj5R8LjyDTSfvkm8i15amLpOZddgXK39R/tFg7qGM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lSiZzWYQnIylBlzW0Pp/f3AmCyQMnoUi//umQavH3biwszJWz0QjFvh0r/ovSeDIx
	 URsHKDLm+pLR1eLytgiFW7rTkKaCicrDIZKhIhDe927gywuBnEmjGvXmHaKvB789BS
	 S5PCbjnagCQyE8OXZ4Ah7CZzP7WVpzDATsgj7wZM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PFjeSu020562
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 09:45:40 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 09:45:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 09:45:39 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PFjdK7110154;
	Thu, 25 Jan 2024 09:45:39 -0600
Message-ID: <7872f641-8a72-424f-b345-99c27403d7c6@ti.com>
Date: Thu, 25 Jan 2024 09:45:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] udmabuf: Sync buffer mappings for attached devices
Content-Language: en-US
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
        Gerd Hoffmann
	<kraxel@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Paul Cercueil
	<paul@crapouillou.net>
CC: "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
References: <20240123221227.868341-1-afd@ti.com>
 <20240123221227.868341-2-afd@ti.com>
 <IA0PR11MB7185DDD7A972ED546B4CEA10F87B2@IA0PR11MB7185.namprd11.prod.outlook.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <IA0PR11MB7185DDD7A972ED546B4CEA10F87B2@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/24/24 5:05 PM, Kasireddy, Vivek wrote:
> Hi Andrew,
> 
>> Currently this driver creates a SGT table using the CPU as the
>> target device, then performs the dma_sync operations against
>> that SGT. This is backwards to how DMA-BUFs are supposed to behave.
>> This may have worked for the case where these buffers were given
>> only back to the same CPU that produced them as in the QEMU case.
>> And only then because the original author had the dma_sync
>> operations also backwards, syncing for the "device" on begin_cpu.
>> This was noticed and "fixed" in this patch[0].
>>
>> That then meant we were sync'ing from the CPU to the CPU using
>> a pseudo-device "miscdevice". Which then caused another issue
>> due to the miscdevice not having a proper DMA mask (and why should
>> it, the CPU is not a DMA device). The fix for that was an even
>> more egregious hack[1] that declares the CPU is coherent with
>> itself and can access its own memory space..
>>
>> Unwind all this and perform the correct action by doing the dma_sync
>> operations for each device currently attached to the backing buffer.
> Makes sense.
> 
>>
>> [0] commit 1ffe09590121 ("udmabuf: fix dma-buf cpu access")
>> [1] commit 9e9fa6a9198b ("udmabuf: Set the DMA mask for the udmabuf
>> device (v2)")
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/dma-buf/udmabuf.c | 41 +++++++++++++++------------------------
>>   1 file changed, 16 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>> index 3a23f0a7d112a..ab6764322523c 100644
>> --- a/drivers/dma-buf/udmabuf.c
>> +++ b/drivers/dma-buf/udmabuf.c
>> @@ -26,8 +26,6 @@ MODULE_PARM_DESC(size_limit_mb, "Max size of a
>> dmabuf, in megabytes. Default is
>>   struct udmabuf {
>>   	pgoff_t pagecount;
>>   	struct page **pages;
>> -	struct sg_table *sg;
>> -	struct miscdevice *device;
>>   	struct list_head attachments;
>>   	struct mutex lock;
>>   };
>> @@ -169,12 +167,8 @@ static void unmap_udmabuf(struct
>> dma_buf_attachment *at,
>>   static void release_udmabuf(struct dma_buf *buf)
>>   {
>>   	struct udmabuf *ubuf = buf->priv;
>> -	struct device *dev = ubuf->device->this_device;
>>   	pgoff_t pg;
>>
>> -	if (ubuf->sg)
>> -		put_sg_table(dev, ubuf->sg, DMA_BIDIRECTIONAL);
> What happens if the last importer maps the dmabuf but erroneously
> closes it immediately? Would unmap somehow get called in this case?
> 

Good question, had to scan the framework code a bit here. I thought
closing a DMABUF handle would automatically unwind any current
attachments/mappings, but it seems nothing in the framework does that.

Looks like that is up to the importing drivers[0]:

> Once a driver is done with a shared buffer it needs to call
> dma_buf_detach() (after cleaning up any mappings) and then
> release the reference acquired with dma_buf_get() by
> calling dma_buf_put().

So closing a DMABUF after mapping without first unmapping it would
be a bug in the importer, it is not the exporters problem to check
for (although some more warnings in the framework checking for that
might not be a bad idea..).

Andrew

[0] https://www.kernel.org/doc/html/v6.7/driver-api/dma-buf.html

> Thanks,
> Vivek
> 
>> -
>>   	for (pg = 0; pg < ubuf->pagecount; pg++)
>>   		put_page(ubuf->pages[pg]);
>>   	kfree(ubuf->pages);
>> @@ -185,33 +179,31 @@ static int begin_cpu_udmabuf(struct dma_buf
>> *buf,
>>   			     enum dma_data_direction direction)
>>   {
>>   	struct udmabuf *ubuf = buf->priv;
>> -	struct device *dev = ubuf->device->this_device;
>> -	int ret = 0;
>> -
>> -	if (!ubuf->sg) {
>> -		ubuf->sg = get_sg_table(dev, buf, direction);
>> -		if (IS_ERR(ubuf->sg)) {
>> -			ret = PTR_ERR(ubuf->sg);
>> -			ubuf->sg = NULL;
>> -		}
>> -	} else {
>> -		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
>> -				    direction);
>> -	}
>> +	struct udmabuf_attachment *a;
>>
>> -	return ret;
>> +	mutex_lock(&ubuf->lock);
>> +
>> +	list_for_each_entry(a, &ubuf->attachments, list)
>> +		dma_sync_sgtable_for_cpu(a->dev, a->table, direction);
>> +
>> +	mutex_unlock(&ubuf->lock);
>> +
>> +	return 0;
>>   }
>>
>>   static int end_cpu_udmabuf(struct dma_buf *buf,
>>   			   enum dma_data_direction direction)
>>   {
>>   	struct udmabuf *ubuf = buf->priv;
>> -	struct device *dev = ubuf->device->this_device;
>> +	struct udmabuf_attachment *a;
>>
>> -	if (!ubuf->sg)
>> -		return -EINVAL;
>> +	mutex_lock(&ubuf->lock);
>> +
>> +	list_for_each_entry(a, &ubuf->attachments, list)
>> +		dma_sync_sgtable_for_device(a->dev, a->table, direction);
>> +
>> +	mutex_unlock(&ubuf->lock);
>>
>> -	dma_sync_sg_for_device(dev, ubuf->sg->sgl, ubuf->sg->nents,
>> direction);
>>   	return 0;
>>   }
>>
>> @@ -307,7 +299,6 @@ static long udmabuf_create(struct miscdevice
>> *device,
>>   	exp_info.priv = ubuf;
>>   	exp_info.flags = O_RDWR;
>>
>> -	ubuf->device = device;
>>   	buf = dma_buf_export(&exp_info);
>>   	if (IS_ERR(buf)) {
>>   		ret = PTR_ERR(buf);
>> --
>> 2.39.2
> 

