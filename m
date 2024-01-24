Return-Path: <linux-kernel+bounces-36604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16BE83A3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A221C24385
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA617543;
	Wed, 24 Jan 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2vwd4bx"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733DF171B8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083447; cv=none; b=oR+3RmEN6Zz/MBdM/jEc1zD++YEAvZhDewni/5H0Zhuz/b6l9k7Wquj+UFON5if7/gi08u8jf07gRjbdRY37S3x6ETOFtfJmvezRMXz+1tt7Peof+DLxoKDqhf92MZ/B9gVDHLTzA1Oipkcf+ZgnkblxtpVQXMWTH14bN9p8bQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083447; c=relaxed/simple;
	bh=3ryJ9QfMSJB5meTFNmrsG8yMJDsWZtcgCBG7GnLOU2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oui5pufEmuCU5xLSmNidghswu6bPVpX5o9eka1FOihCvWvp2zP5T40kBg3TKaEIoa0wNGRX+ULgIH416IF5udJFdK+qXWp1IEAV18e2wFd+mxz3xBG8jqVoeH3fc3adyKOzzffzEXjZFymKXNqitSyNcVkjN338oSaoq9QAHGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2vwd4bx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a30d2bd22e7so128016366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706083443; x=1706688243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMsMvcqo9tiI+zEI4bAOrsj58NkwX4U+iZs9afW5yO8=;
        b=a2vwd4bxPgCoz6Y3lXQbu4kpXemsgi05JqsGXJ+Yl4OlzD181uD2pLkBNFgy84LLJx
         p6LK7lUl3P28XM3rHTxp4phXt3SkKnh70SvgGaiCswk2W9aMRsJvtTbr2Ew45PuPPWqY
         Cwiu2UgfVNiZO1baln1XXUOhxd1TAxKd4yWAhdW21KmnjrKGE1B4POM+rycwZKkKQSr5
         Q8nJjMuG/M19aaIJbt7FS+ZAs2Opo9ODM8KLWv1lJjFtaGuQclUe5cvA0gddPQZN0S4P
         2XXTAuhKBKBrYmICURaBVKurilkVzNLgyOxo/ebvYCp1rlTxwSnU88SjU+rNMkhB67c/
         7xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706083443; x=1706688243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMsMvcqo9tiI+zEI4bAOrsj58NkwX4U+iZs9afW5yO8=;
        b=vhvZOgimiZAl5rFvgT3iwnu6XS9ba1qyaOLcb7EwcpWEDYyf/Hbg6dOY+mrFOtDdiJ
         JymDp0tuZthFq/8fFpSIyZNYJ2wcVBof4uSAoy/ffxk6m9v2C1oM2ia60oLqXXvxsuXv
         ifLd/v4dzLTJnvpoZYLWn8gJMzOix6mlk7tzwdrcXScVUShcWGHphymdAKgc+s9RQ6Sz
         ishKnv0oKvQ+qfXVpbyEiPjPN/TUaeJoTJdr5qL73F27V1iTdkMdm4OJu62m6/nDcV2z
         7SLVWkaoKa+HRGB6B0xuqK4ZyEDBVRDkij6Bm6KUGvIcmZe3xTb9gfSYz+6ph6J0sMnQ
         69dw==
X-Gm-Message-State: AOJu0YxG0GSnUBwFthxlR2sQ91YoYV5PbnFTmLPVWqMAxoKdz7WOwV1K
	1ia87fxCRhj2s/BH7bvyxqxcnr1s99sXj9PL70fvg+LEtDzG/r4UZgUfdbFRoi19i5YMV8HoiMI
	mYhKF7dSDyKrZne14RftoxMTIA+Xud3561Kc=
X-Google-Smtp-Source: AGHT+IF4cJRxM1jSTL21PLnaFKGDqLs8hHv0lg2CRob3WakI7L0fkc1IUVV1PKo8IQj68dFnLssUR7qZBZPcSh6IUjw=
X-Received: by 2002:a17:906:c7d2:b0:a26:4625:eeb4 with SMTP id
 dc18-20020a170906c7d200b00a264625eeb4mr656392ejb.51.1706083443312; Wed, 24
 Jan 2024 00:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com> <CACGkMEsS2yAnEc3UAQ8EeBgv6aOFVHnX_D=2kyNp96kZwsU03Q@mail.gmail.com>
In-Reply-To: <CACGkMEsS2yAnEc3UAQ8EeBgv6aOFVHnX_D=2kyNp96kZwsU03Q@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 24 Jan 2024 16:03:51 +0800
Message-ID: <CAKhg4tLMw01HgvmtSL9L8+1Yek9-JE2-BKxvWF1JeJeyMF5HFg@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:12=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jan 22, 2024 at 6:23=E2=80=AFPM Liang Chen <liangchen.linux@gmail=
com> wrote:
> >
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing X=
DP
> > hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..1463a4709e3c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >         }
> >  }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                          enum xdp_rss_hash_type *rss_type)
> > +{
> > +       const struct xdp_buff *xdp =3D (void *)_ctx;
> > +       struct virtio_net_hdr_v1_hash *hdr_hash;
> > +       struct virtnet_info *vi;
> > +
> > +       if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > +               return -ENODATA;
> > +
> > +       vi =3D netdev_priv(xdp->rxq->dev);
> > +       hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->=
hdr_len);
>
> Is there a guarantee that the hdr is not modified?
>

We cannot guarantee the hdr is not modified by the XDP prog, So the
idea is to save it in a wrapper structure before running the xdp prog.
Patch is coming soon.

Thanks,
Liang

> Thanks
>

