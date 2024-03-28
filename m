Return-Path: <linux-kernel+bounces-123762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF40890D72
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DC029DAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D127B13BAFF;
	Thu, 28 Mar 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1zyR1Q0"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89C13BACD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663984; cv=none; b=KgPJjdniPZcx8euIurBLocgMm/Wlyk1VyrXf/oCNnNANEjysbNblN/Zeo6UOePbA8jocCmUIOYYlc11NSI03N+pFnRig/048ObqaJtB7PBErcuNkCrEz7u7HEgFAlmEuR4UeP8FDMfquIJN1mVVXfECT/Vc6H97wva8KslJcbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663984; c=relaxed/simple;
	bh=UIn7MGUsViPkQt8ICxQrkMUs2JY8jgTueQwbo2IwpX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLoPcjOKcd3/3PTU5b3YXlvwvOpyuLO1cjF+z3gZCjwBAR3Du+XpybGyonAmqWpluFrseoVb5DZzeCQs78c+i9QL+ggyNbkrDD29+0CfDnB/vdFwb2AHzXM/DV9M9Nbs7mgBahvRHOoEdH2asim0QaIX7R1nmMbGjYdnFgn9CuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1zyR1Q0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5101cd91017so1767616e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711663981; x=1712268781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICkGbpRzf1cYfCwK/zqGbOtZejo0e91jUNy63Mscxkw=;
        b=V1zyR1Q0y6TqJnwmOsTdIL3JDajG1kHMyBr1E7eAPAB0UygW79aF3+NovP84MPjKPb
         ZVN/akcr/g69eumHLuHJr9sIGHyiNwaXkiY7ByObmQbiGN4OuXSinXKC6WFF72BJAy1R
         nN3CobxrOb0g//L/HuXprN5DnaAmu1pkXM+pkEthITpf3Z77gPzLHfSloTXoj8//T/Sw
         oeNFsAAh7mMTDBisCO17zKcHXUTSTVIYO5xvXZSeFH3o2v8PKxQ2Rk3VPlIkbKPbAyVs
         J85XB8nz0KoBRyLpRMBOs6h6GxuFjGUhLzZNW/b3EM3byrsy7lrAoiBg48CpuChMJHHV
         fudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663981; x=1712268781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICkGbpRzf1cYfCwK/zqGbOtZejo0e91jUNy63Mscxkw=;
        b=POxOsRMw7EkR8uTdZI65NASbj/vgdn4VVKyIXEo1J4LW8MAUYxceyLHT5fMqb580O1
         cyxnaBK+2xjWzvFR22lu8XDRXDJjxrOaxkxIkRK2sfgA+YtE1OiiSE7yZ+je0mzqGCKL
         xl8CMAnFkJvlFh0bn12IutTO9pOrzyA/7CeFhB1Cl1H3J96oEEnSxc9CWScy9NgR0bJa
         mJI9JpDeBi8Hq3E40OgqxXZGfEZKZ4KdURMIth42ThxcYR4hwn6IQpCUe0iX2OR2+FFm
         mKWhA1e8fYH5hsmn7XVk+lnFon4h+a575MGdJff/+crRusWLR7g144GbDsW1hi/BPWW4
         AcGg==
X-Gm-Message-State: AOJu0Yzjz7GPjKFWinipeVPuWfs5L3dSrfypUxxjIi8waDHrhXokseSI
	IYvwQ/KWwgWBJDOCJH7bjqsWXjcicRtO93sp8l858tlHyk/7ed88vqVBRucfCAAxoR4Y4wP+ffW
	NzRkC1cMC5g8qlDHbKYqHNNaQSFPh88tTV+AzpByOllXiJPwAv0h3
X-Google-Smtp-Source: AGHT+IHSqMcf1h2xQB5wa4ZUcWCBKayE/iQN+78kFaOeI10I6ErDFcmpdz42xUhwteOa3FVAVroi2xGibnGqS3oLTFc=
X-Received: by 2002:a19:6902:0:b0:513:d484:da51 with SMTP id
 e2-20020a196902000000b00513d484da51mr440445lfc.65.1711663981372; Thu, 28 Mar
 2024 15:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-8-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-8-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 15:12:49 -0700
Message-ID: <CAFhGd8ojRE3no8K--Nanj5PJz4oO-eG2J8Q_4579pDEEJz8uNw@mail.gmail.com>
Subject: Re: [PATCH 7/9] infiniband: uverbs: avoid out-of-range warnings
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:32=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
> Add a cast to u32 in both cases, so it never warns about this.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/infiniband/core/uverbs_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/=
core/uverbs_ioctl.c
> index f80da6a67e24..e0cc3ddae71b 100644
> --- a/drivers/infiniband/core/uverbs_ioctl.c
> +++ b/drivers/infiniband/core/uverbs_ioctl.c
> @@ -90,7 +90,7 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_m=
ethod *method_elm,
>                 ALIGN(bundle_size + 256, sizeof(*pbundle->internal_buffer=
));
>
>         /* Do not want order-2 allocations for this. */
> -       WARN_ON_ONCE(method_elm->bundle_size > PAGE_SIZE);
> +       WARN_ON_ONCE((u32)method_elm->bundle_size > PAGE_SIZE);
>  }
>
>  /**
> @@ -636,7 +636,7 @@ long ib_uverbs_ioctl(struct file *filp, unsigned int =
cmd, unsigned long arg)
>         if (err)
>                 return -EFAULT;
>
> -       if (hdr.length > PAGE_SIZE ||
> +       if ((u32)hdr.length > PAGE_SIZE ||
>             hdr.length !=3D struct_size(&hdr, attrs, hdr.num_attrs))
>                 return -EINVAL;
>
> --
> 2.39.2
>

