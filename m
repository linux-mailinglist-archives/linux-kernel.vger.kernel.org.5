Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2000B7D47C1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjJXGx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjJXGxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A3792
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698130362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnCv+G93neJ+iTTfLV4dLwiSeZXfPaixO3SHIVGZX+k=;
        b=IjlAt9Qvztx4lsB9BvHtocKzdRvkE0bsGQoZXB+7rYYnErSkUpMXdy/ngkPnltUMXBMbyH
        lU90FKkZnpwlt2JcJf+ewDIZWRJPDrztduqPoht10pGurXaw4TXnymcnCvw2Vn5rCR0waQ
        xDATR05DaZgz9jMjmhBisuqnO6zfy8s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-dBMwt7qqNGWm6_nqvD9P0g-1; Tue, 24 Oct 2023 02:52:35 -0400
X-MC-Unique: dBMwt7qqNGWm6_nqvD9P0g-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5344aaf2703so2449847a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698130354; x=1698735154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnCv+G93neJ+iTTfLV4dLwiSeZXfPaixO3SHIVGZX+k=;
        b=NK6cUrnwWelbOS1TsSCHKUgtY2Yb4TpkKo6WrxmxW0bLGzyHsN0V0fEcVw8Z2E/YMn
         xCt5I2tu4dYTm3/HRmRp6XSHwYD9xbrSc3PeA7qz6B45Eil29SgPtlTCyqcBuSBh1iBS
         OxcGPsF2BkSDdyO0luIW/sdmYQ+vDEtRVa4SxYe24q/g/YHwR8mdxX2WbD1+wmkTucTA
         6OHtXMwKzrAEi6pDkue/uoe9c8NQFnJf4zg816csJGK/yZw865uKMU05Nr2ep6xtQGSf
         bF2qDwceZeUclLeRhWZemnO+sRh6uRLnje60AWkwTOmmbTiDeC/ezZaJeymMeHs4Ci0b
         DBaw==
X-Gm-Message-State: AOJu0YymlWis7tiUwr3q8ntwq7j2absJJkyd5UagpEVVJ/fMmC7j3SVD
        XDbJypiYWXmwyB7Gx/vAsPHDWu49QSnsTnUX6pLoYxBD+RzXjbd65yZlCc8sxbhiJew9nsCGvkf
        5zqZuLKTjoCBLIQcMsPaRc5t2Y2DQW3E6wxUjsWcE
X-Received: by 2002:a05:6402:510d:b0:53f:731a:e513 with SMTP id m13-20020a056402510d00b0053f731ae513mr8646625edd.25.1698130354362;
        Mon, 23 Oct 2023 23:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsWCnETG+7zp6SrPsIxQM2EKZaH7Gl3Rt1zMlO3YvwXykQRxizaPcJFuO8XSuzYjl5bQN6s+A6qZmc4b5nTII=
X-Received: by 2002:a05:6402:510d:b0:53f:731a:e513 with SMTP id
 m13-20020a056402510d00b0053f731ae513mr8646612edd.25.1698130354074; Mon, 23
 Oct 2023 23:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com> <4d03661b-4289-46e7-8760-32a186783b73@oracle.com>
In-Reply-To: <4d03661b-4289-46e7-8760-32a186783b73@oracle.com>
From:   Lei Yang <leiyang@redhat.com>
Date:   Tue, 24 Oct 2023 14:51:57 +0800
Message-ID: <CAPpAL=za9VKy2csCPKOKHEKe3qGDQ=89n_08G_MWd7XMiNpUvQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device reset
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        eperezma@redhat.com, sgarzare@redhat.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QE tested this series v4 with regression testing on real nic, there is
no new regression bug.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Oct 24, 2023 at 6:02=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/22/2023 8:51 PM, Jason Wang wrote:
> > Hi Si-Wei:
> >
> > On Sat, Oct 21, 2023 at 5:28=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> In order to reduce needlessly high setup and teardown cost
> >> of iotlb mapping during live migration, it's crucial to
> >> decouple the vhost-vdpa iotlb abstraction from the virtio
> >> device life cycle, i.e. iotlb mappings should be left
> >> intact across virtio device reset [1]. For it to work, the
> >> on-chip IOMMU parent device could implement a separate
> >> .reset_map() operation callback to restore 1:1 DMA mapping
> >> without having to resort to the .reset() callback, the
> >> latter of which is mainly used to reset virtio device state.
> >> This new .reset_map() callback will be invoked only before
> >> the vhost-vdpa driver is to be removed and detached from
> >> the vdpa bus, such that other vdpa bus drivers, e.g.
> >> virtio-vdpa, can start with 1:1 DMA mapping when they
> >> are attached. For the context, those on-chip IOMMU parent
> >> devices, create the 1:1 DMA mapping at vdpa device creation,
> >> and they would implicitly destroy the 1:1 mapping when
> >> the first .set_map or .dma_map callback is invoked.
> >>
> >> This patchset is rebased on top of the latest vhost tree.
> >>
> >> [1] Reducing vdpa migration downtime because of memory pin / maps
> >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
> >>
> >> ---
> >> v4:
> >> - Rework compatibility using new .compat_reset driver op
> > I still think having a set_backend_feature()
> This will overload backend features with the role of carrying over
> compatibility quirks, which I tried to avoid from. While I think the
> .compat_reset from the v4 code just works with the backend features
> acknowledgement (and maybe others as well) to determine, but not
> directly tie it to backend features itself. These two have different
> implications in terms of requirement, scope and maintaining/deprecation,
> better to cope with compat quirks in explicit and driver visible way.
>
> >   or reset_map(clean=3Dtrue) might be better.
> An explicit op might be marginally better in driver writer's point of
> view. Compliant driver doesn't have to bother asserting clean_map never
> be true so their code would never bother dealing with this case, as
> explained in the commit log for patch 5 "vhost-vdpa: clean iotlb map
> during reset for older userspace":
>
> "
>      The separation of .compat_reset from the regular .reset allows
>      vhost-vdpa able to know which driver had broken behavior before, so =
it
>      can apply the corresponding compatibility quirk to the individual
> driver
>      whenever needed.  Compared to overloading the existing .reset with
>      flags, .compat_reset won't cause any extra burden to the implementat=
ion
>      of every compliant driver.
> "
>
> >   As it tries hard to not introduce new stuff on the bus.
> Honestly I don't see substantial difference between these other than the
> color. There's no single best solution that stands out among the 3. And
> I assume you already noticed it from all the above 3 approaches will
> have to go with backend features negotiation, that the 1st vdpa reset
> before backend feature negotiation will use the compliant version of
> .reset that doesn't clean up the map. While I don't think this nuance
> matters much to existing older userspace apps, as the maps should
> already get cleaned by previous process in vhost_vdpa_cleanup(), but if
> bug-for-bug behavioral compatibility is what you want, module parameter
> will be the single best answer.
>
> Regards,
> -Siwei
>
> > But we can listen to others for sure.
> >
> > Thanks
> >
>

