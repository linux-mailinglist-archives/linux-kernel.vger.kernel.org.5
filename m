Return-Path: <linux-kernel+bounces-160842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CA8B4372
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD19283CEA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC38738DC7;
	Sat, 27 Apr 2024 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHm3kNt8"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE4383A0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714180772; cv=none; b=HcGIeNIzO+9sHaU82HjEJPhJy4EXl1BUlEiQEgpLDVKfXZteJjpalax28/GKwDEvYlC6WLUWjOr2wbnLs5fheOYKrg0jZnvyQMNySgy2EJot6LlaypDEHkE7RrwxwBUzBNilchozXDhvIeyB2uBONM5nKhBdft1X5r1kSIZOkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714180772; c=relaxed/simple;
	bh=F8/x6WYm3mQ7WVqeZZcGcM1pO3CXxx3F+6ucXZwlnGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQO+Nvml8Ks+v/gcQWfAUUG0rRMWVAblZEPGVsr2lEDr0voTBKFq9IKFml1oHcD56MjmL5ZFBndW3Stnl5SSzRcW1RdDQMkB2mF5/HBN5sNDQAPX3d/ZGr1GpfWIHNhBySBfuX5KFGHX52+4tLS+UGs/Ot9pJYla8j4IJTKvx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHm3kNt8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58e2740cd7so55401066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714180769; x=1714785569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8/x6WYm3mQ7WVqeZZcGcM1pO3CXxx3F+6ucXZwlnGY=;
        b=bHm3kNt8H14XWShuRMXV+T+TPO/goGmo6VT7DRsx6EanYdqbKvuXkjsd+o9ujxzy9u
         nyhmcVCLvLu5CQQI3CJPfMTGHS3kGu3/Yap9b4H6BKs5jMBOfV/k8La0CmbgGbto3FJ/
         usyRT8GhnWX+S+vruKhotvz69vhW17UI7fBMvJRz/glR3/kMTroGtaH7hevlJxXOHYnO
         Hp+kSqyZHiuDZTap8vJvZOwwT+jyetcf8ruPTd35LY111xqm7mF6RWvBjeJ/jrKghqts
         TuUedxxL1jMywTIGJACu5yghZV20ojGlpTAPTv4ESMTSMtycbMnBi11GKoEXMUWtcqKu
         hC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714180769; x=1714785569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8/x6WYm3mQ7WVqeZZcGcM1pO3CXxx3F+6ucXZwlnGY=;
        b=D5gBfTBuUlXTDcIQk9VLrCWKa0Bz4IUEF/aGOPyDbvWWpcckE+YSXJ2qHIsw72yeQP
         vqbFULgw+sEnzpq5fLX+K9OXQ2oFw9FX+YChTIABV81eSSQfsgRccGAAd19CvCsHrkOZ
         vDNIiG38AnZB5IfsK0DKypfERT9T1aFaoSQZ7F/6O6XKqRfFqiFcCxMuXhXP9IU8t5M7
         X5jcz6cDj9iffh3j4Pep4S/Hz3RcqDPqEAhjPhT/1b10421kZS3VLZfYbOubg+x46mLy
         OQB7WGFQr+3R5+gBpVPm3dvwU64zbrB6Fn8u8s6ZDzOCGnWx4t5RI7lNBRmK96BsCLqL
         plJg==
X-Forwarded-Encrypted: i=1; AJvYcCXREObHfIcft8Izm8+I2R4K7gBaPy/5p1zj1lm2xKdiPym1SDj+P9ph0bfpXtOoGVwWE23J0YrhFZz1BxbCqKWQg81bsPjPKLPtl1yY
X-Gm-Message-State: AOJu0Yylwt0wMFalmcYB0iw2I1eIyx+WIga5x4igKIjbTkPl1TFXGFDy
	sttg4GPXVUlyLo9Vs8j4z9fsnv1nolCEyot3lf/+46xfTGxwUJR/hGBde6HrnkAmeMmQrd6yQ1U
	+ghrFH7LsN37Fmsy34qDgmdn0FpF5ujCEa9ng
X-Google-Smtp-Source: AGHT+IG0f9S4ycgs6mnMWIYUkxy6HkdXLaCSm8YGZNVaE99RGDxlclwkVJR5scPSkfl9vXt65rgn3OiQEijC1VLK9TY=
X-Received: by 2002:a17:906:4945:b0:a58:e3d5:87bd with SMTP id
 f5-20020a170906494500b00a58e3d587bdmr653470ejt.26.1714180768557; Fri, 26 Apr
 2024 18:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-4-shakeel.butt@linux.dev> <CAJD7tkY2EwtOHh3w=e0+OC3gOPb9xCC7C36BhM0RHYPv184U+Q@mail.gmail.com>
 <uewheydidpkiqywtc4m6dcmvlfj7raocpngtbqocksxvf4nyz4@srxnazpqxvzy>
In-Reply-To: <uewheydidpkiqywtc4m6dcmvlfj7raocpngtbqocksxvf4nyz4@srxnazpqxvzy>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Apr 2024 18:18:50 -0700
Message-ID: <CAJD7tkbj1hdka1wJiRZA+nOXFb3YW3adN=CENp2F+FACm7N+Tg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] memcg: reduce memory for the lruvec and memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 6:16=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Apr 26, 2024 at 05:51:23PM -0700, Yosry Ahmed wrote:
> > On Fri, Apr 26, 2024 at 5:37=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > At the moment, the amount of memory allocated for stats related struc=
ts
> > > in the mem_cgroup corresponds to the size of enum node_stat_item.
> > > However not all fields in enum node_stat_item has corresponding memcg
> > > stats. So, let's use indirection mechanism similar to the one used fo=
r
> > > memcg vmstats management.
> >
> > Just curious, does the indirection table cause any noticeable
> > performance impact? My guess is no, but the update paths are usually
> > very performance sensitive.
> >
> > I guess lkp will shout at us if there are any noticeable regressions.
>
> Yeah and that is the reason I made the indirection table smaller (i.e.
> int8_t) to keep more entries in a single cacheline.

Thanks for pointing this out, probably worth including in the commit log :)

