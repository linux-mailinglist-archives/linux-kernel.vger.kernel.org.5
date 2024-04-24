Return-Path: <linux-kernel+bounces-157582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FA98B132D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4682821EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC871D53C;
	Wed, 24 Apr 2024 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PeLggIeu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE41CD23;
	Wed, 24 Apr 2024 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985542; cv=none; b=Cd35nBv5NB2v0o+sMExMTQE8M4BE3sGSBbaC+Hjtli2L4hB+AdygeykdlbJKrYJPwGvoVVin8sDEOSFWNwXLt4Abd0H/UeKHw9A3zYb3WyPgiCR2pYtjRmHj2M+7kFAnmYS/3BxtZKckFM12wxTMuiS92epuDMBfiR/am0HHjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985542; c=relaxed/simple;
	bh=uVVbF6GiMkgakd5lE+ffSY73qbJQOEixg3E8AGCtuRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TTpvirjoqsv42VO0DC6gYaI+46fwlAZwdFrArt5ywd/IT3ZsUbQpCOmU03C+CK8kvQaHNB3+m0HC9gGT4A1+a1LRasr88oNqGypHpxsV4azU1PXdMw0ySEGGXHshAL6N1FmNuhZ6SU4M7Q4zbFpPkNTjFYp9hBZ2HKu5sVGwsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PeLggIeu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3DF7447C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713985540; bh=Wy2B2R3KR5uxKB4u7+d/2AoPngeFSanEnSg9ZOiJgvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PeLggIeuYIB7dnU4p1Hfm3JIoU5PeaXgID4uhnejqnoIBfrI8V9wRL2GC5jW8Yb6G
	 rJ4BAmRPgFXdncOtt+rMygYoR+DdK9RvU45bnfELOoXZzcuy2KGhwZx06YA2OYHqrO
	 KqBlUQmZ8FM3M71hLysBpQ49w4zQehQq9e+HCLD9jq5+4dUF3smT/Emf4RTYimHAar
	 HyDs2qq5nu7Mma8Q9vluGz2awA0PFAODIxpUjOMzisbkwTRnyfbR1TjqXUNdEMjmh1
	 KwQzAeOwOuVQpUPgAirV72apwo5Xj8w/ustBYIkpJwBGbWuJnfCN6w9UdQdxWAaBMS
	 qE610/gz0BgSg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3DF7447C41;
	Wed, 24 Apr 2024 19:05:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Tejun
 Heo <tj@kernel.org>, David Hildenbrand <david@redhat.com>, Wei Yang
 <richard.weiyang@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>,
 Huang Ying <ying.huang@intel.com>, Mel Gorman
 <mgorman@techsingularity.net>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel-dev@igalia.com, =?utf-8?Q?Ma=C3=ADra?= Canal
 <mcanal@igalia.com>
Subject: Re: [PATCH] mm: Update shuffle documentation to match its current
 state
In-Reply-To: <20240422142007.1062231-1-mcanal@igalia.com>
References: <20240422142007.1062231-1-mcanal@igalia.com>
Date: Wed, 24 Apr 2024 13:05:39 -0600
Message-ID: <874jbqtwcc.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ma=C3=ADra Canal <mcanal@igalia.com> writes:

> Commit 839195352d82 ("mm/shuffle: remove dynamic reconfiguration")
> removed the dynamic reconfiguration capabilities from the shuffle page
> allocator. This means that, now, we don't have any perspective of an
> "autodetection of memory-side-cache" that triggers the enablement of the
> shuffle page allocator.
>
> Therefore, let the documentation reflect that the only way to enable
> the shuffle page allocator is by setting `page_alloc.shuffle=3D1`.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
>  mm/Kconfig                                      |  7 +++----
>  2 files changed, 7 insertions(+), 10 deletions(-)

Applied, thanks.

jon

