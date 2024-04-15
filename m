Return-Path: <linux-kernel+bounces-145749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81998A5A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933EF284C10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCB156251;
	Mon, 15 Apr 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PJwG5pFc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23015623D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207983; cv=none; b=O/5YdjGW/QQDDh0leAuvSpfUm2nm9sOz5vYtRPfkB+1ls1uyU4vJBqi2iM8KeENgthXTuN5Z4ZbseCzT1BGPcZMP/gQZWiw342w0OdpaRFBzfPAadtoZyCajp6eGHxTd/fFkk0FgH4/K5PrD5y2ERChH7izY8FluDzI/2vnFH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207983; c=relaxed/simple;
	bh=dSGiT+xLSTcfM01u7Gve7gCnW5bf9/lDEjU/9A1y5w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ForSwByQL0VPJvuYhQM3CpjslSPpbu36DMo4NaNDwcX6Shx9EPZx/ENKg7ro49+fT0vyzzczxePYu0Yc/sc7mpmQ4xBAAOhWZ0dgWUsbEG6LNWeySc6KWxhZzNIxpg3jcwqQgZkseuC3RTepOMr9GR1y3/NtVs31vPehl1lCbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PJwG5pFc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MChLp9ws+slgrxOBUGCVsKZbu7NB1tpz2huFIgNyMUM=; b=PJwG5pFcev1RdMIj8qn6YK2j1U
	/X35JGgQp8HxsqhqFD9HoIdEnnIkypZpyZmXoJdWAWP/HFqGwg/n10lvoExA+pax2HMJO4WNxW8be
	gq/+xU3/ljtBvDcF5JKmNr9VimfwluKgVyBvqdVyDlnkT1WbkAgKky0UjJoVatMTpG5CRszweN9Jm
	Q4LpMJXidMN1e19z2I4zAWI5zor7mbeWFwuywTlnEj5q9Hv9D2E0MoUNZzRjM5lqTGOpnBsGStv5G
	GIpy4pq0CLYV6XkyOG0J0/nCLoc9wtpyz7GynB5/MJcwguZl6xDssMKJInwtYLJ4Fm50MTq1u2y9Q
	sjqbCS5w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwReY-0000000GJeR-0OS5;
	Mon, 15 Apr 2024 19:06:06 +0000
Date: Mon, 15 Apr 2024 20:06:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] lib/xarray: introduce a new helper xas_get_order
Message-ID: <Zh16ndI5aN8r4yOR@casper.infradead.org>
References: <20240415171857.19244-1-ryncsn@gmail.com>
 <20240415171857.19244-4-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415171857.19244-4-ryncsn@gmail.com>

On Tue, Apr 16, 2024 at 01:18:55AM +0800, Kairui Song wrote:
>  /**
> - * xa_get_order() - Get the order of an entry.
> - * @xa: XArray.
> - * @index: Index of the entry.
> + * xas_get_order() - Get the order of an loaded entry after xas_load.

I'd just leave that as "Get the order of an entry." as it doesn't have
to be after calling xas_load(), it could be from any other operation
that moves xas.  Also this is the short description!

>  		if (slot >= XA_CHUNK_SIZE)
>  			break;
> -		if (!xa_is_sibling(xas.xa_node->slots[slot]))
> +		if (!xa_is_sibling(xas->xa_node->slots[slot]))

Could you fold in this change I have locally?

-               if (!xa_is_sibling(xas->xa_node->slots[slot]))
+               if (!xa_is_sibling(xa_entry(xas.xa, xas.xa_node, slot)))

That fixes a sparse warning which existed before your modifications.


