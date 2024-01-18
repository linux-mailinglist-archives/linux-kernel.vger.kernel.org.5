Return-Path: <linux-kernel+bounces-30111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C783195B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D936B20EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939CA24B51;
	Thu, 18 Jan 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPj0WR9O"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0D241F6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581880; cv=none; b=Q/0oXQHwEfXAec3AeB6hjO4eGN4g/54V/YhbF8ckziqV2E7eS1Oznh1OLy8v/PqwQ90vyTdOwoJcWdir74+/s23Ub0OCPW/w76vEC0u1WhQsfjYnHlklKpmTu7mKRB5Xav044/XOITTcvyIlOQw/XPmt/CG89uTsVFRnpGk9/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581880; c=relaxed/simple;
	bh=eUedD1uUdxArJOmOqoy6JbY9jaRf2S8Q4mrkCLZfWL0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=iUkKFGdHPM+UGIvadQD0KRC/USZlhETCmcFlBxO6Cw9HWBQm5E5ySE6bVIv4fMZurZxDMXA8fhWz6kPogYjUgtV5S8sf+ohl85ukNGB9HApOJsTM7kDjy6R9bhrSjWFHm9wFALXZTaLaF9YQogsKViNTn7TyjmnYO8E0EH9sFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lPj0WR9O; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-559d3fbed6bso2204581a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705581877; x=1706186677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFs5WFNuIRub1VPrlJgHpKQe7Fz8TOGFyF7JArd77ng=;
        b=lPj0WR9OpSLH2WErV6BvowmOD61lwR+hzkV77M4RflbHjAO3WBNOaf/l5XwN+dK10x
         G17pb2HKZIlCklhtWRlD7+X7kbr6UbsK+0siR4/WsjaLgO0RSImF7Nrj701ZSXF5oZjM
         2yDdIVMNmG4Q8MqheXlGp+JHz4L7r6gtVFkVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705581877; x=1706186677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFs5WFNuIRub1VPrlJgHpKQe7Fz8TOGFyF7JArd77ng=;
        b=AFOaDFJIGYw/i4TjUp2z6dUl/EzCnWD0anJbg0WQLqJp6RviOd6osBGHlVTc8bkoaT
         +zMoNnpcl7iIATWOS3ibEIjraA3PHJvyM/rrp+zdOJnHwgZouObnGGqUY5hiUPszmlHP
         glveg1RuOWIQ/a6rGnSbLaRRZJiOxKzdDfs35mC5p/oAb/pnnX+ChYo156keJw/Uhpev
         U64ZDyJ5vHV8dY3g7hujGZlPVhs+LPt3KiVcKJkLhPNPpbV/XDyKoSYVbbn9tM/Z6I3b
         yBQu/ste0AhYRr3Kz+ZAKtL6KU/k3Wd5vsgDDQ8+pj1aMLhIPfaSFzddPc14+uqtyAJp
         crqQ==
X-Gm-Message-State: AOJu0Yy7OMa+kORM6TZQp/ra9+sS9AA25tK3+EFlbJSyo8XCjbhHSpwG
	ohpVGL5SzaDlDuNG5IZp+MOQcOJkVwfV5VN6wZ2ka/84F4d9EissA5nnMcIITzf/cvf5l0RZ0ow
	Tdg==
X-Google-Smtp-Source: AGHT+IGe43vCecsVlr1N5ANSBB1PkRhyzaSgXeQykdDcuZul+E9ssudUiSxjFjIWL0GM3IgxTjkKzA==
X-Received: by 2002:a17:906:3719:b0:a27:7de8:9cd9 with SMTP id d25-20020a170906371900b00a277de89cd9mr323278ejc.23.1705581876722;
        Thu, 18 Jan 2024 04:44:36 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170906adca00b00a2930696259sm9105582ejb.71.2024.01.18.04.44.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 04:44:35 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3367a304091so10614122f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:44:35 -0800 (PST)
X-Received: by 2002:adf:e6c6:0:b0:337:c6da:9705 with SMTP id
 y6-20020adfe6c6000000b00337c6da9705mr331995wrm.146.1705581875197; Thu, 18 Jan
 2024 04:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118121452.29151-1-benjamin.gaignard@collabora.com>
In-Reply-To: <20240118121452.29151-1-benjamin.gaignard@collabora.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 18 Jan 2024 21:44:15 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DddJt5EY8JnofJZuiQG8WqM7AjOF2cZ29Z=u6nh4YgCg@mail.gmail.com>
Message-ID: <CAAFQd5DddJt5EY8JnofJZuiQG8WqM7AjOF2cZ29Z=u6nh4YgCg@mail.gmail.com>
Subject: Re: [PATCH v2] media: media videobuf2: Stop direct calls to queue
 num_buffers field
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: m.szyprowski@samsung.com, mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:15=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly=
.
> This allows us to change how the number of buffers is computed in the
> future.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 2:
> - Change vdev->queue->num_buffers to vb2_get_num_buffers(vdev->queue)
>   in vb2_ioctl_create_bufs().
> - Remove Fixes tag
>
>  drivers/media/common/videobuf2/videobuf2-core.c | 2 +-
>  drivers/media/common/videobuf2/videobuf2-v4l2.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/me=
dia/common/videobuf2/videobuf2-core.c
> index 41a832dd1426..b6bf8f232f48 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -989,7 +989,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb=
2_memory memory,
>         bool no_previous_buffers =3D !q_num_bufs;
>         int ret =3D 0;
>
> -       if (q->num_buffers =3D=3D q->max_num_buffers) {
> +       if (q_num_bufs =3D=3D q->max_num_buffers) {
>                 dprintk(q, 1, "maximum number of buffers already allocate=
d\n");
>                 return -ENOBUFS;
>         }
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/me=
dia/common/videobuf2/videobuf2-v4l2.c
> index 54d572c3b515..6380155d8575 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -1029,7 +1029,7 @@ int vb2_ioctl_create_bufs(struct file *file, void *=
priv,
>         int res =3D vb2_verify_memory_type(vdev->queue, p->memory,
>                         p->format.type);
>
> -       p->index =3D vdev->queue->num_buffers;
> +       p->index =3D vb2_get_num_buffers(vdev->queue);
>         fill_buf_caps(vdev->queue, &p->capabilities);
>         validate_memory_flags(vdev->queue, p->memory, &p->flags);
>         /*
> --
> 2.40.1
>

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

