Return-Path: <linux-kernel+bounces-157838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E48898B1707
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B928866F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED916F0E9;
	Wed, 24 Apr 2024 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDBmXtqK"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B51E86F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001035; cv=none; b=hLlBLwWvuatsq14yjpD6tcUrTxFgXaKR3N4SKEIU3bhi4PR7y10URN6ipeK0qU1E76XuUbVDhzDMcce1SHQRhgRrzQhi33aVJitzaTXlFGtPZqGQZ1CyyT3JM4Uv0rCkoCL/i6YZVaA1pEl5VpbqhX+a2vdt9E0mBxndso4GGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001035; c=relaxed/simple;
	bh=kWYPE52TsD9tInankw4Nl3ZO8d6bCgXJgGeWHlBI7E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4PzVRcNR7KRptnJb52Pv3cwTDa5elQ7nTfKAcpi14RIByzI6eMnfmN3Uv1VVjAyX84dMlMtLOGyFoR4EAQrVTYJQKOhl5Gbm9UyAy5c0duboMVBJD/11yniWo7mdhaXUvI1ZU61uYQJH3dWSVTvzS2HqJMJyDHXZZOEDcT6KLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDBmXtqK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dd041acff1so4208491fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714001031; x=1714605831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4Xhz5NWCXtt8nKXxeIFmhH8Oed5NRQI3JQnJYBJb4s=;
        b=ZDBmXtqKUgzM5W6Y9v/FaSWCHcLxNWr12HbqWLBMO6yf6A8OTiahKd3JK1posYwxSG
         vuMm8PFjLRvrMt5lwZUyiweQsVDVF/F62rnhi0zCE97/mNJZDsIrMMajRsNQZSWmr4og
         91mlctLys46RrYkEjgAGu3mrzHmHtO6IJiTk66weMjRoMXvW0gpylRits2TiFvcY1cMt
         BY5wd9sliMz2uIigVPYvjLwCd1a6JIZf3M2FhGr/gSilxQWrA4VkRFCwDVXgAf+hN4jo
         BJ3M7EGjRQdm3yamJoku/qFFDjGF1fVDfDEZ7VgXBFd+amcVrRPryrjanJWvvXizAaAS
         nCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001031; x=1714605831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4Xhz5NWCXtt8nKXxeIFmhH8Oed5NRQI3JQnJYBJb4s=;
        b=ox5hxNHuRaZScxbF6/DCTJt5P0Hd05CrvBVnoF7Lv4rUf9+MMBWIfhpAXUsm0xjVU2
         C9uUbHljQCmrNZIFUF3DD4Abtgvt+oefSXefibqEk+TaXDgguqxNp7XXbiIZQ0s+2a9F
         DCU9Q/wzKNGb+SQCXS5OGuuBdFwPp65NkSaUlBZ/JVvPbJrKxGGb6exOxDMMuxGegyRv
         ftn2sB/YOi4hzp0KoSJqp/qXlWA/I1apATz8Cj65qMoj6MIaJb2spB7oCiAs7G74rc9M
         mwe46WCIR5nLDQDAdhdikRKLqd5mBfWCU82JRQxq7zvDxCV1XDgH7uPfGMfuoIKw16Sp
         bIxA==
X-Forwarded-Encrypted: i=1; AJvYcCUS0yW5GsBB+oG8D6ZjDetxc0UWZlgzm224dPwWvvEgC5MKntEPpLVaALz9geuSfZRYwkXT/jPOxR5wcI8/9Yqf28pFK9bajgLBR2k2
X-Gm-Message-State: AOJu0YzfkGETwkrYyBygXxyHg/8ttK4J6ZT49n9rwNJjyZ7bMVvJdcYn
	+JGeNdLJBUsl1LTj7v4xi3IY0GUm4xk03JOEgDf3+X1h3M6EMeEy1T7uyl43vQ4YrWAYZHWR/Iq
	dEiDbvHZsifkTTV63nxnZEQkGciPZ77QQMsAQ
X-Google-Smtp-Source: AGHT+IHPC10+jHzeG+tgpIIgUMIPE4SuCr0QvH7By3qs7yKyt3sGcnqfFcju9V2mis/w27r/UIkSloxyYeZtRuWl320=
X-Received: by 2002:ac2:4254:0:b0:519:63c1:6f45 with SMTP id
 m20-20020ac24254000000b0051963c16f45mr2385942lfl.61.1714001031354; Wed, 24
 Apr 2024 16:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424125940.2410718-1-leitao@debian.org>
In-Reply-To: <20240424125940.2410718-1-leitao@debian.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Apr 2024 16:23:12 -0700
Message-ID: <CAJD7tkaWw14fLvCKE5-3U-FLm_0bsMJHcxHEFJwgGdfsR4SzMw@mail.gmail.com>
Subject: Re: [PATCH] memcg: Fix data-race KCSAN bug in rstats
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, leit@meta.com, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 6:00=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> A data-race issue in memcg rstat occurs when two distinct code paths
> access the same 4-byte region concurrently. KCSAN detection triggers the
> following BUG as a result.
>
>         BUG: KCSAN: data-race in __count_memcg_events / mem_cgroup_css_rs=
tat_flush
>
>         write to 0xffffe8ffff98e300 of 4 bytes by task 5274 on cpu 17:
>         mem_cgroup_css_rstat_flush (mm/memcontrol.c:5850)
>         cgroup_rstat_flush_locked (kernel/cgroup/rstat.c:243 (discriminat=
or 7))
>         cgroup_rstat_flush (./include/linux/spinlock.h:401 kernel/cgroup/=
rstat.c:278)
>         mem_cgroup_flush_stats.part.0 (mm/memcontrol.c:767)
>         memory_numa_stat_show (mm/memcontrol.c:6911)
> <snip>
>
>         read to 0xffffe8ffff98e300 of 4 bytes by task 410848 on cpu 27:
>         __count_memcg_events (mm/memcontrol.c:725 mm/memcontrol.c:962)
>         count_memcg_event_mm.part.0 (./include/linux/memcontrol.h:1097 ./=
include/linux/memcontrol.h:1120)
>         handle_mm_fault (mm/memory.c:5483 mm/memory.c:5622)
> <snip>
>
>         value changed: 0x00000029 -> 0x00000000
>
> The race occurs because two code paths access the same "stats_updates"
> location. Although "stats_updates" is a per-CPU variable, it is remotely
> accessed by another CPU at
> cgroup_rstat_flush_locked()->mem_cgroup_css_rstat_flush(), leading to
> the data race mentioned.
>
> Considering that memcg_rstat_updated() is in the hot code path, adding
> a lock to protect it may not be desirable, especially since this
> variable pertains solely to statistics.
>
> Therefore, annotating accesses to stats_updates with READ/WRITE_ONCE()
> can prevent KCSAN splats and potential partial reads/writes.
>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

, and or posterity:
Fixes: 9cee7e8ef3e3 ("mm: memcg: optimize parent iteration in
memcg_rstat_updated()")

