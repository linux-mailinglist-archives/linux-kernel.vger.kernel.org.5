Return-Path: <linux-kernel+bounces-120235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02488D4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B9D300B89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00A921350;
	Wed, 27 Mar 2024 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NK00pjQp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080041CF92
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507322; cv=none; b=lFQP2fkg98Tpvvl4k02C428KxpUTCLtdDi8LtU2C+yvZ0y3+5zY4k4dPyCQCCzpog2Ku6Nj/0wGdl582HVwmj/T7MJ9vOGnAE124KYA7PNr64are7F3kyTomYQTkSHcztsq7xcjEp4phAqBpFEWEKYnHD8ub6K1MqZcP2FN9HwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507322; c=relaxed/simple;
	bh=axjOW/vY9e3o+PZdfzQ5WQAdCV1jLWhlfmMBoBEahCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNQ3bItkCQ0Mkgv+yaFslXa6fGwhFIhpCiL0/qEDH6iiR0etqebRj/p2O6Gk1GO7h6UQFrBdMYfZVpNkB5JHAz8/4QwVNqy6zErZp+tZLQuQ/JDwivOmTb9DHT52CcyrC15uVfnGYnSjv8O6QkOFwzX1z0LMyvi2jADpI1Li1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NK00pjQp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711507318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7kv7KXHkhOIlsVSgT9TYuMfAwXaBotnL9UfnoFbD78=;
	b=NK00pjQpOl9jWpvltwwxbvDqthB/xRW32i86SjPoDZF0eKyuc4A9iUIAUL3R0NzVO22jC3
	3jj4ej6xgJGdpmIZcig21kIpHEyi6kLJKBFq/xyTvgahdqnky2+MqXH2rUqRD0SBbP/4j1
	FZ5B5+hwhvVbSoqP/4nCmYeRT/NnJqs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-3cjBbWm1P76WZM9_hLkJ3w-1; Tue, 26 Mar 2024 22:41:57 -0400
X-MC-Unique: 3cjBbWm1P76WZM9_hLkJ3w-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ea815e1c1eso4217729b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711507316; x=1712112116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7kv7KXHkhOIlsVSgT9TYuMfAwXaBotnL9UfnoFbD78=;
        b=bwVOdQn1nl8vooEWFuFmTLAL7xVP9re022CAA2L5Kyc9xv8CAi2+6ZSwoxse1hfw9m
         4EI40fKhNoVua4jFaIbsrfjLoz/8O9toobSrcvaPUbSP0qtWx/eNGrsdGaURUPXzGf4V
         zS3CA2cPGaJmYSQovxxXvkG9hKwHNjr+1I4u8MNZFbF3tYs4h/ixDq0sXZprPPUrEphh
         lrvuYgUqJSvwz2KwtDPgxDYS6SikedDc25FEboQU0HiNtizAddj00f1kbkJ5nIjjh8Sz
         0Z95qItt2TIclOzXoqx2ME8aIBBZhqYtPezvzphVba9+uPQNxkbdx2Ox4WfkFc6yafnn
         yrJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpxF3wQEiRg8dTYkF9pMsYiza8CQsdkc5oPN4A7wJNv5QItQW77BBaIlqsVLg17n4h9smrPli5QQKqnid+567tiVfxKdotyw897MVl
X-Gm-Message-State: AOJu0Yz/joK7Hq+QCdEEX3zUzAnLNKRIyaHItm3G7sLXrzjhybqd+QTH
	MaXzmlej8EMB88h5D9qnGOWf17NbM/mk9hKziJg2c86lo1bo5QvYZQgEpFtv9vnlTCnjP0kkm4+
	2XLiC/eDE5gG4aMwtayXlH+l40+gAkJJnvfbBIO//hoSanKw8+Pk/eStJ1SsW7AFoyPz72PT2eZ
	2nocbmPWtYHF0ypoNykRl3uM51uRTN02SglgSq
X-Received: by 2002:a05:6a20:9147:b0:1a3:bdd9:3123 with SMTP id x7-20020a056a20914700b001a3bdd93123mr9985485pzc.9.1711507316002;
        Tue, 26 Mar 2024 19:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Z+wFgaV7C5ynBGBf1PskljLQf3sO3b8YmTi3SpnxiZuF/2uCdwLrbHKuf4QxtkJ9nf79f1L9OngqZAGf1cs=
X-Received: by 2002:a05:6a20:9147:b0:1a3:bdd9:3123 with SMTP id
 x7-20020a056a20914700b001a3bdd93123mr9985471pzc.9.1711507315720; Tue, 26 Mar
 2024 19:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326233846.1086253-1-gshan@redhat.com> <20240326233846.1086253-3-gshan@redhat.com>
In-Reply-To: <20240326233846.1086253-3-gshan@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 10:41:44 +0800
Message-ID: <CACGkMEsh8HguArBNUkxcZ74pWoZWOtfj2Zigenyt_Ehh7qf_YQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vhost: Add smp_rmb() in vhost_enable_notify()
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, davem@davemloft.net, stefanha@redhat.com, sgarzare@redhat.com, 
	keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:39=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrote=
:
>
> A smp_rmb() has been missed in vhost_enable_notify(), inspired by
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
> Add the missed smp_rmb() in vhost_enable_notify(). Note that it
> should be safe until vq->avail_idx is changed by commit d3bb267bbdcb
> ("vhost: cache avail index in vhost_enable_notify()").
>
> Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
> Cc: <stable@kernel.org> # v5.18+
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/vhost/vhost.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 00445ab172b3..58f9d6a435f0 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2847,9 +2847,18 @@ bool vhost_enable_notify(struct vhost_dev *dev, st=
ruct vhost_virtqueue *vq)
>                        &vq->avail->idx, r);
>                 return false;
>         }
> +
>         vq->avail_idx =3D vhost16_to_cpu(vq, avail_idx);
> +       if (vq->avail_idx !=3D vq->last_avail_idx) {
> +               /* Similar to what's done in vhost_get_vq_desc(), we need
> +                * to ensure the available ring entries have been exposed
> +                * by guest.
> +                */
> +               smp_rmb();
> +               return true;
> +       }
>
> -       return vq->avail_idx !=3D vq->last_avail_idx;
> +       return false;

So we only care about the case when vhost_enable_notify() returns true.

In that case, I think you want to order with vhost_get_vq_desc():

last_avail_idx =3D vq->last_avail_idx;

if (vq->avail_idx =3D=3D vq->last_avail_idx) { /* false */
}

vhost_get_avail_head(vq, &ring_head, last_avail_idx)

Assuming I understand the patch correctly.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>
> --
> 2.44.0
>


