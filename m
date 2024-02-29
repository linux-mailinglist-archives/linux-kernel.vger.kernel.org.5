Return-Path: <linux-kernel+bounces-87328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 425CF86D2E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D24B21DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4415713443A;
	Thu, 29 Feb 2024 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ+RGWNm"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097037A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233974; cv=none; b=fQoo9BBUR6rGi3ok5kUMV2Gtw5Ki2PFmd7Mlqn/TlGbKv1iWrwpTeoY2yl0BqCT8DeSrx1RegHEfe7tPz4Gv8R9oAuDFJX65Dtk30Iw3H49fTOP1PxJBlCO49XPIhrAHKoUFNTmBt4cRC6RIZMVlcZDBCJRIrKrfH9if3f0/kUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233974; c=relaxed/simple;
	bh=z2wEAt7zpR7E6YWtpUvu+3gKjErwKwxgYcFIWwcgxww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+DEXWZrFCtkWL0H7fQz+sgctJjbqjTGSqhmoYzIFVMP7RtUKvw/pwKzCRp2nQ9WDE9vtJMiPUyIC90+lk6wDr+UhwqjYU0KQdHRyiP58CtiWCjUchrWaVK3nunn1EQojdcPYokCZ2hsXgJUw+Ja5ZDrZ04yCZVW3KyKrTjZu1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ+RGWNm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1002330a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709233972; x=1709838772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px+JyXf4tLpdcNsZuGtIfGj/dsN60RYAYJbqilYoB+8=;
        b=PZ+RGWNm+h6Y/Bsum4eDDib3kBeX5OsNPcBj5zsKSGJBk/EoXc95RK/mc/aNTtem4y
         c17tlw2iitf+eLHen0HZ+myzCe6dAGU0VG184HlItyZPMzLZBzy16lfh7wXz+Tg21Tm1
         tY5Z6w9UVIFEbZqXzU4E1WVVz070w7rWbUYw3MSkFncjgzWYrhbRbUjxZkL1v0YcOUQZ
         W9O6wc8dRvLopvK01FuYmDfBQrJ7S2dPWanlmEOqB+/wFsZgalR+XErazIUhnSGmlfz3
         yRLWLLPchs9bQuA31mCnko+t/7TqcBr+WqE1mVgIKKJlTwQ/YF3SKK8K6oEsz5I2bBbF
         Oo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709233972; x=1709838772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px+JyXf4tLpdcNsZuGtIfGj/dsN60RYAYJbqilYoB+8=;
        b=GzAyN0xmMSQHi2WlfbcAcle/oX49+LkmTQgLBi2dS0cBaMeGcaATgAX767HuSq423i
         a+xhU+m3u6j3489LOQliLyxzujWoz49Hyp8ArB3UsESm/dF54AUbBL+aLeZJU8xGxaCw
         sQR3lSkvv7A0DgcGVLUeVO1hJZ+utlR3YXzBJ8io5Y4OzxJVmTPiaqVnbR7XQUkkvqDM
         cznb4RWHU1KWnNYRDoLe+md7/DFSIVy6TzjOi8cwZWS3lysXKL59lAMi0BBGur2pG0eN
         rDqFwRrxG9vF2Q4W5ZOb1HjbIW8Xen/LiykLCQHwugP7JSJPKa/A56LLfPDcjhOVTeq1
         8QHA==
X-Forwarded-Encrypted: i=1; AJvYcCV4DWaSLjIMfsRLpQBJtcPFcZkhXSqNnW9EU4UoruNAIgxyFX/X4UUvD2BB/w0Jx/35yAx0q2JjxEGMe7cKfQdkhOrJgmD8u81zFy26
X-Gm-Message-State: AOJu0Yx66NfxkbQx++BQQP/k4l9ERSU+mYFaLzgjgMR/KPU+/fmggzxT
	6mmbdkX3N7jhIme4AGGL7tJGdcfyXNSew5IzbxQmdc+oNld8C99iS/BS3CVJFa7qOr7TNNdFxJ9
	vEF1FfeNyt33Sfo+85oA5AH1RcpY=
X-Google-Smtp-Source: AGHT+IFMzzhy10NqDN+BK2sKx5qHOBOz1iWOCM7oh2BvBq+hmVZas4TDKA77iA356owZsETodRWHQmax6qLWPeR7z20=
X-Received: by 2002:a17:90b:ec6:b0:29b:17de:6951 with SMTP id
 gz6-20020a17090b0ec600b0029b17de6951mr1582952pjb.3.1709233972379; Thu, 29 Feb
 2024 11:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229181106.351877-1-helgaas@kernel.org>
In-Reply-To: <20240229181106.351877-1-helgaas@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Feb 2024 14:12:40 -0500
Message-ID: <CADnq5_OdYfOOckVNzxZHgxCn5tuYHrCUuaTEnEubJS_2jwXw-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove misleading amdgpu_pmops_runtime_idle() comment
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Feb 29, 2024 at 1:11=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> After 4020c2280233 ("drm/amdgpu: don't runtime suspend if there are
> displays attached (v3)"), "ret" is unconditionally set later before being
> used, so there's point in initializing it and the associated comment is n=
o
> longer meaningful.
>
> Remove the comment and the unnecessary initialization.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index cc69005f5b46..68416e2a9130 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2744,8 +2744,7 @@ static int amdgpu_pmops_runtime_idle(struct device =
*dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> -       /* we don't want the main rpm_idle to call suspend - we want to a=
utosuspend */
> -       int ret =3D 1;
> +       int ret;
>
>         if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE) {
>                 pm_runtime_forbid(dev);
> --
> 2.34.1
>

