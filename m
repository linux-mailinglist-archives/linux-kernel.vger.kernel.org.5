Return-Path: <linux-kernel+bounces-121285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429A088E4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F5929CE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8566413119A;
	Wed, 27 Mar 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cJsQBQlG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C412EBC8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542771; cv=none; b=TvOUuuwod81dD+xQtA/ObADKj/VCzYXIxXpY9JByrI/AUXb8bQj6zfJuSR1Ax/9Ds38vOX1Oi2wAU6oEruRWDz4yeULN+m/84ecI9v9KwjS8i7aRrR0ZFOBfyDG2USQsfO+MvYf7353cPrN9jR1r6nXc+gpfvUZxjFOqijau5lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542771; c=relaxed/simple;
	bh=a4o0A6ggKfF3YJK9T/cm1DSZSsKsJAOhYfrZh8H57PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9qhGj5uQc/7g1qWp/2ZEb69/xK50fkwJ6Bwph1YvY7TVHD0xBGGKfCwLqeLbhEWF77Th1fvav9UVWAjahmVHRUBkztPJyXPYCTc0E6lehAX78jmUdna209fLZjuuQuuYpS7zlggbTTgsjq0aWpjcfL9DefQOB1BU7cFfX9xy3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cJsQBQlG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l6GZOMZ+j81OaJ382d3JAd6zvAL+ZqNG19CFuQDVLPk=; b=cJsQBQlGZHSZtJpD0rZeloENVv
	4Hten8gDfDu3gEft+8N6tNJ5XuKV3Ex997I4AurtmJAKCZVUCm3oQa6QfB72EeJF1x5jme03dsQIW
	Df3Y0lBQLaHO2NC//OVnBby6yqo9jRXd00mNR62yqV8898L/1HvQpDXqMaPInBwmrz6XmoMM5OxmZ
	ac9wwPYAjc2bSJ14DmRRdk6ACRqUUsiM6G8VgUHbW3j80YWP72v8Vo9L/1lc4H+W3gJpjJNfKfmKj
	e4+dKXmLPCykxbfZE0f2Uy6nVrbGDz3c992MNYsnE/apqBjGf2aLBoisVAiwGvKraufV3fTI27ODb
	xptM7/hA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSSV-00000003qbf-1PIW;
	Wed, 27 Mar 2024 12:32:47 +0000
Date: Wed, 27 Mar 2024 12:32:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH] mm: fix unproperly folio_put by changing API in
 read_pages
Message-ID: <ZgQR77VVaiitIinS@casper.infradead.org>
References: <20240327055406.1339636-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327055406.1339636-1-zhaoyang.huang@unisoc.com>

On Wed, Mar 27, 2024 at 01:54:06PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> According to the comments of readahead_page[3], the refcnt which
> represents page cache dropped in [1] makes sense for two reasons, '1.
> The folio is going to do IO and is locked until IO done;2. The refcnt
> will be added back when found again from the page cache and then serve
> for PTE or vfs' while it doesn't make sense in [2] as the refcnt of
> page cache will be dropped in filemap_remove_folio.

NAK, per previous email.

