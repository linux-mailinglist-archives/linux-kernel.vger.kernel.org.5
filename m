Return-Path: <linux-kernel+bounces-122373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D16C88F5CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA67629A34D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6521DA53;
	Thu, 28 Mar 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rBPk926m"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53642E405
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711595918; cv=none; b=jX0eruN+jNivoaP1+Ia7qQwvCZIZGo3Y7uH+4mIBvAkr85gPcgSRwG2nEpXwPtIZEFxNKFQrUFt4u9H+tdQIAVeLj4mPdPu5geanTh9rePl6ypsHzZOLzNK6sUCuRX0O72WtC39CKvtHLXrCi6kDKREFNUi7Mq3rL0oWs4pROKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711595918; c=relaxed/simple;
	bh=5vFqVpmltv+FRFSlK6Bry9PygRX8oCEWOYykkGWoI1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD/ctGj0jpiUT1gpsQUymkBCzr2EzHN/8BGxRYKaWbQBrm21sgy2WQl8jsvskr3UeezFpcdiJ2uAwr/EewzkiP2LPP5lhwlcRUEIJRpPmjcF86wgZ/Fgbbs/B/BlhVLs/9aTZYTvcjnwF3XxRoQZ2Tlk83nLzRzoDNtZKDEZlJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rBPk926m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=667BZ75JN63p2WibLec/d2R/US6udjc5iPxuUlTOhFo=; b=rBPk926mRFY/QwL4bURPl80+6M
	fLu3StBjBVRVOWOT1NG3We3/FABD4QBgwrR7DHPnbZGCoJgTpFWYTmxp+ZjFR4t2RVnT6GrfNsyAu
	mGkCQJxickvizzyG2eRgE5NDTBHvgtI9GaBeluZgbdXBY/Q1QjFaAjI6HbLp3xY+wXi0KIdoMJ48j
	p/IRKSWNb/9wBKFoZiL0dw552yb2sf8+Ct7+ajSCevLC3sPLRBttVN2ocj8d9Lt3w8wZprj5Bs4qs
	FPlb4i9N7lHMWIFl0i2RICuNKiM35jyryq0QDlLWQT1rb42Zp8qMgnSS3YjMjgj+klAGA1SKiCUDh
	NBR4wcgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpgHb-00000005O6U-43VH;
	Thu, 28 Mar 2024 03:18:28 +0000
Date: Thu, 28 Mar 2024 03:18:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <ZgThg-pzQzRl3ckF@casper.infradead.org>
References: <ZfwpuRjAZV07_lc3@casper.infradead.org>
 <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
 <Zfz4_GJAHRInB8ul@casper.infradead.org>
 <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
 <ZgDt9mwN-Py5Y-xr@casper.infradead.org>
 <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
 <ZgK91II_eSYY6D2F@casper.infradead.org>
 <CAGWkznGLySzLE17+rCe=UoA26vx=iM375o2zkruKM9ssG05QzA@mail.gmail.com>
 <ZgQRtQ60mrvOUKXo@casper.infradead.org>
 <CAGWkznF3GfCs8odhR-Hue5H8MZ=eXb82V20ZoCCjeoSjAPQ9cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznF3GfCs8odhR-Hue5H8MZ=eXb82V20ZoCCjeoSjAPQ9cw@mail.gmail.com>

On Thu, Mar 28, 2024 at 09:27:31AM +0800, Zhaoyang Huang wrote:
> ok, I missed the refcnt from alloc_pages. However, I still think it is
> a bug to call readahead_folio in read_pages as the refcnt obtained by
> alloc_pages should be its final guard which is paired to the one which
> checked in shrink_folio_list->__remove_mapping->folio_ref_freeze(2)(this
> 2 represent alloc_pages & page cache). If we removed this one without

__remove_mapping()  requires that the caller holds the folio locked.
Since the readahead code unlocks the folio, __remove_mapping() cannot
be run because the caller of __remove_mapping() will wait for the folio
lock.

