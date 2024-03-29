Return-Path: <linux-kernel+bounces-124049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83958891188
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69F61C2A9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E80335DB;
	Fri, 29 Mar 2024 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KPupsMe7"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A754EB45;
	Fri, 29 Mar 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678223; cv=none; b=Ub31zwgQD/VtpkSkL+dTH+DQpTbySddp7m+RSBO3pbJ09RuhI2q20Aj22Cx5weBrw/nhVfqf6RLjLsxBpiDde0zRbZNB34q3R7y1+bdFALWHQHeyVTBExUxAgDsnryQJAQE9tznIfu/prIyBJCufIPD3NA0xXLqg14YHKgYKAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678223; c=relaxed/simple;
	bh=hj5TjGL4a8qXk947vXHRELwRpXFvFpzKGFWwPuPdOh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCzeNAvt7mVKtnerffdraTyYHMEOcL7NUkKNnkRFGIfDT8y/POmB6CvYTxndyL26cS7P6x8fZx6CUWDU2Klu+bYA9UhGyFXRYvKiWPJe8GpKEs6LvmXw1CBT+XdrbLt0rmtQeaXaHXajfFy40kGqSNMcBUNYIsg9snZJRybBDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KPupsMe7; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711678213; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NX8pI+Bd0/enxNzF+RhtcwIAqaNwq85yczophRjct+I=;
	b=KPupsMe7H6qADWrwXStA2JgCOZ0U/RgzM2CxrMtUp8pEN2VJctvlle1oEFeOG+UbHCpsSY+jB1wkmaLXLIGlsiS7iOOojUUn93YOHfWKmKZNpT4N3BsAL1iZz4rQnzkA6pfUpIZnR3iqyV75DztbQXTBVwCk0Uax9ST4OonAlrs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W3UsYoD_1711678211;
Received: from 30.221.147.241(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3UsYoD_1711678211)
          by smtp.aliyun-inc.com;
          Fri, 29 Mar 2024 10:10:12 +0800
Message-ID: <82e6e5c0-0943-467e-a11b-e511839f38eb@linux.alibaba.com>
Date: Fri, 29 Mar 2024 10:10:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] virtio_net: Do not set rss_indir if RSS is not
 supported
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com, riel@surriel.com,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240326151911.2155689-1-leitao@debian.org>
 <1711503463.632461-1-xuanzhuo@linux.alibaba.com> <ZgQkXfMd6GIEndXm@gmail.com>
 <1711589335.4973893-1-xuanzhuo@linux.alibaba.com>
 <ZgWAmsB4vTXE66uJ@gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <ZgWAmsB4vTXE66uJ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/28 下午10:37, Breno Leitao 写道:
>>> On Wed, Mar 27, 2024 at 09:37:43AM +0800, Xuan Zhuo wrote:
>>>> On Tue, 26 Mar 2024 08:19:08 -0700, Breno Leitao <leitao@debian.org> wrote:
>>>>> Do not set virtnet_info->rss_indir_table_size if RSS is not available
>>>>> for the device.
>>>>>
>>>>> Currently, rss_indir_table_size is set if either has_rss or
>>>>> has_rss_hash_report is available, but, it should only be set if has_rss
>>>>> is set.
>>>>>
>>>>> On the virtnet_set_rxfh(), return an invalid command if the request has
>>>>> indirection table set, but virtnet does not support RSS.
>>>>>
>>>>> Suggested-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>>>> ---
>>>>>   drivers/net/virtio_net.c | 9 +++++++--
>>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>> index c22d1118a133..c640fdf28fc5 100644
>>>>> --- a/drivers/net/virtio_net.c
>>>>> +++ b/drivers/net/virtio_net.c
>>>>> @@ -3813,6 +3813,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
>>>>>   	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>>>>>   		return -EOPNOTSUPP;
>>>>>
>>>>> +	if (rxfh->indir && !vi->has_rss)
>>>>> +		return -EINVAL;
>>>>> +
>>>>>   	if (rxfh->indir) {
>>>> Put !vi->has_rss here?
>>> I am not sure I understand the suggestion. Where do you suggest we have
>>> !vi->has_rss?
>>>
>>> If we got this far, we either have:
>>>
>>> a) rxfh->indir set and vi->has_rss is also set
>>> b) rxfh->indir not set. (vi->has_rss could be set or not).
>>
>> This function does two tasks.
>> 1. update indir table
>> 2. update rss key
>>
>> #1 only for has_rss
>> #2 for has_rss or has_rss_hash_report
>>
>>
>> So I would code:
>>
>> 	bool update = false
>>
>> 	if (rxfh->indir) {
>> 		if (!vi->has_rss)
>> 			return -EINVAL;
>>
>> 		for (i = 0; i < vi->rss_indir_table_size; ++i)
>> 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
>>
>> 		update = true
>> 	}
>>
>> 	if (rxfh->key) {
>> 		if (!vi->has_rss && !vi->has_rss_hash_report)
>> 			return -EINVAL;
>>
>> 		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
>> 		update = true
>> 	}
>>
>>
>> 	if (update)
>> 		virtnet_commit_rss_command(vi);
>>
>> Thanks.
> This is a bit different from the previous proposal, but, I like this one
> approach better. It makes the code easier to read.
>
> How does the full patch looks like?
>
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..180f342f1898 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3807,20 +3807,35 @@ static int virtnet_set_rxfh(struct net_device *dev,
>   			    struct netlink_ext_ack *extack)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
> +	bool update = false;
>   	int i;
>   
> +	if (!vi->has_rss && !vi->has_rss_hash_report)
> +		return -EOPNOTSUPP;
> +

I think this two modifications are no longer needed as they have been 
embedded below.

>   	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
>   	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>   		return -EOPNOTSUPP;
>   
>   	if (rxfh->indir) {
> +		if (!vi->has_rss)
> +			return -EINVAL;

-EOPNOTSUPP seems better.

> +
>   		for (i = 0; i < vi->rss_indir_table_size; ++i)
>   			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> +		update = true;
>   	}
> -	if (rxfh->key)
> +
> +	if (rxfh->key) {
> +		if (!vi->has_rss && !vi->has_rss_hash_report)
> +			return -EINVAL;

Same as above. return -EOPNOTSUPP.

Others look good.

Thanks.

> +
>   		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
> +		update = true;
> +	}
>   
> -	virtnet_commit_rss_command(vi);
> +	if (update)
> +		virtnet_commit_rss_command(vi);
>   
>   	return 0;
>   }
> @@ -4729,13 +4744,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>   		vi->has_rss_hash_report = true;
>   
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
>   		vi->has_rss = true;
>   
> -	if (vi->has_rss || vi->has_rss_hash_report) {
>   		vi->rss_indir_table_size =
>   			virtio_cread16(vdev, offsetof(struct virtio_net_config,
>   				rss_max_indirection_table_length));
> +	}
> +
> +	if (vi->has_rss || vi->has_rss_hash_report) {
>   		vi->rss_key_size =
>   			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
>   


