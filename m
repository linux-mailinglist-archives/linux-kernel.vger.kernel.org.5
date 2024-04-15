Return-Path: <linux-kernel+bounces-145547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56C68A57B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FBB1F211C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FC43E48F;
	Mon, 15 Apr 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yt43Wfdr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D58063C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198420; cv=none; b=BNvenlO9PEaXtdfSegTLaXqbvO9I/SsNcdRRTu31CLC84x+HTX6PBj9S8gxncRGgNYtq7WTaHKHZxqqOcB4uCt4fw8ABVxDcs3d6qmv+rp9P29c9yVGKKBCddP6TETGXW71TmRhYGZUaX55kZTosuQrjUnZqEPBkLOvVPYzfNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198420; c=relaxed/simple;
	bh=FsGXC95MuRbTCP5YYvZkGQEOjfnV4rG+8AuKvodSm1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvdHLeCshUpG/vZwBV5XBhbN0pLoi+MGv5vSLQdLMDZziXwo3afL41GcQqN0XIKEgHH740UL9oBvgoK4VuepPSBOXNBG+LuwwkE2tu9hYDwyNB6xcv0+k+7XgDU9bYCHyVsa0y273GMxxK1XltveFBrUfg3VbIJINOTF8zycaA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yt43Wfdr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=aT/STpxKuekl2Fk6nZChHwEDDzTToAFhme+ALYu4XrI=; b=Yt43WfdrZ6/nZjiMfl6ZwLHc/Z
	DOAORuym87Iw+/zOBrF5v5QSO41Gm29B11h18EiZq6jGLDiK1MWIzTvOxGk6j0r+TxKLe/f6Dxgp/
	C2rXA8ENTXC1wOrzCMZiM1iozZSfbIht3rxz6OZf4YH+gjORzzx7DOwYaqPTbo0FQV7Qw8rLz4JE6
	G7UvVni4t3vWECTLNLqL93/7RHTMrPo/8DdfPfEwS0zYiuQ7uE2mdN5u2ez6kJIjXdk0W7DuwGYKB
	BunDjU0jjREVckAE0HseP4KB4I6H1sZLywiLbGjHWoW9wn5RWsoyvD2A/WKiF1UbGxP7L7yUh2jkH
	tbCq6unw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwPAV-0000000G3pm-29OT;
	Mon, 15 Apr 2024 16:26:55 +0000
Date: Mon, 15 Apr 2024 17:26:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <Zh1VT-6wKfeE0VJS@casper.infradead.org>
References: <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZhkrY5tkxgAsL1GF@x1n>
 <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org>
 <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
 <ZhlQ_4Ve0vYNbWbl@casper.infradead.org>
 <CAJuCfpH3sKvczqRix6Q6QX9L4FsHQbmnyFXetvY+TzVUk38soA@mail.gmail.com>
 <Zh1SMHdN9xK9N2U_@casper.infradead.org>
 <CAJuCfpFjhfEYzG2zBNnE0Spv1=DbamKTc46ie0U3r7QniOnqRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFjhfEYzG2zBNnE0Spv1=DbamKTc46ie0U3r7QniOnqRA@mail.gmail.com>

On Mon, Apr 15, 2024 at 09:19:06AM -0700, Suren Baghdasaryan wrote:
> On Mon, Apr 15, 2024 at 9:13 AM Matthew Wilcox <willy@infradead.org> wrote:
> > The tcp vma is not file backed, but I'm pretty sure that COW is not
> > something they want, so there's never an anon_vma.  It's for pages
> > that contain received TCP packets; ie it's mmaped TCP.
> 
> I was following
> tcp_zerocopy_receive()->tcp_zerocopy_vm_insert_batch()->vm_insert_pages()->insert_page_in_batch_locked()->validate_page_before_insert()
> which errors out for PageAnon(page). So, I assumed this path works on
> file-backed pages but I'm not familiar with this code at all.

It turns out there are pages which are neither file nor anon ;-)
I have a partial list here:

https://kernelnewbies.org/MatthewWilcox/Memdescs

but I don't even have TCP on that list.  I haven't looked into what they
need -- I don't think they need mapping, index, etc, but I need to
figure that out.

