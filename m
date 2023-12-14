Return-Path: <linux-kernel+bounces-187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E07813D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1234B21AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8F56D1C5;
	Thu, 14 Dec 2023 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VSnEPKWP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A30697AB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04134C433C7;
	Thu, 14 Dec 2023 22:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702592601;
	bh=/iBybz/14xsX0TqeFyiHuR4ZDEOsekfMZngpMh9rS48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSnEPKWPkGYfgsbBCkycraDrTgZUJS3vjZs0plA5/JOOin935OlbvZml8Kf2FF8AG
	 4Laa4y6xXHx9N+pVIo6AjEUQYhihc6CrCGi22v4o0vJVOu6JHrIeBzt/UPFVoVBuvM
	 MXoFG0AVuuMJP1HO7hFDcAnXT9biAB3IzIabrXCg=
Date: Thu, 14 Dec 2023 14:23:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Nhat Pham
 <nphamcs@gmail.com>, Chris Li <chriscli@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Seth Jennings <sjenning@redhat.com>, Dan Streetman
 <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
Message-Id: <20231214142320.f5cf319e619dbb2127c423e9@linux-foundation.org>
In-Reply-To: <CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
	<20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com>
	<CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 13 Dec 2023 17:02:25 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:

> On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > Also after the common decompress part goes to __zswap_load(), we can
> > cleanup the zswap_reclaim_entry() a little.
> 
> I think you mean zswap_writeback_entry(), same for the commit title.

I updated my copy of the changelog, thanks.

> > -       /*
> > -        * If we get here because the page is already in swapcache, a
> > -        * load may be happening concurrently. It is safe and okay to
> > -        * not free the entry. It is also okay to return !0.
> > -        */
> 
> This comment should be moved above the failure check of
> __read_swap_cache_async() above, not completely removed.

This?

--- a/mm/zswap.c~mm-zswap-cleanup-zswap_reclaim_entry-fix
+++ a/mm/zswap.c
@@ -1457,8 +1457,14 @@ static int zswap_writeback_entry(struct
 	mpol = get_task_policy(current);
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
 				NO_INTERLEAVE_INDEX, &page_was_allocated, true);
-	if (!page)
+	if (!page) {
+		/*
+		 * If we get here because the page is already in swapcache, a
+		 * load may be happening concurrently. It is safe and okay to
+		 * not free the entry. It is also okay to return !0.
+		 */
 		return -ENOMEM;
+	}
 
 	/* Found an existing page, we raced with load/swapin */
 	if (!page_was_allocated) {


