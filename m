Return-Path: <linux-kernel+bounces-106153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D020887E9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B024282458
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A74839AF2;
	Mon, 18 Mar 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P2U7LpMS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A22383B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767697; cv=none; b=Wopu73Jd+gg4iMg93C03AK8SkOmD4JI3m9jG6XwxPnKS2BablzIhTMLeeYbKRKv50Rf5aQFzpfDrgg3dDe2OK+YYT9TFSfF8n6fxpUP31FeKnuWV5WfBY9d4fBPKWviJBi+FdbRco2CURvBip8DSLVcStk4bDZYcRXGAOloeBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767697; c=relaxed/simple;
	bh=V08A+r/k3FcDK3PGKBV3s/lZTsJYHJftoRDlA/cxT3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcDZHUrioM3F3YS4dYV9EedLwa+rWhhzaeznttEYzalmgu6UMyulb3U+Z5a1zH1xPJxcHqIGyFctVBMHVJTLf6XyXHqXjHOz268jOf9cYg0Xnk9VhSll0JWuGhPt7PF61tYYZ2aADFAHWwSGfFKOx6QSpJaibBXwfE9kptF6XSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P2U7LpMS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tIU7gy+q6bDXHOKZz5jX4dY0VNZ6vp/YGRkWwNWLmp0=; b=P2U7LpMSg3J6Va5A3TZMrXS4Kd
	cfBRQT54F0hkM2S5dFRne6/I9W6CQyQsfc5C21VH6eJ3YN0ushOQm4s4AvG/VVZjeh/bsi+olJhER
	BGFwyXnohdE+WDFGyH18PnOq0CXbQ0AFXwWe00NnxbUuaHTqyvqv+TjqqmoME9vqZ7nUd3pLvygFR
	9gOVBjJWVmRWa+wjfcjZNzvSKwplHbDWYMZaH1Ewmc/3xK7Shw8zpFtSRBSLgE0mo2TR+P86Qt9TD
	bhruqYn19SJvlQ/u1hAss0h25XeHm3NYOz+Xo3zYA7mW5/TQvXUmatDVHYnjhdp5zIc93t3Qdm3XG
	0jIRfHYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmCpA-0000000HDQ3-1MEa;
	Mon, 18 Mar 2024 13:14:44 +0000
Date: Mon, 18 Mar 2024 13:14:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: kasong@tencent.com, Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] mm/ksm: catch tail page abnormal in
 page_stable_node
Message-ID: <Zfg-RJU8z_HYArt5@casper.infradead.org>
References: <20240318121443.3991104-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318121443.3991104-1-alexs@kernel.org>

On Mon, Mar 18, 2024 at 08:14:30PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> commit 19138349ed59 ("mm/migrate: Add folio_migrate_flags()") change the
> meaning of func page_stable_node() to check the compound head for tail
> 'page' instead of tail page self.
> But seems both semantics are same at results, the func always return NULL
>  for tail page. So adding a bug monitor here in case of abnormal.

No.  I didn't object to you doing this to convince yourself, but there's
no way we should have this upstream.

If we did have large KSM folios (and I don't think we should!), you'd
crash the kernel instead of silently doing the right thing.

>  static inline struct ksm_stable_node *page_stable_node(struct page *page)
>  {
> -	return folio_stable_node(page_folio(page));
> +	struct ksm_stable_node *node;
> +
> +	node = folio_stable_node(page_folio(page));
> +	VM_BUG_ON_PAGE(PageTail(page) && node, page);
> +
> +	return node;
>  }


