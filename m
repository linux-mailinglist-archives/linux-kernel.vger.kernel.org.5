Return-Path: <linux-kernel+bounces-6915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD8819F49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069B71C22EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B425543;
	Wed, 20 Dec 2023 12:45:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258C219F6;
	Wed, 20 Dec 2023 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4SwCsh2GmBz1Q6N0;
	Wed, 20 Dec 2023 20:43:36 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 54C381404F1;
	Wed, 20 Dec 2023 20:44:50 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Dec
 2023 20:44:50 +0800
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To: Jason Wang <jasowang@redhat.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>
References: <20231205113444.63015-1-linyunsheng@huawei.com>
 <20231205113444.63015-7-linyunsheng@huawei.com>
 <CACGkMEvVezZnHK-gRWY+MUd_6awnprb024scqPNmMQ05P8rWTQ@mail.gmail.com>
 <424670ab-23d8-663b-10cb-d88906767956@huawei.com>
 <CACGkMEsMdP1B-9RaqibJYfFsd_qJpB+Kta5BnyD_WXH=W2w_OQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <c5b5d36c-d0ca-c943-5355-343214d92c26@huawei.com>
Date: Wed, 20 Dec 2023 20:44:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsMdP1B-9RaqibJYfFsd_qJpB+Kta5BnyD_WXH=W2w_OQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2023/12/12 12:35, Jason Wang wrote:>>>> +done:
>>>> +       backend.fd = tun_alloc();
>>>> +       assert(backend.fd >= 0);
>>>> +       vdev_info_init(&dev, features);
>>>> +       vq_info_add(&dev, 256);
>>>> +       run_test(&dev, &dev.vqs[0], delayed, batch, reset, nbufs);
>>>
>>> I'd expect we are testing some basic traffic here. E.g can we use a
>>> packet socket then we can test both tx and rx?
>>
>> Yes, only rx for tun is tested.
>> Do you have an idea how to test the tx too? As I am not familar enough
>> with vhost_net and tun yet.
> 
> Maybe you can have a packet socket to bind to the tun/tap. Then you can test:
> 
> 1) TAP RX: by write a packet via virtqueue through vhost_net and read
> it from packet socket
> 2) TAP TX:  by write via packet socket and read it from the virtqueue
> through vhost_net

When implementing the TAP TX by adding VHOST_NET_F_VIRTIO_NET_HDR,
I found one possible use of uninitialized data in vhost_net_build_xdp().

And vhost_hlen is set to sizeof(struct virtio_net_hdr_mrg_rxbuf) and
sock_hlen is set to zero in vhost_net_set_features() for both tx and rx
queue.

For vhost_net_build_xdp() called by handle_tx_copy():

The (gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) checking below may cause a
read of uninitialized data if sock_hlen is zero.

And it seems vhost_hdr is skipped in get_tx_bufs():
https://elixir.bootlin.com/linux/latest/source/drivers/vhost/net.c#L616

static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
			       struct iov_iter *from)
{
...
	buflen += SKB_DATA_ALIGN(len + pad);
	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
	if (unlikely(!vhost_net_page_frag_refill(net, buflen,
						 alloc_frag, GFP_KERNEL)))
		return -ENOMEM;

	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
	copied = copy_page_from_iter(alloc_frag->page,
				     alloc_frag->offset +
				     offsetof(struct tun_xdp_hdr, gso),
				     sock_hlen, from);
	if (copied != sock_hlen)
		return -EFAULT;

	hdr = buf;
	gso = &hdr->gso;

	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
	    vhost16_to_cpu(vq, gso->csum_start) +
	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >
	    vhost16_to_cpu(vq, gso->hdr_len)) {
...
}

I seems the handle_tx_copy() does not handle the VHOST_NET_F_VIRTIO_NET_HDR
case correctly, Or do I miss something obvious here?

> 
> Thanks
> 
>>
>>>
>>> Thanks
>>
> 
> .
> 

