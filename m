Return-Path: <linux-kernel+bounces-75848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2285EFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F4283504
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ABB1755F;
	Thu, 22 Feb 2024 03:28:10 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A20101EC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572489; cv=none; b=DFiRE25lzsAusR45qj8WFVf2QSyyGYgr9GwjkV4ROOjndlvurHe46f3uvqNVIQ3HTCoAerbQxOjZupV2o+AgRxBNcVA6uddAClSPFB1OueVZawWbVj/kVfdwoVL9hI0onjxrdgSBVTajjZkR0hBkx8LWeInGqQi3x0RFPM58484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572489; c=relaxed/simple;
	bh=EFb+iPmzBjn4e4oMMmuJpJ2BjLmuvCUl4VH8ya1lqgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nArcPqSVO0VpS1we1iLqpAryjMxWoTVtssmIGIUh/bNZILPEFG8qd/9yRPTbTgLQduIRNjSt778sBaJDY5LK/zpds+f0ivOpGngXW9Yc5gLpSCwzHp/P0OmEBnH5ctL4vuOy3NP+4TftzrmuhybqamDgypI89khjp4mZOOQW6sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-9b-65d6bf41bf6c
Date: Thu, 22 Feb 2024 12:27:56 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH] mm, vmscan: Don't turn on cache_trim_mode at the highest
 scan priority
Message-ID: <20240222032756.GA71504@system.software.com>
References: <20240208061825.36640-1-byungchul@sk.com>
 <CAOUHufYUC-oWePfqbbmm15Ue9QLfPg1G2nhXn6iSX_A460O6Uw@mail.gmail.com>
 <20240216072434.GC32626@system.software.com>
 <CAOUHufbGQ_ZFLhVSPG78pbMtvcfZ5v-E3oRdfZDP2mtHtkrPVg@mail.gmail.com>
 <20240221143013.d130b310a1306dfed0f6603a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221143013.d130b310a1306dfed0f6603a@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXC9ZZnoa7j/mupBvvvy1nMWb+GzeLyrjls
	FvfW/Ge1eDfhC6sDi8eCTaUemz5NYvc4MeM3i8fnTXIBLFFcNimpOZllqUX6dglcGS/ur2Aq
	+CxQ0Xh1OXsDYw9vFyMnh4SAicTUNT9ZYezt946C2SwCqhI3Xz9nB7HZBNQlbtz4yQxiiwjo
	Sqx6vgvMZhbIkZj8u4epi5GDQ1ggVmLpx3CQMK+AhUT7jrdArVwcQgKbmST6ZvxlgUgISpyc
	+YQFoldd4s+8S8wgvcwC0hLL/3FAhOUlmrfOBhvPKeAtsez7HTBbVEBZ4sC240wgMyUEFrBJ
	XD54iAXiZkmJgytusExgFJyFZMUsJCtmIayYhWTFAkaWVYxCmXlluYmZOSZ6GZV5mRV6yfm5
	mxiBAb6s9k/0DsZPF4IPMQpwMCrx8D5gvJYqxJpYVlyZe4hRgoNZSYSXpfxKqhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbGOZGt8yyUT6bP4jVh2qQx
	+xX/ZrvfD5fdXpFyJG2P++ug+unSh35MXi30sJ9314TFh7tUfJ5/Nn2r1uC15v4/z9IFmS+a
	ua8yGO7cvzX2a0XUfwmJ7EuW/S4eF0ov3dyUsGTubH/3NSv5vtYoM/HNmPYxbeIcgecH1jTP
	9i3tZOiwnBnweua3rUosxRmJhlrMRcWJAEOqsklsAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsXC5WfdrOu4/1qqwcY9IhZz1q9hszg89ySr
	xeVdc9gs7q35z2rxbsIXVgdWjwWbSj02fZrE7nFixm8Wj8UvPjB5fN4kF8AaxWWTkpqTWZZa
	pG+XwJXx4v4KpoLPAhWNV5ezNzD28HYxcnJICJhIbL93lBXEZhFQlbj5+jk7iM0moC5x48ZP
	ZhBbREBXYtXzXWA2s0COxOTfPUxdjBwcwgKxEks/hoOEeQUsJNp3vAVq5eIQEtjMJNE34y8L
	REJQ4uTMJywQveoSf+ZdYgbpZRaQllj+jwMiLC/RvHU22HhOAW+JZd/vgNmiAsoSB7YdZ5rA
	yDcLyaRZSCbNQpg0C8mkBYwsqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQLDdVntn4k7GL9c
	dj/EKMDBqMTD+4DxWqoQa2JZcWXuIUYJDmYlEV6W8iupQrwpiZVVqUX58UWlOanFhxilOViU
	xHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYycySfm6XAu0u6JDZ/aenKVgMOpXwwmE5b+Ss6X
	3XnhSSTfJd6cijzN6YqCPzPnrVC9v8v9fQuTvZn2SectVn1iK/+d3dDoFdn7kS972d2pU732
	M/5bfWe+p/0T32Oh+oXL5A/a3JfcxPzy1byMd8a1r7cuX5oSm2ny70j5hfLdB163OM1i/nNa
	iaU4I9FQi7moOBEApnLRAlMCAAA=
X-CFilter-Loop: Reflected

On Wed, Feb 21, 2024 at 02:30:13PM -0800, Andrew Morton wrote:
> On Sat, 17 Feb 2024 00:11:25 -0500 Yu Zhao <yuzhao@google.com> wrote:
> 
> > On Fri, Feb 16, 2024 at 2:24 AM Byungchul Park <byungchul@sk.com> wrote:
> > >
> > > On Fri, Feb 16, 2024 at 12:55:17AM -0500, Yu Zhao wrote:
> > > > On Thu, Feb 8, 2024 at 1:18 AM Byungchul Park <byungchul@sk.com> wrote:
> > > > >
> > > > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > > > > pages. However, it should be more careful to turn on the mode because
> > > > > it's going to prevent anon pages from reclaimed even if there are huge
> > > > > ammount of anon pages that are very cold so should be reclaimed. Even
> > > > > worse, that can lead kswapd_failures to be MAX_RECLAIM_RETRIES and stop
> > > > > until direct reclaim eventually works to resume kswapd.
> > > >
> > > > Is a theory or something observed in the real world? If it's the
> > > > former, would this change risk breaking existing use cases? It's the
> > >
> > > I faced the latter case.
> > >
> > > > latter, where are the performance numbers to show what it looks like
> > > > before and after this patch?
> > 
> > Let me ask again: where are the performance numbers to show what it
> > looks like before and after this patch?
> > 
> > > Before:
> > >
> > > Whenever the system meets the condition to turn on cache_trim_mode but
> > > few cache pages to trim, kswapd fails without scanning anon pages that
> > > are plenty and cold for sure and it retries 8 times and looks *stopped
> > > for ever*.
> 
> Does "stopped for ever" mean that kswapd simply stops functioning?

Yes. kswapd stops its functioning. Even worse, after being stopped, any
request to wake up kswapd fails until ->kswapd_failures gets reset to 0
by direct reclaim or something.

It's more like a bug fix than a performance improvement.

> If so, that's a pretty serious issue.  Please fully describe all of
> this in the changelog.  Please also address Yu Zhao's review comments
> and send us a v2 patch?  Thanks.

I will post v2 with vmstat numbers between before and after.

	Byungchul

