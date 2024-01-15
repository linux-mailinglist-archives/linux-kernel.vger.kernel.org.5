Return-Path: <linux-kernel+bounces-25699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF5582D4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1182818FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9315232;
	Mon, 15 Jan 2024 07:55:50 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9773D8F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-db-65a4e4fd330c
Date: Mon, 15 Jan 2024 16:55:35 +0900
From: Byungchul Park <byungchul@sk.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
	mgorman@techsingularity.net, hughd@google.com, david@redhat.com,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [v4 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20240115075535.GA56305@system.software.com>
References: <20231109045908.54996-1-byungchul@sk.com>
 <20231109045908.54996-3-byungchul@sk.com>
 <ZUzuUf7JfhybYBgg@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUzuUf7JfhybYBgg@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsXC9ZZnke7fJ0tSDaauMLWYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovrux4yWhzvPcBk
	sXnTVGaL3z+A6uZMsbI4OWsyi4OAx/fWPhaPBZtKPTav0PJYvOclk8emVZ1sHps+TWL3eHfu
	HLvHiRm/WTx2PrT0mHcy0OP9vqtsHlt/2Xl83iTn8W7+W7YAvigum5TUnMyy1CJ9uwSujJeX
	z7IXPGKuaJtm18D4nqmLkYNDQsBEYtkcvy5GTjDzbOc6VhCbRUBVYvONE8wgNpuAusSNGz+Z
	QcpFBDQk3mwx6mLk4mAWeM0k8ez/PiaQGmGBaIlTH/axg9TwClhIvH1TD1IjJNDNKLG9/wvY
	TF4BQYmTM5+wgNjMAloSN/69BDuBWUBaYvk/DhCTE+iEJWeMQSpEBZQlDmw7zgQyRkJgHbvE
	1lW7WCHOlJQ4uOIGywRGgVlIps5CMnUWwtQFjMyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQKj
	b1ntn+gdjJ8uBB9iFOBgVOLh/fF3caoQa2JZcWXuIUYJDmYlEd7qO0tShXhTEiurUovy44tK
	c1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTBay9vN0tuw667d3ue2j7X+1HM/
	fX+4vjLHZSerevLBDDU78yMn3gW+29rbuazue95f9m/6Uoeim5/Prv9+WEI41Nktev/kKRO6
	nn5UMFUKe5f1lOtl0NQSs3yRYymbS6J5N9mc0tWpdFmX4aC2bd60QvnAjMOXLNR3cOZzyT1c
	efnWa9f1m34qsRRnJBpqMRcVJwIApDNyd7oCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42Lh8rNu1v37ZEmqQfdxDYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
	sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPxS8+MHls/WXn8XmTnMe7+W/ZAvijuGxSUnMy
	y1KL9O0SuDJeXj7LXvCIuaJtml0D43umLkZODgkBE4mznetYQWwWAVWJzTdOMIPYbALqEjdu
	/ASyOThEBDQk3mwx6mLk4mAWeM0k8ez/PrBeYYFoiVMf9rGD1PAKWEi8fVMPUiMk0M0osb3/
	C9hMXgFBiZMzn7CA2MwCWhI3/r1kAqlnFpCWWP6PA8TkBDphyRljkApRAWWJA9uOM01g5J2F
	pHkWkuZZCM0LGJlXMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBEbTsto/E3cwfrnsfohRgINR
	iYf3x9/FqUKsiWXFlbmHGCU4mJVEeKvvLEkV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpog
	JJCeWJKanZpakFoEk2Xi4JRqYLxi9Xz7/y2sHRsmb31WMOXTimct2Z+PLHG6nsAnXDzR1uRn
	6PSDd68ommtmMzllLF93uSKj1Ov5dxUOFuOL8tfL+5kXL1uw6dfNDoVYa3OWoxeV1zZWJ1wP
	nnx7gsHZCULfjvpVOZpEc77LuiV6ZWrwPd0f90yzvnj7GXTNrxJub30tab1jWZISS3FGoqEW
	c1FxIgCK249YogIAAA==
X-CFilter-Loop: Reflected

On Thu, Nov 09, 2023 at 02:36:01PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 09, 2023 at 01:59:07PM +0900, Byungchul Park wrote:
> > +++ b/include/linux/page-flags.h
> > @@ -136,6 +136,7 @@ enum pageflags {
> >  	PG_arch_2,
> >  	PG_arch_3,
> >  #endif
> > +	PG_migrc,		/* Page is under migrc's control */
> >  	__NR_PAGEFLAGS,
> 
> Yeah; no.  We're out of page flags.  And CXL is insufficiently

I won't use an additional page flag any more.

Thanks.
	Byungchul


