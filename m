Return-Path: <linux-kernel+bounces-89137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8186EB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425811F2608A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A95733F;
	Fri,  1 Mar 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z95VsU0J"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79D3C464
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327939; cv=none; b=rG9+szos+hkk0MkEFCf9I8KPk8Wi5lt3SZXo7aAiDkJKwB606+XU5xymZoZODffXQA71NzJxJ8R5XLQEdE4q3IAZUJU4bLO4RBccamwi4eK6JovTrG+q7YHscKE4ThNoHBF6C+MJWt4VBb5rWEU2NxdoBJsP82asRdGFdvxJebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327939; c=relaxed/simple;
	bh=SYTsC+D82Rn+NfDCS0BGr0Enxbh8kD6j4lA9Z46UG/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sH3elijEb2j/t4vQgmbsoomf+AerN55SbZBDdNQqKzc7SIUnQDuKTh1r1efKT5QHvqx0x+Q4ecZ6RF+iPmgnQKBWSKwI4/40/fkQts+rUxB049cX4/pkVZ6T3BYFuhFgNLd06R9mGGdTCZEh+/FlH6/0dc4mLRYw9zKWehieBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z95VsU0J; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso2532088276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 13:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709327937; x=1709932737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+hKswwgBRlVs6hoFMZ8CfmbaVVy8hEBnVfnxYYsUtE=;
        b=Z95VsU0JSW5pOfvAZ8Fc7BObiUSpS3VcbVNG9yC5eBNw5CaVvNj/uQHjJV68PkOFgZ
         c2M5mWDcoCnUgd7CndJsQ7tKPC9eykwgfu/5MQdYJMYVbNfo1SY90v5z6T3aUJDiuJor
         jZjD9le2P1q4QaAMk31p8Plnvp2v776Er8FVRPLE7Qcg1q67FG/asO1lig2gUzXeWgIJ
         6i/If0rZXFiGkoSJmjmqZx5tj5ZLuSMEksA3pp4Svp5E+lc3JNxs1SWVCe8Z25QR4gqz
         hc1ZqAMUSHrJ9qr2wHlkbhFT+6HmTFvv53UWVNLwJRpNd0WbvGyxAzmoyeVCkeJngDxO
         678Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327937; x=1709932737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+hKswwgBRlVs6hoFMZ8CfmbaVVy8hEBnVfnxYYsUtE=;
        b=cO4hh/9uXHi4KXuRmThiINDbrfVWENtc8ZfsyaCP6hhc0tNUMAuRqy1n3qPdSHUl8s
         oQlXspLhhtgDCv/vP5nHIVF+xHk2HUBtrPd/y0+Sq++wjOmxYO7IBVSfqJaE4vBbbrwu
         KJz6O39UQcSkayu0fMSZilBLTfiAjYwZymsIxt9K3TBFTneklSeKql+0H7JxhHxRHpsZ
         htDvf5aNDBwVQrmAsMStRH78deek65H27RzvXuEF9fRPg5hhpt8/9ZX/0lStyYITUVPd
         a3Qll/TvmUf443EhvDBeKLAHc3zoOqdD1EMxv/6v5NHJtdc2kvlg8I1zZ8T4Q4iHhBTU
         LPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ92a9aCmLuRUXCOifTnm+2urKSNM2t23hHElkKGHV2upvHA8H8mF9JiGSUSs64Aw+B0cLhku8sn+iFPshEkeutr71iAIr5DSfhcoh
X-Gm-Message-State: AOJu0YxRXJmSwgeUq6m28ni+OwLe+2h6UCLywF8D+p2UDi1OapHbzgYi
	Idzn+VPjytyMzgBr2FaXH7ec9XOeatm6nWbaZtruSwhfNNw3K8Zn9OL5MDeu0ugPnEJ39XqtX8u
	T/W6pnAK1SDz/aKBqDwCwgnPOlkdu2T7kI1Qhxw==
X-Google-Smtp-Source: AGHT+IFQSoyOyCyetZ1xyBsyCoRdufcJjtnjYMJ6MZY4Lmc3rRAWPeNv2sj/uOoiiWOoKZw8WaP8KgqCWT7zhhlRukU=
X-Received: by 2002:a25:c02:0:b0:dcf:4793:9a25 with SMTP id
 2-20020a250c02000000b00dcf47939a25mr3196516ybm.44.1709327937273; Fri, 01 Mar
 2024 13:18:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
 <d5c07950-6f42-4ac9-b0d8-776d444252ae@app.fastmail.com> <CAPLW+4=T1eGrWQcEJWvOcHgq9tnRhfi=AH_=qj1022k2WHmEhA@mail.gmail.com>
In-Reply-To: <CAPLW+4=T1eGrWQcEJWvOcHgq9tnRhfi=AH_=qj1022k2WHmEhA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Mar 2024 15:18:46 -0600
Message-ID: <CAPLW+4mVTvPBW0hd9pV6AsSezxPAhwPByq3WmGpprtseTgy-wg@mail.gmail.com>
Subject: Re: WinLink E850-96: WARNING: at block/blk-settings.c:204 blk_validate_limits
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, linux-block <linux-block@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:51=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>
> On Thu, Feb 29, 2024 at 8:56=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wro=
te:
> >
> > On Thu, Feb 29, 2024, at 15:14, Naresh Kamboju wrote:
> > > The arm64 WinLink E850-96 Board boot failed with 16K and 64K page siz=
e builds
> > > Please find the below warning log on Linux next-20240229.
> > > First noticed on the next-20240220 tag.
> > >
> > > This issue arises only when one of these Kconfig options is enabled.
> > >   CONFIG_ARM64_16K_PAGES=3Dy
> > >   CONFIG_ARM64_64K_PAGES=3Dy
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Warning log:
> > > -------
> > > [    2.231008] mmc_host mmc0: Bus speed (slot 0) =3D 49968750Hz (slot
> > > req 52000000Hz, actual 49968750HZ div =3D 0)
> > > [    2.231714] mmc_host mmc0: Bus speed (slot 0) =3D 399750000Hz (slo=
t
> > > req 200000000Hz, actual 199875000HZ div =3D 1)
> > > [    2.241961] mmc0: new HS400 Enhanced strobe MMC card at address 00=
01
> > > [    2.249182] ------------[ cut here ]------------
> > > [    2.252371] WARNING: CPU: 3 PID: 90 at block/blk-settings.c:204
> > > blk_validate_limits (block/blk-settings.c:204 (discriminator 1))
> >
> >
> > The warning was added with commit d690cb8ae14b ("block: add
> > an API to atomically update queue limits")
> >
> > +               if (!lim->max_segment_size)
> > +                       lim->max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
> > +               if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> > +                       return -EINVAL;
> >
> > Whereas mmc_alloc_disk sets the limit as
> >
> >         /*
> >          * Setting a virt_boundary implicity sets a max_segment_size, s=
o try
> >          * to set the hardware one here.
> >          */
> >         if (host->can_dma_map_merge) {
> >                 lim.virt_boundary_mask =3D dma_get_merge_boundary(mmc_d=
ev(host));
> >                 lim.max_segments =3D MMC_DMA_MAP_MERGE_SEGMENTS;
> >         } else {
> >                 lim.max_segment_size =3D
> >                         round_down(host->max_seg_size, lim.logical_bloc=
k_size);
> >                 lim.max_segments =3D host->max_segs;
> >         }
> >
> > and max_seg_size gets initialized to either one less
> > than 64k, or to exactly 4k in the dwmmc driver here:
> >
> >         /* Useful defaults if platform data is unset. */
> >         if (host->use_dma =3D=3D TRANS_MODE_IDMAC) {
> >                 mmc->max_segs =3D host->ring_size;
> >                 mmc->max_blk_size =3D 65535;
>
> Changing this value here to PAGE_SIZE (instead of 65535) makes E850-96
> functional again (tested with CONFIG_ARM64_16K_PAGES=3Dy). I'm sure this
> is just a quick hack, but maybe it can be helpful in further analysis.
> If anybody wants me to run some tests on E850-96 -- please let me
> know.
>

Sorry, just noticed I commented on the wrong line. Here is the change I mad=
e:

-               mmc->max_seg_size =3D 0x1000;
+               mmc->max_seg_size =3D PAGE_SIZE;

for (host->use_dma =3D=3D TRANS_MODE_IDMAC) case.

> [snip]

