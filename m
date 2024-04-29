Return-Path: <linux-kernel+bounces-162762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B650B8B6036
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D957B1C21B25
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF127126F03;
	Mon, 29 Apr 2024 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJAGWBjX"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467A8614C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412153; cv=none; b=pDMGnLtI/JcOzp+pPBUVHEEeihASGAEiNN3WnZJgSVGprw8DIAe5HD/FNTN6n6qBO+N86oAfrNuQQmntU5soLBlK+uKArbUnFGeEyg7PSsjM5M1c66uM1JhX1d4IspPBuFFOwUEVQ7fVOgY1aIOhBWq5AVvvx96x3tjBLjsriI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412153; c=relaxed/simple;
	bh=kKB+Gx4VijAcXAdpEnC7HogMPoCF3TjIDI8x/Ckk8xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgkIu6zoY8VDBSAIcW9pDtn+9smTvf8rqAQ98eiFRw7Jw7yVEiEe67rr2m9J4xPH6We/gPi022kRkojUlq12W8NE84JGEUSbk6u59Ca4JNYqxwS24u9H72yxhPfiIjn9h/3LjlBICOZmiR80+V2/5g2cDRHDYeBrH/rOZv+HqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJAGWBjX; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de5ea7edb90so1616514276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714412151; x=1715016951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7wVsqLptnLKS5hiDCshs3Dr+pCekMHSh0FCkw4ggDQ=;
        b=pJAGWBjXDatZeJpx+adtQsGQXp/TgaWgNtc7yd6s3s4yiVKwCC81GlXeBLA55B1hY+
         tbo2XD6g1Y1p7iTVNC7xMDMOx/qheZpGkQRg9YvHxA6K21h7I8zrfQPGRsV1+lJJSQ5w
         M1J5nJScD7vVF7ArdueghTFrJ2Xyy+L6aipUebsjOlJ8reAgEBF4hvFJICIlqYMHodGh
         cIjL2nojM83/ITiE4I7QIuqh04jzS3lM29R0HzFn+nKl0dhGuB6NoqZ39ChXe/i4gelz
         YtJMbrVZT2iB+EUvqO57z9O28vfqz8x783pKJVmVTjGQmQN4QB7gBqE/ELwm5s9iR6DU
         JMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412151; x=1715016951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7wVsqLptnLKS5hiDCshs3Dr+pCekMHSh0FCkw4ggDQ=;
        b=WBo41CVab17ndYexa26E3Y2Qg3ZTKnEJok5EpQfEcNGbFJeZIJjw79QuldbHW2FtJ4
         xfS4nsh75AORbQBJjr+BFg1uXCedLirD2wVQjdn1ZlJxS60HNQc4Rg76/hspS4org6MQ
         6q/u47ZYF3ZQ8laMFw0UHL8cYbfjv3HLn4EW6zCDweVsUWZ5XywbF6HSDJbdvaoRzaFJ
         eyBo7c12zsHsXdbhbeGrKn9fVj9nWrLj4MGQAEWdVp2+hoY7ewhwD6jYJf+YtfsR/zOP
         jV6zgcbBG0qDN3y2bI9EEPSAhLa+94VPtwiReow2tWpEu2H9L+Yqe0CyMUxtVaGdP1hH
         tgEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUqTOe/EFr4x4auSF3w4t/enQPUBFfuzUPu0rjJOaJHbgQ6FJFkW+wmo/O2Y9+nsssEOXMm35mUjE5X6zM/TW0EBgI42bvwVlOEAPs
X-Gm-Message-State: AOJu0Yw6gwoJZ19vIT3RM/Y2E+SNQYSMpyYDc8g/sBPetxXafbtN588J
	Y5FUpbESplXW+7mLjgq0mTNJHaT6ksBIgy6C1qrZR+cGMiJ2wLeK+/4EwFHqy6e1nue4mWkOPMk
	8tGFqJk0vm1YZM4cs30cL0JOtnEB62thxo9G8
X-Google-Smtp-Source: AGHT+IGze69SzvgF+laQKVNenGfnhfSWQBgrc5CamDWJtv+XCFQ6jEAcsZk7GmgDzGBWxcDr4R7RpmZIhxez25z/hY4=
X-Received: by 2002:a25:5:0:b0:de5:588e:40c8 with SMTP id 5-20020a250005000000b00de5588e40c8mr11793575yba.56.1714412150470;
 Mon, 29 Apr 2024 10:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427003733.3898961-1-shakeel.butt@linux.dev> <20240427003733.3898961-4-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-4-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 29 Apr 2024 10:35:38 -0700
Message-ID: <CABdmKX0Mo74f-AjY46cyPwd2qSpwmj4CLvYVCEywq_PEsVmd9w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] memcg: reduce memory for the lruvec and memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:37=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> At the moment, the amount of memory allocated for stats related structs
> in the mem_cgroup corresponds to the size of enum node_stat_item.
> However not all fields in enum node_stat_item has corresponding memcg
> stats. So, let's use indirection mechanism similar to the one used for
> memcg vmstats management.
>
> For a given x86_64 config, the size of stats with and without patch is:
>
> structs size in bytes         w/o     with
>
> struct lruvec_stats           1128     648
> struct lruvec_stats_percpu     752     432
> struct memcg_vmstats          1832    1352
> struct memcg_vmstats_percpu   1280     960
>
> The memory savings is further compounded by the fact that these structs
> are allocated for each cpu and for each node. To be precise, for each
> memcg the memory saved would be:
>
> Memory saved =3D ((21 * 3 * NR_NODES) + (21 * 2 * NR_NODS * NR_CPUS) +
>                (21 * 3) + (21 * 2 * NR_CPUS)) * sizeof(long)
>
> Where 21 is the number of fields eliminated.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 138 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 115 insertions(+), 23 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5e337ed6c6bf..c164bc9b8ed6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -576,35 +576,105 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgro=
up_tree_per_node *mctz)
>         return mz;
>  }
>
> +/* Subset of node_stat_item for memcg stats */
> +static const unsigned int memcg_node_stat_items[] =3D {
> +       NR_INACTIVE_ANON,
> +       NR_ACTIVE_ANON,
> +       NR_INACTIVE_FILE,
> +       NR_ACTIVE_FILE,
> +       NR_UNEVICTABLE,
> +       NR_SLAB_RECLAIMABLE_B,
> +       NR_SLAB_UNRECLAIMABLE_B,
> +       WORKINGSET_REFAULT_ANON,
> +       WORKINGSET_REFAULT_FILE,
> +       WORKINGSET_ACTIVATE_ANON,
> +       WORKINGSET_ACTIVATE_FILE,
> +       WORKINGSET_RESTORE_ANON,
> +       WORKINGSET_RESTORE_FILE,
> +       WORKINGSET_NODERECLAIM,
> +       NR_ANON_MAPPED,
> +       NR_FILE_MAPPED,
> +       NR_FILE_PAGES,
> +       NR_FILE_DIRTY,
> +       NR_WRITEBACK,
> +       NR_SHMEM,
> +       NR_SHMEM_THPS,
> +       NR_FILE_THPS,
> +       NR_ANON_THPS,
> +       NR_KERNEL_STACK_KB,
> +       NR_PAGETABLE,
> +       NR_SECONDARY_PAGETABLE,
> +#ifdef CONFIG_SWAP
> +       NR_SWAPCACHE,
> +#endif
> +};
> +
> +static const unsigned int memcg_stat_items[] =3D {
> +       MEMCG_SWAP,
> +       MEMCG_SOCK,
> +       MEMCG_PERCPU_B,
> +       MEMCG_VMALLOC,
> +       MEMCG_KMEM,
> +       MEMCG_ZSWAP_B,
> +       MEMCG_ZSWAPPED,
> +};

Unsigned for these? All the values are positive now, but I don't think
we'll get a build warning if a negative one ever got added, just a
crash or corruption. BUG_ON in init_memcg_stats if a
memcg_stat_items[i] < 0?

