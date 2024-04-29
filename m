Return-Path: <linux-kernel+bounces-162975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE8B8B62EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01EB1F22B89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8E12D1E8;
	Mon, 29 Apr 2024 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HZoS1UWZ"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EED128807
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420456; cv=none; b=fJtdtMO6TsYwzOoxwjbQVEwB/GzQSo2MzEIZ8xiJXOYWoWEqa+mnQS9FowHJnAs/K0MZvI/mKY/b5xm9gOG17QN7zdOoTRRG+OsQHzt309Rs6qORpxJ8jxzNXkTSwy/DN3hhuR4CaLVBAY6mUBt6TTcRANaHO8AAHUOuAibaq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420456; c=relaxed/simple;
	bh=PfeQWhR1Lzg+FveSwt5O3o0HEKsYd2v6agDjwMPG3jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL8gPleYDMWzzqyoRs/3f1PZ+UuiurDMca/XSKqjmtUCmSVXUo1scrHNw+g2P1Fi/Q/QUaBVQwaVutKQn/dbBGIexthMWzqijdOskzwbvRunrFLAv7noTUF/SVP/rP+Kc2XcAai02563mcfg0YvFPrTM1K4NaN5qCQgzN9w6hOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HZoS1UWZ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 12:54:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714420452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbbKQkKWKhZZZX+xv6puyDF4u7BZGj2cFK9rsyf5wYI=;
	b=HZoS1UWZ16WAYJWw5jqN5f0tj3Bp2UTjUvDrhBgpm8WA2NyNvcsC6CUceQjoD6eqtOUib2
	px50FFk9LO/OdwZSiVpK1voQPCkNgH65yrEGG0QcILm+NL7oOHzE6O3j2FyzYRIrnsFIlU
	q+xlKg16gWlBJHTrYOtC+jfO1qzoGA8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] memcg: pr_warn_once for unexpected events and
 stats
Message-ID: <5eh7nwj6tnl76bkwnksgbb63mjmvf3rzlaevepcxecl3xhmkc7@hbcmkhseaoky>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-6-shakeel.butt@linux.dev>
 <CAJD7tkZJBBOfhHXfweJu367ov0GnppLTiUMLdoq=TcWnqu2q5w@mail.gmail.com>
 <dsxeqlmrxyxfi2i7yzhdrukwiczh7sjcwfobaytdgkckjez36b@u6ooikkgyyf4>
 <20240427142234.GA1155473@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240427142234.GA1155473@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 27, 2024 at 10:22:34AM -0400, Johannes Weiner wrote:
> On Fri, Apr 26, 2024 at 06:18:13PM -0700, Shakeel Butt wrote:
> > On Fri, Apr 26, 2024 at 05:58:16PM -0700, Yosry Ahmed wrote:
> > > On Fri, Apr 26, 2024 at 5:38 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> > > 
> > > Can we make these more compact by using WARN_ON_ONCE() instead:
> > > 
> > > if (WARN_ON_ONCE(i < 0))
> > >          return 0;
> > > 
> > > I guess the advantage of using pr_warn_once() is that we get to print
> > > the exact stat index, but the stack trace from WARN_ON_ONCE() should
> > > make it obvious in most cases AFAICT.
> 
> if (WARN_ONCE(i < 0, "stat item %d not in memcg_node_stat_items\n", i))
> 	return 0;
> 
> should work?
> 
> > > No strong opinions either way.
> > 
> > One reason I used pr_warn_once() over WARN_ON_ONCE() is the syzbot
> > trigger. No need to trip the bot over this error condition.
> 
> The warn splat is definitely quite verbose. But I think that would
> only be annoying initially, in case a site was missed. Down the line,
> it seems helpful to have this stand out to somebody who is trying to
> add a new cgroup stat and forgets to update the right enums.

Sounds good to me. I will change it to WARN_ONCE().

