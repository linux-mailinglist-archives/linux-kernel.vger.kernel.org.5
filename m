Return-Path: <linux-kernel+bounces-30555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A98832066
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1017AB23EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F502E648;
	Thu, 18 Jan 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clmzw37h"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD802E650
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609169; cv=none; b=BWVvz5AUd6jCW9sSNGu6nFddVPFitT1esgp0MY3jAL7EZtEC6DUYBRXpzknoVruLZJ6jkWXoCCZlKsmjNqsfFTQEJguMCyQ647UhC2s/8o9b8amiXCCnYg+QS7xDppV0S3gBdsHwP/00sDfzi8rW2GN1R3CoSf2nw4WzivpjFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609169; c=relaxed/simple;
	bh=PIi7GYt6jbHa+tcCPyWxzhvV162nht9aB8jy6QpLXHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6XalkvZaAs8wd0GaRvUxHQ/Blm5bfTI73DapVbTEtvlUPLSo3UzHjdmkl05m0Lr8H83WR9iGRfCYBYOJot4uebBrUzmRyvD/DwsljoMOrt4QbxbleLghQu3zXFrjceqf6ed3yvI2ENZAOyG4XycFEenKRKiC8hMkbKFqgn+xXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clmzw37h; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dc20b4595bso35995a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705609166; x=1706213966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhrU9+2Wos2GEkaqWKGdWBeUMi5dBl1aaYQCU5q6qoM=;
        b=clmzw37hjCmuYnXa3YTCVT3sqDe402c7V8eFlCi8CRyXGd3f//brZm3MkgN72I0Hit
         OfifoPHXlwb7uxedZv4ZUipnPRDe+YReT9xB9/gXuAAGzmoott9mU7qprdpsuncQewsn
         vj4w5Af8ALW7eU9MPvn2dckRI0r6/vYIbVn00sppcYDl7Rc5KCeo9d804DW83Q6VqUio
         PDJnG1xmNeOKpjJvI7d86o7tpK2NR7Xhx9+7SKfnjoBNGo2cH0XjEr53N8sPzPSGKxt0
         tU+veu8Ax1HzR/MKxb7Tx6mb5u+ZkdlA4E5cDeOyusqsGWq2QR46D2juwVB3dopWxMol
         R7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705609166; x=1706213966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhrU9+2Wos2GEkaqWKGdWBeUMi5dBl1aaYQCU5q6qoM=;
        b=ldFiGU0yLR+z50+10wGUiU9BMh6Xey+5hNccZPJ9bXUS2a9QF97eUB569YcZKQALJj
         8uCWBS2RkYuI5M+Eep3VsfjHAGBYK9sTmdkwPLe/PtUAt3qxRS7wOC6qfH6rPKAL5ENm
         hD5lJzD+hwheHZUlAZULNobF92IBizbj/Dp5H7lZDxRX/5bukG6uX2nruIjY1vqRaU1M
         RRxJ5amA/sdn77q+MbHtIIFRZHsBXXpTRj6Wq/wpGaTWtPzkJ5GmvFxXE7spOF5LFAT7
         dYillcyomIizch/dZU/nCglcyUtcH/zaN/n2qoUO6QpuJuEAiB3mhy1gL13r0d4EJJLy
         N/fg==
X-Gm-Message-State: AOJu0Yw+fkEm/0AulCDY8+UvCGdB0X/of0NXMr6A1u73Eb7uAVIC6ENS
	oQ+SjZtYG8Zw+h9mnMSfbE9DoPguZH8MToSjbaOg5VYvHbAyrilW2K7OKy8mv+D/c8xa1skwBuK
	IVzVhBnRZmO3B0Bi4PCK2fQY52uc=
X-Google-Smtp-Source: AGHT+IHFyv8JqhpnsV52YeCOupboqAMIhZ7qnurgiXLv38ZMbl3Qakmyl9cU6t4jDjiVrNmsHVfPoHNnEZ8KnSXh8dE=
X-Received: by 2002:a05:6871:7827:b0:206:cbc8:1001 with SMTP id
 oy39-20020a056871782700b00206cbc81001mr1533751oac.92.1705609166241; Thu, 18
 Jan 2024 12:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117144436.10930-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240117144436.10930-1-n.zhandarovich@fintech.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jan 2024 15:19:14 -0500
Message-ID: <CADnq5_MFLxNcKnvT6gr1RBiBoQrnynqQmo9kyKD86+_7pHa4TQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove dead code in ni_mc_load_microcode()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:52=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> Inside the if block with (running =3D=3D 0), the checks for 'running'
> possibly being non-zero are redundant. Remove them altogether.
>
> This change is similar to the one authored by Heinrich Schuchardt
> <xypron.glpk@gmx.de> in commit
> ddbbd3be9679 ("drm/radeon: remove dead code, si_mc_load_microcode (v2)")
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool Svace.
>
> Fixes: 0af62b016804 ("drm/radeon/kms: add ucode loader for NI")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Applied both of your patches.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/ni.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
> index 927e5f42e97d..8eac8c090433 100644
> --- a/drivers/gpu/drm/radeon/ni.c
> +++ b/drivers/gpu/drm/radeon/ni.c
> @@ -624,7 +624,7 @@ static const u32 cayman_io_mc_regs[BTC_IO_MC_REGS_SIZ=
E][2] =3D {
>  int ni_mc_load_microcode(struct radeon_device *rdev)
>  {
>         const __be32 *fw_data;
> -       u32 mem_type, running, blackout =3D 0;
> +       u32 mem_type, running;
>         u32 *io_mc_regs;
>         int i, ucode_size, regs_size;
>
> @@ -659,11 +659,6 @@ int ni_mc_load_microcode(struct radeon_device *rdev)
>         running =3D RREG32(MC_SEQ_SUP_CNTL) & RUN_MASK;
>
>         if ((mem_type =3D=3D MC_SEQ_MISC0_GDDR5_VALUE) && (running =3D=3D=
 0)) {
> -               if (running) {
> -                       blackout =3D RREG32(MC_SHARED_BLACKOUT_CNTL);
> -                       WREG32(MC_SHARED_BLACKOUT_CNTL, 1);
> -               }
> -
>                 /* reset the engine and set to writable */
>                 WREG32(MC_SEQ_SUP_CNTL, 0x00000008);
>                 WREG32(MC_SEQ_SUP_CNTL, 0x00000010);
> @@ -689,9 +684,6 @@ int ni_mc_load_microcode(struct radeon_device *rdev)
>                                 break;
>                         udelay(1);
>                 }
> -
> -               if (running)
> -                       WREG32(MC_SHARED_BLACKOUT_CNTL, blackout);
>         }
>
>         return 0;

