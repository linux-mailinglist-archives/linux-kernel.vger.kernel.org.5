Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9E783C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjHVIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjHVIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1CB1B2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692694498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpNZZm0xrOZji3+sFL4gaEKA2aO8eVbYxQuyUN3O8GQ=;
        b=RnT8NdUDC1Fs9z1fW+1BOl3s9QCtN3sQmNVOqCsvBTwoSffMb6d+ypCm9m+DeS/XCLxqCq
        B2KYTm/A4GFLzGtq7WJN93ROhjkzUF9ucO7oKqICQfBwN01guEXn+5xCSXx47karsA7MMs
        LJs+n1XhVEzwjcR7uGVAxMHr4zPrrQU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-4FgLMsqFPkyxfvb7WMh3eg-1; Tue, 22 Aug 2023 04:54:56 -0400
X-MC-Unique: 4FgLMsqFPkyxfvb7WMh3eg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b980182002so29640041fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692694494; x=1693299294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpNZZm0xrOZji3+sFL4gaEKA2aO8eVbYxQuyUN3O8GQ=;
        b=kxyRcpjbWbMzvcxyxuSeSndlu+ZKH+W9/4wO5DDVU7hFL3ZtiT9wP7ujGEoicDH5AA
         jZ5GJzl5sAe6inpdqJBkyn9JMyOUan/zCYB2jZqrszVyy2rLa4YeR/6WeJU2WpMoiUaM
         baW4NAMTR7HKFnx32uf1np212s9zUJeABE1X+1z+AlpmmfUrSqMddHkGGKO3OsZm6a1A
         pVfuB5bUGD3rdkWVlzVVWzn4386McSYOW9hUEVuKmIP0xiBUVw5UCGIltt3InPY7TOkX
         ihzFeqgeeXx2qCafXr2ROGqBnSIFlBpefcuUYuwK2wTaFhP+Pw469c39NS/wSHS1MRMp
         /m6Q==
X-Gm-Message-State: AOJu0Yw+tsCPLekCKVShhqKiJZ4xwtWjM7SfAOBaZKgBQGJ81CedJ21z
        YCqzghsVqjw+l5q7Lk4NJtTPKpHm+V32KSH0q9CLy4Ge+M56bIgyZlGIGol+87ACqNOOxxJPhDb
        bEjVsjWSd7ritX+LlsaIMllXN8u7ZageP+h0bYX9JQVs0LI4z1Lo=
X-Received: by 2002:a2e:90cd:0:b0:2bc:c052:25b4 with SMTP id o13-20020a2e90cd000000b002bcc05225b4mr1761820ljg.19.1692694494523;
        Tue, 22 Aug 2023 01:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsgvEvyPuN1nmaPQF0XF6UL0KXVvbjLrlQKHixu27C8/EN+LiH2p4Q7Ehyg4xJLpbfwhFF3ui+1btbYMHi5Z0=
X-Received: by 2002:a2e:90cd:0:b0:2bc:c052:25b4 with SMTP id
 o13-20020a2e90cd000000b002bcc05225b4mr1761812ljg.19.1692694494200; Tue, 22
 Aug 2023 01:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com> <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
 <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com> <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
 <9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com>
In-Reply-To: <9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 22 Aug 2023 16:54:42 +0800
Message-ID: <CACGkMEtNZnGw+O2PkZkCgOd+NiU3kw7asYsGH3EkuOHd=GvCnA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
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

On Thu, Aug 17, 2023 at 7:44=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 8/15/2023 6:48 PM, Jason Wang wrote:
> > On Wed, Aug 16, 2023 at 6:31=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 8/14/2023 7:25 PM, Jason Wang wrote:
> >>> On Tue, Aug 15, 2023 at 9:45=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>> ---
> >>>>    drivers/vhost/vdpa.c             | 16 +++++++++++++++-
> >>>>    include/uapi/linux/vhost_types.h |  2 ++
> >>>>    2 files changed, 17 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>> index 62b0a01..75092a7 100644
> >>>> --- a/drivers/vhost/vdpa.c
> >>>> +++ b/drivers/vhost/vdpa.c
> >>>> @@ -406,6 +406,14 @@ static bool vhost_vdpa_can_resume(const struct =
vhost_vdpa *v)
> >>>>           return ops->resume;
> >>>>    }
> >>>>
> >>>> +static bool vhost_vdpa_has_persistent_map(const struct vhost_vdpa *=
v)
> >>>> +{
> >>>> +       struct vdpa_device *vdpa =3D v->vdpa;
> >>>> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >>>> +
> >>>> +       return (!ops->set_map && !ops->dma_map) || ops->reset_map;
> >>> So this means the IOTLB/IOMMU mappings have already been decoupled
> >>> from the vdpa reset.
> >> Not in the sense of API, it' been coupled since day one from the
> >> implementations of every on-chip IOMMU parent driver, namely mlx5_vdpa
> >> and vdpa_sim. Because of that, later on the (improper) support for
> >> virtio-vdpa, from commit 6f5312f80183 ("vdpa/mlx5: Add support for
> >> running with virtio_vdpa") and 6c3d329e6486 ("vdpa_sim: get rid of DMA
> >> ops") misused the .reset() op to realize 1:1 mapping, rendering strong
> >> coupling between device reset and reset of iotlb mappings. This series
> >> try to rectify that implementation deficiency, while keep userspace
> >> continuing to work with older kernel behavior.
> >>
> >>>    So it should have been noticed by the userspace.
> >> Yes, userspace had noticed this no-chip IOMMU discrepancy since day on=
e
> >> I suppose. Unfortunately there's already code in userspace with this
> >> assumption in mind that proactively tears down and sets up iotlb mappi=
ng
> >> around vdpa device reset...
> >>> I guess we can just fix the simulator and mlx5 then we are fine?
> >> Only IF we don't care about running new QEMU on older kernels with
> >> flawed on-chip iommu behavior around reset. But that's a big IF...
> > So what I meant is:
> >
> > Userspace doesn't know whether the vendor specific mappings (set_map)
> > are required or not. And in the implementation of vhost_vdpa, if
> > platform IOMMU is used, the mappings are decoupled from the reset. So
> > if the Qemu works with parents with platform IOMMU it means Qemu can
> > work if we just decouple vendor specific mappings from the parents
> > that uses set_map.
> I was aware of this, and if you may notice I don't even offer a way
> backward to retain/emulate the flawed vhost-iotlb reset behavior for
> older userspace - I consider it more of a bug in .set_map driver
> implementation of its own rather than what the vhost-vdpa iotlb
> abstraction wishes to expose to userspace in the first place.

That's my understanding as well.

>
> If you ever look into QEMU's vhost_vdpa_reset_status() function, you may
> see memory_listener_unregister() will be called to evict all of the
> existing iotlb mappings right after vhost_vdpa_reset_device() across
> device reset, and later on at vhost_vdpa_dev_start(),
> memory_listener_register() will set up all iotlb mappings again. In an
> ideal world without this on-chip iommu deficiency QEMU should not have
> to behave this way - this is what I mentioned earlier that userspace had
> already noticed the discrepancy and it has to "proactively tear down and
> set up iotlb mapping around vdpa device reset". Apparently from
> functionality perspective this trick works completely fine with platform
> IOMMU, however, it's sub-optimal in the performance perspective.

Right.

>
> We can't simply fix QEMU by moving this memory_listener_unregister()
> call out of the reset path unconditionally, as we don't want to break
> the already-functioning older kernel even though it's suboptimal in
> performance.

I'm not sure how things can be broken in this case? Or why it is
specific to parent with set_map.

> Instead, to keep new QEMU continuing to work on top of the
> existing or older kernels, QEMU has to check this IOTLB_PERSIST feature
> flag to decide whether it is safe not to bother flushing and setting up
> iotlb across reset. For the platform IOMMU case, vdpa parent driver
> won't implement either the .set_map or .dma_map op, so it should be
> covered in the vhost_vdpa_has_persistent_map() check I suppose.

Just to make sure we are at the same page.

From the userspace point of view, the IOTLB persists and vhost-vDPA
doesn't reset the IOTLB during vDPA reset. But we have are two levels
of the coupling in other places:

1) Qemu level: memory listener is coupled with DRIVER_OK/reset
2) vDPA parent level: mlx5 build/destroy MR during DRIVER_OK/reset

If I understand you correctly, since we've coupled in 1), Qemu can't
be aware of whether the mapping is coupled with reset or not? If we
simply decouple in 1), memory mappigns might be lost during vDPA rset.

Thanks

>
>
> Thanks,
> -Siwei
> > Thanks
> >
> >> Regards,
> >> -Siwei
> >>> Thanks
> >>>
>

