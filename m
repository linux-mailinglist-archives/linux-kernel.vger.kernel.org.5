Return-Path: <linux-kernel+bounces-966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 463F88148AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C725B1F24578
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C02D04C;
	Fri, 15 Dec 2023 13:00:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out187-13.us.a.mail.aliyun.com (out187-13.us.a.mail.aliyun.com [47.90.187.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7610951
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.Vl7PTuA_1702644264;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.Vl7PTuA_1702644264)
          by smtp.aliyun-inc.com;
          Fri, 15 Dec 2023 20:44:25 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: yuzhao@google.com
Cc:  <akpm@linux-foundation.org>,
  "Henry Huang" <henry.hj@antgroup.com>,
  "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
  "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
Date: Fri, 15 Dec 2023 20:44:17 +0800
Message-ID: <20231215124423.88878-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOUHufavCOqwkm4BJJzHY+RUOafFBLH7t0O+KRbw=ns-RdYwdA@mail.gmail.com>
References: <CAOUHufavCOqwkm4BJJzHY+RUOafFBLH7t0O+KRbw=ns-RdYwdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Dec 15, 2023 at 15:23 PM Yu Zhao <yuzhao@google.com> wrote:
>Regarding the change itself, it'd cause a slight regression to other
>use cases (details below).
>
> > @@ -3355,6 +3359,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
> >                 unsigned long pfn;
> >                 struct folio *folio;
> >                 pte_t ptent = ptep_get(pte + i);
> > +               bool is_pte_young;
> >
> >                 total++;
> >                 walk->mm_stats[MM_LEAF_TOTAL]++;
> > @@ -3363,16 +3368,20 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
> >                 if (pfn == -1)
> >                         continue;
> >
> > -               if (!pte_young(ptent)) {
> > -                       walk->mm_stats[MM_LEAF_OLD]++;
>
> Most overhead from page table scanning normally comes from
> get_pfn_folio() because it almost always causes a cache miss. This is
> like a pointer dereference, whereas scanning PTEs is like streaming an
> array (bad vs good cache performance).
>
> pte_young() is here to avoid an unnecessary cache miss from
> get_pfn_folio(). Also see the first comment in get_pfn_folio(). It
> should be easy to verify the regression -- FlameGraph from the
> memcached benchmark in the original commit message should do it.
>
> Would a tracepoint here work for you?
>
>
>
> > +               is_pte_young = !!pte_young(ptent);
> > +               folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap, is_pte_young);
> > +               if (!folio) {
> > +                       if (!is_pte_young)
> > +                               walk->mm_stats[MM_LEAF_OLD]++;
> >                         continue;
> >                 }
> >
> > -               folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
> > -               if (!folio)
> > +               if (!folio_test_clear_young(folio) && !is_pte_young) {
> > +                       walk->mm_stats[MM_LEAF_OLD]++;
> >                         continue;
> > +               }
> >
> > -               if (!ptep_test_and_clear_young(args->vma, addr, pte + i))
> > +               if (is_pte_young && !ptep_test_and_clear_young(args->vma, addr, pte + i))
> >                         VM_WARN_ON_ONCE(true);
> >
> >                 young++;

Thanks for replying.

For avoiding below:
1. confict between page_idle/bitmap and mglru scan
2. performance downgrade in mglru page-table scan if call get_pfn_folio for each pte.

We have a new idea:
1. Include a new api under /sys/kernel/mm/page_idle, support mark idle flag only, without
rmap walking or clearing pte young.
2. Use mglru proactive scan to clear page idle flag.

workflows:
      t1                      t2 
mark pages idle    mglru scan and check pages idle

It's easy for us to know that whether a page is accessed during t1~t2.

Some code changes like these:

We clear idle flags in get_pfn_folio, and in walk_pte_range we still follow
original design.

static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
					struct pglist_data *pgdat, bool can_swap, bool clear_idle)
{
	struct folio *folio;

	/* try to avoid unnecessary memory loads */
	if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
		return NULL;

	folio = pfn_folio(pfn);
+
+	if (clear_idle && folio_test_idle(folio))
+		folio_clear_idle(folio);
+
	if (folio_nid(folio) != pgdat->node_id)
		return NULL;

	if (folio_memcg_rcu(folio) != memcg)
		return NULL;

	/* file VMAs can contain anon pages from COW */
	if (!folio_is_file_lru(folio) && !can_swap)
		return NULL;

	return folio;
}

static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
			struct mm_walk *args)
{
...
	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
		unsigned long pfn;
		struct folio *folio;
		pte_t ptent = ptep_get(pte + i);

		total++;
		walk->mm_stats[MM_LEAF_TOTAL]++;

		pfn = get_pte_pfn(ptent, args->vma, addr);
		if (pfn == -1)
			continue;

		if (!pte_young(ptent)) {
			walk->mm_stats[MM_LEAF_OLD]++;
			continue;
		}

+		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap, true);
-		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
		if (!folio)
			continue;
...
}

Is it a good idea or not ?

-- 
2.43.0


