Return-Path: <linux-kernel+bounces-132099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64115898F94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893491C2290C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1012CD8F;
	Thu,  4 Apr 2024 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NTlQyc15"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419681BF2B;
	Thu,  4 Apr 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262699; cv=none; b=s8nUYNUiwN2PIyrn+s2gkHtsE1kC9YygL/rCzigYMJFWoS6HgE3GcjesFl7shtyvr3FHawcHJuXulcnGHwpf6/m2VrlUmuP0VyGM8odXwaAUC8H5DlebS69rDFxcILjv14iR02dQmj/0PU8EUERslE+jUNIKuakKEM41b/6NGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262699; c=relaxed/simple;
	bh=Hew0RwkTVS+l0xV7qv/+83XciUA+bvPNzdeJES2OSX0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZBbnguVXMOLbVs4BROYQAGehj0BlHgA7eUwxjjYL4GGr/19XOW8sWg9rQuFJpoPC0y14oZ9FLCFQBzTBRHfo0j0Ja5E27wFiS+tXvdMTUFUEaWtOvkVa8NJKJhfFr6D21TRQPpReCValfe1RAQDfnPS+acw2hr73CkEOkfuwuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NTlQyc15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B6DC433F1;
	Thu,  4 Apr 2024 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712262698;
	bh=Hew0RwkTVS+l0xV7qv/+83XciUA+bvPNzdeJES2OSX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NTlQyc15FdIpH8wOQyWjdMc8ZAOzRRTs+StY6AGUQ8aSgIpT7U6MEU0T/fmuyZviy
	 K3fDvwFoqOb7TYdlZjCXLuzfOk9ivwYIWgn9HI2LADsG4HN4as9HbEaPxVkJuNrOZZ
	 fVFPdzrzbWjMzZ01wXPrfGGLtOHoybr3B9Q1Vl68=
Date: Thu, 4 Apr 2024 13:31:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, David
 Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Nathan
 Chancellor <nathan@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Ryan
 Roberts <ryan.roberts@arm.com>, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/3] mm: Allow anon exclusive check over hugetlb tail
 pages
Message-Id: <20240404133137.560d15c1a3bc7176424901fb@linux-foundation.org>
In-Reply-To: <Zg63YZaXqYdSLHG-@x1n>
References: <20240403013249.1418299-1-peterx@redhat.com>
	<20240403013249.1418299-2-peterx@redhat.com>
	<Zg3u5Sh9EbbYPhaI@casper.infradead.org>
	<Zg6vFtciZAl4SQHW@x1n>
	<Zg6z4ZEt7rbILgl8@casper.infradead.org>
	<Zg63YZaXqYdSLHG-@x1n>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 10:21:21 -0400 Peter Xu <peterx@redhat.com> wrote:

> Andrew, could you help update with Matthew's fixup?  The comment is
> definitely better than what I wrote in all cases.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-allow-anon-exclusive-check-over-hugetlb-tail-pages-fix
Date: Thu Apr  4 01:27:47 PM PDT 2024

simplify PageAnonExclusive(), per Matthew

Link: https://lkml.kernel.org/r/Zg3u5Sh9EbbYPhaI@casper.infradead.org
Cc: David Hildenbrand <david@redhat.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: WANG Xuerui <kernel@xen0n.name>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/page-flags.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/include/linux/page-flags.h~mm-allow-anon-exclusive-check-over-hugetlb-tail-pages-fix
+++ a/include/linux/page-flags.h
@@ -1096,11 +1096,10 @@ static __always_inline int PageAnonExclu
 {
 	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
 	/*
-	 * Allow the anon-exclusive check to work on hugetlb tail pages.
-	 * Here hugetlb pages will always guarantee the anon-exclusiveness
-	 * of the head page represents the tail pages.
+	 * HugeTLB stores this information on the head page; THP keeps it per
+	 * page
 	 */
-	if (PageHuge(page) && !PageHead(page))
+	if (PageHuge(page))
 		page = compound_head(page);
 	return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
 }
_


