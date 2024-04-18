Return-Path: <linux-kernel+bounces-149432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FB78A9117
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497701C2102F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620454DA11;
	Thu, 18 Apr 2024 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xf6JRe/b"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275203BBD8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406459; cv=none; b=UGOnKZlr4S/v2WDb8ojLQmvoeixxPRUleW0LJQOnVKfYxDdsuYOUQs6k9uflzgkCErrKoFsaxqj4IZQQ7OutdClt8J9W5zKz6wr03IUMKr+JMrHjXJ6V4QMQCSQq17rHESMJMvRL5U6XB9Km7vK50bwGb15m5nL8y+gP39Wn+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406459; c=relaxed/simple;
	bh=xy2v9XI+hu3E9BlWSVNBUmL0WFz0IgfDKWRA7V5lq14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfYI0QLHx7TZdqj2QdWNzJywNgTMcBQI100hGZWU/AHiw+O3c1GG0g0S+hS/EL+sGr63SnWN82DqsyEzzhjWYhQzgLYdbSOQsid5EXmUQbB0b21/4rc+ZADZD3P1vNtW+9UPtpajUdFfpl2CVtYHO7mA1GeOV4dS+fAXtCq93lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xf6JRe/b; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a526d0b2349so27459366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713406456; x=1714011256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EWy3InHHcdr6Et3oKPqHiA/efKMXLdl9NWj5a3LIKA=;
        b=Xf6JRe/baC1edVV8aM4en7Mzm8ydcn0MB7AwP3LQU6oy8jgPmzDamgns4SNzEhLtYL
         wObW74eejHnRfU0kjoI7K4+HOo77nYZFDfVNQapiD/kMvskbuiGtTWFd8Irk1iRNtWy+
         0AzQ/3klXzvrnr+h26siGOQmNKVTQ0sHasRzCcgMzvVPd+wM749uwPQbDwToXZgrZ3Ve
         N3HHqGg2755agdAn/OU6iWkwxy5Wvh8j+OQkiSjiuuEWc49ZJrld7OfhCc9wNRZj5lB1
         Tb3M0PSReI9r9vHMOajseP7+E7PhEj+ecj5Ojz1EEjLBqyqvNVgmhZ4Nti+LNuENnJYM
         zyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713406456; x=1714011256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EWy3InHHcdr6Et3oKPqHiA/efKMXLdl9NWj5a3LIKA=;
        b=V9K3Dx1Hg7FpnuWiwprSRhW2eyDPRkVy1QZepcZjyA+bRF9w7HpHdD0SSYChf4mY4Y
         6YZ4rUSRn1O8E5m/GfhMwyGwvhDP+uqdnqYKx4raPjdeAdEIlqGPfgi44AbyGuZOYO2k
         1H1k68mByViAUxwQ0xuoNb1omzGMz56IAhH8z/hdraYINYAZAh9QqoBE1kjtwfzmtnSm
         pshLRNHwuB+M1/UaNgoH9+lkps4bO7eNtKk04A5yK3NUFcSFFBvNLm9GKXNH2CvMjTuL
         WddUrpNEklmTeQJLxjFAYmpk1UWQyUO53wJrxnlEZtfIBonzTr6HTZ8pQiZbU0+1bxt5
         BuBg==
X-Forwarded-Encrypted: i=1; AJvYcCUshJHOT1HfFu3Jvo+fSOrZHr/BYX2PTXspeKm6wKOrolSA2LK82y4QCgjJEZt3k/IdPyRvWK2JbGbyc1MhfIO8h/EoL8/6uXGatuGJ
X-Gm-Message-State: AOJu0Yw8+aC5t9wrqxIAIwk/m+9rG40VP505WN/glxoUpLBOJkQYjyMX
	ZX7/uneVPolpGLaAhBZSn7jz5mPQXK+53mCST560muU7h/5A5VdiP/dhg9iFoOADnzHeFCFD6N4
	kSd+kkhlraPqbJdxCDOXJDvznIhiimry4Z5i+
X-Google-Smtp-Source: AGHT+IE/Nf4C5eaH5s4T2RRQ0jDt7/fjhylkOElaSpZipRuSnyI2rIKGrPh8cigEE9JO5l6XGaOIHOMiew3CNftZbYw=
X-Received: by 2002:a17:907:6d07:b0:a55:6f39:3364 with SMTP id
 sa7-20020a1709076d0700b00a556f393364mr296261ejc.15.1713406456189; Wed, 17 Apr
 2024 19:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul> <Zh7vuBRbA9rT5OCO@slm.duckdns.org>
In-Reply-To: <Zh7vuBRbA9rT5OCO@slm.duckdns.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Apr 2024 19:13:40 -0700
Message-ID: <CAJD7tkZhjYZQqsnTvUnv9EB1KUNyKijxLbYLOMsEcsRcZw=j3Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] cgroup/rstat: global cgroup_rstat_lock changes
To: Tejun Heo <tj@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 2:38=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Apr 16, 2024 at 07:51:19PM +0200, Jesper Dangaard Brouer wrote:
> > This patchset is focused on the global cgroup_rstat_lock.
> >
> >  Patch-1: Adds tracepoints to improve measuring lock behavior.
> >  Patch-2: Converts the global lock into a mutex.
> >  Patch-3: Limits userspace triggered pressure on the lock.
>
> Imma wait for people's inputs on patch 2 and 3. ISTR switching the lock t=
o
> mutex made some tail latencies really bad for some workloads at google?
> Yosry, was that you?

I spent some time going through the history of my previous patchsets
to find context.

There were two separate instances where concerns were raised about
using a mutex.

(a) Converting the global rstat spinlock to a mutex:

Shakeel had concerns about priority inversion with a global sleepable
lock. So I never actually tested replacing the spinlock with a mutex
based on Shakeel's concerns as priority inversions would be difficult
to reproduce with synthetic tests.

Generally speaking, other than priority inversions, I was depending on
Wei's synthetic test to measure performance for userspace reads, and a
script I wrote with parallel reclaimers to measure performance for
in-kernel flushers.

(b) Adding a mutex on top of the global rstat spinlock for userspace
reads (to limit contention from userspace on the in-kernel lock):

Wei reported that this significantly affects userspace read latency
[2]. I then proceeded to add per-memcg thresholds for flushing, which
resulted in the regressions from that mutex going away. However, at
that point the mutex didn't really provide much value, so I removed it
[3].

[1]https://lore.kernel.org/lkml/CALvZod441xBoXzhqLWTZ+xnqDOFkHmvrzspr9NAr+n=
ybqXgS-A@mail.gmail.com/
[2]https://lore.kernel.org/lkml/CAAPL-u9D2b=3DiF5Lf_cRnKxUfkiEe0AMDTu6yhrUA=
zX0b6a6rDg@mail.gmail.com/
[3]https://lore.kernel.org/lkml/CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=3DtZZjJHj=3Dd=
zD=3DCcSSpp2qg@mail.gmail.com/

