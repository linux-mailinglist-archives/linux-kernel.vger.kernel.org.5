Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2278DE67
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbjH3TCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242371AbjH3ISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6797B113
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693383439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bar+WKz4EarAB8Ac37g0Uj2o6cVBqwkH3VXs7Pt3Pzg=;
        b=Plj8lfGz4todUuIYSXmHED5defJWju0R2td25hejyMTf5UBs/PlMRcOZUyijkYCZxuHycy
        dT1/+JaZ9qQgELykBLCHvM0RY5up3QymE8z2m1GakYtIH++glTNmYdg2+oo/JANWgH5yXM
        WJZAA2mZAti0Ci6fITwXww4Y4KaXMqE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-rVinnf97PHWjJuUsnsD5aQ-1; Wed, 30 Aug 2023 04:17:17 -0400
X-MC-Unique: rVinnf97PHWjJuUsnsD5aQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-52a3e9c53e7so4197848a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693383435; x=1693988235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bar+WKz4EarAB8Ac37g0Uj2o6cVBqwkH3VXs7Pt3Pzg=;
        b=lmC7m9laIFQ/1AEykyz2i9MZvdZy0uQ5hr0FLdaz8zeh97guuOtjTuQ1TavwLMzWk/
         Y5aZpveTY8S87538/IPTzpuz9kr4mVa34+OmgFU33KFBthl+sa8gY0S8okBLYpHUDWhD
         Pa4DfYxXT9kkBHmZdOd7+4opLpcfCFwqIr9VzQUmlDT4EnPoBMLowsO/n4SOJfPqz8M1
         kBawXmBiUHgfsjOZgZqO1K/yqdaImhR31pvBlsqwH/qTxKCReFAAv7V2d9uVcCplvpgO
         75KRyzyqZaesezfLxPZftdOj+R2TF0tpc9OXnFrpC/zFm2q+nYmvhxVVOCTdv+vstdLY
         KbIg==
X-Gm-Message-State: AOJu0Ywn9Pbo4kwAt64TxWFMVzzcXOGmKc/1VxBumMHsIfZRDNX1bGMG
        ZngD1ZvXf1y4xokZXC7tMBN1X9GGE93qNJ0Tk2rZ75bBCIWUVCj390Pppm4sDXq3gEaNFalc1Sq
        bE15+8EGT9aXAb03C7bKA5iDg4Rc2ipZ2J4vSWF+N
X-Received: by 2002:aa7:d309:0:b0:522:27ea:58b with SMTP id p9-20020aa7d309000000b0052227ea058bmr1235980edq.39.1693383435625;
        Wed, 30 Aug 2023 01:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6/LInntBhml1RhECdv+jKaWODZOhnz8jouuiowLxhc/PAy4Lz8MdbiTpXX0KtN5lbcxZ4VViU+Moq9sFeXZw=
X-Received: by 2002:aa7:d309:0:b0:522:27ea:58b with SMTP id
 p9-20020aa7d309000000b0052227ea058bmr1235966edq.39.1693383435291; Wed, 30 Aug
 2023 01:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230829015421.920511-1-gshan@redhat.com> <55cb12bf-12e4-8da6-629c-5518f8abe85e@redhat.com>
In-Reply-To: <55cb12bf-12e4-8da6-629c-5518f8abe85e@redhat.com>
From:   Zhenyu Zhang <zhenyzha@redhat.com>
Date:   Wed, 30 Aug 2023 16:16:39 +0800
Message-ID: <CAJFLiBK+PyvJrENd-=9gPDfVJ-MPL9RpkzyM_+wFrwxU=7qagA@mail.gmail.com>
Subject: Re: [PATCH] virtio_balloon: Fix endless deflation and inflation on arm64
To:     Gavin Shan <gshan@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com, mst@redhat.com,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        David Hildenbrand <david@redhat.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] virtio_balloon: Fix endless deflation and inflation on arm64

The patches work well on my arm Ampere host.
The test results are as expected.

Testing
=3D=3D=3D=3D=3D=3D=3D
(1) boot 64KB base page size guest, deflation balloon.
/home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
-device '{"id": "pcie-root-port-0", "driver": "pcie-root-port",
"multifunction": true, "bus": "pcie.0", "addr": "0x1", "chassis": 1}'
\
-device '{"id": "pcie-pci-bridge-0", "driver": "pcie-pci-bridge",
"addr": "0x0", "bus": "pcie-root-port-0"}'  \
-nodefaults \
-device '{"id": "pcie-root-port-1", "port": 1, "driver":
"pcie-root-port", "addr": "0x1.0x1", "bus": "pcie.0", "chassis": 2}' \
-device '{"driver": "virtio-gpu-pci", "bus": "pcie-root-port-1",
"addr": "0x0"}' \
-m 8192 \
-object '{"size": 4294967296, "id": "mem-machine_mem0", "qom-type":
"memory-backend-ram"}'  \
-object '{"size": 4294967296, "id": "mem-machine_mem1", "qom-type":
"memory-backend-ram"}'  \
-numa node,nodeid=3D0,memdev=3Dmem-machine_mem0,cpus=3D0-3 \
-numa node,nodeid=3D1,memdev=3Dmem-machine_mem1,cpus=3D4-7 \
-smp 8,maxcpus=3D8,cores=3D2,threads=3D1,clusters=3D2,sockets=3D2  \
-cpu 'host' \
-enable-kvm \
    :       \
-device '{"id": "pcie-root-port-5", "port": 5, "driver":
"pcie-root-port", "addr": "0x1.0x5", "bus": "pcie.0", "chassis": 6}' \
-device '{"driver": "virtio-balloon-pci", "id": "balloon0",
"free-page-reporting": true, "bus": "pcie-root-port-5", "addr":
"0x0"}' \

{ "execute" : "balloon", "arguments": { "value" : 7515705344 }}
{"return": {}}
{"timestamp": {"seconds": 1693284182, "microseconds": 597003},
"event": "BALLOON_CHANGE", "data": {"actual": 8588886016}}
{"timestamp": {"seconds": 1693284183, "microseconds": 598037},
"event": "BALLOON_CHANGE", "data": {"actual": 7515668480}}
{"timestamp": {"seconds": 1693284184, "microseconds": 599116},
"event": "BALLOON_CHANGE", "data": {"actual": 7515734016}}
{"timestamp": {"seconds": 1693284185, "microseconds": 600167},
"event": "BALLOON_CHANGE", "data": {"actual": 7515668480}}
{"timestamp": {"seconds": 1693284186, "microseconds": 601226},
"event": "BALLOON_CHANGE", "data": {"actual": 7515734016}}
{"timestamp": {"seconds": 1693284187, "microseconds": 602287},
"event": "BALLOON_CHANGE", "data": {"actual": 7515668480}}
{"timestamp": {"seconds": 1693284188, "microseconds": 603386},
"event": "BALLOON_CHANGE", "data": {"actual": 7515668480}}
{"timestamp": {"seconds": 1693284189, "microseconds": 604401},
"event": "BALLOON_CHANGE", "data": {"actual": 7515668480}}
{"timestamp": {"seconds": 1693284190, "microseconds": 605467},
"event": "BALLOON_CHANGE", "data": {"actual": 7515734016}}
    :
 <The similar QMP events repeat>

git am this patch
{ "execute" : "balloon", "arguments": { "value" : 7515705344 }}
{"return": {}}
{"timestamp": {"seconds": 1693301553, "microseconds": 809765},
"event": "BALLOON_CHANGE", "data": {"actual": 8588886016}}
{"timestamp": {"seconds": 1693301553, "microseconds": 986697},
"event": "BALLOON_CHANGE", "data": {"actual": 7515668480}}

{ "execute" : "query-balloon" }
{"return": {"actual": 7515668480}}


(2) Run kvm-unit-tests:
      6 cases skip, 32 cases pass.

(3) Run selftests TARGETS=3Dkvm:
      23 cases all pass

Tested-by: Zhenyu Zhang <zhenzha@redhat.com>

On Wed, Aug 30, 2023 at 12:24=E2=80=AFPM Gavin Shan <gshan@redhat.com> wrot=
e:
>
> On 8/29/23 11:54, Gavin Shan wrote:
> > The deflation request to the target, which isn't unaligned to the
> > guest page size causes endless deflation and inflation actions. For
> > example, we receive the flooding QMP events for the changes on memory
> > balloon's size after a deflation request to the unaligned target is
> > sent for the ARM64 guest, where we have 64KB base page size.
> >
> >    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
> >    -accel kvm -machine virt,gic-version=3Dhost -cpu host          \
> >    -smp maxcpus=3D8,cpus=3D8,sockets=3D2,clusters=3D2,cores=3D2,threads=
=3D1 \
> >    -m 1024M,slots=3D16,maxmem=3D64G                                 \
> >    -object memory-backend-ram,id=3Dmem0,size=3D512M                 \
> >    -object memory-backend-ram,id=3Dmem1,size=3D512M                 \
> >    -numa node,nodeid=3D0,memdev=3Dmem0,cpus=3D0-3                     \
> >    -numa node,nodeid=3D1,memdev=3Dmem1,cpus=3D4-7                     \
> >      :                                                          \
> >    -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpcie.10
> >
> >    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
> >    {"return": {}}
> >    {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> >    {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> >    {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> >    {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> >    {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> >       :
> >    <The similar QMP events repeat>
> >
> > Fix it by having the target aligned to the guest page size, 64KB
> > in this specific case. With this applied, no flooding QMP event
> > is observed and the memory balloon's size can be stablizied to
> > 0x3ffe0000 soon after the deflation request is sent.
> >
> >    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
> >    {"return": {}}
> >    {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
> >     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> >    { "execute" : "query-balloon" }
> >    {"return": {"actual": 1073610752}}
> >
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >   drivers/virtio/virtio_balloon.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >
>
> It was supposed to copy David, Jason and Zhenyu. I don't know how they ha=
ve been
> missed. My script may run into problems temporarily. Amending for it.
>
> Thanks,
> Gavin
>
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> > index 5b15936a5214..625caac35264 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -386,6 +386,17 @@ static void stats_handle_request(struct virtio_bal=
loon *vb)
> >       virtqueue_kick(vq);
> >   }
> >
> > +static inline s64 align_pages_up(s64 diff)
> > +{
> > +     if (diff =3D=3D 0)
> > +             return diff;
> > +
> > +     if (diff > 0)
> > +             return ALIGN(diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
> > +
> > +     return -ALIGN(-diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
> > +}
> > +
> >   static inline s64 towards_target(struct virtio_balloon *vb)
> >   {
> >       s64 target;
> > @@ -396,7 +407,7 @@ static inline s64 towards_target(struct virtio_ball=
oon *vb)
> >                       &num_pages);
> >
> >       target =3D num_pages;
> > -     return target - vb->num_pages;
> > +     return align_pages_up(target - vb->num_pages);
> >   }
> >
> >   /* Gives back @num_to_return blocks of free pages to mm. */
>

