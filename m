Return-Path: <linux-kernel+bounces-83994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0086A12B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C582D1F2351A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144A154441;
	Tue, 27 Feb 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tYZW7V8/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62214F988
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067079; cv=none; b=pMNgGBjE3aT3hBENZ3eZZWpcuox/EeKvVrxw38RoBGh4+7p5V8z8KpaF9iFusuJ2R29UJWkjwTSHLLBlibFYHLKFcq/VbXy2JJWQEEz2BLHIgtl1aqYdAfPoJqdFGOHS5CcUrf68iA2x3xb6ZtH6baMhlroT60M28J0Fd9/jPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067079; c=relaxed/simple;
	bh=Ce4kaCaB0Xmj+UrWJOre3mHw7WLbByKBtK0VhdyFGLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz4XiRqD2XPJ9J2v1zGFaGDWb+x6p4uMzg6scW6WrRa2FOslVOgA4qBU2JwSH5RP3z6DpUYuVDhiQAbyKi8khJPHWfTXnDTpfpdGFGUPzGovAIiRyYJpvxsKjpKZI1x9Z0B4kdd8JWfALHcmILtoy8TlzjYvn6VzNhRy/ekFb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tYZW7V8/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pehzdoB8wsh8SgroFElaiUc6/flpbKrMg0Us2dS9mCA=; b=tYZW7V8/4fYkqfd2EQxkkhF4Lb
	RJvdrjCOM33klyU0JVjGcHQkY6IjnYCI9vT5YaWogebG+C6j/zJZgfqdaeI1HWzuaz/4+INBxUceC
	Y/CeSxOVBFmcP1PaAKzJf0tpLcak8g6i8pTVuPdpnLybUXYoHrCgxMenfisPEwAm8YO9anKhLszmj
	8SC8K3jp+WO35Y8SjwLbBfIcyR/zvksdcBoroN7/ODQ74lnHWiMYuw4tAV3IM9PvDOrSTHGP0aHlp
	HOavkUf2Zw/n4niD2AbuRJV9eqsyVPejXCBzyJcHk7hrctDVyG71anr9Vcr5uRYX+dN5aSTczy2m/
	bIOXEFjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4Pw-00000003LmO-3QiL;
	Tue, 27 Feb 2024 20:51:12 +0000
Date: Tue, 27 Feb 2024 20:51:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, sidhartha.kumar@oracle.com
Subject: Re: [PATCH] mm/cma: convert cma_alloc() to return folio
Message-ID: <Zd5LQHoSAqC9HFv8@casper.infradead.org>
References: <20240227181338.59932-1-jianfeng.w.wang@oracle.com>
 <Zd4xR9sojA-4Mdwm@casper.infradead.org>
 <cf6c758a-42a9-4d4c-a1f7-71f4fc09e8a0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6c758a-42a9-4d4c-a1f7-71f4fc09e8a0@oracle.com>

On Tue, Feb 27, 2024 at 11:26:02AM -0800, Jianfeng Wang wrote:
> 
> 
> On 2/27/24 11:00 AM, Matthew Wilcox wrote:
> > On Tue, Feb 27, 2024 at 10:13:38AM -0800, Jianfeng Wang wrote:
> >> Change cma_alloc() to return struct folio. This further increases the
> >> usage of folios in mm/hugetlb.
> > 
> > I love the idea, but I don't think this works.  The memory returned
> > from cma_alloc() isn't set up to be a folio, is it?  That is, it
> > doesn't have compound_head initialised so that page_folio() on
> > consecutive pages will return the same pointer.
> 
> Thanks for review.
> cma_alloc() returns an array of order-0 pages. So, this commit makes
> cma_alloc() return an array of folios (each an order-0 page) rather
> than a compound page. Functions that use cma_alloc() do not expect
> a compound page as well.

No, this is not the way.

