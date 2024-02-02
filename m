Return-Path: <linux-kernel+bounces-50673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7968C847C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166F61F24FB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5526126F1A;
	Fri,  2 Feb 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzC1Vcbt"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D658592F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913351; cv=none; b=H+mBFiwWBYeGBDqwlXlKyji6zCHsPBBkHm/rIsiemhfC+r0CHnRQ0GGb3+4xZCXIUfz4H1Bo/BdW/Z/uhhuSL1P+0pneJxrDpYMvNMZTRd4a5pR66xIrYZ8Q+k1Z0zQJzNHCGpCcrU/4mBIAP0dEOrHZJbXBPAWWdOVyRiMm6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913351; c=relaxed/simple;
	bh=JXT5OHVVhhp1OBhwJZY4IYHGL6yAqJAwyumvJZtYG88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTCpLpxK7O4gFrqoM03Ohagb9lXNqLRjKrM3uq03RIl8yv8f1Du6Y45DJugN+pptFnjkah/171oHCfy23Gn9Ay2KC2m7DT/RgmvglwYEJg523m41p/zm3JhnyZsYg9lOEriFZJaxTbqEsgMgTtY+7563p/jBOUl4qxuGMdJpcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzC1Vcbt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a36126ee41eso350993566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706913348; x=1707518148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+qQwjL7b78T10XqvIbUCoEdwqpS1GzNQCRv1zXvcjA=;
        b=tzC1Vcbt7s2jvRNsJ1y0segbBZ8w5zNy5mysJ5SV/cDqsB00MQfqQC0re/n2qIMcpk
         0M4BuJOc7cAtwcyhN6xNkEFc4WtLmX5mOj+zyhC+bwL/VQKXKshDjbdB5XdsIRE+HsWt
         pQqgmNqCzG0MsyfA//Ny3LlfzQ5f7p8HqShNlu4kqQqML7MpyoFVcXeNGk1moLb9TKGa
         K85q65tQjGPX9farUClguQxNPaUqA8WRe7ZnynlpLcmuvFN0oIKXnKgA1UDfemxOkHpv
         ulVpwzxGH7y9O0jA6VnjDDRR5XVkNucAB2kzAzA3Uj+Q65PjJaJuYaApHzTlr/LmUW1r
         AZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913348; x=1707518148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+qQwjL7b78T10XqvIbUCoEdwqpS1GzNQCRv1zXvcjA=;
        b=AknmMpwkUM4rhKkGiUf8CQxHLLoeO1H+jmrb0/0gRmb1BKJIU+6TGvnXM3IJxf4Ns9
         c8e4BS6qKbifE1oNcDF5yRZxTgsqKoTvnukbVwsh3Gg2gEQD/DfIFqP+YeokIsLMlPGx
         lVY7Osqcac29/O63iPRCDHzXUkb7qVIHkrCOeU++Qp6OXqKipaukCzOAYG7eRPByLlgQ
         qDIueiNHFbxckgG3faGMxwJrqQ+s7Sk9dxJKsY64bgugUQ2g2yqpr9+dMqq1fgAEf6O6
         Gn1Xp7unZH67uetIE/H5DKlyNTd5eGj0No1dnHX0MHlWekqHY/D3QtXfVvS1+MQ8siM7
         vS3A==
X-Gm-Message-State: AOJu0YwoNi71BoMDvcyMZa9LdVoZstw4efWhhF8JvWN21YRbtqC3cxzq
	VgoYM2uI0IeqiNduGpEQGaIlcasVuW2xsnoDjnWbmJouPdLgYrE3mZKrV0/Vlo+m4lPqpLSo+ZW
	/TUaiH/GHoHM7ewFUPPBRnlly3+HvQTTR6XNp
X-Google-Smtp-Source: AGHT+IGvB459/BXAdardPQcfjxRtp4LvVuLJxT3vVQFzFdSPsDtLjHnCQ98ZXWaIPxQz5tA8GbHQnHBkHHBxQI1eHnw=
X-Received: by 2002:a17:906:250c:b0:a33:b64f:48c1 with SMTP id
 i12-20020a170906250c00b00a33b64f48c1mr6152350ejb.21.1706913347656; Fri, 02
 Feb 2024 14:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202221026.1055122-1-tjmercier@google.com>
 <CAJD7tkZh=M58Avfwx_D+UEXy6mm18Zx_hVKn8Gb8-+8-JQQfWw@mail.gmail.com> <CABdmKX3_jCjZdOQeinKCKBS3m4XS8heE9WMDU-z1oFpCcPc5fg@mail.gmail.com>
In-Reply-To: <CABdmKX3_jCjZdOQeinKCKBS3m4XS8heE9WMDU-z1oFpCcPc5fg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Feb 2024 14:35:10 -0800
Message-ID: <CAJD7tkaRSeWV=UGT8KbnwjehsckVGnncL738qThV9hoyvEV95A@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: Use larger batches for proactive reclaim
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com, yuzhao@google.com, 
	mkoutny@suse.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 46d8d02114cf..e6f921555e07 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -6965,6 +6965,9 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > >         while (nr_reclaimed < nr_to_reclaim) {
> > >                 unsigned long reclaimed;
> > >
> > > +               /* Will converge on zero, but reclaim enforces a minimum */
> > > +               unsigned long batch_size = (nr_to_reclaim - nr_reclaimed) / 4;
> > > +

I think it's clearer with no blank lines between declarations. Perhaps
add these two lines right above the declaration of "reclaimed"?

> > >                 if (signal_pending(current))
> > >                         return -EINTR;
> > >
> > > @@ -6977,7 +6980,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > >                         lru_add_drain_all();
> > >
> > >                 reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > > -                                       min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> > > +                                       batch_size,
> > >                                         GFP_KERNEL, reclaim_options);
> >
> > I think the above two lines should now fit into one.
>
> It goes out to 81 characters. I wasn't brave enough, even though the
> 80 char limit is no more. :)

Oh okay, I would leave it as-is or rename batch_size to something
slightly shorter. Not a big deal either way. Going to 81 chars is
probably fine too.

