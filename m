Return-Path: <linux-kernel+bounces-57301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5327984D6BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0999B2820E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7928E8;
	Wed,  7 Feb 2024 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oHUa2w9M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A25200D9;
	Wed,  7 Feb 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349390; cv=none; b=RXlDCIQWzMbs9NMHa0ljfmEFfWg/TwtDZJlUbTiEki8c9BdL1GxQpsoWyoUJ0igAOJ/t0tv14w4axHStC5hLYef3mMbBsk9TcOUj5oSBtZWuYwb5/YseedBVh0x7ShHFQqcu9ZEn2/3QUM7yWMyFAMwwZ+luDZ/pC95bEui6i7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349390; c=relaxed/simple;
	bh=MSFIzvdxYtXmQVrYnhwiJReGuZF/2JziUGpHlCPhyaw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s9nhjsYRvOZUcbEEPcfZAokjgsTMp+cfxu6K4dAOUD7li3E2vbzsFadrqSX0N18pHhm1wFVnk86UsszkudEz2/BDAmS1zA+nP05uIFwokBCxaidx+bOswRIRtWbh2y7aFcLbLokNFYzdLXe6T3akhZiEhDofc+WgTgQc3gbAGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oHUa2w9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF0EC433C7;
	Wed,  7 Feb 2024 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707349389;
	bh=MSFIzvdxYtXmQVrYnhwiJReGuZF/2JziUGpHlCPhyaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oHUa2w9MenXTtmVIymyF4c5sKPZHCruv1r9X4zN9BxrNK/80ZmTF2ddMarPHIJVAY
	 0SiUeiabq6KSm+T3IJtbVXgdFxwgARuxz0vN7UK7gp6ym2mr0TD/Fk/k3sy0Lfvbxj
	 YkyjE9akdJHBxBwa0bTmyvsbjOVR3RZ7cfHfpcPs=
Date: Wed, 7 Feb 2024 15:43:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: chengming.zhou@linux.dev
Cc: hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Chengming Zhou
 <zhouchengming@bytedance.com>, stable@vger.kernel.org, Chris Li
 <chrisl@kernel.org>
Subject: Re: [PATCH v4] mm/zswap: invalidate old entry when store fail or
 !zswap_enabled
Message-Id: <20240207154308.bc275f3e72ec1c1fd06cf5a2@linux-foundation.org>
In-Reply-To: <20240207115406.3865746-1-chengming.zhou@linux.dev>
References: <20240207115406.3865746-1-chengming.zhou@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 11:54:06 +0000 chengming.zhou@linux.dev wrote:

> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We may encounter duplicate entry in the zswap_store():
> 
> 1. swap slot that freed to per-cpu swap cache, doesn't invalidate
>    the zswap entry, then got reused. This has been fixed.
> 
> 2. !exclusive load mode, swapin folio will leave its zswap entry
>    on the tree, then swapout again. This has been removed.
> 
> 3. one folio can be dirtied again after zswap_store(), so need to
>    zswap_store() again. This should be handled correctly.
> 
> So we must invalidate the old duplicate entry before insert the
> new one, which actually doesn't have to be done at the beginning
> of zswap_store(). And this is a normal situation, we shouldn't
> WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
> to detect swap entry UAF problem? But not very necessary here.)
> 
> The good point is that we don't need to lock tree twice in the
> store success path.
> 
> Note we still need to invalidate the old duplicate entry in the
> store failure path, otherwise the new data in swapfile could be
> overwrite by the old data in zswap pool when lru writeback.
> 
> We have to do this even when !zswap_enabled since zswap can be
> disabled anytime. If the folio store success before, then got
> dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store(). So later lru writeback
> may overwrite the new data in swapfile.
> 
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Cc: <stable@vger.kernel.org>

We have a patch ordering issue.

As a cc:stable hotfix, this should be merged into 6.8-rcX and later
backported into -stable trees.  So it will go
mm-hotfixes-unstable->mm-hotfixes-stable->mainline.  So someone has to
make this patch merge and work against latest mm-hotfixes-unstable.

The patch you sent appears to be based on linux-next, so it has
dependencies upon mm-unstable patches which won't be merged into
mainline until the next merge window.

So can you please redo and retest this against mm.git's
mm-hotfixes-unstable branch?  Then I'll try to figure out how to merge
the gigentic pile of mm-unstable zswap changes on top of that.

Thanks.

