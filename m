Return-Path: <linux-kernel+bounces-72311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358785B1DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD9B283235
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E656B81;
	Tue, 20 Feb 2024 04:10:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491342A88
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402207; cv=none; b=ZHgn9ZWLbKaicgu1Q99ATFUML8w+F3fBTyxCkb6fAjWzIQX9AFfEo9mXel1hdc0LXC4/CQlflCWW7mLPvotoUZGW2fRfyF68I52bdAMZ7be2HQGADpyfg6+5pT2ZWRZEFnS/Fl6eAtf1nLWpgEJRDAFV6Zdnvv3HrRhMRa3PBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402207; c=relaxed/simple;
	bh=CfhveA0iY0NhZM89I34YYfDGZgjwYYXWOT9zcfo1vks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ0GRD25sKGjc+UpLfPsOfZmSDlp6SRYNMhs8/Yg5x+sa87fvlAbLTh2EyLFSkIzIU8ZNxqwqK0Q2uJgfIbNhYhb13TlvAsCHRtugRqyMe97N78hM99ROGODRF6KcWRxHyIYIn1XO2aJHr0VI8eampcJ59kWyf1RDmgbckloxMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-e6-65d4261705ab
Date: Tue, 20 Feb 2024 13:09:54 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: Re: [PATCH v4] sched/numa, mm: do not try to migrate memory to
 memoryless nodes
Message-ID: <20240220040954.GJ65758@system.software.com>
References: <20240219041920.1183-1-byungchul@sk.com>
 <87o7ccrghz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240219174508.bc6256248a163c3ab9a58369@linux-foundation.org>
 <20240220023304.GF65758@system.software.com>
 <20240219192841.f1ed44b8c85073511227721c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219192841.f1ed44b8c85073511227721c@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsXC9ZZnoa642pVUg7urTSzmrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XlXXPYLO6t+c9qMfndM0aLSwcWMFkc7z3AZLGv4wGTRceRb8wW
	W49+Z7c4OWsyiwOfx5p5axg9WvbdYvdYsKnUY/MKLY/Fe14yeWz6NInd4861PWweJ2b8ZvF4
	v+8qm8fm09UenzfJBXBHcdmkpOZklqUW6dslcGV8/HOUvaCHv6Ll+GWmBsZ73F2MnBwSAiYS
	6zressPYXb2tYDaLgKrE2t9zWEFsNgF1iRs3fjKD2CICuhKrnu8Cs5kFrjNJXP9XCGILC0RJ
	zFjyhRHE5hWwkJhw8D/QHC4OIYGZTBIPlq2HSghKnJz5hAWiWUvixr+XTF2MHEC2tMTyfxwg
	YU4Bb4mew71gN4gKKEsc2HacCWSOhEA7u8TMt9vYIA6VlDi44gbLBEaBWUjGzkIydhbC2AWM
	zKsYhTLzynITM3NM9DIq8zIr9JLzczcxAiNrWe2f6B2Mny4EH2IU4GBU4uF9EHc5VYg1say4
	MvcQowQHs5IIr3vThVQh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotg
	skwcnFINjJN5GZ9drtmaWqM/5dsGqZ9a0+TnfLa4/D3jleZds96WJ7nP5jUFiYrvXvdww52v
	AcHdGqL57x9ULrrm5W46/Vz8zAkrN/f8kVQV0xZSrJdevFPlp8nxX2n7NpqppwX3b55invjX
	S7ZG0V5czPTm0gsKxb0M9/731wu8YWZidrxwNsNIYcchPiWW4oxEQy3mouJEAGKkjlCoAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsXC5WfdrCuudiXV4P1FTYs569ewWVx6fJXN
	YvrLRhaLpxO2Mlvc7Z/KYnF47klWi8u75rBZ3Fvzn9Vi8rtnjBaXDixgsjjee4DJYl/HAyaL
	jiPfmC22Hv3ObnFy1mQWB36PNfPWMHq07LvF7rFgU6nH5hVaHov3vGTy2PRpErvHnWt72DxO
	zPjN4vF+31U2j8UvPjB5bD5d7fF5k1wATxSXTUpqTmZZapG+XQJXxsc/R9kLevgrWo5fZmpg
	vMfdxcjJISFgItHV28oOYrMIqEqs/T2HFcRmE1CXuHHjJzOILSKgK7Hq+S4wm1ngOpPE9X+F
	ILawQJTEjCVfGEFsXgELiQkH/wPN4eIQEpjJJPFg2XqohKDEyZlPWCCatSRu/HvJ1MXIAWRL
	Syz/xwES5hTwlug53At2g6iAssSBbceZJjDyzkLSPQtJ9yyE7gWMzKsYRTLzynITM3NM9Yqz
	MyrzMiv0kvNzNzEC42RZ7Z+JOxi/XHY/xCjAwajEw/sg7nKqEGtiWXFl7iFGCQ5mJRFe96YL
	qUK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2M6SXKccfe
	6hTtemrhd9W/4thHk20r9JfeLly156f9p1Nt3XIfzjf9T9a5sn637fyJZmZJHbZz787jUXC8
	UWuy+/pW+1VHzaU1dVPm/dz68+fsIxfjObZ/PZDJunFd/vNDGe7nj1R23PzyUfkuQ9X12mnJ
	fK0lT4pN3TfPeurCa1b6KSya/0z4ciWW4oxEQy3mouJEAP79fmiPAgAA
X-CFilter-Loop: Reflected

On Mon, Feb 19, 2024 at 07:28:41PM -0800, Andrew Morton wrote:
> On Tue, 20 Feb 2024 11:33:04 +0900 Byungchul Park <byungchul@sk.com> wrote:
> 
> > > Yes, this changelog is missing rather a lot of important information.
> > > 
> > > I pulled together the below, please check.
> > 
> > To make it more clear, I need to explain it more. I posted the following
> > two patches while resolving the oops issue. However, two are going on
> > for different purposes.
> > 
> > 1) https://lkml.kernel.org/r/20240219041920.1183-1-byungchul@sk.com
> > 
> >    I started this patch as the fix for the oops. However, I found the
> >    root cause comes from using -1 as an array index. So let the root 
> >    cause fix go with another thread, 2). Nevertheless, 1) is still
> >    necessary as a *reasonable optimization* but not the real fix any
> >    more.
> 
> Well I altered this patch's changelog to tell readers that it is an
> optimization.  But one does wonder why it isn't simply a bugfix. 
> Attempting to migrate to a memoryless node is clearly as error. 

I agree with what Oscar Salvador said:

   "As this is not a bug fix but an optimization, as we will fail anyways
   in migrate_misplaced_folio() when migrate_balanced_pgdat() notices
   that we do not have any memory on that node."

   https://lore.kernel.org/lkml/ZdG1yO29WTyRiw8Q@localhost.localdomain/
   
So assuming all the related code works correctly, the migration will
safely fail even without this optimization patch.

	Byungchul

> Presumably the called code handles it somehow, but in what fashion and
> at what cost?
> 
> > 2) https://lkml.kernel.org/r/20240216111502.79759-1-byungchul@sk.com
> > 
> >    I found the root cause of the oops comes from using -1 as an array
> >    index. So moved all the oops message, Fixes: tag, and cc stable to
> >    here. Long story short, 2) is the *real fix* for the oops.
> > 

