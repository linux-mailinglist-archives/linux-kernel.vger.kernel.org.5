Return-Path: <linux-kernel+bounces-137931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB789E9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8103B1F25051
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5462030A;
	Wed, 10 Apr 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLWpJ5q/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342914A8C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726907; cv=none; b=N+mIWR6tH9fp4RcjXwRRV5FGPXF0bISAKFo1BoEsGMf/ppAsRz533dqBjMUSDpU/ora3HAQwUXY65kOgz+EBnr1T3pVKaTXJwdtGZzXlLXV36vmxbfphJreWDww3TD5t6mZjnR2h52EGl0mJSiTSRP1Sl8zrmgwXFHDWvt+UKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726907; c=relaxed/simple;
	bh=ljfQhHxBG2avO1cQTRbTF4VKrakPTE2h3jJfLV9OMik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=V1K4Z5Np0XxJWHcWpv+/Z2fR9Wb6VNHnJNP1a6gx9N3kyOyonOAdMjSdjCQuvhDhu3hcEZvyHcXutveVqnwUraUGfrREUAsiWItA5yeWE4NOuzLdvN0eEPYVGI447fxc2iQz0WB3uM6SfRbQPLbjCQ97Ek9783VbYtQPy/lNjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLWpJ5q/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712726903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sr9Rs7tpVxHk2Cr9wlHh87gQfwKe/Tm3Gn6z29nHOVI=;
	b=DLWpJ5q/xyb8bhKJMhuUC0dKlAKuNqFzQEreVF3eMDXvNGhytHHoEWPWmNr8pN18NnnK9y
	LiUVoQ51FBKrUXqzhP3T++VgAUt5XBJ+lBDqAJ/sKh+H2FsZ5uoYFt5ChbefEc9uPtDKDA
	n0h0zbmky49bWE3uOoaI6p9HZq6EbJY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-wIGr5RHuOXGqL9gPLDt22A-1; Wed, 10 Apr 2024 01:28:21 -0400
X-MC-Unique: wIGr5RHuOXGqL9gPLDt22A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51abd0d7c6so332711766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 22:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712726900; x=1713331700;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sr9Rs7tpVxHk2Cr9wlHh87gQfwKe/Tm3Gn6z29nHOVI=;
        b=aEqUqNOttVbq+YcQNoh9thWRIvXHP36Py84uM4d9bZfZsK97nrUDRasB7XL1L5KCgF
         fsxesc7iE+0Fhaw/5DXpYCkbN+eYo5GKSalHAT0fvc78Jr5CUHGsXAdpo0+jFlbAYww2
         sa/vr8rNhkjjrH6rdGVvMGN1SDZy1Va9F4/ck/9Lg0dmxwB/iwl2Z1k4XsxAuIAugY5y
         MQvBxKATI9Lbe/pYG0nwN53N7+NiIYGbQOdW6BpfHBk4MWuxPUbb5fYzNDCoQjuY1061
         NHfrzI9DWYWsBi1gPJ1w7iNvP35hdpNgnSHqn2bt94Ovx0uaq87m9LuDL+OqNWF+LD0w
         xiuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD6A6OzdPdGsa7LJQ5Y3Ovjt0SPrnKO61jVy1pvMG7RTM3JLG3CWQ1F/dH4hT98wqB91JKUorU67B65kHvpdZVgaR3ACfAwAW9vuAv
X-Gm-Message-State: AOJu0YyEuuAAC1J3gsk6SK5Owtt1kvrg0j+zoDpmFV95ZHBlqKjUoCXK
	fOfzg9oz9bG+a1R7bTyEgyrzvsKPDMFJajCsIRl+ofVPYxWvNoyPgYS877emNzkIacB58dEpjbe
	U6nnf7bnHnJisX4QriZ7cdFXDI/nu7ajIwo2l7FyiYqFfdapeCwnV15oSAFp9ilIS7DYvVFzMnJ
	F8+HlU4ovzOfumSRe1BMYtxfjE4vjAZ3DpYuGv
X-Received: by 2002:a17:906:2352:b0:a51:d7b1:daa5 with SMTP id m18-20020a170906235200b00a51d7b1daa5mr774351eja.65.1712726900466;
        Tue, 09 Apr 2024 22:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8pwiTgzKOtUSldwHz23rg9QYCan+25MAnLvv9VFe4NzmZCAZ4eDVcFWQv+lL6uOF6amadPg/UdZaro5JfK6M=
X-Received: by 2002:a17:906:2352:b0:a51:d7b1:daa5 with SMTP id
 m18-20020a170906235200b00a51d7b1daa5mr774344eja.65.1712726900070; Tue, 09 Apr
 2024 22:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410043450.416752-1-lulu@redhat.com> <20240410043450.416752-2-lulu@redhat.com>
In-Reply-To: <20240410043450.416752-2-lulu@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 10 Apr 2024 13:27:42 +0800
Message-ID: <CACLfguX-L_amTHz5+wvaFe9bObNAFQTxe+Q_en-ungcV8U4Jjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virtio-pci: Fix the crash that the vector was used
 after released.
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, send to the wrong mail list, please ignore it

On Wed, Apr 10, 2024 at 12:35=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> When the guest triggers vhost_stop and then virtio_reset, the vector will=
 the
> IRQFD for this vector will be released and change to VIRTIO_NO_VECTOR.
> After that, the guest called vhost_net_start,  (at this time, the configu=
re
> vector is still VIRTIO_NO_VECTOR),  vector 0 still was not "init".
> The guest system continued to boot, set the vector back to 0, and then me=
t the crash.
>
> To fix this, we need to call the function "kvm_virtio_pci_vector_use_one(=
)"
> when the vector changes back from VIRTIO_NO_VECTOR
>
> (gdb) bt
> 0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsig=
no@entry=3D6, no_tid=3Dno_tid@entry=3D0)
>     at pthread_kill.c:44
> 1  0x00007fc87148ec53 in __pthread_kill_internal (signo=3D6, threadid=3D<=
optimized out>) at pthread_kill.c:78
> 2  0x00007fc87143e956 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/p=
osix/raise.c:26
> 3  0x00007fc8714287f4 in __GI_abort () at abort.c:79
> 4  0x00007fc87142871b in __assert_fail_base
>     (fmt=3D0x7fc8715bbde0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", as=
sertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "../accel/kv=
m/kvm-all.c", line=3D1837, function=3D<optimized out>) at assert.c:92
> 5  0x00007fc871437536 in __GI___assert_fail
>     (assertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "..=
/accel/kvm/kvm-all.c", line=3D1837, function=3D0x5606413f06f0 <__PRETTY_FUN=
CTION__.19> "kvm_irqchip_commit_routes") at assert.c:101
> 6  0x0000560640f884b5 in kvm_irqchip_commit_routes (s=3D0x560642cae1f0) a=
t ../accel/kvm/kvm-all.c:1837
> 7  0x0000560640c98f8e in virtio_pci_one_vector_unmask
>     (proxy=3D0x560643c65f00, queue_no=3D4294967295, vector=3D0, msg=3D...=
, n=3D0x560643c6e4c8)
>     at ../hw/virtio/virtio-pci.c:1005
> 8  0x0000560640c99201 in virtio_pci_vector_unmask (dev=3D0x560643c65f00, =
vector=3D0, msg=3D...)
>     at ../hw/virtio/virtio-pci.c:1070
> 9  0x0000560640bc402e in msix_fire_vector_notifier (dev=3D0x560643c65f00,=
 vector=3D0, is_masked=3Dfalse)
>     at ../hw/pci/msix.c:120
> 10 0x0000560640bc40f1 in msix_handle_mask_update (dev=3D0x560643c65f00, v=
ector=3D0, was_masked=3Dtrue)
>     at ../hw/pci/msix.c:140
> 11 0x0000560640bc4503 in msix_table_mmio_write (opaque=3D0x560643c65f00, =
addr=3D12, val=3D0, size=3D4)
>     at ../hw/pci/msix.c:231
> 12 0x0000560640f26d83 in memory_region_write_accessor
>     (mr=3D0x560643c66540, addr=3D12, value=3D0x7fc86b7bc628, size=3D4, sh=
ift=3D0, mask=3D4294967295, attrs=3D...)
>     at ../system/memory.c:497
> 13 0x0000560640f270a6 in access_with_adjusted_size
>
>      (addr=3D12, value=3D0x7fc86b7bc628, size=3D4, access_size_min=3D1, a=
ccess_size_max=3D4, access_fn=3D0x560640f26c8d <memory_region_write_accesso=
r>, mr=3D0x560643c66540, attrs=3D...) at ../system/memory.c:573
> 14 0x0000560640f2a2b5 in memory_region_dispatch_write (mr=3D0x560643c6654=
0, addr=3D12, data=3D0, op=3DMO_32, attrs=3D...)
>     at ../system/memory.c:1521
> 15 0x0000560640f37bac in flatview_write_continue
>     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., ptr=3D0x7fc871e=
9c028, len=3D4, addr1=3D12, l=3D4, mr=3D0x560643c66540)
>     at ../system/physmem.c:2714
> 16 0x0000560640f37d0f in flatview_write
>     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., buf=3D0x7fc871e=
9c028, len=3D4) at ../system/physmem.c:2756
> 17 0x0000560640f380bf in address_space_write
>     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, attrs=
=3D..., buf=3D0x7fc871e9c028, len=3D4)
>     at ../system/physmem.c:2863
> 18 0x0000560640f3812c in address_space_rw
>     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, attrs=
=3D..., buf=3D0x7fc871e9c028, len=3D4, is_write=3Dtrue) at ../system/physme=
m.c:2873
> --Type <RET> for more, q to quit, c to continue without paging--
> 19 0x0000560640f8aa55 in kvm_cpu_exec (cpu=3D0x560642f205e0) at ../accel/=
kvm/kvm-all.c:2915
> 20 0x0000560640f8d731 in kvm_vcpu_thread_fn (arg=3D0x560642f205e0) at ../=
accel/kvm/kvm-accel-ops.c:51
> 21 0x00005606411949f4 in qemu_thread_start (args=3D0x560642f292b0) at ../=
util/qemu-thread-posix.c:541
> 22 0x00007fc87148cdcd in start_thread (arg=3D<optimized out>) at pthread_=
create.c:442
> 23 0x00007fc871512630 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone3.S:81
> (gdb)
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c..344f4fb844 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -880,6 +880,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIPro=
xy *proxy, int queue_no)
>      int ret;
>      EventNotifier *n;
>      PCIDevice *dev =3D &proxy->pci_dev;
> +    VirtIOIRQFD *irqfd;
>      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
>      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>
> @@ -890,10 +891,19 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIP=
roxy *proxy, int queue_no)
>      if (vector >=3D msix_nr_vectors_allocated(dev)) {
>          return 0;
>      }
> +    /*
> +     * if the irqfd still in use, means the irqfd was not
> +     * release before and don't need to set up
> +     */
> +    irqfd =3D &proxy->vector_irqfd[vector];
> +    if (irqfd->users !=3D 0) {
> +        return 0;
> +    }
>      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
>      if (ret < 0) {
>          goto undo;
>      }
> +
>      /*
>       * If guest supports masking, set up irqfd now.
>       * Otherwise, delay until unmasked in the frontend.
> @@ -1570,7 +1580,19 @@ static void virtio_pci_common_write(void *opaque, =
hwaddr addr,
>          } else {
>              val =3D VIRTIO_NO_VECTOR;
>          }
> +        vector =3D vdev->config_vector;
>          vdev->config_vector =3D val;
> +        /*
> +         *if the val was change from NO_VECTOR, this means the vector ma=
ybe
> +         * release before, need to check if need to set up
> +         */
> +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_VECT=
OR) &&
> +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +            /* check if use irqfd*/
> +            if (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabl=
ed()) {
> +                kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_I=
DX);
> +            }
> +        }
>          break;
>      case VIRTIO_PCI_COMMON_STATUS:
>          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> @@ -1611,6 +1633,19 @@ static void virtio_pci_common_write(void *opaque, =
hwaddr addr,
>              val =3D VIRTIO_NO_VECTOR;
>          }
>          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> +
> +        /*
> +         *if the val was change from NO_VECTOR, this means the vector ma=
ybe
> +         * release before, need to check if need to set up
> +         */
> +
> +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_VECT=
OR) &&
> +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +            /* check if use irqfd*/
> +            if (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabl=
ed()) {
> +                kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel);
> +            }
> +        }
>          break;
>      case VIRTIO_PCI_COMMON_Q_ENABLE:
>          if (val =3D=3D 1) {
> --
> 2.43.0
>


