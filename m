Return-Path: <linux-kernel+bounces-3012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 354BD816619
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB43B21ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2892A63D6;
	Mon, 18 Dec 2023 05:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VPQUMJca"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95263C9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D594C433C8;
	Mon, 18 Dec 2023 05:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702878417;
	bh=Aitsqp9o/OwmXfDwBOhtyQ3t1dhttz5cuHNKGQ3/Lq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VPQUMJcaXqkA6kWtQFYNOCoUb70Yg8hE3wmM4LgkM6VkCgKVGs4KvRQ9/KuRM5C/F
	 aGCCSNuKoRCcWD6LA60b3Bd/2fL7ectZLVtfa2QyXKAU+WHPvcddnLcOL1NzgSOGyW
	 EDCfAQwGDTpFV8QKiqsQr+Fb/u6LNLr4v3Bi0m+w=
Date: Sun, 17 Dec 2023 21:46:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Yu Zhao
 <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Jesse Barnes <jsbarnes@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Guru Anbalagane <gurua@google.com>, David Rientjes <rientjes@google.com>
Subject: Re: [GIT PULL] hotfixes for 6.7-rc6
Message-Id: <20231217214656.ee095a1df467b745ad1ca75e@linux-foundation.org>
In-Reply-To: <ZX8WY7s76KYr3jRE@casper.infradead.org>
References: <20231215071604.946a433bbc05a6409faf5a33@linux-foundation.org>
	<CAHk-=wjWJgWzOf9MCuiE0oDsF6cCCn7KKDc_xDN6Q3kWNEHKLQ@mail.gmail.com>
	<20231215122251.bad09400b337dfb1965f6976@linux-foundation.org>
	<CAOUHufbcB9Lxeez=NcUY4uzxyX6x71dy2N0SMgj=ALooq+MetQ@mail.gmail.com>
	<CAHk-=wgWwyvzcG9YiEAv2X7XivH-zqLLxeJ+A6EpMp+EA3o_iw@mail.gmail.com>
	<ZX8WY7s76KYr3jRE@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 15:40:19 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Dec 16, 2023 at 04:16:45PM -0800, Linus Torvalds wrote:
> > On Fri, 15 Dec 2023 at 20:57, Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > There has been a short-term plan, i.e., moving some of folio->flags to
> > > the lower bits of folio->lru so that we can drop the Kconfig
> > > constraint. I have discussed this with Willy but never acted on it. My
> > > priority has been to surface more of our ideas that can potentially
> > > save users money on memory to the community. I'm CC'ing our team
> > > leads. Please feel free to let us know your preference on the
> > > priority.
> > 
> > This is definitely a "eventually" thing on my wishlist, so I was more
> > just wanting to hear that there is a plan, and somebody working on
> > it..
> 
> "eventually" we should get rid of LRUs altogether.  They're no good for
> a modern CPU.
> 
> https://lore.kernel.org/linux-mm/ZTc7SHQ4RbPkD3eZ@casper.infradead.org/
> 

OK, but...

What of the cost of physical I/O?  If a computationally more expensive
scan results in less I/O (hopefully) then the balance is altered?


