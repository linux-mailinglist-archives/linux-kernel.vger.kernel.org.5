Return-Path: <linux-kernel+bounces-116353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 658F78896F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06134B3733A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8A618AC44;
	Mon, 25 Mar 2024 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3nF+HIv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13E42A96
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324897; cv=none; b=i8Ve/07Lvrsl0cgX1j25uLgUOwUqJd3ihnq9THOvoRKQxpav1U7NCE1VokF1ggzUAEXMFbQ8B0VksxZ6NhVGs3nwRaF5MjIspXfQkOObnrq0az5sKTvRYOST+mR4t24JPl/dexfmBDcZd019Dz/P+tUbmSbJdvV3lZP4BKrp8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324897; c=relaxed/simple;
	bh=NIE/CcYuw5x+AJSlzMUub7IIPjl12ZMADren4K9YdUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouv6ygPpg140Zq4fj3fTQeKOoYT2lzVaD+iaYVfy7O31QUqOzXrwC6CwiVhGII+WFFpyyjSveZh501/r88oXUgKbqmlEFinuLXDfrkSN4sh5DXNVN9sWDyRFmkeRFIqL4Z25OFrEteMkXeScIr9L4/A03g8Xpm60d3SHbrWaeQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3nF+HIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844E7C43390;
	Mon, 25 Mar 2024 00:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324896;
	bh=NIE/CcYuw5x+AJSlzMUub7IIPjl12ZMADren4K9YdUg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=I3nF+HIvaUKDyM3ViD8AVC60aXNFk9dbbn6L9VYmTBtfIisjMawpwBzEw8i/6k5Pg
	 uLGOi8LpgYDlCUG76tHaFcxWSfDGZ5bgmW4wr31luRd2gCmE5Ad9SqpGNVLI9JGo9x
	 OdKqFwtRcH2YpMVNeqhtrn7fXwLil2Kay/KDFU9I7POBbjjZviIRU0gzj78yjFHEF6
	 8X7jjQCMIoFKXL/K+xlbBAeI6tov6GKLs7cx/z1M1Z55fVIBOBbE9KxGU1+UHCN+nx
	 /8yH8OiIq7OJbJMBDAG/PS6d3fCndgYZF3UEOEqtV50Vbf+656AGKIfVOA02IgDvzF
	 K92vMMBCWL9pg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 26079CE11CE; Sun, 24 Mar 2024 17:01:36 -0700 (PDT)
Date: Sun, 24 Mar 2024 17:01:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: ying.huang@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	ryan.roberts@arm.com, chrisl@kernel.org
Subject: Re: Can you help us on memory barrier usage? (was Re: [PATCH v4 4/6]
 mm: swap: Allow storage of all mTHP orders)
Message-ID: <766cfb68-f82a-4163-9dc1-5f4483fa5a7a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
 <c56eae89-9559-4b1d-8249-d23281e466b4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56eae89-9559-4b1d-8249-d23281e466b4@gmail.com>

On Sat, Mar 23, 2024 at 11:11:09AM +0900, Akira Yokosawa wrote:
> [Use Paul's reachable address in CC;
>  trimmed CC list, keeping only those who have responded so far.]
> 
> Hello Huang,
> Let me chime in.
> 
> On Fri, 22 Mar 2024 06:19:52 -0700, Huang, Ying wrote:
> > Hi, Paul,
> > 
> > Can you help us on WRITE_ONCE()/READ_ONCE()/barrier() usage as follows?
> > For some example kernel code as follows,
> > 
> > "
> > unsigned char x[16];
> > 
> > void writer(void)
> > {
> >         memset(x, 1, sizeof(x));
> >         /* To make memset() take effect ASAP */
> >         barrier();
> > }
> > 
> > unsigned char reader(int n)
> > {
> >         return READ_ONCE(x[n]);
> > }
> > "
> > 
> > where, writer() and reader() may be called on 2 CPUs without any lock.
> > It's acceptable for reader() to read the written value a little later.

What are your consistency requirements?  For but one example, if reader(3)
gives the new value, is it OK for a later call to reader(2) to give the
old value?

Until we know what your requirements are, it is hard to say whether the
above code meets those requirements.  In the meantime, I can imagine
requirements that it meets and others that it does not.

Also, Akira's points below are quite important.

							Thanx, Paul

> > Our questions are,
> > 
> > 1. because it's impossible for accessing "unsigned char" to cause
> > tearing.  So, WRITE_ONCE()/READ_ONCE()/barrier() isn't necessary for
> > correctness, right?
> > 
> > 2. we use barrier() and READ_ONCE() in writer() and reader(), because we
> > want to make writing take effect ASAP.  Is it a good practice?  Or it's
> > a micro-optimization that should be avoided?
> 
> Why don't you consult Documentation/memory-barriers.txt, especially
> the section titled "COMPILER BARRIER"?
> 
> TL;DR:
> 
> barrier(), WRITE_ONCE(), and READ_ONCE() are compiler barriers, not
> memory barriers.  They just restrict compiler optimizations and don't
> have any effect with regard to "make writing take effect ASAP".
> 
> If you have further questions, please don't hesitate to ask.
> 
> Regards,
> Akira (a LKMM Reveiwer).
> 
> > 
> > --
> > Best Regards,
> > Huang, Ying
> 

