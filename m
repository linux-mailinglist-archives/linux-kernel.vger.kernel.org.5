Return-Path: <linux-kernel+bounces-97335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EA18768F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4922B1C2037A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8091CA97;
	Fri,  8 Mar 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLFeSBnd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9939E572;
	Fri,  8 Mar 2024 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916929; cv=none; b=aIRa0zRwnGh28H2v0toS9XNSQ3X1CpB9HeigU2uWK5MypzEaIGC1i4qDVygslJRe8jDF/uRLqkDFioCLfwexmVx/dFA4tnckVR9a/ogtOi86KMoOLev/aECSU/8Fjj8eG7oUkT92yTEElnEvKVqQB6WVyJ6Vo6KubXoupYtxtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916929; c=relaxed/simple;
	bh=DbchbOqFFVKBM2t0Qy3IghyGibkgCCKQjmqp5ugPh1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hplqJp60Aragg6JpyGAmEJotUOZYgZJIFPfAgTBE3WYy3UH4musVRrAgC3/+cDKxCl9FxS++Wmz+0MtyMna8LfsStPAGrtq/yojNcjaBnQ/ZdYNqYGVnR3tgPiZ+I84nUTZL2v+03L29QtIdhKoxFKGl1cVdeEQd0IcFy0d3kV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLFeSBnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F03C433C7;
	Fri,  8 Mar 2024 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709916928;
	bh=DbchbOqFFVKBM2t0Qy3IghyGibkgCCKQjmqp5ugPh1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LLFeSBndw8GfNsV/ySmEPb5MqncBTviKxOluPa3GeNUNPE7PW/7eS7ltnD24mVaQY
	 3SO/vhD3cKrAbGjjdXAQ2/KoRyHxBGNA51GFG1ID3SRv6B6pJCqDgetjAbzFi8nMla
	 LDmhe5L4LC6+HUF+Olv9TL+LWkq1wbI0xJLS6GFc9thzV3uJCXlkTmDLwga7B+hwHs
	 krAj3CRlzDm/b0C7IdxRoImFX2HikydcA13mTo6DWyMzJpeN7syTlWS6eH+4yNQOp8
	 TIjGX87e82srNLEhoTWSVp0aC67JysMYXcjtzgpSJG8BM9Ct0jdNqI0wZk51I/lLRv
	 4Ahwn/JiEVMSA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513298d6859so2200271e87.3;
        Fri, 08 Mar 2024 08:55:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPRLJb3JIhXrVHG69VIVb6fFVhORu45bviN/FhpKm+4A5HeNORK3T8Xs5vtxGxLDz+zYcv90I37A4tRacKbKgwt7KcN3CeTNZ5K9Sle5sZmIyZrjCSpwpOzZYfzSnUEfzV
X-Gm-Message-State: AOJu0YwxM/IH6ov44HnN08c0UzTNfB4Gw9ptDOTd2pHJgGe9/sCezNbF
	LtiNSRRT8KEnkkDcDtiHk9AYk4/+/fq0wFTT+irG8imyLN5eBEzXA746U0Np6aigGSxyY4snxca
	gi8dezkpXjHY84mdCsNJtmk2Ni34=
X-Google-Smtp-Source: AGHT+IEvLk7UHtO38Nms4JK1shCpzamyjWivk7RaeHiTPVJ29LLn/xdDEywWh2pxUZUB8z7i+GezLd7z0oD+SCjNhGQ=
X-Received: by 2002:a05:6512:711:b0:513:2900:1f5c with SMTP id
 b17-20020a056512071100b0051329001f5cmr3428004lfs.59.1709916926779; Fri, 08
 Mar 2024 08:55:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308120712.88122-1-puranjay12@gmail.com>
In-Reply-To: <20240308120712.88122-1-puranjay12@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 8 Mar 2024 08:55:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7Do8c8cA6rVykhVnFRgKA0s6nO8JyGXkEB7gm94KR7Mw@mail.gmail.com>
Message-ID: <CAPhsuW7Do8c8cA6rVykhVnFRgKA0s6nO8JyGXkEB7gm94KR7Mw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: cap BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 4:07=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> On some architectures like ARM64, PMD_SIZE can be really large in some
> configurations. Like with CONFIG_ARM64_64K_PAGES=3Dy the PMD_SIZE is
> 512MB.
>
> Use 2MB * num_possible_nodes() as the upper limit for allocations done
> through the prog pack allocator.
>
> Fixes: ea2babac63d4 ("bpf: Simplify bpf_prog_pack_[size|mask]")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Closes: https://lore.kernel.org/all/7e216c88-77ee-47b8-becc-a0f780868d3c@=
sirena.org.uk/
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  kernel/bpf/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 134b7979f537..83a3b6964e54 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -893,8 +893,17 @@ static LIST_HEAD(pack_list);
>   * CONFIG_MMU=3Dn. Use PAGE_SIZE in these cases.
>   */
>  #ifdef PMD_SIZE
> +/*
> + * PMD_SIZE is really big for some archs. It doesn't make sense to
> + * reserve too much memory in one allocation. Cap BPF_PROG_PACK_SIZE to
> + * 2MiB * num_possible_nodes().
> + */

In BPF code, we prefer a different style of multiple line comments:

/* PMD_SIZE is really big for some archs. It doesn't make sense to
 * reserve too much memory in one allocation. Cap BPF_PROG_PACK_SIZE to
 * 2MiB * num_possible_nodes().
 */

Other than this, this looks good to me.

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song

> +#if PMD_SIZE <=3D (1 << 21)
>  #define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
>  #else
> +#define BPF_PROG_PACK_SIZE ((1 << 21) * num_possible_nodes())
> +#endif
> +#else
>  #define BPF_PROG_PACK_SIZE PAGE_SIZE
>  #endif

