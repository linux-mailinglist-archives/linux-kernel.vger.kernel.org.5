Return-Path: <linux-kernel+bounces-54202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B8D84AC29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FDD1C2362A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B956B83;
	Tue,  6 Feb 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnJetQo5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4256B68
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186253; cv=none; b=lq37GRmbzppSnemJDcy+zVKSejn2fpGClroBSceKsw9DtdmSXzzuQTfeR+ZnTlkLdJ0SAkLHLbOKiYmFzhAWAf2XHvZ35/QulTGMAjwizWx6V6gaNCI66thhBoAWEsl+DiRAjidTSsuEdwIQ5uvOV3w4vswiPxVHEEx1cTEHdQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186253; c=relaxed/simple;
	bh=gP1SNSrFBlGtxxoCJK90VW8nMVu/mXcAmT+PUBPwbnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZK+jyCt7aeX2UEuDz2dEVEAb67cunz/up/pF6OjOyJ3jh7KUYeFOtGeOrsFglH/ezCo3Axw5UuBnrwAuIH0sZJ6wWAikZey3U9Qa+CvbELcNwGW0UB9xWw6wJH5lAxbQchbPRQxfgNYP4ZAzGBpjkJ7tKTJ5cQfZCptYWFmeok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnJetQo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B806CC4166D;
	Tue,  6 Feb 2024 02:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707186252;
	bh=gP1SNSrFBlGtxxoCJK90VW8nMVu/mXcAmT+PUBPwbnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RnJetQo5yXZtVIzdqT7I2bsQ2Q0rf/2IJ5s0/Hb4g88pYbpEhXK7vxpcNaUuXoAuc
	 Tah5pthrBmltjyo2WhboHUg05bJ/kxhO8MjQ6zRpVuodxGkyevLleK9PtY4DDtRaP0
	 MGo15cv/8l/yM3wfJaiOv42xDzscEGvtKAvPt/l15lRqu2sRakJT7Taf6FNtiD3ijB
	 I5GGiYRK16Z36NY3nPCfaMHD0yFovIei8pC3Bf2dmOOmCPHU3A4wwyvi2aQ3mj/mKp
	 TZDaFIAGn1USMl61w7761TV9JG4lzLbwDEkOUo7j0kItsGL6oH1YweLO+x8TNdkjLn
	 o+NGYn5w8sqOA==
From: SeongJae Park <sj@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yu Zhao <yuzhao@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH] mm/swap: fix race condition in direct swapin path
Date: Mon,  5 Feb 2024 18:24:09 -0800
Message-Id: <20240206022409.202536-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205110959.4021-1-ryncsn@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kairui,

On Mon,  5 Feb 2024 19:09:59 +0800 Kairui Song <ryncsn@gmail.com> wrote:

[...]
>  mm/memory.c   | 19 +++++++++++++++++++
>  mm/swap.h     |  5 +++++
>  mm/swapfile.c | 16 ++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..fd7c55a292f1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3867,6 +3867,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!folio) {
>  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>  		    __swap_count(entry) == 1) {
> +			/*
> +			 * With swap count == 1, after we read the entry,
> +			 * other threads could finish swapin first, free
> +			 * the entry, then swapout the modified page using
> +			 * the same entry. Now the content we just read is
> +			 * stalled, and it's undetectable as pte_same()
> +			 * returns true due to entry reuse.
> +			 *
> +			 * So pin the swap entry using the cache flag even
> +			 * cache is not used.
> +			 */
> +			if (swapcache_prepare(entry))
> +				goto out;
> +

I'm getting below build error after this patch.  I guess maybe the code need to
take care of CONFIG_SWAP unset case?

    .../mm/memory.c: In function 'do_swap_page':
    .../mm/memory.c:4004:8: error: implicit declaration of function 'swapcache_prepare'; did you mean 'swapcache_clear'? [-Werror=implicit-function-declaration]
     4004 |    if (swapcache_prepare(entry))
          |        ^~~~~~~~~~~~~~~~~
          |        swapcache_clear


Thanks,
SJ

[...]

