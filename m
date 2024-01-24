Return-Path: <linux-kernel+bounces-37447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4583B065
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A353B27B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA33811F9;
	Wed, 24 Jan 2024 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpF5jWzx"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1D7F7E5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117912; cv=none; b=IynD5kJ38SX/jP82RXzupSKy0436RUrWiB6y5bx7x/y45OKPRfDCkwzY8OfnMW8QzB1Ad2bqG4MwiJ4m2tCuubJRbwWV0E1x+Z7+j7hYJxw+LFA1Ms7oV9o1arM0VVQYRGU5ko71fooLEoExcLLDN/cNZtiDq5BEJkPxg+gQqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117912; c=relaxed/simple;
	bh=yJ/BKkfpXJzgeyNiHaKMu/CgCnQKf/dgognXWBGDJRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6uCMsUaRr2xG5y5zs0VSTR0ONmv5Abt3H/R40J9aSf2r4UJJvgi8rXzXNrN8U0+E6UgnswOVMBUnkV64IisW33zk3I1iRSo342n5wT0nfsGffIUzzqywUveIvL6SYL12MjnJhrKG7QXQYB9D0BI8usw+44AqD0hvzItbHq7pJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpF5jWzx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d72d240c69so168965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706117910; x=1706722710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ/BKkfpXJzgeyNiHaKMu/CgCnQKf/dgognXWBGDJRs=;
        b=lpF5jWzxTcpFc2COD2Q4RapamyszvZxdwd0bsZg/HrnlfOdVIDIffTbWB1o/BIWmvr
         MN5A6AvmJbCDvWMWV8TOtNI2rCvv7Sw3NbyhBQ5AxTS8UrdTpn1SJvuLth28j8tHDSRI
         G2fwQg2QoYI5Z7rICBx6JLCP/Oflqet6iVbSsuoNG/fram0WXqnyXOd50B4XBlHeFv/8
         Al0APVU4jlXMtGMAM+9KbFA9ajOQi1Y9e10C/gfsyhFF0PwOZAnJ4NWRNQ4otvcdgHj6
         ypI22zdRz7nDlGm2v6R+0ntIkCqwtYHwVql6M8MHQYOypPoBmJoowJw/gKycs/FjI7B4
         HvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117910; x=1706722710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJ/BKkfpXJzgeyNiHaKMu/CgCnQKf/dgognXWBGDJRs=;
        b=IAIMNsz48ea65mmWL4KZIIjurxYp51cTQcJtgygV6Z48RM/j2UKZt634AWhEv5u7UY
         MwenV0aJCvgf/N8gcDWNLHeJsi1phUBJu5Z6338rZtBwMWNxt5QXY+mw9kPD9XFl16GL
         rWiSFYmlW+usv3dw9UoaOrNZrMXjpaSbiC6QGSa19aK//MEvWjwS5WyFXcbtGHEELe9M
         V4N/WS/ISxsGYL6xTQ+I5RIhzR+HfuviYDHZTdlccZ/K7j9JwCOVtNncOMF8qfocRFXA
         Am2OSpGxL/C4Swco3YEDNoUTCOufBFN0tojO/tzXBYtYtqaACul/f9UYGXjm0JpOBvIH
         GSSQ==
X-Gm-Message-State: AOJu0Yy249N7eC0Qf+43ScYF7tcOgcfX3GpXwEqmknQtsVRgsmsN2LmP
	IdFkOcQlXC3k2aqIUI6yCfV+pVZ0mo3mxUPMPtDl1yLd7wXJcsmKqDc/wH8nNIiuY0Mm9RJngXz
	hcNBUXza6dBZ+HJAet/aFJuWgAbCen8bh4hA3
X-Google-Smtp-Source: AGHT+IFB5hVm3nPtQ1RkStaM3t/gRxrS+28Wx2F0onfV8o6fOhomKTu7ndT8c1ooAvc+cAfwWvFudUBaqRv9FcYZ8EE=
X-Received: by 2002:a17:902:db04:b0:1d7:246c:2fc1 with SMTP id
 m4-20020a170902db0400b001d7246c2fc1mr216102plx.26.1706117910167; Wed, 24 Jan
 2024 09:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124100023.660032-1-yosryahmed@google.com>
In-Reply-To: <20240124100023.660032-1-yosryahmed@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 24 Jan 2024 09:38:18 -0800
Message-ID: <CALvZod5+S5RLt5t=+ZvrRgOkAhNvC9mJo1SE7r6Ms1LRodV3RQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: optimize parent iteration in memcg_rstat_updated()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:00=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> In memcg_rstat_updated(), we iterate the memcg being updated and its
> parents to update memcg->vmstats_percpu->stats_updates in the fast path
> (i.e. no atomic updates). According to my math, this is 3 memory loads
> (and potentially 3 cache misses) per memcg:
> - Load the address of memcg->vmstats_percpu.
> - Load vmstats_percpu->stats_updates (based on some percpu calculation).
> - Load the address of the parent memcg.
>
> Avoid most of the cache misses by caching a pointer from each struct
> memcg_vmstats_percpu to its parent on the corresponding CPU. In this
> case, for the first memcg we have 2 memory loads (same as above):
> - Load the address of memcg->vmstats_percpu.
> - Load vmstats_percpu->stats_updates (based on some percpu calculation).
>
> Then for each additional memcg, we need a single load to get the
> parent's stats_updates directly. This reduces the number of loads from
> O(3N) to O(2+N) -- where N is the number of memcgs we need to iterate.
>
> Additionally, stash a pointer to memcg->vmstats in each struct
> memcg_vmstats_percpu such that we can access the atomic counter that all
> CPUs fold into, memcg->vmstats->stats_updates.
> memcg_should_flush_stats() is changed to memcg_vmstats_needs_flush() to
> accept a struct memcg_vmstats pointer accordingly.
>
> In struct memcg_vmstats_percpu, make sure both pointers together with
> stats_updates live on the same cacheline. Finally, update
> mem_cgroup_alloc() to take in a parent pointer and initialize the new
> cache pointers on each CPU. The percpu loop in mem_cgroup_alloc() may
> look concerning, but there are multiple similar loops in the cgroup
> creation path (e.g. cgroup_rstat_init()), most of which are hidden
> within alloc_percpu().
>
> According to Oliver's testing [1], this fixes multiple 30-38%
> regressions in vm-scalability, will-it-scale-tlb_flush2, and
> will-it-scale-fallocate1. This comes at a cost of 2 more pointers per
> CPU (<2KB on a machine with 128 CPUs).
>
> [1] https://lore.kernel.org/lkml/ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020/
>
> Fixes: 8d59d2214c23 ("mm: memcg: make stats flushing threshold per-memcg"=
)
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202401221624.cb53a8ca-oliver.sang@=
intel.com
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---

Nice work.

Acked-by: Shakeel Butt <shakeelb@google.com>

