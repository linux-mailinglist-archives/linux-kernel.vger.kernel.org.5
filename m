Return-Path: <linux-kernel+bounces-62177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8930A851CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24A4B215E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62F3FE27;
	Mon, 12 Feb 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9SXeEve"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606413C6A6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762500; cv=none; b=QWcYwbY+s7ZlY64ZvFY+bWV8Yqo7tieYxpY0gR5HSmSsp4M5InAswYxVyK0tVERuNmdQqF6VfyHhl0YzOtMQI1oaFLNrCpotGoo1JDtQ6gkZ0rohXWkglaDD7JYtIAhCqNRgeG7DI1n9pFrPU8jNJ+A9eAq33MOLylCwQ8v6cI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762500; c=relaxed/simple;
	bh=WiUYf9N/yCCt/KvvF5EwlwZUQRLHndE2JKq3S/cTn0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsFuuRvU7o7i+X9UblpukJvH/eKkCfMSqbQJ5t0L7go6C1XIjW5KBYE4gKwLFNvgHT6V8Y+LoCM/K2q6veAaOVVIwkIDvo4JPSs8j77EI/vdLdrYBIvbgdgwl7b4afJR2ik4gk1BFl6kkN4ANBP8BxxrJ5BVHCmq2hq5G0xfNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9SXeEve; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-410acf9e776so3565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707762496; x=1708367296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypHcUZ+aGWwSqOIX8vKscvJOnKGBfRqwg/T41r3ZbLM=;
        b=M9SXeEveF6Kv2HTN61BwJbr6BphjrVKsmlbLg822jfd2HDbNSY1Hwkc3hmKw1++gxP
         CLYk4kmWCMmU8yph/vMJcQtM0pdVkuhYQ6PCX/sQBo9Yo7nCuP1YDW2NQqJrXEHKAisD
         EKsZmHmeqmIO/YddsczsqN7famO7FuFQ8TTwhHUGOz/6RqbAgDUJDxtF3gsGomJqajJu
         O0rBUtmAh8dN70eJydYcCLwViOGScId8BvHBgE6t63KqHkp0KLDV6GWyfuJEQGHLn6Hq
         HhHLBceJZ8R8cfbS25NokE3upOZgYoO/c/mvy8/npkVq4k/sl81FnqQL7xAYMx/ja1EP
         ULxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762496; x=1708367296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypHcUZ+aGWwSqOIX8vKscvJOnKGBfRqwg/T41r3ZbLM=;
        b=QJtgFzFbv06wjOnNEVSmeICFoZsocr4RzoPc1yD1EoP/z9huolSP+wLpoD5WlzjrZz
         ELzLW+ykBdB0QCsQnzBqTKlxKf+5sZnI3hlJeOcVWVSOlEAKFAgU0TdC/dmGdEWzf9KC
         XJXYkxChcodVPt/0+8jiumaqwUh2+z7sGaEaTkfy2Au26KSKQc0WDE3b5ZK5m0OJyF2e
         Y3IhUvlBeAqIViRM36LLKWzTsJZ5rA0TIJmYxYOzq5PuV9LTOvJK/11XDVj+Ndeaibkk
         LqhNl0UKG7CIV+egPaKrNMhm5QY9Yj8TcviimsSTLhyy8KNAiBfLI0F0tf+VoC++4SnW
         Y4HA==
X-Forwarded-Encrypted: i=1; AJvYcCUBIhhVAzr64n+wCCwlBncrelaAmWJiU+vtv5V0yIIPkIplmdh8bCAQHxOwz6U68m9SdKfSQTNIiM7irVDlmsHZk+p1//RnTZwe/LJe
X-Gm-Message-State: AOJu0YwJw8cMJPH0WwGYv8LmF9KrmsM+e2HTtK7xUm/lT7LCdByELNXi
	IPNeGXOVkpprS253aXrG21M2OK8kifDBeTpPYRz8kqMJSQbFbBnEq3EkZ6LYO+Kiuat+vHonPrl
	ufpVL7PxPYOLgjd6vnxntqPpUbltrJlLKlll1
X-Google-Smtp-Source: AGHT+IENUbcQetxdbVJUWkDcZV9wBOKwUA5KBVKb3q8kwwNwrJ81UhZO9mANnq3JBZ4CWFIexcNdopfgQFazsqAn7Lc=
X-Received: by 2002:a05:600c:1f1b:b0:410:d18a:290b with SMTP id
 bd27-20020a05600c1f1b00b00410d18a290bmr200842wmb.7.1707762496373; Mon, 12 Feb
 2024 10:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212163510.859822-1-zi.yan@sent.com> <20240212163510.859822-4-zi.yan@sent.com>
In-Reply-To: <20240212163510.859822-4-zi.yan@sent.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 12 Feb 2024 11:27:38 -0700
Message-ID: <CAOUHufYz2P8w_kqxSjmOghbEG8CZmO2cfb4UzP7dkduBQbHhQw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/compaction: optimize >0 order folio compaction
 with free page split.
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Huang, Ying" <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, "Yin, Fengwei" <fengwei.yin@intel.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Mel Gorman <mgorman@techsingularity.net>, 
	Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>, 
	Adam Manzanares <a.manzanares@samsung.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 9:35=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> During migration in a memory compaction, free pages are placed in an arra=
y
> of page lists based on their order.  But the desired free page order
> (i.e., the order of a source page) might not be always present, thus
> leading to migration failures and premature compaction termination.  Spli=
t
> a high order free pages when source migration page has a lower order to
> increase migration successful rate.
>
> Note: merging free pages when a migration fails and a lower order free
> page is returned via compaction_free() is possible, but there is too much
> work.  Since the free pages are not buddy pages, it is hard to identify
> these free pages using existing PFN-based page merging algorithm.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Adam Manzanares <a.manzanares@samsung.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>  mm/compaction.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index d0a05a621b67..25908e36b97c 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1832,15 +1832,41 @@ static struct folio *compaction_alloc(struct foli=
o *src, unsigned long data)
>         struct compact_control *cc =3D (struct compact_control *)data;
>         struct folio *dst;
>         int order =3D folio_order(src);
> +       bool has_isolated_pages =3D false;
> +       int start_order;
> +       struct page *freepage;
> +       unsigned long size;
> +
> +again:
> +       for (start_order =3D order; start_order < NR_PAGE_ORDERS; start_o=
rder++)
> +               if (!list_empty(&cc->freepages[start_order]))
> +                       break;
>
> -       if (list_empty(&cc->freepages[order])) {
> -               isolate_freepages(cc);
> -               if (list_empty(&cc->freepages[order]))
> +       /* no free pages in the list */
> +       if (start_order =3D=3D NR_PAGE_ORDERS) {
> +               if (!has_isolated_pages) {
> +                       isolate_freepages(cc);
> +                       has_isolated_pages =3D true;
> +                       goto again;
> +               } else
>                         return NULL;

Nit: remove the "else" above, or just:

        if (has_isolated_pages)
                return NULL;
        isolate_freepages(cc);
        has_isolated_pages =3D true;
        goto again;

