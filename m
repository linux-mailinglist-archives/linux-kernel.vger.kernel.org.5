Return-Path: <linux-kernel+bounces-63850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08CC85357C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF931C22A44
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC9D5F551;
	Tue, 13 Feb 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA0fvuSp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25C5D914
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839975; cv=none; b=IctPBpOjOsAyJsKNtNEgRQx/Pj45iy+eqltyEJQzOeZ9IQw+r4OmcCuYF5yNAXlhMsYgiO8RwbB792AWEXyam15C2dARfjsa2mV5cf7ZOrqDcmFBMagk/OEEi2ypeWdEITJk19ZvZPnn57UjT0ZQC7NhW1fHuOOYEfmaOHBLgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839975; c=relaxed/simple;
	bh=gRbVmUln/eRZrMgBtMOu95Son0kYgWZtjC+yBqqnV8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPO5b8FzkCv6N0CIDNJjk8iWmRYZAH+j0PJ9T2PySGUctKQK++TcwBtMY7+AOdXC4XuNnyy8fRH9n6S7b3sg/Qr+7gqrT1ODqnNBMTO17z/4TSj4o0amK3fDxAcITTKJ4nmfoaPhfdm0L5MThtg5aa3txVccFp/q8pjWC08KyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YA0fvuSp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707839972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq4cGykM54m1GUbpNCYw0KR4tzCwjD4fijC17ReJiPw=;
	b=YA0fvuSpWkQXsHTZYb2/6JWmV/ZdkKWSQO2dQBkXdTNdH17K05vosWwjzLsj8WqKxImPAl
	85Di+fSqR7kP/yVapzeaXwcw/LQH8qrROrPOVAa2NSc9DoqXwo2fvcM3zb9R+Ex7pytM6Y
	WT+22rEwcnQqjroVnZEtyS7Hcaglu6Q=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-YhlK7PuWODqXJ-W0DBiFjw-1; Tue, 13 Feb 2024 10:59:30 -0500
X-MC-Unique: YhlK7PuWODqXJ-W0DBiFjw-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso817643276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839970; x=1708444770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zq4cGykM54m1GUbpNCYw0KR4tzCwjD4fijC17ReJiPw=;
        b=jTWhVpLr8xwCa6jbysJMEz7k/i7M9bLNFecRzP8gZoygy2pU9oT3HWl8sTyYXWXSe9
         btTiIGF2E/ueKFm3PNRakBGd7WbtYY3tLwfKbWHkchVIRj3jR0F9a/jbO7gmUsFRzJ04
         rZ/pgWAVaD75ekK+q9U/o+vJwnNcPJWXfooNpoIBIA/dyZ4VnpWnKO89TIdmrSHCdAKI
         fvBJXE2cSdCIykl9D91uzEeVK87ACX9x+0+Cts9IfIU/z+Y2Lirq3jeHLtuRHwEViwgn
         ilK9A4wlAK2jCTnbniFJZtSAsmX01vbKkOVnPeJQqe+hOqvaPjHtKqXCNh1vCCAy5J99
         4Rkg==
X-Forwarded-Encrypted: i=1; AJvYcCVtRLZAjMZIOY/xpe+yl4++Dp+ku/3Zt+rztKvP0tl8//Dk481Oa/yhOWjIhFj8div7fRuO7t2WPzun7LbfpkZKDsumbCKwfsYJtvhQ
X-Gm-Message-State: AOJu0YxUs/eg4dhvVU59dUhBnBhbYZ4EvKEmO84U4K0i3ZdtJV6fEOAX
	YBmLxG/xooT77n5xJLpGPg7tCOlykpm4RmgFaJk+KJ6ORX47uXTBDybsbHFKW3JmXjLkOMbulgK
	cr2u5S7SMLSElem59EOsGM/3B4W0HtZFvfGOH7UnySUfaPcyKr2Mr36mNN/pt2ORCenepfVFDRy
	BokgLtyDni7wbbdWBC/qdrBIlkS/Dce9dCZ/ji
X-Received: by 2002:a25:aba3:0:b0:dcb:d0cb:651e with SMTP id v32-20020a25aba3000000b00dcbd0cb651emr3678762ybi.28.1707839970283;
        Tue, 13 Feb 2024 07:59:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Y9tRkT/w76lYOCEDhwuuKmO/porv8bn7dSnKt/eWOytIXYIHSKWZ8ZDNwQxpijSKYEbz5UVnSKlp6/P0++k=
X-Received: by 2002:a25:aba3:0:b0:dcb:d0cb:651e with SMTP id
 v32-20020a25aba3000000b00dcbd0cb651emr3678746ybi.28.1707839970035; Tue, 13
 Feb 2024 07:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com> <1707758174-142161-2-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1707758174-142161-2-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 16:58:54 +0100
Message-ID: <CAJaqyWdOYHA21A2JUwnTmWfSro7H0ZTTTkkH7Ot9F8hwK+TKXw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] vhost-vdpa: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:16=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Flush to guarantee no workers are running when suspend returns.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Should this have a Fixes tag?

> ---
>  drivers/vhost/vdpa.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..a3b986c24805 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -594,10 +594,13 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v=
)
>         struct vdpa_device *vdpa =3D v->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         int ret;
> +       struct vhost_dev *vdev =3D &v->vdev;
>
>         if (!ops->suspend)
>                 return -EOPNOTSUPP;
>
> +       vhost_dev_flush(vdev);
> +
>         ret =3D ops->suspend(vdpa);
>         if (!ret)
>                 v->suspended =3D true;
> --
> 2.39.3
>


