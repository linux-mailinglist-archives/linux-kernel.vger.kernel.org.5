Return-Path: <linux-kernel+bounces-68327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F38578C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032881F24D74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69F1BC57;
	Fri, 16 Feb 2024 09:23:20 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34D1BC3C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075399; cv=none; b=ZiEkwf0mPJJtFp1RJXqmC7G5QztWzL5W8UlSQIeMLnopH/Hw5gu02EUUiVAn2gFFEckTQVob53Lt4ZEqTf7BJ9blfYfvGYQ6mWpmQUfJ03zeFxR6IPPYEbI6CENCqoZqfuJtbKrtwmrraeGx1UrsX7pr6VjphGvlL5LWYaDaX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075399; c=relaxed/simple;
	bh=9SXdXn9AqvDzCkZcLX9Fytd5UYUM/pdMAgYv9JAmgtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZPsEkuz9qYiB0XPLTA1CV919Ghpl7/CSOwUgeMOdIZHoMCwLm7rrBdvRr8JsIWkXCrnu2cdngKb3ohJKBmItj92Bm68DKZLSVG9tMyaUnr+xerqZzOaS/FtwanmiAI/89X8lnLuInuTdteQEw8PhiplO+avAbbUDmpxfCkofi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-d5-65cf297e427b
Date: Fri, 16 Feb 2024 18:23:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH] sched/numa, mm: do not promote folios to nodes not set
 N_MEMORY
Message-ID: <20240216092305.GC75176@system.software.com>
References: <20240214035355.18335-1-byungchul@sk.com>
 <Zc0tFdGAzD9sCzZN@localhost.localdomain>
 <20240216070754.GB32626@system.software.com>
 <Zc8UPuzii_5gTsrJ@localhost.localdomain>
 <20240216091139.GA75176@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216091139.GA75176@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LhesuzSLdO83yqwYEjhhZz1q9hs7j0+Cqb
	xfSXjSwWTydsZba42z+VxeLyrjlsFvfW/Ge1mPzuGaPFpQMLmCzOTCuyON57gMliX8cDJouO
	I9+YLbYe/c7uwOexZt4aRo+WfbfYPRZsKvXYvELLY9OnSewed67tYfM4MeM3i8f7fVfZPDaf
	rvb4vEkugCuKyyYlNSezLLVI3y6BK2PL+odMBY95K2aunsLWwHifq4uRk0NCwERi6+8rjDD2
	2xUrWLoYOThYBFQl5k6rBwmzCahL3LjxkxnEFhFQk5j2qpG9i5GLg1ngFJPEhM8X2EHqhQXC
	JP6+UQCp4RWwkNjzuZ0JpEZI4CWjxLopK1ghEoISJ2c+YQGxmQW0JG78e8kE0sssIC2x/B8H
	SJhTwFLi5o7N7CC2qICyxIFtx8HmSAi0s0tMeXOXCeJOSYmDK26wTGAUmIVk7CwkY2chjF3A
	yLyKUSgzryw3MTPHRC+jMi+zQi85P3cTIzCWltX+id7B+OlC8CFGAQ5GJR7eA3/OpgqxJpYV
	V+YeYpTgYFYS4Z3UeyZViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQi
	mCwTB6dUA+OMh6uU5eXnng/boH1DMvp+qWbHsYacLjbX4sSfL+Zu/77ruERyeYNti2uZr9N6
	qUzVSTfmFqRNec59M6Jy7febRhMeTXhkFsMbf1jisIzqvJyiS/PfuvexHvxvVbP+/s8DlUIl
	Ubt3lE1ay/bijeXF/8dOMT8rUko6Mm1xtetMq+03DATWze5RYinOSDTUYi4qTgQAnxLzKKEC
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsXC5WfdrFuneT7VYFq3osWc9WvYLC49vspm
	Mf1lI4vF0wlbmS3u9k9lsTg89ySrxeVdc9gs7q35z2ox+d0zRotLBxYwWZyZVmRxvPcAk8W+
	jgdMFh1HvjFbbD36nd2B32PNvDWMHi37brF7LNhU6rF5hZbHpk+T2D3uXNvD5nFixm8Wj/f7
	rrJ5LH7xgclj8+lqj8+b5AK4o7hsUlJzMstSi/TtErgytqx/yFTwmLdi5uopbA2M97m6GDk5
	JARMJN6uWMHSxcjBwSKgKjF3Wj1ImE1AXeLGjZ/MILaIgJrEtFeN7F2MXBzMAqeYJCZ8vsAO
	Ui8sECbx940CSA2vgIXEns/tTCA1QgIvGSXWTVnBCpEQlDg58wkLiM0soCVx499LJpBeZgFp
	ieX/OEDCnAKWEjd3bGYHsUUFlCUObDvONIGRdxaS7llIumchdC9gZF7FKJKZV5abmJljqlec
	nVGZl1mhl5yfu4kRGBnLav9M3MH45bL7IUYBDkYlHt4Df86mCrEmlhVX5h5ilOBgVhLhndR7
	JlWINyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qBMfJTy5oV
	G8tlvre7zLDsi/FrEe54dJfb0Jp7zTbVKNa1QaYOq37WA2NJ5knj860ly1X0E3fOPtltGFDO
	zejhO3/+9DdW2pUXW15EHffVdlr26oOrb+ymj/du+igrrHtXVpNyQUq6mmllNmvVXiejiOIa
	l491R3dkBj3iXSDeukxXap/wxAwlluKMREMt5qLiRADnLik4iAIAAA==
X-CFilter-Loop: Reflected

On Fri, Feb 16, 2024 at 06:11:40PM +0900, Byungchul Park wrote:
> On Fri, Feb 16, 2024 at 08:52:30AM +0100, Oscar Salvador wrote:
> > On Fri, Feb 16, 2024 at 04:07:54PM +0900, Byungchul Park wrote:
> > > For normal numa nodes, node_data[] is initialized at alloc_node_data(),
> > > but it's not for memoryless node. However, the node *gets onlined* at
> > > init_cpu_to_node().
> > > 
> > > Let's look at back free_area_init(). free_area_init_node() will be called
> > > with node_data[] not set yet, because it's already *onlined*. So
> > > ->zone_pgdat cannot be initialized properly in the path you mentioned.
> > 
> > I am might be missing something., so bear with me.
> > 
> > free_area_init() gets called before init_cpu_to_node() does.
> > free_area_init_node() gets called on every possible node.
> > 
> > free_area_init_node then() does
> > 
> >  pg_data_t *pgdat = NODE_DATA(nid);,
> > 
> > and then we call free_area_init_core().
> > 
> > free_area_init_core() does
> > 
> >  free_area_init_core() does
> >   zone_init_internals()
> > 
> > which ends up doing zone->zone_pgdat = NODE_DATA(nid);
> > 
> > If node_data[] was not set at all, we would already blow up when doing
> > the first
> > 
> >   for_each_node()
> >     pgdat = NODE_DATA(nid);
> >     free_area_init_node(nid);
> > 
> > back in free_area_init().
> 
> It seems that I got it wrong about the reason. Let me check it again and
> share the reason.
> 
> Just in case, this patch is still definitely necessary tho.

Sorry for the confusing expression. Please don't misunderstand it. The
oops has been always observed in the configuration that I descriped. I
meant:

   Just in case, I need to say the fix is still necessary.

	Byungchul

