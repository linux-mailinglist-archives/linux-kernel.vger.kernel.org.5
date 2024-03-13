Return-Path: <linux-kernel+bounces-102501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D887B303
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8771C23ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD6C4D135;
	Wed, 13 Mar 2024 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7pek5Dd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D191A38DB;
	Wed, 13 Mar 2024 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710362778; cv=none; b=iRCts7vFCRI5QBaUwVlicir4Jh5MKfyqXXadUMy6cqvgl6qwZyyr3TC08X8IfmSZKtezYMDqoppM/heL6w8mOXck6agaWjK8oc0ec8d1bP31JQdBNBFgX7qhgSztlX5xpkjqM0cS6CUFwNKBI7EcXvRs98sk6U2hsgyqz82AiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710362778; c=relaxed/simple;
	bh=ALM0WwrGBQUp/FYw+0zzYxsd3BgRttSPoSv9KNVliHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0Z1f+DTYgMbd6nFfkyrhJSCuhi6jV4y56Mh7yCf0bZEloisy7u2MDsUGJRyBvUPvtbYpdZjRdDegYk68D55XfgwLakhKYGA7wJIRZeP9pam9xWjOZH+3Lyf1OVBkv5fIA3DgjDSe5UFIazvFA5zIQRm0uHqklKY2USwFqGMvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7pek5Dd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd878da011so1746715ad.2;
        Wed, 13 Mar 2024 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710362777; x=1710967577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts6uCQCSR583D5MrwHjGerF6k57417HU7JnE/j9wabs=;
        b=k7pek5DdPLeLoEDTkzlv7ki9Q+99FDKkZlKA0mAMht9OTE2KHHU7BeFeEnFabOkyuR
         i6B7Uh/Ff051/vWUvLBmaVlIDmPA268XoKYE32baiNsgaXFPUZZgkmyG90Ad1H/kbhhE
         YZwRuXPId5DOKOcOGjqeMR6Y36xULNyqHkMSUclkKWynyoV2QJCcSXRV5MT42VBRBD08
         dUv0KcAcoYUM+m17lwDQJ/QFFNgCVWDQE7ZW5gDE90V62pP59M/TV0Iei8h7kmyh4Ivc
         ELAEJZGOa4vd4xjbTjTlDMoV6pQnOHYP+GzjoT/B4gtjQt36+W6gd782V08dKT3elEEX
         ypoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710362777; x=1710967577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts6uCQCSR583D5MrwHjGerF6k57417HU7JnE/j9wabs=;
        b=k8PtvItjRscnFifTbM+/hp0cG0fc9gmL0zxY9+dYnsoI+NZF9BHK9R3j+9vEOKO8pb
         KJ0oQvjR076e4SeuUKCVY/Bq6I24mTLD5VPm5Mm8XJummwv5/6MMnuP3vFt+oMm8E1my
         cCSuj+y8zClKuGzCGXmMIDTnO+5KmIHK/1lXl/pzAlSMPmDQiJi+tlgQPXmSQDrqxb3T
         dyLy6TzPtZlI/cbSN/kXtLMAVUz47GNuM95QBq8lzPeBg1zy0q1wk6VCLeA7OpgzndZH
         gPVKObykBeairLtj2txP55a+jhlecyu1nIn/zwOyEZab5CWtmJJu7TKQQyk8iPhrvXAY
         fbhw==
X-Forwarded-Encrypted: i=1; AJvYcCUO8lpquG08Eisyp6bj01s4sUnfLqyfXv9PtktuC6gCmLc1IiRggnZw1wsAkz/sxxSI52aa74D6uSEuUjKSgwbi6oYQ24kMNTRR/6JoRNgi33S2Dg707IhlWDZIofHKURhn2JVv
X-Gm-Message-State: AOJu0YxmUQlsSIz4ZC04WolYD4fSxa31yEvn2ddQbQocGsaT5leW2tKF
	s5ynWxjmfYhSinYf1AcfLmYXaParDSvHrT2qr5RSJlvAxV6GV5U6KN+zt7LVpAhOUXOdC5i26Qo
	7XKPeBmk+HTYyk7gMgOkA/PoZOrw=
X-Google-Smtp-Source: AGHT+IGYqfS5DvWMkzgnBKtCUoh0ekfjB6vYZlQVJbjyvNRGm42ddMgr01CInYZAvgWcnusQw48HiAHusT46XBd+NFM=
X-Received: by 2002:a17:90a:be08:b0:29c:3c56:a4f5 with SMTP id
 a8-20020a17090abe0800b0029c3c56a4f5mr5840535pjs.26.1710362776624; Wed, 13 Mar
 2024 13:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311151424.318621-1-sashal@kernel.org> <20240311151424.318621-3-sashal@kernel.org>
 <65d9f97b-95a8-474f-a716-32f810cbb1bc@amd.com>
In-Reply-To: <65d9f97b-95a8-474f-a716-32f810cbb1bc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Mar 2024 16:46:04 -0400
Message-ID: <CADnq5_OHW9Sw5quFqk52ymGVKXe3PGidB9uLW9wcQcA=pCOTCA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 3/5] drm/amdgpu: Enable gpu reset for S3
 abort cases on Raven series
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Prike Liang <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	daniel@ffwll.ch, Hawking.Zhang@amd.com, lijo.lazar@amd.com, le.ma@amd.com, 
	James.Zhu@amd.com, shane.xiao@amd.com, sonny.jiang@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 4:12=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> On 2024-03-11 11:14, Sasha Levin wrote:
> > From: Prike Liang <Prike.Liang@amd.com>
> >
> > [ Upstream commit c671ec01311b4744b377f98b0b4c6d033fe569b3 ]
> >
> > Currently, GPU resets can now be performed successfully on the Raven
> > series. While GPU reset is required for the S3 suspend abort case.
> > So now can enable gpu reset for S3 abort cases on the Raven series.
>
> This looks suspicious to me. I'm not sure what conditions made the GPU
> reset successful. But unless all the changes involved were also
> backported, this should probably not be applied to older kernel
> branches. I'm speculating it may be related to the removal of AMD IOMMUv2=
.
>

We should get confirmation from Prike, but I think he tested this on
older kernels as well.

Alex

> Regards,
>    Felix
>
>
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/soc15.c | 45 +++++++++++++++++------------=
-
> >   1 file changed, 25 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/a=
mdgpu/soc15.c
> > index 6a3486f52d698..ef5b3eedc8615 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -605,11 +605,34 @@ soc15_asic_reset_method(struct amdgpu_device *ade=
v)
> >               return AMD_RESET_METHOD_MODE1;
> >   }
> >
> > +static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
> > +{
> > +     u32 sol_reg;
> > +
> > +     sol_reg =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> > +
> > +     /* Will reset for the following suspend abort cases.
> > +      * 1) Only reset limit on APU side, dGPU hasn't checked yet.
> > +      * 2) S3 suspend abort and TOS already launched.
> > +      */
> > +     if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> > +                     !adev->suspend_complete &&
> > +                     sol_reg)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >   static int soc15_asic_reset(struct amdgpu_device *adev)
> >   {
> >       /* original raven doesn't have full asic reset */
> > -     if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> > -         (adev->apu_flags & AMD_APU_IS_RAVEN2))
> > +     /* On the latest Raven, the GPU reset can be performed
> > +      * successfully. So now, temporarily enable it for the
> > +      * S3 suspend abort case.
> > +      */
> > +     if (((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> > +         (adev->apu_flags & AMD_APU_IS_RAVEN2)) &&
> > +             !soc15_need_reset_on_resume(adev))
> >               return 0;
> >
> >       switch (soc15_asic_reset_method(adev)) {
> > @@ -1490,24 +1513,6 @@ static int soc15_common_suspend(void *handle)
> >       return soc15_common_hw_fini(adev);
> >   }
> >
> > -static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
> > -{
> > -     u32 sol_reg;
> > -
> > -     sol_reg =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> > -
> > -     /* Will reset for the following suspend abort cases.
> > -      * 1) Only reset limit on APU side, dGPU hasn't checked yet.
> > -      * 2) S3 suspend abort and TOS already launched.
> > -      */
> > -     if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> > -                     !adev->suspend_complete &&
> > -                     sol_reg)
> > -             return true;
> > -
> > -     return false;
> > -}
> > -
> >   static int soc15_common_resume(void *handle)
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

