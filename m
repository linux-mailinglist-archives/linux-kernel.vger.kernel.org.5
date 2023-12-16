Return-Path: <linux-kernel+bounces-2108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FAF8157FA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92E81C24A64
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CA12E5C;
	Sat, 16 Dec 2023 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mcxQLRcX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E412B68;
	Sat, 16 Dec 2023 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xTCeiRnVo2DjWRhzmP26oRimtFAuGMuZmVBxfVmUuk0=; b=mcxQLRcXOnAQa9bcf+QRpJaGbe
	yka5CwzwHnLt9n6aj9xIiTKol5KUsSWtBTM/kf2SWPCnU/QwgaIlUlVofWhLmxR4Xm38l2RvVMosO
	duLTjj4rjncA3lGDL8vVGYMqdnxwQ3VTg/EvxqgjVY09sgq0GJCM0a94Z1+7RopZnt+6pId1LHyk3
	bTCVIUH5/9F0C5sfgEQDkmJYKFcWUM7CC6UZiatqlgBWchLEDRElBQs1A4jF9GGZPCSPcbpCl7UTH
	w+uv1+6KpY1mnRy2h/ciT6E5mn+7k4RFlPJkU/rL8fHZ/rWFf7JbTU7b9w+EQf3rvPm+thcgrXJrh
	Sm9vR33g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rENvh-007aiS-1r; Sat, 16 Dec 2023 06:13:41 +0000
Date: Sat, 16 Dec 2023 06:13:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 46/50] preempt.h: Kill dependency on list.h
Message-ID: <ZX1AFVAWXMfbo+Ry@casper.infradead.org>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-3-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216033552.3553579-3-kent.overstreet@linux.dev>

On Fri, Dec 15, 2023 at 10:35:47PM -0500, Kent Overstreet wrote:
> -	INIT_HLIST_NODE(&notifier->link);
> +	/* INIT_HLIST_NODE() open coded, to avoid dependency on list.h */
> +	notifier->link.next = NULL;
> +	notifier->link.pprev = NULL;

Arguably INIT_HLIST_NODE() belongs in types.h -- we already have
RCUREF_INIT() and ATOMIC_INIT() in there.

