Return-Path: <linux-kernel+bounces-10034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBE981CEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3811C22C35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6222F858;
	Fri, 22 Dec 2023 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tdUfleNz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1412F849
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 19:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A18C433CC;
	Fri, 22 Dec 2023 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703274729;
	bh=9/goXFkgxBVSNEPhlQK8ZimkF0PGBTWUJgfmfSTrhhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tdUfleNzIZFzv+duf7Rv5BjnJJXD/ix8hHCOZDGsfcEXuMLvvm0JikroJIDhQUVOX
	 bQ8+602rys/dcJVv4TpBVPr839CfHwNJHse7M4d5XfrQb06T9EbE4pc9DqVr3Pbv7I
	 bNRx0DO6xGsj/pgzkzW3VXZdNFJ0X+FfuHBkK4tc=
Date: Fri, 22 Dec 2023 11:52:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Wei =?ISO-8859-1?Q?X?=
 =?UTF-8?Q?u=EF=BF=BC?= <weixugc@google.com>, Yu =?UTF-8?Q?Zhao=EF=BF=BC?=
 <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, Chun-Tse Shao
 <ctshao@google.com>, Suren =?UTF-8?Q?Baghdasaryan=EF=BF=BC?=
 <surenb@google.com>, Yosry =?UTF-8?Q?Ahmed=EF=BF=BC?=
 <yosryahmed@google.com>, Brain Geffon <bgeffon@google.com>, Minchan Kim
 <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, Mel Gorman
 <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, Nhat Pham
 <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song
 <kasong@tencent.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng
 Shi <shikemeng@huaweicloud.com>, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
Message-Id: <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org>
In-Reply-To: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 22:25:39 -0800 Chris Li <chrisl@kernel.org> wrote:

> We discovered that 1% swap page fault is 100us+ while 50% of
> the swap fault is under 20us.
> 
> Further investigation show that a large portion of the time
> spent in the free_swap_slots() function for the long tail case.
> 
> The percpu cache of swap slots is freed in a batch of 64 entries
> inside free_swap_slots(). These cache entries are accumulated
> from previous page faults, which may not be related to the current
> process.
> 
> Doing the batch free in the page fault handler causes longer
> tail latencies and penalizes the current process.
> 
> Move free_swap_slots() outside of the swapin page fault handler into an
> async work queue to avoid such long tail latencies.

This will require a larger amount of total work than the current
scheme.  So we're trading that off against better latency.

Why is this a good tradeoff?

