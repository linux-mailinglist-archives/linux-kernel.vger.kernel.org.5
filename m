Return-Path: <linux-kernel+bounces-107867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0D8802BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4C31F23697
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B172224D0;
	Tue, 19 Mar 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wD95Toxi"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E2208D4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867130; cv=none; b=c4BIOn1vku8kVFxx0tjWUSDL0g/ZqPvFcDhYb6+FPntzmDFjZteTBsb3Mt87b8zxmyhKqZMV4mwy0mZD2SZxowj5X44d00g3gOLBJ4Hnb7OS/891JXjF784R2WxtuE9/2awv2aGzhvNNVt3TNywaTegKdlVvcygqL/WO1iprdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867130; c=relaxed/simple;
	bh=U32m0SI2gfRENrFvT0P56oJ6rRLJh2vh1fMh73Zm0gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVPCmd5ENChCxzE70I7Cl0NixffkJfxW8dllX4WgbEM44dtBZ+DSPTW9q/QnCl5n0Q4+mzrbme4wqzTrQsKMwPIFUHCwqjXwm53a9wxDPFVIV8+C0yM6ggVV3PPZvMU0WxSeLJtY0+9M3p32qZwVjtHlyYFmjX2oZpKu4F+3UXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wD95Toxi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KizDvAs4Yj6RxJgCz75yX4yH1t6QiF+D0on+mjFBcMY=; b=wD95Toxi1mDsNY0oD6zGhWEqfA
	yR53icSHH734mg06hn3pofuf2It8H0/ljVmyc8VHn+6XWTokNP+4yiQ1vx23/U0AOUX38+kkKPpkE
	SiLb8NYFoZjcUXns5b8dAdi1G7wdigyDJSemyHlICDV/Du92a4dY/4EGtt950HQgQI44WrK7QNXXS
	NSeIUljFahH2pYbnISnSPy1p6oXxSzy36iTTqGuBCL6hIMhEKORNWV3pzCwAmK6UzHz5Q1XVVeX5m
	if039kC4j5ZITVbAwjF4WIimhaTPx+qTuN+K7Gn8RPpLLpbuX/q5MopitPqIBnxYu61nbtfDlMMOu
	DcIl/XRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmch0-00000002LeJ-0ltl;
	Tue, 19 Mar 2024 16:52:02 +0000
Date: Tue, 19 Mar 2024 16:52:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] lib/xarray: introduce a new helper xas_get_order
Message-ID: <ZfnCsredzl7hcbI1@casper.infradead.org>
References: <20240319092733.4501-1-ryncsn@gmail.com>
 <20240319092733.4501-4-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319092733.4501-4-ryncsn@gmail.com>

On Tue, Mar 19, 2024 at 05:27:32PM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> It can be used after xas_load to check the order of loaded entries.
> Compared to xa_get_order, it saves an XA_STATE and avoid a rewalk.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Brilliant; yes.  I was just looking at this the other day and wondering
why I hadn't done this.

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> +EXPORT_SYMBOL(xas_get_order);

We don't have a module user yet, so I'd hold off on this.  It's an
unusual thing to want to do, and we may never have a modular user.
Also, xas functions are EXPORT_SYMBOL_GPL, not EXPORT_SYMBOL.

