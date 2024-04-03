Return-Path: <linux-kernel+bounces-129226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9034896755
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB421C24FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D13605B6;
	Wed,  3 Apr 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KQi5tStu"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD15BAD7;
	Wed,  3 Apr 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131056; cv=none; b=bJDyt3ZnUYAQaa8/Lm0jYo2ZNtdvugZPiiwS4PszAF6dGM2YY3p5+jwEl3Ggp3bHYEv+9K7LrGlrsghPiP7rSwSmq/fXK0Heb1CB/oEgf8Tp6rkEY6zYJZ7JUtcgu/5QZ4rVo4dxtAvym5cyYP3JdmZpps9sGxmaeuM91KSHoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131056; c=relaxed/simple;
	bh=NWpwTnjcEDhRKvpJ+SIhLpymU8TaR5Qc2w5x9QzXbL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1qhghtUAfGGh79Bb1ed3COcN9/dl2uf2u2ziplwYdIUJG+mtm7qeBuLA+WcB5Z2naQsbW60LKnuQEYbiNBwNSbuunTww+cn6ka8HoSKtwN1kVmJ/MGHC8NlRW35gsKqGsfSDWEDVFq2Q8RFSyu2/F25Kd8kCFIYIiq4NaEwwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KQi5tStu; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712131045; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R0yA25vpOsgMjEIbg/eLjwHteozmPXXyADvI8WORaFA=;
	b=KQi5tStuas3JwKzy6NaNA/+QUR+0Mf1o5TveDdt56XAj77qTK/PnkWSTmN2QvPGGJOouG62b2hhEeGW/tgOWfkVyrrmOIjiAEt5bNBWxJy/Dei9sJ+xUnSvTof9vF7YOmPONcwdojGzjkdFNMKVFA3W2BUWmEFM4mtcxR6BK7tI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3qvPFc_1712131042;
Received: from 30.221.147.161(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3qvPFc_1712131042)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 15:57:23 +0800
Message-ID: <ae848a33-383f-40d8-9c41-7a4b51045b3b@linux.alibaba.com>
Date: Wed, 3 Apr 2024 15:57:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
To: Breno Leitao <leitao@debian.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com, riel@surriel.com,
 stable@vger.kernel.org, qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240329171641.366520-1-leitao@debian.org>
 <20240331160618-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240331160618-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/1 上午4:20, Michael S. Tsirkin 写道:
> On Fri, Mar 29, 2024 at 10:16:41AM -0700, Breno Leitao wrote:
>> There is a bug when setting the RSS options in virtio_net that can break
>> the whole machine, getting the kernel into an infinite loop.
>>
>> Running the following command in any QEMU virtual machine with virtionet
>> will reproduce this problem:
>>
>>      # ethtool -X eth0  hfunc toeplitz
>>
>> This is how the problem happens:
>>
>> 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
>>
>> 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
>>
>> 3) virtnet_commit_rss_command() populates 4 entries for the rss
>> scatter-gather
>>
>> 4) Since the command above does not have a key, then the last
>> scatter-gatter entry will be zeroed, since rss_key_size == 0.
>> sg_buf_size = vi->rss_key_size;
>>
>> 5) This buffer is passed to qemu, but qemu is not happy with a buffer
>> with zero length, and do the following in virtqueue_map_desc() (QEMU
>> function):
>>
>>    if (!sz) {
>>        virtio_error(vdev, "virtio: zero sized buffers are not allowed");
>>
>> 6) virtio_error() (also QEMU function) set the device as broken
>>
>>      vdev->broken = true;
>>
>> 7) Qemu bails out, and do not repond this crazy kernel.
>>
>> 8) The kernel is waiting for the response to come back (function
>> virtnet_send_command())
>>
>> 9) The kernel is waiting doing the following :
>>
>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>> 	     !virtqueue_is_broken(vi->cvq))
>> 	      cpu_relax();
>>
>> 10) None of the following functions above is true, thus, the kernel
>> loops here forever. Keeping in mind that virtqueue_is_broken() does
>> not look at the qemu `vdev->broken`, so, it never realizes that the
>> vitio is broken at QEMU side.
>>
>> Fix it by not sending RSS commands if the feature is not available in
>> the device.
>>
>> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
>> Cc: stable@vger.kernel.org
> net has its own stable process, don't CC stable on net patches.
>
>
>> Cc: qemu-devel@nongnu.org
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>> Changelog:
>>
>> V2:
>>    * Moved from creating a valid packet, by rejecting the request
>>      completely
>> V3:
>>    * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
>>      the rejection path.
>>
>> ---
>>   drivers/net/virtio_net.c | 22 ++++++++++++++++++----
>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index c22d1118a133..c4a21ec51adf 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
>>   			    struct netlink_ext_ack *extack)
>>   {
>>   	struct virtnet_info *vi = netdev_priv(dev);
>> +	bool update = false;
>>   	int i;
>>   
>>   	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
>> @@ -3814,13 +3815,24 @@ static int virtnet_set_rxfh(struct net_device *dev,
>>   		return -EOPNOTSUPP;
>>   
>>   	if (rxfh->indir) {
>> +		if (!vi->has_rss)
>> +			return -EOPNOTSUPP;
>> +
>>   		for (i = 0; i < vi->rss_indir_table_size; ++i)
>>   			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
>> +		update = true;
>>   	}
>> -	if (rxfh->key)
>> +
>> +	if (rxfh->key) {
>> +		if (!vi->has_rss && !vi->has_rss_hash_report)
>> +			return -EOPNOTSUPP;
>
> What's the logic here? Is it || or &&? A comment can't hurt.

&&

Hi Breno,

You can add a comment like the following:

If either _F_HASH_REPORT or _F_RSS are negotiated, the device provides
hash calculation capabilities, that is, hash_key can be configured.

Regards,
Heng

>
>> +
>>   		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
>> +		update = true;
>> +	}
>>   
>> -	virtnet_commit_rss_command(vi);
>> +	if (update)
>> +		virtnet_commit_rss_command(vi);
>>   
>>   	return 0;
>>   }
>> @@ -4729,13 +4741,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>>   		vi->has_rss_hash_report = true;
>>   
>> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
>> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
>>   		vi->has_rss = true;
>>   
>> -	if (vi->has_rss || vi->has_rss_hash_report) {
>>   		vi->rss_indir_table_size =
>>   			virtio_cread16(vdev, offsetof(struct virtio_net_config,
>>   				rss_max_indirection_table_length));
>> +	}
>> +
>> +	if (vi->has_rss || vi->has_rss_hash_report) {
>>   		vi->rss_key_size =
>>   			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
>>   
>> -- 
>> 2.43.0


