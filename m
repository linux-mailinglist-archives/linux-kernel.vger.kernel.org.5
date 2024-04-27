Return-Path: <linux-kernel+bounces-160828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B088B4353
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1391C22A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60329409;
	Sat, 27 Apr 2024 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByCGYqTv"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C94C99
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178610; cv=none; b=gPaLcU6dy6av01ie7eX049Y46YRr48fhplpWcV5N7jWNdntfhfKzBGg4jIh5oJTTh2bOYO+e4skOZIW5xqWkusl/0TyzEi984j+Iq6RpuD/7YOcz00+OoRf7NkXyCeXlCz76iJ5e6a5A6SCxa4tFRTkGRyvy4GFSijgAcmbqaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178610; c=relaxed/simple;
	bh=8CbY436CyB1LG0mIf6lnhnsp9BSccmu06BQaEafvmAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCoRo3tYKEFi9I5TSgOUmF7Qj7qtUJDSXSTlRpudEAkpvrIhtnraYhImRYY/TpQfz/hoMxwAQX+9wD7ku43zNcstAUJGnYY0WScwrinNunVa7E7UW6Fb24uat+5ciL/asE5q3kpVMunk8Xe8xGv1K7Fx9Tq9VOqm5qSyCM4XWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByCGYqTv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a56d7d457a1so325879666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714178607; x=1714783407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAV5lb9sQLlVxGGdRZG8Wcfo2rn1ufwq+aieY6fQ3sM=;
        b=ByCGYqTvF/aPrwEteOGHmNTlBbeT/8EYRWRjWnqmMF8F7os2xBPrxlWP2dgAuiq6wq
         nk4HAIx0Q7aIZweea76uTH/HC3D0ri05Nk9+nxEmdV6NLUIFYRObd3wWHbxV+gEJj80s
         /EqwGkO/EAbCHxEB9dR2Y5h9ov22NxMWZtlrBA4cYpQ6+tO0ze8Odx0XSQXU6ifbXgoO
         SqjFtEd2UfuHqmed0dX85LmJ67Jmg+wyybuMMM3th7iD9QPd0orEEVfF4zf9b+EUP3FQ
         pa7S7A5PgyII9oSa0sbB0jvZItoVN3ndEqhmEnRBQqsfJlBURgFr5+DUto1rLszTjsn4
         4Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714178607; x=1714783407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAV5lb9sQLlVxGGdRZG8Wcfo2rn1ufwq+aieY6fQ3sM=;
        b=EsRXsJdZaI3uh/a3SF/IkqZn5xb9DZijAIvBqlxlEljjdB/fA65ONpT2vZfhMZOf5f
         SbIaBuxZsGaZ4FC1bQ8OxT3mi0RM2gtxMjIxTbI7wspbUAm5z/Gml6ErRARzjuZcpRD6
         V/TMakWOEyOCwhA4gt4837inuinWJ/Cr4WyLie+vuWakcQzNQLrnvRcEsLNcX0f9aNg+
         KGm9PEtqz6t8zZVuZhUVN/hlzQYHKTcgErgh+/RJ10zTNUIGpgudyBEnrnrUjXvncitA
         4eZL21aDfUAqxXgKpxWdLBgTSFmG94MAFnCwJMdm4Pjhd72PN+4sU9viCZDOMLa0pfAL
         ctYA==
X-Forwarded-Encrypted: i=1; AJvYcCXHEE6ZGrJRLJHAnXVzWh2XpdBwi+/S4fmJi5qeo9fQP0mPQQX6AHmjEL/FVnNJ1uBuicAStgHKUhCny0wyVF+7Fe0f1EsoYSOaOZCd
X-Gm-Message-State: AOJu0YxZ+6YrMREVja/Q/LsDePddrVPmXmyJRylt4EsdcFYlcX0sK3rN
	B6xiY879IpQR7nZeSA6sq67dmLpG3eqlUkAJVt/1NqqlCjWB+RNS0+prIzkzGVEn+L/gHLNScJ7
	K9lQMV77/kfDoa98PJBUCLKSM4/hJt2Yavn+e
X-Google-Smtp-Source: AGHT+IHvTq7qhe5Gj4WiZ0O8rfvc72H94d5tMQE1Rjx0WZKcH4BC6WYPuiGa8QxBJcIIiaX/2Rd+QFMNsz7dirDTnlw=
X-Received: by 2002:a17:906:2dda:b0:a55:9e16:f005 with SMTP id
 h26-20020a1709062dda00b00a559e16f005mr2853749eji.57.1714178606615; Fri, 26
 Apr 2024 17:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427003733.3898961-1-shakeel.butt@linux.dev> <20240427003733.3898961-2-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-2-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Apr 2024 17:42:48 -0700
Message-ID: <CAJD7tkYsz+v9z=3N3dCUFP-9L3RazVkQU_6Cuy0o8-0Ouq-S5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] memcg: reduce memory size of mem_cgroup_events_index
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:37=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> mem_cgroup_events_index is a translation table to get the right index of
> the memcg relevant entry for the general vm_event_item. At the moment,
> it is defined as integer array. However on a typical system the max
> entry of vm_event_item (NR_VM_EVENT_ITEMS) is 113, so we don't need to
> use int as storage type of the array. For now just use int8_t as type
> and add a BUILD_BUG_ON() and will switch to short once NR_VM_EVENT_ITEMS
> touches 127.

Any reason not to use uint8_t (or simply u8) and U8_MAX (instead of
the hardcoded 127)?

>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 602ad5faad4d..53769d06053f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -607,11 +607,14 @@ static const unsigned int memcg_vm_event_stat[] =3D=
 {
>  };
>
>  #define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
> -static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
> +static int8_t mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
>
>  static void init_memcg_events(void)
>  {
> -       int i;
> +       int8_t i;
> +
> +       /* Switch to short once this failure occurs. */
> +       BUILD_BUG_ON(NR_VM_EVENT_ITEMS >=3D 127 /* INT8_MAX */);
>
>         for (i =3D 0; i < NR_MEMCG_EVENTS; ++i)
>                 mem_cgroup_events_index[memcg_vm_event_stat[i]] =3D i + 1=
;
> --
> 2.43.0
>
>

