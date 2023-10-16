Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB977C9FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjJPGeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPGd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B82697
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697437993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIO4upB/BF6e1PX85KFwo9jmaAkfIMsZHKTqfiZlcqM=;
        b=fV5HZ2gYy1mb+FrogJRPI4drZIOliAYTImdjI4G0qGmQrr6CdR3d0R5kYKQYvPZOXlHx64
        6xjatxvaY/Jkq8bE8oSoElEBaXYCy+BOmF66gt3Q3G60a3ueUICCbkvnNp1eIxXsDZuURW
        HLzBJO7fQl0s7rFfJ6U9LX4oZHP1g+0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-aBHsO5cAMw6cTHQNrR5vrw-1; Mon, 16 Oct 2023 02:33:11 -0400
X-MC-Unique: aBHsO5cAMw6cTHQNrR5vrw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5079a8c68c6so2494012e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697437990; x=1698042790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIO4upB/BF6e1PX85KFwo9jmaAkfIMsZHKTqfiZlcqM=;
        b=wZOV+9yTm16295GZhKH1H4fdwgbjdwUCiCRn+cJijgDuT83k72e2298YQw8wPS5WD3
         X5U49gnGWizidgGYxzbKnZbgc3ap1G6a9rZxXraTGoLEOb79bK5ka2smucfij+LH9l+t
         5faiEykbV1W7nfJHpts3JBxaaNpD5+PiF4XtqlsTmxX3RwG0a2lCwsz1NXcQ72Zh47YG
         YCXvePTEZSQa4Q/4XG7m8f2KpBt1TfxxseaBMxixujeT5dp3HqZduWsWnNj2AC8+Vccv
         vcGXwnf3fvoUI+OLfZjTc/ojRLPGQBQQ22W4ofz1KLS2KYdBvQndQIL9+JRD7DmFqdbW
         d/Sg==
X-Gm-Message-State: AOJu0YyGIaMYP72JdV2rkymzkW5eUfCvwurPjnjYxNzhrShxmGOTDIuj
        wJU1uViJHu1/WztVChjtT9VV+aX757Hk8+6DPzwyuai7PPb8y5IJg9p4hG0vhtyikKeUFHNn540
        mGX36s0QO3bfxy8Gmlr5Thv3rcXQQa/wm2ZQc0AIg
X-Received: by 2002:ac2:4bce:0:b0:503:1722:bf3a with SMTP id o14-20020ac24bce000000b005031722bf3amr31051860lfq.1.1697437989909;
        Sun, 15 Oct 2023 23:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf+okbHXZCetyLViIwBUNQtjMg4ABshwSuCPClAVcR8pYJDLEG5PO/UXZu3YXSOWb3p14YEHoLnqVCYU77CA8=
X-Received: by 2002:ac2:4bce:0:b0:503:1722:bf3a with SMTP id
 o14-20020ac24bce000000b005031722bf3amr31051849lfq.1.1697437989582; Sun, 15
 Oct 2023 23:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
In-Reply-To: <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 16 Oct 2023 14:32:58 +0800
Message-ID: <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 3:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/12/2023 8:01 PM, Jason Wang wrote:
> > On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Devices with on-chip IOMMU or vendor specific IOTLB implementation
> >> may need to restore iotlb mapping to the initial or default state
> >> using the .reset_map op, as it's desirable for some parent devices
> >> to solely manipulate mappings by its own, independent of virtio device
> >> state. For instance, device reset does not cause mapping go away on
> >> such IOTLB model in need of persistent mapping. Before vhost-vdpa
> >> is going away, give them a chance to reset iotlb back to the initial
> >> state in vhost_vdpa_cleanup().
> >>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   drivers/vhost/vdpa.c | 16 ++++++++++++++++
> >>   1 file changed, 16 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index 851535f..a3f8160 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_allo=
c_as(struct vhost_vdpa *v,
> >>          return vhost_vdpa_alloc_as(v, asid);
> >>   }
> >>
> >> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
> >> +{
> >> +       struct vdpa_device *vdpa =3D v->vdpa;
> >> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >> +
> >> +       if (ops->reset_map)
> >> +               ops->reset_map(vdpa, asid);
> >> +}
> >> +
> >>   static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
> >>   {
> >>          struct vhost_vdpa_as *as =3D asid_to_as(v, asid);
> >> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa=
 *v, u32 asid)
> >>
> >>          hlist_del(&as->hash_link);
> >>          vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> >> +       /*
> >> +        * Devices with vendor specific IOMMU may need to restore
> >> +        * iotlb to the initial or default state which is not done
> >> +        * through device reset, as the IOTLB mapping manipulation
> >> +        * could be decoupled from the virtio device life cycle.
> >> +        */
> > Should we do this according to whether IOTLB_PRESIST is set?
> Well, in theory this seems like so but it's unnecessary code change
> actually, as that is the way how vDPA parent behind platform IOMMU works
> today, and userspace doesn't break as of today. :)

Well, this is one question I've ever asked before. You have explained
that one of the reason that we don't break userspace is that they may
couple IOTLB reset with vDPA reset as well. One example is the Qemu.

>
> As explained in previous threads [1][2], when IOTLB_PERSIST is not set
> it doesn't necessarily mean the iotlb will definitely be destroyed
> across reset (think about the platform IOMMU case), so userspace today
> is already tolerating enough with either good or bad IOMMU. This code of
> not checking IOTLB_PERSIST being set is intentional, there's no point to
> emulate bad IOMMU behavior even for older userspace (with improper
> emulation to be done it would result in even worse performance).

For two reasons:

1) backend features need acked by userspace this is by design
2) keep the odd behaviour seems to be more safe as we can't audit
every userspace program

Thanks

> I think
> the purpose of the IOTLB_PERSIST flag is just to give userspace 100%
> certainty of persistent iotlb mapping not getting lost across vdpa reset.
>
> Thanks,
> -Siwei
>
> [1]
> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78152e47=
fd@oracle.com/
> [2]
> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5473f1f=
2e@oracle.com/
> >   Otherwise
> > we may break old userspace.
> >
> > Thanks
> >
> >> +       vhost_vdpa_reset_map(v, asid);
> >>          kfree(as);
> >>
> >>          return 0;
> >> --
> >> 1.8.3.1
> >>
>

