Return-Path: <linux-kernel+bounces-123491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E61890969
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEE61F22E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F1F1384B6;
	Thu, 28 Mar 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="syslETbc"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C980617
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654811; cv=none; b=eNgeadTQPnQPQ65RpuStShWWJJCrQt72Ux0jc8KKYFyiIv+wU4GIYvM76GqGNaBMr6N21OABX78z9I+tv3gyZ6plwQF9duvsYoGcaXVyuXaspdfupKCsGYCMerfdeGelXwhr0pyUMsC3k6R8NRLjruiCYsePKHIRVRpoxMp6+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654811; c=relaxed/simple;
	bh=ZtjZFLPTiVQORRAF/RvtX0zAM7xjZumGM16VWdWmwYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLCYyTn5qpTZnznVydbQPJKbt9pfGYlapxxn+30GhSNpOZC0E45PdU7x1fRxxK+NfGQ0T4RB+r3st95/NcF92j08u5EplWe1BK6Mhwfd14q6ZSdRG/kHAMh6rEIBregj/v4E76VNBtfl2Bp5oYOwmQ8y34KcKnFZx9Q6PnexZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=syslETbc; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Mar 2024 15:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711654805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4N45qEzZ33lTnFLFuDGUaQID+Buaapoa/kxgDVnQPks=;
	b=syslETbcnuA4+bTAebP8fFAZFJWkAPqOUGHPC/c7H8OsQKPYKuszwdcPAPziypUvK7VRON
	FYz4SJudL+GgLZ2i6ep+wIfLO3fvs4ljgVuyJ9TDhKfjEErsFXReVX3yE0vUrczBvLYc6B
	CoGaZEpqCtASwzitAUPr+aUJWD0BhaY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org, 
	willy@infradead.org, jack@suse.cz, bfoster@redhat.com, dsterba@suse.com, 
	mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgXFrabAqunDctVp@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 28, 2024 at 09:31:57AM -1000, Tejun Heo wrote:
> Hello, Kent.
> 
> On Thu, Mar 28, 2024 at 03:24:35PM -0400, Kent Overstreet wrote:
> > fs/bcachefs/time_stats.c has some code that's going to be moving out to
> > lib/ at some point, after I switch it to MAD; if you could hook that up
> > as well to a few points we could see at a glance if there are stalls
> > happening in the writeback path.
> 
> Using BPF (whether through bcc or bpftrace) is likely a better approach for
> this sort of detailed instrumentation. Fixed debug information is useful and
> it's also a common occurrence that they don't quite reveal the full picture
> of what one's trying to understand and one needs to dig a bit deeper, wider,
> aggregate data in a different way, or whatever.
> 
> So, rather than adding more fixed infrastructure, I'd suggest adding places
> which can easily be instrumented using the existing tools (they are really
> great once you get used to them) whether that's tracepoints or just
> strategically placed noinline functions.

Collecting latency numbers at various key places is _enormously_ useful.
The hard part is deciding where it's useful to collect; that requires
intimate knowledge of the code. Once you're defining those collection
poitns statically, doing it with BPF is just another useless layer of
indirection.

The time stats stuff I wrote is _really_ cheap, and you really want this
stuff always on so that you've actually got the data you need when
you're bughunting.

