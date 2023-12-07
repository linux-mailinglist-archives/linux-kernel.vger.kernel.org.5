Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC208086BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjLGL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjLGL2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:28:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E1310C2;
        Thu,  7 Dec 2023 03:28:19 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SmBp05SJ9zYsnN;
        Thu,  7 Dec 2023 19:27:36 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 7 Dec
 2023 19:28:17 +0800
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To:     Jason Wang <jasowang@redhat.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        <virtualization@lists.linux.dev>
References: <20231205113444.63015-1-linyunsheng@huawei.com>
 <20231205113444.63015-7-linyunsheng@huawei.com>
 <CACGkMEvVezZnHK-gRWY+MUd_6awnprb024scqPNmMQ05P8rWTQ@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <424670ab-23d8-663b-10cb-d88906767956@huawei.com>
Date:   Thu, 7 Dec 2023 19:28:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CACGkMEvVezZnHK-gRWY+MUd_6awnprb024scqPNmMQ05P8rWTQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/7 14:00, Jason Wang wrote:
> On Tue, Dec 5, 2023 at 7:35 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
...

>> +
>> +static int tun_alloc(void)
>> +{
>> +       struct ifreq ifr;
>> +       int fd, e;
>> +
>> +       fd = open("/dev/net/tun", O_RDWR);
>> +       if (fd < 0) {
>> +               perror("Cannot open /dev/net/tun");
>> +               return fd;
>> +       }
>> +
>> +       memset(&ifr, 0, sizeof(ifr));
>> +
>> +       ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
> 
> Why did you use IFF_TUN but not IFF_TAP here?

To be honest, no particular reason, I just picked IFF_TUN and it happened
to work for me to test changing in vhost_net_build_xdp().

Is there a particular reason you perfer the IFF_TAP over IFF_TUN?

> 
>> +       strncpy(ifr.ifr_name, "tun0", IFNAMSIZ);
> 
> tun0 is pretty common if there's a VPN. Do we need some randomized name here?

How about something like below?

snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());

> 
> 
>> +
>> +       e = ioctl(fd, TUNSETIFF, (void *) &ifr);
>> +       if (e < 0) {
>> +               perror("ioctl[TUNSETIFF]");
>> +               close(fd);
>> +               return e;
>> +       }
>> +
>> +       return fd;
>> +}
>> +
>> +/* Unused */
>> +void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> 
> Why do we need trick like these here?

That is because of the below error:
tools/virtio/./linux/kernel.h:58: undefined reference to `__kmalloc_fake'

when virtio_ring.c is compiled in the userspace, the kmalloc raleted function
is implemented in tools/virtio/./linux/kernel.h, which requires those varibles
to be defined.

> 
>> +
>> +struct vq_info {
>> +       int kick;
>> +       int call;
>> +       int num;
>> +       int idx;
>> +       void *ring;
>> +       /* copy used for control */
>> +       struct vring vring;
>> +       struct virtqueue *vq;
>> +};
>> +
>> +struct vdev_info {
>> +       struct virtio_device vdev;
>> +       int control;
>> +       struct pollfd fds[1];
>> +       struct vq_info vqs[1];
>> +       int nvqs;
>> +       void *buf;
>> +       size_t buf_size;
>> +       struct vhost_memory *mem;
>> +};
>> +
>> +static struct vhost_vring_file no_backend = { .index = 1, .fd = -1 },
>> +                                    backend = { .index = 1, .fd = 1 };
> 
> A magic number like fd = 1 is pretty confusing.
> 
> And I don't see why we need global variables here.

I was using the virtio_test.c as reference, will try to remove it
if it is possible.

> 
>> +static const struct vhost_vring_state null_state = {};
>> +

..

>> +
>> +done:
>> +       backend.fd = tun_alloc();
>> +       assert(backend.fd >= 0);
>> +       vdev_info_init(&dev, features);
>> +       vq_info_add(&dev, 256);
>> +       run_test(&dev, &dev.vqs[0], delayed, batch, reset, nbufs);
> 
> I'd expect we are testing some basic traffic here. E.g can we use a
> packet socket then we can test both tx and rx?

Yes, only rx for tun is tested.
Do you have an idea how to test the tx too? As I am not familar enough
with vhost_net and tun yet.

> 
> Thanks
