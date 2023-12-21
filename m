Return-Path: <linux-kernel+bounces-9013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855381BF3F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC331C23F78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC820317;
	Thu, 21 Dec 2023 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VMKdh2gt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29B651B4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jkYZaGzPxkq2kteSU3jlRwqK1FmL8my5278X4xLgGkM=; b=VMKdh2gtMwrC3FAIuyqWrG9EQn
	U28olh8j+a+NXdl4qQ84hTfiqSlI00X9abBsH8obLeyLcxgOuBI/rCKbTf1tfce4iVTnqhLRG5yNk
	Dj5BJirDtX973eF2mf8ltVGphu/5yFP6FWk1n1rOKOJJ+5dZQ8zDQCP0nXoA8S8S3m4fsTjhsi56p
	fvjc75daOgfV1wjzw+CQmSMy9a3L8t6BSiBB3P6qS2SuE/4rohcV1K4MvrASjRNc0Nv4S8UiPaQJy
	qQWTBd/2jPjM1RL9c66u/iBMw5ZpEauG3HofqHTBpIL2CZhV0+3OxeEzsOmho2PsYVQRSp+ufDqu5
	yvMzEBxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGP4J-0061YK-D2; Thu, 21 Dec 2023 19:50:55 +0000
Date: Thu, 21 Dec 2023 19:50:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Fangrui Song <maskray@google.com>
Cc: Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Song Liu <songliubraving@fb.com>, Miaohe Lin <linmiaohe@huawei.com>,
	linux-kernel@vger.kernel.org, Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: Re: [PATCH] mm: remove VM_EXEC requirement for THP eligibility
Message-ID: <ZYSXH58aQpI1SLr2@casper.infradead.org>
References: <20231220054123.1266001-1-maskray@google.com>
 <CAHbLzkpZomZBHVkSpCiK-hZUoZi4x2N6MB=PtFj-cBHOVhYs7Q@mail.gmail.com>
 <CAFP8O3+5fKcGS8xEY5=DHqsN0YdybEY178nM+cXRY1bbQXV4WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFP8O3+5fKcGS8xEY5=DHqsN0YdybEY178nM+cXRY1bbQXV4WQ@mail.gmail.com>

On Wed, Dec 20, 2023 at 08:53:38PM -0800, Fangrui Song wrote:
> Thanks for the comment. Frankly, I am not familiar with huge pages...
> I noticed this VM_EXEC condition when I was writing this
> hugepage-related section in
> https://maskray.me/blog/2023-12-17-exploring-the-section-layout-in-linker-output#transparent-huge-pages-for-mapped-files
> (Thanks to Alexander Monakov's comment about
> CONFIG_READ_ONLY_THP_FOR_FS in
> https://mazzo.li/posts/check-huge-page.html).

CONFIG_READ_ONLY_THP_FOR_FS is a preliminary hack which solves some
problems.  The real solution is using large folios, which at the moment
means that you should test on XFS or AFS; filesystem authors have not
been enthusiastic about adding support to their filesystems so far.

In your blog, you write:

: In -z noseparate-code layouts, the file content starts somewhere at
: the first page, potentially wasting half a huge page on unrelated
: content. Switching to -z separate-code allows reclaiming the benefits
: of the half huge page but increases the file size. Balancing
: these aspects poses a challenge. One potential solution is using
: fallocate(FALLOC_FL_PUNCH_HOLE), which introduces complexity into the
: linker. However, this approach feels like a workaround to address a
: kernel limitation. It would be preferable if a file-backed huge page
: didn't necessitate a file offset aligned to a huge page boundary.

You should distinguish between file size (ie st_size in stat(3)) and
amount of space occupied on storage (st_blocks).  The linker should be
fine with creating a sparse file.  If it doesn't, cp --sparse will do
the trick.

Yes, it's a kernel limitation that folios have to be aligned within the
file as well as in both virtual and physical address space.  It's a huge
complexity win to do that; I don't think we'd be able to tile the page
cache effectively if we allowed folios to be placed at arbitrary offsets
(I think it turns into a knapsack problem at that point).

> As dTLB for read-only data is also an important optimization of
> file-backed THP, it seems straightforward that we should drop the
> VM_EXEC condition :)

I'm not particularly enthusiastic about making CONFIG_READ_ONLY_THP_FOR_FS
better.  Large folios are the future.  Indeed, I'd like to see
CONFIG_READ_ONLY_THP_FOR_FS go away in the next year or two once
btrfs and ext4 have support for large folios.


