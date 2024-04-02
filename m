Return-Path: <linux-kernel+bounces-127505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5165894CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227DE1C21FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41A03D0BE;
	Tue,  2 Apr 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjDkGXRL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B993CF65;
	Tue,  2 Apr 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042967; cv=none; b=jtnoRBv4Ig1mi59DFStvgfv29JSUVV6m16m0WEnOnyq/+fyOPvtdFUkYmEwgf7iZmF2BPfRuh6htzq+ezj8bI9g5V662sPtPe333wYIuYKAgADyMZ0DkCTEiL7/+1BU2km0UP/4R6N5M/31j1Z2OW4pSZlmCIUTybxtxC7eWINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042967; c=relaxed/simple;
	bh=qOicry9z85KjMA4krUEtV2LPv7uV/eb02RvZJJGSRL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRke16A8MnAPSrb/4wuIEEWE5XohDSuKcMSY0lpcS/cLMSzw6YhoP9F9kX4j5b+en7L90zpMkOzfJv2RvkwMtZ+SA0xprF1dJZjcqvs3n8+RhtK1WZyYZggi/cuQD88wH2n6LDgv4KSoTj27sMoZAjyOt7yrkhqBro7wxBbkMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjDkGXRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01353C433C7;
	Tue,  2 Apr 2024 07:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042966;
	bh=qOicry9z85KjMA4krUEtV2LPv7uV/eb02RvZJJGSRL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GjDkGXRLeXSxlcRYovEB1Pee7Y+iEj/+JSbkC/aQYrhaT6zD57IZwO5zf3+ec70PZ
	 CT86MYuJ4MXeuGNT90V5/Fyj5XSGha15SZz0Pz+Jr0D+z4UfBnaldBxegqdhes8P6V
	 PAcwNb+Gqm9cCWq+JYNld2RGNAVRz0lT6gMSBCARt43nfawALplsMH2OEpJjep/f0g
	 TUr8SZjyPcNUZCDpAvnxMURbmEpRcmbLkA4kMm5swqlejelwTqiHT1Nw2BO54a43Wg
	 +pUmtQZSjkg4H2HuAVHYaE35aaZ764YiKT7/KFDmQ8HX5D3KLlaudHVmwgfK/VKqWH
	 JQrCC45iSNBmQ==
Date: Tue, 2 Apr 2024 10:28:42 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, stable@vger.kenrel.org,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] mm, mmap: remove vma_merge()
Message-ID: <Zguzqq_PDDbyqh3Y@kernel.org>
References: <20240401192623.18575-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401192623.18575-2-vbabka@suse.cz>

On Mon, Apr 01, 2024 at 09:26:24PM +0200, Vlastimil Babka wrote:
> With SLAB gone I was looking for what I could delete next, and then it
> dawned on me - it should be vma_merge(). It's simply an unmaintainable
> mess.
> 
> The code is extremely hard to follow. There has been a number of recent
> attempts to made it more readable, by Liam, Lorenzo and myself. Almost
> every time this only resulted in subtle embarassing bugs [1] [2] [3] [4]
> [5]. For many of the bugs the only reliable testcase we have is the rpm
> process running in the Open Build Service. Which is worrying, as that
> clearly makes vma_merge() a potential supply chain attack vector for
> planting backdoors.
> 
> Thus simply remove vma_merge() and all the related code, and adjust all
> callers to take the path as if merging was attempted and failed.
> The only downside is that there might now be more vmas and maple tree
> nodes due to no merging. To extensively validate that, I've booted the
> kernel with virtme-ng before and after the change and checked slabinfo
> for the number of active objects:
> 
> before:
> maple_node          1159
> vm_area_struct      1538
> 
> after:
> maple_node          1113
> vm_area_struct      1861
> 
> Yeah there's more vma's but interestingly, less maple tree nodes. I
> believe it's worth it. The larger number of smaller vmas could even help
> with better parallelism thanks to per-vma locking. So the conclusion is
> obvious - we should have never tried merging vmas in the first place,
> hence the tags on this patch.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d014cd7c1c35
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4c6759967826
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e7757876f25
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1419430c8abb
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc0c8f9089c2
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This is hilarious, stable folks will be excited :)

> Cc: <stable@vger.kenrel.org> # CVE mandatory
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Singed-off-by-one: Vlastimil Babka <vbabka@suse.cz>
>
> ---
>  mm/internal.h |   7 -
>  mm/mmap.c     | 368 +++-----------------------------------------------
>  mm/mremap.c   |  60 --------
>  3 files changed, 17 insertions(+), 418 deletions(-)

-- 
Sincerely yours,
Mike.

