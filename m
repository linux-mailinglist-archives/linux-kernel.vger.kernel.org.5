Return-Path: <linux-kernel+bounces-131457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031DA898842
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF2AB2D8B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42776041;
	Thu,  4 Apr 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gmcVa4LM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21948266D4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234776; cv=none; b=hg1UcVDBxUspwg5QVHGJdpSa5vqvI6fBskyTI8JYD/RqiubtNB38GITcgZsp7gvYek95FjOVAJRnRi5gJhzBA3F4BYwq9+vOOXAAGzjKRG0GF0P74onBhMRez0EA7M8mogLXtxkkDF2EfAZUemMQwj7JuKB1slzkqfM7tKlgk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234776; c=relaxed/simple;
	bh=OykBJ3j9tsg0Me08qK0/ZsC1FrDJFQSCCcRe95z9Qc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxAXq/czsCgZGGsZfP4nDXEw8y3QrY70OF/9aLKQlr/G0zL3SLsElkRt4LNweRKkwscFUge5/qtlZmvTk6ar8xXOltgGhXFJ46eHmco8bG/faMv9FRHyIckrTWBuY31Kz5UaDcp2ln5GAU7Is6ZVoMZDaKnbRr/dlR3b3vmrzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gmcVa4LM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G5rrMNHSqPSBCGVZqRVmxcAnVGI/ioS1AvddD0G2MZw=; b=gmcVa4LMBNR18w++zQMkX0DzFg
	aSW4E1pe4FDk8iTfq9U37ujKqA/PqHx+d6bNB6C4JuFb91V97EuguVjqcJeU/CzAegL0T5dQd7xBR
	M4Az3K75m5SHeKM06yvdiPkycZ2d+eOqVQfbunGyGRwyJ36Nefzd+bWxuvNMWEkieoUms1PamuxkS
	Ha40l67uPbR9oxIkbv3WEIM7pghfpFPgDUi53wLrhbUiQ/Z6WeUqOXpG9QXFa884mx3CftYsvQ67l
	YCVwfiB55ol4biMKYrRrzpF1LPcvz7Wv65C45A9Oo2J8DmVbQI1uAmGt/s0thKdEK/21wbGPcFKVs
	bFZNK2dg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsMTs-000000083UM-20uf;
	Thu, 04 Apr 2024 12:46:12 +0000
Date: Thu, 4 Apr 2024 13:46:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patchlet] locking: fix trivial f70405afc99b RT build breakage
Message-ID: <Zg6hFEQPnP3KIwQ0@casper.infradead.org>
References: <68731eaeb522ced5319e3c1e45f03cdca5c8fd2a.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68731eaeb522ced5319e3c1e45f03cdca5c8fd2a.camel@gmx.de>

On Thu, Apr 04, 2024 at 07:02:41AM +0200, Mike Galbraith wrote:
> 
> Two trivial RT build issues arrived along with f70405afc99b: WARN_ON() being
> undefined as added to include/linux/rwbase_rt.h, and the wrong parameter (typo)
> being passed to rw_base_assert_held_write().
> 
> Fixes: f70405afc99b ("locking: Add rwsem_assert_held() and rwsem_assert_held_write()")
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Mike Galbraith <efault@gmx.de>

Is Sebastian's patch not merged yet?

https://lore.kernel.org/lkml/20240319182050.U4AzUF3I@linutronix.de/

>  include/linux/rwbase_rt.h |    1 +
>  include/linux/rwsem.h     |    2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/rwbase_rt.h
> +++ b/include/linux/rwbase_rt.h
> @@ -4,6 +4,7 @@
> 
>  #include <linux/rtmutex.h>
>  #include <linux/atomic.h>
> +#include <linux/bug.h>
> 
>  #define READER_BIAS		(1U << 31)
>  #define WRITER_BIAS		(1U << 30)
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -174,7 +174,7 @@ static inline void rwsem_assert_held_nol
> 
>  static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
>  {
> -	rw_base_assert_held_write(sem);
> +	rw_base_assert_held_write(&sem->rwbase);
>  }
> 
>  static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
> 

