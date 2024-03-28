Return-Path: <linux-kernel+bounces-123448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6787A8908D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048361F26F76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49BD137909;
	Thu, 28 Mar 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EuRHhQSu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587A13775B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652504; cv=none; b=mnNTAhxQ0LIiOBQ0RBDjVMeEGFw5R+i3ZXOQ7gdYChpsoFx6VQqcUWa7r26Lh9oqwcqtUZfvJOfFPn4aaRVAzyt7IIt7mqcczURmh9MKW6pok/BfAERepmqWJNc5NqLnyIJpkiUAfaMc2AEmCzA24VSZwVFT6SyVqG0AQ2Xgeqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652504; c=relaxed/simple;
	bh=75zJQi6/t8Bugee7Y/WvYhL+nXJNnuKScwY0EXrSoes=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZXI+M8hjvSKSTpkNNqJMgiWt89R7M+ZAx7DFenE0jikZL72UYjstpzQqXsWAdKMSpKTJT9VY6YFsQLGz0X1ElxVCYdBrrdKdZ5euSw7VhIgEEAV6dNKruBY9USmlFVn8J+pOVJzNb60Dz14B5Y/qSxPv7VgxUTcz2jMSJlbVxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EuRHhQSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F78C433F1;
	Thu, 28 Mar 2024 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711652503;
	bh=75zJQi6/t8Bugee7Y/WvYhL+nXJNnuKScwY0EXrSoes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EuRHhQSuhT6UhLje68IlwmCQqCGilcULpK7LoI7ffKimNB38kuwasGAwdmey5M3bK
	 w76Dbmfxu5cMJPhJmPKXGTUSaluFio9ZuNxZZjD9m62mGWpZNm0O1s3PHo4jeQl/xU
	 PchmtkI3nAt7scT0o5FtyP+3XAlYHJwqdV8wlpBc=
Date: Thu, 28 Mar 2024 12:01:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Yang Shi <shy828301@gmail.com>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, Mike Kravetz <mike.kravetz@oracle.com>, John
 Hubbard <jhubbard@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Jones <andrew.jones@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Rik van Riel <riel@surriel.com>, linux-arm-kernel@lists.infradead.org,
 Andrea Arcangeli <aarcange@redhat.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, James Houghton
 <jthoughton@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport
 <rppt@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v4 06/13] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-Id: <20240328120142.32c6676dc7fbf1af82da5e58@linux-foundation.org>
In-Reply-To: <372a9331-6d95-4083-9a8f-a4f714868bea@redhat.com>
References: <20240327152332.950956-1-peterx@redhat.com>
	<20240327152332.950956-7-peterx@redhat.com>
	<372a9331-6d95-4083-9a8f-a4f714868bea@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 11:10:59 +0100 David Hildenbrand <david@redhat.com> wrote:

> @Andrew, you properly adjusted the code to remove the 
> gup_fast_folio_allowed() call instead of the folio_fast_pin_allowed() 
> call, but
> 
> (1) the commit subject
> (2) comment for gup_huge_pd()
> 
> Still mention folio_fast_pin_allowed().
> 
> The patch "mm/gup: handle hugepd for follow_page()" then moves that 
> (outdated) comment.

OK, thanks, I fixed all that up.

