Return-Path: <linux-kernel+bounces-108064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7969B880572
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AF01F239DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2043A1BB;
	Tue, 19 Mar 2024 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7/IodE9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2D39FE5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876689; cv=none; b=cGDr7axZa59kDKTijnEt1jTmp1X7kw9Q5/GWnyv/5nLRoQuS8D10uNiZ7WVkabDt3z5NSY3hJznJn0/Iq9t0dWOzqwseobT/aAqgRENdCqbo3UMHnQBhFPgwTth6sTz7gTmT2LD9V1g9IFup6Sub/6tckxmL+YUbUjwbrcLNHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876689; c=relaxed/simple;
	bh=J0vX+cuzIYxY5cfgG0/yAsNBit83l5xsuBU7BpH5j7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sk2sR4fWh9NusqhX6EwlvrbO6aH5UjF6/cpYp4tkOfZrfyvYJQhDaF+M/j9VmK4YJDpTitABSWwUMWweXjJvASGqjtApRkI2pZAgM3GXr3sw2tOI19RBPt6E8swls06OL1g+FTLNAAzRt76Hxdubibn6v/eXimvZyqdD3RtluQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7/IodE9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dddd7d64cdso226395ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710876687; x=1711481487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PftXuVDUnL3kD4hazB5nxJjQYb7nK8wSYHQOZO2iQTc=;
        b=i7/IodE9chBtKdgpFQAATBdJ3Vf7129l7TsFRxD21rMRhW+PLoeH/aUimteEjxcmnt
         xDcz5oIDCXh49X2dt8fM1LzdonnYawz7+L4YVXlMRVSuAsehGPDWfNUwchQl1H6E/RXy
         ujOiaq4aNIzYvYx94BggHK5WYXAxIwKlyqr/kYIFv1KqnTVybS+p3IxpJdCwP/s3o+Pd
         3KJCDBaQQsWZ4mlzdlkv1Ouibten1gZStAFXFCDHIY7S5QtC6IrmFm62EPNQ99usXZOe
         K1G2Roum7IhCB3N2Nrl0uehg7WzjcPx846kHQkQjVmzjWinlFo071zCfKjmz6mu66icg
         Lk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710876687; x=1711481487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PftXuVDUnL3kD4hazB5nxJjQYb7nK8wSYHQOZO2iQTc=;
        b=Ug6efiOtneTH+MaoRNQWgSMZm11q2jevLu+Ppfea9QLONmAqEvdvCzLtSYvUZVmhjj
         QdQZsoQv8eOe5M/wS5c3PPHnhvGoioqtkDkY0eioSlO9+jirtStcWoQAA/ZvuqKu9yzy
         D/u+tU90eYupVUXVpiVKXgwB1hvnR2k9eyVqKcPz9xjfMWoZTfWN3fYJVbppSEX8wFeV
         T78PiSB5UhTKz+KdibkVE/oB3ROQhI6TGtxLG0SxWjvYL4Wn5d1kfiKtGrpl421m4lS9
         RuhdAEPL3SJARhoF3rINOOsPzDhwHtU6SMMdEVa0N4Ni5XrqwUNtgXWIlk/XChZTl1cn
         WBug==
X-Forwarded-Encrypted: i=1; AJvYcCWsBRlMOogFc7F9yUchkF65QjkShWUM/Gus/qzI5WxnEEa/AfD7WegnSQGC1R5qWuOP3YI4Yp/P3z+oUwBgXqrou+3UPoZRz1g5t7eh
X-Gm-Message-State: AOJu0YzrQcX8WjmKZs/OC+fPkkix9586qZVCDa1klE75ib+2t1ysB7XY
	HWe3ABcna38Wejyr9dki3iDuMMtEOi7gqi8Yr4kmk5/Vyf4WgpOJK7rbvZdx0tQVYapWoNRBXY0
	mI6Vx8aXXniXKT9Z8Ns3ouVAYpTcQm3ZzXqRy
X-Google-Smtp-Source: AGHT+IG76oWakoMgWcYoXoHdnbTBRqQ5nEeMt5a4y0z4O96qLkOgPwbsy2MgW3bFTKpshunF7cqZKHqUvi2r50XAtm8=
X-Received: by 2002:a17:902:e881:b0:1e0:e16:dcc0 with SMTP id
 w1-20020a170902e88100b001e00e16dcc0mr49886plg.13.1710876686733; Tue, 19 Mar
 2024 12:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319180005.246930-1-visitorckw@gmail.com> <20240319180005.246930-2-visitorckw@gmail.com>
In-Reply-To: <20240319180005.246930-2-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 12:31:12 -0700
Message-ID: <CAP-5=fW=Mky3nkYerzwqgnrL3UJ1uONccyxuJ2aoD+ueY+kt-A@mail.gmail.com>
Subject: Re: [PATCH 01/13] perf/core: Fix several typos
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:00=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.co=
m> wrote:
>
> Replace 'artifically' with 'artificially'.
> Replace 'irrespecive' with 'irrespective'.
> Replace 'futher' with 'further'.
> Replace 'sufficent' with 'sufficient'.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  kernel/events/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 724e6d7e128f..10ac2db83f14 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -534,7 +534,7 @@ void perf_sample_event_took(u64 sample_len_ns)
>         __this_cpu_write(running_sample_length, running_len);
>
>         /*
> -        * Note: this will be biased artifically low until we have
> +        * Note: this will be biased artificially low until we have
>          * seen NR_ACCUMULATED_SAMPLES. Doing it this way keeps us
>          * from having to maintain a count.
>          */
> @@ -596,10 +596,10 @@ static inline u64 perf_event_clock(struct perf_even=
t *event)
>   *
>   * Event groups make things a little more complicated, but not terribly =
so. The
>   * rules for a group are that if the group leader is OFF the entire grou=
p is
> - * OFF, irrespecive of what the group member states are. This results in
> + * OFF, irrespective of what the group member states are. This results i=
n
>   * __perf_effective_state().
>   *
> - * A futher ramification is that when a group leader flips between OFF a=
nd
> + * A further ramification is that when a group leader flips between OFF =
and
>   * !OFF, we need to update all group member times.
>   *
>   *
> @@ -891,7 +891,7 @@ static int perf_cgroup_ensure_storage(struct perf_eve=
nt *event,
>         int cpu, heap_size, ret =3D 0;
>
>         /*
> -        * Allow storage to have sufficent space for an iterator for each
> +        * Allow storage to have sufficient space for an iterator for eac=
h
>          * possibly nested cgroup plus an iterator for events with no cgr=
oup.
>          */
>         for (heap_size =3D 1; css; css =3D css->parent)
> --
> 2.34.1
>

