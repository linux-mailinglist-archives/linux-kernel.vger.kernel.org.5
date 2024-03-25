Return-Path: <linux-kernel+bounces-118132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36AE88B447
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F271F3EF8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7D7EEF8;
	Mon, 25 Mar 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5jzOA21"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD536EB6A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406300; cv=none; b=d9AsHSWq3OY9IXEfSHTvBx4fKM77hMpeaT/psHXBJ/bm6ZIS+28CeOXUgSZH5wrG0t5VVR8Sh7/0vsaPJhVzxTlRsApVOsBmSDTHAV68DGGth+ZBuO+EcPar8AzCplN3ij4RmkT0lKtW/vyjZc+zQTStuA2z+alwJmJQVQhMpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406300; c=relaxed/simple;
	bh=xMW7RXYeIfBFCjZ7VpJtMSa+FXfoa1xIBPpDQwxVrPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEnqQTKhpfMdoU3JCD3Veqdpf71fpLft+cEID5Z8g1QYBQUhF90iDQa1BROv2WFSXiUWKiauAW2KNu7qgixy91D5/VYyiJlHL6VQBxklG7jp7AWi+PP+tWq8wW5yiDeAJvmJZGW59bA9f6W/cJsKUwMXOB0kaNou4kyFoyKRolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R5jzOA21; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430d3fcc511so53871cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711406297; x=1712011097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGxpwjKqErz/WL1ZU+CEUoKvbb2jqoUW3asVbdp7yTQ=;
        b=R5jzOA21iZKiK5FqcZjzfzRPEROBcDSgAY4s0XqCJYPZyPHh/kQjLmKyAxYilRT+pY
         CKAY7m0xexVe3MUHjaupk4UJSuThIZUegEwldPRCg5SgwP5GlflOz8KlCvSevlDLbZeg
         OoKI+U0JZtVTzjHdj/86EWW3h2phE23odtsmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406297; x=1712011097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGxpwjKqErz/WL1ZU+CEUoKvbb2jqoUW3asVbdp7yTQ=;
        b=DZs39n4Ck3DYqDRu1jq+JY3hdDOz3D5mx0feotmcC2nEwO7qTU+ixdFdjtx3HjVYRp
         +1lU2uq0vcq+2ZtH2PV8cKgiskU32LOAXrCbg5flnVWrv4tKnV1s5G8tM/M0B3lkyRC3
         xGdq3M5kfXlU2qm+SdfQ2eb7Pf3s/SypUIClV3zb8yVNS0R4rSdQaBo5zu7l74ppB3La
         0LE1EWbkZbgaGFpN7I0GtY0cysJZV31ak31E2rezy0QkF+1wPKminx3sV6iKGhQflYmv
         pP49gXEL8XKH1vrYplSzUyWIR44hRzP+hiLWj51whJU83ZgjrImmd8VHrcuPF/lbDNqd
         YGDw==
X-Forwarded-Encrypted: i=1; AJvYcCVoLLYGLVz9/BdH+j3+8rag/zbIJJ6xexMgPu9SD+Au3mXKgKWEnR3dv0ePb+JS7DJRrihwlOZ89keI//NgCO8E4CUXFGxzoerAUCqo
X-Gm-Message-State: AOJu0YzJ/S7tyCUUaV2ZohuNbHh297gEfB6O1V5e5oTPwpnC9Ex2AV7O
	HYbGo45DnYA+OMj1rxgPB0tR6rOa0O7n4usNcOrtYtocrmdmewNt1DCkl9mLjVAnmmfRA6RfKD0
	mjHy7lQvaMoPTfnuUhqp/6FxH35izAqNLl0+Y
X-Google-Smtp-Source: AGHT+IG52mKa+pnbbYX3Ox0jW5wzGRU3wSOiDtmpILVDdI7DL6SUQE9Rf8+tGIrIV07xI4B507o9Zmf6GRIhYZTuXXw=
X-Received: by 2002:a05:622a:1b0f:b0:430:a5df:a3af with SMTP id
 bb15-20020a05622a1b0f00b00430a5dfa3afmr575qtb.5.1711406297215; Mon, 25 Mar
 2024 15:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322214801.319975-1-robdclark@gmail.com>
In-Reply-To: <20240322214801.319975-1-robdclark@gmail.com>
From: Dominik Behr <dbehr@chromium.org>
Date: Mon, 25 Mar 2024 15:38:06 -0700
Message-ID: <CABUrSUBTz7n6Yg_4wvGR+W__AKn5Vj4aWuLg5p3bDWye-PwExg@mail.gmail.com>
Subject: Re: [PATCH] drm/prime: Unbreak virtgpu dma-buf export
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Dominik Behr <dbehr@chromium.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simon Ser <contact@emersion.fr>, open list <linux-kernel@vger.kernel.org>, 
	"open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linux-media@vger.kernel.org>, 
	"moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It also fixes importing virtgpu blobs into real hardware, for instance
amdgpu for DRI_PRIME rendering.


On Fri, Mar 22, 2024 at 2:48=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> virtgpu "vram" GEM objects do not implement obj->get_sg_table().  But
> they also don't use drm_gem_map_dma_buf().  In fact they may not even
> have guest visible pages.  But it is perfectly fine to export and share
> with other virtual devices.
>
> Reported-by: Dominik Behr <dbehr@chromium.org>
> Fixes: 207395da5a97 ("drm/prime: reject DMA-BUF attach when get_sg_table =
is missing")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/drm_prime.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 7352bde299d5..64dd6276e828 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -582,7 +582,12 @@ int drm_gem_map_attach(struct dma_buf *dma_buf,
>  {
>         struct drm_gem_object *obj =3D dma_buf->priv;
>
> -       if (!obj->funcs->get_sg_table)
> +       /*
> +        * drm_gem_map_dma_buf() requires obj->get_sg_table(), but driver=
s
> +        * that implement their own ->map_dma_buf() do not.
> +        */
> +       if ((dma_buf->ops->map_dma_buf =3D=3D drm_gem_map_dma_buf) &&
> +           !obj->funcs->get_sg_table)
>                 return -ENOSYS;
>
>         return drm_gem_pin(obj);
> --
> 2.44.0
>

