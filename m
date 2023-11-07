Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045A37E3515
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjKGGLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjKGGLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:11:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51670110
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699337464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jy3AoTaEFtBC3Hdf9DK2P1sqM0oihORJcg/Y85jsjiM=;
        b=DBpv8t6jn7fitNkCmv1oXWJVTWGueQnEHDdhITTZVgmtdowoTjBwSX+IMYJjYgbF7VSTJ7
        Z6fw6cTubh8DZyeM5GHR3TCZgKWVr/HjJVU9QOWQeTp8fsHddO1tPCKG2dJBdYjOgfmAdN
        UMM7S9roWHUVHUZi+BVso0IjaOC4I5I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-1hofzyO7NA-DKJjw1uUGpg-1; Tue, 07 Nov 2023 01:10:51 -0500
X-MC-Unique: 1hofzyO7NA-DKJjw1uUGpg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c797b497e8so382229666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 22:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337450; x=1699942250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy3AoTaEFtBC3Hdf9DK2P1sqM0oihORJcg/Y85jsjiM=;
        b=gIyTGmOmVqrkKwyTzGElkA3BQ0A0uOyoUJU7BQUWj3l8DbRALULNe3l929E1O0XsYB
         1G7ye3DrxFzvQZs844Qk0DKL4wsD5xEoTmDa4km6+FCauK1i55eLVmTStZV67/9J54Gf
         4IWfuU81cB6vcxteQAuyCURCEG6TaDpdBSCdFcvmEPtxRoGFV7yT8UX/va3jz5AU/VGg
         B5WumM/+0CE2ha45jlT7joomLkzKgr3eOi7OCjnQdOQzHiKRu5cgqF//4CT5Fraq3cu7
         P3Tpl+ZE7/fWRFmi4IBVwHTcmmiWo4qGaEmUsQdr5mBRHd7ta9S48ZZrF2ZJRwTNm32I
         KNxg==
X-Gm-Message-State: AOJu0YwNXOCqX9HvDCA7kFrNMoMJyW1Q0GDF5Ep7Cf9O6fE1fq88ZSxK
        wdeyc08UzWMg0yEa92gj8piswSuz4TmWDbOA8njsmUAygpUzzGAi9k4dWLnIo5ylfP3gg6AbibW
        EAri12HZLyD8VSld/f1DHaLQBt4FdQf373bg51rC/
X-Received: by 2002:a17:906:c114:b0:9dd:6d39:42b9 with SMTP id do20-20020a170906c11400b009dd6d3942b9mr9767020ejc.55.1699337450461;
        Mon, 06 Nov 2023 22:10:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ146Ql2Vvi0xcjK7Z9omMZRxdZMLHLDq1ESNq6PfFahRy+ug99qPlbg3aZ0HTfKjKT8OIC8DWy3+ihFO68A8=
X-Received: by 2002:a17:906:c114:b0:9dd:6d39:42b9 with SMTP id
 do20-20020a170906c11400b009dd6d3942b9mr9767002ejc.55.1699337450164; Mon, 06
 Nov 2023 22:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-9-lulu@redhat.com>
 <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
In-Reply-To: <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 7 Nov 2023 14:10:11 +0800
Message-ID: <CACLfguUPZVY2HDBoir67u0CeR3A9wHjCGvuc3cGLe0L43f8jkg@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 3:26=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Sat, Nov 4, 2023 at 1:18=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Expose the function iommu_device_use_default_domain() and
> > iommu_device_unuse_default_domain()=EF=BC=8C
> > While vdpa bind the iommufd device and detach the iommu device,
> > vdpa need to call the function
> > iommu_device_unuse_default_domain() to release the owner
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> This is the end of the series, who is the user then?
>
> Thanks
>
hi Jason
These 2 functions was called in vhost_vdpa_iommufd_set_device(), Vdpa need =
to
release the dma owner, otherwise, the function will fail when
iommufd called iommu_device_claim_dma_owner() in iommufd_device_bind()
I will change this sequence, Or maybe will find some other way to fix
this problem
thanks
cindy


> > ---
> >  drivers/iommu/iommu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 3bfc56df4f78..987cbf8c9a87 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct device=
 *dev)
> >
> >         return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
> >
> >  /**
> >   * iommu_device_unuse_default_domain() - Device driver stops handling =
device
> > @@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct dev=
ice *dev)
> >         mutex_unlock(&group->mutex);
> >         iommu_group_put(group);
> >  }
> > +EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
> >
> >  static int __iommu_group_alloc_blocking_domain(struct iommu_group *gro=
up)
> >  {
> > --
> > 2.34.3
> >
>

