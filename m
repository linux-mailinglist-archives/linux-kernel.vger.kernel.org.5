Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7AE7AE78F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjIZILY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjIZILP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CA0FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695715822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Tq+OwDsnhYOE9KHhY3J8xr/2sMS7VG1riTR0pXydwI=;
        b=hXH089R6jTM375fqTvyndnOiBTGi6ZtGakcqzDpWy0neVX4gPVhzxpw+xvPZY6PLryHpUu
        1v8GIcZDyOtgdQz7VHY+SANf9V3LeJHNO7M6zARLRhg6FieJSKZlCV/hAcHxS1NIwVjRAy
        BWyuA/v9N63h6WtaXuHDRxBrT121yMs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-O2_jUzcMPE2P-9xgMGi5tg-1; Tue, 26 Sep 2023 04:10:20 -0400
X-MC-Unique: O2_jUzcMPE2P-9xgMGi5tg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32320b9d671so3312039f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695715819; x=1696320619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Tq+OwDsnhYOE9KHhY3J8xr/2sMS7VG1riTR0pXydwI=;
        b=Q9kjZ4UReP1RTwLhO/tuX13wwvxPMH77VR49KeQzVzJDWIApMkiXSWHvHv+TIlJrtu
         gtO7ekPSgY4v8jBvcVLbTZQfuOgrpfj2+MlMF4XH2JyJHxROp3qEYlD+Mjk+5er3r2VO
         56+EDHhMHzTEoogRkGJBFZOzVoMYRR8AsHiK9pR78LG992r5duWBbaJBO7VbvOal67KY
         K1F4yOU4ykZnzocIma1ovwDOpGjb76xcpQsyg+WQGk579/sfBja0T+hkK2/NRoWt5/ZO
         qwNX1t0nANeV5gi7TfaZzii3WL/BwCIjDqXY1ON9Vo9r+nvm8tVLjYcO13a0uSNyqjWd
         mVxA==
X-Gm-Message-State: AOJu0Yxv7MqQyzGuT+67NWBzbj8oWytUdzVLlEOh9Du3JQBEqsHn7lxj
        Yx4iOBtglgaBWTderbPTZHADzxbzwGCZKNhvlYMtBz0FBtw2589zndrh363TEzSu7CtDSY8/Zn0
        kgjbT4UrISTwElwTY3jIe3bzmpANW8rg79mWe+bWu
X-Received: by 2002:a5d:6b51:0:b0:31f:d95d:20a6 with SMTP id x17-20020a5d6b51000000b0031fd95d20a6mr7586937wrw.12.1695715819480;
        Tue, 26 Sep 2023 01:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsySNQKHkzRI2VVmJVtLzzf6l2Gixg5d681v+zNxkMLCHHomxDLUT0bVYKaTVsw5KZ4Y9yy5vzw8aqY5rOrtY=
X-Received: by 2002:a5d:6b51:0:b0:31f:d95d:20a6 with SMTP id
 x17-20020a5d6b51000000b0031fd95d20a6mr7586924wrw.12.1695715819194; Tue, 26
 Sep 2023 01:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20230923170540.1447301-5-lulu@redhat.com>
 <20230925134506.GB13733@nvidia.com>
In-Reply-To: <20230925134506.GB13733@nvidia.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 26 Sep 2023 16:09:41 +0800
Message-ID: <CACLfguUVK20JpSkqq0MybnVSqpBS6SbL=DazZscCiwU=q_SQ1A@mail.gmail.com>
Subject: Re: [RFC 4/7] vdpa: change the map/unmap process to support iommufd
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 9:45=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sun, Sep 24, 2023 at 01:05:37AM +0800, Cindy Lu wrote:
> > Add the check for iommufd_ictx,If vdpa don't have the iommufd_ictx
> > then will use the Legacy iommu domain pathway
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vdpa.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 91da012084e9..8d1ad89d4671 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -981,6 +981,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, st=
ruct vhost_iotlb *iotlb,
> >       } else if (ops->set_map) {
> >               if (!v->in_batch)
> >                       r =3D ops->set_map(vdpa, asid, iotlb);
> > +     } else if (!vdpa->iommufd_ictx) {
> > +             /* Legacy iommu domain pathway without IOMMUFD */
> > +             r =3D iommu_map(v->domain, iova, pa, size,
> > +                           perm_to_iommu_flags(perm));
> >       } else {
> >               r =3D iommu_map(v->domain, iova, pa, size,
> >                             perm_to_iommu_flags(perm));
>
> Um, why is the 2nd else the same as the new one?
>
the code here seems not in a good logic=EF=BC=8C I will try to optimize it =
in
the next version
Thanks
Cindy

> Jason
>

