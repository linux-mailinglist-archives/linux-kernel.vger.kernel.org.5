Return-Path: <linux-kernel+bounces-149438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CE18A9128
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8A7281BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DE84E1CA;
	Thu, 18 Apr 2024 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QpscMb+6"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982AB53AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406933; cv=none; b=hcRnqb4goav7KwhnPPvv6han2xfl/YvWO3XGvBSDedRB01SVJ/eLLQSN2IgilQMzo01xJyO6FSsvicqBqEMKd2nH7YhcYZArfhc+r++9S6gPD8bHLGADg7hSqA4txgtbOSX35kohz9kjfq3HRBmC8dkZ3IzqDgFcWmsUd2Rpx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406933; c=relaxed/simple;
	bh=Qff+I+aGfGJWISm1b0a5UyILEZ6EJuYWH7ZKwAZRixI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lb5Oh9zLk6eLEqGfAIdt8tIMOunmSAsznOImuHziDzfCYj1vNSP5kAso3FkBV4o6nlFl9TOWrotO2OPKUTs0F9ke7MY/dHCqMnUuRRHBHymWtUbYkYXmC2EgY5UQun+RAUIAxtBQibFUGhJluG4EtZXF0VLEDeO7pCT1lz2Xrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QpscMb+6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a526d0b2349so27918266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713406930; x=1714011730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qff+I+aGfGJWISm1b0a5UyILEZ6EJuYWH7ZKwAZRixI=;
        b=QpscMb+6hqAUTd5qWxcF6UIW7ngb7DEKzCUNxRUIFCcgTZAVcpt2eVTmgcnjS42vhU
         0UU4MafQWpWsuGoNho5rKpXfC1G3RyHEOlBQOG1GBI8ywDD2a4ANzUV0rVJYVW8Sk6NK
         M+4ru/M4YH6KMrA3pr7zSlSpRFKlW3SzXpteHwz2eH43Y7vEeBIBOrdSUldVaUTXRKC3
         rUvoZPL6k+G25raHZymKwVq/KlmodYTfx/Cru0xz30BYpOZiTLGu2ogiwsUa4aAQzoJz
         hgC/Jah0AdIUrL5kp4k5i4qcx7g2w4usyhnvw/skI5WPgdjn2N9TQ/PyiKfMqfxyT+yJ
         72Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713406930; x=1714011730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qff+I+aGfGJWISm1b0a5UyILEZ6EJuYWH7ZKwAZRixI=;
        b=al8TqUwCPQfW51p/K3kUuy4FIZjQSI5QX4CJEJCOl7lT0XKvCURCblC34cNxjoAs7q
         1CEgV0FmDjiMeV4SGxI6oaeOxruXojO05aXENWElfIVCy/Xr8M3dcUDJFRJscxh0H/2k
         udcuSXAjOSjoPq9fnUPWvqK0T++YSIk5f7C+AHoKI/kRgIVl6HrZMrY9rV9qchOTofqK
         3StOuWH2saQi25BqUb2sLHjTkULUnxYYS2nnm/GaxA7Eoy/kj/I9fXA4a5vB9UfgQfeQ
         VyI+xhhV+gNoZ4R+vrWtUWXirPhbUBWYVo6Lgc0GsZ2dyy0nQe6hIyZBfJsgiuWyvgRU
         jIuA==
X-Forwarded-Encrypted: i=1; AJvYcCXU1px2ZFVHZUnINgy0s0XeZZq2eaOKef7rF7TGoYGrEc8WwLRIMmdD+ak35IZ1TiH9OQcCw0BerD3AzJRUQhzAsPkgCjpyxZabypaH
X-Gm-Message-State: AOJu0YyCXlSsYqAP8DVGnuhB3yde3IGumRX8HpooJOL4yOXPvV/pD5N+
	1Leue3xzE9u1cx4w7M5+oZ1PMXyfdBTTrjt+8twU92v+b6vDCP3TpU6lD67nDSWmfWpgeZbuhdh
	zN1woZLmKL9O2t90cQIxrPUuez17nXR2N7GL+
X-Google-Smtp-Source: AGHT+IEsn2jGrIe3C4gLKbA8+kMsvSSF1fhZfq37SxAlOsONgdio3k0OzSspWSZ5JGdHKbepDMsk16Du3X8HrZb0pAw=
X-Received: by 2002:a17:906:38d:b0:a52:15dd:20d8 with SMTP id
 b13-20020a170906038d00b00a5215dd20d8mr707296eja.26.1713406929803; Wed, 17 Apr
 2024 19:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul> <171328990014.3930751.10674097155895405137.stgit@firesoul>
In-Reply-To: <171328990014.3930751.10674097155895405137.stgit@firesoul>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Apr 2024 19:21:33 -0700
Message-ID: <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:51=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
> This patch aims to reduce userspace-triggered pressure on the global
> cgroup_rstat_lock by introducing a mechanism to limit how often reading
> stat files causes cgroup rstat flushing.
>
> In the memory cgroup subsystem, memcg_vmstats_needs_flush() combined with
> mem_cgroup_flush_stats_ratelimited() already limits pressure on the
> global lock (cgroup_rstat_lock). As a result, reading memory-related stat
> files (such as memory.stat, memory.numa_stat, zswap.current) is already
> a less userspace-triggerable issue.
>
> However, other userspace users of cgroup_rstat_flush(), such as when
> reading io.stat (blk-cgroup.c) and cpu.stat, lack a similar system to
> limit pressure on the global lock. Furthermore, userspace can easily
> trigger this issue by reading those stat files.
>
> Typically, normal userspace stats tools (e.g., cadvisor, nomad, systemd)
> spawn threads that read io.stat, cpu.stat, and memory.stat (even from the
> same cgroup) without realizing that on the kernel side, they share the
> same global lock. This limitation also helps prevent malicious userspace
> applications from harming the kernel by reading these stat files in a
> tight loop.
>
> To address this, the patch introduces cgroup_rstat_flush_ratelimited(),
> similar to memcg's mem_cgroup_flush_stats_ratelimited().
>
> Flushing occurs per cgroup (even though the lock remains global) a
> variable named rstat_flush_last_time is introduced to track when a given
> cgroup was last flushed. This variable, which contains the jiffies of the
> flush, shares properties and a cache line with rstat_flush_next and is
> updated simultaneously.
>
> For cpu.stat, we need to acquire the lock (via cgroup_rstat_flush_hold)
> because other data is read under the lock, but we skip the expensive
> flushing if it occurred recently.
>
> Regarding io.stat, there is an opportunity outside the lock to skip the
> flush, but inside the lock, we must recheck to handle races.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

As I mentioned in another thread, I really don't like time-based
rate-limiting [1]. Would it be possible to generalize the
magnitude-based rate-limiting instead? Have something like
memcg_vmstats_needs_flush() in the core rstat code?

Also, why do we keep the memcg time rate-limiting with this patch? Is
it because we use a much larger window there (2s)? Having two layers
of time-based rate-limiting is not ideal imo.

[1]https://lore.kernel.org/lkml/CAJD7tkYnSRwJTpXxSnGgo-i3-OdD7cdT-e3_S_yf7d=
SknPoRKw@mail.gmail.com/

