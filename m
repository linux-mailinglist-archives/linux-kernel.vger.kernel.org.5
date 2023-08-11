Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D5778A55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHKJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjHKJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191072723
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691747329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fuPwMiCOds871v8o/ogtGSupZ7sHE8svUP10CQtFD/o=;
        b=i6KGhJ1igbSShxZa6tfwrXxa7Hm3iCDUvHMVw/MAe/4PuIYtMMCJuoPbzrVvej7QXTEn1Y
        OD5c49ZruDbFozKDN3dVNYYUlNxq3UE0kO0OQfscuhaT0V7BjGvUCsCp9ZAZWkOUssFy2b
        2dL5M8AwSYXaemhL1GGlWQlgYkjH6Us=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-ITziIuwbO1enDueYMZ8g5w-1; Fri, 11 Aug 2023 05:48:47 -0400
X-MC-Unique: ITziIuwbO1enDueYMZ8g5w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe5c898715so11552865e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691747326; x=1692352126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuPwMiCOds871v8o/ogtGSupZ7sHE8svUP10CQtFD/o=;
        b=SqmoO7LTVN+C9cDhxvNdYtylymlklbWnKOZKbzz6P+7ch2LMAzZTj9d+TDhVXPHlVK
         RY2sqgWAfwaJguOm0Vy9BJg6nxkSOpA+q60J2Agfex7rdUOgZbvjZJFzOH/4sbrwLITG
         Z/2G/gL2RuIebT9+EcOwQjPmvVAoCCvghb2wBPIkeBwaAmBn80SwjOuvMiE/4dgKXV03
         8VM36y6cOz8m3Flw64GzR3ip/raYIWv4kTohWp1wQIHpPwSsJtu5gHVaK7mkvAWPrPpk
         P3kBez0cOzu33QPgp3V54wLm7DDiO6P50i34nuZ2VfSPuy4SmRX40StH8pKinJih1d5d
         4fQA==
X-Gm-Message-State: AOJu0Yznt9KoO9/QSNT3jXUUn+6MSSk1olaJ6wz76wui1w68UPk28NYg
        TXiBONr3cu6Wd0/5phgzYhmFMQY6vm2p9L/RptwfwMGCSLYy+jWLyBqPBUXJVmFvBrbw3L6nxJI
        VrxleNygWkEN/TtkmxvWJ2iq4EyD9FjNE
X-Received: by 2002:a1c:cc12:0:b0:3fa:8db4:91ec with SMTP id h18-20020a1ccc12000000b003fa8db491ecmr1134553wmb.10.1691747326504;
        Fri, 11 Aug 2023 02:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf9bXPD4yjwvlp8v42lTNJRVWFj4ngnnn3DuWzV+hlTBAZcBoR/XB3/gpHHTV7jqPuGXB0EA==
X-Received: by 2002:a1c:cc12:0:b0:3fa:8db4:91ec with SMTP id h18-20020a1ccc12000000b003fa8db491ecmr1134544wmb.10.1691747326177;
        Fri, 11 Aug 2023 02:48:46 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id c16-20020a7bc010000000b003fc00212c1esm4709023wmb.28.2023.08.11.02.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:48:45 -0700 (PDT)
Date:   Fri, 11 Aug 2023 05:48:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com
Subject: Re: [PATCH] virtio_vdpa: build affinity masks conditionally
Message-ID: <20230811054736-mutt-send-email-mst@kernel.org>
References: <20230811091539.1359865-1-jasowang@redhat.com>
 <20230811052435-mutt-send-email-mst@kernel.org>
 <CACGkMEuO+smLSY+dRvDOar=pq6MpOv3U9z6gX=xRUkHg494MFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuO+smLSY+dRvDOar=pq6MpOv3U9z6gX=xRUkHg494MFw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 05:41:44PM +0800, Jason Wang wrote:
> On Fri, Aug 11, 2023 at 5:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Aug 11, 2023 at 05:15:39AM -0400, Jason Wang wrote:
> > > We try to build affinity mask via create_affinity_masks()
> > > unconditionally which may lead several issues:
> > >
> > > - the affinity mask is not used for parent without affinity support
> > >   (only VDUSE support the affinity now)
> > > - the logic of create_affinity_masks() might not work for devices
> > >   other than block. For example it's not rare in the networking device
> > >   where the number of queues could exceed the number of CPUs. Such
> > >   case breaks the current affinity logic which is based on
> > >   group_cpus_evenly() who assumes the number of CPUs are not less than
> > >   the number of groups. This can trigger a warning[1]:
> > >
> > >       if (ret >= 0)
> > >               WARN_ON(nr_present + nr_others < numgrps);
> > >
> > > Fixing this by only build the affinity masks only when
> > >
> > > - Driver passes affinity descriptor, driver like virtio-blk can make
> > >   sure to limit the number of queues when it exceeds the number of CPUs
> > > - Parent support affinity setting config ops
> > >
> > > This help to avoid the warning. More optimizations could be done on
> > > top.
> > >
> > > [1]
> > > [  682.146655] WARNING: CPU: 6 PID: 1550 at lib/group_cpus.c:400 group_cpus_evenly+0x1aa/0x1c0
> > > [  682.146668] CPU: 6 PID: 1550 Comm: vdpa Not tainted 6.5.0-rc5jason+ #79
> > > [  682.146671] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> > > [  682.146673] RIP: 0010:group_cpus_evenly+0x1aa/0x1c0
> > > [  682.146676] Code: 4c 89 e0 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc e8 1b c4 74 ff 48 89 ef e8 13 ac 98 ff 4c 89 e7 45 31 e4 e8 08 ac 98 ff eb c2 <0f> 0b eb b6 e8 fd 05 c3 00 45 31 e4 eb e5 cc cc cc cc cc cc cc cc
> > > [  682.146679] RSP: 0018:ffffc9000215f498 EFLAGS: 00010293
> > > [  682.146682] RAX: 000000000001f1e0 RBX: 0000000000000041 RCX: 0000000000000000
> > > [  682.146684] RDX: ffff888109922058 RSI: 0000000000000041 RDI: 0000000000000030
> > > [  682.146686] RBP: ffff888109922058 R08: ffffc9000215f498 R09: ffffc9000215f4a0
> > > [  682.146687] R10: 00000000000198d0 R11: 0000000000000030 R12: ffff888107e02800
> > > [  682.146689] R13: 0000000000000030 R14: 0000000000000030 R15: 0000000000000041
> > > [  682.146692] FS:  00007fef52315740(0000) GS:ffff888237380000(0000) knlGS:0000000000000000
> > > [  682.146695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  682.146696] CR2: 00007fef52509000 CR3: 0000000110dbc004 CR4: 0000000000370ee0
> > > [  682.146698] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [  682.146700] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [  682.146701] Call Trace:
> > > [  682.146703]  <TASK>
> > > [  682.146705]  ? __warn+0x7b/0x130
> > > [  682.146709]  ? group_cpus_evenly+0x1aa/0x1c0
> > > [  682.146712]  ? report_bug+0x1c8/0x1e0
> > > [  682.146717]  ? handle_bug+0x3c/0x70
> > > [  682.146721]  ? exc_invalid_op+0x14/0x70
> > > [  682.146723]  ? asm_exc_invalid_op+0x16/0x20
> > > [  682.146727]  ? group_cpus_evenly+0x1aa/0x1c0
> > > [  682.146729]  ? group_cpus_evenly+0x15c/0x1c0
> > > [  682.146731]  create_affinity_masks+0xaf/0x1a0
> > > [  682.146735]  virtio_vdpa_find_vqs+0x83/0x1d0
> > > [  682.146738]  ? __pfx_default_calc_sets+0x10/0x10
> > > [  682.146742]  virtnet_find_vqs+0x1f0/0x370
> > > [  682.146747]  virtnet_probe+0x501/0xcd0
> > > [  682.146749]  ? vp_modern_get_status+0x12/0x20
> > > [  682.146751]  ? get_cap_addr.isra.0+0x10/0xc0
> > > [  682.146754]  virtio_dev_probe+0x1af/0x260
> > > [  682.146759]  really_probe+0x1a5/0x410
> > >
> > > Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading mechanism")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > This won't fix the case where block has more queues than CPUs though,
> > will it?
> 
> Block will limit the number of queues during init_vq():
> 
>         num_vqs = min_t(unsigned int,
>                         min_not_zero(num_request_queues, nr_cpu_ids),
>                         num_vqs);
> 
> 
> Thanks

Good point. This doesn't play well with cpu hotplug but that is not new.

> >
> > > ---
> > >  drivers/virtio/virtio_vdpa.c | 17 +++++++++++------
> > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > index 961161da5900..06ce6d8c2e00 100644
> > > --- a/drivers/virtio/virtio_vdpa.c
> > > +++ b/drivers/virtio/virtio_vdpa.c
> > > @@ -366,11 +366,14 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > >       struct irq_affinity default_affd = { 0 };
> > >       struct cpumask *masks;
> > >       struct vdpa_callback cb;
> > > +     bool has_affinity = desc && ops->set_vq_affinity;
> > >       int i, err, queue_idx = 0;
> > >
> > > -     masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
> > > -     if (!masks)
> > > -             return -ENOMEM;
> > > +     if (has_affinity) {
> > > +             masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
> > > +             if (!masks)
> > > +                     return -ENOMEM;
> > > +     }
> > >
> > >       for (i = 0; i < nvqs; ++i) {
> > >               if (!names[i]) {
> > > @@ -386,20 +389,22 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > >                       goto err_setup_vq;
> > >               }
> > >
> > > -             if (ops->set_vq_affinity)
> > > +             if (has_affinity)
> > >                       ops->set_vq_affinity(vdpa, i, &masks[i]);
> > >       }
> > >
> > >       cb.callback = virtio_vdpa_config_cb;
> > >       cb.private = vd_dev;
> > >       ops->set_config_cb(vdpa, &cb);
> > > -     kfree(masks);
> > > +     if (has_affinity)
> > > +             kfree(masks);
> > >
> > >       return 0;
> > >
> > >  err_setup_vq:
> > >       virtio_vdpa_del_vqs(vdev);
> > > -     kfree(masks);
> > > +     if (has_affinity)
> > > +             kfree(masks);
> > >       return err;
> > >  }
> > >
> > > --
> > > 2.39.3
> >

