Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0AE808070
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377304AbjLGGBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGGBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:01:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E91D44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701928869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypxU29xtNtQWubBXrL0ITUVGGlbhbqmQCazRQxr/0G8=;
        b=SxmQgIRPluBsVxOzMN5pjirb9KljF/zxGaMGTu6G+Vlfs8qwut4CJP9Fv3QZyOvdwUkzhX
        BBMyAGLHFXzxyoNCJOheUW0c8DZ7SaDzOuOuMJRV9nE1TULDdeszLSHANhlpVpL8FxzsxT
        FYLZpQZOOev4v5y+YYbuvTlEoAp6iLY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Q5ACRVtYNECap9taaN2aZw-1; Thu, 07 Dec 2023 01:01:07 -0500
X-MC-Unique: Q5ACRVtYNECap9taaN2aZw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2865681dcb4so585491a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 22:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701928866; x=1702533666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypxU29xtNtQWubBXrL0ITUVGGlbhbqmQCazRQxr/0G8=;
        b=jfA38G0bZhPVD7NOCddUaSJJTWsn1xPFU7l9C8IFqny0f6lUQ9PiikzvXqbyZy0ujA
         jiOS9ne+aQamnae1eocuvsYKoX+cK6ZSUxp5BFCS6fp+PEp6enfXsQaQazD0T7nRdwsx
         vZ7QVQk95Hn/m4ld2SdK0ns/NSmtUE1E6bTFQrITrmp5BQIxryYJRnEKKE5ukWTG8Rxk
         wH+Q9k/ZvIXYQL2vNr56JkMHlbo/EWydfahDwO61Pvr7sVMSW4VTg+ArxxvH1MGqJ5Ds
         gCpRmlU+w5JatSC2afT6sE+BJ9gp6mN23/SQfj41VRqycHVKmtWYIsyKS2lJOe4Qqhnd
         ffcQ==
X-Gm-Message-State: AOJu0YzW7IJoxg5WyQiRrxDgS5Us17zenmAwu6lw8XMNE4irIGppgcKo
        slp7GFcGt6jXr70dxtGMmeny9d4z7NX34eUtXgWYicyCRCtc6Lc6LC4PRDpifiRkANCVPhAy0yx
        2nYpDbam9VdsTXKvPKRco6mhPQhTtt7uePLWCRcfm
X-Received: by 2002:a17:90a:fa88:b0:286:b6ab:5394 with SMTP id cu8-20020a17090afa8800b00286b6ab5394mr1756828pjb.94.1701928866292;
        Wed, 06 Dec 2023 22:01:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnvhev3v3z2M0TC7lJFcBKSo3//Ei0IkvaEp4lJNlSFhvZMCtAHQCdcg+io6fPTzXYKBS1SFAZE7QC034SXaA=
X-Received: by 2002:a17:90a:fa88:b0:286:b6ab:5394 with SMTP id
 cu8-20020a17090afa8800b00286b6ab5394mr1756816pjb.94.1701928865964; Wed, 06
 Dec 2023 22:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com> <20231205113444.63015-7-linyunsheng@huawei.com>
In-Reply-To: <20231205113444.63015-7-linyunsheng@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Dec 2023 14:00:55 +0800
Message-ID: <CACGkMEvVezZnHK-gRWY+MUd_6awnprb024scqPNmMQ05P8rWTQ@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> introduce vhost_net_test basing on virtio_test to test
> vhost_net changing in the kernel.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  tools/virtio/Makefile         |   8 +-
>  tools/virtio/vhost_net_test.c | 441 ++++++++++++++++++++++++++++++++++
>  2 files changed, 446 insertions(+), 3 deletions(-)
>  create mode 100644 tools/virtio/vhost_net_test.c
>
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
> diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.=
c
> new file mode 100644
> index 000000000000..7e7b7aba3668
> --- /dev/null
> +++ b/tools/virtio/vhost_net_test.c
> @@ -0,0 +1,441 @@
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
> +#include <linux/virtio_types.h>
> +#include <linux/vhost.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/if.h>
> +#include <linux/if_tun.h>
> +
> +#define RANDOM_BATCH -1
> +
> +static int tun_alloc(void)
> +{
> +       struct ifreq ifr;
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
> +       ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;

Why did you use IFF_TUN but not IFF_TAP here?

> +       strncpy(ifr.ifr_name, "tun0", IFNAMSIZ);

tun0 is pretty common if there's a VPN. Do we need some randomized name her=
e?


> +
> +       e =3D ioctl(fd, TUNSETIFF, (void *) &ifr);
> +       if (e < 0) {
> +               perror("ioctl[TUNSETIFF]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       return fd;
> +}
> +
> +/* Unused */
> +void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;

Why do we need trick like these here?

> +
> +struct vq_info {
> +       int kick;
> +       int call;
> +       int num;
> +       int idx;
> +       void *ring;
> +       /* copy used for control */
> +       struct vring vring;
> +       struct virtqueue *vq;
> +};
> +
> +struct vdev_info {
> +       struct virtio_device vdev;
> +       int control;
> +       struct pollfd fds[1];
> +       struct vq_info vqs[1];
> +       int nvqs;
> +       void *buf;
> +       size_t buf_size;
> +       struct vhost_memory *mem;
> +};
> +
> +static struct vhost_vring_file no_backend =3D { .index =3D 1, .fd =3D -1=
 },
> +                                    backend =3D { .index =3D 1, .fd =3D =
1 };

A magic number like fd =3D 1 is pretty confusing.

And I don't see why we need global variables here.

> +static const struct vhost_vring_state null_state =3D {};
> +
> +bool vq_notify(struct virtqueue *vq)
> +{
> +       struct vq_info *info =3D vq->priv;
> +       unsigned long long v =3D 1;
> +       int r;
> +       r =3D write(info->kick, &v, sizeof v);
> +       assert(r =3D=3D sizeof v);
> +       return true;
> +}
> +
> +void vq_callback(struct virtqueue *vq)
> +{
> +}
> +
> +
> +void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
> +{
> +       struct vhost_vring_state state =3D { .index =3D info->idx };
> +       struct vhost_vring_file file =3D { .index =3D info->idx };
> +       unsigned long long features =3D dev->vdev.features;
> +       struct vhost_vring_addr addr =3D {
> +               .index =3D info->idx,
> +               .desc_user_addr =3D (uint64_t)(unsigned long)info->vring.=
desc,
> +               .avail_user_addr =3D (uint64_t)(unsigned long)info->vring=
.avail,
> +               .used_user_addr =3D (uint64_t)(unsigned long)info->vring.=
used,
> +       };
> +       int r;
> +       r =3D ioctl(dev->control, VHOST_SET_FEATURES, &features);
> +       assert(r >=3D 0);
> +       state.num =3D info->vring.num;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
> +       assert(r >=3D 0);
> +       state.num =3D 0;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_BASE, &state);
> +       assert(r >=3D 0);
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_ADDR, &addr);
> +       assert(r >=3D 0);
> +       file.fd =3D info->kick;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_KICK, &file);
> +       assert(r >=3D 0);
> +       file.fd =3D info->call;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_CALL, &file);
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
> +                                      info->ring, vq_notify, vq_callback=
, "test");
> +       assert(info->vq);
> +       info->vq->priv =3D info;
> +}
> +
> +static void vq_info_add(struct vdev_info *dev, int num)
> +{
> +       struct vq_info *info =3D &dev->vqs[dev->nvqs];
> +       int r;
> +
> +       /* use VHOST_NET_VQ_TX for testing */
> +       info->idx =3D 1;
> +       info->kick =3D eventfd(0, EFD_NONBLOCK);
> +       info->call =3D eventfd(0, EFD_NONBLOCK);
> +       r =3D posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> +       assert(r >=3D 0);
> +       vq_reset(info, num, &dev->vdev);
> +       vhost_vq_setup(dev, info);
> +       dev->fds[0].fd =3D info->call;
> +       dev->fds[0].events =3D POLLIN;
> +       dev->nvqs++;
> +}
> +
> +static void vdev_info_init(struct vdev_info* dev, unsigned long long fea=
tures)
> +{
> +       int r;
> +       memset(dev, 0, sizeof *dev);
> +       dev->vdev.features =3D features;
> +       INIT_LIST_HEAD(&dev->vdev.vqs);
> +       spin_lock_init(&dev->vdev.vqs_list_lock);
> +       dev->buf_size =3D 1024;
> +       dev->buf =3D malloc(dev->buf_size);
> +       assert(dev->buf);
> +       dev->control =3D open("/dev/vhost-net", O_RDWR);
> +       assert(dev->control >=3D 0);
> +       r =3D ioctl(dev->control, VHOST_SET_OWNER, NULL);
> +       assert(r >=3D 0);
> +       dev->mem =3D malloc(offsetof(struct vhost_memory, regions) +
> +                         sizeof dev->mem->regions[0]);
> +       assert(dev->mem);
> +       memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
> +                          sizeof dev->mem->regions[0]);
> +       dev->mem->nregions =3D 1;
> +       dev->mem->regions[0].guest_phys_addr =3D (long)dev->buf;
> +       dev->mem->regions[0].userspace_addr =3D (long)dev->buf;
> +       dev->mem->regions[0].memory_size =3D dev->buf_size;
> +       r =3D ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
> +       assert(r >=3D 0);
> +}
> +
> +/* TODO: this is pretty bad: we get a cache line bounce
> + * for the wait queue on poll and another one on read,
> + * plus the read which is there just to clear the
> + * current state. */
> +static void wait_for_interrupt(struct vdev_info *dev)
> +{
> +       int i;
> +       unsigned long long val;
> +       poll(dev->fds, dev->nvqs, -1);
> +       for (i =3D 0; i < dev->nvqs; ++i)
> +               if (dev->fds[i].revents & POLLIN) {
> +                       read(dev->fds[i].fd, &val, sizeof val);
> +               }
> +}
> +
> +static void run_test(struct vdev_info *dev, struct vq_info *vq,
> +                    bool delayed, int batch, int reset_n, int bufs)
> +{
> +       struct scatterlist sl;
> +       long started =3D 0, completed =3D 0, next_reset =3D reset_n;
> +       long completed_before, started_before;
> +       int r;
> +       unsigned int len;
> +       long long spurious =3D 0;
> +       const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
> +
> +       r =3D ioctl(dev->control, VHOST_NET_SET_BACKEND, &backend);
> +       assert(!r);
> +
> +       if (!reset_n) {
> +               next_reset =3D INT_MAX;
> +       }
> +
> +       for (;;) {
> +               virtqueue_disable_cb(vq->vq);
> +               completed_before =3D completed;
> +               started_before =3D started;
> +               do {
> +                       const bool reset =3D completed > next_reset;
> +                       if (random_batch)
> +                               batch =3D (random() % vq->vring.num) + 1;
> +
> +                       while (started < bufs &&
> +                              (started - completed) < batch) {
> +                               sg_init_one(&sl, dev->buf, dev->buf_size)=
;
> +                               r =3D virtqueue_add_outbuf(vq->vq, &sl, 1=
,
> +                                                        dev->buf + start=
ed,
> +                                                        GFP_ATOMIC);
> +                               if (unlikely(r !=3D 0)) {
> +                                       if (r =3D=3D -ENOSPC &&
> +                                           started > started_before)
> +                                               r =3D 0;
> +                                       else
> +                                               r =3D -1;
> +                                       break;
> +                               }
> +
> +                               ++started;
> +
> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
> +                                       r =3D -1;
> +                                       break;
> +                               }
> +                       }
> +
> +                       if (started >=3D bufs)
> +                               r =3D -1;
> +
> +                       if (reset) {
> +                               r =3D ioctl(dev->control, VHOST_NET_SET_B=
ACKEND,
> +                                         &no_backend);
> +                               assert(!r);
> +                       }
> +
> +                       /* Flush out completed bufs if any */
> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> +                               ++completed;
> +                               r =3D 0;
> +                       }
> +
> +                       if (reset) {
> +                               struct vhost_vring_state s =3D { .index =
=3D 0 };
> +
> +                               vq_reset(vq, vq->vring.num, &dev->vdev);
> +
> +                               r =3D ioctl(dev->control, VHOST_GET_VRING=
_BASE,
> +                                         &s);
> +                               assert(!r);
> +
> +                               s.num =3D 0;
> +                               r =3D ioctl(dev->control, VHOST_SET_VRING=
_BASE,
> +                                         &null_state);
> +                               assert(!r);
> +
> +                               r =3D ioctl(dev->control, VHOST_NET_SET_B=
ACKEND,
> +                                         &backend);
> +                               assert(!r);
> +
> +                               started =3D completed;
> +                               while (completed > next_reset)
> +                                       next_reset +=3D completed;
> +                       }
> +               } while (r =3D=3D 0);
> +               if (completed =3D=3D completed_before && started =3D=3D s=
tarted_before)
> +                       ++spurious;
> +               assert(completed <=3D bufs);
> +               assert(started <=3D bufs);
> +               if (completed =3D=3D bufs)
> +                       break;
> +               if (delayed) {
> +                       if (virtqueue_enable_cb_delayed(vq->vq))
> +                               wait_for_interrupt(dev);
> +               } else {
> +                       if (virtqueue_enable_cb(vq->vq))
> +                               wait_for_interrupt(dev);
> +               }
> +       }
> +       fprintf(stderr,
> +               "spurious wakeups: 0x%llx started=3D0x%lx completed=3D0x%=
lx\n",
> +               spurious, started, completed);
> +}
> +
> +const char optstring[] =3D "h";
> +const struct option longopts[] =3D {
> +       {
> +               .name =3D "help",
> +               .val =3D 'h',
> +       },
> +       {
> +               .name =3D "event-idx",
> +               .val =3D 'E',
> +       },
> +       {
> +               .name =3D "no-event-idx",
> +               .val =3D 'e',
> +       },
> +       {
> +               .name =3D "indirect",
> +               .val =3D 'I',
> +       },
> +       {
> +               .name =3D "no-indirect",
> +               .val =3D 'i',
> +       },
> +       {
> +               .name =3D "virtio-1",
> +               .val =3D '1',
> +       },
> +       {
> +               .name =3D "no-virtio-1",
> +               .val =3D '0',
> +       },
> +       {
> +               .name =3D "delayed-interrupt",
> +               .val =3D 'D',
> +       },
> +       {
> +               .name =3D "no-delayed-interrupt",
> +               .val =3D 'd',
> +       },
> +       {
> +               .name =3D "buf-num",
> +               .val =3D 'n',
> +               .has_arg =3D required_argument,
> +       },
> +       {
> +               .name =3D "batch",
> +               .val =3D 'b',
> +               .has_arg =3D required_argument,
> +       },
> +       {
> +               .name =3D "reset",
> +               .val =3D 'r',
> +               .has_arg =3D optional_argument,
> +       },
> +       {
> +       }
> +};
> +
> +static void help(int status)
> +{
> +       fprintf(stderr, "Usage: virtio_test [--help]"
> +               " [--no-indirect]"
> +               " [--no-event-idx]"
> +               " [--no-virtio-1]"
> +               " [--delayed-interrupt]"
> +               " [--batch=3Drandom/N]"
> +               " [--reset=3DN]"
> +               "\n");
> +
> +       exit(status);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       struct vdev_info dev;
> +       unsigned long long features =3D (1ULL << VIRTIO_RING_F_INDIRECT_D=
ESC) |
> +               (1ULL << VIRTIO_RING_F_EVENT_IDX) | (1ULL << VIRTIO_F_VER=
SION_1);
> +       long batch =3D 1, reset =3D 0, nbufs =3D 0x100000;
> +       int o;
> +       bool delayed =3D false;
> +
> +       for (;;) {
> +               o =3D getopt_long(argc, argv, optstring, longopts, NULL);
> +               switch (o) {
> +               case -1:
> +                       goto done;
> +               case '?':
> +                       help(2);
> +               case 'e':
> +                       features &=3D ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
> +                       break;
> +               case 'h':
> +                       help(0);
> +               case 'i':
> +                       features &=3D ~(1ULL << VIRTIO_RING_F_INDIRECT_DE=
SC);
> +                       break;
> +               case '0':
> +                       features &=3D ~(1ULL << VIRTIO_F_VERSION_1);
> +                       break;
> +               case 'D':
> +                       delayed =3D true;
> +                       break;
> +               case 'b':
> +                       if (0 =3D=3D strcmp(optarg, "random")) {
> +                               batch =3D RANDOM_BATCH;
> +                       } else {
> +                               batch =3D strtol(optarg, NULL, 10);
> +                               assert(batch > 0);
> +                               assert(batch < (long)INT_MAX + 1);
> +                       }
> +                       break;
> +               case 'r':
> +                       if (!optarg) {
> +                               reset =3D 1;
> +                       } else {
> +                               reset =3D strtol(optarg, NULL, 10);
> +                               assert(reset > 0);
> +                               assert(reset < (long)INT_MAX + 1);
> +                       }
> +                       break;
> +               case 'n':
> +                       nbufs =3D strtol(optarg, NULL, 10);
> +                       assert(nbufs > 0);
> +                       break;
> +               default:
> +                       assert(0);
> +                       break;
> +               }
> +       }
> +
> +done:
> +       backend.fd =3D tun_alloc();
> +       assert(backend.fd >=3D 0);
> +       vdev_info_init(&dev, features);
> +       vq_info_add(&dev, 256);
> +       run_test(&dev, &dev.vqs[0], delayed, batch, reset, nbufs);

I'd expect we are testing some basic traffic here. E.g can we use a
packet socket then we can test both tx and rx?

Thanks

> +       return 0;
> +}
> --
> 2.33.0
>

