Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C205E77D7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbjHPBtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjHPBtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B238F10D1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692150498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVBkV5dzZAWODtzWnKoi2MILlBe8Jt7Xq72lWn3roK8=;
        b=QIVzJv+kbtkrsqgdPrdU1LU6VJu+6XuPWr/VKQCQ/Zln9vcI9q9Xs1OqpXR06HGSCk7lJd
        AeDeLPN5UEaYfnEgpjKfazNWFRaJfeL7v7uLZXmE2qwYkDXc2GiL6LYVhHEVyKFC8DCt21
        tgfhFVPxj054DaRnbayJx/UoYKoKIak=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-J2K2Fh8MO2uRaLnoQSUF0A-1; Tue, 15 Aug 2023 21:48:17 -0400
X-MC-Unique: J2K2Fh8MO2uRaLnoQSUF0A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe38a9f954so5511040e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692150496; x=1692755296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVBkV5dzZAWODtzWnKoi2MILlBe8Jt7Xq72lWn3roK8=;
        b=SRUC/Vxz5PqCxY58zMAWV2dOk7xuaHtmHifv8cSEXlgPYfFY2zYE/nTAUqXFOXgAgu
         WhpAjG04M2A5MEXyTnSU9xWcVIf3tUQ5HTPKCQRYbMaD27ifrbUxjRRjoCruBFfHWgDM
         M9jJkrOyK4JFyvgFcT8bbJtFaX89c6WfYO0dtSXyoehZcK9s/U6s9OPzR3P9hzbcwe+2
         1OStJpzTDBIzpFvdHkpx5Z0lzFq4oUmDVMl43S//flMGmxHAlAz/mJdZNR/pPSPJjnCg
         dhpvScsiXh5MQ0pYGtnrgwVxjdQ4wEqi2Nzt5ZzBpfQ87aIvnYzTUWzsCcsNwZi0QmYQ
         OkYA==
X-Gm-Message-State: AOJu0YzHNn35QbPjf+qbb0GNs7uj/bvzxAy/nnSccNy2IGwx8Fpolz4e
        xq/c8CP6OLlIuJ/n06+p+bIPUmVy+ngpS7PJ19Uu8XJ4MR38H0HtDLzzV7EmRbDnBj9kiINORaJ
        WdKJ1Mk5bHRMP3d8ssfsOHxPoBhEtwwHcLZBbO+0k
X-Received: by 2002:a05:6512:2342:b0:4ff:8fdd:4be4 with SMTP id p2-20020a056512234200b004ff8fdd4be4mr489604lfu.29.1692150495924;
        Tue, 15 Aug 2023 18:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjmh9t4DGDwhiZVL0/RxuMUJJONbpBOZnGAmz9am62b5NR3mpM4FTr9ke8hEnOR5xxPCekRv6EprWABGnAMAg=
X-Received: by 2002:a05:6512:2342:b0:4ff:8fdd:4be4 with SMTP id
 p2-20020a056512234200b004ff8fdd4be4mr489594lfu.29.1692150495563; Tue, 15 Aug
 2023 18:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com> <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com> <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
In-Reply-To: <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Aug 2023 09:48:04 +0800
Message-ID: <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
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

On Wed, Aug 16, 2023 at 6:31=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 8/14/2023 7:25 PM, Jason Wang wrote:
> > On Tue, Aug 15, 2023 at 9:45=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   drivers/vhost/vdpa.c             | 16 +++++++++++++++-
> >>   include/uapi/linux/vhost_types.h |  2 ++
> >>   2 files changed, 17 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index 62b0a01..75092a7 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -406,6 +406,14 @@ static bool vhost_vdpa_can_resume(const struct vh=
ost_vdpa *v)
> >>          return ops->resume;
> >>   }
> >>
> >> +static bool vhost_vdpa_has_persistent_map(const struct vhost_vdpa *v)
> >> +{
> >> +       struct vdpa_device *vdpa =3D v->vdpa;
> >> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >> +
> >> +       return (!ops->set_map && !ops->dma_map) || ops->reset_map;
> > So this means the IOTLB/IOMMU mappings have already been decoupled
> > from the vdpa reset.
> Not in the sense of API, it' been coupled since day one from the
> implementations of every on-chip IOMMU parent driver, namely mlx5_vdpa
> and vdpa_sim. Because of that, later on the (improper) support for
> virtio-vdpa, from commit 6f5312f80183 ("vdpa/mlx5: Add support for
> running with virtio_vdpa") and 6c3d329e6486 ("vdpa_sim: get rid of DMA
> ops") misused the .reset() op to realize 1:1 mapping, rendering strong
> coupling between device reset and reset of iotlb mappings. This series
> try to rectify that implementation deficiency, while keep userspace
> continuing to work with older kernel behavior.
>
> >   So it should have been noticed by the userspace.
> Yes, userspace had noticed this no-chip IOMMU discrepancy since day one
> I suppose. Unfortunately there's already code in userspace with this
> assumption in mind that proactively tears down and sets up iotlb mapping
> around vdpa device reset...
> > I guess we can just fix the simulator and mlx5 then we are fine?
> Only IF we don't care about running new QEMU on older kernels with
> flawed on-chip iommu behavior around reset. But that's a big IF...

So what I meant is:

Userspace doesn't know whether the vendor specific mappings (set_map)
are required or not. And in the implementation of vhost_vdpa, if
platform IOMMU is used, the mappings are decoupled from the reset. So
if the Qemu works with parents with platform IOMMU it means Qemu can
work if we just decouple vendor specific mappings from the parents
that uses set_map.

Thanks

>
> Regards,
> -Siwei
> >
> > Thanks
> >
>

