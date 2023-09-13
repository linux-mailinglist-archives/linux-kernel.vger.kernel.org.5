Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A179EDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjIMQKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIMQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C33E7E54
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694621366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vir9XPxQtJjkx9y2t61YbcWIDMErIm3G1G2MRJnWHY=;
        b=T/6DDR8l2Qg+7AXWbxC+6NYHmATPhFbRgqnC53o9z+Lw5XCN9nmCLGC8a6zZb+pg4fDpEe
        OUQNbKOIIEDyK9L48r223hk4b7P6JoqHaH8XkPbepdDJpM26fE1OQF5/lf0SmeEmtOAXcD
        iLVdBP02VE+f2azi9/JQ3QBrJZoiTGM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-emMzzaQpPFK5g4OsU77x3A-1; Wed, 13 Sep 2023 12:09:24 -0400
X-MC-Unique: emMzzaQpPFK5g4OsU77x3A-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ab29aedbcbso8296217b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694621363; x=1695226163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vir9XPxQtJjkx9y2t61YbcWIDMErIm3G1G2MRJnWHY=;
        b=pCQ3Geyn+VPaadBgx+JgiPC1MVaAjP2UuI5yZ8hW5UbvdPY2ZghbQMkRZLSQEWycUT
         9s0PwXCaHL2nrcowdL+5GwbiqGU8yFfPPJ8iEI6ghSv8KUsorhS/I9AlsC+TonYOrMv5
         mUDTqPEcnSkbebIvIlgzZsEQNb5URiZjFlY28m/34GhzenWzHi0TBul3IUP1xhY/jIOK
         F/nQjOq6vwhEZRK4OPvkBp2l6f2TiyE9Hy5eifyhbwKweTAMeFC9zTrhzX8ontsfb3Lj
         uTVLTD2fOBN7GJhMofi2G3KKlDayXk4vmweByTQVpzt33tRqk1chXjjG+XT/bgiTq38P
         U3CA==
X-Gm-Message-State: AOJu0YyCgGHiA7MeEUi7iYCnmPlZr2tiyNoYNlABE1YUH4EjAQhlPfDH
        eu6IGRTW9FsT85Zvvk5fLxw2CM0t+LEyf++b8LEU7juseYgAYl2pXqf7+TMc25fVOf7JGVjDtj3
        oNBrzN6TiIUSgIdLDK0Ar30uMUoiQ6vmyXkRZewKh
X-Received: by 2002:aca:2102:0:b0:3a7:b5ea:f5e8 with SMTP id 2-20020aca2102000000b003a7b5eaf5e8mr3184293oiz.27.1694621363737;
        Wed, 13 Sep 2023 09:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7xa/Ps8ih1cpYFwfdNgaYAIRO8lM7v3v1vhDYf8Q+UuRA7mbI4UIywieN9ESmOr62otMmXGOb4OjZGxHnWa8=
X-Received: by 2002:aca:2102:0:b0:3a7:b5ea:f5e8 with SMTP id
 2-20020aca2102000000b003a7b5eaf5e8mr3184272oiz.27.1694621363522; Wed, 13 Sep
 2023 09:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com> <CAPpAL=w6KeBG5Ur037GNQa=n_fdoUwrFo+ATsFtX9HbWPHZvsg@mail.gmail.com>
In-Reply-To: <CAPpAL=w6KeBG5Ur037GNQa=n_fdoUwrFo+ATsFtX9HbWPHZvsg@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 13 Sep 2023 18:08:47 +0200
Message-ID: <CAJaqyWeVjKTPmGWwZ26TgebuzCaN8Z2FmPontHvZauOTQj0brQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] vdpa: Add support for vq descriptor mappings
To:     Lei Yang <leiyang@redhat.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 3:03=E2=80=AFAM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Hi Dragos, Eugenio and Si-Wei
>
> My name is Lei Yang, a software Quality Engineer from Red Hat.  And
> always paying attention to improving the live migration downtime
> issues because there are others QE asked about this problem when I
> share live migration status  recently. Therefore I would like to test
> it in my environment. Before the testing I want to know if there is an
> expectation of downtime range based on this series of patches? In
> addition, QE also can help do a regression test based on this series
> of patches if there is a requirement.
>

Hi Lei,

Thanks for offering the testing bandwidth!

I think we can only do regression tests here, as the userland part is
still not sent to qemu.

> Regards and thanks
> Lei
>
>
> On Tue, Sep 12, 2023 at 9:04=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.c=
om> wrote:
> >
> > This patch series adds support for vq descriptor table mappings which
> > are used to improve vdpa live migration downtime. The improvement comes
> > from using smaller mappings which take less time to create and destroy
> > in hw.
> >
> > The first part adds the vdpa core changes from Si-Wei [0].
> >
> > The second part adds support in mlx5_vdpa:
> > - Refactor the mr code to be able to cleanly add descriptor mappings.
> > - Add hardware descriptor mr support.
> > - Properly update iotlb for cvq during ASID switch.
> >
> > [0] https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-=
email-si-wei.liu@oracle.com
> >
> > Dragos Tatulea (13):
> >   vdpa/mlx5: Create helper function for dma mappings
> >   vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code
> >   vdpa/mlx5: Take cvq iotlb lock during refresh
> >   vdpa/mlx5: Collapse "dvq" mr add/delete functions
> >   vdpa/mlx5: Rename mr destroy functions
> >   vdpa/mlx5: Allow creation/deletion of any given mr struct
> >   vdpa/mlx5: Move mr mutex out of mr struct
> >   vdpa/mlx5: Improve mr update flow
> >   vdpa/mlx5: Introduce mr for vq descriptor
> >   vdpa/mlx5: Enable hw support for vq descriptor mapping
> >   vdpa/mlx5: Make iotlb helper functions more generic
> >   vdpa/mlx5: Update cvq iotlb mapping on ASID change
> >   Cover letter: vdpa/mlx5: Add support for vq descriptor mappings
> >
> > Si-Wei Liu (3):
> >   vdpa: introduce dedicated descriptor group for virtqueue
> >   vhost-vdpa: introduce descriptor group backend feature
> >   vhost-vdpa: uAPI to get dedicated descriptor group id
> >
> >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  31 +++--
> >  drivers/vdpa/mlx5/core/mr.c        | 191 ++++++++++++++++-------------
> >  drivers/vdpa/mlx5/core/resources.c |   6 +-
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 100 ++++++++++-----
> >  drivers/vhost/vdpa.c               |  27 ++++
> >  include/linux/mlx5/mlx5_ifc.h      |   8 +-
> >  include/linux/mlx5/mlx5_ifc_vdpa.h |   7 +-
> >  include/linux/vdpa.h               |  11 ++
> >  include/uapi/linux/vhost.h         |   8 ++
> >  include/uapi/linux/vhost_types.h   |   5 +
> >  10 files changed, 264 insertions(+), 130 deletions(-)
> >
> > --
> > 2.41.0
> >
>

