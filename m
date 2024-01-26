Return-Path: <linux-kernel+bounces-40578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BB583E2AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4861C2385E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB85225A6;
	Fri, 26 Jan 2024 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K82lLFVG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4807622F00
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297678; cv=none; b=Hj+FjG6EXowjBJDqU0O4LPrIlp8g6tGghusGbAXaDtLInj/swBs3hPnAUacBwqv3F/QJNctpqEunZS7lDO3M13Xi88ifX96Ley6tq3HwwNy7ROQccNDKrcWQp7R9zXnktdKeU00oX0+u83k+3QgeMoHTVyzIE969//IUeKmPRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297678; c=relaxed/simple;
	bh=tfOxMtx5Cfr4/2BBa6e/Z93lwhl+XzA2Fe1CjCbRPH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cASjYSiBZS2sKoPtePYtcG2vHfYluhE6233XFU6x8kU7ZR8EHRojFn0wfuXBRZTxWf4ccnOkIRfzJaUUurdTCpFqla1CXZbd3b/eMTozkcZkOIp5FGbE91b56C+ejB428zT1rdlRuvefoqutupSuanX3R5K6qIqjDR3wLuvkENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K82lLFVG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706297676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKFOw84eQkBctyl11Kq4eHftlIIXeML4uIYWCERUDJQ=;
	b=K82lLFVGSkOUV4fX7QOG3uRvzVpI0UJfDEtYJfh5zz+fTP9009pawvHgGsuR7Qh9zqYnod
	nQIjhLI3+TtyVJMJIKtW316/ANkavF3XFznPbXylWVX7mP0uPUtV1JWTOOcvPDGZTo+p13
	z/5X7wNwtoWnT+qtx0bA8BO5lriLbnw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-N7wthCzsMNqVUqiu656uZA-1; Fri, 26 Jan 2024 14:34:34 -0500
X-MC-Unique: N7wthCzsMNqVUqiu656uZA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5eba564eb3fso13415457b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297673; x=1706902473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKFOw84eQkBctyl11Kq4eHftlIIXeML4uIYWCERUDJQ=;
        b=WfVcn0tGQZW7h53VeC1eTSXYzwqCvX9ophtQAKgXz/gPT9VyRwb4PXi6+6WNN6xair
         r/xSxyVYVkr0w+nXkfUvzi+oQGabxh1CUm5BD1FGBpPZ1x0Hkbls9h9RpdfZ5VDyXLos
         fxmIFtjd6ECc361rYsTUwDpT5SWW+VVtTu4Xfus0aghRS/EXfI+aLc5QpYYFt3YAxV1a
         hBt9Hj2jyC3OYi51tnnpfsN4AtOlxi1qdcsfNcSbgGRz5lpegIc8SSSwZZ13BvoqTnJP
         OmM4ciPXSMB76d8eye4UiOIt2hONoug3nBJkCCKGSPxZJ/2Cfwl9jnemDuSJoymtslSJ
         X70w==
X-Gm-Message-State: AOJu0Yy11NewBCw0i2cjuOWptSwZnpeqeTuBoW0kDOQjzh4UhzowRoV4
	WLw0gsZfjB5yWv/RfhkgZmtoU6U7OkyWlofGDGk5WBKPdl4ejGNAHlmzjd0eBFp0brT3eD+2XG/
	B5PWAtsGLbygBixastd70oE2f34XxoNQlJrSSntAauQCW9/DjJzXbBNY0Zj9ehLKuF+UOKaYuwD
	Utv4scLDuS2jyZaWgcmxJDKqAQqmtnZdPjIbM7
X-Received: by 2002:a05:6902:2182:b0:dc6:3610:c344 with SMTP id dl2-20020a056902218200b00dc63610c344mr455177ybb.13.1706297673538;
        Fri, 26 Jan 2024 11:34:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbvimdorHrnYxIhWjG3RD7+nAROM2OJYWCfaHXU515HbHyysUsM5k27p6T4zCgikDysUxTZ1zNtXpWJETBmdc=
X-Received: by 2002:a05:6902:2182:b0:dc6:3610:c344 with SMTP id
 dl2-20020a056902218200b00dc63610c344mr455153ybb.13.1706297672554; Fri, 26 Jan
 2024 11:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-77-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-77-keescook@chromium.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jan 2024 20:33:56 +0100
Message-ID: <CAJaqyWf0EbRWSj5r5P6POJA1PjQCp8LUn=VrMr82CzEyeHFJ2g@mail.gmail.com>
Subject: Re: [PATCH 77/82] virtio: Refactor intentional wrap-around test
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:28=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
>         VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow()=
.
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185365=
94 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: virtualization@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virt=
io_pci_modern_dev.c
> index 0d3dbfaf4b23..710d3bd45b4f 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -59,7 +59,7 @@ vp_modern_map_capability(struct virtio_pci_modern_devic=
e *mdev, int off,
>
>         length -=3D start;
>
> -       if (start + offset < offset) {
> +       if (add_would_overflow(offset, start)) {
>                 dev_err(&dev->dev,
>                         "virtio_pci: map wrap-around %u+%u\n",
>                         start, offset);
> @@ -81,7 +81,7 @@ vp_modern_map_capability(struct virtio_pci_modern_devic=
e *mdev, int off,
>         if (len)
>                 *len =3D length;
>
> -       if (minlen + offset < minlen ||
> +       if (add_would_overflow(minlen, offset) ||
>             minlen + offset > pci_resource_len(dev, bar)) {
>                 dev_err(&dev->dev,
>                         "virtio_pci: map virtio %zu@%u "
> --
> 2.34.1
>
>


