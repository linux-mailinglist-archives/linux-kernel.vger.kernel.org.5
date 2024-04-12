Return-Path: <linux-kernel+bounces-143428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04AD8A38DD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1441C22804
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277B152516;
	Fri, 12 Apr 2024 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jzG2Zj/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F90927442
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712964073; cv=none; b=orFNtd6wVt5uYSUH8TAOZHIvwo0v6q2nrr+gpbG+dMJsXJZNqunzYYY5L5+Qg3pHR9XSNqrNi5jK8PCJuRks5nM0WCkaB2bV2x8vXyqIKdcfKgLZNLMOsvlIHV3+rj8myzr5cwZI/6BSWz6TwY38XDMve2NdVZCAo8KuDXMDiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712964073; c=relaxed/simple;
	bh=2CrUSMy2ZQbQHtwUPbTAnJJXXmcemmqf6qltoaC24+0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Yvy0RnPFpLjErR+GXG0Nl1BzpMhEvAduZkthXFQ87zL+w3qYNwwGT214+Bm4Z5XsA6egnd9z6P61urWmyFqaJRPe01A5RuShu2kkqYceQfADyQp6iDPSGtUjRPY3wn/g+JZxWnhUafBvApIZYKh4CrWZUV6PySXjdt0SfrQ0cOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jzG2Zj/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBB2C113CC;
	Fri, 12 Apr 2024 23:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712964072;
	bh=2CrUSMy2ZQbQHtwUPbTAnJJXXmcemmqf6qltoaC24+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jzG2Zj/e+EIoPw+tfCjb2lfy5xRRoLIUrpA7NYkJKV9AQsw/dmjQbyUhxk0emFDGm
	 d5ZkyJHIuTuWRJp9sil5OpG6X2RNotWdQ0XnbWr8+Hj/w2H+sGSRgXM9Ec5NFlIps9
	 dRuK4XFh9hY0wAzSjyVbPtHCEv1T0eDzyzAjUq9M=
Date: Fri, 12 Apr 2024 16:21:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>, <naoya.horiguchi@nec.com>,
 <osalvador@suse.de>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
Message-Id: <20240412162111.10f67ad0f001734464b53ad8@linux-foundation.org>
In-Reply-To: <8d186776-f3b1-5d9a-2f94-fa249dee7d5f@huawei.com>
References: <20240412025754.1897615-1-linmiaohe@huawei.com>
	<48647e5b-d15b-457b-9879-fb1b6bbaee27@oracle.com>
	<8d186776-f3b1-5d9a-2f94-fa249dee7d5f@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 16:11:52 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> > I recently sent a patch[1] to convert dissolve_free_huge_page() to folios which changes the function name and the name referenced in the comment so this will conflict with my patch. It's in mm-unstable now, would you be able to rebase to that in a new version?
> > 

This patch is a hotfixes, cc:stable one so the mm-unstable material will be
based on top of this change.

I've queued this change up as a -fix against v1.  And I've retained
this changelog addition:

: This issue won't occur until commit a6b40850c442 ("mm: hugetlb: replace
: hugetlb_free_vmemmap_enabled with a static_key").  As it introduced
: rlock(cpu_hotplug_lock) in dissolve_free_huge_page() code path while
: lock(pcp_batch_high_lock) is already in the __page_handle_poison().

And I've queued another -fix to reflow that block comment to 80 columns.

--- a/mm/memory-failure.c~mm-memory-failure-fix-deadlock-when-hugetlb_optimize_vmemmap-is-enabled-v2-fix
+++ a/mm/memory-failure.c
@@ -155,14 +155,16 @@ static int __page_handle_poison(struct p
 	int ret;
 
 	/*
-	 * zone_pcp_disable() can't be used here. It will hold pcp_batch_high_lock and
-	 * dissolve_free_huge_page() might hold cpu_hotplug_lock via static_key_slow_dec()
-	 * when hugetlb vmemmap optimization is enabled. This will break current lock
-	 * dependency chain and leads to deadlock.
-	 * Disabling pcp before dissolving the page was a deterministic approach because
-	 * we made sure that those pages cannot end up in any PCP list. Draining PCP lists
-	 * expels those pages to the buddy system, but nothing guarantees that those pages
-	 * do not get back to a PCP queue if we need to refill those.
+	 * zone_pcp_disable() can't be used here. It will
+	 * hold pcp_batch_high_lock and dissolve_free_huge_page() might hold
+	 * cpu_hotplug_lock via static_key_slow_dec() when hugetlb vmemmap
+	 * optimization is enabled. This will break current lock dependency
+	 * chain and leads to deadlock.
+	 * Disabling pcp before dissolving the page was a deterministic
+	 * approach because we made sure that those pages cannot end up in any
+	 * PCP list. Draining PCP lists expels those pages to the buddy system,
+	 * but nothing guarantees that those pages do not get back to a PCP
+	 * queue if we need to refill those.
 	 */
 	ret = dissolve_free_huge_page(page);
 	if (!ret) {
_


