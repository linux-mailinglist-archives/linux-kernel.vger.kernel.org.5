Return-Path: <linux-kernel+bounces-69472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D7858A10
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02D01C20FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1D1487F4;
	Fri, 16 Feb 2024 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SRGQ6I5N"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2217BC4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125552; cv=none; b=PDRQR99/0LQJvkxnn+Ih1uCqtQEHUubBmWB74wsTaMojwhWOIMRck3RYWy60WFGdCZMIIckM0gev0DgoxuED+UcTNi/6GxL2MvunMTUHtno4F1jHbddzaDcgTiQBVgIv9U5oL2uqT8SeaQiHt3qEI+INkhrB6P2Fe+1v5uwXAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125552; c=relaxed/simple;
	bh=+0tVT7b1fxqTxgx0N4I95PE69+poGgPKlWQA0oDaDX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH0iIVhiqDuSy460Zta7aG0sv3Ov7cdTZmJ4cLV1XXimqR+FmJfyjCqZTjb3O5svmdI6oNvRzc0ASGdMf/Lww37yBgHEaMU3B/d8BXcwww+CXoxbwwsLRBQ2HHozuUD2fd7k8QPfVr7AF9tZUqwVG8OT8Bmr+igwOhtZ2ea38b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SRGQ6I5N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GHk08+9Qr2abvfFoZHWP0gAwqgSKn3bFiclZzT/m3D8=; b=SRGQ6I5N1G03NQ6vP4wxMnClZn
	THcmHjIQNAwBdcbLWQGtRr+3kCticVuyeY3k/kKPNGY1NKj4FUwb3Ly9NEWBKOYBdR7Bkg6Zbwpqg
	VxkTGowlfryva2I7GeU45K0oJAhFMv+MoEVs5k07IxrGijqOgelK6w1rhaI/5WlP7Xmpxt9p6Q/7a
	jVHV3Q7BpwI1FWnMNdNDLM56KDOaFEht0IQQAQTxKSeXdfwoCU/QOetet+MvssFKs2XgYYmBp0pg9
	4PKK2ubTgI9DmkbjfHTvkoVe09IKsCyDGpWnf/1NrpNBmAZBOQSB9PUymTs0WAJ8+2SEqBhBoYzes
	P0Do0m1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb7U1-00000005uni-0Zym;
	Fri, 16 Feb 2024 23:19:05 +0000
Date: Fri, 16 Feb 2024 23:19:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, apopple@nvidia.com
Subject: Re: [PATCH v2 4/6] mm/migrate_device: convert
 __migrate_device_pages() to folios
Message-ID: <Zc_taXK-X-NYPQli@casper.infradead.org>
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
 <20240216211320.222431-4-sidhartha.kumar@oracle.com>
 <Zc_Z1PT20tNlsiFf@casper.infradead.org>
 <71db0ad0-a385-8572-7bea-bb11f76a6345@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71db0ad0-a385-8572-7bea-bb11f76a6345@oracle.com>

On Fri, Feb 16, 2024 at 02:00:31PM -0800, Sidhartha Kumar wrote:
> On 2/16/24 1:55 PM, Matthew Wilcox wrote:
> > On Fri, Feb 16, 2024 at 01:13:18PM -0800, Sidhartha Kumar wrote:
> > > Use migrate_pfn_to_folio() so we can work with folios directly in
> > > __migrate_device_pages().
> > 
> > i don't understand why this would be correct if we have multipage
> > folios.
> > 
> 
> Alistair mentioned that he is working on order > 0 device page support so I
> was under the impression that currently device pages are only order 0.

That might well be true, but I'm *very* uncomfortable with doing a folio
conversion in core MM that won't work with large folios.  We need to
consider what will happen with large device folios.

(for filesystems, I am less bothered.  Individual filesystems control
whether they see large folios or not, and for lesser filesystems it may
never be worth converting them to support large folios)

