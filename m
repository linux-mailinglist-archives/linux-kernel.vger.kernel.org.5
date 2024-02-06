Return-Path: <linux-kernel+bounces-54239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32584ACBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E64283941
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A84BAAA;
	Tue,  6 Feb 2024 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjX4Tl74"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB74745E5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188910; cv=none; b=EsFiWmREeAK4Zdp/koSDJtsYvsFmzKnSki39qiuwE3l1NarAFU0Y/9lPTdRU3BhUSHj46EIiQSKKdG+YGSJf0YPKu9N/vVSjlDnEppT/1LUgLxoAoZhUJPE+19od1eQ/PRuVpVc/nQD2Q5NjprdB4AVUh18A2n0dx/7/BN/VLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188910; c=relaxed/simple;
	bh=d4/Xdc3RDPX9yQFzLbD/w3v8QdUW1JkPJki7k0rJDnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV/7sIlWd6SLD78+PPvDxYnejariAMeQabr1/InqqGXX80H+Ml2sOWNJL/i5EHd6UKOgEi3Mf6s3tSeZeiJEeBpmLdnV0IVef6zTrawS1g5tC39WdgVia/yZNOgAimk7qPAK/ertAwy6Lal6Hyy50hMoFnsx8toebpmBKBn6WNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjX4Tl74; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707188906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4coahlz/EBj4Pt0jKop1+g2Y8QuGd/wq0ymO/hlVzac=;
	b=NjX4Tl744fTbXBeEx6dQ9pLymmeU6vt2BIeNBlgXL677ySTmtIbDDiZEZtIKXt45CDdqJR
	DXa90bw3Yn/lHGcTEfbijEY37Nr01yPdvHrU8HznhqHHvMzd5sYYv/UvXsS2NKyXcG2SQo
	8xx1JScr1AQ6Zcbc3FgIAVTRrNU0bsg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-hHh3EF0kM86_faxk3dVdFw-1; Mon, 05 Feb 2024 22:08:25 -0500
X-MC-Unique: hHh3EF0kM86_faxk3dVdFw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6e112f748e1so3334744a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707188904; x=1707793704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4coahlz/EBj4Pt0jKop1+g2Y8QuGd/wq0ymO/hlVzac=;
        b=ci19peDhTPPaxLpw9O+nLJnbR/bY4i6nh5VoxfrSNhZJE7eyInJfJcokoUnh72cAGn
         iCuW/ZmmcmKDcYxvRd1eW2jNhsCeAPI5gCF62pQfd5NQ65q8YIkr6xjUj2HIQ2u28dNq
         1EgjrmGW1ujna4opu4d5dkOpGDhLFx5QMnZRLN3+bv0Xw8oxEhgHiGM3xOzvV2tBRajF
         IMPjxfeUCag5izOXzvd3ylXD0QzKaYyYc+QJ2+sZir8XByAlHxM7g8srJFRT4zF+mFp/
         t3BhXvmnrBXO8ce1MQCt8d8ZN6kBJD73DahARmMFxRa13xTK7VglA1MA2rhwQ25/Y6Uz
         Oncg==
X-Gm-Message-State: AOJu0YzxF1BgXzvnBFyvVLFnavaor8EyU/Y9kNOhUBCfLVj7ORzZKZOi
	JUWkf+EK8vv/HCV4X+VnhnGwNw0vaK6D8jVQyjsy1KeVQ8cA9P62lADpUxKJQSG3Fgm8HGdQngx
	KVMjYqrKfoOn1Yj1y4GsgGgt99TPSW3xgEBevTUINGMbanlXcAQ5jtzcheMLNLnKT06aAaIz7Ya
	2quiCnBVWzGz/wworhgSYJpcYj8W8Tc4uGQPlL
X-Received: by 2002:a05:6808:318e:b0:3bd:cacd:332d with SMTP id cd14-20020a056808318e00b003bdcacd332dmr2715491oib.40.1707188904515;
        Mon, 05 Feb 2024 19:08:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQny3V1VkYtRB2ydA1yRnrOiZEf8txFsj8hfIvEAejsnMmlzfAYMzDJtsYqOGeWCY0/xT1aXBK4lyE7E6bTcE=
X-Received: by 2002:a05:6808:318e:b0:3bd:cacd:332d with SMTP id
 cd14-20020a056808318e00b003bdcacd332dmr2715477oib.40.1707188904216; Mon, 05
 Feb 2024 19:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124506.57670-1-linyunsheng@huawei.com> <20240205124506.57670-6-linyunsheng@huawei.com>
In-Reply-To: <20240205124506.57670-6-linyunsheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Feb 2024 11:08:11 +0800
Message-ID: <CACGkMEsKHOefArPd56RAYPsJE8kf=jGb6B-V6eNJiViCAD7GYA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 5/5] tools: virtio: introduce vhost_net_test
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:46=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> introduce vhost_net_test for both vhost_net tx and rx basing
> on virtio_test to test vhost_net changing in the kernel.
>
> Steps for vhost_net tx testing:
> 1. Prepare a out buf.
> 2. Kick the vhost_net to do tx processing.
> 3. Do the receiving in the tun side.
> 4. verify the data received by tun is correct.
>
> Steps for vhost_net rx testing:
> 1. Prepare a in buf.
> 2. Do the sending in the tun side.
> 3. Kick the vhost_net to do rx processing.
> 4. verify the data received by vhost_net is correct.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  tools/virtio/.gitignore            |   1 +
>  tools/virtio/Makefile              |   8 +-
>  tools/virtio/linux/virtio_config.h |   4 +
>  tools/virtio/vhost_net_test.c      | 536 +++++++++++++++++++++++++++++
>  4 files changed, 546 insertions(+), 3 deletions(-)
>  create mode 100644 tools/virtio/vhost_net_test.c
>
> diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
> index 9934d48d9a55..7e47b281c442 100644
> --- a/tools/virtio/.gitignore
> +++ b/tools/virtio/.gitignore
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  *.d
>  virtio_test
> +vhost_net_test
>  vringh_test
>  virtio-trace/trace-agent
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index d128925980e0..e25e99c1c3b7 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -1,8 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  all: test mod
> -test: virtio_test vringh_test
> +test: virtio_test vringh_test vhost_net_test
>  virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
> +vhost_net_test: virtio_ring.o vhost_net_test.o
>
>  try-run =3D $(shell set -e;              \
>         if ($(1)) >/dev/null 2>&1;      \
> @@ -49,6 +50,7 @@ oot-clean: OOT_BUILD+=3Dclean
>
>  .PHONY: all test mod clean vhost oot oot-clean oot-build
>  clean:
> -       ${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cm=
d \
> -              vhost_test/Module.symvers vhost_test/modules.order *.d
> +       ${RM} *.o vringh_test virtio_test vhost_net_test vhost_test/*.o \
> +              vhost_test/.*.cmd vhost_test/Module.symvers \
> +              vhost_test/modules.order *.d
>  -include *.d
> diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virt=
io_config.h
> index 2a8a70e2a950..42a564f22f2d 100644
> --- a/tools/virtio/linux/virtio_config.h
> +++ b/tools/virtio/linux/virtio_config.h
> @@ -1,4 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef LINUX_VIRTIO_CONFIG_H
> +#define LINUX_VIRTIO_CONFIG_H
>  #include <linux/virtio_byteorder.h>
>  #include <linux/virtio.h>
>  #include <uapi/linux/virtio_config.h>
> @@ -95,3 +97,5 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_=
device *vdev, u64 val)
>  {
>         return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
>  }
> +
> +#endif
> diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.=
c
> new file mode 100644
> index 000000000000..6c41204e6707
> --- /dev/null
> +++ b/tools/virtio/vhost_net_test.c
> @@ -0,0 +1,536 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <getopt.h>
> +#include <limits.h>
> +#include <string.h>
> +#include <poll.h>
> +#include <sys/eventfd.h>
> +#include <stdlib.h>
> +#include <assert.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <linux/vhost.h>
> +#include <linux/if.h>
> +#include <linux/if_tun.h>
> +#include <linux/in.h>
> +#include <linux/if_packet.h>
> +#include <linux/virtio_net.h>
> +#include <netinet/ether.h>
> +
> +#define HDR_LEN                sizeof(struct virtio_net_hdr_mrg_rxbuf)
> +#define TEST_BUF_LEN   256
> +#define TEST_PTYPE     ETH_P_LOOPBACK
> +#define DESC_NUM       256
> +
> +/* Used by implementation of kmalloc() in tools/virtio/linux/kernel.h */
> +void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> +
> +struct vq_info {
> +       int kick;
> +       int call;
> +       int idx;
> +       long started;
> +       long completed;
> +       struct pollfd fds;
> +       void *ring;
> +       /* copy used for control */
> +       struct vring vring;
> +       struct virtqueue *vq;
> +};
> +
> +struct vdev_info {
> +       struct virtio_device vdev;
> +       int control;
> +       struct vq_info vqs[2];
> +       int nvqs;
> +       void *buf;
> +       size_t buf_size;
> +       char *test_buf;
> +       char *res_buf;
> +       struct vhost_memory *mem;
> +       int sock;
> +       int ifindex;
> +       unsigned char mac[ETHER_ADDR_LEN];
> +};
> +
> +static int tun_alloc(struct vdev_info *dev, char *tun_name)
> +{
> +       struct ifreq ifr;
> +       int len =3D HDR_LEN;
> +       int fd, e;
> +
> +       fd =3D open("/dev/net/tun", O_RDWR);
> +       if (fd < 0) {
> +               perror("Cannot open /dev/net/tun");
> +               return fd;
> +       }
> +
> +       memset(&ifr, 0, sizeof(ifr));
> +
> +       ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> +       strncpy(ifr.ifr_name, tun_name, IFNAMSIZ);
> +
> +       e =3D ioctl(fd, TUNSETIFF, &ifr);
> +       if (e < 0) {
> +               perror("ioctl[TUNSETIFF]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       e =3D ioctl(fd, TUNSETVNETHDRSZ, &len);
> +       if (e < 0) {
> +               perror("ioctl[TUNSETVNETHDRSZ]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       e =3D ioctl(fd, SIOCGIFHWADDR, &ifr);
> +       if (e < 0) {
> +               perror("ioctl[SIOCGIFHWADDR]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       memcpy(dev->mac, &ifr.ifr_hwaddr.sa_data, ETHER_ADDR_LEN);
> +       return fd;
> +}
> +
> +static void vdev_create_socket(struct vdev_info *dev, char *tun_name)
> +{
> +       struct ifreq ifr;
> +
> +       dev->sock =3D socket(AF_PACKET, SOCK_RAW, htons(TEST_PTYPE));
> +       assert(dev->sock !=3D -1);
> +
> +       strncpy(ifr.ifr_name, tun_name, IFNAMSIZ);
> +       assert(ioctl(dev->sock, SIOCGIFINDEX, &ifr) >=3D 0);
> +
> +       dev->ifindex =3D ifr.ifr_ifindex;
> +
> +       /* Set the flags that bring the device up */
> +       assert(ioctl(dev->sock, SIOCGIFFLAGS, &ifr) >=3D 0);
> +       ifr.ifr_flags |=3D (IFF_UP | IFF_RUNNING);
> +       assert(ioctl(dev->sock, SIOCSIFFLAGS, &ifr) >=3D 0);
> +}
> +
> +static void vdev_send_packet(struct vdev_info *dev)
> +{
> +       char *sendbuf =3D dev->test_buf + HDR_LEN;
> +       struct sockaddr_ll saddrll =3D {0};
> +       int sockfd =3D dev->sock;
> +       int ret;
> +
> +       saddrll.sll_family =3D PF_PACKET;
> +       saddrll.sll_ifindex =3D dev->ifindex;
> +       saddrll.sll_halen =3D ETH_ALEN;
> +       saddrll.sll_protocol =3D htons(TEST_PTYPE);
> +
> +       ret =3D sendto(sockfd, sendbuf, TEST_BUF_LEN, 0,
> +                    (struct sockaddr *)&saddrll,
> +                    sizeof(struct sockaddr_ll));
> +       assert(ret >=3D 0);
> +}
> +
> +static bool vq_notify(struct virtqueue *vq)
> +{
> +       struct vq_info *info =3D vq->priv;
> +       unsigned long long v =3D 1;
> +       int r;
> +
> +       r =3D write(info->kick, &v, sizeof(v));
> +       assert(r =3D=3D sizeof(v));
> +
> +       return true;
> +}
> +
> +static void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
> +{
> +       struct vhost_vring_addr addr =3D {
> +               .index =3D info->idx,
> +               .desc_user_addr =3D (uint64_t)(unsigned long)info->vring.=
desc,
> +               .avail_user_addr =3D (uint64_t)(unsigned long)info->vring=
avail,
> +               .used_user_addr =3D (uint64_t)(unsigned long)info->vring.=
used,
> +       };
> +       struct vhost_vring_state state =3D { .index =3D info->idx };
> +       struct vhost_vring_file file =3D { .index =3D info->idx };
> +       int r;
> +
> +       state.num =3D info->vring.num;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
> +       assert(r >=3D 0);
> +
> +       state.num =3D 0;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_BASE, &state);
> +       assert(r >=3D 0);
> +
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_ADDR, &addr);
> +       assert(r >=3D 0);
> +
> +       file.fd =3D info->kick;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_KICK, &file);
> +       assert(r >=3D 0);
> +}
> +
> +static void vq_reset(struct vq_info *info, int num, struct virtio_device=
 *vdev)
> +{
> +       if (info->vq)
> +               vring_del_virtqueue(info->vq);
> +
> +       memset(info->ring, 0, vring_size(num, 4096));
> +       vring_init(&info->vring, num, info->ring, 4096);
> +       info->vq =3D vring_new_virtqueue(info->idx, num, 4096, vdev, true=
, false,
> +                                      info->ring, vq_notify, NULL, "test=
");
> +       assert(info->vq);
> +       info->vq->priv =3D info;
> +}
> +
> +static void vq_info_add(struct vdev_info *dev, int idx, int num, int fd)
> +{
> +       struct vhost_vring_file backend =3D { .index =3D idx, .fd =3D fd =
};
> +       struct vq_info *info =3D &dev->vqs[idx];
> +       int r;
> +
> +       info->idx =3D idx;
> +       info->kick =3D eventfd(0, EFD_NONBLOCK);
> +       r =3D posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> +       assert(r >=3D 0);
> +       vq_reset(info, num, &dev->vdev);
> +       vhost_vq_setup(dev, info);
> +
> +       r =3D ioctl(dev->control, VHOST_NET_SET_BACKEND, &backend);
> +       assert(!r);
> +}
> +
> +static void vdev_info_init(struct vdev_info *dev, unsigned long long fea=
tures)
> +{
> +       struct ether_header *eh;
> +       int i, r;
> +
> +       dev->vdev.features =3D features;
> +       INIT_LIST_HEAD(&dev->vdev.vqs);
> +       spin_lock_init(&dev->vdev.vqs_list_lock);
> +
> +       dev->buf_size =3D (HDR_LEN + TEST_BUF_LEN) * 2;
> +       dev->buf =3D malloc(dev->buf_size);
> +       assert(dev->buf);
> +       dev->test_buf =3D dev->buf;
> +       dev->res_buf =3D dev->test_buf + HDR_LEN + TEST_BUF_LEN;
> +
> +       memset(dev->test_buf, 0, HDR_LEN + TEST_BUF_LEN);
> +       eh =3D (struct ether_header *)(dev->test_buf + HDR_LEN);
> +       eh->ether_type =3D htons(TEST_PTYPE);
> +       memcpy(eh->ether_dhost, dev->mac, ETHER_ADDR_LEN);
> +       memcpy(eh->ether_shost, dev->mac, ETHER_ADDR_LEN);
> +
> +       for (i =3D sizeof(*eh); i < TEST_BUF_LEN; i++)
> +               dev->test_buf[i + HDR_LEN] =3D (char)i;
> +
> +       dev->control =3D open("/dev/vhost-net", O_RDWR);
> +       assert(dev->control >=3D 0);
> +
> +       r =3D ioctl(dev->control, VHOST_SET_OWNER, NULL);
> +       assert(r >=3D 0);
> +
> +       dev->mem =3D malloc(offsetof(struct vhost_memory, regions) +
> +                         sizeof(dev->mem->regions[0]));
> +       assert(dev->mem);
> +       memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
> +              sizeof(dev->mem->regions[0]));
> +       dev->mem->nregions =3D 1;
> +       dev->mem->regions[0].guest_phys_addr =3D (long)dev->buf;
> +       dev->mem->regions[0].userspace_addr =3D (long)dev->buf;
> +       dev->mem->regions[0].memory_size =3D dev->buf_size;
> +
> +       r =3D ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
> +       assert(r >=3D 0);
> +
> +       r =3D ioctl(dev->control, VHOST_SET_FEATURES, &features);
> +       assert(r >=3D 0);
> +
> +       dev->nvqs =3D 2;
> +}
> +
> +static void wait_for_interrupt(struct vq_info *vq)
> +{
> +       unsigned long long val;
> +
> +       poll(&vq->fds, 1, -1);

It's not good to wait indefinitely.

> +
> +       if (vq->fds.revents & POLLIN)
> +               read(vq->fds.fd, &val, sizeof(val));
> +}
> +
> +static void verify_res_buf(char *res_buf)
> +{
> +       int i;
> +
> +       for (i =3D ETHER_HDR_LEN; i < TEST_BUF_LEN; i++)
> +               assert(res_buf[i] =3D=3D (char)i);
> +}
> +
> +static void run_tx_test(struct vdev_info *dev, struct vq_info *vq,
> +                       bool delayed, int bufs)
> +{
> +       long long spurious =3D 0;
> +       struct scatterlist sl;
> +       unsigned int len;
> +       int r;
> +
> +       for (;;) {
> +               long started_before =3D vq->started;
> +               long completed_before =3D vq->completed;
> +
> +               virtqueue_disable_cb(vq->vq);
> +               do {
> +                       while (vq->started < bufs &&
> +                              (vq->started - vq->completed) < 1) {
> +                               sg_init_one(&sl, dev->test_buf, HDR_LEN +=
 TEST_BUF_LEN);
> +                               r =3D virtqueue_add_outbuf(vq->vq, &sl, 1=
,
> +                                                        dev->test_buf + =
vq->started,
> +                                                        GFP_ATOMIC);
> +                               if (unlikely(r !=3D 0))
> +                                       break;
> +
> +                               ++vq->started;

If we never decrease started/completed shouldn't we use unsigned here?
(as well as completed)

Otherwise we may get unexpected results for vq->started as well as
vq->completed.

> +
> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
> +                                       r =3D -1;
> +                                       break;
> +                               }
> +                       }
> +
> +                       if (vq->started >=3D bufs)
> +                               r =3D -1;

Which condition do we reach here?

> +
> +                       /* Flush out completed bufs if any */
> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> +                               int n;
> +
> +                               n =3D recvfrom(dev->sock, dev->res_buf, T=
EST_BUF_LEN, 0, NULL, NULL);
> +                               assert(n =3D=3D TEST_BUF_LEN);
> +                               verify_res_buf(dev->res_buf);
> +
> +                               ++vq->completed;
> +                               r =3D 0;
> +                       }
> +               } while (r =3D=3D 0);
> +
> +               if (vq->completed =3D=3D completed_before && vq->started =
=3D=3D started_before)
> +                       ++spurious;
> +
> +               assert(vq->completed <=3D bufs);
> +               assert(vq->started <=3D bufs);
> +               if (vq->completed =3D=3D bufs)
> +                       break;
> +
> +               if (delayed) {
> +                       if (virtqueue_enable_cb_delayed(vq->vq))
> +                               wait_for_interrupt(vq);
> +               } else {
> +                       if (virtqueue_enable_cb(vq->vq))
> +                               wait_for_interrupt(vq);
> +               }

This could be simplified with

if (delayed)
else

wait_for_interrupt(vq)

> +       }
> +       printf("TX spurious wakeups: 0x%llx started=3D0x%lx completed=3D0=
x%lx\n",
> +              spurious, vq->started, vq->completed);
> +}
> +
> +static void run_rx_test(struct vdev_info *dev, struct vq_info *vq,
> +                       bool delayed, int bufs)
> +{
> +       long long spurious =3D 0;
> +       struct scatterlist sl;
> +       unsigned int len;
> +       int r;
> +
> +       for (;;) {
> +               long started_before =3D vq->started;
> +               long completed_before =3D vq->completed;
> +
> +               do {
> +                       while (vq->started < bufs &&
> +                              (vq->started - vq->completed) < 1) {
> +                               sg_init_one(&sl, dev->res_buf, HDR_LEN + =
TEST_BUF_LEN);
> +
> +                               r =3D virtqueue_add_inbuf(vq->vq, &sl, 1,
> +                                                       dev->res_buf + vq=
->started,
> +                                                       GFP_ATOMIC);
> +                               if (unlikely(r !=3D 0))
> +                                       break;
> +
> +                               ++vq->started;
> +
> +                               vdev_send_packet(dev);
> +
> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
> +                                       r =3D -1;
> +                                       break;
> +                               }
> +                       }
> +
> +                       if (vq->started >=3D bufs)
> +                               r =3D -1;
> +
> +                       /* Flush out completed bufs if any */
> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> +                               struct ether_header *eh;
> +
> +                               eh =3D (struct ether_header *)(dev->res_b=
uf + HDR_LEN);
> +
> +                               /* tun netdev is up and running, ignore t=
he
> +                                * non-TEST_PTYPE packet.
> +                                */
> +                               if (eh->ether_type !=3D htons(TEST_PTYPE)=
) {
> +                                       ++vq->completed;
> +                                       r =3D 0;
> +                                       continue;
> +                               }
> +
> +                               assert(len =3D=3D TEST_BUF_LEN + HDR_LEN)=
;
> +                               verify_res_buf(dev->res_buf + HDR_LEN);

Let's simply the logic here:

if (ether_type =3D=3D htons()) {
    assert()
    verify_res_buf()
}

r =3D 0;
++vq->completed;

Others look good.

Thanks


