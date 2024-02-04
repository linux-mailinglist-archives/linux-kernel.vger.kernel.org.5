Return-Path: <linux-kernel+bounces-51847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEB3848FF8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108361C21891
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4C624B52;
	Sun,  4 Feb 2024 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRuPTXHT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB9249E6
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707072396; cv=none; b=mWIG9NluhsGXVDMu41Nhe83bh5t5NphhiNYQJssx6kecTHrUACGAmy7VKyErzxE4xWp9deQNDl7xuQ1vM2R+EXifBHpseqrA2936vIiEFa+jc/RlZlvJRjVcW7xNHKzEa7ri3Z/YGMz8q1WxOSIEp6XcRgghP5J0XgWwdahO+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707072396; c=relaxed/simple;
	bh=48waK8TfpLHDDxFDxz6XIBRX/g5bIPT94fN2TREShKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGSMGDP1Y93ckNBwwrIJd+v43F72U/z/LwJCd6orOaz6ZeMFJypioVGbYiAyuzGiap37SnezazMkZOS+6lc8td6L3bC6ueIH2VTXGuTuMEPie3iCerZv2W3PEvYR50LJG7YrhEg7hwukx7kuvftZlfN5IAUR8HU69UN9F9kZLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MRuPTXHT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZrsQ1gAPq8HHoN6t4ZwPfn1Y/MogSDe4++j+eW6F0Ds=; b=MRuPTXHTij8SUOHq7zubl7+0kV
	LhuVxhkxJKFLVAvN4IHGYKpLlWxAXF+QtQ5Pth1/2Lmref4bZNU8RV0kiJjH9XsZy4T/vIevN8hf0
	Fvh5IFSlbxtHD0b6PkM2jiWSQkecQm8t/mTE5Z0ZBGRAwy19uf2zKSdtfl8yfjSuCY54CysSD4VV0
	linZIW/RtA/YflH8rXNp5+KLPtKAj1K+GbT81O4s8YrNJWAabSPcBtpWxUbo1XgLlIw6DgOsLWtor
	uKdUOlrRAmR6W2ngUaWrmcKxhl2WsIAC/FNZmah31H1zWYXaA38gUmeMRj2K43wY4Bh1xpoNFl+rq
	eOcYk9UA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWhVc-00000007JSF-1nKO;
	Sun, 04 Feb 2024 18:46:28 +0000
Date: Sun, 4 Feb 2024 18:46:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/z3fold: remove unneeded spinlock
Message-ID: <Zb_bhO8Z_d7VUCdJ@casper.infradead.org>
References: <20240204125404.2112384-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204125404.2112384-1-hezhongkun.hzk@bytedance.com>

On Sun, Feb 04, 2024 at 08:54:04PM +0800, Zhongkun He wrote:
> There is no need to use spinlock in this section, so
> remove it.

I don't know this code at all, but the idiom is (relatively) common.
It waits until anybody _currently_ holding the lock has released it.

That would, eg, make it safe to free the 'pool' memory.

> -	spin_lock(&pool->lock);
> -	spin_unlock(&pool->lock);


