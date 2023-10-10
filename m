Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5457BF35C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442340AbjJJGx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442295AbjJJGxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7705299
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696920757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+G320iPimgxS8L1+mRAviW0xgLurmbE0PKiNyj0tp6Q=;
        b=APi/yo76YaJASINprSTimuFwWjSANlY4ISoKAlBdl7H9fbv/BJlVnlWHj76VhJXuy6Q/iv
        hEyb3gJ15a3d0VOlcmqmXObjEUytBX9Z/W07ROyXQr5waBH1Zl/HMDTg9HWXWxdc2CNUWs
        RTwa4InNzBuudTKCuFtUfifRwsrsSRA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-_7ONRgquNPa71jGJdXH7Uw-1; Tue, 10 Oct 2023 02:52:36 -0400
X-MC-Unique: _7ONRgquNPa71jGJdXH7Uw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5043353efbdso4656542e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 23:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696920754; x=1697525554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+G320iPimgxS8L1+mRAviW0xgLurmbE0PKiNyj0tp6Q=;
        b=SSHVFfoopomDA2Xx6HD/MffdnbZKecdQsOW8onWSwhEfTQHFtYHGlkFf/ZBmH0jlLR
         BFkmcMWO18vGXKheEx4gKdTEMWPMYATiIkrOCbX1Px9Kl8T/AB5OYWybIuNFpY7CfNu5
         /kV0zdxOVuNGW0oBVQmSscqdUOimdxj13tM09gVW89R0hsfrYkB0PK5oMrX5WWXrTHbQ
         4KW48wMQVXCtLtq8hiXS9I02w6UtI6avXagY5+mjVPHtuQsq0/gdpgGwuSXnzsSk2rvD
         FkDZiSRHEtqJ+e4SeaqQb+cyLhKknvVVBHhdu8Ga56x2pq6zcFgT08xauzzo27O1BiBV
         /kRw==
X-Gm-Message-State: AOJu0YzOMnkVKzlby9xqeOkBoHA3Qn76fOGqfwEE7YKw7+jA/LMId39e
        RcyxAwIfEnJqwSO3KyIgaQV4rHE9GDHVeO/6XzJ30RvN6WWtncSRZlwBUlc+hRMPX3L3zIlMLQ1
        eCRRB6a7IXYALeX5XxSOJFwlVMquNF0PaSw5yWyZo
X-Received: by 2002:a19:910d:0:b0:501:ba04:f34b with SMTP id t13-20020a19910d000000b00501ba04f34bmr12894258lfd.44.1696920754535;
        Mon, 09 Oct 2023 23:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdkzil+fZM3sRvYWHcSN1F+M9KEiQsMB6dyNn9xV2X3juFCS7UlNbaqQ3sUTeVRaUP1eZhopO7WwfBKctoAEU=
X-Received: by 2002:a19:910d:0:b0:501:ba04:f34b with SMTP id
 t13-20020a19910d000000b00501ba04f34bmr12894246lfd.44.1696920754140; Mon, 09
 Oct 2023 23:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com> <20230929-jakub-os-90-trim-v1-2-a3af0c08f812@cloudflare.com>
In-Reply-To: <20230929-jakub-os-90-trim-v1-2-a3af0c08f812@cloudflare.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 Oct 2023 14:52:23 +0800
Message-ID: <CACGkMEsFYJ7VsyLua2BuCbCCrntkrJ4eUrCUrojCrirRpNT4Aw@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-mmio: Support multiple interrupts per device
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 4:46=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Some virtual devices, such as the virtio network device, can use multiple
> virtqueues (or multiple pairs of virtqueues in the case of a vNIC). In su=
ch
> case, when there are multiple vCPUs present, it is possible to process
> virtqueue events in parallel. Each vCPU can service a subset of all
> virtqueues when notified that there is work to carry out.
>
> However, the current virtio-mmio transport implementation poses a
> limitation. Only one vCPU can service notifications from any of the
> virtqueues of a single virtio device. This is because a virtio-mmio devic=
e
> driver supports registering just one interrupt per device. With such setu=
p
> we are not able to scale virtqueue event processing among vCPUs.
>
> Now, with more than one IRQ resource registered for a virtio-mmio platfor=
m
> device, we can address this limitation.
>
> First, we request multiple IRQs when creating virtqueues for a device.
>
> Then, map each virtqueue to one of the IRQs assigned to the device. The
> mapping is done in a device type specific manner. For instance, a network
> device will want each RX/TX virtqueue pair mapped to a different IRQ
> line. Other device types might require a different mapping scheme. We
> currently provide a mapping for virtio-net device type.
>
> Finally, when handling an interrupt, we service only the virtqueues
> associated with the IRQ line that triggered the event.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  drivers/virtio/virtio_mmio.c | 102 +++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 83 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 06a587b23542..180c51c27704 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -69,6 +69,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
> +#include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
>
> @@ -93,6 +94,10 @@ struct virtio_mmio_device {
>         /* a list of queues so we can dispatch IRQs */
>         spinlock_t lock;
>         struct list_head virtqueues;
> +
> +       /* IRQ range allocated to the device */
> +       unsigned int irq_base;
> +       unsigned int num_irqs;
>  };
>
>  struct virtio_mmio_vq_info {
> @@ -101,6 +106,9 @@ struct virtio_mmio_vq_info {
>
>         /* the list node for the virtqueues list */
>         struct list_head node;
> +
> +       /* IRQ mapped to virtqueue */
> +       unsigned int irq;
>  };
>
>
> @@ -297,7 +305,7 @@ static bool vm_notify_with_data(struct virtqueue *vq)
>         return true;
>  }
>
> -/* Notify all virtqueues on an interrupt. */
> +/* Notify all or some virtqueues on an interrupt. */
>  static irqreturn_t vm_interrupt(int irq, void *opaque)
>  {
>         struct virtio_mmio_device *vm_dev =3D opaque;
> @@ -308,20 +316,31 @@ static irqreturn_t vm_interrupt(int irq, void *opaq=
ue)
>
>         /* Read and acknowledge interrupts */
>         status =3D readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
> -       writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
>
>         if (unlikely(status & VIRTIO_MMIO_INT_CONFIG)) {
> +               writel(status & VIRTIO_MMIO_INT_CONFIG, vm_dev->base + VI=
RTIO_MMIO_INTERRUPT_ACK);
>                 virtio_config_changed(&vm_dev->vdev);
>                 ret =3D IRQ_HANDLED;
>         }
>
>         if (likely(status & VIRTIO_MMIO_INT_VRING)) {
> +               writel(status & VIRTIO_MMIO_INT_VRING, vm_dev->base + VIR=
TIO_MMIO_INTERRUPT_ACK);
>                 spin_lock_irqsave(&vm_dev->lock, flags);
>                 list_for_each_entry(info, &vm_dev->virtqueues, node)
>                         ret |=3D vring_interrupt(irq, info->vq);
>                 spin_unlock_irqrestore(&vm_dev->lock, flags);
>         }
>
> +       /* Notify only affected vrings if device uses multiple interrupts=
 */
> +       if (vm_dev->num_irqs > 1) {
> +               spin_lock_irqsave(&vm_dev->lock, flags);
> +               list_for_each_entry(info, &vm_dev->virtqueues, node) {
> +                       if (info->irq =3D=3D irq)
> +                               ret |=3D vring_interrupt(irq, info->vq);
> +               }
> +               spin_unlock_irqrestore(&vm_dev->lock, flags);
> +       }
> +
>         return ret;
>  }
>
> @@ -356,11 +375,15 @@ static void vm_del_vqs(struct virtio_device *vdev)
>  {
>         struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev)=
;
>         struct virtqueue *vq, *n;
> +       int i, irq;
> +
> +       for (i =3D 0; i < vm_dev->num_irqs; i++) {
> +               irq =3D vm_dev->irq_base + i;
> +               devm_free_irq(&vdev->dev, irq, vm_dev);
> +       }
>
>         list_for_each_entry_safe(vq, n, &vdev->vqs, list)
>                 vm_del_vq(vq);
> -
> -       free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
>  }
>
>  static void vm_synchronize_cbs(struct virtio_device *vdev)
> @@ -488,6 +511,18 @@ static struct virtqueue *vm_setup_vq(struct virtio_d=
evice *vdev, unsigned int in
>         return ERR_PTR(err);
>  }
>
> +/* Map virtqueue to zero-based interrupt number */
> +static unsigned int vq2irq(const struct virtqueue *vq)
> +{
> +       switch (vq->vdev->id.device) {
> +       case VIRTIO_ID_NET:
> +               /* interrupt shared by rx/tx virtqueue pair */
> +               return vq->index / 2;
> +       default:
> +               return 0;
> +       }

Transport drivers should have no knowledge of a specific type of device.

> +}
> +
>  static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                        struct virtqueue *vqs[],
>                        vq_callback_t *callbacks[],
> @@ -496,19 +531,9 @@ static int vm_find_vqs(struct virtio_device *vdev, u=
nsigned int nvqs,
>                        struct irq_affinity *desc)
>  {
>         struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev)=
;
> -       int irq =3D platform_get_irq(vm_dev->pdev, 0);
> -       int i, err, queue_idx =3D 0;
> -
> -       if (irq < 0)
> -               return irq;
> -
> -       err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
> -                       dev_name(&vdev->dev), vm_dev);
> -       if (err)
> -               return err;
> -
> -       if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-sour=
ce"))
> -               enable_irq_wake(irq);
> +       struct virtio_mmio_vq_info *info;
> +       int i, err, irq, nirqs, queue_idx =3D 0;
> +       unsigned int irq_base =3D UINT_MAX;
>
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
> @@ -519,12 +544,51 @@ static int vm_find_vqs(struct virtio_device *vdev, =
unsigned int nvqs,
>                 vqs[i] =3D vm_setup_vq(vdev, queue_idx++, callbacks[i], n=
ames[i],
>                                      ctx ? ctx[i] : false);
>                 if (IS_ERR(vqs[i])) {
> -                       vm_del_vqs(vdev);
> -                       return PTR_ERR(vqs[i]);
> +                       err =3D PTR_ERR(vqs[i]);
> +                       goto fail_vq;
>                 }
>         }
>
> +       nirqs =3D platform_irq_count(vm_dev->pdev);
> +       if (nirqs < 0) {
> +               err =3D nirqs;
> +               goto fail_vq;
> +       }
> +
> +       for (i =3D 0; i < nirqs; i++) {
> +               irq =3D platform_get_irq(vm_dev->pdev, i);
> +               if (irq < 0)
> +                       goto fail_irq;
> +               if (irq < irq_base)
> +                       irq_base =3D irq;
> +
> +               err =3D devm_request_irq(&vdev->dev, irq, vm_interrupt,
> +                                      IRQF_SHARED, NULL, vm_dev);
> +               if (err)
> +                       goto fail_irq;
> +
> +               if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wak=
eup-source"))
> +                       enable_irq_wake(irq);

Could we simply use the same policy as PCI (vp_find_vqs_msix())?

Thanks

> +       }
> +
> +       for (i =3D 0; i < nvqs; i++) {
> +               irq =3D vq2irq(vqs[i]);
> +               info =3D vqs[i]->priv;
> +               info->irq =3D irq_base + (irq % nirqs);
> +       }
> +
> +       vm_dev->irq_base =3D irq_base;
> +       vm_dev->num_irqs =3D nirqs;
> +
>         return 0;
> +
> +fail_irq:
> +       while (i--)
> +               devm_free_irq(&vdev->dev, irq_base + i, vm_dev);
> +fail_vq:
> +       vm_del_vqs(vdev);
> +
> +       return err;
>  }
>
>  static const char *vm_bus_name(struct virtio_device *vdev)
>
> --
> 2.41.0
>

