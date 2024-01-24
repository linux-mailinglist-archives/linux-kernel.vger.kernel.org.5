Return-Path: <linux-kernel+bounces-36300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82331839E98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65661C24250
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F191842;
	Wed, 24 Jan 2024 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jmx+02C6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C95C97
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062380; cv=none; b=dMNMMQhvv+eyJ+0Tq+CLHn89s20htLtBV0edt64xKVtTfG0r8CmumPudLKX8bba+NW+sk63jKLPotTQhJcy9vNOkR4Bz1kysBTKmtaFIVs9nMrX/p7fKSGzw2pf3TDYnC1p5eUW6QAT0NFiTWr0PyDLWUxPMp1oz80MqVh+U6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062380; c=relaxed/simple;
	bh=lFdIGOrsLJDCPMyERIOrFMHqIa0XrdR2y2Y6ka89vkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCJrZ9MNU148lv6KqoW2OlbOrjo7LiK5lz4rDfj7YdH9eqB2Hp4vQJg2Lh88dS8y5pLJjjIz9QQhpPkRr7EFdimjeNT7bKecipfa1xdFxPhJ8pvS0tV1Fepl2a1cGVf7qO5iEixHKJiEWa4FHJb1A1N6Nib0pkWHiL/QfU7l2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jmx+02C6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706062378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcX6ZTJW6jDsbwZncNxHncjf49E26ZAqFDwn/qtQ/ko=;
	b=Jmx+02C6u/XVppohwbvwVgyZQFcT577XdSpZHDjIlCCDWsNGBL9Z7r53I1ABFOFtjAhs14
	iCIw39XrbXhZOAPOTP1ronn74DtIVP/OwbU7lXmlnGeoOuDM8hXOexls956713cVZCIlc3
	dakDH/VxzNHMCtFl1k1LaLPsmMr/0hE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Ncr3usC9OlqinstkJwj8Ow-1; Tue, 23 Jan 2024 21:12:56 -0500
X-MC-Unique: Ncr3usC9OlqinstkJwj8Ow-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6dd7ad4009dso1378888b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706062375; x=1706667175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcX6ZTJW6jDsbwZncNxHncjf49E26ZAqFDwn/qtQ/ko=;
        b=ZSen6HlUVif1bWUTBkgVrOXdcMsgOEKqI32c6cV5O4DgNqW6Cf22fKtXISdQv3Gq/G
         aZcLPHZxh9tBaCjljz11tQJzhuZbx7zRILJAqxgb1aibmG75rlHQKS9403GXmPVR0j8b
         A7GTLyNd4IHAVqlGxfr3+p3ZINWxvOJHS1LfkwVHOW1zMOvjFCTdBEQOpHtjXJ3ERAQT
         ao2AnjjXYvSVSxG2ISO0ibuyZcxyzP5rnpWngAY0UzMXs+XT89fbcPRz3cjc6t6dpykp
         GOP/rq00nPT8lkYxXAroveZ4PI76Zn1NQoTbr6nu5uGTLfj6GRuhX92IiQI+2kkrKchx
         BDYQ==
X-Gm-Message-State: AOJu0YzXxUd5oQF/QNarfXawTNKt+bEPivaqXzLOOCVudW+gFJujTOSB
	E2dbcWrwiNKK4SUaDfzZYuSXNbCAA8utqsA/JecWperY1lxpABZIVwJcMygaeAsT6vAITtwPHsk
	V3T0bl5WwaAJRtmXHO63ANXi97+Hfuu7QavBOq8crtkSHIkcr8pwQzjJLi/fG9pGE0Pchc8aqLn
	kuMxdLD6FwsuNk85k/Z1jrr2WkRz0rjOs6gphCspwiJ1EQ
X-Received: by 2002:a05:6a20:2d0a:b0:19a:834f:3b05 with SMTP id g10-20020a056a202d0a00b0019a834f3b05mr246694pzl.47.1706062374955;
        Tue, 23 Jan 2024 18:12:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNn8l1cx6DZqmpTOXs74y9mH8KWMRbygPjT3c+58HhDNrQpbaQx2ZervZGQULrB6ZouLS1P0uv/AuiVE1ygFA=
X-Received: by 2002:a05:6a20:2d0a:b0:19a:834f:3b05 with SMTP id
 g10-20020a056a202d0a00b0019a834f3b05mr246687pzl.47.1706062374696; Tue, 23 Jan
 2024 18:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
In-Reply-To: <20240122102256.261374-1-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Jan 2024 10:12:43 +0800
Message-ID: <CACGkMEsS2yAnEc3UAQ8EeBgv6aOFVHnX_D=2kyNp96kZwsU03Q@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:23=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing XDP
> hints through kfuncs to allow XDP programs to access the RSS hash.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..1463a4709e3c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtnet=
_info *vi, const int mtu)
>         }
>  }
>
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +                          enum xdp_rss_hash_type *rss_type)
> +{
> +       const struct xdp_buff *xdp =3D (void *)_ctx;
> +       struct virtio_net_hdr_v1_hash *hdr_hash;
> +       struct virtnet_info *vi;
> +
> +       if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> +               return -ENODATA;
> +
> +       vi =3D netdev_priv(xdp->rxq->dev);
> +       hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);

Is there a guarantee that the hdr is not modified?

Thanks


