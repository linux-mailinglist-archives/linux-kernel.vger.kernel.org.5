Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0337E50C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjKHHG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjKHHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C837C10D3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699427165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DUoSm2Iv7a2UwdhQ6s1wKH58JFgFQEsPFOv1WpRND8=;
        b=dTDQeetoi/ggUfDJTKRydosCP726A1B1Eh4BLqnRtwR5lAjYHIyWFuxi5rSDuirdhO15Rp
        73lZYg+KZsqw3NmXtK1HBR4SCZ1K7iRgVJDfbbcITGPYXSLyG4nHHP9gpxX5DbqBXoiHis
        bnKR64Axh2a7XrwdCCIdfiTZOAP2d0g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-hvAW0-4WNAyDnslhmNnCuQ-1; Wed, 08 Nov 2023 02:06:04 -0500
X-MC-Unique: hvAW0-4WNAyDnslhmNnCuQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9d2606301eeso60407566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 23:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699427163; x=1700031963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DUoSm2Iv7a2UwdhQ6s1wKH58JFgFQEsPFOv1WpRND8=;
        b=iU1aWPUVngcQT+3xJRiVKsdPjaiBZI5aagbnNe8kZd8s45CD3A+gJj+QGNid/eGFV3
         lHHc3cwYqS5JJRY51FKF4PaNlcnmJrYPU8rTH4HAOdLX0hA2K7g2BVErMS6JYAYG7KZu
         hBQCkM5kOf6Sz/G7HAc8zGyfS+bi3I3zOg4Qrfz4AGYBSH+PCv51QYm0XNILrupMeRUV
         ePsg0SbsvFkObLJaQ0lt7Fde3zecfNI/sypcZ4NNIkmzWAB77iduiI58pYiMV5++J4cm
         KtuH18ZHbR1KqKdB+vESGndV13z4qFK/8jnXLuAoC5PytIHUnn22bErddNyk8Sg3HiEa
         YpnA==
X-Gm-Message-State: AOJu0YwxVRdUJILL2D0nVglF6OIwNbrnQi+fIGnA2HlskI9uQnrmx9BK
        dBQixGCIOcxlMzjm7L4HQ1ApbS/F8HwRS7Ifrka1ORhbRKyegfGhkXALeEM4ulZg7ecT+dIYHoy
        aqA/ZhFGMmq/DpzlDd+6ZuJ2Usl4lkqtGTHOLDdeK
X-Received: by 2002:a17:906:51d1:b0:9dd:be2b:34ea with SMTP id v17-20020a17090651d100b009ddbe2b34eamr4377394ejk.31.1699427163089;
        Tue, 07 Nov 2023 23:06:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDM7EhI+swyyvkDM3u6Pfk6QmXHKd/4wym/b/QMJOFFCkjCTPCMaznbGWByhlORtrmXpffeg/s+KQz4nYEGw8=
X-Received: by 2002:a17:906:51d1:b0:9dd:be2b:34ea with SMTP id
 v17-20020a17090651d100b009ddbe2b34eamr4377383ejk.31.1699427162806; Tue, 07
 Nov 2023 23:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-9-lulu@redhat.com>
 <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
 <CACLfguUPZVY2HDBoir67u0CeR3A9wHjCGvuc3cGLe0L43f8jkg@mail.gmail.com> <CACGkMEuA3jg06s9wuxTL60geFm6+nnbEnYXvv8HhTgXoFHyJgQ@mail.gmail.com>
In-Reply-To: <CACGkMEuA3jg06s9wuxTL60geFm6+nnbEnYXvv8HhTgXoFHyJgQ@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Wed, 8 Nov 2023 15:05:24 +0800
Message-ID: <CACLfguVny1MEOddJiQG4x5RWhxwF2OdzVtKcN3kVGtMP-2XXDQ@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 11:04=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Nov 7, 2023 at 2:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Mon, Nov 6, 2023 at 3:26=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Sat, Nov 4, 2023 at 1:18=E2=80=AFAM Cindy Lu <lulu@redhat.com> wro=
te:
> > > >
> > > > Expose the function iommu_device_use_default_domain() and
> > > > iommu_device_unuse_default_domain()=EF=BC=8C
> > > > While vdpa bind the iommufd device and detach the iommu device,
> > > > vdpa need to call the function
> > > > iommu_device_unuse_default_domain() to release the owner
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >
> > > This is the end of the series, who is the user then?
> > >
> > > Thanks
> > >
> > hi Jason
> > These 2 functions was called in vhost_vdpa_iommufd_set_device(), Vdpa n=
eed to
> > release the dma owner, otherwise, the function will fail when
> > iommufd called iommu_device_claim_dma_owner() in iommufd_device_bind()
> > I will change this sequence, Or maybe will find some other way to fix
> > this problem
> > thanks
>
> I meant exporting helpers needs to be done before the real users.
>
> Thanks
>
sure will fix
Thanks
Cindy
> > cindy
> >
> >
> > > > ---
> > > >  drivers/iommu/iommu.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index 3bfc56df4f78..987cbf8c9a87 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct de=
vice *dev)
> > > >
> > > >         return ret;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
> > > >
> > > >  /**
> > > >   * iommu_device_unuse_default_domain() - Device driver stops handl=
ing device
> > > > @@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct=
 device *dev)
> > > >         mutex_unlock(&group->mutex);
> > > >         iommu_group_put(group);
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
> > > >
> > > >  static int __iommu_group_alloc_blocking_domain(struct iommu_group =
*group)
> > > >  {
> > > > --
> > > > 2.34.3
> > > >
> > >
> >
>

