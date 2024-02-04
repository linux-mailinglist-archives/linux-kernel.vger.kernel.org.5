Return-Path: <linux-kernel+bounces-51366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DBD848A33
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379A01C20D49
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E010EB;
	Sun,  4 Feb 2024 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NE8s4RvS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A14690
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010251; cv=none; b=Cqm8lsT5XcZphzJ6MELOmX1EuvwKSZbLMZqB6clsRq/MctLSjZPzUc9p7pPh9FTtTtOC2w01mlvPscky/I/V6vDyj1yy2nFIL6iOpoT1hEOp6RZPxOPs0WES4wQiEak8Xe89N2NkXCoUmiqevIT2j+N87t6clZ/8/jz6T1UeeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010251; c=relaxed/simple;
	bh=FbxrXSfgjg7CL+575dxVjcplV633G1vV4ELHFqYA8Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riTi0DfAZK0ehFd/hkFp+c/CkW/V8uzrX29X3L2zckYo3fIxB+f8aLbtea3aL90sMHt6qD8SgvkJsPz72V1msy/cgjVV5BiHsj0jHCDgxVwgDXodKszLHBC9QSxCmbEA3mpdAW9EpByFlxeFtIfbx8mvocvUMnE5IJ2LIR1B2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NE8s4RvS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707010247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPMtbJ/YORou26XpV7B1nFtIqB5rHSwYCaMck997akE=;
	b=NE8s4RvSzVtzVm8fntKlmFzlW+tqnXFIrgMAub8bLEttvJNQy9OIi7fkodSmXPZcny2oSE
	JEHWjgQtpLXwPIXrcIlxHp/EwRivMv7cAgt1hdBhIilVYPyXlp/YKjbyjLgxMK5/jZi35p
	Rkd1k3CnYkPGRbA5IhRDFlUYwNMi4fI=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-8t028r7AOymrSR2c69Nnig-1; Sat, 03 Feb 2024 20:30:46 -0500
X-MC-Unique: 8t028r7AOymrSR2c69Nnig-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5998b7ad6b4so3839457eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 17:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707010246; x=1707615046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPMtbJ/YORou26XpV7B1nFtIqB5rHSwYCaMck997akE=;
        b=WM/f/ty7WVLSTZtTIIfl+CLMdDnLDq9mAegSZC5Jf0oEB692ByZVteb2SZbwef1yit
         MSER1RD+MOamRWekXulc5+wWzFcwqcSLR9hqZfzmHoD6ZNSbvkFmNjIhEQvLUFEVNk8f
         Up2BrJslj0szhSfJZTF6RF9nLUCdvNB6o3OswmUj6v+HwbVhAO/ZG7o+Snai4odQFatw
         jFa+dATkWdMCwz42qAh/G+Umzdl9ON898II6/ccZzDqiA6UOOe/1xx9m+9iqsVfltxKT
         kaH/qh2Z8TRzeS62zWoAYy0Cmyysh3/tSe9umC5jIfLT1JeFMtTpFzR56gtVR7fAhfWX
         VB2A==
X-Gm-Message-State: AOJu0YxMlfvPa2KmIYSTAwS5uqrAbznGEUHihjBul3UFf4dmTwVmIKYa
	vGvPl5cguhHrz67TnwL6L116dFV3rkeFcAAJ/CTCuIXaqD9DKgvNVFsWVmOWuVnoIqXfKd/uawL
	QxwbCZhDRbcXDwLfT2s9ViWVXZICOGY0pGgeY1Fq79y62hUwee9zPa+Mmwdpuu9R8jdXcw2jIVk
	jQj7FPgmpotPbOtIKs6bpw9ooDXH42OZe6ypbm
X-Received: by 2002:a05:6359:4c0b:b0:178:950d:1175 with SMTP id kj11-20020a0563594c0b00b00178950d1175mr12585800rwc.13.1707010245752;
        Sat, 03 Feb 2024 17:30:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+qQ4q7+TKHOaJzoGtpwdGam+Np5HnSzkzGucnx42VZeJj4o0dd5VAWhWijJuBWVnSlaiazKoR2LCVWh4Di2I=
X-Received: by 2002:a05:6359:4c0b:b0:178:950d:1175 with SMTP id
 kj11-20020a0563594c0b00b00178950d1175mr12585784rwc.13.1707010245405; Sat, 03
 Feb 2024 17:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130113710.34511-1-linyunsheng@huawei.com>
 <20240130113710.34511-6-linyunsheng@huawei.com> <CACGkMEsJq1Fg6T+9YLPzE16027sBHRZodk2+b1ySa9MeMcGjMA@mail.gmail.com>
 <dfc3dcb0-511c-945b-6099-c4d7ccbf3253@huawei.com>
In-Reply-To: <dfc3dcb0-511c-945b-6099-c4d7ccbf3253@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Feb 2024 09:30:34 +0800
Message-ID: <CACGkMEsHLis66LntKTG01Eg7cMv-S7u05B3W6CizKRahJ5gDOw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/5] tools: virtio: introduce vhost_net_test
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:24=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/2/2 12:05, Jason Wang wrote:
> > On Tue, Jan 30, 2024 at 7:38=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> introduce vhost_net_test basing on virtio_test to test
> >> vhost_net changing in the kernel.
> >
> > Let's describe what kind of test is being done and how it is done here.
>
> How about something like below:
>
> This patch introduces testing for both vhost_net tx and rx.
> Steps for vhost_net tx testing:
> 1. Prepare a out buf
> 2. Kick the vhost_net to do tx processing
> 3. Do the receiving in the tun side
> 4. verify the data received by tun is correct
>
> Steps for vhost_net rx testing::
> 1. Prepare a in buf
> 2. Do the sending in the tun side
> 3. Kick the vhost_net to do rx processing
> 4. verify the data received by vhost_net is correct

It looks like some important details were lost, e.g the logic for batching =
etc.

>
>
> >> +
> >> +static int tun_alloc(struct vdev_info *dev)
> >> +{
> >> +       struct ifreq ifr;
> >> +       int len =3D HDR_LEN;
> >
> > Any reason you can't just use the virtio_net uapi?
>
> I didn't find a macro for that in include/uapi/linux/virtio_net.h.
>
> Did you mean using something like below?
> sizeof(struct virtio_net_hdr_mrg_rxbuf)

Yes.

>
> >
> >> +       int fd, e;
> >> +
> >> +       fd =3D open("/dev/net/tun", O_RDWR);
> >> +       if (fd < 0) {
> >> +               perror("Cannot open /dev/net/tun");
> >> +               return fd;
> >> +       }
> >> +
> >> +       memset(&ifr, 0, sizeof(ifr));
> >> +
> >> +       ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> >> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
> >> +
> >> +       e =3D ioctl(fd, TUNSETIFF, &ifr);
> >> +       if (e < 0) {
> >> +               perror("ioctl[TUNSETIFF]");
> >> +               close(fd);
> >> +               return e;
> >> +       }
> >> +
> >> +       e =3D ioctl(fd, TUNSETVNETHDRSZ, &len);
> >> +       if (e < 0) {
> >> +               perror("ioctl[TUNSETVNETHDRSZ]");
> >> +               close(fd);
> >> +               return e;
> >> +       }
> >> +
> >> +       e =3D ioctl(fd, SIOCGIFHWADDR, &ifr);
> >> +       if (e < 0) {
> >> +               perror("ioctl[SIOCGIFHWADDR]");
> >> +               close(fd);
> >> +               return e;
> >> +       }
> >> +
> >> +       memcpy(dev->mac, &ifr.ifr_hwaddr.sa_data, ETHER_ADDR_LEN);
> >> +       return fd;
> >> +}
> >> +
> >> +static void vdev_create_socket(struct vdev_info *dev)
> >> +{
> >> +       struct ifreq ifr;
> >> +
> >> +       dev->sock =3D socket(AF_PACKET, SOCK_RAW, htons(TEST_PTYPE));
> >> +       assert(dev->sock !=3D -1);
> >> +
> >> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
> >
> > Nit: it might be better to accept the device name instead of repeating
> > the snprintf trick here, this would facilitate the future changes.
>
> I am not sure I understand what did you mean by "accept the device name"
> here.
>
> The above is used to get ifindex of the tun netdevice created in
> tun_alloc(), so that we can use it in vdev_send_packet() to send
> a packet using the tun netdevice created in tun_alloc(). Is there
> anything obvious I missed here?

I meant a const char *ifname for this function and let the caller to
pass the name.

>
> >
> >> +       assert(ioctl(dev->sock, SIOCGIFINDEX, &ifr) >=3D 0);
> >> +
> >> +       dev->ifindex =3D ifr.ifr_ifindex;
> >> +
> >> +       /* Set the flags that bring the device up */
> >> +       assert(ioctl(dev->sock, SIOCGIFFLAGS, &ifr) >=3D 0);
> >> +       ifr.ifr_flags |=3D (IFF_UP | IFF_RUNNING);
> >> +       assert(ioctl(dev->sock, SIOCSIFFLAGS, &ifr) >=3D 0);
> >> +}
> >> +
> >> +static void vdev_send_packet(struct vdev_info *dev)
> >> +{
> >> +       char *sendbuf =3D dev->test_buf + HDR_LEN;
> >> +       struct sockaddr_ll saddrll =3D {0};
> >> +       int sockfd =3D dev->sock;
> >> +       int ret;
> >> +
> >> +       saddrll.sll_family =3D PF_PACKET;
> >> +       saddrll.sll_ifindex =3D dev->ifindex;
> >> +       saddrll.sll_halen =3D ETH_ALEN;
> >> +       saddrll.sll_protocol =3D htons(TEST_PTYPE);
> >> +
> >> +       ret =3D sendto(sockfd, sendbuf, TEST_BUF_LEN, 0,
> >> +                    (struct sockaddr *)&saddrll,
> >> +                    sizeof(struct sockaddr_ll));
> >> +       assert(ret >=3D 0);
> >> +}
> >> +
>
> ...
>
> >> +
> >> +static void vq_info_add(struct vdev_info *dev, int idx, int num, int =
fd)
> >> +{
> >> +       struct vhost_vring_file backend =3D { .index =3D idx, .fd =3D =
fd };
> >> +       struct vq_info *info =3D &dev->vqs[idx];
> >> +       int r;
> >> +
> >> +       info->idx =3D idx;
> >> +       info->kick =3D eventfd(0, EFD_NONBLOCK);
> >> +       info->call =3D eventfd(0, EFD_NONBLOCK);
> >
> > If we don't care about the callback, let's just avoid to set the call h=
ere?
> >
> > (As I see vq_callback is a NULL)
>
> Sure, will remove the vq_callback related code.
>
> >
> >> +       r =3D posix_memalign(&info->ring, 4096, vring_size(num, 4096))=
;
> >> +       assert(r >=3D 0);
> >> +       vq_reset(info, num, &dev->vdev);
> >> +       vhost_vq_setup(dev, info);
> >> +       info->fds.fd =3D info->call;
> >> +       info->fds.events =3D POLLIN;
> >> +
> >> +       r =3D ioctl(dev->control, VHOST_NET_SET_BACKEND, &backend);
> >> +       assert(!r);
> >> +}
> >> +
> >> +static void vdev_info_init(struct vdev_info *dev, unsigned long long =
features)
> >> +{
> >> +       struct ether_header *eh;
> >> +       int i, r;
> >> +
> >> +       dev->vdev.features =3D features;
> >> +       INIT_LIST_HEAD(&dev->vdev.vqs);
> >> +       spin_lock_init(&dev->vdev.vqs_list_lock);
> >> +
> >> +       dev->buf_size =3D (HDR_LEN + TEST_BUF_LEN) * 2;
> >> +       dev->buf =3D malloc(dev->buf_size);
> >> +       assert(dev->buf);
> >> +       dev->test_buf =3D dev->buf;
> >> +       dev->res_buf =3D dev->test_buf + HDR_LEN + TEST_BUF_LEN;
> >> +
> >> +       memset(dev->test_buf, 0, HDR_LEN + TEST_BUF_LEN);
> >> +       eh =3D (struct ether_header *)(dev->test_buf + HDR_LEN);
> >> +       eh->ether_type =3D htons(TEST_PTYPE);
> >> +       memcpy(eh->ether_dhost, dev->mac, ETHER_ADDR_LEN);
> >> +       memcpy(eh->ether_shost, dev->mac, ETHER_ADDR_LEN);
> >> +
> >> +       for (i =3D sizeof(*eh); i < TEST_BUF_LEN; i++)
> >> +               dev->test_buf[i + HDR_LEN] =3D (char)i;
> >> +
> >> +       dev->control =3D open("/dev/vhost-net", O_RDWR);
> >> +       assert(dev->control >=3D 0);
> >> +
> >> +       r =3D ioctl(dev->control, VHOST_SET_OWNER, NULL);
> >> +       assert(r >=3D 0);
> >> +
> >> +       dev->mem =3D malloc(offsetof(struct vhost_memory, regions) +
> >> +                         sizeof(dev->mem->regions[0]));
> >> +       assert(dev->mem);
> >> +       memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
> >> +              sizeof(dev->mem->regions[0]));
> >> +       dev->mem->nregions =3D 1;
> >> +       dev->mem->regions[0].guest_phys_addr =3D (long)dev->buf;
> >> +       dev->mem->regions[0].userspace_addr =3D (long)dev->buf;
> >> +       dev->mem->regions[0].memory_size =3D dev->buf_size;
> >> +
> >> +       r =3D ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
> >> +       assert(r >=3D 0);
> >> +
> >> +       r =3D ioctl(dev->control, VHOST_SET_FEATURES, &features);
> >> +       assert(r >=3D 0);
> >> +
> >> +       dev->nvqs =3D 2;
> >> +}
> >> +
> >> +static void wait_for_interrupt(struct vq_info *vq)
> >> +{
> >> +       unsigned long long val;
> >> +
> >> +       poll(&vq->fds, 1, -1);
> >> +
> >> +       if (vq->fds.revents & POLLIN)
> >> +               read(vq->fds.fd, &val, sizeof(val));
> >> +}
> >> +
> >> +static void verify_res_buf(char *res_buf)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i =3D ETHER_HDR_LEN; i < TEST_BUF_LEN; i++)
> >> +               assert(res_buf[i] =3D=3D (char)i);
> >> +}
> >> +
> >> +static void run_tx_test(struct vdev_info *dev, struct vq_info *vq,
> >> +                       bool delayed, int batch, int bufs)
> >
> > It might be better to describe the test design briefly above as a
> > comment. Or we can start from simple test logic and add sophisticated
> > ones on top.
>
> Does something described in the comment log as suggested by you make
> sense to you?
> Steps for vhost_net tx testing:
> 1. Prepare a out buf
> 2. Kick the vhost_net to do tx processing
> 3. Do the receiving in the tun side
> 4. verify the data received by tun is correct

See my reply above.

>
> >
> >> +{
> >> +       const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
> >> +       long long spurious =3D 0;
> >> +       struct scatterlist sl;
> >> +       unsigned int len;
> >> +       int r;
> >> +
> >> +       for (;;) {
> >> +               long started_before =3D vq->started;
> >> +               long completed_before =3D vq->completed;
> >> +
> >> +               virtqueue_disable_cb(vq->vq);
> >> +               do {
> >> +                       if (random_batch)
> >> +                               batch =3D (random() % vq->vring.num) +=
 1;
> >> +
> >> +                       while (vq->started < bufs &&
> >> +                              (vq->started - vq->completed) < batch) =
{
> >> +                               sg_init_one(&sl, dev->test_buf, HDR_LE=
N + TEST_BUF_LEN);
> >> +                               r =3D virtqueue_add_outbuf(vq->vq, &sl=
, 1,
> >> +                                                        dev->test_buf=
 + vq->started,
> >> +                                                        GFP_ATOMIC);
> >> +                               if (unlikely(r !=3D 0)) {
> >> +                                       if (r =3D=3D -ENOSPC &&
> >> +                                           vq->started > started_befo=
re)
> >> +                                               r =3D 0;
> >> +                                       else
> >> +                                               r =3D -1;
> >> +                                       break;
> >> +                               }
> >> +
> >> +                               ++vq->started;
> >> +
> >> +                               if (unlikely(!virtqueue_kick(vq->vq)))=
 {
> >> +                                       r =3D -1;
> >> +                                       break;
> >> +                               }
> >> +                       }
> >> +
> >> +                       if (vq->started >=3D bufs)
> >> +                               r =3D -1;
> >> +
> >> +                       /* Flush out completed bufs if any */
> >> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> >> +                               int n;
> >> +
> >> +                               n =3D recvfrom(dev->sock, dev->res_buf=
, TEST_BUF_LEN, 0, NULL, NULL);
> >> +                               assert(n =3D=3D TEST_BUF_LEN);
> >> +                               verify_res_buf(dev->res_buf);
> >> +
> >> +                               ++vq->completed;
> >> +                               r =3D 0;
> >> +                       }
> >> +               } while (r =3D=3D 0);
> >> +
> >> +               if (vq->completed =3D=3D completed_before && vq->start=
ed =3D=3D started_before)
> >> +                       ++spurious;
> >> +
> >> +               assert(vq->completed <=3D bufs);
> >> +               assert(vq->started <=3D bufs);
> >> +               if (vq->completed =3D=3D bufs)
> >> +                       break;
> >> +
> >> +               if (delayed) {
> >> +                       if (virtqueue_enable_cb_delayed(vq->vq))
> >> +                               wait_for_interrupt(vq);
> >> +               } else {
> >> +                       if (virtqueue_enable_cb(vq->vq))
> >> +                               wait_for_interrupt(vq);
> >> +               }
> >> +       }
> >> +       printf("TX spurious wakeups: 0x%llx started=3D0x%lx completed=
=3D0x%lx\n",
> >> +              spurious, vq->started, vq->completed);
> >> +}
> >> +
> >> +static void run_rx_test(struct vdev_info *dev, struct vq_info *vq,
> >> +                       bool delayed, int batch, int bufs)
> >> +{
> >> +       const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
> >> +       long long spurious =3D 0;
> >> +       struct scatterlist sl;
> >> +       unsigned int len;
> >> +       int r;
> >> +
> >> +       for (;;) {
> >> +               long started_before =3D vq->started;
> >> +               long completed_before =3D vq->completed;
> >> +
> >> +               do {
> >> +                       if (random_batch)
> >> +                               batch =3D (random() % vq->vring.num) +=
 1;
> >> +
> >> +                       while (vq->started < bufs &&
> >> +                              (vq->started - vq->completed) < batch) =
{
> >> +                               sg_init_one(&sl, dev->res_buf, HDR_LEN=
 + TEST_BUF_LEN);
> >> +
> >> +                               r =3D virtqueue_add_inbuf(vq->vq, &sl,=
 1,
> >> +                                                       dev->res_buf +=
 vq->started,
> >> +                                                       GFP_ATOMIC);
> >> +                               if (unlikely(r !=3D 0)) {
> >> +                                       if (r =3D=3D -ENOSPC &&
> >
> > Drivers usually maintain a #free_slots, this can help to avoid the
> > trick for checking ENOSPC?
>
> The above "(vq->started - vq->completed) < batch" seems to ensure that
> the 'r' can't be '-ENOSPC'?

Well, if this is true any reason we still check ENOSPEC here?

> We just need to ensure the batch <=3D desc_num,
> and the 'r =3D=3D -ENOSPC' checking seems to be unnecessary.
>
> >
> >> +                                           vq->started > started_befo=
re)
> >> +                                               r =3D 0;
> >> +                                       else
> >> +                                               r =3D -1;
> >> +                                       break;
> >> +                               }
> >> +
> >> +                               ++vq->started;
> >> +
> >> +                               vdev_send_packet(dev);
> >> +
> >> +                               if (unlikely(!virtqueue_kick(vq->vq)))=
 {
> >> +                                       r =3D -1;
> >> +                                       break;
> >> +                               }
> >> +                       }
> >> +
> >> +                       if (vq->started >=3D bufs)
> >> +                               r =3D -1;
> >> +
> >> +                       /* Flush out completed bufs if any */
> >> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> >> +                               struct ether_header *eh;
> >> +
> >> +                               eh =3D (struct ether_header *)(dev->re=
s_buf + HDR_LEN);
> >> +
> >> +                               /* tun netdev is up and running, ignor=
e the
> >> +                                * non-TEST_PTYPE packet.
> >> +                                */
> >
> > I wonder if it's better to set up some kind of qdisc to avoid the
> > unexpected packet here, or is it too complicated?
>
> Yes, at least I don't know to do that yet.

For example, the blackhole qdisc?

Thanks


