Return-Path: <linux-kernel+bounces-150752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA058AA41F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD35C2822E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9E190670;
	Thu, 18 Apr 2024 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HE17W2pX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CC184135
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472698; cv=none; b=NYxJK/Gokc13jkc75MZHO3d7OozQ0IxMYX9FQ02IwHjqAqSJAtc2FPt9yETSjid5QsT6rtbU3RABmvNdb9mHr8Z9R0+2kS5vSvwSybjuwD34vwHkgFCzlrIZ/XRmkVImlbedNEMkSrpJlsEeyhobEGi4TjlXBBJOD6y8O6w9xE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472698; c=relaxed/simple;
	bh=w5RGyzVBvoGAtMUsTnU34Y0CJu5FBsbDHlJjmWZiX9w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KVucJTIzo3HhLpHGNTyTNayxCl9uuWdy57oifMCl2WK/ybhzfEuFiKYoiI1vyqNE3YEU5UsDkircoDI1+kFBDuAkB0FyZqvDOdUDrV/VYDG8RWM+YEvyT7aOkN6rrLXUh+M2/NlVZ/FpHa3fSTbORZQOg07Nn6iR7N9UdimPDK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HE17W2pX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161D2C113CC;
	Thu, 18 Apr 2024 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713472698;
	bh=w5RGyzVBvoGAtMUsTnU34Y0CJu5FBsbDHlJjmWZiX9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HE17W2pXfryr1qP1csdJB5HMM6g/LCw0KRag6Rbrltd2xCWWYPBEjPp9b0p5aMxMO
	 6oP2ODaoNH3oXamowSKFFW5G+RFn+/+SA7bbm7KGWyNYHgx42d/6H4q9hm+OKWgRTc
	 67MKC0gHKcvMwEMXEjosllHUn9GWgZ9uOtKiEQmo=
Date: Thu, 18 Apr 2024 13:38:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <muchun.song@linux.dev>, <david@redhat.com>, <vbabka@suse.cz>,
 <willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm/hugetlb: fix unable to handle page fault for
 address dead000000000108
Message-Id: <20240418133817.afb65c8dcd11cfea7c686d25@linux-foundation.org>
In-Reply-To: <20240418022000.3524229-3-linmiaohe@huawei.com>
References: <20240418022000.3524229-1-linmiaohe@huawei.com>
	<20240418022000.3524229-3-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 10:20:00 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Below panic occurs when I did memory failure test:
> 
> BUG: unable to handle page fault for address: dead000000000108
> 
> ...
>
> The root cause is that list_del() is used to remove folio from list when
> dissolve_free_hugetlb_folio(). But list_move() might be used to reenqueue
> hugetlb folio when free_huge_folio() leading to above panic. Fix this
> issue by using list_del_init() to remove folio.
> 
> ...
>
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1642,7 +1642,7 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
>  
> -	list_del(&folio->lru);
> +	list_del_init(&folio->lru);
>  
>  	if (folio_test_hugetlb_freed(folio)) {
>  		h->free_huge_pages--;

We should cc:stable and find a Fixes:.  This appears to predate
6eb4e88a6d27022ea8aff424d47a0a5dfc9fcb34, after which I got lost.

