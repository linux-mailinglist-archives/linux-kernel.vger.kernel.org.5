Return-Path: <linux-kernel+bounces-76537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962785F88F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDCE1C22A27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E6312DD8F;
	Thu, 22 Feb 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="peNZF9aJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD9132484
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605948; cv=none; b=eKR0XaGdAfcmWFEb6lxpB7JwKniX6Qof+Oy0iG+KC6gmKfoKOyZwl5XXIG0DPRMbtTMUXpFPnAc8hWKYgeVA4ghvd9AGshiSzaBvkYQZ8q8i7BmEfel07tKUoNhutYxFGhtbS1fPPAJvgD4opO0wkou7PqiFqGoh2ZCnkw236+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605948; c=relaxed/simple;
	bh=0gPXjDFWHNXwYbdVEPc5GrDFkwcps5NAUS3jP41NSyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4gQ/vbvqODpUSGjVohYcUJk2k7F2oMXXRjiMh/H93WCSWp1DYOHLD+ZHilpmjxKQW+4VN46+OUkUjAcGeWiOoYkRwjZG/YcuUgVcwDb0HfRf0xJy88jDZvZa4e7qKZtPWwmW3dALNcLKQ0uQ7fQQAFbNn1M2kqr3LPrG3OJOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=peNZF9aJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KS1N/dgKH5bTXPPxUTP/t+hmXJGu8yDdfjErpHr1zXE=; b=peNZF9aJux7Kjp78nsSQnASQ10
	gdc+6FYgwZZyBSVWgl9Hn2W1s6YF8RNQWjvFexp8nNaWp1Pv8RbJAbPlj75g1kop0XCu2RdN4EcIT
	tccUiddJptPzXkbtg/Y2gFOQoq6MkjmmvJApyIJze8EKOCxtd4fD4KAN8Hwy6mCh0Ej8nj7ly+jtE
	VdjlM8/fiG3T4ktF24EPJWu9rsGgo37veFHGhsgRw8pvc8ErstbaYOp1gOX9GHG33Zrhuemy9WILK
	dBz6XLdCAAD1u5yeutcsALbZAnupzAi7jX9lloicklabp7b2OXM9jRZSJPgPz+rfTKMohI7BFD+T9
	wg9SFMow==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd8SK-00000003aBc-0ZD1;
	Thu, 22 Feb 2024 12:45:40 +0000
Date: Thu, 22 Feb 2024 12:45:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hao Ge <gehao@kylinos.cn>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gehao618@163.com
Subject: Re: [PATCH] mm/page_alloc: Make check_new_page return bool
Message-ID: <ZddB9BcieSU2lmSo@casper.infradead.org>
References: <20240222091932.54799-1-gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222091932.54799-1-gehao@kylinos.cn>

On Thu, Feb 22, 2024 at 05:19:32PM +0800, Hao Ge wrote:
> Make check_new_page return bool like check_new_pages
> 
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

