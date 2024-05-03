Return-Path: <linux-kernel+bounces-167632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539B18BAC3A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0900A1F23DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406E153505;
	Fri,  3 May 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cDEZkJUk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B714F9F9;
	Fri,  3 May 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738841; cv=none; b=lGlKK378Y2O/0as1F7KPuU5cn55uDjrpvWHDOTmXCht35uoULwuJ+SX3+hrL7DrqoGQd88EsN0FuuAN0sng+tqNCl/QO5AJwEVAPwVuJqlJZ2JvDmPGrn/30yryhmxztyCSjhR9z4O6WaUFWApQImzOOY4Eex4K0mp6l/SZCaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738841; c=relaxed/simple;
	bh=GmWwVje1unjuK7lL1AHBqfUMZpJj6+qljR/mYjzyXxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni3DCrZcOZZt9RItw+N1Ya7ieoojltnilqC/znE+xwdp+u6V/72OOQ9wl402dlXUzm3/LiKwC2hOPRkA8VgaG3L+rjGZm1qcQ6CnrUutkMuPYQJ8JvThnBLc6VJBOfGrP+B7vjLnA6mGZutofKmmHkzI7/6T5LnfiwLCzBCdwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cDEZkJUk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wAR49S+Q3+midVFaG+tbPBcVJqTAyA2eqOKvGm8H1xM=; b=cDEZkJUk8dwwEAj7zZcr1bbwY9
	k04xJ16jARjmfoHOPbUuv818QfkNpE3lRyb9TOTtmdMEOi2vjaOnmcwcnZPdOzvop36NwuMixbLyu
	5AOEyyRGR7xlkXUmW3c8w+sUy1la78b6Kq4GC1iAmCiPhlsJQYb5U81xFgyEzuTasV2VIQdYCH8li
	iV87FwqmtRyVtEqN+rPTzIR3Tui0vQvnjuBgj2P3/sJJuYVv5f1MQnvA8A8W3vDqJQfeTYlo0GQhG
	ZgLNDDAmCQO8EM6KEkTo6cdSJukwdMH5ep8clhIR2dYBHjMtOt0/kQHu6+NyMQ/bY3Yx1AoTJx6Tq
	5KQoJtGA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2rtw-000000043Si-38lO;
	Fri, 03 May 2024 12:20:32 +0000
Date: Fri, 3 May 2024 13:20:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, llvm@lists.linux.dev, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] maple_tree: Fix build failure with W=1 and LLVM=1
Message-ID: <ZjTWkM9hTnoIhzqV@casper.infradead.org>
References: <20240503095027.747838-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503095027.747838-1-visitorckw@gmail.com>

On Fri, May 03, 2024 at 05:50:27PM +0800, Kuan-Wei Chiu wrote:
> When compiling library code using "make W=1 LLVM=1 lib/", clang
> generated the following compilation errors:
> 
> lib/maple_tree.c:351:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
> static inline void *mte_set_full(const struct maple_enode *node)

Uh, clang is wrong to flag these as an error.  They're just not used
yet.

