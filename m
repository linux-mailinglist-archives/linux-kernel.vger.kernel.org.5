Return-Path: <linux-kernel+bounces-120221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4E88D495
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BAFB2208A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A8420B0F;
	Wed, 27 Mar 2024 02:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQZ9I7vK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A94208B6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506893; cv=none; b=cFKFfzt8yggmp1YVdRR7bzz73YvgIQz7U2PUZG30dE6D0tiv9LZis0/SYhHoKs9dlpOxigt7Mh9P+DjXwsBkYSn5R5gmznzwMq9QLWRM26nlbylI21Au0D3cb2W+IoUqaQdHuxewT/om/2BbSxrzfFVl+m9Dbm1Lyd0fSIPRco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506893; c=relaxed/simple;
	bh=Qqzod6RnevlfYYey7LaLzZkHboMKdV2B1HONW9tD7FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6vsKw1nibt9Wt9D2ffGuf8D92JMms/HnwSQBDLS+k0f4ABK2APxt8wavhUE4r+C1WMehZxWYQr64tO0bTwzybdZdWzOSMs5sdBP9C/IVEyGWuWXWkD1qkyMLsMrzLqHL1kC3BBUJ2qpn/nZS3SsMEC27jBNG9fXqg7VGtkaQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQZ9I7vK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711506890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daSGAK1vKPtHioOKtIUSXnIE1GcZiKLKNEvMx3yD3SY=;
	b=CQZ9I7vKqA3gz2V2gufK2nZNsFtkT2n7pkiy+fkloKTJzZJTWg0lnPgBrrCXBfK43RwMXg
	b/6n8BNbQJwsJ2xtTCivHIrLhlTX6apiKgIjZ8nGu7lxlLFVcgBDIVcxz/u11Fpv+8Ekvr
	YA5ZyZRG5cjwQdbm8OUHAIXRoT/3xvg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-p8nkgPYqOLGc5qGCQMypnA-1; Tue, 26 Mar 2024 22:34:47 -0400
X-MC-Unique: p8nkgPYqOLGc5qGCQMypnA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e6c5b1377fso335968b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506886; x=1712111686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daSGAK1vKPtHioOKtIUSXnIE1GcZiKLKNEvMx3yD3SY=;
        b=KfUaNScR2XufMbwCy4C5rvO6xDDJMJVp/oF03CT4MVhkzPGJVC4uwk1cVVcyPiyaTP
         tdkiZllcvnGxx1GVl7baEBsBoBFxYF5UXqumS484iemnUL/rnfIUJrH0lP4Ae/h4DbI3
         SGn5ay199Qi2ts+nC92Whvatczij/zwJX5Ss/FQAR/xYvL+Jhp4oAqNAZXW9AZ1KTxtl
         4WaXnICi6GKZY+RxmgqOGukAf4wNyw/3s3Zrr5mJLGz9POmgHvz2FLdp0FzxYLMjLH0T
         tykg0uUlQmdWvAGX2XM7xMYQ40qynLkdbfYCEwPjveyVJWYJVOt5UnMM3o2fXJ/O8l9I
         RZEg==
X-Forwarded-Encrypted: i=1; AJvYcCVSdkhUBNAj8U23r98hQGqqgbbhdlg302Ks7Th06/Dy4W6GeGUQgbRHZCek+I6k6uGXgm7RgadC+nwoNCRIz55GBZu/iy0Hp9d+pm3T
X-Gm-Message-State: AOJu0YwJFniN+0zKQxYp1c0+T7t1Ww7cN/UoUtvKo9msdmcB1T7/i8nu
	70+O6G59RER9mEYuH+sVh+83QZg+UkeBpzEM5UTL6DTo/69HC8yrwcL19yWY/BUIaXiSduMQov7
	S+jfgyqBz33ggreLzuBdnhN55io0bFMdrB+YKHeG18aDX6PyfgWzUX3OGh1Tt0xov71vD4EcUae
	iZPwgCggpdwC6t3pffNgE9jzp4vq73GeP9HSJD
X-Received: by 2002:a05:6a20:4325:b0:1a3:c6aa:ec7d with SMTP id h37-20020a056a20432500b001a3c6aaec7dmr4759159pzk.16.1711506886128;
        Tue, 26 Mar 2024 19:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2D17wf0XSecst4P0/CFvwY7g59bOHZlulOhr1pJevDkqh9TDzQlOYW1mV3flIFMZC5OA53NXcrZin2v4MLZU=
X-Received: by 2002:a05:6a20:4325:b0:1a3:c6aa:ec7d with SMTP id
 h37-20020a056a20432500b001a3c6aaec7dmr4759138pzk.16.1711506885767; Tue, 26
 Mar 2024 19:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326233846.1086253-1-gshan@redhat.com> <20240326233846.1086253-2-gshan@redhat.com>
In-Reply-To: <20240326233846.1086253-2-gshan@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 10:34:34 +0800
Message-ID: <CACGkMEtyEo2QQSEh0ZnZDUJSXMMhzeO97Jp0wF4_rhzUBGk4Zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, davem@davemloft.net, stefanha@redhat.com, sgarzare@redhat.com, 
	keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:39=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrote=
:
>
> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
> available ring entries pushed by guest can be observed by vhost
> in time, leading to stale available ring entries fetched by vhost
> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
> grace-hopper (ARM64) platform.
>
>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>   -accel kvm -machine virt,gic-version=3Dhost -cpu host          \
>   -smp maxcpus=3D1,cpus=3D1,sockets=3D1,clusters=3D1,cores=3D1,threads=3D=
1 \
>   -m 4096M,slots=3D16,maxmem=3D64G                                 \
>   -object memory-backend-ram,id=3Dmem0,size=3D4096M                \
>    :                                                           \
>   -netdev tap,id=3Dvnet0,vhost=3Dtrue                              \
>   -device virtio-net-pci,bus=3Dpcie.8,netdev=3Dvnet0,mac=3D52:54:00:f1:26=
:b0
>    :
>   guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>   virtio_net virtio0: output.0:id 100 is not a head!
>
> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
> should be safe until vq->avail_idx is changed by commit 275bf960ac697
> ("vhost: better detection of available buffers").
>
> Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
> Cc: <stable@kernel.org> # v4.11+
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/vhost/vhost.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..00445ab172b3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, s=
truct vhost_virtqueue *vq)
>         r =3D vhost_get_avail_idx(vq, &avail_idx);
>         if (unlikely(r))
>                 return false;
> +
>         vq->avail_idx =3D vhost16_to_cpu(vq, avail_idx);
> +       if (vq->avail_idx !=3D vq->last_avail_idx) {
> +               /* Similar to what's done in vhost_get_vq_desc(), we need
> +                * to ensure the available ring entries have been exposed
> +                * by guest.
> +                */

We need to be more verbose here. For example, which load needs to be
ordered with which load.

The rmb in vhost_get_vq_desc() is used to order the load of avail idx
and the load of head. It is paired with e.g virtio_wmb() in
virtqueue_add_split().

vhost_vq_avail_empty() are mostly used as a hint in
vhost_net_busy_poll() which is under the protection of the vq mutex.

An exception is the tx_can_batch(), but in that case it doesn't even
want to read the head.

Thanks


> +               smp_rmb();
> +               return false;
> +       }
>
> -       return vq->avail_idx =3D=3D vq->last_avail_idx;
> +       return true;
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
>
> --
> 2.44.0
>


