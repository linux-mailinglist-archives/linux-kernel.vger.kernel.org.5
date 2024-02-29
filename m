Return-Path: <linux-kernel+bounces-86226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41386C268
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F581C2048B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C434E47F4B;
	Thu, 29 Feb 2024 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDC7cpTV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B144C93
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191313; cv=none; b=bmAczYmaP3n7bjK3MwbMvIJv6jupss5eqq3tcFMbWf5zOaIAvi4U2XO5PpbgdtzHsLbyfOg3KEWAgPkIiz0yIdytDc36CD8JSjCujABaSiLxhyvgNZLR/q9NOpevhmfg68DH3iYZljqfiQQHpL59+xbU5OBsAWk00clpCTAWgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191313; c=relaxed/simple;
	bh=HqknOjEjlYxT7iVdqKOIUCiHsRYWnF8WRHrWHM7BaNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux4oCx6O9SyHDOu5mAvFmZJo5ZGQX5w2lydEfNRlJbe+kDS/Y6fz3qj5etXZHnAG+Aa6NCjXMANdlMuW/Bpok8LSyL4Psc87TA4q+ZzZ+ST/mwmvjvhkmcSf0gxr8tcuMSd3E4tTuubkKACpnlnS7zp3AkbzH4ib5On+AOeVFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDC7cpTV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709191309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Net7WSZ0SLXfX6qP1fBqoZy/fUubtzc+/J9dRqSPBjo=;
	b=fDC7cpTVoJEkDtSKX4a6Cy5yRamTE6hfRcna+b+TJnvQDptMLdBce22lV1Mcs5NM51NntB
	KWIobSkp/b+ZodBBGRnpfumwEXbtpiOqcps73QyXjP208uN5h2ZFJd7uUZ5RXMX8AtMtH9
	P7bg/z8lMN2Le4IVWkmM9iXpQm9BqMQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-LypiVx6OPEGkPiIHIs8QJg-1; Thu, 29 Feb 2024 02:21:47 -0500
X-MC-Unique: LypiVx6OPEGkPiIHIs8QJg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4454ff9a70so4750266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709191306; x=1709796106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Net7WSZ0SLXfX6qP1fBqoZy/fUubtzc+/J9dRqSPBjo=;
        b=SjTgnSR3TKcMkeCNXlSdPZiLuUcdhqn4GYbFkUzfJjO42t2PMt51dMFEJJkO+g8KV6
         qrNI46pgGTayMac7iTZbCr81qshK+IZ1no5FR5ARA81t/vosaDJUdHS5u+bz4Ql38nPg
         OVP8v6jsePY2MJbIl4ParHgot+8/TmXkxzow5mT7V1myFyldEiOo3wa9DaXm9Jr+XSnh
         fd5wpC2bT4vswNpY+WFRlCpRlKUcEG70s/rrAl2g1RIEnPRCvgmJ8fbCvhbGy4ney6hS
         D/t1VLITafEX2WDA2PJrCiIUOLZ581f5F8cjCV8K/OK63Lr2xZCwvnzjmbsuADN4PaLp
         y7rA==
X-Forwarded-Encrypted: i=1; AJvYcCUzoJlou9rm+kYi9CBkeOLsFbEf3ukFM2k8VeIIQBQK+alhJLpb83zZcWjy0yPtZrVVfnfeglDft4qkhDl7UcYLgmEaNtqBJncWw1IO
X-Gm-Message-State: AOJu0Yzz4i4JN00Q/4jBCIVS0TCGfi69cRwD2t35NHGiApL3PYprd4oa
	f9L7CeyE7hShOsrGVLEbwibW+n7rnJWJk3nKOEVaLB0xp32zwX4isFKLUWBiqBgMVHXAEvJds0V
	nlHQNgOB22nBsT1mjZMfbv2sxrz8UuTvo5X/o91jyDKN+fVdp58cJ0wjWyy17syA+Ff+phBZFjF
	XQTSduqONQSitvQWQik9a49Pqg5KmbRD6LmMBc
X-Received: by 2002:a17:906:f848:b0:a3f:d71d:d820 with SMTP id ks8-20020a170906f84800b00a3fd71dd820mr688218ejb.26.1709191306659;
        Wed, 28 Feb 2024 23:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR1+8q9qhWcpHCQv9NfHXzSbTJvOggAWbOmIh8P8wUWatZVIF7qiSuP0cDF+Mqh1M4VO49hebtH0JZ7m1N8oM=
X-Received: by 2002:a17:906:f848:b0:a3f:d71d:d820 with SMTP id
 ks8-20020a170906f84800b00a3fd71dd820mr688204ejb.26.1709191306393; Wed, 28 Feb
 2024 23:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain> <CAJSP0QWW2QvibpcrZbcLzVp8ngnooiTqP8i2emd+0sdCj_7Yww@mail.gmail.com>
In-Reply-To: <CAJSP0QWW2QvibpcrZbcLzVp8ngnooiTqP8i2emd+0sdCj_7Yww@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 29 Feb 2024 15:21:09 +0800
Message-ID: <CACLfguXksa4TEb5gk2bvoeGaQrR8s5TZMJGzR0r7Y9Wo9N82UQ@mail.gmail.com>
Subject: Re: [PATCH v3] vduse: Fix off by one in vduse_dev_mmap()
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:19=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Wed, 28 Feb 2024 at 13:24, Dan Carpenter <dan.carpenter@linaro.org> wr=
ote:
> >
> > The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> > vduse_dev_init_vqs().  Thus, this > comparison needs to be >=3D to avoi=
d
> > reading one element beyond the end of the array.
> >
> > Add an array_index_nospec() as well to prevent speculation issues.
> >
> > Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: add array_index_nospec()
> > v3: I accidentally corrupted v2.  Try again.
> >
Thanks for fix this
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by:  Cindy Lu <lulu@redhat.com>
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index b7a1fb88c506..eb914084c650 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, str=
uct vm_area_struct *vma)
> >         if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
> >                 return -EINVAL;
> >
> > -       if (index > dev->vq_num)
> > +       if (index >=3D dev->vq_num)
> >                 return -EINVAL;
> >
> > +       index =3D array_index_nospec(index, dev->vq_num);
> >         vq =3D dev->vqs[index];
> >         vaddr =3D vq->vdpa_reconnect_vaddr;
> >         if (vaddr =3D=3D 0)
> > --
> > 2.43.0
> >
> >
>


