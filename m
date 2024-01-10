Return-Path: <linux-kernel+bounces-21686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15478292C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7806F1F26779
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316746A2;
	Wed, 10 Jan 2024 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VnNPi8ES"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44A1FA6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28c23a0df1eso2062743a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704857281; x=1705462081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmHQeP0vkxtfvKhUYEtyUhBg1iWakI0fi5SAJQmRJk4=;
        b=VnNPi8ESSWzjOkf/BEcsKSlq+NmIkw06+WJONVn9ICEswQ+veIup2YsLTWbLeXk1aM
         5ec29kmnxzSZZsQxZlH16E4OUM04KfR4dOAov7Mglkg726ICvaPQX1ym6V3Dz4OjvUQ/
         jMl9wul5kW290oUrugx6zaWyTIpPTJfv/Dyk7WsM+wuOqbjueqsWcfCYt0NUhCExp5US
         XB/4UmqiYNBvzfg12JMouYzzCInMRJBQs0IFUjHjkV5w/TPF2PP/rVAuWH+zo15kOnMZ
         t9jXHDreuxsCiz2FxBDF2qQeJzwsR17lhrrvTHwTDF6ZBJ/footFQe+XmsfmVBqjcRqL
         k0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704857281; x=1705462081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmHQeP0vkxtfvKhUYEtyUhBg1iWakI0fi5SAJQmRJk4=;
        b=XOcRx1di+i4JGoeLB2NhLvePmmTPClsWedzsI44BtSgFkRR23VYgYjhARd1oDb3zS+
         dJ0g+MCZm9AhvSH3V6p3uFn53dSegidfb5dkFR5kpvOoALBqySxVkOFYOICSR37MsizR
         dcbGt6afYQb5qtrBbuHfbX202f5lrHHmcHQzyysGIbDah2uxQNF8V5Cq+oaLdQKL2nTy
         F+Aps5dTpxv2S1LIleX1fKGxTK6sStP1EEiz5iWLzueJJHSs8VdtfLIeD1ZVA9Xzflf6
         mGk83TdzGVjLKhmRyyoi+clMoPE1pKugLoIfu2Tux4OlLXKlZSqCtK5/JQ4nKxQJRZuh
         j48g==
X-Gm-Message-State: AOJu0YyGg2C1EbPuV2XWj1463GZVgk5nHHtSI6/UDbITVhbkaxubuW9m
	kcdVc6Jt9oHkk0FmHD/6/mHTlGnWyaIwzPLDk5uIOXM+5qtg
X-Google-Smtp-Source: AGHT+IF27DiaczlYFILU/RHYpoznkULFIUjMXHiMAHYqtzlVUZr2n4os6ENUCEt3jfhAxw20K/LutHE5YEYDJgy4qfQ=
X-Received: by 2002:a17:90b:117:b0:28c:7ca2:ee49 with SMTP id
 p23-20020a17090b011700b0028c7ca2ee49mr167498pjz.54.1704857281474; Tue, 09 Jan
 2024 19:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com> <20240109111025.1320976-4-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-4-maxime.coquelin@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 10 Jan 2024 11:27:50 +0800
Message-ID: <CACycT3sLjx1b9BjijP0ofM6OZkgRHk92VunGQcAweguBPzN1Dg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] vduse: enable Virtio-net device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, David Marchand <david.marchand@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:10=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch adds Virtio-net device type to the supported
> devices types.
>
> Initialization fails if the device does not support
> VIRTIO_F_VERSION_1 feature, in order to guarantee the
> configuration space is read-only. It also fails with
> -EPERM if the CAP_NET_ADMIN is missing.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 00f3f562ab5d..8924bbc55635 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -143,6 +143,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
>
>  static u32 allowed_device_id[] =3D {
>         VIRTIO_ID_BLOCK,
> +       VIRTIO_ID_NET,
>  };
>
>  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> @@ -1686,6 +1687,10 @@ static bool features_is_valid(struct vduse_dev_con=
fig *config)
>                         (config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)=
))
>                 return false;
>
> +       if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> +                       !(config->features & BIT_ULL(VIRTIO_F_VERSION_1))=
)
> +               return false;
> +
>         return true;
>  }
>
> @@ -1793,6 +1798,10 @@ static int vduse_create_dev(struct vduse_dev_confi=
g *config,
>         int ret;
>         struct vduse_dev *dev;
>
> +       ret =3D -EPERM;
> +       if ((config->device_id =3D=3D VIRTIO_ID_NET) && !capable(CAP_NET_=
ADMIN))
> +               goto err;
> +
>         ret =3D -EEXIST;
>         if (vduse_find_dev(config->name))
>                 goto err;
> @@ -2036,6 +2045,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtd=
ev_ops =3D {
>
>  static struct virtio_device_id id_table[] =3D {
>         { VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
> +       { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
>         { 0 },
>  };
>
> --
> 2.43.0
>

