Return-Path: <linux-kernel+bounces-802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2002814663
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B571F24890
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7725106;
	Fri, 15 Dec 2023 11:09:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out187-6.us.a.mail.aliyun.com (out187-6.us.a.mail.aliyun.com [47.90.187.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15A1C2BD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.Vl3NdoO_1702637605;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.Vl3NdoO_1702637605)
          by smtp.aliyun-inc.com;
          Fri, 15 Dec 2023 18:53:26 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: yuzhao@google.com
Cc:  <akpm@linux-foundation.org>,
  "Henry Huang" <henry.hj@antgroup.com>,
  "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
  "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
Date: Fri, 15 Dec 2023 18:53:18 +0800
Message-ID: <20231215105324.41241-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOUHufaBfziNTwypP=dxZXYZi4nniT6aYQZiZxzyQjSa3Zmaow@mail.gmail.com>
References: <CAOUHufaBfziNTwypP=dxZXYZi4nniT6aYQZiZxzyQjSa3Zmaow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Dec 15, 2023 at 14:46 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > Thanks for replying this RFC.
> >
> > > 1. page_idle/bitmap isn't a capable interface at all -- yes, Google
> > > proposed the idea [1], but we don't really use it anymore because of
> > > its poor scalability.
> >
> > In our environment, we use /sys/kernel/mm/page_idle/bitmap to check
> > pages whether were accessed during a peroid of time.
>
> Is it a production environment? If so, what's your
> 1. scan interval
> 2. memory size

> I'm trying to understand why scalability isn't a problem for you. On
> an average server, there are hundreds of millions of PFNs, so it'd be
> very expensive to use that ABI even for a time interval of minutes.

Thanks for replying.

Our scan interval is 10 minutes and total memory size is 512GB.
We perferred to reclaim pages which idle age > 1 hour at least.

> > We manage all pages
> > idle time in userspace. Then use a prediction algorithm to select pages
> > to reclaim. These pages would more likely be idled for a long time.

> "There is a system in place now that is based on a user-space process
> that reads a bitmap stored in sysfs, but it has a high CPU and memory
> overhead, so a new approach is being tried."
> https://lwn.net/Articles/787611/
>
> Could you elaborate how you solved this problem?

In out environment, we found that we take average 0.4 core and 300MB memory
to do scan, basic analyse and reclaim idle pages.

For reducing cpu & memroy usage, we do: 
1. We implement a ratelimiter to control rate of scan and reclaim.
2. All pages info & idle age were stored in local DB file. Our prediction
algorithm don't need all pages info in memory at the same time.

In out environment, about 1/3 memory was attemped to allocate as THP,
which may save some cpu usage of scan.

> > We only need kernel to tell use whether a page is accessed, a boolean
> > value in kernel is enough for our case.
>
> How do you define "accessed"? I.e., through page tables or file
> descriptors or both?

both

> > > 2. PG_idle/young, being a boolean value, has poor granularity. If
> > > anyone must use page_idle/bitmap for some specific reason, I'd
> > > recommend exporting generation numbers instead.
> >
> > Yes, at first time, we try using multi-gen LRU proactvie scan and
> > exporting generation&refs number to do the same thing.
> >
> > But there are serveral problems:
> >
> > 1. multi-gen LRU only care about self-memcg pages. In our environment,
> > it's likely to see that different memcg's process share pages.
>
> This is related to my question above: are those pages mapped into
> different memcgs or not?

There is a case:
There are two cgroup A, B (B is child cgroup of A)
Process in A create a file and use mmap to read/write this file.
Process in B mmap this file and usually read this file.

> > We still have no ideas how to solve this problem.
> >
> > 2. We set swappiness 0, and use proactive scan to select cold pages
> > & proactive reclaim to swap anon pages. But we can't control passive
> > scan(can_swap = false), which would make anon pages cold/hot inversion
> > in inc_min_seq.
>
> There is an option to prevent the inversion, IIUC, the force_scan
> option is what you are looking for.

It seems that doesn't work now.

static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
{
......
    for (type = ANON_AND_FILE - 1; type >= 0; type--) {
        if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
            continue;

        VM_WARN_ON_ONCE(!force_scan && (type == LRU_GEN_FILE || can_swap));

        if (inc_min_seq(lruvec, type, can_swap))
            continue;

        spin_unlock_irq(&lruvec->lru_lock);
        cond_resched();
        goto restart;
    }
.....
}

force_scan is not a parameter of inc_min_seq.
In our environment, swappiness is 0, so can_swap would be false.

static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
{
    int zone;
    int remaining = MAX_LRU_BATCH;
    struct lru_gen_folio *lrugen = &lruvec->lrugen;
    int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);

    if (type == LRU_GEN_ANON && !can_swap)
        goto done;
......
}

If can_swap is false, would pass anon lru list.

What's more, in passive scan, force_scan is also false.

static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool can_swap)
{
......
    /* skip this lruvec as it's low on cold folios */
    return try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false) ? -1 : 0;
}

Is it a good idea to include a global parameter no_inversion, and modify inc_min_seq
like this:

static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
{
    int zone;
    int remaining = MAX_LRU_BATCH;
    struct lru_gen_folio *lrugen = &lruvec->lrugen;
    int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);

-   if (type == LRU_GEN_ANON && !can_swap)
+   if (type == LRU_GEN_ANON && !can_swap && !no_inversion)
        goto done;
......
}

-- 
2.43.0


