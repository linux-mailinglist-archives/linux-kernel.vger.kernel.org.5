Return-Path: <linux-kernel+bounces-25588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1AC82D30C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE02E1C208F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACC117CF;
	Mon, 15 Jan 2024 02:08:37 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A24215BB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-cd-65a493978fc8
Date: Mon, 15 Jan 2024 11:08:18 +0900
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
Message-ID: <20240115020817.GA56966@system.software.com>
References: <20240111060757.13563-1-byungchul@sk.com>
 <20240111060757.13563-5-byungchul@sk.com>
 <ZaAMf5JX2D3N7Epi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaAMf5JX2D3N7Epi@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsXC9ZZnoe70yUtSDbZNkLGYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovrux4yWhzvPcBk
	sXnTVGaL3z+A6uZMsbI4OWsyi4OAx/fWPhaPBZtKPTav0PJYvOclk8emVZ1sHps+TWL3eHfu
	HLvHiRm/WTx2PrT0mHcy0OP9vqtsHlt/2Xl83iTn8W7+W7YAvigum5TUnMyy1CJ9uwSujKvd
	p9kL5nBWvO+by9LAuIK9i5GTQ0LARGLj5XvMMPaRxpmMIDaLgKrElI2zWEBsNgF1iRs3fgLV
	cHCICGhIvNli1MXIxcEs8JpJ4tn/fUwgNcICsRIfT28Eq+cVsJB40P6HHaRISKCbUaLj9U42
	iISgxMmZT8CKmAW0JG78e8kEMpRZQFpi+T8OkDAn0A2Pfn4Eu0FUQFniwLbjTCBzJATWsUuc
	ODmVCeJQSYmDK26wTGAUmIVk7CwkY2chjF3AyLyKUSgzryw3MTPHRC+jMi+zQi85P3cTIzAK
	l9X+id7B+OlC8CFGAQ5GJR7eH38XpwqxJpYVV+YeYpTgYFYS4T34fEGqEG9KYmVValF+fFFp
	TmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsb+Pc8mzRBueuW+n/Xu9T6Fx06L
	tn299JI/c1Od2Jsd/qsrdioZtE1/27KnuFciZMGT+F6Ov2cjEgWaBOZzeCxauGnFQseJkr9d
	T2q6c7y5zsZ/Lm1Niq274IcrmS8zcjymz//Hknjy4fty5q1v3tbp5xbcvjzZ10xtaqTq/fzf
	dx61u9xWfBShxFKckWioxVxUnAgAVlQlk74CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXC5WfdrDt98pJUg0MTeSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFtd3PWS0
	ON57gMli86apzBa/fwDVzZliZXFy1mQWB0GP7619LB4LNpV6bF6h5bF4z0smj02rOtk8Nn2a
	xO7x7tw5do8TM36zeOx8aOkx72Sgx/t9V9k8Fr/4wOSx9Zedx+dNch7v5r9lC+CP4rJJSc3J
	LEst0rdL4Mq42n2avWAOZ8X7vrksDYwr2LsYOTkkBEwkjjTOZASxWQRUJaZsnMUCYrMJqEvc
	uPGTuYuRg0NEQEPizRajLkYuDmaB10wSz/7vYwKpERaIlfh4eiNYPa+AhcSD9j/sIEVCAt2M
	Eh2vd7JBJAQlTs58AlbELKAlcePfSyaQocwC0hLL/3GAhDmBbnj08yPYDaICyhIHth1nmsDI
	OwtJ9ywk3bMQuhcwMq9iFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIjKlltX8m7mD8ctn9EKMA
	B6MSD++Pv4tThVgTy4orcw8xSnAwK4nwHny+IFWINyWxsiq1KD++qDQntfgQozQHi5I4r1d4
	aoKQQHpiSWp2ampBahFMlomDU6qBMXpxcaXPzysvg70EpXd4/lZf8jUzIH/p4csve4LeSirz
	vtMQSNRz7lrOsbKiY/LDQ8Ff2cxNmN2D5mg95/wuoHH/RH5M0dzwmSXnQ5e7LEhaOq3LItFx
	7q20Fw3Nl97mSHH9z3slz15+Ly05OuXCm2jxlITjnB/4Ft2Wt88+mt9hfF8o65a6EktxRqKh
	FnNRcSIA8ieXD6UCAAA=
X-CFilter-Loop: Reflected

On Thu, Jan 11, 2024 at 03:42:55PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 11, 2024 at 03:07:54PM +0900, Byungchul Park wrote:
> > +static void migrate_folios_move(struct list_head *src_folios,
> > +		struct list_head *dst_folios,
> > +		free_folio_t put_new_folio, unsigned long private,
> > +		enum migrate_mode mode, int reason,
> > +		struct list_head *ret_folios,
> > +		struct migrate_pages_stats *stats,
> > +		int *retry, int *thp_retry, int *nr_failed,
> > +		int *nr_retry_pages)
> > +{
> > +	struct folio *folio, *folio2, *dst, *dst2;
> > +	bool is_thp;
> > +	int nr_pages;
> > +	int rc;
> > +
> > +	dst = list_first_entry(dst_folios, struct folio, lru);
> > +	dst2 = list_next_entry(dst, lru);
> > +	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
> > +		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
> 
> You don't need to call folio_test_large() first.  folio_order() includes
> a call to test_large() so it can return 0.
> 
> > +		nr_pages = folio_nr_pages(folio);
> 
> ... or since you're calculating this anyway,
> 
> 		is_thp = nr_pages >= HPAGE_PMD_NR

Cool. Thanks.

	Byungchul

> perhaps

