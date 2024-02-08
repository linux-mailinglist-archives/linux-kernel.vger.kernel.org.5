Return-Path: <linux-kernel+bounces-58214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCC84E2E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C771F26A80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF478B6F;
	Thu,  8 Feb 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY7xJcdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C387B3EE;
	Thu,  8 Feb 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401549; cv=none; b=X3aOxmH4f1PwKpMc92+OhzXV2KkIlXPWqw5UIrN0IWEqXKQR5RxcNJ31YupvDjdjPceJfJumMfcLZeqrzg5vSwc6x2MuQO+MGrMB02LIBpfd0LrGuFbP+PZ7yIxU8RZ6Pd4ZtR+OUQBdQJ5h1FSRhgbP4YLWnIaoH8wnTksajD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401549; c=relaxed/simple;
	bh=FVNjVUKh9OyW/83Ue0bZwUjdq4qIapVVOgrhdt/rjmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2314Ol0acq6pw7audQ1Dgb31WTuZsow2TdORfVEOW1OQQoppiInCMJD0TaywMbQ2dodlZEVfgladFqYGVDNmuAmELwdBtLg+sFJDtfvy9ujMF9gWPUc4U9V6JUjKjhVuk/X9XW3hFUUNBqTucCuAzfL2Zx3hUN6gwdkJbmO55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY7xJcdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CEDC43601;
	Thu,  8 Feb 2024 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707401548;
	bh=FVNjVUKh9OyW/83Ue0bZwUjdq4qIapVVOgrhdt/rjmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oY7xJcdhY87obWJfJL9l0De+t6szN33dhakI7R4b8JejBll60yqBTRhz/FqHZjydq
	 D34SNk5SnrlGc/RAn9usjzjbS4E1wBUWfL9UicpwBj/c6VeNL95STnL7FUzese2F0L
	 KASwebfLvLZowxscx0R7VDy1v33DKmJEYKVijvD8Pkkmx99NrUfdWloqWhLDFv8va4
	 62lsGndGw0obTCbyFh/XStxYcd1CjcqrwlawFhk8HLpNNzlyRP3qhS8xWhSBp/rfqu
	 eIN+qoMcVdgxsVdx9qMp92f75Q8HwPDE8L+REmj4tj3U+XfqZQpK7zZBG0q7+TasjO
	 QJ+dDPfyh9vaA==
Date: Thu, 8 Feb 2024 14:12:23 +0000
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Pavel Machek <pavel@ucw.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: Fix kernel panic on interface
 rename trig notify
Message-ID: <20240208141223.GR689448@google.com>
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
 <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>
 <20240205085007.GA19855@google.com>
 <2cf84815-f9b6-4a0a-a3b4-d23628a89aa4@lunn.ch>
 <65c0e874.df0a0220.257a.43b1@mx.google.com>
 <20240205143359.GB53266@google.com>
 <65c0f2dc.050a0220.63083.8524@mx.google.com>
 <20240205150422.GC53266@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205150422.GC53266@google.com>

On Mon, 05 Feb 2024, Lee Jones wrote:

> On Mon, 05 Feb 2024, Christian Marangi wrote:
> 
> > On Mon, Feb 05, 2024 at 02:33:59PM +0000, Lee Jones wrote:
> > > On Mon, 05 Feb 2024, Christian Marangi wrote:
> > > 
> > > > On Mon, Feb 05, 2024 at 02:41:46PM +0100, Andrew Lunn wrote:
> > > > > > > This should have 'net' in the subject line, to indicate which tree its
> > > > > > > for.
> > > > > > 
> > > > > > No, it shouldn't.
> > > > > > 
> > > > > > Contributors aren't obliged to know anything about merging strategies.
> > > > > 
> > > > > With netdev, we tend to assume they do, or at least can contribute to
> > > > > the discussion. They often know about any dependencies etc which could
> > > > > influence the decision. When there are multiple subsystem maintainers
> > > > > involved, i tend to use To: to indicate the maintainer i think should
> > > > > merge the patch, and Cc: for the rest.
> > > > >
> > > > 
> > > > I'm always a bit confused when I have to send patch to mixed subsystem
> > > > (not the case but for net trigger it's almost that). Sorry for the
> > > > confusion/noise.
> > > 
> > > When you have a truly cross-subsystem patch, it's up to you.
> > > 
> > >  - Mention both e.g. leds/net:
> > >  - Mention neither e.g. <device>:
> > >  - Mention the one that is most relevant
> > > 
> > >  An example of the last option might be when the lion's share of the
> > >  changes occur in one subsystem and only header files are changed in the
> > >  other.
> > > 
> > > In an ideal world i.e. when there are no build-time/runtime deps between
> > > them, changes should be separated out into their own commits.
> > >
> > 
> > Thanks a lot for the explaination and the examples!
> > 
> > > > > > Why does this need to go in via net?
> > > > > 
> > > > > It does not, as far as i'm aware. Christian, do you know of any
> > > > > reason?
> > > > > 
> > > > 
> > > > This is strictly a fix, no dependency or anything like that. Maybe using
> > > > net as target would make this faster to merge (since net is for fix only
> > > > and this has to be backported) than using leds-next?
> > > 
> > > We have leds-fixes for that.
> > >
> > 
> > Oh! No idea, should I add a tag to the patch to target that branch
> > specifically?
> 
> You don't need to do anything special.
> 
> The Fixes: tag is enough to let us know that this is a fix.
> 
> If the commit mentioned in Fixes: was accepted as part of the last
> merge-window, it'll be sent to the -rcs in good time.  If it fixes a
> commit which was introduced in a previous cycle, it'll be submitted
> during the next merge-window.

Since this patch fixes an issue that was incorporated into v6.4, we
shall not be submitting this for the v6.8-rcs.  Instead it's heading for
the v6.9 merge-window and will be backported to v6.6.y accordingly.

-- 
Lee Jones [李琼斯]

