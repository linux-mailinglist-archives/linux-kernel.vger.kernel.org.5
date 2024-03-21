Return-Path: <linux-kernel+bounces-109685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A9881C64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808371C214C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999703BBC4;
	Thu, 21 Mar 2024 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnj3gSKC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D4038DD8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001490; cv=none; b=C5x2jn3az7P00egmOAUvt3euai8inNpRUyWiyjt/H3g4AKuPtG87avcc4Cm0xP6IUfkMDyBfpMqgMVx3li2hmeTnAFmaSCLfqhWeRCdcJ+j1oYm4L2K+rAKNXtrcDHPNLxLXIaohAKegyYcTPNaG6gg0PitioIg6ScQ1EyxuPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001490; c=relaxed/simple;
	bh=nS3ZtkcmRWYQhNRSA+8PL8l9Y6ENrB3adeY74KvxwmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DA21OKHgBfo/OLSpIoHQzBjZRjIUippcyLw2znzywWEUTSGZrBolkTEzJIfKYQCPj8ZBSv8ZxKsbni32XCPw1H+nqnojpWQm+rkdSj7bEWPsBy5qbJmUl4hBzyg6dOzsjVBV93aIBH4GnDC54pK0XJW3HsQqYKvDf9l5f/TUWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fnj3gSKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711001488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRr6w2hmwgDNs0vVbChBiZJi7/+SS06endfvm4wx2Qo=;
	b=Fnj3gSKCpoqMi+J/qLoG4mutJ6TCkSFoipAWVdCPwrsCApjghLzWuZdOjb1rkk+nSHbQNs
	+L/kBlfIPigRH6+XLWVDDMQxTvAOSDbkBGtj8Q4eMv1ofBR3F9yQ0rN25cYtrV6rvlR2bp
	euyOPPy6nNxALW0B+fVe0SozEQZOvDs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-TwrdZiRxObKz6B--FM8uaA-1; Thu, 21 Mar 2024 02:11:25 -0400
X-MC-Unique: TwrdZiRxObKz6B--FM8uaA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29d7e7c0c7cso519025a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711001484; x=1711606284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRr6w2hmwgDNs0vVbChBiZJi7/+SS06endfvm4wx2Qo=;
        b=cXuSlC5DCuI2mrI8XDVJyvBtsa7WHj6HcivAbjOMbj3uUL3/9g1PBoOyf41LJiwGwa
         Vncto1ojzCUW8thW7llm57CmaJQoWQiJPdMAYtj6kQeMSI13tM6isSz81HRcKz+63QPx
         MSOBAZlzMLi8HL/bTHNdeB5mEjDq/NLQYaXIQRTMjaRCxiiKcWNjGejA6JB3PTOyENpo
         ZxZqDoV0TKu5gFpklZ4ilvY5gsflT7Z0JT4xD0s28gAuvAYAYzoOupNhEmuOECNe+c+S
         vA0rSclU8XHJwH5Zg7z6J1zYbfGAUIecwdTUzA4CJPF+STpp4CEAuEThpWjz4sbj92Vn
         0ocw==
X-Forwarded-Encrypted: i=1; AJvYcCUxmRkmSqg8Hkp/o2Cm5/xVOylDpQjhBfjii5lypMsqq3rf+g/xaftc7ehY7aDZ+YCHyIh/25MXS3Lm8zt75FWfauamOoqhZCF0Jbxo
X-Gm-Message-State: AOJu0Yym3ft8b3RARvLHk5vvWpDOfWYXs3L0izMnzSjen8fJIYgOwAJy
	Jzc9lIKfxpptBQOOQgdtcWY2boj6ENrllosVmnawQ4YlvV25OUymGNhFDeaTZkzqjXhLxfJTbhj
	12ot3cfXdf+2II6MyIPSikEBEnJRvCws9lraqmqWrs6S9QapNGcnO+ClxodlCegH21k9bVW651F
	yAx5KqdBcndLUom8HHYEmFRCxzzg/h1iXRpN5o
X-Received: by 2002:a17:90a:ee94:b0:29d:dd93:5865 with SMTP id i20-20020a17090aee9400b0029ddd935865mr6337695pjz.46.1711001484423;
        Wed, 20 Mar 2024 23:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMJs5m8yPCol1xvp4yJO6WcRnRdD98Sx8BFnN7+XFFZjVg6pV1bOfqeO7BXwqMn4EG2HGLFM86gzFGtPZgAf4=
X-Received: by 2002:a17:90a:ee94:b0:29d:dd93:5865 with SMTP id
 i20-20020a17090aee9400b0029ddd935865mr6337683pjz.46.1711001484139; Wed, 20
 Mar 2024 23:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com>
In-Reply-To: <20240320101912.28210-1-w_angrong@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 14:11:13 +0800
Message-ID: <CACGkMEst2ixZrtBUEWArQT+CkDqzSr9E3V7qMyVU6xX+FnBChA@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: Wang Rong <w_angrong@163.com>
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 6:20=E2=80=AFPM Wang Rong <w_angrong@163.com> wrote=
:
>
> From: Rong Wang <w_angrong@163.com>
>
> Once enable iommu domain for one device, the MSI
> translation tables have to be there for software-managed MSI.
> Otherwise, platform with software-managed MSI without an
> irq bypass function, can not get a correct memory write event
> from pcie, will not get irqs.
> The solution is to obtain the MSI phy base address from
> iommu reserved region, and set it to iommu MSI cookie,
> then translation tables will be created while request irq.
>
> Change log
> ----------
>
> v1->v2:
> - add resv iotlb to avoid overlap mapping.
> v2->v3:
> - there is no need to export the iommu symbol anymore.
>
> Signed-off-by: Rong Wang <w_angrong@163.com>
> ---
>  drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ba52d128aeb7..28b56b10372b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -49,6 +49,7 @@ struct vhost_vdpa {
>         struct completion completion;
>         struct vdpa_device *vdpa;
>         struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
> +       struct vhost_iotlb resv_iotlb;

Is it better to introduce a reserved flag like VHOST_MAP_RESERVED,
which means it can't be modified by the userspace but the kernel.

So we don't need to have two IOTLB. But I guess the reason you have
this is because we may have multiple address spaces where the MSI
routing should work for all of them?

Another note, vhost-vDPA support virtual address mapping, so this
should only work for physicall address mapping. E.g in the case of
SVA, MSI iova is a valid IOVA for the driver/usrespace.

>         struct device dev;
>         struct cdev cdev;
>         atomic_t opened;
> @@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
>  static int vhost_vdpa_reset(struct vhost_vdpa *v)
>  {
>         v->in_batch =3D 0;
> +       vhost_iotlb_reset(&v->resv_iotlb);

We try hard to avoid this for performance, see this commit:

commit 4398776f7a6d532c466f9e41f601c9a291fac5ef
Author: Si-Wei Liu <si-wei.liu@oracle.com>
Date:   Sat Oct 21 02:25:15 2023 -0700

    vhost-vdpa: introduce IOTLB_PERSIST backend feature bit

Any reason you need to do this?

>         return _compat_vdpa_reset(v);
>  }
>
> @@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(struct=
 vhost_vdpa *v,
>             msg->iova + msg->size - 1 > v->range.last)
>                 return -EINVAL;
>
> +       if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
> +                                       msg->iova + msg->size - 1))
> +               return -EINVAL;
> +
>         if (vhost_iotlb_itree_first(iotlb, msg->iova,
>                                     msg->iova + msg->size - 1))
>                 return -EEXIST;
>
> +
>         if (vdpa->use_va)
>                 return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->size,
>                                          msg->uaddr, msg->perm);
> @@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct ki=
ocb *iocb,
>         return vhost_chr_write_iter(dev, from);
>  }
>
> +static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, str=
uct device *dma_dev,
> +       struct vhost_iotlb *resv_iotlb)
> +{
> +       struct list_head dev_resv_regions;
> +       phys_addr_t resv_msi_base =3D 0;
> +       struct iommu_resv_region *region;
> +       int ret =3D 0;
> +       bool with_sw_msi =3D false;
> +       bool with_hw_msi =3D false;
> +
> +       INIT_LIST_HEAD(&dev_resv_regions);
> +       iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> +
> +       list_for_each_entry(region, &dev_resv_regions, list) {
> +               ret =3D vhost_iotlb_add_range_ctx(resv_iotlb, region->sta=
rt,
> +                               region->start + region->length - 1,
> +                               0, 0, NULL);

I think MSI should be write-only?

> +               if (ret) {
> +                       vhost_iotlb_reset(resv_iotlb);

Need to report an error here.

Thanks


