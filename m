Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E117E1B2F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjKFH1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKFH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:27:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD85191
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699255586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evSFj1U1p+Ny9gPIF1c5/6yqRIJ9hrTGuB8/aTR/hqw=;
        b=aa4PPyLHSLeWmM3nWbyRMwqqX04W9a+KcbN3yokCllH2rOACVLy4hj6JukpPbmd7iYQi5E
        wIJA7ACHuuOkN2Wd4AWgKg8LvLFHDGjbCEPtQ0U5asvxNQSLTVos4P5TLDdruadqfiNxia
        pN0pdELxKvH9HfEB6xamor/BFLdjc3Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-SpuGGZBGNCO3owzd-34ecA-1; Mon, 06 Nov 2023 02:26:25 -0500
X-MC-Unique: SpuGGZBGNCO3owzd-34ecA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c6ec02785eso40195321fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 23:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255583; x=1699860383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evSFj1U1p+Ny9gPIF1c5/6yqRIJ9hrTGuB8/aTR/hqw=;
        b=TIH+w0f0fJpCrSJ/yYCT3CCFH+2bgHLQ73a9Cg6afT8BVL8pLFJzT/FBBZH5Acxo1t
         nyGzUG9lFLFfLohZn7kgCXmIdNBuBznepmUeuykTO+FD5hAo4oisJ96VTSgkpUByJKeZ
         qMQbLPccY8uQv1x+wpeAAS3+oGGBkSl0w2gJM0po/IrEYHXqTu9pac98SbM6qLk+7meA
         AXfypmvuGs94zm2x6FWBHofJwhAjj73Toex5RMJI0UsWR5roQWgACx11qfSYG6ovmMPN
         +KauDsXPXc9adL4ueJRG/4RitahcMGq/YaeuEyjEWwlAyVt/Mikgj3IK1tURZBBcO59s
         UWKQ==
X-Gm-Message-State: AOJu0YyIWOFhJwxMI+82LoKZJY4mOaGB0tP4BsDqhoYCf8LntFR9Gtq/
        yQzYJySsx20aNQVGTnwPoIBXkbViq/I8hZ1iTkuGG9E7PL4GB9bcP2TRulURtK9ass+L0YfD7Rn
        C6p6GigIvp7yYK6bjDYDut9tVi60/xK2hr6IDe2id
X-Received: by 2002:ac2:4903:0:b0:507:9628:afb with SMTP id n3-20020ac24903000000b0050796280afbmr22045589lfi.68.1699255583632;
        Sun, 05 Nov 2023 23:26:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcZHQqKWdEULM3eBwn+4d0ZXxU5lMFxm0yiPC67W449u3K16MJzdZf96kxwAhxM88I6SzimJ/v/7HYurwI7AQ=
X-Received: by 2002:ac2:4903:0:b0:507:9628:afb with SMTP id
 n3-20020ac24903000000b0050796280afbmr22045574lfi.68.1699255583367; Sun, 05
 Nov 2023 23:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-9-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-9-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 6 Nov 2023 15:26:12 +0800
Message-ID: <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 1:18=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Expose the function iommu_device_use_default_domain() and
> iommu_device_unuse_default_domain()=EF=BC=8C
> While vdpa bind the iommufd device and detach the iommu device,
> vdpa need to call the function
> iommu_device_unuse_default_domain() to release the owner
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

This is the end of the series, who is the user then?

Thanks

> ---
>  drivers/iommu/iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3bfc56df4f78..987cbf8c9a87 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct device *=
dev)
>
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
>
>  /**
>   * iommu_device_unuse_default_domain() - Device driver stops handling de=
vice
> @@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct devic=
e *dev)
>         mutex_unlock(&group->mutex);
>         iommu_group_put(group);
>  }
> +EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
>
>  static int __iommu_group_alloc_blocking_domain(struct iommu_group *group=
)
>  {
> --
> 2.34.3
>

