Return-Path: <linux-kernel+bounces-102494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C603F87B2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAD91C261BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3199851026;
	Wed, 13 Mar 2024 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+3etGRV"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2D4D108
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361722; cv=none; b=LqYyBDG0z5m0prjJw3noakvMx7SEjqGPIaDiPEXsSBhE/7iGOZBM3Hqh8SyTpMBdI+xVrk70VlCJ6kXv8PQqyJvH1NWb5hA6fvb4Wx7DjGr+Y0Iy8oHDgkHZ/jSBrAmAhxsu83J/mNLBaEMmRGlH3Wgzhu8TqyLG0BPIQgnBaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361722; c=relaxed/simple;
	bh=dfx8ASkk6a9ruedjbY+4FlMz2GvTNBDUEpltVAHck9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWqrSQA86+5fcDtTAhXaBh9RFR4I81POkRBr6AEtUrrAa3sMOtmSh2pgqGijJ/j+o9h/TMYZEhoMi2HXOf9G165V4UpZtuZFl7gDVRtZ6U+gzTcZfikXrWxvVaRTD3+4qf6TiGKiCMBXM8fZ6mqP/YN4Cppv9nnXclS69aC4VT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+3etGRV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29c57f1e66fso174488a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710361720; x=1710966520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLdMGTHjCZxVafTtMVCntax7k5CZGdoW/l4AHdOa5ds=;
        b=m+3etGRV90FHv2Y09MHGDIOd2fWodpTScCNW8CaRZzhIwQOLJhD6Br4Cug+jmv2d02
         7iD0U5Zm1WRp1w/QZHvm0U3ZLMIj0WOhTGVpC1c8JBBMzs9x/bL7zIw1qGuPf56e22/W
         STLRKWrmPuyeatcftOTUmdfAuS0UmfmIRdlZqHFKAAuKO6aGij3hOsITPQ/KPwKt2Y1z
         JNNEskKtTFTtgVbMYWIQ2o6wS8hVpErqMgy/2DxDBI8r3xkgUR/HRk/dwCIldKG8+Bma
         QM3BC3VxESQhTBQg6WYYkPtMrBlxiphPdwTtdBdiuwbvs1Ez2HtihVG0rXseKOGCypCM
         22Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710361720; x=1710966520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLdMGTHjCZxVafTtMVCntax7k5CZGdoW/l4AHdOa5ds=;
        b=oSdsHNk5jvcYKBHfHj8tfO0xs2wXQ3cI7AWM4dMJ9WmuaWi/K3HR0nts3HbYOo0+zN
         Mj56uTlYxvKFq2LXKKzNgtgTuWmlxJXbTeNv4a1zjOUxk+PBnMGy1pbCo34N9gYpbdZ6
         AcfZhJN5FbPQodta2lU/EFMvqDVf6ArthbRRI/L52mbMXZLj9D9LOS4PSvUFM1HyvO4A
         admVe7kdpoY/xZiOEhvdIC0gLO1QLusV9hVk+WrKhpqwjAp9nD6atgpcAjovy+6pAnxY
         Lqll8JPsqAYpBp9hxYeXNyQuWdFzts2IwCe/zpbwtcuONphYmV25fnUSssijrNeT4lRI
         DgEw==
X-Forwarded-Encrypted: i=1; AJvYcCUShDgfcyOZOt5ES9rBcvAlnJBeqyXj7P2yxkByPupU5mDS3LoSVkMwemxGbc+I1HxYaELIaUFhNbtOa+TVJUM+zjJChAXvnUrp0ELY
X-Gm-Message-State: AOJu0Yxw2/GtO7Y2syIl16prTQoYHetLiy6Ho3cD49D7T68E+AhIPt1J
	ohkBZkfW1nEWDIh4ZEBZQqxxMcKvcPFoFt98U0yP7PqZ+CGCixqnUuhpmwoPteyMH8r5Q/gSvp4
	QvFwuLYYjVwifdjx+vlNhKHiVCvz5xeIJ6lg=
X-Google-Smtp-Source: AGHT+IHfe0f72cKVDWfwCyw15sU3YqepXYlm+0OC2iqUlzAtqVE4ia7J9pxtUhgmCGnF6l6pP0qMzmV3PFRhKJ+ct9I=
X-Received: by 2002:a17:90b:3c0c:b0:29b:b1b5:13f2 with SMTP id
 pb12-20020a17090b3c0c00b0029bb1b513f2mr6940943pjb.4.1710361720286; Wed, 13
 Mar 2024 13:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312124148.257067-1-sunil.khatri@amd.com>
In-Reply-To: <20240312124148.257067-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Mar 2024 16:28:28 -0400
Message-ID: <CADnq5_O-cyDkNLznZpvnZtz15Mi1_rkigirG80BmYJprP_udnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add the IP information of the soc
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 8:41=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add all the IP's information on a SOC to the
> devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index a0dbccad2f53..611fdb90a1fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -196,6 +196,25 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset,=
 size_t count,
>                            coredump->reset_task_info.process_name,
>                            coredump->reset_task_info.pid);
>
> +       /* GPU IP's information of the SOC */
> +       if (coredump->adev) {
> +               drm_printf(&p, "\nIP Information\n");
> +               drm_printf(&p, "SOC Family: %d\n", coredump->adev->family=
);
> +               drm_printf(&p, "SOC Revision id: %d\n", coredump->adev->r=
ev_id);
> +
> +               for (int i =3D 0; i < coredump->adev->num_ip_blocks; i++)=
 {
> +                       struct amdgpu_ip_block *ip =3D
> +                               &coredump->adev->ip_blocks[i];
> +                       drm_printf(&p, "IP type: %d IP name: %s\n",
> +                                  ip->version->type,
> +                                  ip->version->funcs->name);
> +                       drm_printf(&p, "IP version: (%d,%d,%d)\n\n",
> +                                  ip->version->major,
> +                                  ip->version->minor,
> +                                  ip->version->rev);
> +               }
> +       }

I think the IP discovery table would be more useful.  Either walk the
adev->ip_versions structure, or just include the IP discovery binary.

Alex

> +
>         if (coredump->ring) {
>                 drm_printf(&p, "\nRing timed out details\n");
>                 drm_printf(&p, "IP Type: %d Ring Name: %s\n",
> --
> 2.34.1
>

