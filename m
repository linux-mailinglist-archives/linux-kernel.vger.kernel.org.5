Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8199381264F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443109AbjLNEN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjLNEN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:13:57 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E4CF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:14:02 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so96721631fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702527241; x=1703132041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko9+5c+M0rsdOliJjz79vbwez7kfxRfvV4P4ddiTQ70=;
        b=JlJRLg6p8xGb+OxYo+6hTnr4XDIGsPQSM84VGKOg2zhwpAn96nwUCdJKZUZ5Tar+Bd
         9TN4wUVRrgMYKQcxO2SQHFF6xRkO7/5uih6bG9w2/utlca+MbVjGLDUETwAWiUCMkGo9
         5vkGqDWx3jvPcPw/vAxSuV2OuyayX2/yDl1sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702527241; x=1703132041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko9+5c+M0rsdOliJjz79vbwez7kfxRfvV4P4ddiTQ70=;
        b=tPtqGKWTaSZGFZQEj6tUxEd2k4tCRfqcHNGBmKEPtYGXOJmtcvF00MEqy/rHoIKX6B
         eNRK1F2FfI1LkzvK6zK5fchKetkb75r9TP29Fp2eEIuUnw/FUkxwrCFGSXI81r/5zi+l
         286zv/V3Sm6PHDnvDDSRS3ohiKHUIzYBCxJ6qPieGr61O39IesZeAis+6VbNsjrecF64
         bqxEetbKFI/7oWnC9zHulEDIn6kKBf/eMv2d0Evmi1a522RnRxFQlXGfuI94hrfhyaQq
         3o7fWVY/ZqRPPYOc+WXBuFeupuALdJPLn7e8oNYCT8u81UVfOB92iMXv1LbNkYa1TckT
         ZM3w==
X-Gm-Message-State: AOJu0YybWJKQFN1Oo/uGYCHK7mJ3bCBsNkiBpopsuUMtJLmA95qgrPpM
        0ZOnTmLjO40fxLn2n7IKU6EFcOqgj/Y+RenTC1vd3A==
X-Google-Smtp-Source: AGHT+IF8dhpQCQv0logOf7SKeTioSy3lVUJdPz0lrUuXryPldBFF7hIb3KbzKDbva/fjX/cLx+sBOjPxhKlq/1NGB+8=
X-Received: by 2002:ac2:5511:0:b0:50c:4af:f2d7 with SMTP id
 j17-20020ac25511000000b0050c04aff2d7mr2607874lfk.135.1702527240864; Wed, 13
 Dec 2023 20:14:00 -0800 (PST)
MIME-Version: 1.0
References: <20231211114346.1132386-1-stevensd@google.com> <2146e48d-5fb3-4444-81c5-9c8d8cb18811@redhat.com>
In-Reply-To: <2146e48d-5fb3-4444-81c5-9c8d8cb18811@redhat.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 14 Dec 2023 13:13:49 +0900
Message-ID: <CAD=HUj7e9NaaYhos82JZoxhyX6J0bu+m0i7-_TqNbXiCDZ-Uxg@mail.gmail.com>
Subject: Re: [PATCH] virtio_balloon: stay awake while adjusting balloon
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 5:44=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.12.23 12:43, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
>
> Hi David,
>
> > Add a wakeup event for when the balloon is inflating or deflating.
> > Userspace can enable this wakeup event to prevent the system from
> > suspending while the balloon is being adjusted. This allows
> > /sys/power/wakeup_count to be used without breaking virtio_balloon's
> > cooperative memory management.
>
> Can you add/share some more details

I'm working on enabling support for Linux s2Idle in our Android
virtual machine, to restrict apps from running in the background
without holding an Android partial wakelock. With the patch I recently
sent out [1], since crosvm advertises native PCI power management for
virtio devices, the Android guest can properly enter s2idle, and it
can be woken up by incoming IO. However, one of the remaining problems
is that when the host needs to reclaim memory from the guest via the
virtio-balloon, there is nothing preventing the guest from entering
s2idle before the balloon driver finishes returning memory to the
host.

One alternative to this approach would be to add a virtballoon_suspend
callback to abort suspend if the balloon is inflating/adjusting.
However, it seems cleaner to just prevent suspend in the first place.

[1] https://lore.kernel.org/lkml/20231208070754.3132339-1-stevensd@chromium=
.org/

> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >   drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++++-----=
-
> >   1 file changed, 49 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> > index 1fe93e93f5bc..811d8937246a 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -119,6 +119,11 @@ struct virtio_balloon {
> >       /* Free page reporting device */
> >       struct virtqueue *reporting_vq;
> >       struct page_reporting_dev_info pr_dev_info;
> > +
> > +     /* State for keeping the wakeup_source active while adjusting the=
 balloon */
> > +     spinlock_t adjustment_lock;
> > +     u32 adjustment_seqno;
>
> Using a simple flag that gets set when updating the balloon size and
> test-and-clear when testing for changes should be easier to get.
>
> bool adjustment_balloon_size_changed;
>
> or sth like that.

That's a good simplification, thanks.

> > +     bool adjustment_in_progress;
> >   };
> >
> >   static const struct virtio_device_id id_table[] =3D {
> > @@ -437,6 +442,31 @@ static void virtio_balloon_queue_free_page_work(st=
ruct virtio_balloon *vb)
> >       queue_work(vb->balloon_wq, &vb->report_free_page_work);
> >   }
> >
> > +static void start_update_balloon_size(struct virtio_balloon *vb)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&vb->adjustment_lock, flags);
> > +     vb->adjustment_seqno++;
> > +     if (!vb->adjustment_in_progress) {
> > +             vb->adjustment_in_progress =3D true;
> > +             pm_stay_awake(&vb->vdev->dev);
> > +     }
> > +     spin_unlock_irqrestore(&vb->adjustment_lock, flags);
> > +
> > +     queue_work(system_freezable_wq, &vb->update_balloon_size_work);
> > +}
> > +
> > +static void end_update_balloon_size(struct virtio_balloon *vb, u32 seq=
no)
> > +{
> > +     spin_lock(&vb->adjustment_lock);
> > +     if (vb->adjustment_seqno =3D=3D seqno && vb->adjustment_in_progre=
ss) {
> > +             vb->adjustment_in_progress =3D false;
> > +             pm_relax(&vb->vdev->dev);
> > +     }
> > +     spin_unlock(&vb->adjustment_lock);
> > +}
> > +
> >   static void virtballoon_changed(struct virtio_device *vdev)
> >   {
> >       struct virtio_balloon *vb =3D vdev->priv;
> > @@ -444,8 +474,7 @@ static void virtballoon_changed(struct virtio_devic=
e *vdev)
> >
> >       spin_lock_irqsave(&vb->stop_update_lock, flags);
> >       if (!vb->stop_update) {
> > -             queue_work(system_freezable_wq,
> > -                        &vb->update_balloon_size_work);
> > +             start_update_balloon_size(vb);
> >               virtio_balloon_queue_free_page_work(vb);
> >       }
> >       spin_unlock_irqrestore(&vb->stop_update_lock, flags);
> > @@ -473,22 +502,29 @@ static void update_balloon_size_func(struct work_=
struct *work)
> >   {
> >       struct virtio_balloon *vb;
> >       s64 diff;
> > +     u32 seqno;
> >
> >       vb =3D container_of(work, struct virtio_balloon,
> >                         update_balloon_size_work);
> > -     diff =3D towards_target(vb);
> >
> > -     if (!diff)
> > -             return;
> > +     spin_lock(&vb->adjustment_lock);
> > +     seqno =3D vb->adjustment_seqno;
> > +     spin_unlock(&vb->adjustment_lock);
> >
> > -     if (diff > 0)
> > -             diff -=3D fill_balloon(vb, diff);
> > -     else
> > -             diff +=3D leak_balloon(vb, -diff);
> > -     update_balloon_size(vb);
> > +     diff =3D towards_target(vb);
> > +
> > +     if (diff) {
> > +             if (diff > 0)
> > +                     diff -=3D fill_balloon(vb, diff);
> > +             else
> > +                     diff +=3D leak_balloon(vb, -diff);
> > +             update_balloon_size(vb);
> > +     }
> >
> >       if (diff)
> >               queue_work(system_freezable_wq, work);
> > +     else
> > +             end_update_balloon_size(vb, seqno);
>
> What if we stop the workqueue and unload the driver -- see
> remove_common() -- won't you leave pm_stay_awake() wrongly set?

When a device gets removed, its wakeup source is destroyed, which
automatically calls __pm_relax.

> >   }
> >
> >   static int init_vqs(struct virtio_balloon *vb)
> > @@ -992,6 +1028,9 @@ static int virtballoon_probe(struct virtio_device =
*vdev)
> >                       goto out_unregister_oom;
> >       }
> >
> > +     spin_lock_init(&vb->adjustment_lock);
> > +     device_set_wakeup_capable(&vb->vdev->dev, true);
>
>
> I'm a bit confused: Documentation/driver-api/pm/devices.rst documents
>
> "
> The :c:member:`power.can_wakeup` flag just records whether the device
> (and its driver) can physically support wakeup events.  The
> :c:func:`device_set_wakeup_capable()` routine affects this flag.
> "
>
> ...
>
> "
> Whether or not a device is capable of issuing wakeup events is a
> hardware matter, and the kernel is responsible for keeping track of it.
> "
>
> But how is the virtio-balloon device capable of waking up the machine?
> Your patch merely implies that the virtio-baloon device is capable to
> prohbit going to sleep.
>
> What am I missing?

The underlying virtio_pci_device is capable of waking up the machine,
if it supports PCI power management. The core PCI code will keep the
machine awake while processing the interrupt (i.e. during
virtballoon_changed), but after processing is handed off to the
virtio-balloon driver, the virtio-balloon driver needs to keep the
machine awake until the processing is actually completed.

An alternative to making vb->vdev->dev wakeup capable is to plumb the
pm_stay_awake/pm_relax calls to the underlying virtio_pci_device. Would
that be a preferable approach?

-David
