Return-Path: <linux-kernel+bounces-110144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D3885A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157991C20E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98E85279;
	Thu, 21 Mar 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="c3R/RtTs"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033D84A5A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031081; cv=none; b=s+bUG8wxAnRNYnpXAQ7yhhI3mERXWpVceHDX+6gyMA6C2Uw2ySIWz4pCFV2bC+aA2zkE4UGGZ1KSyxQylVDtZ7StJ0xak72qwGM8RugLBRaCJp+7bYhSEJHjtw/u5hw0qiBYuZfR6NveMB5ZDlOdvsXXg/1sQeh0+WQfM0yeXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031081; c=relaxed/simple;
	bh=IGmZ72nnCoCD5q22ThDUsDJdidoptCJfZ2WGQFwMMoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmpfW9kfqmQov42ckDe3pBiOBCsYOI7Dvx1S3vZt/cmbViutEHhbNUm7NhkYmUjQ4/DBA02G7XhkwalsDS5kNdYY5kGfHJ878VNIZtWFj590pD68TcjUpyCEzR/fCgFW+ri4+hzIu52GpP5aU/EWQdlcjd8H3zuOps+K/UshFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=c3R/RtTs; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-222a9eae9a7so466713fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711031078; x=1711635878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMwHK5SLtdqChoTJnZ8oDxJRYwecYOvB8jcFY9CBgVk=;
        b=c3R/RtTsf9/D6hahGrL5bR4TCe86GBe7vokXYAurwPNAQvtwB0UKMiqwWilTo4PNbV
         XEYiGIk8EHKekx7rz0raSdjkAG65zZEZVLj7FXKljpi8YbKpOONeATZDALTkgw7FYTKw
         9iy77zj7WJ0zKSNwFPSfVvQcJkOrxu5kvcTJHoyEuTCYT/Uy9p+DuFoAEBZjz90XpKMa
         BU3ukatPztrfSTKToeidGcXsXOt80ZDY7C2tGf1UgTDo+fmObd0CITEzUj5Lg1koef9R
         +tWuVqhywuir+83UgZX/sEn5fS77pCSy7hUYXi+eDGccqpTiujVRkbgb4ZcH49jd4vQk
         A5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711031078; x=1711635878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMwHK5SLtdqChoTJnZ8oDxJRYwecYOvB8jcFY9CBgVk=;
        b=Z48nhelPYqZiBB1oKC4jqpKw+ScS61TMWh/c9Phm58tiPjW1CbvsyoSBP9VIP/AUgA
         7Xn4W24rlO3Z+cC5jAKDYmdTk4QVN3AyytVmG9xzfMNq1GbBsuJSnhLccIRkHwQghJoJ
         uC1HCvc/JmXJ2LSS8CboR0Ea822BPDpC3UvqdtBeB7vRRc0gKVfpbtNbZaoxkhGK7jl+
         EbKlmD8mw2gct3vL5KvNhgzTPbRBKzo7Cp+65AF+9DTonwprRvsIY6BIK8x38RENkJhp
         hkLlWdygw9WGGEIrHeP1xX58kmtUlHdUsJcSwAjDt4tRur/JidWDtDToya94RhLpBM3d
         9KMg==
X-Forwarded-Encrypted: i=1; AJvYcCWszrC5uWEGfnPwi+nCQhJKiQKMhWuvDu+ywb2WmCLYn2ij+6fLOBqHP5uScrRxb5B5TIGC83MmZvm58e4Q33PbhUlh2+yRtx1TuKdt
X-Gm-Message-State: AOJu0Yz8SGxTOoIOexLxi2Y43ERhtoSHPZt8VfLkuAGoLnamTU7qftf6
	HnM+4JwW6JA8L0fqRDW1hG8wlcfQKbg/vGash0wnHt6VfJ6Y9MOKJDTHbvQh0Qs=
X-Google-Smtp-Source: AGHT+IFov2e+/kQxGWoYd6pon9dB6ic+JHmJrCaJt3wZ16SD0JwIMpyHn3WTmkRdA23DHfA9eY8cKg==
X-Received: by 2002:a05:6870:f10c:b0:222:6495:642a with SMTP id k12-20020a056870f10c00b002226495642amr5490576oac.46.1711031077907;
        Thu, 21 Mar 2024 07:24:37 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id s14-20020a0562140cae00b0069124066c2fsm8956146qvs.140.2024.03.21.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:24:37 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:24:26 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
	Zi Yan <ziy@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] mm: page_isolation: prepare for hygienic freelists
Message-ID: <20240321142426.GB777580@cmpxchg.org>
References: <20240320180429.678181-10-hannes@cmpxchg.org>
 <202403212118.ye7lcKjD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403212118.ye7lcKjD-lkp@intel.com>

On Thu, Mar 21, 2024 at 09:13:57PM +0800, kernel test robot wrote:
> Hi Johannes,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Weiner/mm-page_alloc-remove-pcppage-migratetype-caching/20240321-020814
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240320180429.678181-10-hannes%40cmpxchg.org
> patch subject: [PATCH 09/10] mm: page_isolation: prepare for hygienic freelists
> config: i386-randconfig-003-20240321 (https://download.01.org/0day-ci/archive/20240321/202403212118.ye7lcKjD-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240321/202403212118.ye7lcKjD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403212118.ye7lcKjD-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    mm/page_alloc.c: In function 'move_freepages_block_isolate':
> >> mm/page_alloc.c:688:17: warning: array subscript 11 is above array bounds of 'struct free_area[11]' [-Warray-bounds]
>      688 |  zone->free_area[order].nr_free--;
>          |  ~~~~~~~~~~~~~~~^~~~~~~
> >> mm/page_alloc.c:688:17: warning: array subscript 11 is above array bounds of 'struct free_area[11]' [-Warray-bounds]

I think this is a bug in the old gcc.

We have this in move_freepages_block_isolate():

	/* We're the starting block of a larger buddy */
	if (PageBuddy(page) && buddy_order(page) > pageblock_order) {
		int mt = get_pfnblock_migratetype(page, pfn);
		int order = buddy_order(page);

		if (!is_migrate_isolate(mt))
			__mod_zone_freepage_state(zone, -(1UL << order), mt);
		del_page_from_free_list(page, zone, order);

And this config doesn't have hugetlb enabled, so:

/* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
#define pageblock_order         MAX_PAGE_ORDER

If buddies were indeed >MAX_PAGE_ORDER, this would be an out-of-bounds
access when delete updates the freelist count. Of course, buddies per
definition cannot be larger than MAX_PAGE_ORDER. But the older gcc
doesn't seem to realize this branch in this configuration is dead.

Maybe we can help it out and make the impossible scenario a bit more
explicit? Does this fixlet silence the warning?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index efb2581ac142..4cdc356e73f6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1698,6 +1698,10 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 				       NULL, NULL))
 		return false;
 
+	/* No splits needed if buddies can't span multiple blocks */
+	if (pageblock_order == MAX_PAGE_ORDER)
+		goto move;
+
 	/* We're a tail block in a larger buddy */
 	pfn = find_large_buddy(start_pfn);
 	if (pfn != start_pfn) {
@@ -1725,7 +1729,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		split_large_buddy(zone, page, pfn, order);
 		return true;
 	}
-
+move:
 	mt = get_pfnblock_migratetype(page, start_pfn);
 	nr_moved = move_freepages(zone, start_pfn, end_pfn, migratetype);
 	if (!is_migrate_isolate(mt))

Zi Yan, does this look sane to you as well?

