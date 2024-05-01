Return-Path: <linux-kernel+bounces-165541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925BF8B8DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33D61C20B91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6A12FF78;
	Wed,  1 May 2024 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoJ5YH/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4C4CE1F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579687; cv=none; b=OzjTa7fWzRIrwD3obwdZDGEemU7x1wPKDNsLC0cUiUj0XYPFwFoObnQNGzG0qg2SSL7m4LsoGs/QBGLdrNpVCKDiDvYDEF95ZIMX5Fz6vC1sd7PybjkQL3qqk5D27e+25uYd+H6blxXnIS79WEBq2rwhBZOjid0J3YM/Fo29DL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579687; c=relaxed/simple;
	bh=mStrog2oMrxkyglXae6P8Wt6hb3v6cHyjuBTYN/mI7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+dkAR/fhz8Qh3ISQcvoNYb6JiZjpoPPNb+RK6NhyDVFo51DS5lyMnrEkwPfTdV70rBCuRr+47yCjDOgTI3A/8yedfEE0GEbttiPa6dpvwFb/2g5kpAUMZxEJCN1uTtyh28a431Dn8bB1Ga0Wly1KRn0VT9+G8AcfCsi5uAmacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoJ5YH/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C9DC113CC;
	Wed,  1 May 2024 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714579686;
	bh=mStrog2oMrxkyglXae6P8Wt6hb3v6cHyjuBTYN/mI7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoJ5YH/MqGf6uSCzNJ0ET0mIDAHqieqnDjfEjSGdAwHSC6WGhTEQjXMjXwxs6HcKG
	 uvEsDHXWz7WT/EZbQn7uILo940XO1L5EBH4Ty60X1kftIIEGbpXEejp4jZv5ztg+Zx
	 /gC+n5v6KvctbSy00csdX7/Ng02LV2G7CUlyMKjBXDOUBkgFxQKlhxyraUtPV3oyRA
	 qKQAFEfpwZo0mGeVZojF9LMXkMLn/6A7aDx4t1mM+dGV2A1XzrDhbB4e5hukAN7DKc
	 9Gdr1TrHFnpalexcq+zWVEOY2jcMDL3255Sc9+wxUKOOtLuDsnhrGqzqtoNl9gDl6M
	 iTXpNF6wbpJqg==
From: SeongJae Park <sj@kernel.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	willy@infradead.org,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Reclaim lazyfree THP without splitting
Date: Wed,  1 May 2024 09:08:03 -0700
Message-Id: <20240501160803.60988-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501042700.83974-1-ioworker0@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lance,

On Wed,  1 May 2024 12:26:57 +0800 Lance Yang <ioworker0@gmail.com> wrote:

> Hi all,
> 
> This series adds support for reclaiming PMD-mapped THP marked as lazyfree
> without needing to first split the large folio via split_huge_pmd_address().
> 
> When the user no longer requires the pages, they would use madvise(MADV_FREE)
> to mark the pages as lazy free. Subsequently, they typically would not re-write
> to that memory again.
> 
> During memory reclaim, if we detect that the large folio and its PMD are both
> still marked as clean and there are no unexpected references(such as GUP), so we
> can just discard the memory lazily, improving the efficiency of memory
> reclamation in this case.
> 
> Performance Testing
> ===================
> 
> On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
> mem_cgroup_force_empty() results in the following runtimes in seconds
> (shorter is better):
> 
> --------------------------------------------
> |     Old       |      New       |  Change  |
> --------------------------------------------
> |   0.683426    |    0.049197    |  -92.80% |
> --------------------------------------------
> 
> ---
> 
> Changes since v3 [3]
> ====================
>  - mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
>     - Resolve compilation errors by handling the case where
>       CONFIG_PGTABLE_HAS_HUGE_LEAVES is undefined (thanks to SeongJae Park)

I confirmed that the issue I reported before is disappeared with this version
of the patchset.  For the fix,

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

