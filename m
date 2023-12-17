Return-Path: <linux-kernel+bounces-2669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590DA816034
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E3B1F21E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB1E44C94;
	Sun, 17 Dec 2023 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bGt3EkY2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2017F8
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IUv0ylGmTtF0hsJHYBG0CgaUWyi6w1dHRyjxXG/JmjU=; b=bGt3EkY21K7PCJ0qioJQMVTPdY
	XGRZyU8xH3uPW5B8rpGYx8XO8YR/LLta5HrF1XQH3iHQ/YAUTpXyS0c84DRzEdKeU13LmNe8+Z+3B
	AOVxG2ZmK4Vh2pE8ylEkro2kZPnLUg5YeSUBpjXrLhJnb8xLukHc3AfiRLUlzPMpM2CzMoTzi6FHp
	qBulM4qKk03kboznq/NKsyLTOPEp2RkBUxy5UxUmz+j99mrhAh8jW6P8BsM9GzDjrp/aZ0/Ya9VIt
	Goesq8G7es8xB2oMXIuNFw8CgtDtVgli8k9cgrsmpXvZYXlg/OSzlRPgdeRv4YdfXWDSTVLO/uCdt
	Ew3gYSGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEtFb-00Bqgq-7e; Sun, 17 Dec 2023 15:40:19 +0000
Date: Sun, 17 Dec 2023 15:40:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Jesse Barnes <jsbarnes@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Guru Anbalagane <gurua@google.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [GIT PULL] hotfixes for 6.7-rc6
Message-ID: <ZX8WY7s76KYr3jRE@casper.infradead.org>
References: <20231215071604.946a433bbc05a6409faf5a33@linux-foundation.org>
 <CAHk-=wjWJgWzOf9MCuiE0oDsF6cCCn7KKDc_xDN6Q3kWNEHKLQ@mail.gmail.com>
 <20231215122251.bad09400b337dfb1965f6976@linux-foundation.org>
 <CAOUHufbcB9Lxeez=NcUY4uzxyX6x71dy2N0SMgj=ALooq+MetQ@mail.gmail.com>
 <CAHk-=wgWwyvzcG9YiEAv2X7XivH-zqLLxeJ+A6EpMp+EA3o_iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgWwyvzcG9YiEAv2X7XivH-zqLLxeJ+A6EpMp+EA3o_iw@mail.gmail.com>

On Sat, Dec 16, 2023 at 04:16:45PM -0800, Linus Torvalds wrote:
> On Fri, 15 Dec 2023 at 20:57, Yu Zhao <yuzhao@google.com> wrote:
> >
> > There has been a short-term plan, i.e., moving some of folio->flags to
> > the lower bits of folio->lru so that we can drop the Kconfig
> > constraint. I have discussed this with Willy but never acted on it. My
> > priority has been to surface more of our ideas that can potentially
> > save users money on memory to the community. I'm CC'ing our team
> > leads. Please feel free to let us know your preference on the
> > priority.
> 
> This is definitely a "eventually" thing on my wishlist, so I was more
> just wanting to hear that there is a plan, and somebody working on
> it..

"eventually" we should get rid of LRUs altogether.  They're no good for
a modern CPU.

https://lore.kernel.org/linux-mm/ZTc7SHQ4RbPkD3eZ@casper.infradead.org/

I don't have much more in the way of thoughts on what this might look
like beyond that email.  I'm inclined towards something incredibly simple
like taking each 4MB chunk of memory in turn; freeing inactive pages
and marking active pages as inactive.

