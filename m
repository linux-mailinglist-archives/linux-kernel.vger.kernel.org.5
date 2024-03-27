Return-Path: <linux-kernel+bounces-121403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881E88E78C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C257B1C2EF92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36A12F38D;
	Wed, 27 Mar 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5Kl822I"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92412EBD1;
	Wed, 27 Mar 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548616; cv=none; b=ZBs3h9Sm6/cMvTnNI2oOY8V8XKGcvz5q1wCRhEloYPzlkkzXUaWRUx2cdUlYil1UjPffDbXS7wnksga8D1czgkwP+xT0OfF4W27XWlrKG+0vXr1vf/P8l81MpSOCCuJmDQREiH674npoOjUORzK2k+9pVvpHAOMCNU/8XUvOuAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548616; c=relaxed/simple;
	bh=grYRpcm7mknCGj/hePXyJKWu2qoHoEJ5UPnuNUewlO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6z9bkf4OcLyz3U136H6uweQgV08Ch4pGsmZQ4rrRP5W1QxtB3vC3CuL3hicHXUFZrZ2OBUJFBSsXEHqOBS4gvpfP8uE549v68+Sr9tv6DWw7pg1xV4Pbj8/ZJy9HZ+KgYIaS+u5KLkTjLBlzMVe8ZHKEjCi9++MUAptdwYoV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5Kl822I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dETpzncT5Z+aB2mkIGV5m3/MWAMpuQdDFo4UMaJMJ6s=; b=g5Kl822IUxs+SNAzMS0m3I8mUY
	Ja/h37cwMfkNqEPieY2rWItzuCWwTuALtZbWKcA3Zwvrd3DsUfo3hpmYb/cmMwFiqYWSaFIWis0s6
	qfyxEzoBe525H01bto7QX07rw2zhuZMZC5MAG1AJ9C0GaU4IvRG2ktosbMFD4Rcmbc+fNP21ZQy3j
	SAoDDBKFcfC61/EhGqQ4woVQiXgp28SlZDyWpUN+bXyAXACaga601JYTPRSzxHrE4C+zjdIVvgj23
	kQcY7AHxPRJikls0FvLlaDYpdfHA9/Y04S7BdUQ4U+Q8PbFSvxjeeaS0tgcIYKTm/Nw04idZZy7Io
	0ptTXkBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpTyk-000000040jb-29BP;
	Wed, 27 Mar 2024 14:10:10 +0000
Date: Wed, 27 Mar 2024 14:10:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "bounds: support non-power-of-two CONFIG_NR_CPUS"
 failed to apply to 5.4-stable tree
Message-ID: <ZgQowqqGf-E7Cpcz@casper.infradead.org>
References: <20240327122125.2836828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327122125.2836828-1-sashal@kernel.org>

On Wed, Mar 27, 2024 at 08:21:25AM -0400, Sasha Levin wrote:
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Looks like you just need a little more fuzz on the patch.

diff --git a/kernel/bounds.c b/kernel/bounds.c
index 9795d75b09b2..a94e3769347e 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -19,7 +19,7 @@ int main(void)
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
 #ifdef CONFIG_SMP
-	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
+	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 	/* End of constants */

> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Tue, 10 Oct 2023 15:55:49 +0100
> Subject: [PATCH] bounds: support non-power-of-two CONFIG_NR_CPUS
> 
> ilog2() rounds down, so for example when PowerPC 85xx sets CONFIG_NR_CPUS
> to 24, we will only allocate 4 bits to store the number of CPUs instead of
> 5.  Use bits_per() instead, which rounds up.  Found by code inspection.
> The effect of this would probably be a misaccounting when doing NUMA
> balancing, so to a user, it would only be a performance penalty.  The
> effects may be more wide-spread; it's hard to tell.
> 
> Link: https://lkml.kernel.org/r/20231010145549.1244748-1-willy@infradead.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 90572890d202 ("mm: numa: Change page last {nid,pid} into {cpu,pid}")
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  kernel/bounds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bounds.c b/kernel/bounds.c
> index b529182e8b04f..c5a9fcd2d6228 100644
> --- a/kernel/bounds.c
> +++ b/kernel/bounds.c
> @@ -19,7 +19,7 @@ int main(void)
>  	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
>  	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
>  #ifdef CONFIG_SMP
> -	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
> +	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
>  #endif
>  	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
>  #ifdef CONFIG_LRU_GEN
> -- 
> 2.43.0
> 
> 
> 
> 

