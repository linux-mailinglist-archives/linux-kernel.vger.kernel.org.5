Return-Path: <linux-kernel+bounces-852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA4681470D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22730284D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090862C698;
	Fri, 15 Dec 2023 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kNt7ntwQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493F25562
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DyPN7fnVufP0g5P+tNuPOIOOtnX83p04L31XSSnfCj8=; b=kNt7ntwQaMDHCqN8vyVLyopkgo
	kTtE2jl+39kGJyHPuVTANTQDqUPgd6qIamTtmGJdqzkjPT5yuvhAldfG3fbZhPB8xuMZTpnjnO9wv
	MD2Y9o70WYJaS+n43Zh+8vg5PhocRXO4v8sbQBff+HScCuq/1LxIR2SooWTxR60f0rocntMKfbq/L
	8utT3ut3kJWGUw9IIqNfc9PTEaFjNjYFO2+xeKYfMytmCVwzjzR4yUrIULUzga+0PnhZ/SX+hNKxr
	3Dyyzt1dc/ysFhyL4Y4Ay1PUo+0aUOMeCsGaHwHOt1XbFKCFqFRiBhXZSIsz08EgekaJihkUrmC9m
	aKBpebrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE6T8-00GIxD-Gg; Fri, 15 Dec 2023 11:35:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 52C9F3005B2; Fri, 15 Dec 2023 12:35:03 +0100 (CET)
Date: Fri, 15 Dec 2023 12:35:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, lucas.demarchi@intel.com,
	pengfei.xu@intel.com
Subject: Re: [PATCH] perf: Fix perf_event_validate_size() lockdep splat
Message-ID: <20231215113503.GS28727@noisy.programming.kicks-ass.net>
References: <20231215112450.3972309-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215112450.3972309-1-mark.rutland@arm.com>

On Fri, Dec 15, 2023 at 11:24:50AM +0000, Mark Rutland wrote:
> When lockdep is enabled, the for_each_sibling_event(sibling, event)
> macro checks that event->ctx->mutex is held. When creating a new group
> leader event, we call perf_event_validate_size() on a partially
> initialized event where event->ctx is NULL, and so when
> for_each_sibling_event() attempts to check event->ctx->mutex, we get a
> splat, as reported by Lucas De Marchi:
> 
>   WARNING: CPU: 8 PID: 1471 at kernel/events/core.c:1950 __do_sys_perf_event_open+0xf37/0x1080
> 
> This only happens for a new event which is its own group_leader, and in
> this case there cannot be any sibling events. Thus it's safe to skip the
> check for siblings, which avoids having to make invasive and ugly
> changes to for_each_sibling_event().
> 
> Avoid the splat by bailing out early when the new event is its own
> group_leader.
> 
> Fixes: 382c27f4ed28f803 ("perf: Fix perf_event_validate_size()")
> Reported-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Closes: https://lore.kernel.org/lkml/20231214000620.3081018-1-lucas.demarchi@intel.com/
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Closes: https://lore.kernel.org/lkml/ZXpm6gQ%2Fd59jGsuW@xpf.sh.intel.com/
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Urgh, my bad indeed.

> ---
>  kernel/events/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Hi Ingo, Boris, Peter,
> 
> I'm not sure who's still around and who has disappeared for the
> holidays, but I'm hoping at least one of you is able to queue this. I've
> tested the patch on arm64 with Syzkaller (and syz-repro); before this
> patch it hits the splat near-instantly, and after this patch all seems
> well.

I'm still here today, let me stick this in perf/urgent.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c9d123e13b579..9efd0d7775e7c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1947,6 +1947,16 @@ static bool perf_event_validate_size(struct perf_event *event)
>  				   group_leader->nr_siblings + 1) > 16*1024)
>  		return false;
>  
> +	/*
> +	 * When creating a new group leader, group_leader->ctx is initialized
> +	 * after the size has been validated, but we cannot safely use
> +	 * for_each_sibling_event() until group_leader->ctx is set. A new group
> +	 * leader cannot have any siblings yet, so we can safely skip checking
> +	 * the non-existent siblings.
> +	 */
> +	if (event == group_leader)
> +		return true;
> +
>  	for_each_sibling_event(sibling, group_leader) {
>  		if (__perf_event_read_size(sibling->attr.read_format,
>  					   group_leader->nr_siblings + 1) > 16*1024)
> -- 
> 2.30.2
> 

