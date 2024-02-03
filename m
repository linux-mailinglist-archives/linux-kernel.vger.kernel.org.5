Return-Path: <linux-kernel+bounces-50911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D18481C5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5883C281D8F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4912B6D;
	Sat,  3 Feb 2024 04:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SpiDVxQj"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2473BB38
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 04:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933619; cv=none; b=Jwv1gdfV67XbYMO2a/hJtJHQbNpli8Dv6mw1sqbkL0vWwJZjgiSj+r8tD5heUQeWPpzvZoKRGGAkc4zznlDcZ/TBEQU/7akpuv1lbZRROkqL6QUvmxTGEfmQBGAiD097W7D6xJQErp9Ge6hVeEda//Zq/EqdIQY0cBTQGTyK8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933619; c=relaxed/simple;
	bh=aukrydltDtElqxloaQOiwp7MBnZYxbVEKC7CRknU2oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Psh+2fDdbNWZr2Qoa+HURYEAuORYlSJs2POaem4QfN1u00fn6zujO5h9+hiclT6OwZgoLMYpLxj4jfcKEF9iRuXpl70Q4VRkm/BNs3eYk9jm0BAztqyLmz77mpX48J1r0/Hpe51yHznEUMwbx7T91QAJ1godbZbq6N3Brudkne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SpiDVxQj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d5ce88b51cso111585ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 20:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706933617; x=1707538417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2yFEK+mYkeNhR2BjzLuPlzJOrsqLmK/m4AY7BXlyUI=;
        b=SpiDVxQjyLF6yj2FkBYdnNxUiyWlv5++g5kOenmNxSjP/0GcE4bR1pjVf+PmTzrstR
         OaQAbd4QiBULdAgP0XE7dCTIqhHaWuffPQjsJQP8dpLh10hRVyk4uy+YVt0aIeZwSXbt
         eqiebem7/ao2F2g9vmolHqz0uNkU33qqeAO2LkHFVmK42Wy9ujKEX2Rlns+ry2zIGzHA
         ey3QQU8I4mhqXZ4WmYsexlt28hwidUCG5puc9YbS6isHIi8whXpDEcz5GgzjviIe4Hw7
         2ZhY5kJAS3yxf0P+dDOaFMzkcfbO62xg9B9Da6qxTKgAP+3R8eSzm7tyA9ga8320j06E
         28Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706933617; x=1707538417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2yFEK+mYkeNhR2BjzLuPlzJOrsqLmK/m4AY7BXlyUI=;
        b=g1jwBZfl0urTjZvRZ/jWpwkRRp2qiD3cqDKaangob5eLohuneTn9kJsdsw+ra2ZyzO
         RoEEFDnG8wuXPt9U3oK3DSL05D5Bbo6uHw8H9zE2Scn7tKxpAWhwEmdRSM8phC2CscRz
         ybxzGuwq8TEL8h4N1RV9yrAEDt0uT4upLj9oYR6p11tzeiDadaxOTQ8lC0W55+Puk0rT
         VYslM8nseM4fDNOEkBcwCYsb5onekLnKDGwxiXIeBGh62JNCGrP81Q3lGfOJK8AnHggx
         AQ1zIxIv+p/5EX/diyLtdlI4q6hbL+Oz8eIyE8utiq3uVHHKPHBFu6j0UtplYMiKBtlZ
         KQgQ==
X-Gm-Message-State: AOJu0YwDNzvmEA0iuUFGOKLK9z9kTytmWdMvqaGDVzUkbQphlW7jwtf6
	wpFr5mCfS4qecN2ChvPURmDhxyK1Yx2H033+lzrG0jGYOTUwX88sTg22brkxI1B67QjMecQAvFf
	Z1KRcxryNbQDTKpDo1wIHA9Og+9lhJGxcJO7V
X-Google-Smtp-Source: AGHT+IEXZ2m5Xf+Jq/IxEHekpp8yz7CV9DXXuRHGWySYbl1JdXoC1ci2EfBWU768Wr4PgkIw8BuZP6TEIYdpLWFpPwo=
X-Received: by 2002:a17:902:e750:b0:1d7:6ebd:3867 with SMTP id
 p16-20020a170902e75000b001d76ebd3867mr74632plf.1.1706933616692; Fri, 02 Feb
 2024 20:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203003414.1067730-1-yosryahmed@google.com>
In-Reply-To: <20240203003414.1067730-1-yosryahmed@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 2 Feb 2024 20:13:24 -0800
Message-ID: <CALvZod6pKLhLm6v7da1sm_axvSR07f_buOc9czRfLb5mpzOanw@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable] mm: memcg: fix struct
 memcg_vmstats_percpu size and alignment
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Commit da10d7e140196 ("mm: memcg: optimize parent iteration in
> memcg_rstat_updated()") added two additional pointers to the end of
> struct memcg_vmstats_percpu with CACHELINE_PADDING to put them in a
> separate cacheline. This caused the struct size to increase from 1200 to
> 1280 on my config (80 extra bytes instead of 16).
>
> Upon revisiting, the relevant struct members do not need to be on a
> separate cacheline, they just need to fit in a single one. This is a
> percpu struct, so there shouldn't be any contention on that cacheline
> anyway. Move the members to the beginning of the struct and cachealign
> the first member. Add a comment about the members that need to fit
> together in a cacheline.
>
> The struct size is now 1216 on my config with this change.
>
> Fixes: da10d7e140196 ("mm: memcg: optimize parent iteration in memcg_rsta=
t_updated()")
> Reported-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/memcontrol.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d9ca0fdbe4ab0..09f09f37e397e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -621,6 +621,15 @@ static inline int memcg_events_index(enum vm_event_i=
tem idx)
>  }
>
>  struct memcg_vmstats_percpu {
> +       /* Stats updates since the last flush */
> +       unsigned int                    stats_updates ____cacheline_align=
ed;

Why do you need ____cacheline_aligned here? From what I understand for
the previous patch you want stats_updates, parent and vmstats on the
same cacheline, right?

I would say just remove the CACHELINE_PADDING() from the previous
patch and we are good.

In the followup I plan to add usage of __cacheline_group_begin() and
__cacheline_group_end() usage in memcg code. If you want, take a stab
at it.

