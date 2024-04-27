Return-Path: <linux-kernel+bounces-160835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1398B4365
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC53B213F4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75122D052;
	Sat, 27 Apr 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nw7zDSBq"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A7320B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714179536; cv=none; b=iYV0oHJ/Ml15ztVUbtVezkLNFu08PZO8GH+UkBj80wp9nOAn89gtB4VtySwaLsM/pZEmo5EikLISG4GptbS0EuuzS+o5Tc+U3jMcMmGJz5xKJqZDbpUAYbmaQVYCV/wnjM1cclw25u/h4tkciLWGgja5GQssGCNbwX+ALkACisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714179536; c=relaxed/simple;
	bh=6ouwrM0c0aq5btYyMAv8dDhjILu6rbOiMes8jZbrJXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4qV3qFXdNLTvjAfeJkoGB6e/PPnw5j7bDzEoOCiOzNMFPhtHnE2uysNcDdAIn3Lw+iQSmPN2DdKwH7OJ7dpEqqNmKQ6LX1uhRe5W0ISID85B4yUQIObKqsQFUUbUzOjWJ287Rvm+jEBbxQW7l1Z/feVzWUWV8q6zU0pXOj/rOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nw7zDSBq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so693374a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714179533; x=1714784333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSat3VRqn3nH22+jIzgZ3SLdh3nYoy1+0NoyZK+oZTo=;
        b=nw7zDSBqcFdE1zlhL9uTB0mmRSpnFy0/Y9aLEfuwzr2OD7mFsF50S7Rezw/6cTDWp1
         vKTInRw/Vchgrq971x7wJBqY5c8yf/zowdRF1/pFErlf6wRE37XXjCSyah2+/WpIhqbG
         UtxUdZa+S+XpgffbfgzExzKccJDg7R+yJH+gxgQJTLvQqQJkjnLaQuODZVgVQz6nkpBl
         Qx1H/xy5gDSJAZo63D6TaR92/eZspuc5QcCB/xAsEvDQA30cGtYXVQFFmu/b/o82Q9ba
         rGz+ouT0ekrPJdLV7aD1wHE+7c2lmaSoGgGGSAWiMz9Rza3IKeb8rsVY6FmH3vVIi2Uv
         csBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714179533; x=1714784333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSat3VRqn3nH22+jIzgZ3SLdh3nYoy1+0NoyZK+oZTo=;
        b=kMHT50vLgumS8lPdkpyp+K9+mddkz7R22KqZHy1uhTyb312EA7IipFW7758OzBsR1A
         Wj7TAJmdA7U8VxVaL1oIKWMDRQg2t1x1NwOwXxqp2B7RURLRMdtyr8IFhfHH20S/6wT+
         3noBJKgUpJtg2UFv53XAS6Z0ccfTLoFaoHPfsNUJx8/1dkY3swoVTV7+8jrxjLAOoYjI
         qLij7q68uf1PF8eKr6OWi6Zrq9reHvSY5xYQvuQg96JhCnNdm7vlgjkwsncCvl92Oeoa
         5tjC3vpruST5Qkx8iErp2tfw7fk0GIAu+yEDvqM5vV2a0TvqiUBtM/n8yoTmdsmbFs0U
         w9mg==
X-Forwarded-Encrypted: i=1; AJvYcCX2WAXDTP8AbwfD0v0LIp81Bg3AU7FlvNsGhfuUycUduedV1zkYmXhs0Sd5ZxFXQHbEzI8xawRTDir64Fbd9VUERB1PRZrlG1HpWMll
X-Gm-Message-State: AOJu0Yzakp0q0nr46ZQFh8iOu/KQ3CxRh1rMiFOUMUerDJY2r5jhPGgi
	EzuoxnSQ+vFn/xgJSbxjCc6joQxGuRSeBj0KT7BDI5aSDUMOhEdRNPzg2L/vCj8C39ACVeR/LpY
	vlKNDuxrC66magIgeMJznIDakXq8vN+QYDCGN
X-Google-Smtp-Source: AGHT+IHrFjX5wTmKi7PvniaysCkDbK8sy8DKFkZ1UTsDu9YwftHSAjROVe4NnE5YpzMZ3uQIIP5NMmN0u2N+0w0uihw=
X-Received: by 2002:a17:906:7f03:b0:a52:6435:ef09 with SMTP id
 d3-20020a1709067f0300b00a526435ef09mr2951843ejr.76.1714179532735; Fri, 26 Apr
 2024 17:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427003733.3898961-1-shakeel.butt@linux.dev> <20240427003733.3898961-6-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-6-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Apr 2024 17:58:16 -0700
Message-ID: <CAJD7tkZJBBOfhHXfweJu367ov0GnppLTiUMLdoq=TcWnqu2q5w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] memcg: pr_warn_once for unexpected events and stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:38=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> To reduce memory usage by the memcg events and stats, the kernel uses
> indirection table and only allocate stats and events which are being
> used by the memcg code. To make this more robust, let's add warnings
> where unexpected stats and events indexes are used.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 43 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 103e0e53e20a..36145089dcf5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -671,9 +671,11 @@ unsigned long lruvec_page_state(struct lruvec *lruve=
c, enum node_stat_item idx)
>                 return node_page_state(lruvec_pgdat(lruvec), idx);
>
>         i =3D memcg_stats_index(idx);
> -       if (i >=3D 0) {
> +       if (likely(i >=3D 0)) {
>                 pn =3D container_of(lruvec, struct mem_cgroup_per_node, l=
ruvec);
>                 x =3D READ_ONCE(pn->lruvec_stats->state[i]);
> +       } else {
> +               pr_warn_once("%s: stat item index: %d\n", __func__, idx);
>         }

Can we make these more compact by using WARN_ON_ONCE() instead:

if (WARN_ON_ONCE(i < 0))
         return 0;

I guess the advantage of using pr_warn_once() is that we get to print
the exact stat index, but the stack trace from WARN_ON_ONCE() should
make it obvious in most cases AFAICT.

No strong opinions either way.

