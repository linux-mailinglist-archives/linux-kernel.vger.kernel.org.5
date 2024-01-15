Return-Path: <linux-kernel+bounces-25750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9082D54B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A111F21B00
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6264BE6E;
	Mon, 15 Jan 2024 08:48:37 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105CE8839
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-f9-65a4f15eecc3
Date: Mon, 15 Jan 2024 17:48:25 +0900
From: Byungchul Park <byungchul@sk.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
	mgorman@techsingularity.net, hughd@google.com, david@redhat.com,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [v5 4/7] mm: Separate move/undo doing on folio list from
 migrate_pages_batch()
Message-ID: <20240115084825.GA18164@system.software.com>
References: <20240111060757.13563-1-byungchul@sk.com>
 <20240111060757.13563-5-byungchul@sk.com>
 <ZaAMf5JX2D3N7Epi@casper.infradead.org>
 <20240115020817.GA56966@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115020817.GA56966@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC9ZZnoW7cxyWpBuc75C3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
	bN40ldni9w+gujlTrCxOzprM4iDg8b21j8VjwaZSj80rtDwW73nJ5LFpVSebx6ZPk9g93p07
	x+5xYsZvFo+dDy095p0M9Hi/7yqbx9Zfdh6fN8l5vJv/li2AL4rLJiU1J7MstUjfLoEro3tW
	J3vBVZ6KjXMPMjUwvuHsYuTkkBAwkbh/pI21i5EDzP4yWxgkzCKgKrFhcRMbiM0moC5x48ZP
	ZpASEQENiTdbjLoYuTiYBV4zSTz7v48JpEZYIFbi4+mNLCA2r4CFxJxvFxlBioQEdjFK9PX9
	YINICEqcnPkErIhZQEvixr+XTCBDmQWkJZb/4wAJcwpYSnQteQhWLiqgLHFg23EmkDkSAuvY
	JU5MPsYOcbOkxMEVN1gmMArMQjJ2FpKxsxDGLmBkXsUolJlXlpuYmWOil1GZl1mhl5yfu4kR
	GIPLav9E72D8dCH4EKMAB6MSD++Pv4tThVgTy4orcw8xSnAwK4nwVt9ZkirEm5JYWZValB9f
	VJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBMfWRQt2dztX7tqqLcnPeOd45
	/dbaiCdrpwl+qvv6h1G8yVfpgpZrzb5Jt7kTuBqPO7G52fzLLDD61ppow8rZLiJWPq9rI4eT
	2NZrKhfeZN88N/mqsEXT5WTF55rRzOe3+As/WKt22rszY/2mGbO9ClZ+1r22VYYhMXey/IUp
	y+IvOVT+czu/V4mlOCPRUIu5qDgRAI+iZTu9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXC5WfdrBv3cUmqwd57vBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGSxedNUZovfP4Dq5kyxsjg5azKLg6DH99Y+Fo8Fm0o9Nq/Q8li85yWTx6ZVnWwemz5N
	Yvd4d+4cu8eJGb9ZPHY+tPSYdzLQ4/2+q2wei198YPLY+svO4/MmOY9389+yBfBHcdmkpOZk
	lqUW6dslcGV0z+pkL7jKU7Fx7kGmBsY3nF2MHBwSAiYSX2YLdzFycrAIqEpsWNzEBmKzCahL
	3LjxkxmkRERAQ+LNFqMuRi4OZoHXTBLP/u9jAqkRFoiV+Hh6IwuIzStgITHn20VGkCIhgV2M
	En19P9ggEoISJ2c+AStiFtCSuPHvJRPIUGYBaYnl/zhAwpwClhJdSx6ClYsKKEsc2HacaQIj
	7ywk3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMKKW1f6ZuIPxy2X3Q4wC
	HIxKPLw//i5OFWJNLCuuzD3EKMHBrCTCW31nSaoQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w
	1AQhgfTEktTs1NSC1CKYLBMHp1QD45S1TbO4Mv0y9tQWCbEVlm29Iul6QuHjCofPgqum2GT0
	hJY/TFz1slKw23Uj47+HZwpVosQqJA8lbNIt1bAp8gusWvHQzkXsb73t8gS+B6rP9R9UBUvv
	PTF1fXFceZ7XweylE6b5PnJ6uX1e9nID/fxNYaIbjv23z/T8mfY0vH5PhVFnqF61EktxRqKh
	FnNRcSIA72GZCKQCAAA=
X-CFilter-Loop: Reflected

On Mon, Jan 15, 2024 at 11:08:18AM +0900, Byungchul Park wrote:
> On Thu, Jan 11, 2024 at 03:42:55PM +0000, Matthew Wilcox wrote:
> > On Thu, Jan 11, 2024 at 03:07:54PM +0900, Byungchul Park wrote:
> > > +static void migrate_folios_move(struct list_head *src_folios,
> > > +		struct list_head *dst_folios,
> > > +		free_folio_t put_new_folio, unsigned long private,
> > > +		enum migrate_mode mode, int reason,
> > > +		struct list_head *ret_folios,
> > > +		struct migrate_pages_stats *stats,
> > > +		int *retry, int *thp_retry, int *nr_failed,
> > > +		int *nr_retry_pages)
> > > +{
> > > +	struct folio *folio, *folio2, *dst, *dst2;
> > > +	bool is_thp;
> > > +	int nr_pages;
> > > +	int rc;
> > > +
> > > +	dst = list_first_entry(dst_folios, struct folio, lru);
> > > +	dst2 = list_next_entry(dst, lru);
> > > +	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
> > > +		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);

JFYI, in the v4 patch set, I hadn't changed the original code that I
refactored. I just copied and pasted this part from the original code.

> > 
> > You don't need to call folio_test_large() first.  folio_order() includes
> > a call to test_large() so it can return 0.
> > 
> > > +		nr_pages = folio_nr_pages(folio);
> > 
> > ... or since you're calculating this anyway,
> > 
> > 		is_thp = nr_pages >= HPAGE_PMD_NR

I didn't apply what you suggested me here to the next version yet
because I was not sure if it'd make the code more readable.

Thanks anyway!

	Byungchul

> Cool. Thanks.
> 
> 	Byungchul
> 
> > perhaps

