Return-Path: <linux-kernel+bounces-132401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C452A89940C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C470287283
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9F11CA81;
	Fri,  5 Apr 2024 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7AZFUeX"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365AE1BF54
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712290788; cv=none; b=bELkfSIGnoAYJPUQQGalFa6dcyH7lFZXg+0YY469KCF6ItM3uNiWGB+HH6uHHLCPeKn2VtYZKnOdP7jixy8i3CUVebdVXZsD3gpkhRT4LDP1KVrugCSC8OponFSCljNmJ2Oiq2TL0k2CJvt08V9OaDjfm+egYODU6xnx1P2ZK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712290788; c=relaxed/simple;
	bh=sSGNnX9g8ICe/nI+9fFx+tzAM1H87qSuQwEdqixVCdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFGY/hJrkE26RSxsWBiMIp6B1r+Cpv+eLlVCdGkjT3ZZNP3pPKL1nRO/74GAbj/+Rl5NUtrtSHlPXp/m5S+vA0364tL0Y0Ir21glispevGVhQTIGhSBe1KiG7vohK1SRIQmRR42ZQme6bMfMZiaYX2Z68o03ChcF68+hMwj6hJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7AZFUeX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a468226e135so242911466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 21:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712290785; x=1712895585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSGNnX9g8ICe/nI+9fFx+tzAM1H87qSuQwEdqixVCdE=;
        b=F7AZFUeXaGvjJZ01Zj+8D15Jij+FGVailOzLlv2MkGWBzL4uN7JtDEc2BMGyepznDl
         esadeINROvMpIdXfUk/T6wMEZj07m5mfVZxjq5/StqrUtQxRdhDzJt8r95vUaB0+AwWV
         2F+vd/yYALTpF6iRm3Q+vv9lV4gkm0j586c3z3NachzNwAtx4u5E6Ty6GaCvwWTFEVF5
         iuY1n6yU/tBxtgMTs0SwPqtg1g0jEaVwJc+dr9tNXjyQMAqEsdNPeQlss+MyTK0VV2E4
         I1nmUI9lndAMHwQD/x89TX/wCYIu+IyXBv871eQpAp4Iq0fH9/H5A2Izq5My0WGYn8M9
         BbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712290785; x=1712895585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSGNnX9g8ICe/nI+9fFx+tzAM1H87qSuQwEdqixVCdE=;
        b=v2ZwhosS073BBsarKdoX/tkz3fPHeyeyoL79kWb6jh6ITHz/sP6JIzcglcJ7x7w9D7
         ri9l+sKaWRukMFoSdstSIzpjsUBll2vA1ODb/N9+v10Dwy+D8GJuKwgbvCIgg1d7NvBt
         rUB/ty0FPr/TfDo3pX6IOPcuMdznrVaGBL1VVXT3YmKL6dxVQex2sblZ27Ch2zEtc9hY
         0NdZEpyfiUdoaQTajwKNkMCDP17izqBXAwEkIy0Gj6dgwbdqcnra5dvvxv61WrVtsTNr
         dSi8/FJ+7aA5hPCTP96elM+iE4i0wZRCPlDeZO74IGtr/u0O8G0qUphu1MuAF2ETEXHY
         u1nw==
X-Forwarded-Encrypted: i=1; AJvYcCV7q17mGRLweG/zA9wFa8/WpvdRUg0j7GPhBBs8iUj/sdjBdCHPsGczSrL7QH3r4H40Ali6MZNc/i8yjjmCuRpSfBlgqtkGaEBq4fbx
X-Gm-Message-State: AOJu0YzG90Dm+6qPF5fpjgQxYfmvDmoMzzNwKaeB3h5IcIOHWOVNnynb
	NI6qrJSbij0VyDhuq05jvSj+st4CC0Te0idwfE5J7eeB/zzDy+41YJbIEPUMxu+LFwzECQyuaK8
	oG0zbSTNlRPEPUtXfe98CKU1ZRNOj0h2RNO6qZNVIVrBzwOtbR5O1BR0=
X-Google-Smtp-Source: AGHT+IFXMl3gfPQFdp7tMwxJOn6+If6j/Vz+aioCA2I13CRmX4cfmooI0lKiHNqqVayWCY/2U3ydDK7mql0067i5GY0=
X-Received: by 2002:a17:906:4716:b0:a46:cef3:4aba with SMTP id
 y22-20020a170906471600b00a46cef34abamr166579ejq.75.1712290785348; Thu, 04 Apr
 2024 21:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405013547.1859126-1-yosryahmed@google.com>
 <20240405013547.1859126-6-yosryahmed@google.com> <20240405025407.GF641486@cmpxchg.org>
In-Reply-To: <20240405025407.GF641486@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 4 Apr 2024 21:19:09 -0700
Message-ID: <CAJD7tkZnKgPQ-a0tcB-z8rSzJuqUWhJqHpC_DDO=73x3fSnQZw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] mm: zswap: do not check the global limit for
 same-filled pages
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:54=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Apr 05, 2024 at 01:35:47AM +0000, Yosry Ahmed wrote:
> > When storing same-filled pages, there is no point of checking the globa=
l
> > zswap limit as storing them does not contribute toward the limit Move
> > the limit checking after same-filled pages are handled.
> >
> > This avoids having same-filled pages skip zswap and go to disk swap if
> > the limit is hit. It also avoids queueing the shrink worker, which may
> > end up being unnecessary if the zswap usage goes down on its own before
> > another store is attempted.
> >
> > Ignoring the memcg limits as well for same-filled pages is more
> > controversial. Those limits are more a matter of per-workload policy.
> > Some workloads disable zswap completely by setting memory.zswap.max =3D=
 0,
> > and those workloads could start observing some zswap activity even afte=
r
> > disabling zswap. Although harmless, this could cause confusion to
> > userspace. Remain conservative and keep respecting those limits.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> I'm not sure this buys us enough in practice to justify special-casing
> those entries even further. Especially with the quirk of checking
> cgroup limits but not the global ones; that would definitely need a
> code comment similar to what you have in the changelog; and once you
> add that, the real estate this special treatment takes up really
> doesn't seem reasonable anymore.

I was on the fence about this, and I thought it would be obvious
without a comment. But you are right that not skipping the limit check
for the cgroup limits would look weird.

>
> In most cases we'd expect a mix of pages to hit swap. Waking up the
> shrinker on a zero-filled entry is not strictly necessary of course,
> but the zswap limit has been reached and the system is swapping - a
> wakeup seems imminent anyway.

Theoretically, it is possible that we never have to wake up the
shrinker if zswap usage falls on its own before the next swapout,
especially with the shrinker in place. I thought it's a nice
optimization without much code, but the need for a large comment
replicating the commit log makes it less appealing tbh. I will just
drop this patch.

