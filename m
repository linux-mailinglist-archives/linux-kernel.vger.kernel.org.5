Return-Path: <linux-kernel+bounces-151624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5988AB13F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95BD1F23C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961812F585;
	Fri, 19 Apr 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7g1iKoP"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE931E893
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539003; cv=none; b=pWUnJcsU3fW3Auk3wyWmOHyup3ww9TIDiMaC6EVU+aT7j2zwnmXkYcl3POG0r9GQk4ORWdPcjWx2RNrRM6G1MGXihvLVDqWCF2YZKH9Ec+vWcq9S7KcOA0zfGKpnMe7jZe3FbZ3TNcjLhyFhNFcoH1iUEIpitu7ANoDzTqOrAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539003; c=relaxed/simple;
	bh=LLEBG9I8LZ70UB8McPzUw3ZN2B28yG6ScIov7xzlQyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0iCi7+N71r73RSl6P4zwn1u5I2BJvHhlbwIsFTxllY4aBCqmXOVL/BWw1ov6OxkPnAqi80QuvK2v3MYKo6F3+ImPGRljK/7aHxpL7j7OdQOffyuMmp+nuB7QM0OvnCGeTw05b2mSpWpyRnHWGj/zQee6Do1h8/nZWR5fIiu9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y7g1iKoP; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so39724831fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713539000; x=1714143800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NDGRYUeyiTR1EMXmnYw7OzWCIL0q6vZIdToFz9TtIo=;
        b=Y7g1iKoPRbzyBR7ozhyqDFvelEKu3NJx19GbW/Q1V5ti0dqu74CYxCqQ/yNmZucivG
         Qqo8GPjGHfwtGwuN385+8Z/O1nK8WCK4ZtuEpL7OstvkEHkAFwDY5KEg6JXA2+D7nBP6
         zAd3c8oYGv4ielI/l8xGgAzghMW07SggziTQtSGdzU4XOkxRtF0UPwa1wNRVtwixAfzx
         uxEtKX1cpBVmdFO9d68xtaLP7yCzb4NNvgIf7VyqWLSgH2ojCP2SCJvjzsRfky2UY3s9
         ytfscKXIcxkTOMsKftvG11UawzuESHK/7NKvfQYzlCahIk2GwjjBXKJLUS94XPJShRmX
         xMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539000; x=1714143800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NDGRYUeyiTR1EMXmnYw7OzWCIL0q6vZIdToFz9TtIo=;
        b=Hk1of7lwCPSx7fjuY9kYq1OUn4Jx9dDvNyvg7NIUOnAlbL/QxnP+m+gNSxYUQupfZS
         LSFWzbXwauDJrPmoO0QVLrSGmaMHnJhTti6euDlnvSAFKbnBf3WY0AQ5aRH6NPbvutI2
         8eECFT9Q2/EzBpL3WCJoj0KIlxDkdPSM3spgsLY/APr/sZ+4z1VscfaCyEL0ZEkeBRjR
         8fZHKcr4Dd8xA8wtCg5qHJDYZlmkOEgvIf4HuDIlws8XJ41BJMBBA/nV6TsVitsqM0J0
         6j4OfmGZi+4Dug3wl4w0DdTbOprmjt1l2JpzojEnRh+qDJxDWXFJRJr8LwJMVxX581//
         H/BA==
X-Forwarded-Encrypted: i=1; AJvYcCUUtvA7hUdZgL1hmiS7ldFDDqEZ88NXtGNt5UHajsPJ8XTfLodw8z+3ujp12+zH0G2rO2fsuKmzwCNzxJoJEWYqZJQPK4eV5+uxYs4w
X-Gm-Message-State: AOJu0YyEAW1c1K8hgJjhuqoPVhyUg8wWg7GI9YdgazT+eSRbwOkWDRSt
	a5NLmWlH7sbTW0vnWrv9xRmChJgoI8DOvc6AKPxfyyi54YtOFDX8yP4YIUwN8GWtQ5ilv8Ols9e
	v6r01cKdNj7WIfIGEj1Q3SrDaJi754vJ+p+Af
X-Google-Smtp-Source: AGHT+IEXSNtgPNWoEBoc3JoQJIXgarCTe4GVAdmcjouLXkIWQ/vxaHbzioyhfn2q62OMP8+k5zXoKHSL/1EHYGJZZTE=
X-Received: by 2002:a05:6512:224a:b0:519:3cbf:f734 with SMTP id
 i10-20020a056512224a00b005193cbff734mr2234601lfu.49.1713539000038; Fri, 19
 Apr 2024 08:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417211836.2742593-1-peterx@redhat.com> <20240417211836.2742593-4-peterx@redhat.com>
In-Reply-To: <20240417211836.2742593-4-peterx@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 19 Apr 2024 08:03:08 -0700
Message-ID: <CAHS8izPMjBMNUStsUjobbo4rUXirFtkOZVvJTFFqD4SUafQZaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/hugetlb: Assert hugetlb_lock in __hugetlb_cgroup_commit_charge
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:18=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> This is similar to __hugetlb_cgroup_uncharge_folio() where it relies on
> holding hugetlb_lock.  Add the similar assertion like the other one, sinc=
e
> it looks like such things may help some day.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index aa4486bd3904..e20339a346b9 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -308,7 +308,7 @@ static void __hugetlb_cgroup_commit_charge(int idx, u=
nsigned long nr_pages,
>  {
>         if (hugetlb_cgroup_disabled() || !h_cg)
>                 return;
> -
> +       lockdep_assert_held(&hugetlb_lock);

Maybe also remove the comment on the top of the function:

/* Should be called with hugetlb_lock held */

Now that the function asserts, the comment seems redundant, but up to you.

>         __set_hugetlb_cgroup(folio, h_cg, rsvd);
>         if (!rsvd) {
>                 unsigned long usage =3D
> --
> 2.44.0
>


--=20
Thanks,
Mina

