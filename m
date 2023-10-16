Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904B47CA6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjJPLaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjJPLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078278E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697455761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Evymgu11lVRIoZkhZtKgNZwcfJTbKeogYL0eQOSHxPI=;
        b=ZNrAOS2cnSRr7FTbMBzaDEQyQgNm8ceKigPUGCiLEkAHN0aBHL65Wp26Q/TWhZQP9/gM0A
        3KdolNHKQaRzztu4fU3uUGcGxgDYzFEDcg6XmdnAOJoJHV7OA92iXI2ewnWy7dB8Z/O0rE
        OurSwUlyrsgtB5ZR7ZkqBZBwULFs6UA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-u97ZeQtNPBKa9uN9HZiXcg-1; Mon, 16 Oct 2023 07:29:15 -0400
X-MC-Unique: u97ZeQtNPBKa9uN9HZiXcg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5a7ac9c1522so66944167b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697455755; x=1698060555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Evymgu11lVRIoZkhZtKgNZwcfJTbKeogYL0eQOSHxPI=;
        b=o9Nangoda7aU9z8/k9P6sy7X4G4iwvyM8H2GYY/AhubXeRKX3HaHlsQ0XpBJb7eKGe
         24q5Ax+NmOUCTWL9umbNKyIdFK3qtgRC66qxS3NzAtfux5F355CAJ3TUjt+uQazqeDGI
         GSfp4MS1Hho0s/AEDMICYVNXgyBCwlvm0iH6YtIvlwlrMBJH/Ziujl4a8Js5tWF+4j/H
         MIQXlxD7qWsnadDDTVyQH0CtOMXZMZQv6fx3DeMBZ16nzDdRaN4dWz2PJYOxNVzw+mu4
         9pxmZ4y/M9EiUyVMsYKkV22xVsdcUHLQ/OF/r73LvGUcJ+UFDPrAuHto9iwLqJ5Ld24W
         1Lhg==
X-Gm-Message-State: AOJu0YwxkgQpqbUIy8wS0eOHkKZC6np9cyXx8CcXk5haLMNEc1z43B/N
        AK0aIhp0vmtQQDUOChsl7UcS/j0aPmWvIBmkUUPBt5HF6D/fcHbYZ754PZRP/WG7I+H48MXxit8
        RADxAkpiW9QX43+KvLiu0Hp8nCZoVUB4OhYOnOPb6
X-Received: by 2002:a81:48cc:0:b0:5a7:baac:7b34 with SMTP id v195-20020a8148cc000000b005a7baac7b34mr20103527ywa.28.1697455754840;
        Mon, 16 Oct 2023 04:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTSSGeFWMg+WBBKLkbzrdtCdipLSnN4mhWtx46zHp0SuhAljYLJjyjDlKIkFT+aT/9lUkNyqo7aBWxzAEU1vI=
X-Received: by 2002:a81:48cc:0:b0:5a7:baac:7b34 with SMTP id
 v195-20020a8148cc000000b005a7baac7b34mr20103517ywa.28.1697455754555; Mon, 16
 Oct 2023 04:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com> <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
In-Reply-To: <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 16 Oct 2023 13:28:37 +0200
Message-ID: <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To:     Jason Wang <jasowang@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 8:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Oct 13, 2023 at 3:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com=
> wrote:
> >
> >
> >
> > On 10/12/2023 8:01 PM, Jason Wang wrote:
> > > On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> > >> Devices with on-chip IOMMU or vendor specific IOTLB implementation
> > >> may need to restore iotlb mapping to the initial or default state
> > >> using the .reset_map op, as it's desirable for some parent devices
> > >> to solely manipulate mappings by its own, independent of virtio devi=
ce
> > >> state. For instance, device reset does not cause mapping go away on
> > >> such IOTLB model in need of persistent mapping. Before vhost-vdpa
> > >> is going away, give them a chance to reset iotlb back to the initial
> > >> state in vhost_vdpa_cleanup().
> > >>
> > >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > >> ---
> > >>   drivers/vhost/vdpa.c | 16 ++++++++++++++++
> > >>   1 file changed, 16 insertions(+)
> > >>
> > >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > >> index 851535f..a3f8160 100644
> > >> --- a/drivers/vhost/vdpa.c
> > >> +++ b/drivers/vhost/vdpa.c
> > >> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_al=
loc_as(struct vhost_vdpa *v,
> > >>          return vhost_vdpa_alloc_as(v, asid);
> > >>   }
> > >>
> > >> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
> > >> +{
> > >> +       struct vdpa_device *vdpa =3D v->vdpa;
> > >> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> > >> +
> > >> +       if (ops->reset_map)
> > >> +               ops->reset_map(vdpa, asid);
> > >> +}
> > >> +
> > >>   static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
> > >>   {
> > >>          struct vhost_vdpa_as *as =3D asid_to_as(v, asid);
> > >> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vd=
pa *v, u32 asid)
> > >>
> > >>          hlist_del(&as->hash_link);
> > >>          vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid)=
;
> > >> +       /*
> > >> +        * Devices with vendor specific IOMMU may need to restore
> > >> +        * iotlb to the initial or default state which is not done
> > >> +        * through device reset, as the IOTLB mapping manipulation
> > >> +        * could be decoupled from the virtio device life cycle.
> > >> +        */
> > > Should we do this according to whether IOTLB_PRESIST is set?
> > Well, in theory this seems like so but it's unnecessary code change
> > actually, as that is the way how vDPA parent behind platform IOMMU work=
s
> > today, and userspace doesn't break as of today. :)
>
> Well, this is one question I've ever asked before. You have explained
> that one of the reason that we don't break userspace is that they may
> couple IOTLB reset with vDPA reset as well. One example is the Qemu.
>
> >
> > As explained in previous threads [1][2], when IOTLB_PERSIST is not set
> > it doesn't necessarily mean the iotlb will definitely be destroyed
> > across reset (think about the platform IOMMU case), so userspace today
> > is already tolerating enough with either good or bad IOMMU. This code o=
f
> > not checking IOTLB_PERSIST being set is intentional, there's no point t=
o
> > emulate bad IOMMU behavior even for older userspace (with improper
> > emulation to be done it would result in even worse performance).
>
> For two reasons:
>
> 1) backend features need acked by userspace this is by design
> 2) keep the odd behaviour seems to be more safe as we can't audit
> every userspace program
>

The old behavior (without flag ack) cannot be trusted already, as:
* Devices using platform IOMMU (in other words, not implementing
neither .set_map nor .dma_map) does not unmap memory at virtio reset.
* Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iotlb
called from mlx5_vdpa_reset). With vdpa_sim patch removing the reset,
now all backends work the same as far as I know., which was (and is)
the way devices using the platform IOMMU works.

The difference in behavior did not matter as QEMU unmaps all the
memory unregistering the memory listener at vhost_vdpa_dev_start(...,
started =3D false), but the backend acknowledging this feature flag
allows QEMU to make sure it is safe to skip this unmap & map in the
case of vhost stop & start cycle.

In that sense, this feature flag is actually a signal for userspace to
know that the bug has been solved. Not offering it indicates that
userspace cannot trust the kernel will retain the maps.

Si-Wei or Dragos, please correct me if I've missed something. Feel
free to use the text in case you find more clear in doc or patch log.

Thanks!

> Thanks
>
> > I think
> > the purpose of the IOTLB_PERSIST flag is just to give userspace 100%
> > certainty of persistent iotlb mapping not getting lost across vdpa rese=
t.
> >
> > Thanks,
> > -Siwei
> >
> > [1]
> > https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78152e=
47fd@oracle.com/
> > [2]
> > https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5473f=
1f2e@oracle.com/
> > >   Otherwise
> > > we may break old userspace.
> > >
> > > Thanks
> > >
> > >> +       vhost_vdpa_reset_map(v, asid);
> > >>          kfree(as);
> > >>
> > >>          return 0;
> > >> --
> > >> 1.8.3.1
> > >>
> >
>

