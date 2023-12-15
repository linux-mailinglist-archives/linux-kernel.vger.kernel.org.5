Return-Path: <linux-kernel+bounces-1565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A2815025
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C991F24F36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F541862;
	Fri, 15 Dec 2023 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GdIGWLIf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B174184B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3CEC433C7;
	Fri, 15 Dec 2023 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702668278;
	bh=7GKOWTHeLhcPaRSYOOjlnHul/VurODSjj9PrACw8s3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GdIGWLIf8/T2P1aKV3L5uWyvsBL9y5wks4C2WWMrZs8+Qs52kJ9DgBvWWYIVRbwun
	 Yz2kAwl3TyfoPfUAoCPBRxdbG2wzDtzltsQu+3t0QZZ3WqvCCMhWraxXqYYKyMmJeU
	 o25HuAFj94b9WK5u+mA/GnGE7oqry15PxpS4HZaU=
Date: Fri, 15 Dec 2023 11:24:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>, Yosry
 Ahmed <yosryahmed@google.com>, Liu Shixin <liushixin2@huawei.com>, Yu Zhao
 <yuzhao@google.com>, Sachin Sant <sachinp@linux.ibm.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mel Gorman
 <mgorman@techsingularity.net>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-Id: <20231215112437.d265299e270722d540e4a246@linux-foundation.org>
In-Reply-To: <878r5wqcmy.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <ZV3_6UH28KMt0ZDb@tiehlicka>
	<87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZWDPuR5Ssx07nBHb@tiehlicka>
	<87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZWRdG49vlGzSY_Uj@tiehlicka>
	<87r0ka64v9.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZWW95JPQ1B0cVPY-@tiehlicka>
	<ZWZtdQKSSnLC8kZ6@google.com>
	<CAJD7tkZA2DDk259QHLnkwVqCq=v_4gBKSUV0hos8G+B6n6=rAQ@mail.gmail.com>
	<ZWZ0fJP9wq65rXtM@google.com>
	<ZWcPuYzWYAvOODsH@tiehlicka>
	<20231213151341.9ae5fa2bdc266d794a7eed39@linux-foundation.org>
	<878r5wqcmy.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 13:05:09 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > tl;dr, what's the viewpoint on this patch now?
> >
> > I have a note here that we're hoping input from Johannes, Vlastimil and
> > Mel (please).
> 
> Michal has performance concerns.  So, I think that we need to stop
> scanning anon LRU if don't find enough page in swap cache at the tail of
> the inactive list.

OK, thanks, I'll make the v10 patch go away for now.

