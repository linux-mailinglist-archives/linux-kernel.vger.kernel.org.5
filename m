Return-Path: <linux-kernel+bounces-79885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B38627E8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC36282271
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D104D5A2;
	Sat, 24 Feb 2024 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi1+wEyM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434FD1400B;
	Sat, 24 Feb 2024 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708812502; cv=none; b=suQG0gDYXlV9OAxdnr+ClCdJ+FbNVz3XLVbqOuYstcQtMO5j06xo5419nN79BhtycqQPYAvx2xeq786SeMnolGcYxphtBrZh5C4HkGSVVvRUOsJRNOnUO1Qd0SL+lF+I1GdcvMSczf6RPg5MG1mY8qBZurEUnwwlUBo0bsIuK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708812502; c=relaxed/simple;
	bh=ADFjQxG/AhdapZ5PMm8RKhbeE27ny3x7l4wkghgcu7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmLi++T9tCtgm/ghapXZPhKu3liYzWEMrRJyb5e7hcGib1o/SiBLRBUwW8+3oM1Ut70o8B8kLPqpIBlbP/AG6o1DqCfc1sXOyrL/2lQj8qQwIpahTMDmvflbrx+wU5aN6WbRYTj21zmChTJ6ord1sXdU1HM62D4jrI7nR3XrPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi1+wEyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302BC433C7;
	Sat, 24 Feb 2024 22:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708812501;
	bh=ADFjQxG/AhdapZ5PMm8RKhbeE27ny3x7l4wkghgcu7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yi1+wEyMJe0GOA+eqYdg02KZKznkZ4hezi7j2W5FOnOnpKDoeQ3LApOJq5Qv1nzf8
	 YGqwCArnPPyP1xiQbsJUwG77txta95HaLoPNAtZL/T6O1qbcp2UvA2Ozi0nXzCgz3G
	 FEQ0vEGa7bdUfAe4OBhykIZXKMeU4jMpSdmQsfr4y8so+M70X53NerfbEPN6W6jN3d
	 evoOoeDSt3gvMPheVjhSl9r23WS6dxLFjzb7Qz6CT6781HhU93m9reCbGnfk0SmZtc
	 KjF14ap2ioX2PWXBI/gJwV5/shTGuSihvgeitBB3VvLbuucBFMhPDhvKRvO3gwVPUN
	 MNRBusuCmEeig==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: corbet@lwn.net,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] Docs/mm/damon/design: describe the differences for pageout's virtual address and physcial address
Date: Sat, 24 Feb 2024 14:08:19 -0800
Message-Id: <20240224220819.49277-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240224215023.5271-1-21cnbao@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Barry,

On Sun, 25 Feb 2024 10:50:23 +1300 Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <v-songbaohua@oppo.com>
> 
> The doc needs update. As only in the case of virtual address, we are
> calling madvise() with MADV_PAGEOUT; but in the case of physical
> address, we are actually calling reclaim_pages() directly. And
> madvise() with MADV_PAGEOUT is much more aggresive on reclamation
> compared to reclaim_pages() on paddr.

Thank you for this nice patch :)

> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  Documentation/mm/damon/design.rst | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index 8c89d26f0baa..6c50743552f5 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -315,7 +315,13 @@ that supports each action are as below.
>     Supported by ``vaddr`` and ``fvaddr`` operations set.
>   - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
>     Supported by ``vaddr`` and ``fvaddr`` operations set.
> - - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
> + - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT`` if
> +   the region is using virtual address; otherwise, call ``reclaim_pages()``
> +   for the region if physical address is used.
> +   ``madvise()``  with ``MADV_PAGEOUT``  is aggressively reclaiming memory
> +   when pages are not shared by multiple processes. Differently, paddr's
> +   pageout  will do the best-effort reclamation by scanning PTEs to figure
> +   out if pages are young, if not, pages are reclaimed.

I think this might be too much details.  Especially, explanation of
``MADV_PAGEOUT`` might better to be done on it's document.  We wouldn't want to
update two places for future changes to ``MADV_PAGEOUT``.  What do you think
about making it simple and independent from the implementation detail?  For
example,

    - - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
    + - ``pageout``: Reclaim the region.

Thanks,
SJ

>     Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
>   - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
>     Supported by ``vaddr`` and ``fvaddr`` operations set.
> -- 
> 2.34.1

