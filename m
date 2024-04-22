Return-Path: <linux-kernel+bounces-154017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E08AD626
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AB21F21BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0431BDC3;
	Mon, 22 Apr 2024 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="N+d/66ae"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58ADDC3;
	Mon, 22 Apr 2024 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819211; cv=none; b=F5f/mNi7DjRS18kx2GHQ2EFocgWU12SdAsEbSnuCuHGWSjI/aP5lpDlAXB/12P3zoM857Lio4gtVZAGJkNjGUVEMHO8F2GTBQ0wZnLLKIfnPcTpqetFvM4JnaAZabqrjJkHGfN5TReDN5oVVh0NCMBHA3Vzi3AaxBodqvkq748g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819211; c=relaxed/simple;
	bh=91uZ1D+g7BCvXY8LmzC1Kc3GezTGlSGp7H9DFv37wcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtzXTHEU1j1gjR2W425RvL/csXai8kLMMCYx/UHHcE5K6SRzYTkBkIF7hg43rie3Bi+b4j/kezRQG6+MNjGfIl9RdxJqnPYoTBIocSowHc6zCEPsE6TFrGkVuDWdLB1C81DBvjxGIvTmAm3WyPQqbP5nfhbdxP0wku43RHOYJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=N+d/66ae; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 3DDE82003A4;
	Mon, 22 Apr 2024 22:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SS0hZxf5Um6ckcjPrS2C6yFU/ft2AfTBLo5VA71mThw=; b=N+d/66aekExkDZY/KH+e/HXbLK
	xdKA1kCIwK78ELym0Pzz2xWS0Ip+yXOK47b876sqBklYWuRr71YHSlKdvetT2SGymNyRrTYiGsPF3
	0SV4OyU1cW9rm5Kes07NEW4qGRulOnNi1oEZ62YGjdlu0HYuccYfiHJSoclq4ChHjJyQ=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1rz0fA-005AgS-1q;
	Mon, 22 Apr 2024 22:53:20 +0200
Date: Mon, 22 Apr 2024 22:53:20 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <ZibOQI9kwzE98n12@bender.morinfr.org>
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>

On 22 Apr 20:59, David Hildenbrand wrote:
> > The benefit - to me - is very clear. People do use hugetlb mappings to
> > run code in production environments. The perf benefits are there for some
> > workloads. Intel has published a whitepaper about it etc.
> > Uprobes are a very good tool to do live tracing. If you can restart the
> > process and reproduce, you should be able to disable hugetlb remapping
> > but if you need to look at a live process, there are not many options.
> > Not being able to use uprobes is crippling.
> 
> Please add all that as motivation to the patch description or cover letter.
>
> > > Yes, libhugetlbfs exists. But why do we have to support uprobes with it?
> > > Nobody cared until now, why care now?
> > 
> > I think you could ask the same question for every new feature patch :)
> 
> I have to, because it usually indicates a lack of motivation in the
> cover-letter/patch description :P

My cover letter was indeed lacking. I will make sure to add this kind of
details next time.
 
> > Since the removal a few releases ago of the __morecore() hook in glibc,
> > the main feature of libhugetlbfs is ELF segments remapping. I think
> > there are definitely a lot of users that simply deal with this
> > unnecessary limitation.
> > 
> > I am certainly not shoving this patch through anyone's throat if there
> > is no interest. But we definitely find it a very useful feature ...
> 
> Let me try to see if we can get this done cleaner.
> 
> One ugly part (in general here) is the custom page replacement in the
> registration part.
> 
> We are guaranteed to have a MAP_PRIVATE mapping. Instead of replacing pages
> ourselves (which we likely shouldn't do ...) ... maybe we could use
> FAULT_FLAG_UNSHARE faults such that we will get an anonymous folio
> populated. (like KSM does nowadays)
> 
> Punching FOLL_PIN|FOLL_LONGTERM into GUP would achieve the same thing, but
> using FOLL_WRITE would not work on many file systems. So maybe we have to
> trigger an unsharing fault ourselves.
> 
> That would do the page replacement for us and we "should" be able to lookup
> an anonymous folio that we can then just modify, like ptrace would.
> 
> But then, there is also unregistration part, with weird conditional page
> replacement. Zapping the anon page if the content matches the content of the
> original page is one thing. But why are we placing an existing anonymous
> page by a new anonymous page when the content from the original page differs
> (but matches the one from the just copied page?)?
> 
> I'll have to further think about that one. It's all a bit nasty.

Sounds good to me. I am willing to help with the code when you have a
plan or testing as you see fit. Let me know.

> One thing to note is that hugetlb folios don't grow on trees. Likely, Many
> setups *don't* reserve extra hugetlb folios and you might just easily be
> running out of free hugetlb folios that you can use to break COW here
> (replace a file hugetlb by a fresh anon hugetlb page). Likely it's easy to
> make register or unregister fail.

Agreed.

-- 
Guillaume Morin <guillaume@morinfr.org>

