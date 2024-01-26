Return-Path: <linux-kernel+bounces-40447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E183E098
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B75FB24CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C020329;
	Fri, 26 Jan 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wSW0X7YM"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795491DDF8;
	Fri, 26 Jan 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290845; cv=none; b=tc49txtklEOJPobBsNRYeMCBxzcI/G8ztnTHWu/683jJtI9KIr1X3xqYViCBU11z8Tf2NHVnj5tXDfTNv3qfUv93ogIS1ZRbbAmZXQaGUG7BOrzs+cnmuBc9JRjUa56sOfKo8ah8FcfTCWj27Xs7H2zVPS8dgcwiTmOoi/mxS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290845; c=relaxed/simple;
	bh=Z1rfJoqpDWxesIszLgcJ0qmA7O0sQwnt8//QkIMRPsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Shc8dUH8wwN+Bxvp39qHEIas3oDLkLZ1eZ5p7GDRJRYergQVGJRZsa7tfCw0dOLoRTzDTnBdvw29QYX2xjper3A2E7syZj6U+OzvvPcQYA8fJelxI48cGEHEnMTky3vvTiV0rSo7PDjfjYkMEmlYU943dqgYLvZwWWcPifVFl54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wSW0X7YM; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40QHeXWl021653;
	Fri, 26 Jan 2024 11:40:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706290833;
	bh=tWS35G6oFLiiMUQqjg0s6kl4zM+dd3KKTVNV/pAk5Y8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wSW0X7YMB25+s9Adtm+MqZ7ac14ct+DkrUMn9JhSHS+1xDbU+enE72YXiIDfo4Lhk
	 t7noOQnkWwvVuVcLmyN3OSHS+HX9RBI0L+LVpnhhxXuD8uqHiaLY38FRiUno2POFpE
	 ZGpSz+ZGMDD8IHe1V3jWkQzvM+3iBd/4MJ7DMnjg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40QHeXfV057999
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jan 2024 11:40:33 -0600
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jan 2024 11:40:33 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:40:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jan 2024 11:40:32 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40QHeWG0086250;
	Fri, 26 Jan 2024 11:40:32 -0600
Message-ID: <1fb28a2f-8f42-42b4-9019-d0fc670c291c@ti.com>
Date: Fri, 26 Jan 2024 11:40:32 -0600
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
 <7872f641-8a72-424f-b345-99c27403d7c6@ti.com>
 <IA0PR11MB7185C799B08748C87F215434F8792@IA0PR11MB7185.namprd11.prod.outlook.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <IA0PR11MB7185C799B08748C87F215434F8792@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/26/24 1:25 AM, Kasireddy, Vivek wrote:
>>>> Currently this driver creates a SGT table using the CPU as the
>>>> target device, then performs the dma_sync operations against
>>>> that SGT. This is backwards to how DMA-BUFs are supposed to behave.
>>>> This may have worked for the case where these buffers were given
>>>> only back to the same CPU that produced them as in the QEMU case.
>>>> And only then because the original author had the dma_sync
>>>> operations also backwards, syncing for the "device" on begin_cpu.
>>>> This was noticed and "fixed" in this patch[0].
>>>>
>>>> That then meant we were sync'ing from the CPU to the CPU using
>>>> a pseudo-device "miscdevice". Which then caused another issue
>>>> due to the miscdevice not having a proper DMA mask (and why should
>>>> it, the CPU is not a DMA device). The fix for that was an even
>>>> more egregious hack[1] that declares the CPU is coherent with
>>>> itself and can access its own memory space..
>>>>
>>>> Unwind all this and perform the correct action by doing the dma_sync
>>>> operations for each device currently attached to the backing buffer.
>>> Makes sense.
>>>
>>>>
>>>> [0] commit 1ffe09590121 ("udmabuf: fix dma-buf cpu access")
>>>> [1] commit 9e9fa6a9198b ("udmabuf: Set the DMA mask for the udmabuf
>>>> device (v2)")
>>>>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> ---
>>>>    drivers/dma-buf/udmabuf.c | 41 +++++++++++++++------------------------
>>>>    1 file changed, 16 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>>>> index 3a23f0a7d112a..ab6764322523c 100644
>>>> --- a/drivers/dma-buf/udmabuf.c
>>>> +++ b/drivers/dma-buf/udmabuf.c
>>>> @@ -26,8 +26,6 @@ MODULE_PARM_DESC(size_limit_mb, "Max size of a
>>>> dmabuf, in megabytes. Default is
>>>>    struct udmabuf {
>>>>    	pgoff_t pagecount;
>>>>    	struct page **pages;
>>>> -	struct sg_table *sg;
>>>> -	struct miscdevice *device;
>>>>    	struct list_head attachments;
>>>>    	struct mutex lock;
>>>>    };
>>>> @@ -169,12 +167,8 @@ static void unmap_udmabuf(struct
>>>> dma_buf_attachment *at,
>>>>    static void release_udmabuf(struct dma_buf *buf)
>>>>    {
>>>>    	struct udmabuf *ubuf = buf->priv;
>>>> -	struct device *dev = ubuf->device->this_device;
>>>>    	pgoff_t pg;
>>>>
>>>> -	if (ubuf->sg)
>>>> -		put_sg_table(dev, ubuf->sg, DMA_BIDIRECTIONAL);
>>> What happens if the last importer maps the dmabuf but erroneously
>>> closes it immediately? Would unmap somehow get called in this case?
>>>
>>
>> Good question, had to scan the framework code a bit here. I thought
>> closing a DMABUF handle would automatically unwind any current
>> attachments/mappings, but it seems nothing in the framework does that.
>>
>> Looks like that is up to the importing drivers[0]:
>>
>>> Once a driver is done with a shared buffer it needs to call
>>> dma_buf_detach() (after cleaning up any mappings) and then
>>> release the reference acquired with dma_buf_get() by
>>> calling dma_buf_put().
>>
>> So closing a DMABUF after mapping without first unmapping it would
>> be a bug in the importer, it is not the exporters problem to check
> It may be a bug in the importer but wouldn't the memory associated
> with the sg table and attachment get leaked if unmap doesn't get called
> in this scenario?
> 

Yes the attachment data would be leaked if unattach was not called,
but that is true for all DMABUF exporters. The .release() callback
is meant to be the mirror of the export function and it only cleans
up that. Same for attach/unattach, map/unmap, etc.. If these calls
are not balanced then yes they can leak memory.

Since balance is guaranteed by the API, checking the balance should
be done at that level, not in each and every exporter. If your
comment is that we should add those checks into the DMABUF framework
layer then I would agree.

Andrew

> Thanks,
> Vivek
> 
>> for (although some more warnings in the framework checking for that
>> might not be a bad idea..).
>>
>> Andrew
>>
>> [0] https://www.kernel.org/doc/html/v6.7/driver-api/dma-buf.html
>>
>>> Thanks,
>>> Vivek
>>>
>>>> -
>>>>    	for (pg = 0; pg < ubuf->pagecount; pg++)
>>>>    		put_page(ubuf->pages[pg]);
>>>>    	kfree(ubuf->pages);
>>>> @@ -185,33 +179,31 @@ static int begin_cpu_udmabuf(struct dma_buf
>>>> *buf,
>>>>    			     enum dma_data_direction direction)
>>>>    {
>>>>    	struct udmabuf *ubuf = buf->priv;
>>>> -	struct device *dev = ubuf->device->this_device;
>>>> -	int ret = 0;
>>>> -
>>>> -	if (!ubuf->sg) {
>>>> -		ubuf->sg = get_sg_table(dev, buf, direction);
>>>> -		if (IS_ERR(ubuf->sg)) {
>>>> -			ret = PTR_ERR(ubuf->sg);
>>>> -			ubuf->sg = NULL;
>>>> -		}
>>>> -	} else {
>>>> -		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
>>>> -				    direction);
>>>> -	}
>>>> +	struct udmabuf_attachment *a;
>>>>
>>>> -	return ret;
>>>> +	mutex_lock(&ubuf->lock);
>>>> +
>>>> +	list_for_each_entry(a, &ubuf->attachments, list)
>>>> +		dma_sync_sgtable_for_cpu(a->dev, a->table, direction);
>>>> +
>>>> +	mutex_unlock(&ubuf->lock);
>>>> +
>>>> +	return 0;
>>>>    }
>>>>
>>>>    static int end_cpu_udmabuf(struct dma_buf *buf,
>>>>    			   enum dma_data_direction direction)
>>>>    {
>>>>    	struct udmabuf *ubuf = buf->priv;
>>>> -	struct device *dev = ubuf->device->this_device;
>>>> +	struct udmabuf_attachment *a;
>>>>
>>>> -	if (!ubuf->sg)
>>>> -		return -EINVAL;
>>>> +	mutex_lock(&ubuf->lock);
>>>> +
>>>> +	list_for_each_entry(a, &ubuf->attachments, list)
>>>> +		dma_sync_sgtable_for_device(a->dev, a->table, direction);
>>>> +
>>>> +	mutex_unlock(&ubuf->lock);
>>>>
>>>> -	dma_sync_sg_for_device(dev, ubuf->sg->sgl, ubuf->sg->nents,
>>>> direction);
>>>>    	return 0;
>>>>    }
>>>>
>>>> @@ -307,7 +299,6 @@ static long udmabuf_create(struct miscdevice
>>>> *device,
>>>>    	exp_info.priv = ubuf;
>>>>    	exp_info.flags = O_RDWR;
>>>>
>>>> -	ubuf->device = device;
>>>>    	buf = dma_buf_export(&exp_info);
>>>>    	if (IS_ERR(buf)) {
>>>>    		ret = PTR_ERR(buf);
>>>> --
>>>> 2.39.2
>>>

