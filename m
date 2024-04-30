Return-Path: <linux-kernel+bounces-163543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915778B6CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A565E1C227BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210411272CA;
	Tue, 30 Apr 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xrlTfZDE"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE317F5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466089; cv=none; b=LsDPaCSJXP8aPNMsdEMEGE4ONl6phlfBRAR7+jPLBm/L3ZXuZJa9jtbRawGb/8oMnmwKt52gjlFleQcqc8NsEtsxU3qM6W8DvIPmnM3ICbM5PMqxycbrkn4kLqaL8pd0gdZnW15X8Ix1VEOutMShiTTOmDkjI4aAYpj7JJaYUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466089; c=relaxed/simple;
	bh=jPYNUDHO8z8R/AW867spSODiXpt3EDt4BNKxe4R+5dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIUUoWyLLzFn2gosD63kY07eNgPrJfZlYcnMlpGIat57t1H6KmSoOILfjCirnDsL4XC2uDRzQGRtjraDa3S1HNUBNq3d9MK5Ar3eaQJ4TInNdlpetksexsy3UabjSVjsZhwzDD++NSenuok7ZZ0lTRMcwMQHW7GwcK2LRd3GeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xrlTfZDE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so6378995a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714466086; x=1715070886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBu8BqMTHMfO28FxxomfhI3ilqxqETOIjPW5gQNZKVM=;
        b=xrlTfZDEnzFIUxUZhOgeyPCLpPYYVfLnfxFJoROsGtd1Tt+s2n113jToHIu5l1Jr+o
         EVCRQryBrsHaAnunxqbEP8tOfnghfDMlbknMPpZLK6m9fZsCbS3+2DeFpvePw4nuTFpF
         yA0UGGB7QOUfkImt/xUBJ8UtEnM977HGPnDUMgaMBN8zhN4556SRZ9I83DfTLjBCBngL
         8pJuWTLqoW4BwgX0TzSES9RF3IjdEDF44+lGo8XZYGh52IFSj8fO2Xs22rurXkdBGcHP
         03D/foSBv94QKl8ehx3K/0xf8ZVcwCmL6jQCct+eyBjxN1Y3enUjxyoOOtDEFnskWi+I
         a/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466086; x=1715070886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBu8BqMTHMfO28FxxomfhI3ilqxqETOIjPW5gQNZKVM=;
        b=W7un3QhRSkVM715Dt6d61/VppyW/5R/ySzvv7TEGYnWM+VJwQh7p0X1Nh0/G6BXdjH
         lLp3ip1xbfjXShNtowVFzmF5HIQIVwHYpRvwa0+cTea1NHLyEjB1CU0aMXSIa/VdSCV1
         x9n2RhBBWi6Pgk2dgcpFneU1IbKixpJkZoKtf2ge3welfQLkUZbyYATf+JShYoacyY4A
         9aTjCSIrM6OP5+RWvSiAh5KtYIVRLqlmhts4oZ7iNutLo+lNsBcvPFe0GroJlFeFDFKB
         EQeBfyB6cGsU6Cotl1DCl1mer/NWg+OVuffau3CXRq6RzJsBJ64t73LO/N+YcTaIKwbn
         d9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTbXRO4CKWxvgD6K9zYvNH8GOvR5w8ddQXr74nOK8by9S2hGiNPETwvfRinosTi/BfcBH8TalTtXr5pH4sdX56kksayUUw5ySTn7P+
X-Gm-Message-State: AOJu0YyFE05rTW8up7TzYRkBZYzfKwRDSVRIr/0cdEQx+qw6jfiyagXA
	rNzZDAutVBYe5HqkQQ4bcgn2SJZsxAyyemssZZ14KJxkfQVxn6XHzWfshr7+TunnlxJLIQ3nlyJ
	A9oGRjf/Y3BxwR0Lr8Hyol0z4N7RC4vLkwYB9
X-Google-Smtp-Source: AGHT+IG9FviPkvXS5CMDFsIMeJxQdptXNvUHM9jcQby2d5RwfDkT3fUJ6oWeWv1yGvKqNb+hyZ/tP8fW9+HefgCbVAU=
X-Received: by 2002:a17:906:e2c5:b0:a55:2e77:c718 with SMTP id
 gr5-20020a170906e2c500b00a552e77c718mr8516330ejb.54.1714466086036; Tue, 30
 Apr 2024 01:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev> <20240430060612.2171650-4-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-4-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 30 Apr 2024 01:34:10 -0700
Message-ID: <CAJD7tkb0cOwgvet4MV8pAzP+R4ptHoWgFoMsdoYw_0qrcWv1=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mm: memcg: account memory used for memcg vmstats
 and lruvec stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, "T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> From: Roman Gushchin <roman.gushchin@linux.dev>
>
> The percpu memory used by memcg's memory statistics is already accounted.
> For consistency, let's enable accounting for vmstats and lruvec stats
> as well.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/memcontrol.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7126459ec56a..434cff91b65e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5545,8 +5545,8 @@ static int alloc_mem_cgroup_per_node_info(struct me=
m_cgroup *memcg, int node)
>         if (!pn)
>                 return 1;
>
> -       pn->lruvec_stats =3D kzalloc_node(sizeof(struct lruvec_stats), GF=
P_KERNEL,
> -                                       node);
> +       pn->lruvec_stats =3D kzalloc_node(sizeof(struct lruvec_stats),
> +                                       GFP_KERNEL_ACCOUNT, node);
>         if (!pn->lruvec_stats)
>                 goto fail;
>
> @@ -5617,7 +5617,8 @@ static struct mem_cgroup *mem_cgroup_alloc(struct m=
em_cgroup *parent)
>                 goto fail;
>         }
>
> -       memcg->vmstats =3D kzalloc(sizeof(struct memcg_vmstats), GFP_KERN=
EL);
> +       memcg->vmstats =3D kzalloc(sizeof(struct memcg_vmstats),
> +                                GFP_KERNEL_ACCOUNT);
>         if (!memcg->vmstats)
>                 goto fail;
>
> --
> 2.43.0
>

