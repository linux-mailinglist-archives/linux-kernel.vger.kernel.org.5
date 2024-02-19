Return-Path: <linux-kernel+bounces-70634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732C859A55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19483B20CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 01:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E019C15C9;
	Mon, 19 Feb 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfdZCCep"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D3394
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708304972; cv=none; b=Ob2eexRNo3HtIGQgyW2RlOxK3LVeOq3yvYlyP77a0q/ruC0oeKiyBfefX+WxCZ2Ib1NPsT1sTM/V7t1vbSwiKb9/HgGoyn/5aK+KF9CB2706Mu9pnOP2DNphNXLyYwU0rcArSlH+T6FWSPhAPYgJ1uh55pW0ArzQ2vBqpeAdMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708304972; c=relaxed/simple;
	bh=kPxrv7W2yIJaZMQ1+gJwIp+HhCy5zI4R+ySZbaEIjB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvRcX/QiFKAvytaF4lEbzA39n8C4OtgE3NRIa9luv2AUtpufV5QQin4Sc+/lQ3/EKe4NccIPtKYUfGI9W7ce/io+3uq+7GPOMW1qL5kL2EGclC0QrSeVRHpJlwEpPuISJloVMxkHb7+rEf+hkYJ3FiWAnlIPmhtGpWVRi0fCeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfdZCCep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708304968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FH/IGXGIzL7Qe7et2w95vW7pDGEVjgey8bcDbORJ2E=;
	b=EfdZCCepdH+RIe/qlCg/m3IZp88mWb0PvIemUavhiNVu4iupg+ha9M1ROCcZs+0ObGzWpO
	K/HpuFChipDmPEwAPD5BjoV2uQEOqY531wGmA+GXASJGoQQvncLba8mL3sqDAN+wBKZfhO
	fNeVLHiTE2RI6kwRRsErvpEcIt4LQOQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-DemtSNUPO0KmZX02HTgBVA-1; Sun, 18 Feb 2024 20:09:26 -0500
X-MC-Unique: DemtSNUPO0KmZX02HTgBVA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5647132e2aeso212432a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708304964; x=1708909764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FH/IGXGIzL7Qe7et2w95vW7pDGEVjgey8bcDbORJ2E=;
        b=YMU7r94kyPpqv2wSdbRrOEBqn9tSh3QdaE3xw2W4YDUlo5MLcRLdKHNBLLAssBU0e8
         WraXpcjBzvdzie6U75zZxBrcNFOijPxI9g06zcjPwsJZCwDzoaOOHClLLbIHyCOwzM3z
         GcbVpfvG4Q0+X1IcT0mxrqAY7bev+X6iR8/i6On1PuPleLZ47/UbdSeijL8HduwykKgw
         Qfgd0/Q3M+jmPJClPMiDy3EQdNrlGTWuIHiMgrI1W9EKbTuHrN/GJaH+zPziAl3ohilg
         TwwXBmXGBb+cq5yBsMtxMD0yBDQqMpZUqRZFoXUY13eNrCQffvXRiIWDINuulBJ8HmmX
         xGWw==
X-Forwarded-Encrypted: i=1; AJvYcCX2vLcxaLZxRLL747cbjC24sMVl592OrclhHqOQsPYWWMRPy7GdpQOPrpgewnr6rs1jFiD2esBAv83kzq+gICqBl2GGeGTPvSBOLt+Q
X-Gm-Message-State: AOJu0YxyLWxepY8jINDnKciEoLoJpLAqAWFm6kgY5k/O6cOiEtkskPk0
	UDJarmH7T/dpx0SmoB7PHhmsdv9HAsln31Zhq/DcBFShA1RFEZNalMbYE8fMS6D29oe18PUJxjM
	hF79YS1Js4cmT0k6vFyEgjWVW1m1L+bPf71Yt31t/ZGOm0JDG3z9TI8m0s8GJ3nMd3pNGq/TZXf
	+lsPm0IPOhgV4cq0/3CDE6bvPLtoDDB/hqWR2VFu+RmmhWZ+cVbA==
X-Received: by 2002:a17:906:b785:b0:a3d:6160:fcca with SMTP id dt5-20020a170906b78500b00a3d6160fccamr9138346ejb.69.1708304964561;
        Sun, 18 Feb 2024 17:09:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2skZ0uE5cETDN0mtHmDLiYuDbMpFEFyh55kaJoE+fMvltoEYczRmuSuwF6ckMHLeGtM1ZbxIq+RQSU3/YY/M=
X-Received: by 2002:a17:906:b785:b0:a3d:6160:fcca with SMTP id
 dt5-20020a170906b78500b00a3d6160fccamr9138336ejb.69.1708304964285; Sun, 18
 Feb 2024 17:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216142502.78095-1-jonah.palmer@oracle.com>
In-Reply-To: <20240216142502.78095-1-jonah.palmer@oracle.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 19 Feb 2024 09:08:47 +0800
Message-ID: <CAPpAL=zp+VxFUNw5W2jB0ENhYZ4Ts5+gAH7cQu-7LMhFnApqrA@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Allow CVQ size changes
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, si-wei.liu@oracle.com, 
	virtualization@lists.linux-foundation.org, dtatulea@nvidia.com, 
	boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this patch's V2, qemu no longer print error messages
"qemu-system-x86_64: Insufficient written data (0)" after
enable/disable multi queues multi times inside guest. Both "x-svq=3Don
'' and without it are all test pass.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Feb 16, 2024 at 10:25=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
>
> The MLX driver was not updating its control virtqueue size at set_vq_num
> and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
> setup_cvq_vring.
>
> Qemu would try to set the size to 64 by default, however, because the
> CVQ size always was initialized to 16, an error would be thrown when
> sending >16 control messages (as used-ring entry 17 is initialized to 0).
> For example, starting a guest with x-svq=3Don and then executing the
> following command would produce the error below:
>
>  # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done
>
>  qemu-system-x86_64: Insufficient written data (0)
>  [  435.331223] virtio_net virtio0: Failed to set mac address by vq comma=
nd.
>  SIOCSIFHWADDR: Invalid argument
>
> Acked-by: Dragos Tatulea <dtatulea@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 778821bab7d9..ecfc16151d61 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -151,8 +151,6 @@ static void teardown_driver(struct mlx5_vdpa_net *nde=
v);
>
>  static bool mlx5_vdpa_debug;
>
> -#define MLX5_CVQ_MAX_ENT 16
> -
>  #define MLX5_LOG_VIO_FLAG(_feature)                                     =
                           \
>         do {                                                             =
                          \
>                 if (features & BIT_ULL(_feature))                        =
                          \
> @@ -2276,9 +2274,16 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_devic=
e *vdev, u16 idx, u32 num)
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         struct mlx5_vdpa_virtqueue *mvq;
>
> -       if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
> +       if (!is_index_valid(mvdev, idx))
>                 return;
>
> +        if (is_ctrl_vq_idx(mvdev, idx)) {
> +                struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> +
> +                cvq->vring.vring.num =3D num;
> +                return;
> +        }
> +
>         mvq =3D &ndev->vqs[idx];
>         mvq->num_ent =3D num;
>  }
> @@ -2963,7 +2968,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mv=
dev)
>                 u16 idx =3D cvq->vring.last_avail_idx;
>
>                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_feat=
ures,
> -                                       MLX5_CVQ_MAX_ENT, false,
> +                                       cvq->vring.vring.num, false,
>                                         (struct vring_desc *)(uintptr_t)c=
vq->desc_addr,
>                                         (struct vring_avail *)(uintptr_t)=
cvq->driver_addr,
>                                         (struct vring_used *)(uintptr_t)c=
vq->device_addr);
> --
> 2.39.3
>


