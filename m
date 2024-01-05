Return-Path: <linux-kernel+bounces-17403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A1824CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B11F22C33
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7D020EE;
	Fri,  5 Jan 2024 02:09:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3281FBF;
	Fri,  5 Jan 2024 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T5n0r5MPZz1Q7Vm;
	Fri,  5 Jan 2024 10:07:56 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 59286140631;
	Fri,  5 Jan 2024 10:09:24 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 5 Jan
 2024 10:09:24 +0800
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To: Eugenio Perez Martin <eperezma@redhat.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-7-linyunsheng@huawei.com>
 <CAJaqyWfHLDRL4z9ooNS2w_yGE_jnHfi2spdYPP_=F0jgSj3mJQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <4417b8ff-144d-374b-2188-38e30567a5ba@huawei.com>
Date: Fri, 5 Jan 2024 10:09:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfHLDRL4z9ooNS2w_yGE_jnHfi2spdYPP_=F0jgSj3mJQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/5 0:17, Eugenio Perez Martin wrote:
> On Wed, Jan 3, 2024 at 11:00 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:

...

>> +
>> +static void run_tx_test(struct vdev_info *dev, struct vq_info *vq,
>> +                       bool delayed, int batch, int bufs)
>> +{
>> +       const bool random_batch = batch == RANDOM_BATCH;
>> +       long long spurious = 0;
>> +       struct scatterlist sl;
>> +       unsigned int len;
>> +       int r;
>> +
>> +       for (;;) {
>> +               long started_before = vq->started;
>> +               long completed_before = vq->completed;
>> +
>> +               virtqueue_disable_cb(vq->vq);
>> +               do {
>> +                       if (random_batch)
>> +                               batch = (random() % vq->vring.num) + 1;
>> +
>> +                       while (vq->started < bufs &&
>> +                              (vq->started - vq->completed) < batch) {
>> +                               sg_init_one(&sl, dev->test_buf, HDR_LEN + TEST_BUF_LEN);
>> +                               r = virtqueue_add_outbuf(vq->vq, &sl, 1,
>> +                                                        dev->test_buf + vq->started,
>> +                                                        GFP_ATOMIC);
>> +                               if (unlikely(r != 0)) {
>> +                                       if (r == -ENOSPC &&
>> +                                           vq->started > started_before)
>> +                                               r = 0;
>> +                                       else
>> +                                               r = -1;
>> +                                       break;
>> +                               }
>> +
>> +                               ++vq->started;
>> +
>> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
>> +                                       r = -1;
>> +                                       break;
>> +                               }
>> +                       }
>> +
>> +                       if (vq->started >= bufs)
>> +                               r = -1;
>> +
>> +                       /* Flush out completed bufs if any */
>> +                       while (virtqueue_get_buf(vq->vq, &len)) {
>> +                               int n, i;
>> +
>> +                               n = recvfrom(dev->sock, dev->res_buf, TEST_BUF_LEN, 0, NULL, NULL);
>> +                               assert(n == TEST_BUF_LEN);
>> +
>> +                               for (i = ETHER_HDR_LEN; i < n; i++)
>> +                                       assert(dev->res_buf[i] == (char)i);
>> +
>> +                               ++vq->completed;
>> +                               r = 0;
>> +                       }
>> +               } while (r == 0);
>> +
>> +               if (vq->completed == completed_before && vq->started == started_before)
>> +                       ++spurious;
>> +
>> +               assert(vq->completed <= bufs);
>> +               assert(vq->started <= bufs);
>> +               if (vq->completed == bufs)
>> +                       break;
>> +
>> +               if (delayed) {
>> +                       if (virtqueue_enable_cb_delayed(vq->vq))
>> +                               wait_for_interrupt(vq);
>> +               } else {
>> +                       if (virtqueue_enable_cb(vq->vq))
>> +                               wait_for_interrupt(vq);
>> +               }
>> +       }
>> +       printf("TX spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
>> +              spurious, vq->started, vq->completed);
>> +}
>> +
>> +static void run_rx_test(struct vdev_info *dev, struct vq_info *vq,
>> +                       bool delayed, int batch, int bufs)
>> +{
>> +       const bool random_batch = batch == RANDOM_BATCH;
>> +       long long spurious = 0;
>> +       struct scatterlist sl;
>> +       unsigned int len;
>> +       int r;
>> +
>> +       for (;;) {
>> +               long started_before = vq->started;
>> +               long completed_before = vq->completed;
>> +
>> +               do {
>> +                       if (random_batch)
>> +                               batch = (random() % vq->vring.num) + 1;
>> +
>> +                       while (vq->started < bufs &&
>> +                              (vq->started - vq->completed) < batch) {
>> +                               sg_init_one(&sl, dev->res_buf, HDR_LEN + TEST_BUF_LEN);
>> +
>> +                               r = virtqueue_add_inbuf(vq->vq, &sl, 1,
>> +                                                       dev->res_buf + vq->started,
>> +                                                       GFP_ATOMIC);
>> +                               if (unlikely(r != 0)) {
>> +                                       if (r == -ENOSPC &&
>> +                                           vq->started > started_before)
>> +                                               r = 0;
>> +                                       else
>> +                                               r = -1;
>> +                                       break;
>> +                               }
>> +
>> +                               ++vq->started;
>> +
>> +                               vdev_send_packet(dev);
>> +
>> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
>> +                                       r = -1;
>> +                                       break;
>> +                               }
>> +                       }
>> +
>> +                       if (vq->started >= bufs)
>> +                               r = -1;
>> +
>> +                       /* Flush out completed bufs if any */
>> +                       while (virtqueue_get_buf(vq->vq, &len)) {
>> +                               struct ether_header *eh;
>> +                               int i;
>> +
>> +                               eh = (struct ether_header *)(dev->res_buf + HDR_LEN);
>> +
>> +                               /* tun netdev is up and running, ignore the
>> +                                * non-TEST_PTYPE packet.
>> +                                */
>> +                               if (eh->ether_type != htons(TEST_PTYPE)) {
>> +                                       ++vq->completed;
>> +                                       r = 0;
>> +                                       continue;
>> +                               }
>> +
>> +                               assert(len == TEST_BUF_LEN + HDR_LEN);
>> +
>> +                               for (i = ETHER_HDR_LEN; i < TEST_BUF_LEN; i++)
>> +                                       assert(dev->res_buf[i + HDR_LEN] == (char)i);
>> +
>> +                               ++vq->completed;
>> +                               r = 0;
>> +                       }
>> +               } while (r == 0);
>> +               if (vq->completed == completed_before && vq->started == started_before)
>> +                       ++spurious;
>> +
>> +               assert(vq->completed <= bufs);
>> +               assert(vq->started <= bufs);
>> +               if (vq->completed == bufs)
>> +                       break;
>> +       }
>> +
>> +       printf("RX spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
>> +              spurious, vq->started, vq->completed);
>> +}
> 
> Hi!
> 
> I think the tests are great! Maybe both run_rx_test and run_tx_test
> (and virtio_test.c:run_test) can be merged into a common function with
> some callbacks? Not sure if it will complicate the code more.

I looked at it more closely, it seems using callback just make the code
more complicated without obvious benefit, as the main steps is different
for tx and rx.

For tx:
1. Prepare a out buf
2. Kick the vhost_net to do tx processing
3. Do the receiving in the tun side
4. verify the data received by tun is correct

For rx:
1. Prepare a in buf
2. Do the sending in the tun side
3. Kick the vhost_net to do rx processing
4. verify the data received by vhost_net is correct

I could refactor out a common function to do the data verifying for step 4
of both tx and rx.

For virtio_test.c:run_test, it does not seems to be using the vhost_net directly,
it uses shim vhost_test.ko module, and it seems to only have step 1 & 3 of
vhost_net_test' rx testing. The new vhost_net_test should be able to replace the
virtio_test, I thought about deleting the virtio_test after adding the vhost_net_test,
but I am not familiar enough with virtio to do the judgement yet.

> 
> Thanks!
> 


