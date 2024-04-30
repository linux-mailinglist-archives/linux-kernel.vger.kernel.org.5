Return-Path: <linux-kernel+bounces-164353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0702B8B7CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AE7284F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD616178CD6;
	Tue, 30 Apr 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aB4aCuWJ"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E71F5FA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494036; cv=none; b=iJmDqM2JHytpZteNlwPkg0qBP4BXSdbz8P6mddXzI5TUr9sYxlsiXhMxZ+54YtXFYxt07fq/hldpqhhNYk1zrmVfVgII3qcXAOVIkKnsOLXlsR0NkgQTjEVooPh6JHrCteDsdyUVOJ3Aeb0/vaYvCQ3LEbT/o89hrwaiVYeO9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494036; c=relaxed/simple;
	bh=MPiAtwedkrAB6+zDcXoDb+B35IRMp0AKoNf+0jYAHyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+12plCtBDxbGtgn65pUYQJaRwuW/PUfyqBIq447qqpUnwXipJIWoLdY6r4n56Otr7TIh5BY7hU6Jd9s6Gq/miCFBq7DUnzUwCY6sGkHmA7h9ru6FOlZ3LYbNOZbIDBualaAk/B69oTuRBDhVNWsQ97aJm4TMqKqf4xHRvHb1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aB4aCuWJ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de46da8ced2so6697917276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714494033; x=1715098833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEtrK3qxDuRYVwOw3ESsbxVxDvF9U0HXAFKtExdTC5w=;
        b=aB4aCuWJYcnxO85T8stLkOsmKytjYwrAhlijwctDyESvfHmNYuQc6HzZZD7dQpeP0P
         imPv22OJygyCiBmTasT4xfSC+Azy1OpbZCSGSULCqnkXczN6lT42pRna1dAifFdu0TrZ
         Q9x9vWkT6UCiLErc4jrXgQR34XQUOso0+4QydfxGq1u94DaI3Iv5VNF/nAstWTTHBRgN
         XwjGBRWbBV5l7GFdurIxrLgpKxcVPNzgISSAG/LTI/cjl/Unsjdvy6+qFRayeBc7Q1DW
         NE2PEz3s9/ZjnF1CxdEk6yxgfZKP5Ps0Zh9x/CZ+ZduZl7o1u7o4+peFN6IaHXQcxcPc
         s0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494033; x=1715098833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEtrK3qxDuRYVwOw3ESsbxVxDvF9U0HXAFKtExdTC5w=;
        b=RthQpROfhD4+/2nNntMCpcxjq13iaYu8D3oTtDKqYAyjArfeD77K5/epqJ2u45sSzI
         Vaj2sUd5ji48J77MBs8qPHApGTEvZs10OmpPaR5wwmBEwq5a3uTlHtUWPXV6EznjM46F
         eC0lp/8zKDYlDOyAI8fv1ysrudU2kt8EwfDGhZwh9vB6Q5XrSQOlh5xfwqqLI07mY7aq
         ITg5OoalbwHcByEO8YEjpC5bMYc2ErMX3FiooZjsmaV3MXnXgBUd62CrXceUYzPoACjC
         Q4Dub3IHPu0ZPrvpg3CUPTWAnS8oRbeZLp4EJ+uKJy2XPnK+jtuEVP5BH/IogL4lbk3n
         j3NQ==
X-Gm-Message-State: AOJu0YwTgYU2T8MxW+rD9zzHivYw15KB5Am1qmKnamMl95DpbzZvJ77v
	HdnBEutf6qJ7QzPIdsAvcT5Ig2vC5gvK2IEVHRwCssFG+nzvCGU+BzIWcWzkvyhJZeluU4EW6mH
	HMCdU88yAB9lRtU8HIxebaymikukYV5vD6G8/
X-Google-Smtp-Source: AGHT+IELPiyYZO2W5SWMYAV/NXcUwl2eP3WFiKv6HN04TdUu8mgKQ9axzX6fizUiSeDsLiqDqz+ruqnKSgfwNjBrR7M=
X-Received: by 2002:a25:c5c7:0:b0:de5:52a8:5d34 with SMTP id
 v190-20020a25c5c7000000b00de552a85d34mr18913ybe.43.1714494033265; Tue, 30 Apr
 2024 09:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430161437.2100295-1-fvdl@google.com>
In-Reply-To: <20240430161437.2100295-1-fvdl@google.com>
From: Frank van der Linden <fvdl@google.com>
Date: Tue, 30 Apr 2024 09:20:21 -0700
Message-ID: <CAPTztWYC_-tdFv5bwTrhtRL61SQSmGfsNQ-r1dy9fy_oCWVnsQ@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: align cma on allocation order, not demotion order
To: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note that this applies on top of:

https://lore.kernel.org/lkml/20240404162515.527802-2-fvdl@google.com/

.which is in mm-stable right now. It's not a fixup of that patch,
though, it's a separate issue. Although they could be combined in to a
"fix arguments to cma_declare_contiguous_nid" commit.

On Tue, Apr 30, 2024 at 9:14=E2=80=AFAM Frank van der Linden <fvdl@google.c=
om> wrote:
>
> Align the CMA area for hugetlb gigantic pages to their size, not the
> size that they can be demoted to. Otherwise there might be misaligned
> sections at the start and end of the CMA area that will never be used
> for hugetlb page allocations.
>
> Signed-off-by: Frank van der Linden <fvdl@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Fixes: a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA")
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5dc3f5ea3a2e..cfe7b025c576 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7794,7 +7794,7 @@ void __init hugetlb_cma_reserve(int order)
>                  * huge page demotion.
>                  */
>                 res =3D cma_declare_contiguous_nid(0, size, 0,
> -                                       PAGE_SIZE << HUGETLB_PAGE_ORDER,
> +                                       PAGE_SIZE << order,
>                                         HUGETLB_PAGE_ORDER, false, name,
>                                         &hugetlb_cma[nid], nid);
>                 if (res) {
> --
> 2.45.0.rc0.197.gbae5840b3b-goog
>

