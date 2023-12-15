Return-Path: <linux-kernel+bounces-1624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8125815105
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165141C240C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343874653A;
	Fri, 15 Dec 2023 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rpaQJRYh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7D46529
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EFBC433C8;
	Fri, 15 Dec 2023 20:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702671772;
	bh=cipOGuUQQaz2VjydkBmiXdPDIAMXBwnAoGBeHEb+oOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rpaQJRYh5p31bYQ9J58SZQaA2ABNxrqstpK8V8v6SXl0lh1vcUvY6sbii/oq5x2FL
	 ZrQSfGaDSwBnA6UERZGNiDaSljn9EZvrG5GEZzdDuDVICrOiWpYIrXEHmux4VvXuer
	 Q9Rqvb39XeMZ6r952O+SmV2Efo5QQUNUrDqa45Y4=
Date: Fri, 15 Dec 2023 12:22:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yu Zhao
 <yuzhao@google.com>
Subject: Re: [GIT PULL] hotfixes for 6.7-rc6
Message-Id: <20231215122251.bad09400b337dfb1965f6976@linux-foundation.org>
In-Reply-To: <CAHk-=wjWJgWzOf9MCuiE0oDsF6cCCn7KKDc_xDN6Q3kWNEHKLQ@mail.gmail.com>
References: <20231215071604.946a433bbc05a6409faf5a33@linux-foundation.org>
	<CAHk-=wjWJgWzOf9MCuiE0oDsF6cCCn7KKDc_xDN6Q3kWNEHKLQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 12:11:42 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 15 Dec 2023 at 07:16, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Yu Zhao (4):
> >       mm/mglru: fix underprotected page cache
> >       mm/mglru: try to stop at high watermarks
> >       mm/mglru: respect min_ttl_ms with memcgs
> >       mm/mglru: reclaim offlined memcgs harder
> 
> Entirely unrelated to this pull request (which I already pulled and
> pushed out, as noted by pr-tracker-bot), since I looked at these it
> just reminded me about a question I've had for a while...
> 
> Do we have any long-term (or even short-term?) plans to just make
> mglru be the one and only model?

I hope so, but I haven't heard specific plans.

Things are still stabilizing, but it seems we're a fair way down that
exponential curve.

> Yes, right now it's not just a Kconfig choice, but a real technical
> issue too: it depends on having enough flags available, so we have
> that "cannot use it on 32-bit with sparsemem".
> 
> But I'm hoping there is a plan or a workaround for that?

Hopefully Yu can talk to that.

> Because I feel like we really don't want to keep this "two different
> models" situation around forever.
> 

Sure.  Some diehards are still using slab :(

